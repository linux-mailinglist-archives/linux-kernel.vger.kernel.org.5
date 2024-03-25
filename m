Return-Path: <linux-kernel+bounces-117175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB688ACC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F8B26FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1FF137776;
	Mon, 25 Mar 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlThblYv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933806CDD6;
	Mon, 25 Mar 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374478; cv=none; b=grLHoQf6a/Ja/b1uR4UeCOnRH2ICKX3S8jLyj7p4O8RKcy+px7bY8EnjvzecrWV44KQWiZygK5a2K/qRMK9kMwCKTzeFZW9ykPkkyHnjJ+nIol5fD8nelAAuxnpE6sJC1piMiTXh6x9/8DrTQQs71W2LYx0xWzLcQZKbCw5AZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374478; c=relaxed/simple;
	bh=iEruMJvxq+UmERlCZDaxB9mRHsXEMs+fp+GFQUEczU0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bKS4zWaQIeGviPTmA5L6mjypdaMKkuq9rzXnHH4Pg8BAofJcy3jvoF4Z79vGHRzneB0wdhtkjdJ6sss/A5BuY5kYpcaLQHfss0bURu9a3zcp28uzR5BcfIimjT0rWhewi2tU6222lPZzOMO5uGY7goOv8MwHINkEHct8AesgX2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlThblYv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711374477; x=1742910477;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iEruMJvxq+UmERlCZDaxB9mRHsXEMs+fp+GFQUEczU0=;
  b=DlThblYv4r268x8gRgZwUYtag3bRum+uYhwH7rdnEdx6H/NnLtsCUrkO
   dtOBrKTiuQ/hTV0Mvc2BwKE6PRGT/1xvhuzcEFzpPKUznTFMFCTobivf+
   n7edIXokKpDxxJpXhcqkElCLrPU2CcHL+mvYxaWS8WxkeBK+7xptNCN20
   /BCFMUs9N84rbMWSwWQSZH8KGE2i0asMiJAwGjIpxznuZLCBU9OBnoQEW
   FrdzaKPkWR5jsMDUtZHpbCGdBh6O9VBilkXcWJduLQGQnT4QavVbtlTBt
   ENdE7z5pDIkEaWpEpVXtN0ylnWYOH+dcqBDY4urodeXgsBgktetyJXkW5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9339611"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="9339611"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15529267"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.19])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:47:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 25 Mar 2024 15:47:46 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] platform/x86: asus-wmi: add support for 2024 ROG
 Mini-LED
In-Reply-To: <20240325054938.489732-2-luke@ljones.dev>
Message-ID: <2cadcf26-7b99-3b32-8441-1b3939cf93b4@linux.intel.com>
References: <20240325054938.489732-1-luke@ljones.dev> <20240325054938.489732-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 25 Mar 2024, Luke D. Jones wrote:

> Support the 2024 mini-led backlight and adjust the related functions
> to select the relevant dev-id. Also add `available_mini_led_mode` to the
> platform sysfs since the available mini-led levels can be different.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
>  drivers/platform/x86/asus-wmi.c               | 74 +++++++++++++++++--
>  include/linux/platform_data/x86/asus-wmi.h    |  1 +
>  3 files changed, 76 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 8a7e25bde085..61a745d2476f 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -126,6 +126,14 @@ Description:
>  		Change the mini-LED mode:
>  			* 0 - Single-zone,
>  			* 1 - Multi-zone
> +			* 2 - Multi-zone strong (available on newer generation mini-led)
> +
> +What:		/sys/devices/platform/<platform>/available_mini_led_mode
> +Date:		Jun 2023
> +KernelVersion:	6.10
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		List the available mini-led modes.
>  
>  What:		/sys/devices/platform/<platform>/ppt_pl1_spl
>  Date:		Jun 2023
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 18be35fdb381..54ce0fb26f42 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -297,6 +297,7 @@ struct asus_wmi {
>  
>  	bool panel_overdrive_available;
>  	bool mini_led_mode_available;
> +	u32 mini_led_dev_id;
>  
>  	struct hotplug_slot hotplug_slot;
>  	struct mutex hotplug_lock;
> @@ -2109,10 +2110,27 @@ static ssize_t mini_led_mode_show(struct device *dev,
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	int result;
>  
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
> -	if (result < 0)
> -		return result;
> +	result = asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_id);
>  
> +	/* Remap the mode values to match previous generation mini-led.
> +	 * Some BIOSes return -19 instead of 2, which is "mini-LED off", this
> +	 * appears to be a  BIOS bug.
> +	 */
> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +		switch (result) {
> +		case 0:
> +			result = 1;
> +			break;
> +		case 1:
> +			result = 2;
> +			break;
> +		case 2:
> +		case -19:

Can you confirm this -19 really does come from BIOS? Because I suspect 
it's -ENODEV error code from from one of the functions on the driver side
(which is why I asked you to change it into -ENODEV).


-- 
 i.


