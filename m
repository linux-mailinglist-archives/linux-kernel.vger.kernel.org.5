Return-Path: <linux-kernel+bounces-19202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08218269B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ADB1C2195F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B98C133;
	Mon,  8 Jan 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUJ1OwiI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC7BE5D;
	Mon,  8 Jan 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704703504; x=1736239504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SdptqZfldfu0KcnGCo0RHrUPW2X7OnuzAYdE3Z53R9Q=;
  b=nUJ1OwiIgxTBOjabMVdBuj/SOMOLNKVbiTcEDzT9w4NKfVw5YjfJOI1+
   6CTlYuraGg1wpyxIIYpemqeaj850zu+IWvDMqok7VtN+J3QFTBaRT3cdK
   vpW6/AwFsiahV0kc71cnVzLhOZfMgWgOOyGcatIhogO4T4asrp8CgTV/F
   V5SL5QlbZDyxbDaupMQ/Ay2TDcu1TVL3PBvwp2MXryRVQWVnCrmxCKP5X
   dOFepmuqbkmAV2OsJy1xfzIcxzOCHdRr4M9e3qgbTuvQVvEADnCGfsiYz
   SdlhKMt/aRbKnOVxX6PoWnpNnAoQedTPJMxkLl0DFOmWMpdqmK24f87oh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="464227077"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="464227077"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:45:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="847149019"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="847149019"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:45:02 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 88D5711F8DE;
	Mon,  8 Jan 2024 10:44:59 +0200 (EET)
Date: Mon, 8 Jan 2024 08:44:59 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vinay Varma <varmavinaym@gmail.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"open list:SONY IMX219 SENSOR DRIVER" <linux-media@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: imx219: implement the v4l2 selection api
Message-ID: <ZZu2C_lu6TAh-LOf@kekkonen.localdomain>
References: <kv6yfyahbud474e75y4jaczg64pcowvlz7i52kikknuh6wje5o@4k2hikwcueoy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kv6yfyahbud474e75y4jaczg64pcowvlz7i52kikknuh6wje5o@4k2hikwcueoy>

Hi Vinay,

Thanks for the patch.

On Sun, Jan 07, 2024 at 03:42:59PM +0800, Vinay Varma wrote:
> This patch exposes IMX219's crop and compose capabilities
> by implementing the selection API. Horizontal and vertical
> binning being separate registers, `imx219_binning_goodness`
> computes the best possible height and width of the compose
> specification using the selection flags. Compose operation
> updates the subdev's format object to keep them in sync.

The line length limit here is 75, not ~ 60. Please rewrap.

> 
> Signed-off-by: Vinay Varma <varmavinaym@gmail.com>
> ---
>  drivers/media/i2c/imx219.c | 222 +++++++++++++++++++++++++++++++------
>  1 file changed, 190 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index 39943d72c22d..27d85fb7ad51 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -29,6 +29,7 @@
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-mediabus.h>
> +#include <media/v4l2-rect.h>
>  
>  /* Chip ID */
>  #define IMX219_REG_CHIP_ID		CCI_REG16(0x0000)
> @@ -73,6 +74,7 @@
>  /* V_TIMING internal */
>  #define IMX219_REG_VTS			CCI_REG16(0x0160)
>  #define IMX219_VTS_MAX			0xffff
> +#define IMX219_VTS_DEF 1763
>  
>  #define IMX219_VBLANK_MIN		32
>  
> @@ -146,6 +148,7 @@
>  #define IMX219_PIXEL_ARRAY_TOP		8U
>  #define IMX219_PIXEL_ARRAY_WIDTH	3280U
>  #define IMX219_PIXEL_ARRAY_HEIGHT	2464U
> +#define IMX219_MIN_COMPOSE_SIZE 8U

Please align 8U with the rest of the macros. Same above.

