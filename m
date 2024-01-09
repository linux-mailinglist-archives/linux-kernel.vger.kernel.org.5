Return-Path: <linux-kernel+bounces-20429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4422C827EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4277285CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C646FA9;
	Tue,  9 Jan 2024 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNc6AL1z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4366126
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704781419; x=1736317419;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=/vPmnM/VJezH4+qTlzkgeqmu5/Dnnr3GHYGLvir4M0I=;
  b=XNc6AL1zAGcNt+5jdsTyroLYtvhwB8HcDYKBzh22Z6UUXEuwRvXCRvV2
   kAmGY/gYvtmVKu0B6qIXQhcq1UICkZodQFroamBEoYmbsD5OVX+WHYt6S
   pfe1vdwIvo7eWUVOyHC80gcFl+p5ztuI2hgf0wGTz7fXXnoUQzZEqqlTw
   jLQXcnfV3P2pQVlkjsSeALiDMHsovrYHCFhTwpbH4aXChG63nVuAUH+0D
   yrYUwqlnop3z2K+wZihPiGYahVh3bOolRApo2H6U74q2Xk4EXwrf0WFRb
   LBXf5BQieNGbdJtEwI3N66tQRJdpgZTPioxvgmpGZhYBP5uub4zh2zm8z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5464469"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="5464469"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 22:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="815858401"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="815858401"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.238.130.17]) ([10.238.130.17])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 22:23:34 -0800
Message-ID: <d5ad4801-6061-42ee-aafb-129a78e5a2b8@linux.intel.com>
Date: Tue, 9 Jan 2024 14:23:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Ido Schimmel <idosch@idosch.org>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
 john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder> <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <15a058ba-3b51-46f3-bb1c-23792d100b55@linux.intel.com>
