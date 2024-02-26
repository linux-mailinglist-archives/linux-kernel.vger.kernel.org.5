Return-Path: <linux-kernel+bounces-80695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890A866B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32701B22CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93881C283;
	Mon, 26 Feb 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7T30GHx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED51BF2B;
	Mon, 26 Feb 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933784; cv=none; b=bEvqYokz8K1Ymp1kXRy6p2UUsKFyf763gltbu4ynNOKVwDoDNqZCfUS4NPp4TZ7XtPM8wiUVuLDlGssE0JOmrdu7TVbgiu3FjkCh5o/kbaHD/ROzrZt3+o9VTHQXQQf+c6vzUMH55OkRHa6FBNzWL0NVcBApAlfN04/WLNbtErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933784; c=relaxed/simple;
	bh=PWnqcfAeddmdN+2IUbadso3oL1zFZpoZUVAuI0hXtI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsnXVl+xD/Plbq8rIj//hPVJy93ewfa0u9B0NPwplgHZRNwRA1DikxfqYFb4o1Aqi0oGBJ72bldApOSYF4MRijgKljwYA4ZyTvq77LcbMjcoEioHkx/xTzQJeE3eBf8N9yICrXqCWYKU4gc/MD4IVwG63w41sOf+02Yn16KIr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7T30GHx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708933782; x=1740469782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PWnqcfAeddmdN+2IUbadso3oL1zFZpoZUVAuI0hXtI4=;
  b=B7T30GHxrA4cRV53jIzQw52+kKA6cZ9c3LhsMcRQKw9QWzffLkRTadyh
   cje49s+EA1a5vO2yQ6Jca0ArL1c++DW9OkTFu7mOiTo8IsTgM6JJ+Upb9
   kZl2rChf+Gx/nYtacnxdXKk/gfbXio84nVDxZJA8FaqEa7whVgLMLS+OM
   eri+xiIZKhGWJF0x9uhrJPoP0Sop2OoomWVTR/ojTBmzlWcMmkoqtFH1y
   gPUNdJjsWQBjyFx7gy59f1rM5eVUZt82QVINEMU5/dwyj/LzbmceKcBAE
   go/BTNuVM9YxVRPMLzigOsmtnl6dFxc4r84g6lm93TDDomxF3aTcZzlol
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14334517"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14334517"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 23:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029444"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029444"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Feb 2024 23:49:37 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 09:49:36 +0200
Date: Mon, 26 Feb 2024 09:49:36 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] usb: typec: constify the struct device_type usage
Message-ID: <ZdxCkAGj1ViFjQ5/@kuha.fi.intel.com>
References: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
 <20240218-device_cleanup-usb-v1-1-77423c4da262@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-device_cleanup-usb-v1-1-77423c4da262@marliere.net>

