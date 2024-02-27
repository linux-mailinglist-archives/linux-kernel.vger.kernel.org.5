Return-Path: <linux-kernel+bounces-83288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BD869151
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4881F25F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FBD13B2A7;
	Tue, 27 Feb 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bp6R5fnG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A913A88C;
	Tue, 27 Feb 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039126; cv=none; b=IkCdo8evV8gHh7e6h0JUQSJJYar7d7qWF4P2FeNAJe+T8BnqmlBcCF9UlFWU108+7Jt4ePcwzRhVE40PBn0JllZHVY8d6/HDJSzCG1DUMdQ74ySLXkUAADCC2W1TSM1P11zS29aL0d5zA88mIEsqeMPtJqGtbEtI0PZA5NCexOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039126; c=relaxed/simple;
	bh=NGxHsT//Fk7PPnSaeyki4VGAuhu1uUTpcQGSybWfVVA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jv4fNTvqqj4m5x8gPRC2Z9msx/0hMM3IgqLxdLCDriWFwuFVvQfd9QmdKHuELiPqSu3X4QzDHbjbaLI1LqXwNOpZt7KMrE55C8PhYa7E+6iEGgQMfV/b7u3iBYUTPE9lBGFspZZUXQ3lkP/Zn/+XyQ/OHptdBbJH6cD9zlsZEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bp6R5fnG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709039125; x=1740575125;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NGxHsT//Fk7PPnSaeyki4VGAuhu1uUTpcQGSybWfVVA=;
  b=bp6R5fnGPSEMs2k5/Fx8wZqcvPJF4/eGdpoMn1AYUBVOo90WJUZ0CLAF
   WFS3o7dLqFrAwKIJYvok1mrKQ4ZD3Ka8ouJyGaCIvJFiXcujBQWXJuYyC
   Emz4Y0TjdFp0UXoULETQWaKerQ/XAALCGcDxH8U41pYZU6FPUBKKt3/uZ
   oAAv5I3Ba7vCniT/1AXK5Jh0TZ5ILqgdrOwfXqlMeCGcZA/DSiwkZC8Op
   TWjBZ5pXT849eyh+zamXytdyvLEtOTTYgVQsNV+C3EP3Vp8p9MSRAJJsh
   uR3NU2/XhDD5oes4KD2vPyBnIv51qXu8/v8h9bz1QPbeW0tlqqnwwI+rx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3247094"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3247094"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7001991"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:05:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 15:05:15 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: jithu.joseph@intel.com, linux@weissschuh.net, pali@kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, Dell.Client.Kernel@dell.com, 
    jdelvare@suse.com, linux@roeck-us.net, platform-driver-x86@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] platform/x86: wmi: Remove obsolete duplicate GUID
 allowlist
In-Reply-To: <20240226193557.2888-3-W_Armin@gmx.de>
Message-ID: <d1244489-6e0b-8209-5b2c-e2af7425e110@linux.intel.com>
References: <20240226193557.2888-1-W_Armin@gmx.de> <20240226193557.2888-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 26 Feb 2024, Armin Wolf wrote:

> The whitelist-based approach for preventing older WMI drivers from
> being instantiated multiple times has many drawbacks:
> 
> - uses cannot see all available WMI devices (if not whitelisted)
> - whitelisting a WMI driver requires changes in the WMI driver core
> - maintenance burden for driver and subsystem developers
> 
> Since the WMI driver core already takes care that older WMI drivers
> are not being instantiated multiple times, remove the now redundant
> whitelist.
> 
> Tested on a ASUS Prime B650-Plus.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 39 --------------------------------------
>  1 file changed, 39 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 349deced87e8..1920e115da89 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -90,16 +90,6 @@ static const struct acpi_device_id wmi_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
> 
> -/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
> -static const char * const allow_duplicates[] = {
> -	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
> -	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
> -	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
> -	"86CCFD48-205E-4A77-9C48-2021CBEDE341",	/* intel-wmi-thunderbolt */
> -	"F1DDEE52-063C-4784-A11E-8A06684B9B01",	/* dell-smm-hwmon */
> -	NULL
> -};

Great work, thank you.

I've applied the series to review-ilpo.

-- 
 i.