In-Reply-To: <15a058ba-3b51-46f3-bb1c-23792d100b55@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/9/2024 1:54 PM, Ethan Zhao wrote:
>
> On 1/9/2024 1:35 AM, Robin Murphy wrote:
>> On 2023-12-28 12:23 pm, Ido Schimmel wrote:
>>> On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
>>>> v2: 
>>>> https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
>>>>
>>>> Hi all,
>>>>
>>>> I hope this is good to go now, just fixed the locking (and threw
>>>> lockdep at it to confirm, which of course I should have done to begin
>>>> with...) and picked up tags.
>>>
>>> Hi,
>>>
>>> After pulling the v6.7 changes we started seeing the following memory
>>> leaks [1] of 'struct iova_magazine'. I'm not sure how to reproduce it,
>>> which is why I didn't perform bisection. However, looking at the
>>> mentioned code paths, they seem to have been changed in v6.7 as part of
>>> this patchset. I reverted both patches and didn't see any memory leaks
>>> when running a full regression (~10 hours), but I will repeat it to be
>>> sure.
>>>
>>> Any idea what could be the problem?
>>
>> Hmm, we've got what looks to be a set of magazines forming a 
>> plausible depot list (or at least the tail end of one):
>>
>> ffff8881411f9000 -> ffff8881261c1000
>>
>> ffff8881261c1000 -> ffff88812be26400
>>
>> ffff88812be26400 -> ffff8188392ec000
>>
>> ffff8188392ec000 -> ffff8881a5301000
>>
>> ffff8881a5301000 -> NULL
>>
>> which I guess has somehow become detached from its rcache->depot 
>> without being freed properly? However I'm struggling to see any 
>> conceivable way that could happen which wouldn't already be more 
>> severely broken in other ways as well (i.e. either general memory 
>> corruption or someone somehow still trying to use the IOVA domain 
>> while it's being torn down).
>>
>> Out of curiosity, does reverting just patch #2 alone make a 
>> difference? And is your workload doing anything "interesting" in 
>> relation to IOVA domain lifetimes, like creating and destroying 
>> SR-IOV virtual functions, changing IOMMU domain types via sysfs, or 
>> using that horrible vdpa thing, or are you seeing this purely from 
>> regular driver DMA API usage?
>
> There no lock held when free_iova_rcaches(), is it possible 
> free_iova_rcaches() race with the delayed cancel_delayed_work_sync() ?
>
> I don't know why not call cancel_delayed_work_sync(&rcache->work); 
> first in free_iova_rcaches() to avoid possible race.
>
between following functions pair, race possible ? if called cocurrently.

1. free_iova_rcaches() with iova_depot_work_func()

    free_iova_rcaches() holds no lock, iova_depot_work_func() holds 
rcache->lock.

2. iova_cpuhp_dead() with iova_depot_work_func()

   iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock, 
iova_depot_work_func() holds rcache->lock.

3. iova_cpuhp_dead() with free_iova_rcaches()

    iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock, 
free_iova_rcaches() holds no lock.

4. iova_cpuhp_dead() with free_global_cached_iovas()

    iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock and 
free_global_cached_iovas() holds rcache->lock.

.....

Thanks,

Ethan


>
> Thanks,
>
> Ethan
>
>>
>> Thanks,
>> Robin.
>>
>>>
>>> Thanks
>>>
>>> [1]
>>> unreferenced object 0xffff8881a5301000 (size 1024):
>>>    comm "softirq", pid 0, jiffies 4306297099 (age 462.991s)
>>>    hex dump (first 32 bytes):
>>>      00 00 00 00 00 00 00 00 e7 7d 05 00 00 00 00 00 .........}......
>>>      0f b4 05 00 00 00 00 00 b4 96 05 00 00 00 00 00 ................
>>>    backtrace:
>>>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>>>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>>>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>>>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>>>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>>>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>>>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>>>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>>>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>>>
>>> unreferenced object 0xffff8881392ec000 (size 1024):
>>>    comm "softirq", pid 0, jiffies 4306326731 (age 433.359s)
>>>    hex dump (first 32 bytes):
>>>      00 10 30 a5 81 88 ff ff 50 ff 0f 00 00 00 00 00 ..0.....P.......
>>>      f3 99 05 00 00 00 00 00 87 b7 05 00 00 00 00 00 ................
>>>    backtrace:
>>>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>>>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>>>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>>>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>>>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>>>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>>>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>>>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>>>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>>>
>>> unreferenced object 0xffff8881411f9000 (size 1024):
>>>    comm "softirq", pid 0, jiffies 4306708887 (age 51.459s)
>>>    hex dump (first 32 bytes):
>>>      00 10 1c 26 81 88 ff ff 2c 96 05 00 00 00 00 00 ...&....,.......
>>>      ac fe 0f 00 00 00 00 00 a6 fe 0f 00 00 00 00 00 ................
>>>    backtrace:
>>>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>>>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>>>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>>>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>>>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>>>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>>>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>>>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>>>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>>>
>>> unreferenced object 0xffff88812be26400 (size 1024):
>>>    comm "softirq", pid 0, jiffies 4306710027 (age 50.319s)
>>>    hex dump (first 32 bytes):
>>>      00 c0 2e 39 81 88 ff ff 32 ab 05 00 00 00 00 00 ...9....2.......
>>>      e3 ac 05 00 00 00 00 00 1f b6 05 00 00 00 00 00 ................
>>>    backtrace:
>>>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>>>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>>>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>>>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>>>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>>>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>>>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>>>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>>>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>>>
>>> unreferenced object 0xffff8881261c1000 (size 1024):
>>>    comm "softirq", pid 0, jiffies 4306711547 (age 48.799s)
>>>    hex dump (first 32 bytes):
>>>      00 64 e2 2b 81 88 ff ff c0 7c 05 00 00 00 00 00 .d.+.....|......
>>>      87 a5 05 00 00 00 00 00 0e 9a 05 00 00 00 00 00 ................
>>>    backtrace:
>>>      [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
>>>      [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
>>>      [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
>>>      [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
>>>      [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
>>>      [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
>>>      [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
>>>      [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
>>>      [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5
>>
>

