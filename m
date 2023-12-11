Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801E680DF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbjLKXD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbjLKXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:03:25 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E79A;
        Mon, 11 Dec 2023 15:03:29 -0800 (PST)
Received: from [192.168.68.112] (ppp118-210-187-191.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.191])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 75C2D20174;
        Tue, 12 Dec 2023 07:03:19 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1702335803;
        bh=BOVT2lTKGgH9egB5ByYC/KQvKf3dxJNOB5Sb9X1V3lg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Vnl11pNqVaknKLnoVhbGozubdZ3eJ4ffOiKTxDa26vO/mQUcqUYexWAARoXmKxdD/
         nhHAa1AmZYc/pabTKHy2uiaQ+rJrMt10YqOK77Y1Hizly5J2mOGPo7DQBV/RLaNf7C
         4sG2/Gnul41zLgwugtK1sdHce9K/dlOtqKrYTfbGtVuULSb1yuLNMHzT7TQbGz1UfY
         ANTYBE2CQGNT5eZT4MlMtV2Z+0zDGaK8/DNuP+RB3lrWfNZUum4oyV8T2qxoY68hp5
         r7dkn6iItEL74lMi5z3IXwI9ooQxqbwZZlJWXT1AUqQR4LDbMXbUmKO0KhSPSt/TXL
         aFcs377ED979Q==
Message-ID: <2eab42cde34723a195e7a0287db08b25f8388a3b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/2] i2c: aspeed: Acknowledge Tx done with and
 without ACK irq late
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Cosmo Chou <chou.cosmo@gmail.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Date:   Tue, 12 Dec 2023 09:33:17 +1030
In-Reply-To: <20231211102217.2436294-3-quan@os.amperecomputing.com>
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
         <20231211102217.2436294-3-quan@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-11 at 17:22 +0700, Quan Nguyen wrote:
> Commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in
> interrupt handler") acknowledges most interrupts early before the slave
> irq handler is executed, except for the "Receive Done Interrupt status"
> which is acknowledged late in the interrupt.
> However, it has been observed that the early acknowledgment of "Transmit
> Done Interrupt Status" (with ACK or NACK) often causes the interrupt to
> be raised in READ REQUEST state, that shows the
> "Unexpected ACK on read request." complaint messages.
>=20
> Assuming that the "Transmit Done" interrupt should only be acknowledged
> once it is truly processed, this commit fixes that issue by acknowledging
> interrupts for both ACK and NACK cases late in the interrupt handler.
>=20
> Fixes: 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in i=
nterrupt handler")
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks Quan!
