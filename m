Return-Path: <linux-kernel+bounces-118158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E388B516
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69B31C379A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90B082D69;
	Mon, 25 Mar 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLb+KbXc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C55D724
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408468; cv=none; b=oVXX3J2cApKKVhghtNsQ7RI9HOtGmVWOzcT3SvY/dTaA8Yn6/1tnTALnR4A00Sn/qI3jcXhewD8Y0lFl7pah9RQE0pMGMlpSI6m14E8wnR2/5uq1RJCErsIMBVRGIROBpc1ptznUv1mqvMjn934trFCd3vqQy9wvxXLAn80GB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408468; c=relaxed/simple;
	bh=3LWY30PbXE29x93awatGIFqHS/W8xTNAbgVdJaW0XoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elDiQcl3oQT5OHUPGprzqF/8H0YOSNbpJMipVBvo+axqMxiphWzRpl9uRqxJx7RqD1JiAS6JDmMmRkNt0uwVTPwdgHN1FqwDPbWM+EM4zG1B2GwUnkfop6byhLtR1/SdjlnpGDpr6NPEyxvgBv9FMen42CXQfqX/WaVD7zReccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLb+KbXc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711408467; x=1742944467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3LWY30PbXE29x93awatGIFqHS/W8xTNAbgVdJaW0XoA=;
  b=RLb+KbXcrsg1p4U1YXPZl+Hvs9AH4ZAbvEm8QvDabjM6ofxbFjcZ2TL1
   sH8BYOxnwwbaD97VR0l9z3vKoKSFpTqAVMlAaFfjlvosEuCBRzn8HMoBd
   xHLn8D4jqVoF9OtlvZF37H35aVK4ImlylsAxePeH71moFB/vHyl/vW6Bm
   qddAI3gO1zF+MAa0ixsHOoxEmRvnzZ4MjRmqtL7RNGOT/D59SDyOx+7IT
   oRTiP1GuxjXwkV3qI6WuR7L7WvYeH8+OyHAD1DISW4tsyJLxHsVhPzASa
   1fESJZ0rQuiwREMUfU4nradk96ZBRuC8RVsTmoSJTpiA6qecLmbHjMyVT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6301360"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6301360"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 16:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20432093"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 16:14:24 -0700
Date: Mon, 25 Mar 2024 16:14:23 -0700
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 21/24] x86/resctrl: Allow overflow/limbo handlers to
 be scheduled on any-but cpu
Message-ID: <ZgIFT5gZgIQ9A9G7@agluck-desk3>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-22-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213184438.16675-22-james.morse@arm.com>

> -static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> +static inline unsigned int
> +cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  {
>  	unsigned int cpu, hk_cpu;
>  
> -	cpu = cpumask_any(mask);
> -	if (!tick_nohz_full_cpu(cpu))
> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> +		cpu = cpumask_any(mask);
> +	else
> +		cpu = cpumask_any_but(mask, exclude_cpu);
> +
> +	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
> +		return cpu;
> +
> +	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */
> +	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>  		return cpu;
>  
> +	/* Try to find a CPU that isn't nohz_full to use in preference */
>  	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +	if (hk_cpu == exclude_cpu)
> +		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);

               OOPS HERE ^^^^^^^^^^^^^^^^^^
> +
>  	if (hk_cpu < nr_cpu_ids)
>  		cpu = hk_cpu;

James,

I'm playing around with v6.9-rc1. When I take all the CPUs in a domain
offline, resctrl wants to stop the mbm overflow handler. While doing
so it crashes with a NULL dereference in the code above.

At this point the cpu_mask for the domain still has the bit for
the last CPU standing in this domain. So cpumask_any_housekeeping()
is called with a mask that just has CPU 36 set, but request to find
a CPU other than 36.

-Tony

Heres the OOPs:

[   97.107355] smpboot: CPU 37 is now offline
[   97.166136] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   97.173118] #PF: supervisor read access in kernel mode
[   97.178263] #PF: error_code(0x0000) - not-present page
[   97.183410] PGD 0
[   97.185438] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   97.189805] CPU: 36 PID: 235 Comm: cpuhp/36 Tainted: G                T  6.9.0-rc1 #356
[   97.197810] Hardware name: Intel Corporation WilsonCity/WilsonCity, BIOS WLYDCRB1.SYS.0021.P06.2104260458 04/26/2021
[   97.208322] RIP: 0010:__find_nth_andnot_bit+0x66/0x110
[   97.213472] Code: d2 eb 20 48 29 c6 48 8d 41 c0 48 39 ca 0f 82 8b 00 00 00 48 01 f0 48 83 c1 40 48 39 d0 0f 83 9e 00 00 00 4d 89 d3 49 83 c2 01 <4b> 8b 3c d8 48 f7 d7 4b 23 3c d9 f3 48 0f b8 c7 48 39 c6 73 c4 4c
[   97.232214] RSP: 0018:ff462f11872bbd98 EFLAGS: 00010202
[   97.237440] RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000080
[   97.244574] RDX: 0000000000000090 RSI: 0000000000000000 RDI: 0000000000000000
[   97.251705] RBP: ff43a0b049599018 R08: 0000000000000000 R09: ff43a0b049599018
[   97.258835] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000025
[   97.265970] R13: 0000000000000090 R14: 0000000000000000 R15: ffffffffaa068fb0
[   97.273100] FS:  0000000000000000(0000) GS:ff43a0b81d800000(0000) knlGS:0000000000000000
[   97.281187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.286932] CR2: 0000000000000000 CR3: 0000000a50e3a004 CR4: 0000000000771ef0
[   97.294065] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   97.301197] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   97.308328] PKRU: 55555554
[   97.311039] Call Trace:
[   97.313492]  <TASK>
[   97.315600]  ? __die+0x1f/0x60
[   97.318665]  ? page_fault_oops+0x176/0x5a0
[   97.322777]  ? exc_page_fault+0x7f/0x260
[   97.326708]  ? asm_exc_page_fault+0x22/0x30
[   97.330903]  ? __pfx_resctrl_arch_offline_cpu+0x10/0x10
[   97.336140]  ? __find_nth_andnot_bit+0x66/0x110
[   97.340680]  ? __cancel_work+0x7d/0xc0
[   97.344438]  cpumask_any_housekeeping+0x55/0x110
[   97.349060]  mbm_setup_overflow_handler+0x40/0x70
[   97.353774]  resctrl_offline_cpu+0x101/0x110
[   97.358054]  resctrl_arch_offline_cpu+0x19/0x260
[   97.362673]  cpuhp_invoke_callback+0x156/0x6b0
[   97.367127]  ? cpuhp_thread_fun+0x5f/0x250
[   97.371234]  cpuhp_thread_fun+0x1ca/0x250
[   97.375247]  ? __pfx_smpboot_thread_fn+0x10/0x10
[   97.379874]  smpboot_thread_fn+0x184/0x220
[   97.383974]  kthread+0xe0/0x110
[   97.387129]  ? __pfx_kthread+0x10/0x10
[   97.390888]  ret_from_fork+0x2d/0x50
[   97.394467]  ? __pfx_kthread+0x10/0x10
[   97.398220]  ret_from_fork_asm+0x1a/0x30
[   97.402149]  </TASK>


