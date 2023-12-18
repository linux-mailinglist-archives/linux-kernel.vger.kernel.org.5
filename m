Return-Path: <linux-kernel+bounces-2953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C55816526
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66411C220D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A52F28;
	Mon, 18 Dec 2023 02:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PGfbsqdv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE623D2;
	Mon, 18 Dec 2023 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 34F051583;
	Mon, 18 Dec 2023 03:58:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702868290;
	bh=qeu/tfk9LDcRaYbt+aO9v6RG30BOvhvYl3/zHx9lKkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGfbsqdvcvNvJwnUaue6AIkvyu6zrLtFzsrAcV2FCxLXkMvbU26lrC7H6cySXIlUo
	 pJh3lrstp0wvki8Atmpf0w4tCfGfwfP7fLMDynr9ZEQMNIPxfkgIL6RBBeMDjv1SSS
	 3shBeU/rt+uWN9dGbzI/LwD3Dx2/D7YYTlSrHTTw=
Date: Mon, 18 Dec 2023 04:59:05 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] media: i2c: alvium: store frame interval in subdev
 state
Message-ID: <20231218025905.GJ5290@pendragon.ideasonboard.com>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
 <20231215082452.1720481-4-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231215082452.1720481-4-tomm.merciai@gmail.com>

Hi Tommaso,

Thank you for the patch.

On Fri, Dec 15, 2023 at 09:24:52AM +0100, Tommaso Merciai wrote:
> Use the newly added storage for frame interval in the subdev state to
> simplify the driver.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/media/i2c/alvium-csi2.c | 40 ++++++++++-----------------------
>  drivers/media/i2c/alvium-csi2.h |  2 --
>  2 files changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index fde456357be1..81f683b3c849 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1643,25 +1643,6 @@ static int alvium_hw_init(struct alvium_dev *alvium)
>  }
>  
>  /* --------------- Subdev Operations --------------- */
> -
> -static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> -				   struct v4l2_subdev_state *sd_state,
> -				   struct v4l2_subdev_frame_interval *fi)
> -{
> -	struct alvium_dev *alvium = sd_to_alvium(sd);
> -
> -	/*
> -	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> -	 * subdev active state API.
> -	 */
> -	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> -		return -EINVAL;
> -
> -	fi->interval = alvium->frame_interval;
> -
> -	return 0;
> -}
> -
>  static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  				   struct v4l2_subdev_state *sd_state,
>  				   struct v4l2_subdev_frame_interval *fi)
> @@ -1669,6 +1650,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  	struct alvium_dev *alvium = sd_to_alvium(sd);
>  	struct device *dev = &alvium->i2c_client->dev;
>  	u64 req_fr, dft_fr, min_fr, max_fr;
> +	struct v4l2_fract *interval;
>  	int ret;
>  
>  	/*

You should drop the FIXME comment here and the ACTIVE check...

> @@ -1701,9 +1683,10 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  	if (req_fr >= max_fr && req_fr <= min_fr)
>  		req_fr = dft_fr;
>  
> -	alvium->fr = req_fr;
> -	alvium->frame_interval.numerator = fi->interval.numerator;
> -	alvium->frame_interval.denominator = fi->interval.denominator;
> +	interval = v4l2_subdev_state_get_interval(sd_state, 0);
> +
> +	interval->numerator = fi->interval.numerator;
> +	interval->denominator = fi->interval.denominator;
>  


... and here only call alvium_set_frame_rate() for the ACTIVE frame
interval.

>  	return alvium_set_frame_rate(alvium, req_fr);
>  }
> @@ -1853,6 +1836,7 @@ static int alvium_init_state(struct v4l2_subdev *sd,
>  {
>  	struct alvium_dev *alvium = sd_to_alvium(sd);
>  	struct alvium_mode *mode = &alvium->mode;
> +	struct v4l2_fract *interval;
>  	struct v4l2_subdev_format sd_fmt = {
>  		.which = V4L2_SUBDEV_FORMAT_TRY,
>  		.format = alvium_csi2_default_fmt,
> @@ -1870,6 +1854,11 @@ static int alvium_init_state(struct v4l2_subdev *sd,
>  	*v4l2_subdev_state_get_crop(state, 0) = sd_crop.rect;
>  	*v4l2_subdev_state_get_format(state, 0) = sd_fmt.format;
>  
> +	/* Setup initial frame interval*/
> +	interval = v4l2_subdev_state_get_interval(state, 0);
> +	interval->numerator = 1;
> +	interval->denominator = ALVIUM_DEFAULT_FR_HZ;
> +
>  	return 0;
>  }
>  
> @@ -2239,7 +2228,7 @@ static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
>  	.set_fmt = alvium_set_fmt,
>  	.get_selection = alvium_get_selection,
>  	.set_selection = alvium_set_selection,
> -	.get_frame_interval = alvium_g_frame_interval,
> +	.get_frame_interval = v4l2_subdev_get_frame_interval,
>  	.set_frame_interval = alvium_s_frame_interval,
>  };
>  
> @@ -2260,11 +2249,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
>  	struct v4l2_subdev *sd = &alvium->sd;
>  	int ret;
>  
> -	/* Setup initial frame interval*/
> -	alvium->frame_interval.numerator = 1;
> -	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> -	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> -
>  	/* Setup the initial mode */
>  	alvium->mode.fmt = alvium_csi2_default_fmt;
>  	alvium->mode.width = alvium_csi2_default_fmt.width;
> diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> index a6529b28e7dd..f5e26257b042 100644
> --- a/drivers/media/i2c/alvium-csi2.h
> +++ b/drivers/media/i2c/alvium-csi2.h
> @@ -442,8 +442,6 @@ struct alvium_dev {
>  	s32 inc_sharp;
>  
>  	struct alvium_mode mode;
> -	struct v4l2_fract frame_interval;
> -	u64 fr;

The fr field should have been removed by a previous patch (the one that
will go between 1/3 an 2/3, see my review of 1/3) as shown by the fact
that this patch only removes two locations where the field is set but
none where it's read.

>  
>  	u8 h_sup_csi_lanes;
>  	u64 link_freq;

-- 
Regards,

Laurent Pinchart

