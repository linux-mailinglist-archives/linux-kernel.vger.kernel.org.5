Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B27EAB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjKNIUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjKNIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:20:02 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE0D1A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:19:58 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA7471BF206;
        Tue, 14 Nov 2023 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699949997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7tWyiHY4GP5FHn9qova3bj8b2knZsniB4j8YzqtHyM=;
        b=XQMkCtmwnl1bi4OTYoaciGBU7mTkriP2zpYqsSv30p9AKSzeMaTIO3c7/Pkvc0t0+QZ22z
        2KziH0ZpTzy3BQuFS/4ISIWvCZO2UqpJ3rx2uUqzmvMjOcq2o/nvS0SS+PpQtROubU9kzH
        y2Odld0v+yARBwl7/VNM2abTU/lxWcTavyCdjK2ncD0p9yQ7Q8p1v4CYEA10wzFaUFr7E5
        zIbut3OTSizTkPBV1xk8axmpP5jShfQ5seXuzDZFkh2/w8V0XYwFvq1nS9el83Nuty3adQ
        Gd8gNcVp+yfiGYVRWiuWEELmzZ93x05KaRIMTcs62zq3wQpsEsT6I4WLAO3z8w==
Date:   Tue, 14 Nov 2023 09:19:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] i3c: Add fallback method for GETMXDS CCC
Message-ID: <20231114091956.0b8dd6c5@xps-13>
In-Reply-To: <20231114033430.9623-2-joshua.yeong@starfivetech.com>
References: <20231114033430.9623-1-joshua.yeong@starfivetech.com>
        <20231114033430.9623-2-joshua.yeong@starfivetech.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

joshua.yeong@starfivetech.com wrote on Tue, 14 Nov 2023 11:34:30 +0800:

> Some I3C hardware will report error when incorrect length is received from

					an

> device. GETMXDS CCC are availble in 2 formats; without turnaround time (f=
ormat

			  available		:

> 1) and with turnaround time (format 2). There is no mechanics to determin=
e which
> format is supported by device. In case sending GETMXDS CCC format 2 resul=
ted

				So in case?

> failure, try sending GETMXDS CCC format 1 instead.

in a

>=20
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  drivers/i3c/master.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 0cdc94e4cb77..2fc04d97f07e 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1099,8 +1099,16 @@ static int i3c_master_getmxds_locked(struct i3c_ma=
ster_controller *master,
> =20
>  	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMXDS, &dest, 1);
>  	ret =3D i3c_master_send_ccc_cmd_locked(master, &cmd);
> -	if (ret)
> -		goto out;
> +	if (ret) {
> +		/*
		 ^
Wrong alignment of the starts below
		v
> +		* Retry when the device does not support max read turnaround
> +		* while expecting shorter length from this CCC command

period?

> +		*/
> +		dest->payload.len -=3D 3;
> +		ret =3D i3c_master_send_ccc_cmd_locked(master, &cmd);
> +		if (ret)
> +			goto out;
> +	}

I believe this is a per-device configuration and we should save this in
order to only fail once, no?

> =20
>  	if (dest.payload.len !=3D 2 && dest.payload.len !=3D 5) {
>  		ret =3D -EIO;


Thanks,
Miqu=C3=A8l
