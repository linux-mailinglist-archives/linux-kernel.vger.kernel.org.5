Return-Path: <linux-kernel+bounces-91251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE889870BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8570B1F22B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96810E57F;
	Mon,  4 Mar 2024 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="djyVpORX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69532DDCB;
	Mon,  4 Mar 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585113; cv=none; b=BvRncvVGnpNtP4jbZ9cuCRhIhqD2zt0B2eTVfJgZ01864ETWh/fW0snQG8D5KoE2v22UrYNiPm04jBzM2ZQQTYezNB2o629zNb9R/f9wkMPKbltGhjfWk407ELTqNkPnPNqzftnO6fSFj9w+4tApyw2O5Yabuu8e9sqsSvwizyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585113; c=relaxed/simple;
	bh=LCizBMempHm6m4HVjhOraAYrjK6MVmfuf33LBSbaVvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe9d8d5QuJ1pFMcyBjiTRtAnA4spFzwxNGfdWh1diYJMgE1DSkHsk4lQl1F2kHqvPG9S9PUQOB0sUv6hwlZWGCIe6BPamsvrFqdGjNtkMWflehjXF048oV7BsM8pzSgPTjkFY0SYDQWT0/eZC5/pD4E9BauEGTVpAPZjiwIfjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=djyVpORX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B1D263F;
	Mon,  4 Mar 2024 21:44:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709585092;
	bh=LCizBMempHm6m4HVjhOraAYrjK6MVmfuf33LBSbaVvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djyVpORXEtaGgsprqvnTvw+YD67RM3BJdG24vhcJ144EmzHEEeaDmAUTSSEOO8Ln4
	 RWqgH9tsGSj1tkdcaC0+YXA0fCnl3rSBoJBLDW6ajUf90V6GKW08gzyDaNBV/ZI+rp
	 ZsSWi9YqMe4w7B1Yjg7rVDw0Q6+LrxY/8JH7vh3c=
Date: Mon, 4 Mar 2024 22:45:10 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v3 09/20] media: i2c: ov4689: Use runtime PM autosuspend
Message-ID: <20240304204510.GD9233@pendragon.ideasonboard.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
 <20240229165333.227484-10-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229165333.227484-10-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Thu, Feb 29, 2024 at 07:53:22PM +0300, Mikhail Rudenko wrote:
> Use runtime PM autosuspend to avoid powering off the sensor during
> fast stop-reconfigure-restart cycles.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 0e0e694510aa..2354397ab34c 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -426,7 +426,8 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  	} else {
>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>  			  OV4689_MODE_SW_STANDBY, NULL);
> -		pm_runtime_put(dev);
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
>  	}
>  
>  unlock_and_return:
> @@ -606,7 +607,8 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>  
> -	pm_runtime_put(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -876,8 +878,10 @@ static int ov4689_probe(struct i2c_client *client)
>  	}
>  
>  	pm_runtime_set_active(dev);
> +	pm_runtime_get_noresume(dev);
>  	pm_runtime_enable(dev);
> -	pm_runtime_idle(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
>  
>  	ret = v4l2_async_register_subdev_sensor(sd);
>  	if (ret) {
> @@ -885,11 +889,14 @@ static int ov4689_probe(struct i2c_client *client)
>  		goto err_clean_subdev_pm;
>  	}
>  
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
>  	return 0;
>  
>  err_clean_subdev_pm:
>  	pm_runtime_disable(dev);
> -	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
>  	v4l2_subdev_cleanup(sd);
>  err_clean_entity:
>  	media_entity_cleanup(&sd->entity);

-- 
Regards,

Laurent Pinchart

