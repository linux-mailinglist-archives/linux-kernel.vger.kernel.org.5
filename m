Return-Path: <linux-kernel+bounces-78222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14786106E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A63B240BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B788278B79;
	Fri, 23 Feb 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JAFl2++A"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E385C617;
	Fri, 23 Feb 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687980; cv=none; b=aOCMIaghWUf3KdtrFX8WG3edf/+x3GX/YLHinylkOY/wJ3o1lwHKClalSUIfATwMCjHxIl7Cxbjo2JKP8QxkRTRnI7CL6lDJK8ZhpjmDwWqD52ahTV1XY66hjQHMlV4l56Kk80jvijW6IJZtV5DzY3KmcC+ZEiKmuPCSw5InSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687980; c=relaxed/simple;
	bh=E8Lif2LsYWgiOStX5/WWdENwxJ97hdnhRuKU+qaBHOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT2J2dokhVupKpJ95cVplqWrgsJ8EdYva2DOEEdGWhczD0isTT7xy3u6KYMntOSBme3RN7HR3F/17F7k7NVp37RNbogY+pisiiVGDsCA4bbtGNuzMa5ZPhrTTqtXezAuSSXFTTanwF6lvPHlVqVjyzNYq/7TLIEDrkan8t4AxKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JAFl2++A; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE6AB2E7;
	Fri, 23 Feb 2024 12:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708687967;
	bh=E8Lif2LsYWgiOStX5/WWdENwxJ97hdnhRuKU+qaBHOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAFl2++A1kGB6XVk/sFWGm3mgoo/++iReBl/1hHrZhmv5NI3dPruCIf4GYYnRniSa
	 BZaPGHKugaisoDI6kbUoxPucSzRRQWt1qxe0UJCObuN0s9+j2j6i6vSgNthjI2QK4v
	 X8f6iP6UHSVIm4plcP0bKVrs223m89CC6sy5NA7M=
Date: Fri, 23 Feb 2024 13:33:00 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 15/20] media: i2c: ov4689: Move pixel array size out
 of struct ov4689_mode
Message-ID: <20240223113300.GS31348@pendragon.ideasonboard.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-16-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-16-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 18, 2023 at 08:40:36PM +0300, Mikhail Rudenko wrote:
> Pixel array dimensions and default crop size do not belong to the
> ov4689_mode structure, since they are mode independent. Make them
> defines instead.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index b43fb1d7b15f..475508559e3e 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -70,6 +70,11 @@
>  #define OV4689_LANES			4
>  #define OV4689_XVCLK_FREQ		24000000
>  
> +#define OV4689_PIXEL_ARRAY_WIDTH	2720
> +#define OV4689_PIXEL_ARRAY_HEIGHT	1536
> +#define OV4689_DUMMY_ROWS		8
> +#define OV4689_DUMMY_COLUMNS		16

Adding a comment here to indicate that there are dummy columns in each
side would be useful:

#define OV4689_DUMMY_ROWS		8	/* 8 dummy rows on each side */
#define OV4689_DUMMY_COLUMNS		16	/* 16 dummy columns on each side */

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
>  static const char *const ov4689_supply_names[] = {
>  	"avdd", /* Analog power */
>  	"dovdd", /* Digital I/O power */
> @@ -90,10 +95,6 @@ struct ov4689_mode {
>  	u32 vts_def;
>  	u32 exp_def;
>  	u32 pixel_rate;
> -	u32 sensor_width;
> -	u32 sensor_height;
> -	u32 crop_top;
> -	u32 crop_left;
>  	const struct cci_reg_sequence *reg_list;
>  	unsigned int num_regs;
>  };
> @@ -254,10 +255,6 @@ static const struct ov4689_mode supported_modes[] = {
>  		.id = OV4689_MODE_2688_1520,
>  		.width = 2688,
>  		.height = 1520,
> -		.sensor_width = 2720,
> -		.sensor_height = 1536,
> -		.crop_top = 8,
> -		.crop_left = 16,
>  		.exp_def = 1536,
>  		.hts_def = 10296,
>  		.hts_min = 3432,
> @@ -385,8 +382,6 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>  				struct v4l2_subdev_state *state,
>  				struct v4l2_subdev_selection *sel)
>  {
> -	const struct ov4689_mode *mode = to_ov4689(sd)->cur_mode;
> -
>  	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
>  		return -EINVAL;
>  
> @@ -394,15 +389,17 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>  	case V4L2_SEL_TGT_CROP_BOUNDS:
>  		sel->r.top = 0;
>  		sel->r.left = 0;
> -		sel->r.width = mode->sensor_width;
> -		sel->r.height = mode->sensor_height;
> +		sel->r.width = OV4689_PIXEL_ARRAY_WIDTH;
> +		sel->r.height = OV4689_PIXEL_ARRAY_HEIGHT;
>  		return 0;
>  	case V4L2_SEL_TGT_CROP:
>  	case V4L2_SEL_TGT_CROP_DEFAULT:
> -		sel->r.top = mode->crop_top;
> -		sel->r.left = mode->crop_left;
> -		sel->r.width = mode->width;
> -		sel->r.height = mode->height;
> +		sel->r.top = OV4689_DUMMY_ROWS;
> +		sel->r.left = OV4689_DUMMY_COLUMNS;
> +		sel->r.width =
> +			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_COLUMNS;
> +		sel->r.height =
> +			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_ROWS;
>  		return 0;
>  	}
>  

-- 
Regards,

Laurent Pinchart

