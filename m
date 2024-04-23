Return-Path: <linux-kernel+bounces-154803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EFD8AE13B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE64283D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9049159B4E;
	Tue, 23 Apr 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3cG41SD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FE51016;
	Tue, 23 Apr 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865442; cv=none; b=d48BfsomMkzSLMYFcwVXAfYRHQKnPAvpOR/T6k1mWur7UoICp0iNJyUFkxeVBeTqpkyD3vuRMuredaQeG77Fvv1+u74SUMqHP4R2qlUAE5uh7j0Xlxy0iNLDMSJAB1pVnsBTO0VfOpXkJ1gArTQFXNAL/OEo07mr2Rk1b2jCwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865442; c=relaxed/simple;
	bh=DumJhvG8fsGnw0uHUg1uUVDb/GabqHRZR1307Gu8s9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGvErYiwAcgcK0TbPbgirhqYDUVvj60xLnqPePJ4EWncbFYFYnQQNJ7Ciorlo5ZxKD9Qxc8U29mb5G2GDZA2SY3eVvJKMuq2pjPGOmCOg5KYZfYTK9w+lOfGxYR4t6WhlNF0b/FO3OyOEMrPCY+SL15psF/aAdyLIddPL4g54uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3cG41SD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713865441; x=1745401441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DumJhvG8fsGnw0uHUg1uUVDb/GabqHRZR1307Gu8s9M=;
  b=h3cG41SDm/nBFfs1oX56p2PgDp2U/YgU2APhV27s7Ihv8v6WEY0mRk4U
   XzHvCucp0EmkfLkBZ2s10Q3BxiXwCiLN82owDX4ibhSkoBzLKUd3NpZM3
   dyCLyQOEj2ifHFE/VCG0HODSkKYYeVtzxSWqkYn31ZmvlMVoFXYOQDtX0
   NolJneYniCqMJZhfGnSXCIXfwGGi0ME5TVjPU28fdUG+TygiSXfJEBgit
   AJoKP+ZpXcAPt7/nOquz4XzjjHpKiTz/lszSziZUyJe55qIKfIcVPbCY4
   2YlgzGvEKSbbh/z5ifluP3tsR+toVyQjbPkCXIAerVbROPaVwvoxzGjCB
   A==;
X-CSE-ConnectionGUID: e/pfZVuTTGW0u/mhOfCTdQ==
X-CSE-MsgGUID: 0lNFnT+7SuiWWZdU1tvWJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19990085"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="19990085"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 02:44:00 -0700
X-CSE-ConnectionGUID: XVZWAwvQR66SJnsbejWocA==
X-CSE-MsgGUID: LChqrwi+T5Oo5idjBqIjfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47598385"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2024 02:43:57 -0700
Date: Tue, 23 Apr 2024 17:38:37 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 4/9] fpga: dfl: migrate FPGA Management Engine
 driver to dfl_feature_dev_data
Message-ID: <ZieBnQBDGgowf+y7@yilunxu-OptiPlex-7050>
References: <20240409233942.828440-1-peter.colberg@intel.com>
 <20240409233942.828440-5-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409233942.828440-5-peter.colberg@intel.com>

On Tue, Apr 09, 2024 at 07:39:37PM -0400, Peter Colberg wrote:
> This change separates out most of the symbol name changes required by this
> patch series for the file: drivers/fpga/dfl-fme-main.c. This is done to
> split a single monolithic change into multiple, smaller patches at the
> request of the maintainer.
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
> v2:
> - Split monolithic patch into series at request of maintainer
> - Change fme_hdr_ioctl_*() to receive dfl_feature_dev_data instead of
>   dfl_feature_platform_data.
> - Remove unused local variable pdata in fme_dev_{init,destroy}().
> ---
>  drivers/fpga/dfl-fme-main.c | 68 ++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 864924f68f5e..7f119b09b54e 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -135,10 +135,10 @@ static const struct attribute_group fme_hdr_group = {
>  	.attrs = fme_hdr_attrs,
>  };
>  
> -static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
> +static long fme_hdr_ioctl_release_port(struct dfl_feature_dev_data *fdata,
>  				       unsigned long arg)
>  {
> -	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
> +	struct dfl_fpga_cdev *cdev = fdata->dfl_cdev;
>  	int port_id;
>  
>  	if (get_user(port_id, (int __user *)arg))
> @@ -147,10 +147,10 @@ static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
>  	return dfl_fpga_cdev_release_port(cdev, port_id);
>  }
>  
> -static long fme_hdr_ioctl_assign_port(struct dfl_feature_platform_data *pdata,
> +static long fme_hdr_ioctl_assign_port(struct dfl_feature_dev_data *fdata,
>  				      unsigned long arg)
>  {
> -	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
> +	struct dfl_fpga_cdev *cdev = fdata->dfl_cdev;
>  	int port_id;
>  
>  	if (get_user(port_id, (int __user *)arg))
> @@ -163,13 +163,13 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>  			  struct dfl_feature *feature,
>  			  unsigned int cmd, unsigned long arg)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);

Maybe firstly make a patch to:

  #define to_dfl_feature_platform_data	dev_get_platdata

And s/to_dfl_feature_platform_data/dev_get_platdata

Then we could do replacements in this patch more friendly.

> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
>  
>  	switch (cmd) {
>  	case DFL_FPGA_FME_PORT_RELEASE:
> -		return fme_hdr_ioctl_release_port(pdata, arg);
> +		return fme_hdr_ioctl_release_port(fdata, arg);
>  	case DFL_FPGA_FME_PORT_ASSIGN:
> -		return fme_hdr_ioctl_assign_port(pdata, arg);
> +		return fme_hdr_ioctl_assign_port(fdata, arg);
>  	}
>  
>  	return -ENODEV;
> @@ -411,14 +411,14 @@ static int power_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
>  			     u32 attr, int channel, long val)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
>  	struct dfl_feature *feature = dev_get_drvdata(dev);
>  	int ret = 0;
>  	u64 v;
>  
>  	val = clamp_val(val / MICRO, 0, PWR_THRESHOLD_MAX);
>  
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  
>  	switch (attr) {
>  	case hwmon_power_max:
> @@ -438,7 +438,7 @@ static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
>  		break;
>  	}
>  
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  
>  	return ret;
>  }
> @@ -589,7 +589,7 @@ static struct dfl_feature_driver fme_feature_drvs[] = {
>  	},
>  };
>  
> -static long fme_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
> +static long fme_ioctl_check_extension(struct dfl_feature_dev_data *fdata,
>  				      unsigned long arg)
>  {
>  	/* No extension support for now */
> @@ -600,19 +600,21 @@ static int fme_open(struct inode *inode, struct file *filp)
>  {
>  	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&fdev->dev);

Why not do the same replacement here?

> +	struct dfl_feature_dev_data *fdata;
>  	int ret;
>  
>  	if (WARN_ON(!pdata))
>  		return -ENODEV;
>  
> -	mutex_lock(&pdata->lock);
> -	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
> +	fdata = pdata;
> +	mutex_lock(&fdata->lock);
> +	ret = dfl_feature_dev_use_begin(fdata, filp->f_flags & O_EXCL);
>  	if (!ret) {
>  		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
> -			dfl_feature_dev_use_count(pdata));
> +			dfl_feature_dev_use_count(fdata));
>  		filp->private_data = pdata;
>  	}
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  
>  	return ret;
>  }
> @@ -620,19 +622,20 @@ static int fme_open(struct inode *inode, struct file *filp)
>  static int fme_release(struct inode *inode, struct file *filp)
>  {
>  	struct dfl_feature_platform_data *pdata = filp->private_data;
> -	struct platform_device *pdev = pdata->dev;
> +	struct dfl_feature_dev_data *fdata = pdata;

ditto.

> +	struct platform_device *pdev = fdata->dev;
>  	struct dfl_feature *feature;
>  
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>  
> -	mutex_lock(&pdata->lock);
> -	dfl_feature_dev_use_end(pdata);
> +	mutex_lock(&fdata->lock);
> +	dfl_feature_dev_use_end(fdata);
>  
> -	if (!dfl_feature_dev_use_count(pdata))
> -		dfl_fpga_dev_for_each_feature(pdata, feature)
> +	if (!dfl_feature_dev_use_count(fdata))
> +		dfl_fpga_dev_for_each_feature(fdata, feature)
>  			dfl_fpga_set_irq_triggers(feature, 0,
>  						  feature->nr_irqs, NULL);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  
>  	return 0;
>  }
> @@ -640,7 +643,8 @@ static int fme_release(struct inode *inode, struct file *filp)
>  static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct dfl_feature_platform_data *pdata = filp->private_data;
> -	struct platform_device *pdev = pdata->dev;
> +	struct dfl_feature_dev_data *fdata = pdata;

ditto

> +	struct platform_device *pdev = fdata->dev;
>  	struct dfl_feature *f;
>  	long ret;
>  
> @@ -650,7 +654,7 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	case DFL_FPGA_GET_API_VERSION:
>  		return DFL_FPGA_API_VERSION;
>  	case DFL_FPGA_CHECK_EXTENSION:
> -		return fme_ioctl_check_extension(pdata, arg);
> +		return fme_ioctl_check_extension(fdata, arg);
>  	default:
>  		/*
>  		 * Let sub-feature's ioctl function to handle the cmd.
> @@ -658,7 +662,7 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		 * handled in this sub feature, and returns 0 or other
>  		 * error code if cmd is handled.
>  		 */
> -		dfl_fpga_dev_for_each_feature(pdata, f) {
> +		dfl_fpga_dev_for_each_feature(fdata, f) {
>  			if (f->ops && f->ops->ioctl) {
>  				ret = f->ops->ioctl(pdev, f, cmd, arg);
>  				if (ret != -ENODEV)
> @@ -672,27 +676,27 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  
>  static int fme_dev_init(struct platform_device *pdev)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
>  	struct dfl_fme *fme;
>  
>  	fme = devm_kzalloc(&pdev->dev, sizeof(*fme), GFP_KERNEL);
>  	if (!fme)
>  		return -ENOMEM;
>  
> -	mutex_lock(&pdata->lock);
> -	dfl_fpga_pdata_set_private(pdata, fme);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	dfl_fpga_fdata_set_private(fdata, fme);
> +	mutex_unlock(&fdata->lock);
>  
>  	return 0;
>  }
>  
>  static void fme_dev_destroy(struct platform_device *pdev)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
>  
> -	mutex_lock(&pdata->lock);
> -	dfl_fpga_pdata_set_private(pdata, NULL);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	dfl_fpga_fdata_set_private(fdata, NULL);
> +	mutex_unlock(&fdata->lock);
>  }
>  
>  static const struct file_operations fme_fops = {
> -- 
> 2.44.0
> 
> 

