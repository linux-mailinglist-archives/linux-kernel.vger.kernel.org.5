Return-Path: <linux-kernel+bounces-91172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58632870AA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E781C21092
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1B79DDC;
	Mon,  4 Mar 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlrHhgUp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB679DD2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580175; cv=none; b=Qr45kixv/8dLEOFlOel53hGxd8+0H68GaQ4iNmBU0uF2fkHw4ogVrz5h03RynWKeE8nq+5GnTVjPOD/547YRbMT0f0CT56vtW5P6W/yTaJTNEbz8Q/XK1GTHDk5SA851XhQtWHuB6ItiFThNcXwsJ1E87GHO4OLQbcUSlGhz088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580175; c=relaxed/simple;
	bh=gu6dVSunCIFCpLeuEc/63FWNsSyCb49Yi3j6XSa+y2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2CqWKsLDbfku4vjM/9CoyqA/UJOsYQJBwOHM0VPepSYl0X8kC4vky/zSP+qn4F1cHkrK5UeCf1v+tBLEm2g+0NIPFsa4KQumkOWwDOK5/UxSVyvDavUnOlEz/QZFC2u2nht5TWyOaoehG5Yz4u7V3flIZGsXMRepv4gEu4KTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlrHhgUp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709580174; x=1741116174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gu6dVSunCIFCpLeuEc/63FWNsSyCb49Yi3j6XSa+y2A=;
  b=GlrHhgUpBJBftvSsHfsc6GgqV/K09F3AS+71G8SOY5TM7bUUscpQnE+Q
   8PvjUM9hGohI0tiXGGJblIkFEOxPf/y/0EBdyB7QLh/+b2z3QYYssDYkJ
   a+V2Qe6x/7vILjZ+xwYhOdhccCYpGOFPSDwvrGKzTtujN3IDc52yNKbBj
   l9VUWGWvGA4NFEfiRFZSf9Oy+hUbIREf/exDojje04/seRfs1g/ysgpfh
   VtH3jxkhHWEZbtWPUzRnKzVUdz92VeFkEq5cyrkt2geW9c55BlvYIctdd
   dzzOOHBSrCGwim7YAAyHft1FTR/hjpyDRPoLmhZYvQxbGX1EnOj1MT5Oi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3956561"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3956561"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9685702"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:22:53 -0800
Received: from [10.213.180.29] (kliang2-mobl1.ccr.corp.intel.com [10.213.180.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 313295807E7;
	Mon,  4 Mar 2024 11:22:52 -0800 (PST)
Message-ID: <b16add91-30c4-43e6-bcf8-11ca8aeaa783@linux.intel.com>
Date: Mon, 4 Mar 2024 14:22:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unchecked MSR access error: WRMSR to 0xd84 (tried to write
 0x0000000000010003) at rIP: 0xffffffffa025a1b8
 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])
To: Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Antonov <alexander.antonov@linux.intel.com>,
 lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20240304181841.GCZeYQgbZk6fdntg-X@fat_crate.local>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240304181841.GCZeYQgbZk6fdntg-X@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-04 1:18 p.m., Borislav Petkov wrote:
> Hi all,
> 
> sending this to a bunch of people who have touched this function
> recently and some more relevant Intel folks.
> 
> The machine is an old SNB:
> 
> smpboot: CPU0: Intel(R) Xeon(R) CPU E5-1620 0 @ 3.60GHz (family: 0x6, model: 0x2d, stepping: 0x7)
> 
> and with latest linus/master + tip/master it gives the below.
> 
> It must be something new because 6.8-rc6 is fine.
> 
> ...
> i801_smbus 0000:00:1f.3: enabling device (0000 -> 0003)
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
> i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> ACPI: button: Power Button [PWRF]
> i2c i2c-14: 4/4 memory slots populated (from DMI)
> unchecked MSR access error: WRMSR to 0xd84 (tried to write 0x0000000000010003) at rIP: 0xffffffffa025a1b8 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])

The 0xd84 is the box control MSR of the CBOX 4 (Please find the
definition of the MSR from page 11 of
https://www.intel.com/content/www/us/en/develop/download/intel-xeon-processor-e5-v2-and-e7-v2-product-families-uncore-performance-monitoring.html).

It looks like the driver tries to access the CBOX 4, but it is not
available on the machine.

The number of available CBOXs on a SNBEP machine is determined at boot
time. It should not be larger than the maximum number of cores.
The recent commit 89b0f15f408f ("x86/cpu/topology: Get rid of
cpuinfo::x86_max_cores") change the boot_cpu_data.x86_max_cores to
topology_num_cores_per_package().
I guess the new function probably returns a different maximum number of
cores on the machine. But I don't have a SNBEP on my hands. Could you
please help to check whether a different maximum number of cores is
returned?

Thanks,
Kan

> Call Trace:
>  <TASK>
>  ? ex_handler_msr+0xcb/0x130
>  ? fixup_exception+0x166/0x320
>  ? exc_general_protection+0xd7/0x3f0
>  ? asm_exc_general_protection+0x22/0x30
>  ? snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore]
>  uncore_box_ref.part.0+0x9c/0xc0 [intel_uncore]
>  ? __pfx_uncore_event_cpu_online+0x10/0x10 [intel_uncore]
>  uncore_event_cpu_online+0x56/0x140 [intel_uncore]
>  ? __pfx_uncore_event_cpu_online+0x10/0x10 [intel_uncore]
>  cpuhp_invoke_callback+0x174/0x5e0
>  ? cpuhp_thread_fun+0x5a/0x200
>  cpuhp_thread_fun+0x17e/0x200
>  ? smpboot_thread_fn+0x2b/0x250
>  smpboot_thread_fn+0x1ad/0x250
>  ? __pfx_smpboot_thread_fn+0x10/0x10
>  kthread+0xed/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x30/0x50
>  ? __pfx_kthread+0x10/0x10
> iTCO_vendor_support: vendor-support=0
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> iTCO_wdt iTCO_wdt.1.auto: Found a Patsburg TCO device (Version=2, TCOBASE=0x0460)
> iTCO_wdt iTCO_wdt.1.auto: initialized. heartbeat=30 sec (nowayout=0)
> RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
> ...
> 
> Thx.
> 

