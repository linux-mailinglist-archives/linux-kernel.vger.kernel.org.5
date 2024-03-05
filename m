Return-Path: <linux-kernel+bounces-92513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F79872170
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B590C1F22459
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC9486652;
	Tue,  5 Mar 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jvXPplCD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECBB8662A;
	Tue,  5 Mar 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648865; cv=none; b=H4TN2dwEiPY1TUJx0yrTE5g9qYylXzNXwY+YavAXo9WtdGiSXVI4ER105MfwVqO9Cd33aYZTFsCY6NVEOwGmWBOW12PHxkqtOxnlNDUMsmL8jOp3e7Kis7UdBHfktnIUc7gcgHBHxBL8CfoINfOV1AOhawLaufX2hzZJq5YoecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648865; c=relaxed/simple;
	bh=nlNT3jUvxPSVeEweC4uUl0UlQX0SoeSe/02Xso6dAgw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ZepgseoW22rR1It4x+PKNO6f0PQ1VG5dUkjdE3LfYGn32bNu1kVwr7VOU4PbIs9FbUnSXE9DvxOyNitlW+7S0iiWUyxBSePZN7zLwROq63dT4PINt9q4bWHAS/Fhg1FIr0UE0509J1MFhHitBqcW6Qgb38CWpJ4A/S7mEIe5Lgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jvXPplCD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A46B59D5;
	Tue,  5 Mar 2024 15:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709648843;
	bh=nlNT3jUvxPSVeEweC4uUl0UlQX0SoeSe/02Xso6dAgw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jvXPplCDTRd2Sk1fsmmTS8mtwe5Fbdvon54X+UBQg+ipVrA48G4VKhGq1fYa4j251
	 yssnq90i5Sg/zZISdwdYSt04Ps8lA16YwqVRN6hOyM7vC/gzaWjsxRX/qG2BcZoHbs
	 g7n+2qK//4LiPgA1qr8JKkIcoOBhYRtJd3buDqIE=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229165333.227484-18-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com> <20240229165333.227484-18-mike.rudenko@gmail.com>
Subject: Re: [PATCH v3 17/20] media: i2c: ov4689: Configurable analogue crop
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Mikhail Rudenko <mike.rudenko@gmail.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Tue, 05 Mar 2024 14:27:37 +0000
Message-ID: <170964885738.362031.275064492290886570@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Hi Mikhail,

Quoting Mikhail Rudenko (2024-02-29 16:53:30)
> Implement configurable analogue crop via .set_selectiong call.

s/.set_selectiong/.set_selection/

> ov4689_init_cfg is modified to initialize default subdev selection.
> Offsets are aligned to 2 to preserve Bayer order, selection width is
> aligned to 4 and height to 2 to meet hardware requirements.
>=20
> Experimentally discovered values of the cropping-related registers and
> vfifo_read_start for various output sizes are used. Default BLC anchor
> positions are used for the default analogue crop, scaling down
> proportionally for the smaller crop sizes.
>=20
> When analogue crop is adjusted, several consequential actions take
> place: the output format is reset, exposure/vblank/hblank control
> ranges and default values are adjusted accordingly. Additionally,
> ov4689_set_ctrl utilizes pad crop instead of cur_mode width and
> height for HTS and VTS calculation. Also, ov4689_enum_frame_sizes is
> modified to report crop size as available frame size.
>=20
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

