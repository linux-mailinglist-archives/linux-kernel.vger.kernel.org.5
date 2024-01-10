Return-Path: <linux-kernel+bounces-21595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8809C82919C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACE91C23E60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E41368;
	Wed, 10 Jan 2024 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYEa8Xcg"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B281B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704847932; x=1736383932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P1lrP9NOMqRhHmYOJ4SIwEz/KxAXtMJkZlm7Bn8S+QQ=;
  b=HYEa8XcgC4peygMcUp/7CZFxbhnMMKvSmAVZPC8pXiGUWd0yJtHd4/tF
   EwnK/eQ+W4Wl52gkxHL+dmwJQHOQ9JBNZdSocV8PK/Y9YRzyYILr3qXrM
   55RrC1w107k0CDbixa8bcDTFP641Ire/8yh5nrhzYCi32GHEYFSkSKgv4
   KmfIHKykHKaQEipaVJpaK+4bG1u5LoVfPAnnYvV9MVQCp0Ndtf6T1++Gj
   /MTiBCU3v4b78RggJJri2oRzy81hmlEYIym+q4bR2jsvgeJGzmQqi0/FT
   LWFblCoS1aB7U1PtnPA0hcs2W+CjSaAZjmkGco8QCO+8iLThdMeXb1AbX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="462654466"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="462654466"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 16:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1028964191"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1028964191"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.19.162]) ([10.93.19.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 16:52:08 -0800
Message-ID: <252396e4-bf9a-4655-8993-75a44d58febd@linux.intel.com>
Date: Wed, 10 Jan 2024 08:52:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
To: Robin Murphy <robin.murphy@arm.com>, Ido Schimmel <idosch@idosch.org>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
 john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder> <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <15a058ba-3b51-46f3-bb1c-23792d100b55@linux.intel.com>
 <d5ad4801-6061-42ee-aafb-129a78e5a2b8@linux.intel.com>
 <7eaa0f41-a71b-43c1-8596-1df99584530a@arm.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <7eaa0f41-a71b-43c1-8596-1df99584530a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/9/2024 7:26 PM, Robin Murphy wrote:
> On 2024-01-09 6:23 am, Ethan Zhao wrote:
>>
>> On 1/9/2024 1:54 PM, Ethan Zhao wrote:
>>>
>>> On 1/9/2024 1:35 AM, Robin Murphy wrote:
>>>> On 2023-12-28 12:23 pm, Ido Schimmel wrote:
>>>>> On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
>>>>>> v2: 
>>>>>> https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> I hope this is good to go now, just fixed the locking (and threw
>>>>>> lockdep at it to confirm, which of course I should have done to 
>>>>>> begin
>>>>>> with...) and picked up tags.
>>>>>
>>>>> Hi,
>>>>>
>>>>> After pulling the v6.7 changes we started seeing the following memory
>>>>> leaks [1] of 'struct iova_magazine'. I'm not sure how to reproduce 
>>>>> it,
>>>>> which is why I didn't perform bisection. However, looking at the
>>>>> mentioned code paths, they seem to have been changed in v6.7 as 
>>>>> part of
>>>>> this patchset. I reverted both patches and didn't see any memory 
>>>>> leaks
>>>>> when running a full regression (~10 hours), but I will repeat it 
>>>>> to be
>>>>> sure.
>>>>>
>>>>> Any idea what could be the problem?
>>>>
>>>> Hmm, we've got what looks to be a set of magazines forming a 
>>>> plausible depot list (or at least the tail end of one):
>>>>
>>>> ffff8881411f9000 -> ffff8881261c1000
>>>>
>>>> ffff8881261c1000 -> ffff88812be26400
>>>>
>>>> ffff88812be26400 -> ffff8188392ec000
>>>>
>>>> ffff8188392ec000 -> ffff8881a5301000
>>>>
>>>> ffff8881a5301000 -> NULL
>>>>
>>>> which I guess has somehow become detached from its rcache->depot 
>>>> without being freed properly? However I'm struggling to see any 
>>>> conceivable way that could happen which wouldn't already be more 
>>>> severely broken in other ways as well (i.e. either general memory 
>>>> corruption or someone somehow still trying to use the IOVA domain 
>>>> while it's being torn down).
>>>>
>>>> Out of curiosity, does reverting just patch #2 alone make a 
>>>> difference? And is your workload doing anything "interesting" in 
>>>> relation to IOVA domain lifetimes, like creating and destroying 
>>>> SR-IOV virtual functions, changing IOMMU domain types via sysfs, or 
>>>> using that horrible vdpa thing, or are you seeing this purely from 
>>>> regular driver DMA API usage?
>>>
>>> There no lock held when free_iova_rcaches(), is it possible 
>>> free_iova_rcaches() race with the delayed cancel_delayed_work_sync() ?
>>>
>>> I don't know why not call cancel_delayed_work_sync(&rcache->work); 
>>> first in free_iova_rcaches() to avoid possible race.
>>>
>> between following functions pair, race possible ? if called cocurrently.
>>
>> 1. free_iova_rcaches() with iova_depot_work_func()
>>
>>     free_iova_rcaches() holds no lock, iova_depot_work_func() holds 
>> rcache->lock.
>
> Unless I've completely misunderstood the workqueue API, that can't 
> happen, since free_iova_rcaches() *does* synchronously cancel the work 
> before it starts freeing the depot list.

iova_depot_work_func() pop and free mag from depot. free_iova_rcaches() 
frees loaded and previous mag before syncronously cancelled.

different thing. okay here.

>
>> 2. iova_cpuhp_dead() with iova_depot_work_func()
>>
>>    iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock, 
>> iova_depot_work_func() holds rcache->lock.
>
> That's not a race because those are touching completely different 
> things - the closest they come to interacting is where they both free 
> IOVAs back to the rbtree.

iova_cpuhp_dead() free pages with 
iova_magazine_free_pfns(cpu_rcache->loaded, iovad);

iova_depot_work_func() free mag from depot. iova_magazine_free_pfns() 
hold rbtree lock.

Okay, different thing.

>
>> 3. iova_cpuhp_dead() with free_iova_rcaches()
>>
>>     iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock, 
>> free_iova_rcaches() holds no lock.
>
> See iova_domain_free_rcaches() - by the time we call 
> free_iova_rcaches(), the hotplug handler has already been removed (and 
> either way it couldn't account for *this* issue since it doesn't touch 
> the depot at all).
Yes, iova_cpuhp_dead() was removed before free_iova_rcaches().
>
>> 4. iova_cpuhp_dead() with free_global_cached_iovas()
>>
>>     iova_cpuhp_dead() holds per cpu lock cpu_rcache->lock and 
>> free_global_cached_iovas() holds rcache->lock.
>
> Again, they hold different locks because they're touching unrelated 
> things.

iova_cpuhp_dead() free loaded and previous pages. 
free_global_cached_iovas() free mags from depot.

Okay too.

then free_global_cached_iovas() with iova_depot_work_func() ? they all 
hold rcache->lock.

So there is no race at all, perfect.  out of imagination, that memory 
leak report.

kmemleak not always right.


Thanks,

Ethan

>
> Thanks,
> Robin.

