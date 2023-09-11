Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ADA79BF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjIKUro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjIKIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:50:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A61A1;
        Mon, 11 Sep 2023 01:50:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 297DD475;
        Mon, 11 Sep 2023 10:48:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694422113;
        bh=HYWcoErF1kOw7PBHq31Lio5TlvKuzPX5j4K2z5/xuLw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VYihZQeoP7RtZ9Heus8M1X/vbQsHAOtro9Ix3pQDGtci3vjNVkf+0jMFfbinKHIBz
         EPvPBJrHh226FyRDx87UiOx1JWRAiqstEnJnq8S3ne0alBmRWA6iKnHoWS+2pr+jpP
         efJDvlugxmPmT2Wzmyle9LyO4dTf5Of0Gm6m1DJg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230910150033.50596-2-biju.das.jz@bp.renesas.com>
References: <20230910150033.50596-1-biju.das.jz@bp.renesas.com> <20230910150033.50596-2-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 1/2] media: i2c: ov7670: Extend match support for OF tables
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Mon, 11 Sep 2023 09:50:00 +0100
Message-ID: <169442220081.2427060.12168685477104863217@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Biju Das (2023-09-10 16:00:32)
> The driver has an OF match table, still, it uses an ID lookup table for
> retrieving match data. Currently, the driver is working on the
> assumption that an I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using i2c_get_match_data() if the devices are registered via OF/ID.
>=20
> Unify the OF/ID table by using struct ov7670_devtype as match data for
> both these tables and replace the ID lookup table for the match data by
> i2c_get_match_data().
>=20
> Split the array ov7670_devdata[] as individual variables, and
> make lines shorter by referring to e.g. &ov7670_devdata instead of
> &ov7670_devdata[MODEL_OV7670].
>=20
> Drop enum ov7670_model as there is no user.
>=20
> While at it, remove the trailing comma in the terminator entry for the OF
> table making code robust against (theoretical) misrebases or other similar
> things where the new entry goes _after_ the termination without the
> compiler noticing.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/media/i2c/ov7670.c | 47 ++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
> index 2f55491ef571..644457e6993d 100644
> --- a/drivers/media/i2c/ov7670.c
> +++ b/drivers/media/i2c/ov7670.c
> @@ -186,11 +186,6 @@ MODULE_PARM_DESC(debug, "Debug level (0-1)");
>  #define REG_HAECC7     0xaa    /* Hist AEC/AGC control 7 */
>  #define REG_BD60MAX    0xab    /* 60hz banding step limit */
> =20
> -enum ov7670_model {
> -       MODEL_OV7670 =3D 0,
> -       MODEL_OV7675,
> -};
> -
>  struct ov7670_win_size {
>         int     width;
>         int     height;
> @@ -1774,21 +1769,6 @@ static const struct v4l2_subdev_internal_ops ov767=
0_subdev_internal_ops =3D {
> =20
>  /* ---------------------------------------------------------------------=
-- */
> =20
> -static const struct ov7670_devtype ov7670_devdata[] =3D {
> -       [MODEL_OV7670] =3D {
> -               .win_sizes =3D ov7670_win_sizes,
> -               .n_win_sizes =3D ARRAY_SIZE(ov7670_win_sizes),
> -               .set_framerate =3D ov7670_set_framerate_legacy,
> -               .get_framerate =3D ov7670_get_framerate_legacy,
> -       },
> -       [MODEL_OV7675] =3D {
> -               .win_sizes =3D ov7675_win_sizes,
> -               .n_win_sizes =3D ARRAY_SIZE(ov7675_win_sizes),
> -               .set_framerate =3D ov7675_set_framerate,
> -               .get_framerate =3D ov7675_get_framerate,
> -       },
> -};
> -
>  static int ov7670_init_gpio(struct i2c_client *client, struct ov7670_inf=
o *info)
>  {
>         info->pwdn_gpio =3D devm_gpiod_get_optional(&client->dev, "powerd=
own",
> @@ -1849,7 +1829,6 @@ static int ov7670_parse_dt(struct device *dev,
> =20
>  static int ov7670_probe(struct i2c_client *client)
>  {
> -       const struct i2c_device_id *id =3D i2c_client_get_device_id(clien=
t);
>         struct v4l2_fract tpf;
>         struct v4l2_subdev *sd;
>         struct ov7670_info *info;
> @@ -1923,7 +1902,7 @@ static int ov7670_probe(struct i2c_client *client)
>         v4l_info(client, "chip found @ 0x%02x (%s)\n",
>                         client->addr << 1, client->adapter->name);
> =20
> -       info->devtype =3D &ov7670_devdata[id->driver_data];
> +       info->devtype =3D i2c_get_match_data(client);
>         info->fmt =3D &ov7670_formats[0];
>         info->wsize =3D &info->devtype->win_sizes[0];
> =20
> @@ -2013,17 +1992,31 @@ static void ov7670_remove(struct i2c_client *clie=
nt)
>         media_entity_cleanup(&info->sd.entity);
>  }
> =20
> +static const struct ov7670_devtype ov7670_devdata =3D {
> +       .win_sizes =3D ov7670_win_sizes,
> +       .n_win_sizes =3D ARRAY_SIZE(ov7670_win_sizes),
> +       .set_framerate =3D ov7670_set_framerate_legacy,
> +       .get_framerate =3D ov7670_get_framerate_legacy,
> +};
> +
> +static const struct ov7670_devtype ov7675_devdata =3D {
> +       .win_sizes =3D ov7675_win_sizes,
> +       .n_win_sizes =3D ARRAY_SIZE(ov7675_win_sizes),
> +       .set_framerate =3D ov7675_set_framerate,
> +       .get_framerate =3D ov7675_get_framerate,
> +};
> +
>  static const struct i2c_device_id ov7670_id[] =3D {
> -       { "ov7670", MODEL_OV7670 },
> -       { "ov7675", MODEL_OV7675 },
> -       { }
> +       { "ov7670", (kernel_ulong_t)&ov7670_devdata },
> +       { "ov7675", (kernel_ulong_t)&ov7675_devdata },
> +       { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ov7670_id);
> =20
>  #if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id ov7670_of_match[] =3D {
> -       { .compatible =3D "ovti,ov7670", },
> -       { /* sentinel */ },
> +       { .compatible =3D "ovti,ov7670", &ov7670_devdata },
> +       { /* sentinel */ }

This all looks good to me - by why is there no ov7675 compatible string?
Should that be added? (as a separate patch?)

Can the model be detected at runtime (Is there a version register on
this chip?)

But otherwise looks fine.


Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>  };
>  MODULE_DEVICE_TABLE(of, ov7670_of_match);
>  #endif
> --=20
> 2.25.1
>
