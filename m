Return-Path: <linux-kernel+bounces-78248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AA8610C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348E5286DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E697AE5A;
	Fri, 23 Feb 2024 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WoI1QGtb"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D2D29B;
	Fri, 23 Feb 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688929; cv=none; b=B3X/u2R9Z7kwrW+rhu8uDIS6P1Hg5wDGnmmCb8AY2p8W+jc+cGDREO065JhwX0DzL8Uinti5fNlZrCW5fSyXMaQbBz+bRtam3hUzXufSYe3f7hycVOfU5TDqbUbIndGX1H6qvtbqX5lWqsnmgrTTy/F0yk5hiVUFl/7AOKDhjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688929; c=relaxed/simple;
	bh=bWXU1JOJOzHsStAX81T5OTAuXcnBcBLeIwRKasby7p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR0kKYGaCI1qRdwoasQ7cn5X/DHVVvvb1ejbslufthw10bfedAldmZN9c4nW9KVLmWhL0k8kKeuoZULy1hBEJDkfYW3nBuGT2OUTV6jZBBmmRwdeQN9NPM+dlAG8uetYVQtwkO+jFLXSnVO1IQHI4UsfAUTHiWKSDOYfzRZKyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WoI1QGtb; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E9D872E7;
	Fri, 23 Feb 2024 12:48:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708688917;
	bh=bWXU1JOJOzHsStAX81T5OTAuXcnBcBLeIwRKasby7p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoI1QGtbFy8UgiimLlRY0M15+GZS+Ei9nWBH3ZJNQBGfFB756JpG6VCISJX3tosSK
	 OBcwCzQu0rD6jxnXzYP/53w8HLa4PJN7v8zyxo63bemRty7gNnn61gP+Mg7FCfIIVF
	 /ji6ZA1YXVVG4yXqXtROhrrBY8QsOFMzI5GA0qe4=
Date: Fri, 23 Feb 2024 13:48:49 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 19/20] media: i2c: ov4689: Refactor ov4689_s_stream
Message-ID: <20240223114849.GU31348@pendragon.ideasonboard.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-20-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-20-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 18, 2023 at 08:40:40PM +0300, Mikhail Rudenko wrote:
> Remove repetitive pm_runtime_put calls in ov4689_s_stream function,
> and call pm_runtime_put once at the end of the "on" branch if any
> error occurred.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index e997c3231e85..884761d02119 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -555,35 +555,26 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  					  ov4689_common_regs,
>  					  ARRAY_SIZE(ov4689_common_regs),
>  					  NULL);
> -		if (ret) {
> -			pm_runtime_put_sync(dev);
> -			goto unlock_and_return;
> -		}
> +		if (ret)
> +			goto cleanup_pm;
>  
>  		ret = ov4689_setup_timings(ov4689, sd_state);
> -		if (ret) {
> -			pm_runtime_put(dev);
> -			goto unlock_and_return;
> -		}
> +		if (ret)
> +			goto cleanup_pm;
>  
>  		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
> -		if (ret) {
> -			pm_runtime_put(dev);
> -			goto unlock_and_return;
> -		}
> +		if (ret)
> +			goto cleanup_pm;
>  
>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
> -		if (ret) {
> -			pm_runtime_put_sync(dev);
> -			goto unlock_and_return;
> -		}
> +		if (ret)
> +			goto cleanup_pm;
>  
>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>  				OV4689_MODE_STREAMING, NULL);
> -		if (ret) {
> +cleanup_pm:

A label within an if branch isn't great, readability-wise :-S Could we
maybe split the ov4687_s_stream() function in two (streamon and
streamoff, or similar names) ? You would then have a single
pm_runtime_put_sync() call in ov4689_s_stream(), in the error handling
path for the streamon function call.

> +		if (ret)
>  			pm_runtime_put_sync(dev);
> -			goto unlock_and_return;
> -		}
>  	} else {
>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>  			  OV4689_MODE_SW_STANDBY, NULL);

-- 
Regards,

Laurent Pinchart

