Return-Path: <linux-kernel+bounces-20772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64580828500
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DE61F25774
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253637168;
	Tue,  9 Jan 2024 11:26:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438637142
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF7FC15;
	Tue,  9 Jan 2024 03:26:53 -0800 (PST)
Received: from [10.57.44.233] (unknown [10.57.44.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 236E33F73F;
	Tue,  9 Jan 2024 03:26:06 -0800 (PST)
Message-ID: <7eaa0f41-a71b-43c1-8596-1df99584530a@arm.com>
Date: Tue, 9 Jan 2024 11:26:04 +0000
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
To: Ethan Zhao <haifeng.zhao@linux.intel.com>,
 Ido Schimmel <idosch@idosch.org>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
 john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder> <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <15a058ba-3b51-46f3-bb1c-23792d100b55@linux.intel.com>
 <d5ad4801-6061-42ee-aafb-129a78e5a2b8@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <d5ad4801-6061-42ee-aafb-129a78e5a2b8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-01-09 6:23 am, Ethan Zhao wrote:
> 
> On 1/9/2024 1:54 PM, Ethan Zhao wrote:
>>
>> On 1/9/2024 1:35 AM, Robin Murphy wrote:
>>> On 2023-12-28 12:23 pm, Ido Schimmel wrote:
>>>> On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
>>>>> v2: 
>>>>> https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
>>>>>
>>>>> Hi all,
>>>>>
>>>>> I hope this is good to go now, just fixed the locking (and threw
>>>>> lockdep at it to confirm, which of course I should have done to begin
>>>>> with...) and picked up tags.
>>>>
>>>> Hi,
>>>>
>>>> After pulling the v6.7 changes we started seeing the following memory
>>>> leaks [1] of 'struct iova_magazine'. I'm not sure how to reproduce it,
>>>> which is why I didn't perform bisection. However, looking at the
>>>> mentioned code paths, they seem to have been changed in v6.7 as part of
>>>> this patchset. I reverted both patches and didn't see any memory leaks
>>>> when running a full regression (~10 hours), but I will repeat it to be
>>>> sure.
>>>>
>>>> Any idea what could be the problem?
>>>
>>> Hmm, we've got what looks to be a set of magazines forming a 
>>> plausible depot list (or at least the tail end of one):
>>>
>>> ffff8881411f9000 -> ffff8881261c1000
>>>
>>> ffff8881261c1000 -> ffff88812be26400
>>>
>>> ffff88812be26400 -> ffff8188392ec000
>>>
>>> ffff8188392ec000 -> ffff8881a5301000
>>>
>>> ffff8881a5301000 -> NULL
>>>
>>> which I guess has somehow become detached from its rcache->depot 
>>> without being freed properly? However I'm struggling to see any 
>>> conceivable way that could happen which wouldn't already be more 
>>> severely broken in other ways as well (i.e. either general memory 
>>> corruption or someone somehow still trying to use the IOVA domain 
>>> while it's being torn down).
>>>
>>> Out of curiosity, does reverting just patch #2 alone make a 
>>> difference? And is your workload doing anything "interesting" in 
>>> relation to IOVA domain lifetimes, like creating and destroying 
>>> SR-IOV virtual functions, changing IOMMU domain types via sysfs, or 
>>> using that horrible vdpa thing, or are you seeing this purely from 
>>> regular driver DMA API usage?
>>
>> There no lock held when free_iova_rcaches(), is it possible 
>> free_iova_rcaches() race with the delayed cancel_delayed_work_sync() ?
>>
>> I don't know why not call cancel_delayed_work_sync(&rcache->work); 
>> first in free_iova_rcaches() to avoid possible race.
>>
> between following functions pair, race possible ? if called cocurrently.
> 
> 1. free_iova_rcaches() with iova_depot_work_func()
> 
>     free_iova_rcaches() holds no lock, iova_depot_work_func() holds 
> rcache->lock.

Unless I've completely misunderstood the workqueue API, that can't 
happen, since free_iova_rcaches() *does* synchronously cancel the work 
before it starts freeing the depot list.

> 2. iova_cpuhp_dead() with iova_depot_work_func()
> 
>    iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock, 
> iova_depot_work_func() holds rcache->lock.

That's not a race because those are touching completely different things 
- the closest they come to interacting is where they both free IOVAs 
back to the rbtree.

> 3. iova_cpuhp_dead() with free_iova_rcaches()
> 
>     iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock, 
> free_iova_rcaches() holds no lock.

See iova_domain_free_rcaches() - by the time we call 
free_iova_rcaches(), the hotplug handler has already been removed (and 
either way it couldn't account for *this* issue since it doesn't touch 
the depot at all).

> 4. iova_cpuhp_dead() with free_global_cached_iovas()
> 
>     iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock and 
> free_global_cached_iovas() holds rcache->lock.

Again, they hold different locks because they're touching unrelated things.

Thanks,
Robin.

