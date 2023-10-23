Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612007D42DB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjJWWoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjJWWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:44:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3E10C;
        Mon, 23 Oct 2023 15:44:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BBDA7AE;
        Tue, 24 Oct 2023 00:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698101040;
        bh=44kTKbA7H5AWp99DN6cgifPwZ2VCzFypzEW+C2K1y4s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=De6296iTuinmnZ8SpztkbFF4Sorx4HDQ4khwjbeHZw3sSWxScjmBef2kygkv3UqZn
         zP11M/saCN2/xzqQ5+IgS01mDJ/Pr1pN8AarH9Loge96YjljuMMOdRgPCdB/6qNkXb
         65/tCv5PK9IgaIYqVqyiZRXyhW6Ewm0Eu1U71Fnc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231023-imx214-v1-1-b33f1bbd1fcf@apitzsch.eu>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu> <20231023-imx214-v1-1-b33f1bbd1fcf@apitzsch.eu>
Subject: Re: [PATCH 1/4] media: i2c: imx214: Explain some magic numbers
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9?= Apitzsch <git@apitzsch.eu>
To:     =?utf-8?q?Andr=C3=A9?= Apitzsch <git@apitzsch.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Mon, 23 Oct 2023 23:44:09 +0100
Message-ID: <169810104910.2245571.16606813523946813634@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andr=C3=A9 Apitzsch (2023-10-23 22:47:50)
> Code refinement, no functional changes.
>=20
> Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
> ---
>  drivers/media/i2c/imx214.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> index 4f77ea02cc27..9218c149d4c8 100644
> --- a/drivers/media/i2c/imx214.c
> +++ b/drivers/media/i2c/imx214.c
> @@ -19,12 +19,23 @@
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-subdev.h>
> =20
> +#define IMX214_REG_MODE_SELECT         0x0100
> +#define IMX214_MODE_STANDBY            0x00
> +#define IMX214_MODE_STREAMING          0x01
> +
>  #define IMX214_DEFAULT_CLK_FREQ        24000000
>  #define IMX214_DEFAULT_LINK_FREQ 480000000
>  #define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ * 8LL) / 10)
>  #define IMX214_FPS 30
>  #define IMX214_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
> =20
> +/* Exposure control */
> +#define IMX214_REG_EXPOSURE            0x0202
> +#define IMX214_EXPOSURE_MIN            0
> +#define IMX214_EXPOSURE_MAX            3184
> +#define IMX214_EXPOSURE_STEP           1
> +#define IMX214_EXPOSURE_DEFAULT                0x0c70

I like this change, and I see that 0x0c70 was directly moved here from
the code below. But could we replace 0xc70 here with 3184 please so that
it's /far/ clearer that the Exposure Default =3D=3D Exposure Max which is
otherwise hidden?

--
Regards

Kieran


> +
>  static const char * const imx214_supply_name[] =3D {
>         "vdda",
>         "vddd",
> @@ -665,7 +676,7 @@ static int imx214_set_ctrl(struct v4l2_ctrl *ctrl)
>         case V4L2_CID_EXPOSURE:
>                 vals[1] =3D ctrl->val;
>                 vals[0] =3D ctrl->val >> 8;
> -               ret =3D regmap_bulk_write(imx214->regmap, 0x202, vals, 2);
> +               ret =3D regmap_bulk_write(imx214->regmap, IMX214_REG_EXPO=
SURE, vals, 2);
>                 if (ret < 0)
>                         dev_err(imx214->dev, "Error %d\n", ret);
>                 ret =3D 0;
> @@ -743,7 +754,7 @@ static int imx214_start_streaming(struct imx214 *imx2=
14)
>                 dev_err(imx214->dev, "could not sync v4l2 controls\n");
>                 goto error;
>         }
> -       ret =3D regmap_write(imx214->regmap, 0x100, 1);
> +       ret =3D regmap_write(imx214->regmap, IMX214_REG_MODE_SELECT, IMX2=
14_MODE_STREAMING);
>         if (ret < 0) {
>                 dev_err(imx214->dev, "could not sent start table %d\n", r=
et);
>                 goto error;
> @@ -761,7 +772,7 @@ static int imx214_stop_streaming(struct imx214 *imx21=
4)
>  {
>         int ret;
> =20
> -       ret =3D regmap_write(imx214->regmap, 0x100, 0);
> +       ret =3D regmap_write(imx214->regmap, IMX214_REG_MODE_SELECT, IMX2=
14_MODE_STANDBY);
>         if (ret < 0)
>                 dev_err(imx214->dev, "could not sent stop table %d\n",  r=
et);
> =20
> @@ -991,9 +1002,12 @@ static int imx214_probe(struct i2c_client *client)
>          *
>          * Yours sincerely, Ricardo.
>          */
> -       imx214->exposure =3D v4l2_ctrl_new_std(&imx214->ctrls, &imx214_ct=
rl_ops,
> +       imx214->exposure =3D v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_op=
s,
>                                              V4L2_CID_EXPOSURE,
> -                                            0, 3184, 1, 0x0c70);
> +                                            IMX214_EXPOSURE_MIN,
> +                                            IMX214_EXPOSURE_MAX,
> +                                            IMX214_EXPOSURE_STEP,
> +                                            IMX214_EXPOSURE_DEFAULT);
> =20
>         imx214->unit_size =3D v4l2_ctrl_new_std_compound(&imx214->ctrls,
>                                 NULL,
>=20
> --=20
> 2.42.0
>
