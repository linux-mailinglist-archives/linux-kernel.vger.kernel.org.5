Return-Path: <linux-kernel+bounces-6630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222B3819B36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFCA2869B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF64E1DA33;
	Wed, 20 Dec 2023 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RKHv31ZA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7441D6A4;
	Wed, 20 Dec 2023 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A6C60833;
	Wed, 20 Dec 2023 10:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1703063816;
	bh=QoOeBEq5AG05SFHV7I02yeoD7xD2eMaxvQQnwvSi9HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKHv31ZA0SaLym86vQ3D3HYupv3qevo+Fwz5zZoDmmN0IZ72GaQrsSx/v//oVzs5+
	 1F6q5dTU00dKJ5CtBCOeAJpf1tHqiyd9lZnK+iW51aobtQzJZfYLBDIZ2UfefwdUOI
	 MTD+WHhPX01gLsY3s2GVUfYn5NBYAZYe6W/M3V5E=
Date: Wed, 20 Dec 2023 11:17:53 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] media: i2c: alvium: store frame interval in
 subdev state
Message-ID: <20231220091753.GI29638@pendragon.ideasonboard.com>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
 <20231220085609.2595732-5-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231220085609.2595732-5-tomm.merciai@gmail.com>

Hi Tommaso,

Thank you for the patch.

On Wed, Dec 20, 2023 at 09:56:09AM +0100, Tommaso Merciai wrote:
> Use the newly added storage for frame interval in the subdev state to
> simplify the driver.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes Since v1:
>  - Removed FIXME comment and active state check into alvium_s_frame_interval
>    as suggested by LPinchart.
>  - Fixed call alvium_set_frame_rate() only for active state into alvium_s_frame_interval
>    as suggested by LPinchart.
> 
>  drivers/media/i2c/alvium-csi2.c | 51 +++++++++++----------------------
>  drivers/media/i2c/alvium-csi2.h |  1 -
>  2 files changed, 16 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index b234d74454bf..240bf991105e 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1641,42 +1641,16 @@ static int alvium_hw_init(struct alvium_dev *alvium)
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
>  {
>  	struct alvium_dev *alvium = sd_to_alvium(sd);
>  	struct device *dev = &alvium->i2c_client->dev;
> -	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
> -	u64 dft_fr, min_fr, max_fr;
> +	u64 req_fr, dft_fr, min_fr, max_fr;
> +	struct v4l2_fract *interval;
>  	int ret;
>  
> -	/*
> -	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> -	 * subdev active state API.
> -	 */
> -	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> -		return -EINVAL;
> -
>  	if (alvium->streaming)
>  		return -EBUSY;
>  
> @@ -1700,8 +1674,13 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  	if (req_fr >= max_fr && req_fr <= min_fr)
>  		req_fr = dft_fr;
>  
> -	alvium->frame_interval.numerator = fi->interval.numerator;
> -	alvium->frame_interval.denominator = fi->interval.denominator;
> +	interval = v4l2_subdev_state_get_interval(sd_state, 0);
> +
> +	interval->numerator = fi->interval.numerator;
> +	interval->denominator = fi->interval.denominator;
> +
> +	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> +		return 0;
>  
>  	return alvium_set_frame_rate(alvium, req_fr);
>  }
> @@ -1851,6 +1830,7 @@ static int alvium_init_state(struct v4l2_subdev *sd,
>  {
>  	struct alvium_dev *alvium = sd_to_alvium(sd);
>  	struct alvium_mode *mode = &alvium->mode;
> +	struct v4l2_fract *interval;
>  	struct v4l2_subdev_format sd_fmt = {
>  		.which = V4L2_SUBDEV_FORMAT_TRY,
>  		.format = alvium_csi2_default_fmt,
> @@ -1868,6 +1848,11 @@ static int alvium_init_state(struct v4l2_subdev *sd,
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
> @@ -2237,7 +2222,7 @@ static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
>  	.set_fmt = alvium_set_fmt,
>  	.get_selection = alvium_get_selection,
>  	.set_selection = alvium_set_selection,
> -	.get_frame_interval = alvium_g_frame_interval,
> +	.get_frame_interval = v4l2_subdev_get_frame_interval,
>  	.set_frame_interval = alvium_s_frame_interval,
>  };
>  
> @@ -2258,10 +2243,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
>  	struct v4l2_subdev *sd = &alvium->sd;
>  	int ret;
>  
> -	/* Setup initial frame interval*/
> -	alvium->frame_interval.numerator = 1;
> -	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> -
>  	/* Setup the initial mode */
>  	alvium->mode.fmt = alvium_csi2_default_fmt;
>  	alvium->mode.width = alvium_csi2_default_fmt.width;
> diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> index 80066ac25047..9463f8604fbc 100644
> --- a/drivers/media/i2c/alvium-csi2.h
> +++ b/drivers/media/i2c/alvium-csi2.h
> @@ -442,7 +442,6 @@ struct alvium_dev {
>  	s32 inc_sharp;
>  
>  	struct alvium_mode mode;
> -	struct v4l2_fract frame_interval;
>  
>  	u8 h_sup_csi_lanes;
>  	u64 link_freq;

-- 
Regards,

Laurent Pinchart