>  
>  /* Mode : resolution and related config&values */
>  struct imx219_mode {
> @@ -284,6 +287,8 @@ static const u32 imx219_mbus_formats[] = {
>  #define IMX219_XCLR_MIN_DELAY_US	6200
>  #define IMX219_XCLR_DELAY_RANGE_US	1000
>  
> +static const u32 binning_ratios[] = { 1, 2 };
> +
>  /* Mode configs */
>  static const struct imx219_mode supported_modes[] = {
>  	{
> @@ -296,19 +301,19 @@ static const struct imx219_mode supported_modes[] = {
>  		/* 1080P 30fps cropped */
>  		.width = 1920,
>  		.height = 1080,
> -		.vts_def = 1763,
> +		.vts_def = IMX219_VTS_DEF,
>  	},
>  	{
>  		/* 2x2 binned 30fps mode */
>  		.width = 1640,
>  		.height = 1232,
> -		.vts_def = 1763,
> +		.vts_def = IMX219_VTS_DEF,
>  	},
>  	{
>  		/* 640x480 30fps mode */
>  		.width = 640,
>  		.height = 480,
> -		.vts_def = 1763,
> +		.vts_def = IMX219_VTS_DEF,
>  	},
>  };
>  
> @@ -809,6 +814,39 @@ static int imx219_enum_frame_size(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> +static void imx219_refresh_ctrls(struct v4l2_subdev *sd,
> +				 struct v4l2_subdev_state *state,
> +				 unsigned int vts_def)
> +{
> +	int exposure_max;
> +	int exposure_def;
> +	int hblank;
> +	struct imx219 *imx219 = to_imx219(sd);
> +	struct v4l2_mbus_framefmt *fmt =
> +		v4l2_subdev_get_pad_format(sd, state, 0);
> +
> +	/* Update limits and set FPS to default */
> +	__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
> +				 IMX219_VTS_MAX - fmt->height, 1,
> +				 vts_def - fmt->height);
> +	__v4l2_ctrl_s_ctrl(imx219->vblank, vts_def - fmt->height);
> +	/* Update max exposure while meeting expected vblanking */
> +	exposure_max = vts_def - 4;
> +	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
> +			       exposure_max :
> +			       IMX219_EXPOSURE_DEFAULT;
> +	__v4l2_ctrl_modify_range(imx219->exposure, imx219->exposure->minimum,
> +				 exposure_max, imx219->exposure->step,
> +				 exposure_def);
> +	/*
> +	 * Currently PPL is fixed to IMX219_PPL_DEFAULT, so hblank
> +	 * depends on mode->width only, and is not changeble in any
> +	 * way other than changing the mode.
> +	 */
> +	hblank = IMX219_PPL_DEFAULT - fmt->width;
> +	__v4l2_ctrl_modify_range(imx219->hblank, hblank, hblank, 1, hblank);
> +}
> +
>  static int imx219_set_pad_format(struct v4l2_subdev *sd,
>  				 struct v4l2_subdev_state *state,
>  				 struct v4l2_subdev_format *fmt)
> @@ -816,7 +854,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
>  	struct imx219 *imx219 = to_imx219(sd);
>  	const struct imx219_mode *mode;
>  	struct v4l2_mbus_framefmt *format;
> -	struct v4l2_rect *crop;
> +	struct v4l2_rect *crop, *compose;
>  	unsigned int bin_h, bin_v;
>  
>  	mode = v4l2_find_nearest_size(supported_modes,
> @@ -842,34 +880,14 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
>  	crop->left = (IMX219_NATIVE_WIDTH - crop->width) / 2;
>  	crop->top = (IMX219_NATIVE_HEIGHT - crop->height) / 2;
>  
> -	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
> -		int exposure_max;
> -		int exposure_def;
> -		int hblank;
> -
> -		/* Update limits and set FPS to default */
> -		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
> -					 IMX219_VTS_MAX - mode->height, 1,
> -					 mode->vts_def - mode->height);
> -		__v4l2_ctrl_s_ctrl(imx219->vblank,
> -				   mode->vts_def - mode->height);
> -		/* Update max exposure while meeting expected vblanking */
> -		exposure_max = mode->vts_def - 4;
> -		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
> -			exposure_max : IMX219_EXPOSURE_DEFAULT;
> -		__v4l2_ctrl_modify_range(imx219->exposure,
> -					 imx219->exposure->minimum,
> -					 exposure_max, imx219->exposure->step,
> -					 exposure_def);
> -		/*
> -		 * Currently PPL is fixed to IMX219_PPL_DEFAULT, so hblank
> -		 * depends on mode->width only, and is not changeble in any
> -		 * way other than changing the mode.
> -		 */
> -		hblank = IMX219_PPL_DEFAULT - mode->width;
> -		__v4l2_ctrl_modify_range(imx219->hblank, hblank, hblank, 1,
> -					 hblank);
> -	}
> +	compose = v4l2_subdev_get_pad_compose(sd, state, 0);
> +	compose->width = format->width;
> +	compose->height = format->height;
> +	compose->left = 0;
> +	compose->top = 0;
> +
> +	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> +		imx219_refresh_ctrls(sd, state, mode->vts_def);
>  
>  	return 0;
>  }
> @@ -884,6 +902,11 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
>  		return 0;
>  	}
>  
> +	case V4L2_SEL_TGT_COMPOSE: {
> +		sel->r = *v4l2_subdev_get_pad_compose(sd, state, 0);
> +		return 0;
> +	}

