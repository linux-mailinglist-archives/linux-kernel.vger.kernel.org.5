Return-Path: <linux-kernel+bounces-106046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478F87E851
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BC5B22F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA83364CD;
	Mon, 18 Mar 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKtxEQZ1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503538385;
	Mon, 18 Mar 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760362; cv=none; b=Cv3Vn1d4C+EMuV2cSfKpuD3ty0tY8zIGeZjJ4r0cKdkCi/ne1Sz9mII4PSWk7NUSozyiW8HGg9uRTFVM9VfkEWSM8duBA/i4ACmdwz0UgmkI25hFqhfnN+xNTt4EV5nR+ftTMbK6cecmXQe7HeIgNXb8MzOa+9XXDwO+Z+0nTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760362; c=relaxed/simple;
	bh=SrNpO6frBXeFes4/cfwvtY7bovpO8PEcBwfDBnzsgX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/RwDKSWsG017UMNU0nKJvllmdTYPI1bsOLKwMPeIqtQ8sJrPhgpW6qKTCkybEwlZKP8+jqS23gvgIBYJoSrXijygb/hAL4VKHQHlP3zZEacP0biozCDd4Nr5XIibaV3mcOqXrR+jaGpQlOMQuiBb3EKpwSC3Uz8A2sU9/Sxkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKtxEQZ1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710760361; x=1742296361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SrNpO6frBXeFes4/cfwvtY7bovpO8PEcBwfDBnzsgX8=;
  b=dKtxEQZ1vGph4AFryJ7ptrpdbBXXNCuVcKi2zATf0BnmcUfFfT0XSrLt
   PaDLZRDKVh0NL4/Nu3hr6Z8qWTzrJ36pZwIQ6mj+MWbA3YgO+WKZj68Ef
   V8l6zn6ktcOxVQTu+YkvALI5rWDXR4REIedZ/aLjKvYCHREeJo/Y/Ghwy
   jCMwEG+g5zkhVIlsJx6Ny+iePMRJoEQMxez1mRATBQ7ZEvYcKj6U8RP02
   g9PUKaRFpQTocnSn9oUd2P6E6i9nW3cLQ3p2+aqOg3R93UUgLoT+2QLPz
   ocOpQy+cCVKAyQz0joR9geOJmpQcXHgObEBGVDwNYBG728H54f8Y6n7BP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="17012457"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="17012457"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 04:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="937060156"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="937060156"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Mar 2024 04:12:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Mar 2024 13:12:36 +0200
Date: Mon, 18 Mar 2024 13:12:36 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ptn36502: switch to DRM_AUX_BRIDGE
Message-ID: <ZfghpN81iR6vL+pu@kuha.fi.intel.com>
References: <20240315-ptn36502-aux-v1-1-c9d3c828ff2e@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-ptn36502-aux-v1-1-c9d3c828ff2e@fairphone.com>

On Fri, Mar 15, 2024 at 05:04:22PM +0100, Luca Weiss wrote:
> Switch to using the new DRM_AUX_BRIDGE helper to create the transparent
> DRM bridge device instead of handcoding corresponding functionality.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Very similar to this patch:
> c5d296bad640 ("usb: typec: nb7vpq904m: switch to DRM_AUX_BRIDGE")
> ---
>  drivers/usb/typec/mux/Kconfig    |  2 +-
>  drivers/usb/typec/mux/ptn36502.c | 44 ++--------------------------------------
>  2 files changed, 3 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> index 399c7b0983df..4827e86fed6d 100644
> --- a/drivers/usb/typec/mux/Kconfig
> +++ b/drivers/usb/typec/mux/Kconfig
> @@ -60,7 +60,7 @@ config TYPEC_MUX_PTN36502
>  	tristate "NXP PTN36502 Type-C redriver driver"
>  	depends on I2C
>  	depends on DRM || DRM=n
> -	select DRM_PANEL_BRIDGE if DRM
> +	select DRM_AUX_BRIDGE if DRM_BRIDGE
>  	select REGMAP_I2C
>  	help
>  	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip
> diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn36502.c
> index 72ae38a1b2be..0ec86ef32a87 100644
> --- a/drivers/usb/typec/mux/ptn36502.c
> +++ b/drivers/usb/typec/mux/ptn36502.c
> @@ -8,7 +8,7 @@
>   * Copyright (C) 2023 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>   */
>  
> -#include <drm/drm_bridge.h>
> +#include <drm/bridge/aux-bridge.h>
>  #include <linux/bitfield.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> @@ -68,8 +68,6 @@ struct ptn36502 {
>  
>  	struct typec_switch *typec_switch;
>  
> -	struct drm_bridge bridge;
> -
>  	struct mutex lock; /* protect non-concurrent retimer & switch */
>  
>  	enum typec_orientation orientation;
> @@ -283,44 +281,6 @@ static int ptn36502_detect(struct ptn36502 *ptn)
>  	return 0;
>  }
>  
> -#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
> -static int ptn36502_bridge_attach(struct drm_bridge *bridge,
> -				  enum drm_bridge_attach_flags flags)
> -{
> -	struct ptn36502 *ptn = container_of(bridge, struct ptn36502, bridge);
> -	struct drm_bridge *next_bridge;
> -
> -	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> -		return -EINVAL;
> -
> -	next_bridge = devm_drm_of_get_bridge(&ptn->client->dev, ptn->client->dev.of_node, 0, 0);
> -	if (IS_ERR(next_bridge)) {
> -		dev_err(&ptn->client->dev, "failed to acquire drm_bridge: %pe\n", next_bridge);
> -		return PTR_ERR(next_bridge);
> -	}
> -
> -	return drm_bridge_attach(bridge->encoder, next_bridge, bridge,
> -				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> -}
> -
> -static const struct drm_bridge_funcs ptn36502_bridge_funcs = {
> -	.attach	= ptn36502_bridge_attach,
> -};
> -
> -static int ptn36502_register_bridge(struct ptn36502 *ptn)
> -{
> -	ptn->bridge.funcs = &ptn36502_bridge_funcs;
> -	ptn->bridge.of_node = ptn->client->dev.of_node;
> -
> -	return devm_drm_bridge_add(&ptn->client->dev, &ptn->bridge);
> -}
> -#else
> -static int ptn36502_register_bridge(struct ptn36502 *ptn)
> -{
> -	return 0;
> -}
> -#endif
> -
>  static const struct regmap_config ptn36502_regmap = {
>  	.max_register = 0x0d,
>  	.reg_bits = 8,
> @@ -369,7 +329,7 @@ static int ptn36502_probe(struct i2c_client *client)
>  	if (ret)
>  		goto err_disable_regulator;
>  
> -	ret = ptn36502_register_bridge(ptn);
> +	ret = drm_aux_bridge_register(dev);
>  	if (ret)
>  		goto err_disable_regulator;
>  
> 
> ---
> base-commit: 9bb9b28d0568991b1d63e66fe75afa5f97ad1156
> change-id: 20240315-ptn36502-aux-15dd6f289aff
> 
> Best regards,
> -- 
> Luca Weiss <luca.weiss@fairphone.com>

-- 
heikki