As discussed privately, this is hard to do a direct review of the
underlying detailed changes and I don't specifically have this hardware
to test.  But I understand and trust the hours you've put in to testing
this, and I can't see anything /wrong/ in this patch - so therefore:

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 276 ++++++++++++++++++++++++++++---------
>  1 file changed, 212 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index d34699f35270..06f202c12dff 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -45,8 +45,12 @@
>  #define OV4689_REG_V_CROP_START                CCI_REG16(0x3802)
>  #define OV4689_REG_H_CROP_END          CCI_REG16(0x3804)
>  #define OV4689_REG_V_CROP_END          CCI_REG16(0x3806)
> +
>  #define OV4689_REG_H_OUTPUT_SIZE       CCI_REG16(0x3808)
> +#define OV4689_H_OUTPUT_SIZE_DEFAULT   2688
> +
>  #define OV4689_REG_V_OUTPUT_SIZE       CCI_REG16(0x380a)
> +#define OV4689_V_OUTPUT_SIZE_DEFAULT   1520
> =20
>  #define OV4689_REG_HTS                 CCI_REG16(0x380c)
>  #define OV4689_HTS_DIVIDER             4
> @@ -96,6 +100,19 @@
>  #define OV4689_DUMMY_ROWS              8       /* 8 dummy rows on each s=
ide */
>  #define OV4689_DUMMY_COLUMNS           16      /* 16 dummy columns on ea=
ch side */
> =20
> +/*
> + * These values are not hardware limits, but rather the minimums that
> + * the driver has been tested to.
> + */
> +#define OV4689_H_CROP_MIN              128
> +#define OV4689_V_CROP_MIN              128
> +
> +/*
> + * Minimum working vertical blanking value. Found experimentally at
> + * minimum HTS values.
> + */
> +#define OV4689_VBLANK_MIN              31
> +
>  static const char *const ov4689_supply_names[] =3D {
>         "avdd", /* Analog power */
>         "dovdd", /* Digital I/O power */
> @@ -134,7 +151,7 @@ struct ov4689 {
>         u32 clock_rate;
> =20
>         struct v4l2_ctrl_handler ctrl_handler;
> -       struct v4l2_ctrl *exposure;
> +       struct v4l2_ctrl *exposure, *hblank, *vblank;
> =20
>         const struct ov4689_mode *cur_mode;
>  };
> @@ -320,24 +337,27 @@ static const struct ov4689_gain_range ov4689_gain_r=
anges[] =3D {
>         },
>  };
> =20
> -static void ov4689_fill_fmt(const struct ov4689_mode *mode,
> -                           struct v4l2_mbus_framefmt *fmt)
> -{
> -       fmt->code =3D MEDIA_BUS_FMT_SBGGR10_1X10;
> -       fmt->width =3D mode->width;
> -       fmt->height =3D mode->height;
> -       fmt->field =3D V4L2_FIELD_NONE;
> -}
> -
>  static int ov4689_set_fmt(struct v4l2_subdev *sd,
>                           struct v4l2_subdev_state *sd_state,
>                           struct v4l2_subdev_format *fmt)
>  {
> -       struct v4l2_mbus_framefmt *mbus_fmt =3D &fmt->format;
> -       struct ov4689 *ov4689 =3D to_ov4689(sd);
> +       struct v4l2_mbus_framefmt *format;
> +       struct v4l2_rect *crop;
> +
> +       crop =3D v4l2_subdev_state_get_crop(sd_state, fmt->pad);
> +       format =3D v4l2_subdev_state_get_format(sd_state, fmt->pad);
> +
> +       format->width =3D crop->width;
> +       format->height =3D crop->height;
> =20
> -       /* only one mode supported for now */
> -       ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
> +       format->code =3D MEDIA_BUS_FMT_SBGGR10_1X10;
> +       format->field =3D V4L2_FIELD_NONE;
> +       format->colorspace =3D V4L2_COLORSPACE_RAW;
> +       format->ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
> +       format->quantization =3D V4L2_QUANTIZATION_FULL_RANGE;
> +       format->xfer_func =3D V4L2_XFER_FUNC_NONE;
> +
> +       fmt->format =3D *format;
> =20
>         return 0;
>  }
> @@ -357,16 +377,20 @@ static int ov4689_enum_frame_sizes(struct v4l2_subd=
ev *sd,
>                                    struct v4l2_subdev_state *sd_state,
>                                    struct v4l2_subdev_frame_size_enum *fs=
e)
>  {
> -       if (fse->index >=3D ARRAY_SIZE(supported_modes))
> +       const struct v4l2_rect *crop;
> +
> +       if (fse->index >=3D 1)
>                 return -EINVAL;
> =20
>         if (fse->code !=3D MEDIA_BUS_FMT_SBGGR10_1X10)
>                 return -EINVAL;
> =20
> -       fse->min_width =3D supported_modes[fse->index].width;
> -       fse->max_width =3D supported_modes[fse->index].width;
> -       fse->max_height =3D supported_modes[fse->index].height;
> -       fse->min_height =3D supported_modes[fse->index].height;
> +       crop =3D v4l2_subdev_state_get_crop(sd_state, 0);
> +
> +       fse->min_width =3D crop->width;
> +       fse->max_width =3D crop->width;
> +       fse->max_height =3D crop->height;
> +       fse->min_height =3D crop->height;
> =20
>         return 0;
>  }
> @@ -388,20 +412,14 @@ static int ov4689_get_selection(struct v4l2_subdev =
*sd,
>                                 struct v4l2_subdev_state *state,
>                                 struct v4l2_subdev_selection *sel)
>  {
> -       if (sel->which !=3D V4L2_SUBDEV_FORMAT_ACTIVE)
> -               return -EINVAL;
> -
>         switch (sel->target) {
> -       case V4L2_SEL_TGT_CROP_BOUNDS:
> -               sel->r.top =3D 0;
> -               sel->r.left =3D 0;
> -               sel->r.width =3D OV4689_PIXEL_ARRAY_WIDTH;
> -               sel->r.height =3D OV4689_PIXEL_ARRAY_HEIGHT;
> -               return 0;
>         case V4L2_SEL_TGT_CROP:
> +               sel->r =3D *v4l2_subdev_state_get_crop(state, sel->pad);
> +               return 0;
> +       case V4L2_SEL_TGT_CROP_BOUNDS:
>         case V4L2_SEL_TGT_CROP_DEFAULT:
> -               sel->r.top =3D OV4689_DUMMY_ROWS;
>                 sel->r.left =3D OV4689_DUMMY_COLUMNS;
> +               sel->r.top =3D OV4689_DUMMY_ROWS;
>                 sel->r.width =3D
>                         OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_COLUM=
NS;
>                 sel->r.height =3D
> @@ -412,37 +430,141 @@ static int ov4689_get_selection(struct v4l2_subdev=
 *sd,
>         return -EINVAL;
>  }
> =20
> -static int ov4689_setup_timings(struct ov4689 *ov4689)
> +/*
> + * Minimum working HTS value for given output width (found
> + * experimentally).
> + */
> +static unsigned int ov4689_hts_min(unsigned int width)
> +{
> +       return max_t(unsigned int, 3156, 224 + width * 19 / 16);
> +}
> +
> +static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689,
> +                                     struct v4l2_rect *crop)
> +{
> +       struct v4l2_ctrl *exposure =3D ov4689->exposure;
> +       struct v4l2_ctrl *vblank =3D ov4689->vblank;
> +       struct v4l2_ctrl *hblank =3D ov4689->hblank;
> +       s64 def_val, min_val, max_val;
> +
> +       min_val =3D ov4689_hts_min(crop->width) - crop->width;
> +       max_val =3D OV4689_HTS_MAX - crop->width;
> +       def_val =3D clamp_t(s64, hblank->default_value, min_val, max_val);
> +       __v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
> +                                def_val);
> +
> +       min_val =3D OV4689_VBLANK_MIN;
> +       max_val =3D OV4689_HTS_MAX - crop->width;
> +       def_val =3D clamp_t(s64, vblank->default_value, min_val, max_val);
> +       __v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
> +                                def_val);
> +
> +       min_val =3D exposure->minimum;
> +       max_val =3D crop->height + vblank->val - 4;
> +       def_val =3D clamp_t(s64, exposure->default_value, min_val, max_va=
l);
> +       __v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->st=
ep,
> +                                def_val);
> +}
> +
> +static int ov4689_set_selection(struct v4l2_subdev *sd,
> +                               struct v4l2_subdev_state *state,
> +                               struct v4l2_subdev_selection *sel)
>  {
> -       const struct ov4689_mode *mode =3D ov4689->cur_mode;
> +       struct ov4689 *ov4689 =3D to_ov4689(sd);
> +       struct v4l2_mbus_framefmt *format;
> +       struct v4l2_rect *crop;
> +       struct v4l2_rect rect;
> +
> +       if (sel->target !=3D V4L2_SEL_TGT_CROP)
> +               return -EINVAL;
> +
> +       rect.left =3D clamp(ALIGN(sel->r.left, 2), OV4689_DUMMY_COLUMNS,
> +                         OV4689_PIXEL_ARRAY_WIDTH);
> +       rect.top =3D clamp(ALIGN(sel->r.top, 2), OV4689_DUMMY_ROWS,
> +                        OV4689_PIXEL_ARRAY_HEIGHT);
> +
> +       rect.width =3D clamp_t(unsigned int, ALIGN(sel->r.width, 4),
> +                            OV4689_H_CROP_MIN, OV4689_PIXEL_ARRAY_WIDTH -
> +                            2 * OV4689_DUMMY_COLUMNS);
> +       rect.height =3D clamp_t(unsigned int, ALIGN(sel->r.height, 2),
> +                             OV4689_V_CROP_MIN, OV4689_PIXEL_ARRAY_HEIGH=
T -
> +                             2 * OV4689_DUMMY_ROWS);
> +
> +       crop =3D v4l2_subdev_state_get_crop(state, sel->pad);
> +
> +       if (rect.width !=3D crop->width || rect.height !=3D crop->height)=
 {
> +               /*
> +                * Reset the output image size if the crop rectangle size=
 has
> +                * been modified.
> +                */
> +               format =3D v4l2_subdev_state_get_format(state, sel->pad);
> +               format->width =3D rect.width;
> +               format->height =3D rect.height;
> +
> +               if (sel->which =3D=3D V4L2_SUBDEV_FORMAT_ACTIVE)
> +                       ov4689_update_ctrl_ranges(ov4689, &rect);
> +       }
> +
> +       *crop =3D rect;
> +       sel->r =3D rect;
> +
> +       return 0;
> +}
> +
> +static int ov4689_setup_timings(struct ov4689 *ov4689,
> +                               struct v4l2_subdev_state *state)
> +{
> +       const struct v4l2_mbus_framefmt *format;
>         struct regmap *rm =3D ov4689->regmap;
> +       const struct v4l2_rect *crop;
>         int ret =3D 0;
> =20
> -       cci_write(rm, OV4689_REG_H_CROP_START, 8, &ret);
> -       cci_write(rm, OV4689_REG_V_CROP_START, 8, &ret);
> -       cci_write(rm, OV4689_REG_H_CROP_END, 2711, &ret);
> -       cci_write(rm, OV4689_REG_V_CROP_END, 1531, &ret);
> +       format =3D v4l2_subdev_state_get_format(state, 0);
> +       crop =3D v4l2_subdev_state_get_crop(state, 0);
> +
> +       cci_write(rm, OV4689_REG_H_CROP_START, crop->left, &ret);
> +       cci_write(rm, OV4689_REG_V_CROP_START, crop->top, &ret);
> +       cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 1=
, &ret);
> +       cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 1=
, &ret);
> =20
> -       cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, mode->width, &ret);
> -       cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, mode->height, &ret);
> +       cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, format->width, &ret);
> +       cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, format->height, &ret);
> =20
> -       cci_write(rm, OV4689_REG_H_WIN_OFF, 8, &ret);
> -       cci_write(rm, OV4689_REG_V_WIN_OFF, 4, &ret);
> +       cci_write(rm, OV4689_REG_H_WIN_OFF, 0, &ret);
> +       cci_write(rm, OV4689_REG_V_WIN_OFF, 0, &ret);
> =20
> -       cci_write(rm, OV4689_REG_VFIFO_CTRL_01, 167, &ret);
> +       /*
> +        * Maximum working value of vfifo_read_start for given output
> +        * width (found experimentally).
> +        */
> +       cci_write(rm, OV4689_REG_VFIFO_CTRL_01, format->width / 16 - 1, &=
ret);
> =20
>         return ret;
>  }
> =20
> -static int ov4689_setup_blc_anchors(struct ov4689 *ov4689)
> +/*
> + * Setup black level compensation anchors. For the default frame width
> + * default anchors positions are used. For smaller crop sizes they are
> + * scaled accordingly.
> + */
> +static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
> +                                   struct v4l2_subdev_state *state)
>  {
> +       unsigned int width_def =3D OV4689_H_OUTPUT_SIZE_DEFAULT;
>         struct regmap *rm =3D ov4689->regmap;
> +       const struct v4l2_rect *crop;
>         int ret =3D 0;
> =20
> -       cci_write(rm, OV4689_REG_ANCHOR_LEFT_START, 16, &ret);
> -       cci_write(rm, OV4689_REG_ANCHOR_LEFT_END, 1999, &ret);
> -       cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START, 2400, &ret);
> -       cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END, 2415, &ret);
> +       crop =3D v4l2_subdev_state_get_crop(state, 0);
> +
> +       cci_write(rm, OV4689_REG_ANCHOR_LEFT_START,
> +                 OV4689_ANCHOR_LEFT_START_DEF * crop->width / width_def,=
 &ret);
