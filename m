Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542DD7EF4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjKQOue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjKQOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:50:28 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25447D50;
        Fri, 17 Nov 2023 06:50:25 -0800 (PST)
Received: from [192.168.12.102] (unknown [159.196.94.230])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A85A620172;
        Fri, 17 Nov 2023 22:50:21 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1700232623;
        bh=jMHZVSWO3q4VSAcpesYRAiXH3F2thoDimQFa8ds3lA4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=d/vZiQHjf0lShuZqhvkwc1kq5RUWAjRHFOXSPOKUn2XqmfrfnP/3KVCinyDeXcG5P
         P49RU+bfVRb0srvvJU4LItI26MnG+DlisnSygpCGkbb2Bu3fUGP6ZmwUwUqIRD/iIe
         E8mLciueK8OZwm/rAUK2JvCQIPvNCAaxuNEKI6Ut1YnjMu8fNoHRwt/5mDerE8BUTV
         OpOGO/hYTwlf5g0JcHXVBO+Cln3V0ZJQDekNG7IrVttVdn5Yo0zXYfYXJUQdupjLwh
         z17tjTtJ9sJEurspRo55NOPrWppCaoJ9JxERjlWdPe9e6DktA4tJk8FWNTzcaV1hjY
         VcqQogJiFsJJg==
Message-ID: <39c213c17712fdc8877b4277b430bfded71c3cca.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp-i2c: increase the MCTP_I2C_TX_WORK_LEN to 500
From:   Matt Johnston <matt@codeconstruct.com.au>
To:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Jinliang Wang <jinliangw@google.com>
Cc:     William Kennington <wak@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Nov 2023 08:50:18 -0600
In-Reply-To: <bd01e1544e388eb71b8713e94ea2165d1a805b54.camel@codeconstruct.com.au>
References: <20231117070457.1970786-1-jinliangw@google.com>
         <bd01e1544e388eb71b8713e94ea2165d1a805b54.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2023-11-17 at 15:29 +0800, Jeremy Kerr wrote:
> 	spin_lock_irqsave(&midev->tx_queue.lock, flags);
> 	if (skb_queue_len(&midev->tx_queue) >=3D MCTP_I2C_TX_WORK_LEN) {
> 		netif_stop_queue(dev);
> 		spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
> 		netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
> 		return NETDEV_TX_BUSY;
> 	}
>=20
> 	__skb_queue_tail(&midev->tx_queue, skb);
> 	if (skb_queue_len(&midev->tx_queue) =3D=3D MCTP_I2C_TX_WORK_LEN)  // nor=
mal stop
> 		netif_stop_queue(dev);
> 	spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
>=20
> What looks like has happened here:
>=20
>  1) we have TX_WORK_LEN-1 packets queued
>  2) we release a flow, which queues the "marker" skb. the tx_queue now
>     has TX_WORK_LEN items
>  3) we queue another packet, ending up with TX_WORK_LEN+1 in the queue
>  4) the =3D=3D TX_WORK_LEN test fails, so we dont do a netif_stop_queue()
>=20
> A couple of potential fixes:
>=20
>  * We do the check and conditional netif_stop_queue() in (2)
>  * We change the check there to be `>=3D MCTP_I2C_TX_WORK_LEN`

My inclination would be to change the second comparison (the normal stop
condition) to=C2=A0

    /* -1 to allow space for an additional unlock_marker skb */
    if (skb_queue_len(&midev->tx_queue) >=3D MCTP_I2C_TX_WORK_LEN-1)

Cheers,
Matt

