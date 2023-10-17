Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037CD7CC5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjJQOdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJQOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:33:41 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3D92
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:33:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80A74240006;
        Tue, 17 Oct 2023 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697553217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yj04gDIpwLQf3yC7GJzN0bzDkhZ5RbyoNmRB6vDiyLw=;
        b=TGT4lwgXQeq65HB4JNBIRBYFdwQvbs/oISsROLQIPjog0d6TVxO+nSdTVRRP+q1icCmvyj
        go2Ynxu2HOnyMXQckPiXuMG/LEGvZ82SwPaQn41vrqIIuIbWejyYwFMNfUbla6gXsAADcw
        d5qS8rMNF+5mDUyRVCoeuzX0vlrnVLT74ChN33GpdhUFL1QuuLTsrGXnJwaefphbK33uAW
        suj5iT8vspsyQTN+HMbtNIShmtjbz773v+vg0HNR/mMJ8+I+xvvyoKsXrfTI3jhW/0bOlD
        84BlcmgWJP0QdsOWoYddpOx10nLFoD4hUgnlFFXmRTY2HS8Q3GOzwIuqYxt//g==
Date:   Tue, 17 Oct 2023 16:33:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 6/6] i3c: master: svc: fix random hot join failure since
 timeout error
Message-ID: <20231017163335.16770af2@xps-13>
In-Reply-To: <20231016153232.2851095-7-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
        <20231016153232.2851095-7-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:32:32 -0400:

> master side report:
>   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x0200=
90c7, MERRWARN 0x00100000
>=20
> BIT 20: TIMEOUT error
>   The module has stalled too long in a frame. This happens when:
>   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> middle of a message,
>   - No STOP was issued and between messages,
>   - IBI manual is used and no decision was made.
>   The maximum stall period is 10 KHz or 100 =CE=BCs.
>=20
> This is a just warning. System irq thread schedule latency is possible

							can be bigger
> bigger than 100us. Just omit this waring.

I'm not sure this is the correct approach. It's a real issue but there
is not much we can do about it. Perhaps dev_err is too high, but I
would not entirely drop this message. Maybe a comment and turning the
message into a dbg printk would be more appropriate?

> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 5bca369d6912..18bc277edc8a 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -93,6 +93,7 @@
>  #define SVC_I3C_MINTMASKED   0x098
>  #define SVC_I3C_MERRWARN     0x09C
>  #define   SVC_I3C_MERRWARN_NACK BIT(2)
> +#define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
>  #define SVC_I3C_MDMACTRL     0x0A0
>  #define SVC_I3C_MDATACTRL    0x0AC
>  #define   SVC_I3C_MDATACTRL_FLUSHTB BIT(0)
> @@ -225,6 +226,11 @@ static bool svc_i3c_master_error(struct svc_i3c_mast=
er *master)
>  	if (SVC_I3C_MSTATUS_ERRWARN(mstatus)) {
>  		merrwarn =3D readl(master->regs + SVC_I3C_MERRWARN);
>  		writel(merrwarn, master->regs + SVC_I3C_MERRWARN);
> +
> +		/* ignore timeout error */
> +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> +			return false;
> +
>  		dev_err(master->dev,
>  			"Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
>  			mstatus, merrwarn);


Thanks,
Miqu=C3=A8l
