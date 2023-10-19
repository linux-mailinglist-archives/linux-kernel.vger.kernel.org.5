Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC07CF047
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjJSGpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjJSGpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:45:00 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C8B116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:44:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E773460002;
        Thu, 19 Oct 2023 06:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697697896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLQy0z/148h9q9gR223NPowUSBgZtPyoLjW6cE0Fr0Y=;
        b=TLR5LKqnonGG9PJg6HVhImuCH2K++DgskOtHCv4TbaN3CItv6sMPF0e/alCsWaLx3jcByI
        qxMt2YJ1AnBlx9lDO0CODPCUuL66R6JWVDJ8nE5k4fwwyBS9xoRTznJUbK2dLZzgay/GKu
        l+kDAr9nGIc3folCeeCe9LvsbYx7ipzkBSk+uUBc+VTLBbUdKQ5khH8G8wEmXp88jelgLm
        NL5JIshMWV8lfTfwcetsBo+IX5TSVNuLCuy6wGda0DY/68HAPtB5NcgSsV1zHiB2rfNCKs
        Dm6mtYnRgCUIdeXgww3X16kJ/AgQud0zBtpucRBt5ruck1UeTCHcmyGV/8somg==
Date:   Thu, 19 Oct 2023 08:44:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <20231019084452.11fd0645@xps-13>
In-Reply-To: <20231018155926.3305476-7-Frank.Li@nxp.com>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
        <20231018155926.3305476-7-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:

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

I am still not convinced this should be ignored in all cases.

Case 1 is a problem because the hardware failed somehow.
Case 2 is fine I guess.
Case 3 is not possible in Linux, this will not be supported.

>   The maximum stall period is 10 KHz or 100 =CE=BCs.

s/10 KHz//

>=20
> This is a just warning. System irq thread schedule latency is possible
> bigger than 100us. Just omit this waring.

This can be considered as being just a warning as the system IRQ
latency can easily be greater than 100us.

>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Change from v1 to v2
>     -none
>=20
>  drivers/i3c/master/svc-i3c-master.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 1a57fdebaa26d..fedb31e0076c4 100644
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
> @@ -226,6 +227,11 @@ static bool svc_i3c_master_error(struct svc_i3c_mast=
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
