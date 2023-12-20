Return-Path: <linux-kernel+bounces-6627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E487819B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909BE1C25865
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A41D6BD;
	Wed, 20 Dec 2023 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OI5fJg83"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5E1F5E4;
	Wed, 20 Dec 2023 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 81B21833;
	Wed, 20 Dec 2023 10:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1703063596;
	bh=p9GLRQLlY6yf4G6YGMhseTCkjNgnEd20sEeQCJ72atQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OI5fJg83fKZRts6I1ruoefT0QilxtkYBgOWSeFMu1GxfG/ZYJldI5xMNMsd9LHIZX
	 aGscHnTyE883RzkDsqzfhoAZ4Ir67Ex8MOlZRi6Xp0N0tfYTYGDdYp2ntGKR5AV/BF
	 72wOZy5/ZOCvniEWQDzSlF/Kp7pS8zOxfZAt7LUI=
Date: Wed, 20 Dec 2023 11:14:13 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] media: i2c: alvium: inline set_frame_interval
 into s_frame_interval
Message-ID: <20231220091413.GH29638@pendragon.ideasonboard.com>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
 <20231220085609.2595732-4-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231220085609.2595732-4-tomm.merciai@gmail.com>

Hi Tommaso,

Thank you for the patch.

On Wed, Dec 20, 2023 at 09:56:08AM +0100, Tommaso Merciai wrote:
> Inline alvium_set_frame_interval() into alvium_s_frame_interval().
> The alvium_set_frame_interval() is called once only, by
> alvium_s_frame_interval(). The latter is a thin wrapper around the
> former. Inline the function in its caller to make the code more
> readable.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
> Changes Since v1:
>  - Now this commit is the 3/4 of the series
>  - Fixed commit body as suggested by LPinchart
> 
>  drivers/media/i2c/alvium-csi2.c | 51 ++++++++++++---------------------
>  1 file changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index a9ff6cc97cff..b234d74454bf 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1660,14 +1660,26 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> -static int alvium_set_frame_interval(struct alvium_dev *alvium,
> -				     struct v4l2_subdev_frame_interval *fi,
> -				     u64 *req_fr)
> +static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> +				   struct v4l2_subdev_state *sd_state,
> +				   struct v4l2_subdev_frame_interval *fi)
>  {
> +	struct alvium_dev *alvium = sd_to_alvium(sd);
>  	struct device *dev = &alvium->i2c_client->dev;
> +	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;

No need to initialize the variable. With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	u64 dft_fr, min_fr, max_fr;
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
> @@ -1682,41 +1694,16 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
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
> -	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
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
> -	ret = alvium_set_frame_interval(alvium, fi, &req_fr);
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