The braces are unnecessary here.

> +
>  	case V4L2_SEL_TGT_NATIVE_SIZE:
>  		sel->r.top = 0;
>  		sel->r.left = 0;
> @@ -900,11 +923,145 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
>  		sel->r.height = IMX219_PIXEL_ARRAY_HEIGHT;
>  
>  		return 0;
> +
> +	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> +	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> +	case V4L2_SEL_TGT_COMPOSE_PADDED:
> +		sel->r.top = 0;
> +		sel->r.left = 0;
> +		sel->r.width = IMX219_PIXEL_ARRAY_WIDTH;
> +		sel->r.height = IMX219_PIXEL_ARRAY_HEIGHT;
> +		return 0;
>  	}
>  
>  	return -EINVAL;
>  }
>  
> +#define IMX219_ROUND(dim, step, flags)                \
> +	((flags) & V4L2_SEL_FLAG_GE ?                 \
> +		 round_up((dim), (step)) :            \
> +		 ((flags) & V4L2_SEL_FLAG_LE ?        \
> +			  round_down((dim), (step)) : \
> +			  round_down((dim) + (step) / 2, (step))))
> +
> +static int imx219_set_selection_crop(struct v4l2_subdev *sd,
> +				     struct v4l2_subdev_state *sd_state,
> +				     struct v4l2_subdev_selection *sel)
> +{
> +	u32 max_binning;
> +	struct v4l2_rect *compose, *crop;
> +	struct v4l2_mbus_framefmt *fmt;
> +
> +	crop = v4l2_subdev_get_pad_crop(sd, sd_state, 0);
> +	if (v4l2_rect_equal(&sel->r, crop))
> +		return false;
> +	max_binning = binning_ratios[ARRAY_SIZE(binning_ratios) - 1];
> +	sel->r.width =
> +		clamp(IMX219_ROUND(sel->r.width, max_binning, sel->flags),
> +		      max_binning * IMX219_MIN_COMPOSE_SIZE,
> +		      IMX219_PIXEL_ARRAY_WIDTH);
> +	sel->r.height =
> +		clamp(IMX219_ROUND(sel->r.width, max_binning, sel->flags),
> +		      max_binning * IMX219_MIN_COMPOSE_SIZE,
> +		      IMX219_PIXEL_ARRAY_WIDTH);
> +	sel->r.left =
> +		min_t(u32, sel->r.left, IMX219_PIXEL_ARRAY_LEFT - sel->r.width);
> +	sel->r.top =
> +		min_t(u32, sel->r.top, IMX219_PIXEL_ARRAY_TOP - sel->r.top);
> +
> +	compose = v4l2_subdev_get_pad_compose(sd, sd_state, 0);
> +	fmt = v4l2_subdev_get_pad_format(sd, sd_state, 0);
> +	*crop = sel->r;
> +	compose->height = crop->height;
> +	compose->width = crop->width;
> +	return true;
> +}
> +
> +static int imx219_binning_goodness(u32 act, u32 ask, u32 flags)
> +{
> +	const int goodness = 100000;
> +	int val = 0;
> +
> +	if (flags & V4L2_SEL_FLAG_GE)
> +		if (act < ask)
> +			val -= goodness;
> +
> +	if (flags & V4L2_SEL_FLAG_LE)
> +		if (act > ask)
> +			val -= goodness;
> +
> +	val -= abs(act - ask);
> +
> +	return val;
> +}
> +
> +static bool imx219_set_selection_compose(struct v4l2_subdev *sd,
> +					 struct v4l2_subdev_state *state,
> +					 struct v4l2_subdev_selection *sel)
> +{
> +	int best_goodness;

This would be nicer if declared after the line below. Think of reverse
Christmas trees.

Similarly for max_binning a few functions up actually as well as variables
in imx219_refresh_ctrls().

> +	struct v4l2_rect *compose, *crop;
> +
> +	compose = v4l2_subdev_get_pad_compose(sd, state, 0);
> +	if (v4l2_rect_equal(compose, &sel->r))
> +		return false;
> +
> +	crop = v4l2_subdev_get_pad_crop(sd, state, 0);
> +
> +	best_goodness = INT_MIN;
> +	for (int i = 0; i < ARRAY_SIZE(binning_ratios); ++i) {
> +		u32 width = crop->width / binning_ratios[i];
> +		int goodness = imx219_binning_goodness(width, sel->r.width,
> +						       sel->flags);
> +		if (goodness > best_goodness) {
> +			best_goodness = goodness;
> +			compose->width = width;
> +		}
> +	}
> +	best_goodness = INT_MIN;
> +	for (int i = 0; i < ARRAY_SIZE(binning_ratios); ++i) {
> +		u32 height = crop->height / binning_ratios[i];
> +		int goodness = imx219_binning_goodness(height, sel->r.height,
> +						       sel->flags);
> +		if (goodness > best_goodness) {
> +			best_goodness = goodness;
> +			compose->height = height;
> +		}
> +	}
> +	return true;
> +}
> +
> +static int imx219_set_selection(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *sd_state,
> +				struct v4l2_subdev_selection *sel)
> +{
> +	bool compose_updated = false;
> +
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_CROP:
> +		compose_updated = imx219_set_selection_crop(sd, sd_state, sel);
> +		break;
> +	case V4L2_SEL_TGT_COMPOSE:
> +		compose_updated =
> +			imx219_set_selection_compose(sd, sd_state, sel);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (compose_updated) {
> +		struct v4l2_rect *compose =
> +			v4l2_subdev_get_pad_compose(sd, sd_state, 0);
> +		struct v4l2_mbus_framefmt *fmt =
> +			v4l2_subdev_get_pad_format(sd, sd_state, 0);

A newline here?

> +		fmt->height = compose->height;
> +		fmt->width = compose->width;
> +	}
> +	if (compose_updated && sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> +		imx219_refresh_ctrls(sd, sd_state, IMX219_VTS_DEF);

Please move this inside the previous condition (where you check just
sel->which).

> +
> +	return 0;
> +}
> +
>  static int imx219_init_cfg(struct v4l2_subdev *sd,
>  			   struct v4l2_subdev_state *state)
>  {
> @@ -938,6 +1095,7 @@ static const struct v4l2_subdev_pad_ops imx219_pad_ops = {
>  	.get_fmt = v4l2_subdev_get_fmt,
>  	.set_fmt = imx219_set_pad_format,
>  	.get_selection = imx219_get_selection,
> +	.set_selection = imx219_set_selection,
>  	.enum_frame_size = imx219_enum_frame_size,
>  };
>  

-- 
Regards,

Sakari Ailus

