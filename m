Return-Path: <linux-kernel+bounces-2946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3D81650E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E55281AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972482F4A;
	Mon, 18 Dec 2023 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q/P1wkyU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CE5238;
	Mon, 18 Dec 2023 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9CD11583;
	Mon, 18 Dec 2023 03:49:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702867789;
	bh=kAjfKX0BWMBTowti17qTSb6dTKjTkYpWap0QOJvxxgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/P1wkyUPgR+EY9tRz3uDkV2GItpL/j1dfhB+M4ED3RiN0I3EvrSArBwWjtVf7ibK
	 TJ0pa3B4IGUQpPG5v+gYXRek4zVjFImLE5fIG9YeIFx1EU72TPpy1eKXzT+8/sDBaK
	 8UAAxRRtaamUYS2Px9nqKOcKaiQVIhamKWQYoK7c=
Date: Mon, 18 Dec 2023 04:50:44 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] media: i2c: alvium: removal of dft_fr, min_fr and
 max_fr
Message-ID: <20231218025044.GH5290@pendragon.ideasonboard.com>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
 <20231215082452.1720481-2-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231215082452.1720481-2-tomm.merciai@gmail.com>

Hi Tommaso,

Thank you for the patch.

On Fri, Dec 15, 2023 at 09:24:50AM +0100, Tommaso Merciai wrote:
> Remove driver private data dft_fr, min_fr and max_fr.
> Those are used only in alvium_set_frame_interval function.
> Use local ones instead.

The fields are used to pass data from alvium_get_frame_interval() to its
caller, not just in alvium_get_frame_interval(). You can write

The dft_fr, min_fr and max_fr fields of the alvium_dev structure are
only used to pass results from alvium_get_frame_interval() to its
caller. Replace them with function parameters.

> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/media/i2c/alvium-csi2.c | 45 +++++++++++++++------------------
>  drivers/media/i2c/alvium-csi2.h |  3 ---
>  2 files changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index 34ff7fad3877..c4b7851045a1 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1170,40 +1170,36 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
>  	return 0;
>  }
>  
> -static int alvium_get_frame_interval(struct alvium_dev *alvium)
> +static int alvium_get_frame_interval(struct alvium_dev *alvium,
> +				     u64 *dft_fr, u64 *min_fr, u64 *max_fr)
>  {
> -	u64 dft_fr, min_fr, max_fr;
>  	int ret = 0;
>  
>  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> -		    &dft_fr, &ret);
> +		    dft_fr, &ret);
>  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
> -		    &min_fr, &ret);
> +		    min_fr, &ret);
>  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
> -		    &max_fr, &ret);
> +		    max_fr, &ret);
>  	if (ret)
>  		return ret;

You can just

	return ret;

>  
> -	alvium->dft_fr = dft_fr;
> -	alvium->min_fr = min_fr;
> -	alvium->max_fr = max_fr;
> -
>  	return 0;
>  }
>  
> -static int alvium_set_frame_rate(struct alvium_dev *alvium)
> +static int alvium_set_frame_rate(struct alvium_dev *alvium, u64 fr)
>  {
>  	struct device *dev = &alvium->i2c_client->dev;
>  	int ret;
>  
>  	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> -				  alvium->fr);
> +				  fr);

This is unrelated to the commit message. Please split handling of the fr
field to a separate patch. One change, one patch.

>  	if (ret) {
>  		dev_err(dev, "Fail to set frame rate lanes reg\n");
>  		return ret;
>  	}
>  
> -	dev_dbg(dev, "set frame rate: %llu us\n", alvium->fr);
> +	dev_dbg(dev, "set frame rate: %llu us\n", fr);
>  
>  	return 0;
>  }
> @@ -1667,36 +1663,36 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
>  }
>  
>  static int alvium_set_frame_interval(struct alvium_dev *alvium,
> -				     struct v4l2_subdev_frame_interval *fi)
> +				     struct v4l2_subdev *sd,
> +				     struct v4l2_subdev_state *sd_state,
> +				     struct v4l2_subdev_frame_interval *fi,
> +				     u64 *req_fr)
>  {
>  	struct device *dev = &alvium->i2c_client->dev;
> -	u64 req_fr, min_fr, max_fr;
> +	u64 dft_fr, min_fr, max_fr;
>  	int ret;
>  
>  	if (fi->interval.denominator == 0)
>  		return -EINVAL;
>  
> -	ret = alvium_get_frame_interval(alvium);
> +	ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
>  	if (ret) {
>  		dev_err(dev, "Fail to get frame interval\n");
>  		return ret;
>  	}
>  
> -	min_fr = alvium->min_fr;
> -	max_fr = alvium->max_fr;
> -
>  	dev_dbg(dev, "fi->interval.numerator = %d\n",
>  		fi->interval.numerator);
>  	dev_dbg(dev, "fi->interval.denominator = %d\n",
>  		fi->interval.denominator);
>  
> -	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> +	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
>  		       fi->interval.numerator);
>  
> -	if (req_fr >= max_fr && req_fr <= min_fr)
> -		req_fr = alvium->dft_fr;
> +	if (*req_fr >= max_fr && *req_fr <= min_fr)
> +		*req_fr = dft_fr;
>  
> -	alvium->fr = req_fr;
> +	alvium->fr = *req_fr;
>  	alvium->frame_interval.numerator = fi->interval.numerator;
>  	alvium->frame_interval.denominator = fi->interval.denominator;
>  
> @@ -1708,6 +1704,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  				   struct v4l2_subdev_frame_interval *fi)
>  {
>  	struct alvium_dev *alvium = sd_to_alvium(sd);
> +	u64 req_fr;
>  	int ret;
>  
>  	/*
> @@ -1720,9 +1717,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  	if (alvium->streaming)
>  		return -EBUSY;
>  
> -	ret = alvium_set_frame_interval(alvium, fi);
> +	ret = alvium_set_frame_interval(alvium, sd, sd_state, fi, &req_fr);
>  	if (!ret)
> -		ret = alvium_set_frame_rate(alvium);
> +		ret = alvium_set_frame_rate(alvium, req_fr);
>  
>  	return ret;
>  }
> diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> index 8b554bffdc39..a6529b28e7dd 100644
> --- a/drivers/media/i2c/alvium-csi2.h
> +++ b/drivers/media/i2c/alvium-csi2.h
> @@ -443,9 +443,6 @@ struct alvium_dev {
>  
>  	struct alvium_mode mode;
>  	struct v4l2_fract frame_interval;
> -	u64 dft_fr;
> -	u64 min_fr;
> -	u64 max_fr;
>  	u64 fr;
>  
>  	u8 h_sup_csi_lanes;

-- 
Regards,

Laurent Pinchart

