Return-Path: <linux-kernel+bounces-130195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED6E89753A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D541C2102C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6AD1509BE;
	Wed,  3 Apr 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nB6WncOC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499E139D17;
	Wed,  3 Apr 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161748; cv=none; b=H4gGb46i4yFvErrNn0VE0+1Ile8PLMtqSv9H8w3HWrRDqZ9NFghQUcWdt5+qZQaEhF2MfH8KkGBRgAdHfUlMMzeeCiGmYDGwxms6TQtawHHY2xbhGgjr2IYTEpVp2UHXivUlP7xwVVUldCyDxT6lxWtl5FDTO9i1SY/jsyjHq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161748; c=relaxed/simple;
	bh=mhuKbmAv0FK32oWKE8zDOqzcjDgwcdmOI00I9TTS6DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heI+Z8m4rHaLsKhw8+E6txBHNBCZ8+7nWN4WW5L/SipVs3elwQrIS95PSTaYeDuMmIoYaf8yfebiNznucIsEkr7gScPMy2EU2mGfaBkYRCRgI6E7LBmtCu1Qw+bIUaWDDyHjOQe9KYUkeTHIRUKlLOmDAWrUOnrCWV/1puIvjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nB6WncOC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712161746; x=1743697746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mhuKbmAv0FK32oWKE8zDOqzcjDgwcdmOI00I9TTS6DI=;
  b=nB6WncOCdoRIuSwbsy6I5dC1iHkLY/Rcj7WO522/HZZ3J+e1IM3wE6Z0
   Pveikps4kDrMhQGcvH3dKtPfJ37K/YNz74b0STf80jAQ85Sdv2VLyELGq
   GowYFtnGIlObGf/ORoAOqxelRR12lathtxfXG5tTHDSvb20bPk3JkDBO7
   5tBg3JOU3aZ4WWN+pC/h0p55TyL5yjMieenGLhle/ORv/VzGOL6kNfdrS
   SA/4yWbRcG1JDutu5znIW9d+yOvDLMAZzpPYAYnQu8yNnFDkGYZOR+8s6
   d3PKzDpVixmfknO3wB/SD7HLhHQsp5jMAVcFygvAn40kncSRbfbfMINPi
   Q==;
X-CSE-ConnectionGUID: Hdgps/tvQy6OWHvkzm621g==
X-CSE-MsgGUID: UX/7Zy+URf2QY8Id50WmMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24912199"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24912199"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:29:05 -0700
X-CSE-ConnectionGUID: m6ew5ttxTs6sDcZnFGoCRQ==
X-CSE-MsgGUID: lf/Y9co2QV+RE2aMxcSKCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18419481"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:29:02 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7BCC311F811;
	Wed,  3 Apr 2024 19:28:59 +0300 (EEST)
Date: Wed, 3 Apr 2024 16:28:59 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org,
	Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v3 24/25] drivers: media: i2c: imx258: Add support for
 reset gpio
Message-ID: <Zg2Dy2QBguXQoR3P@kekkonen.localdomain>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-25-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-25-git@luigi311.com>

Hi Luis,

Could you unify the subject prefix for the driver patches, please? E.g.
"media: imx258: " would be fine.

On Wed, Apr 03, 2024 at 09:03:53AM -0600, git@luigi311.com wrote:
> From: Luis Garcia <git@luigi311.com>
> 
> It was documented in DT, but not implemented.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> ---
>  drivers/media/i2c/imx258.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index 163f04f6f954..4c117c4829f1 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> @@ -680,6 +680,7 @@ struct imx258 {
>  	unsigned int csi2_flags;
>  
>  	struct gpio_desc *powerdown_gpio;
> +	struct gpio_desc *reset_gpio;
>  
>  	/*
>  	 * Mutex for serialized access:
> @@ -1232,7 +1233,11 @@ static int imx258_power_on(struct device *dev)
>  		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>  	}
>  
> -	return ret;
> +	gpiod_set_value_cansleep(imx258->reset_gpio, 0);
> +
> +	usleep_range(400, 500);

You could mention this at least in the commit message.

> +
> +	return 0;
>  }
>  
>  static int imx258_power_off(struct device *dev)
> @@ -1243,6 +1248,7 @@ static int imx258_power_off(struct device *dev)
>  	clk_disable_unprepare(imx258->clk);
>  	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>  
> +	gpiod_set_value_cansleep(imx258->reset_gpio, 1);

Same question than on the other GPIO: does this belong here?

>  	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>  
>  	return 0;
> @@ -1554,6 +1560,12 @@ static int imx258_probe(struct i2c_client *client)
>  	if (IS_ERR(imx258->powerdown_gpio))
>  		return PTR_ERR(imx258->powerdown_gpio);
>  
> +	/* request optional reset pin */
> +	imx258->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(imx258->reset_gpio))
> +		return PTR_ERR(imx258->reset_gpio);
> +
>  	/* Initialize subdev */
>  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>  

-- 
Regards,

Sakari Ailus

