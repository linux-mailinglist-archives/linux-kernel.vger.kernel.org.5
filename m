Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04ED79CF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjILLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjILLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:08:28 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FCB170E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:08:23 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C0831BF213;
        Tue, 12 Sep 2023 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694516902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EF3h98Mdqj31ieacBiceRbGocGI1mqvvI0enRLJAJ9U=;
        b=kDP44VJdI1tNdv9kVJvfwvKf+lFYfaKh5p2qJw1LiqypQuX0QJeZ2hEfctV4NiN7f2F/jn
        qLW9QUtcyeOypXKAU909WmoO2WXaqgWPS63eav3gY0d7NP9+QuAItO+TOwaoCV7heqcHzf
        LjlwoXP92KhpahnlNF6JGNNA24jyTbUAv8dAoyI68Sssix6LeClfCDwrXP7UaZ6t4uOIFr
        B06GbiMWaJKSGuRg4zz+i02aggTcNklhy23xAnX5ta/hV6ptRERpI2SLL5SniqKzqP6UxI
        TbmqW0WLpFVt690hNce9WzxaqNvmR44Gzwop7xD0KhFwaALKdSiJUWhwLRAqGQ==
Date:   Tue, 12 Sep 2023 13:08:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] i3c: Add fallback method for GETMXDS CCC
Message-ID: <20230912130821.21edfafc@xps-13>
In-Reply-To: <20230911082456.23239-2-joshua.yeong@starfivetech.com>
References: <20230911082456.23239-1-joshua.yeong@starfivetech.com>
        <20230911082456.23239-2-joshua.yeong@starfivetech.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

joshua.yeong@starfivetech.com wrote on Mon, 11 Sep 2023 16:24:56 +0800:

> Some I3C hardware will report error when incorrect length is received from
> device. GETMXDS CCC are availble in 2 formats; without turnaround time (f=
ormat
> 1) and with turnaround time (format 2). There is no mechanics to determin=
e which
> format is supported by device. In case sending GETMXDS CCC format 2 resul=
ted
> failure, try sending GETMXDS CCC format 1 instead.
>=20
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  drivers/i3c/master.c    | 33 ++++++++++++++++++++++++++++-----
>  include/linux/i3c/ccc.h | 17 +++++++++++++++--
>  2 files changed, 43 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 87283e4a4607..084f64bef155 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1088,10 +1088,37 @@ static int i3c_master_getmxds_locked(struct i3c_m=
aster_controller *master,
>  				     struct i3c_device_info *info)
>  {
>  	struct i3c_ccc_getmxds *getmaxds;
> +	struct i3c_ccc_getmxds_turnaround *getmaxds_ta;
>  	struct i3c_ccc_cmd_dest dest;
>  	struct i3c_ccc_cmd cmd;
>  	int ret;
> =20
> +	getmaxds_ta =3D i3c_ccc_cmd_dest_init(&dest, info->dyn_addr,
> +					 sizeof(*getmaxds_ta));
> +	if (!getmaxds_ta)
> +		return -ENOMEM;
> +
> +	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMXDS, &dest, 1);
> +	ret =3D i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret) {
> +		goto alternative;
> +	}
> +
> +	if (dest.payload.len !=3D 2 && dest.payload.len !=3D 5) {

Can len be 2 here?

> +		ret =3D -EIO;
> +		goto out;
> +	}
> +
> +	info->max_read_ds =3D getmaxds_ta->maxrd;
> +	info->max_write_ds =3D getmaxds_ta->maxwr;
> +	if (dest.payload.len =3D=3D 5)
> +		info->max_read_turnaround =3D getmaxds_ta->maxrdturn[0] |
> +					    ((u32)getmaxds_ta->maxrdturn[1] << 8) |
> +					    ((u32)getmaxds_ta->maxrdturn[2] << 16);

Don't you want to avoid the "alternative" if it worked?

> +
> +alternative:

I would expect a comment somewhere to explain the subtlety.

> +	i3c_ccc_cmd_dest_cleanup(&dest);
> +
>  	getmaxds =3D i3c_ccc_cmd_dest_init(&dest, info->dyn_addr,
>  					 sizeof(*getmaxds));
>  	if (!getmaxds)
> @@ -1102,17 +1129,13 @@ static int i3c_master_getmxds_locked(struct i3c_m=
aster_controller *master,
>  	if (ret)
>  		goto out;
> =20
> -	if (dest.payload.len !=3D 2 && dest.payload.len !=3D 5) {
> +	if (dest.payload.len !=3D 2) {
>  		ret =3D -EIO;
>  		goto out;
>  	}
> =20
>  	info->max_read_ds =3D getmaxds->maxrd;
>  	info->max_write_ds =3D getmaxds->maxwr;
> -	if (dest.payload.len =3D=3D 5)
> -		info->max_read_turnaround =3D getmaxds->maxrdturn[0] |
> -					    ((u32)getmaxds->maxrdturn[1] << 8) |
> -					    ((u32)getmaxds->maxrdturn[2] << 16);
> =20
>  out:
>  	i3c_ccc_cmd_dest_cleanup(&dest);
> diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
> index ad59a4ae60d1..50ed41d4d5a1 100644
> --- a/include/linux/i3c/ccc.h
> +++ b/include/linux/i3c/ccc.h
> @@ -269,14 +269,27 @@ enum i3c_tsco {
>  #define I3C_CCC_MAX_SDR_FSCL(x)		((x) & I3C_CCC_MAX_SDR_FSCL_MASK)
> =20
>  /**
> - * struct i3c_ccc_getmxds - payload passed to GETMXDS CCC
> + * struct i3c_ccc_getmxds - payload passed to GETMXDS CCC without turnar=
ound
> + * (format 1)
> + *
> + * @maxwr: write limitations
> + * @maxrd: read limitations
> + */
> +struct i3c_ccc_getmxds {
> +	u8 maxwr;
> +	u8 maxrd;
> +} __packed;
> +
> +/**
> + * struct i3c_ccc_getmxds_ta - payload passed to GETMXDS CCC with turnar=
ound
> + * (format 2)
>   *
>   * @maxwr: write limitations
>   * @maxrd: read limitations
>   * @maxrdturn: maximum read turn-around expressed micro-seconds and
>   *	       little-endian formatted
>   */
> -struct i3c_ccc_getmxds {
> +struct i3c_ccc_getmxds_turnaround {
>  	u8 maxwr;
>  	u8 maxrd;
>  	u8 maxrdturn[3];


Thanks,
Miqu=C3=A8l
