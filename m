Return-Path: <linux-kernel+bounces-127774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13A8950C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBB51F24B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D4A5FDA5;
	Tue,  2 Apr 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfQINJTv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8EA5D749;
	Tue,  2 Apr 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054997; cv=none; b=ZQYfqgkGCU6HlCTKRYTxMIcMVUsXIXJlau4g/VVWRMrkcqZJ0zMyq/r6t+FDcsAkc/lTryiM5QO8pXcHoP6N94m7MRDaH+XB5ie+SHG2PCN3TT3guP8p2RZngoF9D5qiEZ1APp/g9IAObKEN0LIomN/vSJfkFe1m2ZX73kYj+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054997; c=relaxed/simple;
	bh=yojujZju9qOfqfMFPNKUKUV4/uQaL/mRXhf6pdQvYh0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=STvaDERw+hA3ee50wsnkQNRYAkOweRBp+4NZh1c+SUEp49p24SpGovP6N5C2zpbxAnX/Ecsgur3L7LEVQcbyFLuWhLoc85qrwE88Wo+CrU2xyYQWZwlj1P4/D8muqmKWB9TnoW2M/0xDSw8SQNveXJdcKXJxoeAk87Zguezi6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfQINJTv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712054997; x=1743590997;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yojujZju9qOfqfMFPNKUKUV4/uQaL/mRXhf6pdQvYh0=;
  b=bfQINJTv4AFh4u9vmv8nBr+iuEnYu0H1/KkFkE7OzYyAPmA7HK/5NoIs
   G5b3astiswrVgrE9QM6UA+WWi17M5aAAkgkcflZibiLjWXzuzFTp8YeSY
   JNW8eKWk7OlR9Rh2y8l6aYb8BftWfdCQgLwdZyoIbPb+z8NCTqsX0CBdT
   EmkejftvHuSVUa1pq5weALxlK/HQ6FjsaSMlZcu8do+4+W33yq0vyjny2
   loVh56Rfm5clAl501rVmlCCvxGLdP89J2suTo6NNtsdd3m1b1vbd1krR6
   iXbyGgmJTws6p6f+uMqdWSec9oYRIFhjvHdbESMEzjgiaPq7ILYZV8/60
   g==;
X-CSE-ConnectionGUID: mI5ZNKKVQNqI3nNoP1Ro5A==
X-CSE-MsgGUID: EJMhYBxLSPOApsrw0zLcyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="11049777"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="11049777"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:49:56 -0700
X-CSE-ConnectionGUID: YDnriq/YQ4aMde48zhTGjw==
X-CSE-MsgGUID: yOg2Gc9BT6mmCUeyKEU0LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22479505"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:49:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 13:49:50 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] platform/x86: asus-wmi: store a min default for
 ppt options
In-Reply-To: <20240402022607.34625-6-luke@ljones.dev>
Message-ID: <89b0c0ea-30ce-28c6-19d2-ebd113b17935@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-6-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Apr 2024, Luke D. Jones wrote:

> Laptops with any of the ppt or nv tunables default to the minimum setting
> on boot so we can safely assume a stored value is correct.
> 
> This patch adds storing of those values in the local struct, and enables
> reading of those values back. To prevent creating a series of byte holes
> in the struct the "<name>_available" bool is removed and
> `asus_sysfs_is_visible()` uses the `ASUS_WMI_DEVID_<name>` directly.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 127 +++++++++++++++++++++++++-------
>  1 file changed, 99 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index b795f9c1941f..c80afa385532 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -262,13 +262,13 @@ struct asus_wmi {
>  	u32 gpu_mux_dev;
>  
>  	/* Tunables provided by ASUS for gaming laptops */
> -	bool ppt_pl2_sppt_available;
> -	bool ppt_pl1_spl_available;
> -	bool ppt_apu_sppt_available;
> -	bool ppt_plat_sppt_available;
> -	bool ppt_fppt_available;
> -	bool nv_dyn_boost_available;
> -	bool nv_temp_tgt_available;
> +	u32 ppt_pl2_sppt;
> +	u32 ppt_pl1_spl;
> +	u32 ppt_apu_sppt;
> +	u32 ppt_platform_sppt;
> +	u32 ppt_fppt;
> +	u32 nv_dynamic_boost;
> +	u32 nv_temp_target;
>  
>  	u32 kbd_rgb_dev;
>  	bool kbd_rgb_state_available;
> @@ -1020,11 +1020,21 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
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
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", asus->ppt_pl2_sppt);

Use %u for u32 values. This applies to all sysfs_emits in this patch.

-- 
 i.