On Sun, Feb 18, 2024 at 04:18:09PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move all the
> device_type variables in use by the driver to be constant structures as
> well, placing it into read-only memory which can not be modified at
> runtime.
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/pd.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
> index b9cca2be76fc..d78c04a421bc 100644
> --- a/drivers/usb/typec/pd.c
> +++ b/drivers/usb/typec/pd.c
> @@ -157,7 +157,7 @@ static const struct attribute_group source_fixed_supply_group = {
>  };
>  __ATTRIBUTE_GROUPS(source_fixed_supply);
>  
> -static struct device_type source_fixed_supply_type = {
> +static const struct device_type source_fixed_supply_type = {
>  	.name = "pdo",
>  	.release = pdo_release,
>  	.groups = source_fixed_supply_groups,
> @@ -182,7 +182,7 @@ static const struct attribute_group sink_fixed_supply_group = {
>  };
>  __ATTRIBUTE_GROUPS(sink_fixed_supply);
>  
> -static struct device_type sink_fixed_supply_type = {
> +static const struct device_type sink_fixed_supply_type = {
>  	.name = "pdo",
>  	.release = pdo_release,
>  	.groups = sink_fixed_supply_groups,
> @@ -213,7 +213,7 @@ static struct attribute *source_variable_supply_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(source_variable_supply);
>  
> -static struct device_type source_variable_supply_type = {
> +static const struct device_type source_variable_supply_type = {
>  	.name = "pdo",
>  	.release = pdo_release,
>  	.groups = source_variable_supply_groups,
> @@ -227,7 +227,7 @@ static struct attribute *sink_variable_supply_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(sink_variable_supply);
>  
> -static struct device_type sink_variable_supply_type = {
> +static const struct device_type sink_variable_supply_type = {
>  	.name = "pdo",
>  	.release = pdo_release,
>  	.groups = sink_variable_supply_groups,
> @@ -258,7 +258,7 @@ static struct attribute *source_battery_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(source_battery);
>  
> -static struct device_type source_battery_type = {
> +static const struct device_type source_battery_type = {
>  	.name = "pdo",
>  	.release = pdo_release,
>  	.groups = source_battery_groups,
> @@ -272,7 +272,7 @@ static struct attribute *sink_battery_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(sink_battery);
>  
> -static struct device_type sink_battery_type = {
> +static const struct device_type sink_battery_type = {
>  	.name = "pdo",
>  	.release = pdo_release,
>  	.groups = sink_battery_groups,
> @@ -339,7 +339,7 @@ static struct attribute *source_pps_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(source_pps);
>  
> -static struct device_type source_pps_type = {
> +static const struct device_type source_pps_type = {
>  	.name = "pdo",
>  	.release = pdo_release,
>  	.groups = source_pps_groups,
> @@ -353,7 +353,7 @@ static struct attribute *sink_pps_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(sink_pps);
>  
> -static struct device_type sink_pps_type = {
> +static const struct device_type sink_pps_type = {
>  	.name = "pdo",
>  	.release = pdo_release,
>  	.groups = sink_pps_groups,
> @@ -371,30 +371,30 @@ static const char * const apdo_supply_name[] = {
>  	[APDO_TYPE_PPS]  = "programmable_supply",
>  };
>  
> -static struct device_type *source_type[] = {
> +static const struct device_type *source_type[] = {
>  	[PDO_TYPE_FIXED] = &source_fixed_supply_type,
>  	[PDO_TYPE_BATT]  = &source_battery_type,
>  	[PDO_TYPE_VAR]   = &source_variable_supply_type,
>  };
>  
> -static struct device_type *source_apdo_type[] = {
> +static const struct device_type *source_apdo_type[] = {
>  	[APDO_TYPE_PPS]  = &source_pps_type,
>  };
>  
> -static struct device_type *sink_type[] = {
> +static const struct device_type *sink_type[] = {
>  	[PDO_TYPE_FIXED] = &sink_fixed_supply_type,
>  	[PDO_TYPE_BATT]  = &sink_battery_type,
>  	[PDO_TYPE_VAR]   = &sink_variable_supply_type,
>  };
>  
> -static struct device_type *sink_apdo_type[] = {
> +static const struct device_type *sink_apdo_type[] = {
>  	[APDO_TYPE_PPS]  = &sink_pps_type,
>  };
>  
>  /* REVISIT: Export when EPR_*_Capabilities need to be supported. */
>  static int add_pdo(struct usb_power_delivery_capabilities *cap, u32 pdo, int position)
>  {
> -	struct device_type *type;
> +	const struct device_type *type;
>  	const char *name;
>  	struct pdo *p;
>  	int ret;
> @@ -460,7 +460,7 @@ static void pd_capabilities_release(struct device *dev)
>  	kfree(to_usb_power_delivery_capabilities(dev));
>  }
>  
> -static struct device_type pd_capabilities_type = {
> +static const struct device_type pd_capabilities_type = {
>  	.name = "capabilities",
>  	.release = pd_capabilities_release,
>  };
> @@ -575,7 +575,7 @@ static void pd_release(struct device *dev)
>  	kfree(pd);
>  }
>  
> -static struct device_type pd_type = {
> +static const struct device_type pd_type = {
>  	.name = "usb_power_delivery",
>  	.release = pd_release,
>  	.groups = pd_groups,
> 
> -- 
> 2.43.0

-- 
heikki

