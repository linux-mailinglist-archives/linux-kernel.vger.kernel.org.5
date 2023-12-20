Return-Path: <linux-kernel+bounces-6620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD70819B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067061F25E03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458361D6AB;
	Wed, 20 Dec 2023 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D//bHVR6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D111CFAD;
	Wed, 20 Dec 2023 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 74441833;
	Wed, 20 Dec 2023 10:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1703063243;
	bh=2eZY8RgaVUNw5VVbrAFpmMJDkj7arLe26QC8zLFhMMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D//bHVR6oH1vYCzeD/iXlTjrrxHuZNiW7ix7xQuvtCxncYoZelWIcLNJUp22Tt63A
	 8cq1yJg62cprOHpvDCbEP6CIp0c1x8E4z89qsktVyQLtCQ07b1F6LBKHvGzQTjFae4
	 /2xaoc5dORrp8/NOTketpObOY/Hu2uTZe2Y69mwk=
Date: Wed, 20 Dec 2023 11:08:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] media: i2c: alvium: removal of dft_fr, min_fr and
 max_fr
Message-ID: <20231220090820.GF29638@pendragon.ideasonboard.com>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
 <20231220085609.2595732-2-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231220085609.2595732-2-tomm.merciai@gmail.com>

Hi Tommaso,

Thank you for the patch.

On Wed, Dec 20, 2023 at 09:56:06AM +0100, Tommaso Merciai wrote:
> The dft_fr, min_fr and max_fr fields of the alvium_dev structure are
> only used to pass results from alvium_get_frame_interval() to its
> caller. Replace them with function parameters.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes Since v1:
>  - Fixed commit body as suggested by LPinchart
>  - Fixed alvium_get_frame_interval just return ret as suggested by LPinchart
>  - Removed unrelated chnages from the commit as suggested by LPinchart
> 
>  drivers/media/i2c/alvium-csi2.c | 27 +++++++++------------------
>  drivers/media/i2c/alvium-csi2.h |  3 ---
>  2 files changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index 34ff7fad3877..0dcd69bf9f92 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1170,25 +1170,19 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
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
> -	if (ret)
> -		return ret;
> -
> -	alvium->dft_fr = dft_fr;
> -	alvium->min_fr = min_fr;
> -	alvium->max_fr = max_fr;
> +		    max_fr, &ret);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int alvium_set_frame_rate(struct alvium_dev *alvium)
> @@ -1670,21 +1664,18 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
>  				     struct v4l2_subdev_frame_interval *fi)
>  {
>  	struct device *dev = &alvium->i2c_client->dev;
> -	u64 req_fr, min_fr, max_fr;
> +	u64 req_fr, dft_fr, min_fr, max_fr;
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
> @@ -1694,7 +1685,7 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
>  		       fi->interval.numerator);
>  
>  	if (req_fr >= max_fr && req_fr <= min_fr)
> -		req_fr = alvium->dft_fr;
> +		req_fr = dft_fr;
>  
>  	alvium->fr = req_fr;
>  	alvium->frame_interval.numerator = fi->interval.numerator;
> diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> index b85a25169e79..17f0bbbd1839 100644
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

