Return-Path: <linux-kernel+bounces-117197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CCB88A88B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D11A1F3BCDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731514388C;
	Mon, 25 Mar 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2KzY/lK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618A5C89;
	Mon, 25 Mar 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375338; cv=none; b=lMUjdnZBPA3xhLfgsITWuuDq4CUI1+YJ6SBnG8u4lh+oARXLYIvvNtajIMURFPtC9n1erDanoE0ewIPhBczEz6LKyT7Ylw218gBlEYRmGMFBv8xNW7kNVFvuTKdhi1LblAdOZOWF1YzbMyupFhYUdD9ZL+OGr/XJ9+qlUq0dXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375338; c=relaxed/simple;
	bh=eQs9r6QvBAImQCbz5fYZNfYhpIYk7o66WMO+5pFvG5A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mDOYT+3DUtz8SW4ERYEHGsmk2Z8ncJ4MUlIZuy8ra3iJpolLWSGjxHEngLOuMn7gxc3YKIvYsu3/11kRAZiBDCk6JS/QikEt+Z4jX0DP+op6B7XzlDWudCwG8lZLvbhZRf11AG6tjC1S0k+L70Vvb0MtTQuG74AiMsm5iOdo214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2KzY/lK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711375337; x=1742911337;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eQs9r6QvBAImQCbz5fYZNfYhpIYk7o66WMO+5pFvG5A=;
  b=X2KzY/lKizxfrJgBC5a7NoiLadt0YFdywPInnn7xk/s7ajDMuIWkmaeI
   SJMd647YlW6simFOZrUZWugmXmMgAg/A3pNhKlrBljxDG3cccyjGmTvFf
   2+wRVS29lryy0LN2OdhRVIi9n9cYfdEzYLqfHkgevwqPLGaE2GEauUq6o
   dzLBifEDOFZkO7N7I7r6lwI1ckUP+WM+EQKDcGqd2m0cWCbxPKjvDiqQn
   qkW5FllqWGRg9XUIM6Inwl9UNk5xgzBK1o+glbQcOXoT1eViGuTBRvYjk
   YuNuYwv4/x5BKTviuNCPK+NoYNo0Ldyyph+2HAwE775ubNCGZFK+E8dRz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17808961"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17808961"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 07:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15708691"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.19])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 07:02:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 25 Mar 2024 16:02:04 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] platform/x86: asus-wmi: support toggling POST
 sound
In-Reply-To: <20240325054938.489732-5-luke@ljones.dev>
Message-ID: <88b7d5b0-23af-37e0-6122-fc790ae57053@linux.intel.com>
References: <20240325054938.489732-1-luke@ljones.dev> <20240325054938.489732-5-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 25 Mar 2024, Luke D. Jones wrote:

> Add support for toggling the BIOS POST sound on some ASUS laptops.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
>  drivers/platform/x86/asus-wmi.c               | 51 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 61a745d2476f..5645dbac4ce8 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -194,3 +194,12 @@ Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the target temperature limit of the Nvidia dGPU:
>  			* min=75, max=87
> +
> +What:		/sys/devices/platform/<platform>/boot_sound
> +Date:		Jun 2023
> +KernelVersion:	6.10
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Set if the BIOS POST sound is played on boot.
> +			* 0 - False,
> +			* 1 - True
> \ No newline at end of file
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 094a93f24667..6cac9c3eb8b2 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2106,6 +2106,54 @@ static ssize_t panel_od_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(panel_od);
>  
> +/* Bootup sound ***************************************************************/
> +
> +static ssize_t boot_sound_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int result;
> +
> +	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_SOUND);
> +	if (result < 0)
> +		return result;
> +
> +	return sysfs_emit(buf, "%d\n", result);
> +}
> +
> +static ssize_t boot_sound_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 snd;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	result = kstrtou32(buf, 10, &snd);
> +	if (result)
> +		return result;
> +
> +	if (snd > 1)
> +		return -EINVAL;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BOOT_SOUND, snd, &result);
> +	if (err) {
> +		pr_warn("Failed to set boot sound: %d\n", err);
> +		return err;
> +	}
> +
> +	if (result > 1) {
> +		pr_warn("Failed to set panel boot sound (result): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "boot_sound");
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(boot_sound);

I started to think that perhaps these would be a way to create helper for 
these sysfs functions to call as they are quite similar, only the wmi id, 
strings and the range check change (the GPU functions do a few extra 
checks and could remain standalone functions but the rest look very 
similar to each other).

-- 
 i.


