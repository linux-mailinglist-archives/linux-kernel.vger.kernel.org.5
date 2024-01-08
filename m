Return-Path: <linux-kernel+bounces-19902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B68D827671
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1765E1C21ADF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881CE55C01;
	Mon,  8 Jan 2024 17:35:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6496B5466A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDBE3C15;
	Mon,  8 Jan 2024 09:36:20 -0800 (PST)
Received: from [10.57.42.133] (unknown [10.57.42.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DE003F73F;
	Mon,  8 Jan 2024 09:35:33 -0800 (PST)
Message-ID: <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
Date: Mon, 8 Jan 2024 17:35:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Content-Language: en-GB
To: Ido Schimmel <idosch@idosch.org>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
 john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZY1osaGLyT-sdKE8@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-28 12:23 pm, Ido Schimmel wrote:
> On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
>> v2: https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
>>
>> Hi all,
>>
>> I hope this is good to go now, just fixed the locking (and threw
>> lockdep at it to confirm, which of course I should have done to begin
>> with...) and picked up tags.
> 
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

Hmm, we've got what looks to be a set of magazines forming a plausible 
depot list (or at least the tail end of one):

ffff8881411f9000 -> ffff8881261c1000

ffff8881261c1000 -> ffff88812be26400

ffff88812be26400 -> ffff8188392ec000

ffff8188392ec000 -> ffff8881a5301000

ffff8881a5301000 -> NULL

which I guess has somehow become detached from its rcache->depot without 
being freed properly? However I'm struggling to see any conceivable way 
that could happen which wouldn't already be more severely broken in 
other ways as well (i.e. either general memory corruption or someone 
somehow still trying to use the IOVA domain while it's being torn down).

Out of curiosity, does reverting just patch #2 alone make a difference? 
And is your workload doing anything "interesting" in relation to IOVA 
domain lifetimes, like creating and destroying SR-IOV virtual functions, 
changing IOMMU domain types via sysfs, or using that horrible vdpa 
thing, or are you seeing this purely from regular driver DMA API usage?

Thanks,
Robin.

> 
> Thanks
> 
> [1]
> unreferenced object 0xffff8881a5301000 (size 1024):
>    comm "softirq", pid 0, jiffies 4306297099 (age 462.991s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 e7 7d 05 00 00 00 00 00  .........}......
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

