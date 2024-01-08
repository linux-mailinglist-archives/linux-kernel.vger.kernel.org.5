Return-Path: <linux-kernel+bounces-19059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2204826759
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145911F215D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A879D8;
	Mon,  8 Jan 2024 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRSMyWqo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B763A5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704683607; x=1736219607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMr5O8x9hphdH+d7Y+wNXoe+z8M2VT/crc2vHlXLMlk=;
  b=TRSMyWqoSAS5iTHs19LDmmlszhXgdcmXGe+x6ookZUknJ9R83q5CYKGl
   Rxy5jg/blVbAlJHQ54L+0dmTnFMISpldWeRTJj2saTwHRU4WjVYuz6mrv
   gpfq/Zq9sdzQufLtrMprO6kStXLkAFK45FNVx3aUFxQ85x7VA19fqoE1H
   /VaUmtkOAcEhktNh2bMR8JF25Mjxt9gAQH9DK5PneZV//ZcRLjhu2oNqM
   CBtEPmDaB5KZ3EiS6YGApYkx1cF5XH16kjMbs1jQIgjQxUfXw88ubKK9K
   GodT4sap077DrqBAWQeiKXktkkKg5Zue3meeh3CvG1cYNgk0MoJG24GcY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="428968370"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="428968370"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:13:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="29645627"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.19.162]) ([10.93.19.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:13:24 -0800
Message-ID: <b6eb2bf8-6d7b-4197-aeec-2c7d13920024@linux.intel.com>
Date: Mon, 8 Jan 2024 11:13:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
To: Ido Schimmel <idosch@idosch.org>, Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
 john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <ZY1osaGLyT-sdKE8@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/28/2023 8:23 PM, Ido Schimmel wrote:
> On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
>> v2: https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
>>
>> Hi all,
>>
>> I hope this is good to go now, just fixed the locking (and threw
>> lockdep at it to confirm, which of course I should have done to begin
>> with...) and picked up tags.
> Hi,
>
> After pulling the v6.7 changes we started seeing the following memory
> leaks [1] of 'struct iova_magazine'. I'm not sure how to reproduce it,
> which is why I didn't perform bisection. However, looking at the
> mentioned code paths, they seem to have been changed in v6.7 as part of
> this patchset. I reverted both patches and didn't see any memory leaks
> when running a full regression (~10 hours), but I will repeat it to be
> sure.
>
> Any idea what could be the problem?
>
> Thanks
>
> [1]
> unreferenced object 0xffff8881a5301000 (size 1024):
>    comm "softirq", pid 0, jiffies 4306297099 (age 462.991s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 e7 7d 05 00 00 00 00 00  .........}......
Here the magazine is empty & loaded, size is 0.
>      0f b4 05 00 00 00 00 00 b4 96 05 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>
> unreferenced object 0xffff8881392ec000 (size 1024):
>    comm "softirq", pid 0, jiffies 4306326731 (age 433.359s)
>    hex dump (first 32 bytes):
>      00 10 30 a5 81 88 ff ff 50 ff 0f 00 00 00 00 00  ..0.....P.......
The above *unreferenced object 0xffff8881a5301000* is referenced here,

00 10 30 a5 81 88 ff ff -> ff ff 88 81 a5 30 10 00

>      f3 99 05 00 00 00 00 00 87 b7 05 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>
> unreferenced object 0xffff8881411f9000 (size 1024):
>    comm "softirq", pid 0, jiffies 4306708887 (age 51.459s)
>    hex dump (first 32 bytes):
>      00 10 1c 26 81 88 ff ff 2c 96 05 00 00 00 00 00  ...&....,.......
>      ac fe 0f 00 00 00 00 00 a6 fe 0f 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>
> unreferenced object 0xffff88812be26400 (size 1024):
>    comm "softirq", pid 0, jiffies 4306710027 (age 50.319s)
>    hex dump (first 32 bytes):
>      00 c0 2e 39 81 88 ff ff 32 ab 05 00 00 00 00 00  ...9....2.......
>      e3 ac 05 00 00 00 00 00 1f b6 05 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>
> unreferenced object 0xffff8881261c1000 (size 1024):
>    comm "softirq", pid 0, jiffies 4306711547 (age 48.799s)
>    hex dump (first 32 bytes):
>      00 64 e2 2b 81 88 ff ff c0 7c 05 00 00 00 00 00  .d.+.....|......

The value of first 8 bytes  is : ff ff 88 81 2b e2 64 00 (little endian)

this is the address of above object 0xffff88812be26400

so the struct is exactly the

struct iova_magazine { union { unsigned long size; struct iova_magazine 
*next; }; unsigned long pfns[IOVA_MAG_SIZE]; };

when the magazine is stored in depot, the member *next is used to

pointer the next magazine.

But when the magzine is loaded, the size member is used,

This report should be *false positive* by kmemleak.

Thanks,

Ethan

>      87 a5 05 00 00 00 00 00 0e 9a 05 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>

