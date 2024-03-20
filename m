Return-Path: <linux-kernel+bounces-108930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539888121E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BFD1F24163
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1241C9D;
	Wed, 20 Mar 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6VjApze"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C3641C85;
	Wed, 20 Mar 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940401; cv=none; b=aJuqnCI7KPhdrbdglGJJ0cZOw5vmdWj5c71kRD5d59q8zXvG5zXPglu/GzKTYDE8AYd1jO2bFr9R61uNyZd+0M2BgbF4+KN3p1KF368opNLcYGC+Y/F1YFu0yvMQGsVVmxk/k+ErSTIuFCajEtEHLIyHVAmo9zqSJLUJMHq1Ibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940401; c=relaxed/simple;
	bh=DbupxmKb2/jnAh4FxY712z8GGAI91p/E883N6rglf48=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dflPIIRBuw3dLOJzcp3AorKGeNR9Y5DUqEVHTXdN/mwTQNAalxlehLUsdUtzlLLYLYv4lao+r5rUaRWwECsZcRe9k7+3xIyseAQ1rp0SYoZ9nF1YePwjdspcBA/9RP09Z3lmSsKUGj9PP+3vKbkL4XwtEAcb0nCGytrWRWmJeEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6VjApze; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710940399; x=1742476399;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DbupxmKb2/jnAh4FxY712z8GGAI91p/E883N6rglf48=;
  b=a6VjApzeSvKPJ2iYQwsDHOSu4dpuFqb/QFbki0n7tB0pvNqgRy+ZywCK
   x+dpfLtDV1g8bRPpp9nC/LmRfCDi3P1LjeKl6SIkzqXkRrGdEZg2iALiY
   24o3JEoFWg3TLBAW7NX2QzwoUm5ZrVABQf/4xwfFRIwAVz3bwR9emTgZH
   3ASjShkKGahXXN1WSNciBfsRwD6PAQB37G90CEWVWB1nb+UXsC4m/Vd2H
   At1A8un96K2WfBn3zPOxcNtEnRblhIQ1WDJL7/zuNv9UKjHu0sdOmgZce
   5RrZYc6f2uatnYvMoS6miAjs1go7Jkov5SiVW+LrwnZU5MFrtiFL/cFTz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23363653"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="23363653"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 06:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14035681"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.16])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 06:13:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Mar 2024 15:13:12 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: store a min default for ppt
 options
In-Reply-To: <20240310233722.30884-1-luke@ljones.dev>
Message-ID: <ebe48668-dfca-775c-880e-dfa333b7e562@linux.intel.com>
References: <20240310233722.30884-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Mar 2024, Luke D. Jones wrote:

> Laptops with any of the ppt or nv tunables default to the minimum setting
> on boot so we can safely assume a stored value is correct.
> 
> This patch adds storing of those values in the local struct, and enables
> reading of those values back.
> 
> Secondary to the above it renames some internal variables to be more
> consistent (which makes code grepping show all related parts)
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 141 +++++++++++++++++++++++++-------
>  1 file changed, 111 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index e4341abb71e0..482e23b55e1e 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -272,12 +272,19 @@ struct asus_wmi {
>  
>  	/* Tunables provided by ASUS for gaming laptops */
>  	bool ppt_pl2_sppt_available;
> +	u32 ppt_pl2_sppt;
>  	bool ppt_pl1_spl_available;
> +	u32 ppt_pl1_spl;
>  	bool ppt_apu_sppt_available;
> -	bool ppt_plat_sppt_available;
> +	u32 ppt_apu_sppt;
> +	bool ppt_platform_sppt_available;
> +	u32 ppt_platform_sppt;
>  	bool ppt_fppt_available;
> -	bool nv_dyn_boost_available;
> -	bool nv_temp_tgt_available;
> +	u32 ppt_fppt;
> +	bool nv_dynamic_boost_available;
> +	u32 nv_dynamic_boost;
> +	bool nv_temp_target_available;
> +	u32 nv_temp_target;
>  
>  	bool kbd_rgb_mode_available;
>  	u32 kbd_rgb_dev;

Can you check with pahole if this structure is now full of 31-bit holes?

The benefit of keeping bool & u32 doesn't seem that big to begin with 
(in visual sense because of the 1 char variation in column).

> @@ -999,11 +1006,10 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
>  				    struct device_attribute *attr,
>  				    const char *buf, size_t count)
>  {
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	int result, err;
>  	u32 value;
>  
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -

Please put this into own patch, it's entirely unrelated (but still useful 
change!).

>  	result = kstrtou32(buf, 10, &value);
>  	if (result)
>  		return result;
> @@ -1022,22 +1028,31 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
>  		return -EIO;
>  	}
>  
> +	asus->ppt_pl2_sppt = value;
>  	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl2_sppt");
>  
>  	return count;
>  }
> -static DEVICE_ATTR_WO(ppt_pl2_sppt);
> +
> +static ssize_t ppt_pl2_sppt_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)

Alignment is not correct?

> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", asus->ppt_pl2_sppt);
> +}
> +static DEVICE_ATTR_RW(ppt_pl2_sppt);
>  
>  /* Tunable: PPT, Intel=PL1, AMD=SPL ******************************************/
>  static ssize_t ppt_pl1_spl_store(struct device *dev,
>  				    struct device_attribute *attr,
>  				    const char *buf, size_t count)
>  {
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	int result, err;
>  	u32 value;
>  
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
> -

Unrelated, put to the same move patch as the other change please. I won't 
mark all thse from this point on but please do them all.

-- 
 i.