> +       cci_write(rm, OV4689_REG_ANCHOR_LEFT_END,
> +                 OV4689_ANCHOR_LEFT_END_DEF * crop->width / width_def, &=
ret);
> +       cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START,
> +                 OV4689_ANCHOR_RIGHT_START_DEF * crop->width / width_def=
, &ret);
> +       cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END,
> +                 OV4689_ANCHOR_RIGHT_END_DEF * crop->width / width_def, =
&ret);
> =20
>         return ret;
>  }
> @@ -470,13 +592,13 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, =
int on)
>                         goto unlock_and_return;
>                 }
> =20
> -               ret =3D ov4689_setup_timings(ov4689);
> +               ret =3D ov4689_setup_timings(ov4689, sd_state);
>                 if (ret) {
>                         pm_runtime_put(dev);
>                         goto unlock_and_return;
>                 }
> =20
> -               ret =3D ov4689_setup_blc_anchors(ov4689);
> +               ret =3D ov4689_setup_blc_anchors(ov4689, sd_state);
>                 if (ret) {
>                         pm_runtime_put(dev);
>                         goto unlock_and_return;
> @@ -568,10 +690,25 @@ static int __maybe_unused ov4689_power_off(struct d=
evice *dev)
>  static int ov4689_init_state(struct v4l2_subdev *sd,
>                              struct v4l2_subdev_state *sd_state)
>  {
> -       struct v4l2_mbus_framefmt *fmt =3D
> -               v4l2_subdev_state_get_format(sd_state, 0);
> +       u32 width_def =3D OV4689_H_OUTPUT_SIZE_DEFAULT;
> +       u32 height_def =3D OV4689_V_OUTPUT_SIZE_DEFAULT;
> +
> +       struct v4l2_subdev_selection sel  =3D {
> +               .target =3D V4L2_SEL_TGT_CROP,
> +               .r.left =3D OV4689_DUMMY_COLUMNS,
> +               .r.top =3D OV4689_DUMMY_ROWS,
> +               .r.width =3D width_def,
> +               .r.height =3D height_def,
> +       };
> +       struct v4l2_subdev_format format =3D {
> +               .format =3D {
> +                       .width =3D width_def,
> +                       .height =3D height_def,
> +               },
> +       };
> =20
> -       ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], fmt);
> +       ov4689_set_selection(sd, sd_state, &sel);
> +       ov4689_set_fmt(sd, sd_state, &format);
> =20
>         return 0;
>  }
> @@ -590,6 +727,7 @@ static const struct v4l2_subdev_pad_ops ov4689_pad_op=
s =3D {
>         .get_fmt =3D v4l2_subdev_get_fmt,
>         .set_fmt =3D ov4689_set_fmt,
>         .get_selection =3D ov4689_get_selection,
> +       .set_selection =3D ov4689_set_selection,
>  };
> =20
>  static const struct v4l2_subdev_internal_ops ov4689_internal_ops =3D {
> @@ -635,20 +773,28 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>         struct ov4689 *ov4689 =3D
>                 container_of(ctrl->handler, struct ov4689, ctrl_handler);
>         struct regmap *regmap =3D ov4689->regmap;
> +       struct v4l2_subdev_state *sd_state;
>         struct device *dev =3D ov4689->dev;
> +       struct v4l2_rect *crop;
> +       s64 max_expo, def_expo;
>         int sensor_gain;
> -       s64 max_expo;
>         int ret =3D 0;
> =20
> +       sd_state =3D v4l2_subdev_get_locked_active_state(&ov4689->subdev);
> +       crop =3D v4l2_subdev_state_get_crop(sd_state, 0);
> +
>         /* Propagate change of current control to all related controls */
>         switch (ctrl->id) {
>         case V4L2_CID_VBLANK:
>                 /* Update max exposure while meeting expected vblanking */
> -               max_expo =3D ov4689->cur_mode->height + ctrl->val - 4;
> -               __v4l2_ctrl_modify_range(ov4689->exposure,
> -                                        ov4689->exposure->minimum, max_e=
xpo,
> -                                        ov4689->exposure->step,
> -                                        ov4689->exposure->default_value);
> +               max_expo =3D crop->height + ctrl->val - 4;
> +               def_expo =3D clamp_t(s64, ov4689->exposure->default_value,
> +                                  ov4689->exposure->minimum, max_expo);
> +
> +               ret =3D __v4l2_ctrl_modify_range(ov4689->exposure,
> +                                              ov4689->exposure->minimum,
> +                                              max_expo, ov4689->exposure=
->step,
> +                                              def_expo);
>                 break;
>         }
> =20
> @@ -666,14 +812,14 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>                 break;
>         case V4L2_CID_VBLANK:
>                 cci_write(regmap, OV4689_REG_VTS,
> -                         ctrl->val + ov4689->cur_mode->height, &ret);
> +                         ctrl->val + crop->height, &ret);
>                 break;
>         case V4L2_CID_TEST_PATTERN:
>                 ret =3D ov4689_enable_test_pattern(ov4689, ctrl->val);
>                 break;
>         case V4L2_CID_HBLANK:
>                 cci_write(regmap, OV4689_REG_HTS,
> -                         (ctrl->val + ov4689->cur_mode->width) /
> +                         (ctrl->val + crop->width) /
>                           OV4689_HTS_DIVIDER, &ret);
>                 break;
>         case V4L2_CID_VFLIP:
> @@ -739,14 +885,16 @@ static int ov4689_initialize_controls(struct ov4689=
 *ov4689)
> =20
>         hblank_def =3D mode->hts_def - mode->width;
>         hblank_min =3D mode->hts_min - mode->width;
> -       v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HBLANK,
> -                         hblank_min, OV4689_HTS_MAX - mode->width,
> -                         OV4689_HTS_DIVIDER, hblank_def);
> +       ov4689->hblank =3D v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
> +                                          V4L2_CID_HBLANK, hblank_min,
> +                                          OV4689_HTS_MAX - mode->width,
> +                                          OV4689_HTS_DIVIDER, hblank_def=
);
> =20
>         vblank_def =3D mode->vts_def - mode->height;
> -       v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VBLANK,
> -                         vblank_def, OV4689_VTS_MAX - mode->height, 1,
> -                         vblank_def);
> +       ov4689->vblank =3D v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
> +                                          V4L2_CID_VBLANK, OV4689_VBLANK=
_MIN,
> +                                          OV4689_VTS_MAX - mode->height,=
 1,
> +                                          vblank_def);
> =20
>         exposure_max =3D mode->vts_def - 4;
>         ov4689->exposure =3D
> --=20
> 2.43.0
>

