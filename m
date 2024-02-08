Return-Path: <linux-kernel+bounces-58465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52884E6D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834322825C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B648823CD;
	Thu,  8 Feb 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCxgwkhG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380A76416
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413633; cv=none; b=qB7x0I0j2tsrGwQ5SaEHxGjykeSCFe3OQwegLUMfO155/Amc+C/lvzHYyrROvqUIUegibNIhAZ2ekfdIuFwgmOUyqBqBQQ2ldufGr8ARgjcGvgh1ZyUyEnYw9/RkN/JIkufOieYa49xxml/vp+kYWRUththN1fp/CEFwwdSO29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413633; c=relaxed/simple;
	bh=D9ZR//xJdvKdHMg46MrHr4eqP0WZAvuqR1WUb+gTQp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzeigSy9WiwBHi8leiVb8T9jZyCRuCc1sLGvLjwOwe1hVEX10bvgv44TxrFI6xQiG2WZxvcRpObYEq1gfJDmEDRO4JfLjs+Ku83FyxIkyaTtNNxvWUSmNegvH+UlCBrufUwA2HYQanNp0T4CM6NRbFT8qUdbWBiB3QAy6v8Q5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCxgwkhG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707413632; x=1738949632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D9ZR//xJdvKdHMg46MrHr4eqP0WZAvuqR1WUb+gTQp0=;
  b=ZCxgwkhGkCG6Cdge5i4BUstkJug2tA03Z7xJPVMP7CfY7aDwrIdH2e3y
   4WRWT1xbCE10OPAh4sLTzKzrh1a9QElxw/DGsBc95aCaITst/1T16ABx7
   +ji7lFjZNL+l/gWB8xWQJpfHX5dgaJbAt5ltq4Bl71SG1WS6vc3T9O/Au
   E7T13ZyB0zhXZoesUOyoC9fbmF6AwFeTIvrgUrR13AJBe9IRyjosYQ+MY
   3cclOJwwBNka7i4nLcthZ9jCmMlyN/hWw0o8iVK3FvquKxjd1hQpbWmDc
   bA5Q5h+ovCqcXwogqwQhoGBF4VqmLyLV5tRePwhTzkM3SSLj2awi/RBXz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1429203"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1429203"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:33:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910438208"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910438208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:33:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY8HS-00000002wDP-2BMX;
	Thu, 08 Feb 2024 19:33:46 +0200
Date: Thu, 8 Feb 2024 19:33:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: `intel_lpss_pci_driver_init` takes 23.8 ms
Message-ID: <ZcUQen0nYAAtZVw8@smile.fi.intel.com>
References: <ebd4dd9d-3710-4cbb-92d1-c3f73b66bc97@molgen.mpg.de>
 <20240208085928.GB689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208085928.GB689448@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 08:59:28AM +0000, Lee Jones wrote:
> On Tue, 06 Feb 2024, Paul Menzel wrote:

> > On the Dell XPS 13 9360 and Linux 6.8-rc3+, `intel_lpss_pci_driver_init()`
> > takes 23.8 ms, making it one of Linux’ longer init functions on this device:

Does it mean on the previous releases it was different?
I mean is it a regression or always was like this?

> > 
> > ```
> > [    0.000000] Linux version 6.8.0-rc3
> > (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0, GNU
> > ld (GNU Binutils for Debian) 2.42) #13 SMP PREEMPT_DYNAMIC Tue Feb 6
> > 08:07:48 CET 2024
> > [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.8.0-rc3
> > root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer
> > mem_sleep_default=deep log_buf_len=8M cryptomgr.notests initcall_debug
> > […]
> > [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> > […]
> > [    0.785696] calling  intel_lpss_pci_driver_init+0x0/0xff0
> > [intel_lpss_pci] @ 153
> > [    0.785704] calling  crct10dif_intel_mod_init+0x0/0xff0
> > [crct10dif_pclmul] @ 163
> > [    0.785796] calling  drm_core_init+0x0/0xff0 [drm] @ 161
> > [    0.785880] ACPI: bus type drm_connector registered
> > [    0.785887] initcall drm_core_init+0x0/0xff0 [drm] returned 0 after 25
> > usecs
> > [    0.785936] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> > [    0.786210] idma64 idma64.0: Found Intel integrated DMA 64-bit
> > [    0.786221] probe of idma64.0 returned 0 after 81 usecs
> > […]
> > [    0.801676] probe of i2c_designware.0 returned 0 after 15424 usecs
> > [    0.801691] probe of 0000:00:15.0 returned 0 after 15973 usecs
> > [    0.801870] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> > [    0.802116] idma64 idma64.1: Found Intel integrated DMA 64-bit
> > [    0.802123] probe of idma64.1 returned 0 after 55 usecs
> > [    0.819818] probe of i2c_designware.1 returned 0 after 17646 usecs
> > [    0.819832] probe of 0000:00:15.1 returned 0 after 18137 usecs
> > [    0.819852] initcall intel_lpss_pci_driver_init+0x0/0xff0
> > [intel_lpss_pci] returned 0 after 23842 usecs
> > ```
> > 
> > Is this expected, that probing
> > 
> >     00:15.1 Signal processing controller [1180]: Intel Corporation Sunrise
> > Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
> > 
> > takes 18 ms?

And it seems that the real culprit is the DesingWare driver itself, am I wrong?

-- 
With Best Regards,
Andy Shevchenko



