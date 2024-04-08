Return-Path: <linux-kernel+bounces-135558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C589C7A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5F6B28FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B34E13F424;
	Mon,  8 Apr 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V75jr4Yd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFA13F00C;
	Mon,  8 Apr 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588027; cv=none; b=GLHbrdj0LZERbRL2+XjMWgBqs5WAXcuI2NZMewDVZfs8PyBPk+8zkZL0DDYpPAH9X5U1gNkJ5MQrtUyprYc0btcX+bQ4Y0NdTHr2uwSwrLD+BgE3vWUWy22WuHlLEstCgJKKyf12ksgbl/N/cCrennhAUKMTosT9AOFNOubMMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588027; c=relaxed/simple;
	bh=AK+lD0LkkHBN0l2USNKLGjDbz6OKeZ2Y2Lhm4uXfw0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCvyE6WUVqTBGo/MEHDKn5QBNbxKV6gYzhVcve6tcGASqMJz5JcfKQc7EhgOJBmoeyL9kNqIhS39aUAsjp9uNEZOCsrE/IoCr3Ww/zdtqLBqWkHstbtC4Hx0snHmiWhyXHGK2ze2kmv7cYIH8NRRpv41VV2z3MpaVT7zQ7ERVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V75jr4Yd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712588026; x=1744124026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AK+lD0LkkHBN0l2USNKLGjDbz6OKeZ2Y2Lhm4uXfw0k=;
  b=V75jr4YdWOxsTQqjm3CN8V40KhFKp764E7IY/J6bzSJFDEDg4kBBC0gT
   V1WzLYl8jW2VqHwr3to3ibsoXDtcFtUbnFsy4l3NfF0f1EAH3r1Q67zEa
   LtUbHFkALpVpcbDWnv31Z4ZXNgAJKYQEAtuvAR3w8457r3Pn4UPP8Wf8v
   /KvMpbfiGB5WK28OHWJwPMDTsl1N0z9TNxjEyJrnUrTZLfVH0AWtSpT5G
   izr1TL/bGvLnbOcrjoSYKGQXR62mHJQ0/Um/w81p0wnDUs8inKaYhCQBF
   sh0w8GVchmRZc4kKBLlkCw7QxoyQ7fxJPLQJhY60aOnEPC1ECrf1VvDTf
   w==;
X-CSE-ConnectionGUID: 0h9GVrrxRjeNonPhOSNCTA==
X-CSE-MsgGUID: CE8Ar+SuR0m5aAwgQ4YAUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7726140"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7726140"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 07:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915367722"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915367722"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 07:53:44 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtqNS-00000002YTR-03sE;
	Mon, 08 Apr 2024 17:53:42 +0300
Date: Mon, 8 Apr 2024 17:53:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1] ACPI: Declare acpi_blacklisted() only if CONFIG_X86
 is enabled
Message-ID: <ZhQE9dU-VIcWI6au@smile.fi.intel.com>
References: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Apr 06, 2024 at 11:33:41PM -0700, Kuppuswamy Sathyanarayanan wrote:
> The function acpi_blacklisted() is defined only when CONFIG_X86 is
> enabled. So to keep it consistent, protect its declaration with
> CONFIG_X86.

..

>  extern char acpi_video_backlight_string[];
>  extern long acpi_is_video_device(acpi_handle handle);
> +#ifdef CONFIG_X86
>  extern int acpi_blacklisted(void);
> +#endif
>  extern void acpi_osi_setup(char *str);
>  extern bool acpi_osi_is_win8(void);

IIRC there is already similar ifdeffery, can we just move the declaration
there?

-- 
With Best Regards,
Andy Shevchenko



