Return-Path: <linux-kernel+bounces-2952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAF2816523
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C81282245
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1473C23;
	Mon, 18 Dec 2023 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LQjAHFOH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A823D2;
	Mon, 18 Dec 2023 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DAD61583;
	Mon, 18 Dec 2023 03:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702868052;
	bh=fiwZrG0T9sm/2CKYqD2obhFOcr3rZBVGF+gFHJSGlss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQjAHFOHai+aWXYmJC6H6L0URkTdav4Xiz/2kZfChChPycbPtycJ+RYiZCF3ek+kM
	 ZTVUBCGjAvnD4yOjd/GQGfi58AxHlWrbhpQKJkzp/KkxPqhPpEjhMWPtFOB/VGSWOq
	 Z/ihrHQwdnwYi/MsbSwk/sZD4R1CsUuwfhn7hzGo=
Date: Mon, 18 Dec 2023 04:55:07 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: i2c: alvium: inline set_frame_interval into
 s_frame_interval
Message-ID: <20231218025507.GI5290@pendragon.ideasonboard.com>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
 <20231215082452.1720481-3-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231215082452.1720481-3-tomm.merciai@gmail.com>

Hi Tommaso,

Thank you for the patch.

On Fri, Dec 15, 2023 at 09:24:51AM +0100, Tommaso Merciai wrote:
> Inline alvium_s_frame_interval function into alvium_s_frame_interval.

I think you mean "alvium_set_frame_interval() function into
alvium_s_frame_interval.()"

> This to clean the driver code.

You can describe the reason more precisely:

The alvium_set_frame_interval() is called once only, by
alvium_s_frame_interval(). The latter is a thin wrapper around the
former. Inline the function in its caller to make the code more
readable.

The rest looks good to me.

> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/media/i2c/alvium-csi2.c | 56 ++++++++++++---------------------
>  1 file changed, 20 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index c4b7851045a1..fde456357be1 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1662,16 +1662,25 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> -static int alvium_set_frame_interval(struct alvium_dev *alvium,
> -				     struct v4l2_subdev *sd,
> -				     struct v4l2_subdev_state *sd_state,
> -				     struct v4l2_subdev_frame_interval *fi,
> -				     u64 *req_fr)
> +static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> +				   struct v4l2_subdev_state *sd_state,
> +				   struct v4l2_subdev_frame_interval *fi)
>  {
> +	struct alvium_dev *alvium = sd_to_alvium(sd);
>  	struct device *dev = &alvium->i2c_client->dev;
> -	u64 dft_fr, min_fr, max_fr;
> +	u64 req_fr, dft_fr, min_fr, max_fr;
>  	int ret;
>  
> +	/*
> +	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> +	 * subdev active state API.
> +	 */
> +	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> +		return -EINVAL;
> +
> +	if (alvium->streaming)
> +		return -EBUSY;
> +
>  	if (fi->interval.denominator == 0)
>  		return -EINVAL;
>  
> @@ -1686,42 +1695,17 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
>  	dev_dbg(dev, "fi->interval.denominator = %d\n",
>  		fi->interval.denominator);
>  
> -	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> +	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
>  		       fi->interval.numerator);
>  
> -	if (*req_fr >= max_fr && *req_fr <= min_fr)
> -		*req_fr = dft_fr;
> +	if (req_fr >= max_fr && req_fr <= min_fr)
> +		req_fr = dft_fr;
>  
> -	alvium->fr = *req_fr;
> +	alvium->fr = req_fr;
>  	alvium->frame_interval.numerator = fi->interval.numerator;
>  	alvium->frame_interval.denominator = fi->interval.denominator;
>  
> -	return 0;
> -}
> -
> -static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> -				   struct v4l2_subdev_state *sd_state,
> -				   struct v4l2_subdev_frame_interval *fi)
> -{
> -	struct alvium_dev *alvium = sd_to_alvium(sd);
> -	u64 req_fr;
> -	int ret;
> -
> -	/*
> -	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> -	 * subdev active state API.
> -	 */
> -	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> -		return -EINVAL;
> -
> -	if (alvium->streaming)
> -		return -EBUSY;
> -
> -	ret = alvium_set_frame_interval(alvium, sd, sd_state, fi, &req_fr);
> -	if (!ret)
> -		ret = alvium_set_frame_rate(alvium, req_fr);
> -
> -	return ret;
> +	return alvium_set_frame_rate(alvium, req_fr);
>  }
>  
>  static int alvium_enum_mbus_code(struct v4l2_subdev *sd,

-- 
Regards,

Laurent Pinchart

