Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F16809AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573106AbjLHEAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLHEAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:00:15 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682AE170F;
        Thu,  7 Dec 2023 20:00:21 -0800 (PST)
Received: from [192.168.68.112] (ppp118-210-181-59.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.59])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A9E6D20016;
        Fri,  8 Dec 2023 12:00:18 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1702008019;
        bh=6g1gg4ODYQHLBaloxEIVH+B88/pEH5RLfLJX0MQ0iPk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=kuPvuuYQxgat5rpGJsEfXAPhzGJuzhJ2gy1NNdBDywTsALSlK+y5+LJJrfM67Cf/N
         pWYRPPWFtmBhxmcueYYwlJgeflZkijiXUyk57+6+ccSB9MpLhmEUFob3tvyTWOp2qY
         cfe1lzES+DvX3b8f3u0kq84I/X4t6z/R4g+IFy0GJoBGzEbe5ogR/jAVyzbz42UPsc
         XMdVxIGceJzbhow79nOdKbD1F87BbNHz+VSuPg/Ox/zfaSp9UgWK/cpYUj19stXq8Y
         sh5ezvwsWrbuJg8B9kHzOIiHqTwRMbqKMbx2WF3RZVNsDcjS3FAB6ZCIPMyvqARxGh
         HgJy677d6fiYA==
Message-ID: <dc36d61aedd2b2389eb366b27436f19d934fc93b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] i2c: aspeed: Acknowledge Tx done with and
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
Date:   Fri, 08 Dec 2023 14:30:18 +1030
In-Reply-To: <20231208033142.1673232-3-quan@os.amperecomputing.com>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
         <20231208033142.1673232-3-quan@os.amperecomputing.com>
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

On Fri, 2023-12-08 at 10:31 +0700, Quan Nguyen wrote:
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
> ---
> v3:
>   + Fix the unconditinal write when ack the irqs               [Andrew]
>   + Refactor the code to enhance code readability                [Quan]
>   + Fix grammar in commit message                                [Quan]
>=20
> v2:
>   + Split to separate series                                     [Joel]
>   + Added the Fixes line                                         [Joel]
>   + Fixed multiline comment                                      [Joel]
>   + Refactor irq clearing code                          [Joel, Guenter]
>   + Revised commit message                                       [Joel]
>   + Revised commit message                                       [Quan]
>   + About a note to remind why the readl() should immediately follow the
> writel() to fix the race condition when clearing irq status from commit
> c926c87b8e36 ("i2c: aspeed: Avoid i2c interrupt status clear race
> condition"), I think it looks straight forward in this patch and decided
> not to add that note.                                            [Joel]
>=20
> v1:
>   + First introduced in
> https://lore.kernel.org/all/20210519074934.20712-1-quan@os.amperecomputin=
g.com/
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-asp=
eed.c
> index 1c2a4f4c4e1b..967a26dd4ffa 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -617,13 +617,19 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_=
bus *bus, u32 irq_status)
>  static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  {
>  	struct aspeed_i2c_bus *bus =3D dev_id;
> -	u32 irq_received, irq_remaining, irq_handled;
> +	u32 irq_received, irq_remaining, irq_handled, irq_ack_last;

`irq_ack_last` might be better as a macro, but you're probably saved by
the optimiser anyway. If there's another reason to do a v4 or others
are unhappy with it then consider fixing it, otherwise:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks.
