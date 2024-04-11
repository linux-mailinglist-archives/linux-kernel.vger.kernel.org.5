Return-Path: <linux-kernel+bounces-140387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787F98A13A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7911F22799
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDCA14A4F8;
	Thu, 11 Apr 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1FkFekt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B514A0A4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836534; cv=none; b=F6lu1W5HDUbwXiyT9dxxoR8uuPmSDRNAqXboHZB44z+/AIvk/nruvzMlh3Wy4BgFqb02TziK0wsQrMi1vc5an7TLmGAe62va+fSRVHAAOCplC88Ss+92U2xJZdF2/AlZ5dWSbOnZeCkeHvD0bKnViLvvzySiJH/2cW0y3NWLFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836534; c=relaxed/simple;
	bh=alXo0H8ANdaI1GJGeUlWdQEWdSZmaHDInU3myDZ1M5Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=f9ARIXqolcSuypZwXXVzIjiKxNCzwJvsA7CyTuGBcE0J2+/3M/QR3LOxr/W0JMy5uOvZT6phEweicoMSP17RKaYipQH9l3o8ItVQzHbdZi6rl32bnj6h+yzmX9vdaNW3r8E/dCCih+Fzktkh3K4HWwvwizL0hpSC0nef61/jyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1FkFekt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712836533; x=1744372533;
  h=message-id:date:mime-version:cc:subject:from:to:
   references:in-reply-to:content-transfer-encoding;
  bh=alXo0H8ANdaI1GJGeUlWdQEWdSZmaHDInU3myDZ1M5Q=;
  b=X1FkFekt1xqwtcZLRZXNh0wxGgir6wzuoWQa9uucx41mpQ0xWdjbmW7v
   BNEA3p9Nt/kwJSBEmqTmbCOiqkkcSE30D8rV6FSQAzOOLtoXcavM/izrn
   3EhB9d2GWkWnO987pelw3App7rXK7b035p0nmVWKi0yxuHNwY8kOgHhfb
   tmFu60r7kld9dNFzGhg4tqL7o7bCSXyQoEXgAueSCgvWTzY4kFLAfI+yq
   tS7YqZ+jU17nT2jlhBJYdJDsT93hF8qfs1IEYiy0OhJwgBVoV9/LPgM89
   Ax380LLoRKXkzzA94wy7Q7p/BGyJoWAYFsaM+3wGBn5s7e3lF2BVbcK7k
   Q==;
X-CSE-ConnectionGUID: EAdMRYFBSS6inQG8fDvrUA==
X-CSE-MsgGUID: waUSnDCrSFSplcpSIYjU1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30721963"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="30721963"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:55:33 -0700
X-CSE-ConnectionGUID: LvEhbi8zSCCUwyc42P2LpA==
X-CSE-MsgGUID: 8OVffHXmQnqfIrIkENzLUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="51845828"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:55:31 -0700
Message-ID: <a012652c-d1d3-4556-a521-6f0721650160@linux.intel.com>
Date: Thu, 11 Apr 2024 19:55:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Xuchun Shang <xuchun.shang@linux.alibaba.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu/vt-d: Fix WARN_ON in iommu probe path
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>
References: <20240411030744.273460-1-baolu.lu@linux.intel.com>
 <20240411030744.273460-4-baolu.lu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20240411030744.273460-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/11 11:07, Lu Baolu wrote:
> Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
> devices") adds all devices probed by the iommu driver in a rbtree
> indexed by the source ID of each device. It assumes that each device
> has a unique source ID. This assumption is incorrect and the VT-d
> spec doesn't state this requirement either.
> 
> The reason for using a rbtree to track devices is to look up the device
> with PCI bus and devfunc in the paths of handling ATS invalidation time
> out error and the PRI I/O page faults. Both are PCI ATS feature related.
> 
> Only track the devices that have PCI ATS capabilities in the rbtree to
> avoid unnecessary WARN_ON in the iommu probe path. Otherwise, on some
> platforms below kernel splat will be displayed and the iommu probe results
> in failure.
> 
>   WARNING: CPU: 3 PID: 166 at drivers/iommu/intel/iommu.c:158 intel_iommu_probe_device+0x319/0xd90
>   Call Trace:
>    <TASK>
>    ? __warn+0x7e/0x180
>    ? intel_iommu_probe_device+0x319/0xd90
>    ? report_bug+0x1f8/0x200
>    ? handle_bug+0x3c/0x70
>    ? exc_invalid_op+0x18/0x70
>    ? asm_exc_invalid_op+0x1a/0x20
>    ? intel_iommu_probe_device+0x319/0xd90
>    ? debug_mutex_init+0x37/0x50
>    __iommu_probe_device+0xf2/0x4f0
>    iommu_probe_device+0x22/0x70
>    iommu_bus_notifier+0x1e/0x40
>    notifier_call_chain+0x46/0x150
>    blocking_notifier_call_chain+0x42/0x60
>    bus_notify+0x2f/0x50
>    device_add+0x5ed/0x7e0
>    platform_device_add+0xf5/0x240
>    mfd_add_devices+0x3f9/0x500
>    ? preempt_count_add+0x4c/0xa0
>    ? up_write+0xa2/0x1b0
>    ? __debugfs_create_file+0xe3/0x150
>    intel_lpss_probe+0x49f/0x5b0
>    ? pci_conf1_write+0xa3/0xf0
>    intel_lpss_pci_probe+0xcf/0x110 [intel_lpss_pci]
>    pci_device_probe+0x95/0x120
>    really_probe+0xd9/0x370
>    ? __pfx___driver_attach+0x10/0x10
>    __driver_probe_device+0x73/0x150
>    driver_probe_device+0x19/0xa0
>    __driver_attach+0xb6/0x180
>    ? __pfx___driver_attach+0x10/0x10
>    bus_for_each_dev+0x77/0xd0
>    bus_add_driver+0x114/0x210
>    driver_register+0x5b/0x110
>    ? __pfx_intel_lpss_pci_driver_init+0x10/0x10 [intel_lpss_pci]
>    do_one_initcall+0x57/0x2b0
>    ? kmalloc_trace+0x21e/0x280
>    ? do_init_module+0x1e/0x210
>    do_init_module+0x5f/0x210
>    load_module+0x1d37/0x1fc0
>    ? init_module_from_file+0x86/0xd0
>    init_module_from_file+0x86/0xd0
>    idempotent_init_module+0x17c/0x230
>    __x64_sys_finit_module+0x56/0xb0
>    do_syscall_64+0x6e/0x140
>    entry_SYSCALL_64_after_hwframe+0x71/0x79
> 
> Fixes: 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed devices")
> Closes:https://gitlab.freedesktop.org/drm/intel/-/issues/10689
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Link:https://lore.kernel.org/r/20240407011429.136282-1-baolu.lu@linux.intel.com
> ---
>   drivers/iommu/intel/iommu.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Kevin gave his r-b.

https://lore.kernel.org/linux-iommu/BN9PR11MB52768106FE4890D6481E73178C052@BN9PR11MB5276.namprd11.prod.outlook.com/

Include that in the pull request so that b4 can pick it up.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

