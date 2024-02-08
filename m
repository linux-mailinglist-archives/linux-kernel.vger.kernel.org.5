Return-Path: <linux-kernel+bounces-58245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E033C84E366
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701A6B25D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AAB6A347;
	Thu,  8 Feb 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgpXii9w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A979956;
	Thu,  8 Feb 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403432; cv=none; b=We4ZURFc6hKXGOBjSV16pEVFl2aR9bMHyne9qSR2XLnk4BohTMSAotY0uvM3oetwHd8/UGBoMZDmWp0+ubJffmYGJzRVUPL2cWoK9DpVXgA9mpVBRT2gd66zh0jLvUoDxDwzP7rVCM6ynaTaZ4c6+57KweNKzmRP8c/LVB4oX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403432; c=relaxed/simple;
	bh=HfSHLYsgKhk5M3JSS42Ig5lg08AF0g9eFj70VaxI34M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JM0Kuw2+3ykXodfh3mHlldlS2MBDA/VjFzkCwm+yaYBQCz1ITSJOo1stM/acKfwxKB9jqYYt03Tatt5LMGgzIta2VFX+yzMQ2kKcwyhGX4IK0CeBBZm7o8f+cNUDSUKWE7qszSOszUDcM699rt16favkqmOkE6z27Dy6QKZWJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgpXii9w; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707403431; x=1738939431;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HfSHLYsgKhk5M3JSS42Ig5lg08AF0g9eFj70VaxI34M=;
  b=cgpXii9wdsObmtzRErk1M8rCLz1FF2/6YbDa91/VkNSe/4tp7hr+jCJ7
   u9cWGbq650sLC7XMSlaEWxnJt1usC3CEf3hK2ZDiHXnE092ZZmBITod9E
   d0hIk+YegATwmzPsffkbgakGP/X3uFAbsNG644yNlUUDOjIDSStcWXskc
   49gbRrBxTNQIRjmeS2UC+/ikrVCeT1QqDrSpKxKvTuXHolDFvey3Q+T9Q
   9RliVHMSS44/HpOKanNzX9dgdmD6aHhdYV63A5RxykXtQT2DMgblXAiG5
   tbSRba4/iIpgD7p4ZDbj79et1ZrQgVJbx4fZk2CT67+2bFPe6SPIYIGqe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1097098"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1097098"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 06:43:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6283651"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 06:43:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 16:43:44 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Netdev <netdev@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 6/8] platform/x86/intel/sdsi: Add attribute to read the
 current meter state
In-Reply-To: <20240201010747.471141-7-david.e.box@linux.intel.com>
Message-ID: <1b91ed16-ab06-8b67-187d-c6de596cb176@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com> <20240201010747.471141-7-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 31 Jan 2024, David E. Box wrote:

> The meter_certificate file provides access to metering information that may
> be attested but is only updated every 8 hours. Add new attribute,
> meter_current, to allow reading an untested snapshot of the current values.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/sdsi.c | 42 ++++++++++++++++++++++++++++---
>  drivers/platform/x86/intel/sdsi.h |  2 ++
>  2 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index 287780fe65bb..171899b4a671 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -62,6 +62,7 @@
>  #define CTRL_COMPLETE			BIT(6)
>  #define CTRL_READY			BIT(7)
>  #define CTRL_INBAND_LOCK		BIT(32)
> +#define CTRL_METER_ENABLE_DRAM		BIT(33)
>  #define CTRL_STATUS			GENMASK(15, 8)
>  #define CTRL_PACKET_SIZE		GENMASK(31, 16)
>  #define CTRL_MSG_SIZE			GENMASK(63, 48)
> @@ -235,8 +236,10 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  	control = FIELD_PREP(CTRL_EOM, 1) |
>  		  FIELD_PREP(CTRL_SOM, 1) |
>  		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
> -		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
> +		  FIELD_PREP(CTRL_PACKET_SIZE, info->size) |
> +		  priv->control_flags;
>  	writeq(control, priv->control_addr);
> +	priv->control_flags = 0;

I'm slightly worried about this. The function is named with a generic 
name but I suppose meter_lock that has less generic name is supposed to 
protect this also?

Also, resetting it after every use smells like it should be a parameter 
instead of struct member.

>  	return sdsi_mbox_poll(priv, info, data_size);
>  }
> @@ -468,11 +471,42 @@ meter_certificate_read(struct file *filp, struct kobject *kobj,
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct sdsi_priv *priv = dev_get_drvdata(dev);
> +	int ret;
>  
> -	return certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
> +	ret = mutex_lock_interruptible(&priv->meter_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
> +
> +	mutex_unlock(&priv->meter_lock);
> +
> +	return ret;
>  }
>  static BIN_ATTR_ADMIN_RO(meter_certificate, SDSI_SIZE_READ_MSG);
>  
> +static ssize_t
> +meter_current_read(struct file *filp, struct kobject *kobj,
> +		   struct bin_attribute *attr, char *buf, loff_t off,
> +		   size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct sdsi_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&priv->meter_lock);
> +	if (ret)
> +		return ret;
> +
> +	priv->control_flags = CTRL_METER_ENABLE_DRAM;
> +	ret = certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
> +
> +	mutex_unlock(&priv->meter_lock);
> +
> +	return ret;
> +}
> +static BIN_ATTR_ADMIN_RO(meter_current, SDSI_SIZE_READ_MSG);
> +
>  static ssize_t registers_read(struct file *filp, struct kobject *kobj,
>  			      struct bin_attribute *attr, char *buf, loff_t off,
>  			      size_t count)
> @@ -503,6 +537,7 @@ static struct bin_attribute *sdsi_bin_attrs[] = {
>  	&bin_attr_registers,
>  	&bin_attr_state_certificate,
>  	&bin_attr_meter_certificate,
> +	&bin_attr_meter_current,
>  	&bin_attr_provision_akc,
>  	&bin_attr_provision_cap,
>  	NULL
> @@ -522,7 +557,7 @@ sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
>  	if (!(priv->features & SDSI_FEATURE_SDSI))
>  		return 0;
>  
> -	if (attr == &bin_attr_meter_certificate)
> +	if (attr == &bin_attr_meter_certificate || attr == &bin_attr_meter_current)
>  		return (priv->features & SDSI_FEATURE_METERING) ?
>  				attr->attr.mode : 0;
>  
> @@ -725,6 +760,7 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
>  	priv->dev = &auxdev->dev;
>  	priv->id = auxdev->id;
>  	mutex_init(&priv->mb_lock);
> +	mutex_init(&priv->meter_lock);
>  	auxiliary_set_drvdata(auxdev, priv);
>  
>  	/* Get the SDSi discovery table */
> diff --git a/drivers/platform/x86/intel/sdsi.h b/drivers/platform/x86/intel/sdsi.h
> index 256618eb3136..e20cf279212e 100644
> --- a/drivers/platform/x86/intel/sdsi.h
> +++ b/drivers/platform/x86/intel/sdsi.h
> @@ -18,12 +18,14 @@ struct device;
>  
>  struct sdsi_priv {
>  	struct mutex			mb_lock;	/* Mailbox access lock */
> +	struct mutex			meter_lock;

Please add information what this protects.


-- 
 i.


