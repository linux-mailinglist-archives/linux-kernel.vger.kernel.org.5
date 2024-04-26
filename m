Return-Path: <linux-kernel+bounces-159777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4D8B33D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB326B218C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879D13E3E4;
	Fri, 26 Apr 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arNw8Wrf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6E13D53D;
	Fri, 26 Apr 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123390; cv=none; b=QBKGIyWwnZXq3pS1k+3g/FsmroWVz9+7MelQvN/b20mwFKPAZyGF39Oy7iXrzuu0v9UiU7E9YWci2YMMmmEqUfLBSrre126IIri+j/3xTfavqdAYwSOKGfo6640id+J8NI3lhxXjAfBLgk3PoH+i+RFC86/1cOX4dsv+wKZZRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123390; c=relaxed/simple;
	bh=+XWdH/l9aGEj66QIAT074n3BMWjgqmF1LBHExf76RPw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o7DpSznqXYEbWLro7NCkISGT8yiolhiu+D7vYwgCHzznoAISG1aO8yW6i9mzPDnalJpueO5w659nn91A2e5lEZm+RqrldJ0qzpVoLiMKkVumG7vTFxSjyKadS8OK24IDcI+rDMOKrXfq+9d+mgH8qpS1t/gYxzNgcjH5s1rjOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arNw8Wrf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714123389; x=1745659389;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+XWdH/l9aGEj66QIAT074n3BMWjgqmF1LBHExf76RPw=;
  b=arNw8WrfrAk51rNkvjh1jEgoldtGADtVqXNywczhzDHKhF3/XNTMXkqQ
   jBbWobUCC7D5XTaHMiGs38+vh8h5yrsw9fdtp8o38sUww91buCDwgwIG0
   MTbwPyCJcNx+vmCPgXhjkLfF+4aZu+V0M/E89MpjTTcHr3iEmQdequ2XT
   cyqNnB3SXr4zqjnQ2b74Soo2axM2a+r+JvE/nNMEJ1AhroiuRK9KIc0Bz
   Lrs/ekTYaQh/dZdaj4GfQ4whQlyYG7LKbZ3TwouwN7V/+z1yYy4iF1B69
   rBfQD5tdwUdjIuZx1FZzVR14ClTB8iGU8vJMx4G5RKoUBXnXuDnT9GkXh
   Q==;
X-CSE-ConnectionGUID: Gpu8xEi1QpKNJgYMa89Oiw==
X-CSE-MsgGUID: ih3vMISFQASYb9FvH0Qg7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="35240892"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="35240892"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 02:23:08 -0700
X-CSE-ConnectionGUID: UjfMWm4mRhej13SGmeht3w==
X-CSE-MsgGUID: PYb66SGeRZy3MOVcsJIQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30018953"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.43])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 02:23:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Apr 2024 12:23:00 +0300 (EEST)
To: Lyndon Sanche <lsanche@lyndeno.ca>
cc: mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de, 
    srinivas.pandruvada@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2] platform/x86: dell-laptop: Implement
 platform_profile
In-Reply-To: <20240426020448.10862-1-lsanche@lyndeno.ca>
Message-ID: <e861d645-0908-d68b-87ad-0b8b8999fc06@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca> <20240426020448.10862-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Apr 2024, Lyndon Sanche wrote:

> Some Dell laptops support configuration of preset
> fan modes through smbios tables.
> 
> If the platform supports these fan modes, set up
> platform_profile to change these modes. If not
> supported, skip enabling platform_profile.
> 
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---

Two things:
- You're missing patch version history (put it below the --- line)
- Don't send updates so soon, give people time to comment. When I saw v1 
  for the first time, you had already posted the next version.

> +void thermal_cleanup(void)
> +{
> +	platform_profile_remove();
> +	kfree(thermal_handler);
> +}
> +
>  static struct led_classdev mute_led_cdev = {
>  	.name = "platform::mute",
>  	.max_brightness = 1,
> @@ -2238,6 +2452,12 @@ static int __init dell_init(void)
>  		goto fail_rfkill;
>  	}
>  
> +	// Do not fail module if thermal modes not supported,
> +	// just skip
> +	ret = thermal_init();
> +	if (ret)
> +		goto fail_thermal;
> +
>  	if (quirks && quirks->touchpad_led)
>  		touchpad_led_init(&platform_device->dev);
>  
> @@ -2317,6 +2537,8 @@ static int __init dell_init(void)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
>  	dell_cleanup_rfkill();
> +fail_thermal:
> +	thermal_cleanup();
>  fail_rfkill:
>  	platform_device_del(platform_device);
>  fail_platform_device2:
> @@ -2344,6 +2566,7 @@ static void __exit dell_exit(void)
>  		platform_device_unregister(platform_device);
>  		platform_driver_unregister(&platform_driver);
>  	}
> +	thermal_cleanup();

This is still not right, you'll still platform_profile_remove() even if 
the init side call failed.

-- 
 i.


