Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBB7EECA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjKQH3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:29:14 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D5196;
        Thu, 16 Nov 2023 23:29:10 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5CD722012D;
        Fri, 17 Nov 2023 15:29:05 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1700206145;
        bh=7sEQcgSTINlPYHwYMq1CMcVwbUsEYi/P5XQkuSsDRCo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=UNBw6HWul8s+67Ir3ekXoy2rLntGk1qPfoPfscIFFECmO4z1ujMe4+FykYoxi+JkT
         6C0Naxi2l2oKkysuem0u8TxEXx75V5JlzTo4Bvi2THAwZixBgidrb8yAw1c11UQN/A
         7msLVMGqUUvI2aIgRcPw20bZZl8wQShfDCXqq/Zx8yiRdzFHW4CJUtoyf22ocLprpw
         aVKUEsbY4z+/6XJDYGVE+FJrqXom7Hw/ccDurc5l/3Yt9pgifDgdI/FXmhl6FRb5e7
         KI9BMP44lSMOwK0PQEpksG+t/m0ch3aNn8pbEOPKH8pFWfJdcYVGqGzF+LC/4LN/Zj
         AMSX+AbxubzHg==
Message-ID: <bd01e1544e388eb71b8713e94ea2165d1a805b54.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp-i2c: increase the MCTP_I2C_TX_WORK_LEN to 500
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Jinliang Wang <jinliangw@google.com>,
        Matt Johnston <matt@codeconstruct.com.au>
Cc:     William Kennington <wak@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Nov 2023 15:29:05 +0800
In-Reply-To: <20231117070457.1970786-1-jinliangw@google.com>
References: <20231117070457.1970786-1-jinliangw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinliang,

> Tested:
> Before the fix, we will see below message in kernel log when
> concurrently sending namespace create commands to the 4 NVMe-MI
> devices on the same i2c bus:
> kernel: i2c i2c-6 mctpi2c6: BUG! Tx Ring full when queue awake!
>=20
> After the fix, the error message is gone.

Thanks for the report, but I don't think this is the correct fix: you
should not hit that error even if > TX_WORK_LEN packets need to be sent.
The net core should not be attempting to queue more skbs after
netif_stop_queue(), which we do in the conditional below the warning:

	spin_lock_irqsave(&midev->tx_queue.lock, flags);
	if (skb_queue_len(&midev->tx_queue) >=3D MCTP_I2C_TX_WORK_LEN) {
		netif_stop_queue(dev);
		spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
		netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
		return NETDEV_TX_BUSY;
	}

	__skb_queue_tail(&midev->tx_queue, skb);
	if (skb_queue_len(&midev->tx_queue) =3D=3D MCTP_I2C_TX_WORK_LEN)
		netif_stop_queue(dev);
	spin_unlock_irqrestore(&midev->tx_queue.lock, flags);

What looks like has happened here:

 1) we have TX_WORK_LEN-1 packets queued
 2) we release a flow, which queues the "marker" skb. the tx_queue now
    has TX_WORK_LEN items
 3) we queue another packet, ending up with TX_WORK_LEN+1 in the queue
 4) the =3D=3D TX_WORK_LEN test fails, so we dont do a netif_stop_queue()

A couple of potential fixes:

 * We do the check and conditional netif_stop_queue() in (2)
 * We change the check there to be `>=3D MCTP_I2C_TX_WORK_LEN`

Matt, any preferences?

Cheers,


Jeremy
