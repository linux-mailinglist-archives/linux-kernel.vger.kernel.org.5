Return-Path: <linux-kernel+bounces-84425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E986A6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB761F24E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B41CD24;
	Wed, 28 Feb 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+I/jzAk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AE1AAC9;
	Wed, 28 Feb 2024 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088097; cv=none; b=o9B6nIOqyS1toYDUFBi/9zdX1jHSmEznWuGQUzd0fcjq8HQJMkFn/JCVQwP9WMoyTP4KgeAW9NTcLmyBxklf7k+1ioIL0MIfGelWXmS5qa5Up1bmm9BqyXkFLhvvUgHEa/4/Ru7H5knouRuWov+a+etRhwZSEA+4H0COpEszPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088097; c=relaxed/simple;
	bh=92CoCrnBxMOMWfB5SuJP3VV67KEybYNkFipmfDe32s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dZ3SbNeaeHKSwVcUk/csy7AuA1j7Q1nkBhF88zree6DVI/SwSfENYPN24mOHO/VtupooHcOrunnGngxZgMDwvFsB4l/+lnAxluTM37ssmYF0Hob5nMbO6QAwVFtUHgsTSehd44LA6NhVpxLW3zgokZ0O/7gJRhVuy6lALfh8gMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+I/jzAk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709088096; x=1740624096;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=92CoCrnBxMOMWfB5SuJP3VV67KEybYNkFipmfDe32s4=;
  b=D+I/jzAk08VfR6OH3O5vRHr14ILEflrr14BHjnUDni+gGcfdXRh7Iysy
   QHWb89/+j/wTWDCj2iK5xQcEkFx8kmN20IRwnsT2XUvEc8wYz3cZSVFW8
   pYqrqCkm2KKRaOMW4VQHtElW8PZY+vJK33+o+sV/OSb2qVr3LDjnDtke+
   jOzwS6Sk673UU9Aa4yWLvYNhKIGP18N3jzMoDNLlKpxSmbVvMaMsrm4y1
   8RhKFWkNGKts5YY1M5Oh76KwQhHlLMO7AfRPlg6RFLLUdcnnFbi9iX6EM
   38zbJiJvnCLS4Of5V9mYLH+cE7zA0lM1tFkt60+/zXGblPJANQ/VCzzM6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3326775"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3326775"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11833524"
Received: from dschro4x-mobl.amr.corp.intel.com (HELO [10.212.137.190]) ([10.212.137.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:41:34 -0800
Message-ID: <7bb4c41c-2df7-4eec-86b2-74d110ea535c@linux.intel.com>
Date: Tue, 27 Feb 2024 18:41:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/9] platform/x86/intel/sdsi: Add attribute to read the
 current meter state
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
 <20240228000016.1685518-5-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240228000016.1685518-5-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/27/24 4:00 PM, David E. Box wrote:
> The meter_certificate file provides access to metering information that may
> be attested but is only updated every 8 hours. Add new attribute,
> meter_current, to allow reading an untested snapshot of the current values.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>
> V2 - make control_flags a parameter to be eventually passed to
>      sdsi_mbox_cmd_read(). This removes the need for a lock which had been
>      added to protect control_flags when it was a member of the private
>      struct.
>
>  drivers/platform/x86/intel/sdsi.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index bb3eaf5eb382..277e4f4b20ac 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -68,6 +68,7 @@
>  #define CTRL_COMPLETE			BIT(6)
>  #define CTRL_READY			BIT(7)
>  #define CTRL_INBAND_LOCK		BIT(32)
> +#define CTRL_METER_ENABLE_DRAM		BIT(33)
>  #define CTRL_STATUS			GENMASK(15, 8)
>  #define CTRL_PACKET_SIZE		GENMASK(31, 16)
>  #define CTRL_MSG_SIZE			GENMASK(63, 48)
> @@ -95,6 +96,7 @@ enum sdsi_command {
>  struct sdsi_mbox_info {
>  	u64	*payload;
>  	void	*buffer;
> +	u64	control_flags;
>  	int	size;
>  };
>  
> @@ -250,7 +252,8 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  	control = FIELD_PREP(CTRL_EOM, 1) |
>  		  FIELD_PREP(CTRL_SOM, 1) |
>  		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
> -		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
> +		  FIELD_PREP(CTRL_PACKET_SIZE, info->size) |
> +		  info->control_flags;
>  	writeq(control, priv->control_addr);
>  
>  	return sdsi_mbox_poll(priv, info, data_size);
> @@ -424,8 +427,8 @@ static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
>  static BIN_ATTR_WO(provision_cap, SDSI_SIZE_WRITE_MSG);
>  
>  static ssize_t
> -certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
> -		 size_t count)
> +certificate_read(u64 command, u64 control_flags, struct sdsi_priv *priv,
> +		 char *buf, loff_t off, size_t count)
>  {
>  	struct sdsi_mbox_info info = {};
>  	size_t size;
> @@ -441,6 +444,7 @@ certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
>  
>  	info.payload = &command;
>  	info.size = sizeof(command);
> +	info.control_flags = control_flags;
>  
>  	ret = mutex_lock_interruptible(&priv->mb_lock);
>  	if (ret)
> @@ -472,7 +476,7 @@ state_certificate_read(struct file *filp, struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct sdsi_priv *priv = dev_get_drvdata(dev);
>  
> -	return certificate_read(SDSI_CMD_READ_STATE, priv, buf, off, count);
> +	return certificate_read(SDSI_CMD_READ_STATE, 0, priv, buf, off, count);
>  }
>  static BIN_ATTR_ADMIN_RO(state_certificate, SDSI_SIZE_READ_MSG);
>  
> @@ -484,10 +488,23 @@ meter_certificate_read(struct file *filp, struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct sdsi_priv *priv = dev_get_drvdata(dev);
>  
> -	return certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
> +	return certificate_read(SDSI_CMD_READ_METER, 0, priv, buf, off, count);
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
> +
> +	return certificate_read(SDSI_CMD_READ_METER, CTRL_METER_ENABLE_DRAM,
> +				priv, buf, off, count);
> +}
> +static BIN_ATTR_ADMIN_RO(meter_current, SDSI_SIZE_READ_MSG);
> +
>  static ssize_t registers_read(struct file *filp, struct kobject *kobj,
>  			      struct bin_attribute *attr, char *buf, loff_t off,
>  			      size_t count)
> @@ -518,6 +535,7 @@ static struct bin_attribute *sdsi_bin_attrs[] = {
>  	&bin_attr_registers,
>  	&bin_attr_state_certificate,
>  	&bin_attr_meter_certificate,
> +	&bin_attr_meter_current,
>  	&bin_attr_provision_akc,
>  	&bin_attr_provision_cap,
>  	NULL
> @@ -537,7 +555,7 @@ sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
>  	if (!(priv->features & SDSI_FEATURE_SDSI))
>  		return 0;
>  
> -	if (attr == &bin_attr_meter_certificate)
> +	if (attr == &bin_attr_meter_certificate || attr == &bin_attr_meter_current)
>  		return (priv->features & SDSI_FEATURE_METERING) ?
>  				attr->attr.mode : 0;
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


