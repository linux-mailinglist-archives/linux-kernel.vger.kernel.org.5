Return-Path: <linux-kernel+bounces-78217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90829861061
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90ADE1C21084
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079685CDDC;
	Fri, 23 Feb 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hrpIosHy"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE295C617;
	Fri, 23 Feb 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687756; cv=none; b=cOEGFNysYPE124poQjTMdVEYyfHT6UyiRxVNnruMVK6v69/wl2e4yh+nwFPO18ZWlKzKHei9C6F28avYt3n8XA5KbPfWAk/7bTdT2a3+wtbFDcQSC/hoBK+K93z4jY/PlPH1Uuj4JeWFGjcTPxRhUvD52t7W9XFV+C3gRrGL7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687756; c=relaxed/simple;
	bh=yWyMB9bSFLQf+xKQD0mpdXL/wVdMZebQbbRlw8q5Uo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLRYIclSQ2W4Mvq12YE85Zhy/Dc5mMZsS5NXb42Z38krff1tpd6T7H9fxNO3EdbSByWlTZVGz+k4YBqh0KfVKOw24ZJkVa+yRYqdUWQGc4CR1rPGuxYMBg7hl1EfIXW3pURA6qbhUvzznb6vfoWR13W0z3KRzBTRcNDEArO8IfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hrpIosHy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA8EE2E7;
	Fri, 23 Feb 2024 12:29:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708687744;
	bh=yWyMB9bSFLQf+xKQD0mpdXL/wVdMZebQbbRlw8q5Uo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrpIosHy8Ha0WNT6imhaL401eE1Fi1FrzUeEMhvhPckqkBnBIV3lD6493aDDK5i1z
	 hjxpk0NFk8yU6+vuo98VPj7aR0EQJbRgOqs1VG97Dxg5rHiYGHsi8w+G81JwJ3hs0z
	 INbUHV4701FOodAR3kDwxjDKePbDG2v39E/+D2vE=
Date: Fri, 23 Feb 2024 13:29:16 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 08/20] media: i2c: ov4689: Enable runtime PM before
 registering sub-device
Message-ID: <20240223112916.GP31348@pendragon.ideasonboard.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-9-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-9-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 18, 2023 at 08:40:29PM +0300, Mikhail Rudenko wrote:
> As the sensor may be accessible right after its async sub-device is
> registered, enable runtime PM before doing so.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 501901aad4ae..5300e621ff90 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -876,19 +876,21 @@ static int ov4689_probe(struct i2c_client *client)
>  		goto err_clean_entity;
>  	}
>  
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_idle(dev);
> +
>  	ret = v4l2_async_register_subdev_sensor(sd);
>  	if (ret) {
>  		dev_err(dev, "v4l2 async register subdev failed\n");
> -		goto err_clean_subdev;
> +		goto err_clean_subdev_pm;
>  	}
>  
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> -	pm_runtime_idle(dev);
> -
>  	return 0;
>  
> -err_clean_subdev:
> +err_clean_subdev_pm:
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
>  	v4l2_subdev_cleanup(sd);
>  err_clean_entity:
>  	media_entity_cleanup(&sd->entity);

-- 
Regards,

Laurent Pinchart

