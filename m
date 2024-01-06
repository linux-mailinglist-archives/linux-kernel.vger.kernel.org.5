Return-Path: <linux-kernel+bounces-18524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D5825EB5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936FF1C23C32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E34439;
	Sat,  6 Jan 2024 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JY3pJrQC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B338440D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704526405; x=1736062405;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JcyWnx6eGCbTMPk4u7ilQC2UDqhNrPRGUQXPKRjphYg=;
  b=JY3pJrQCsz9+h2Z0trEsN+XfpbFcmQkSHzXFDxOifizkGH2mD1vo4mfA
   3Wnzo6tgrTRmm5mDjnxgaOpBEQBaTeTvheEyqc2iUpZC3h0S6ARAPl3jy
   aHMFn8xudN+3SWpLo6Rn9ASOvfATb8q347wcsOHOAHw2OtTe8pZ2XF5tF
   eTBXCDB22tDV44M+O/853IrtyaaZbOROYZrrad8SYeTYol7BUHIv0aMkd
   uHZf0trQEjf0IWAy/OcLfEMHICYCaKuItMUghw9CTVYBhkOdXJFqmw3wS
   /u0dg/XgFMMmuoGwJyS/ewil1L3Sxq/S4Oz9ERZDYwh6L78qlR9CQGS40
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="382610219"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="382610219"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 23:33:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="780950800"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="780950800"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.16.94]) ([10.93.16.94])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 23:33:21 -0800
Message-ID: <23cc4bc9-9519-40e9-bd50-f89b0ebc6c5c@linux.intel.com>
Date: Sat, 6 Jan 2024 15:33:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
To: "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
 dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com,
 Ido Schimmel <idosch@idosch.org>, Robin Murphy <robin.murphy@arm.com>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder> <ZZO6NV-Kq-ktnyo5@shredder>
 <f8ae34f0-dab2-48fa-b3f8-5e969ed028b7@linux.intel.com>
 <20924c0f-b752-4f58-91ce-21ed3b305481@huawei.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20924c0f-b752-4f58-91ce-21ed3b305481@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/6/2024 3:07 PM, zhangzekun (A) wrote:
>
>
> 在 2024/1/6 12:21, Ethan Zhao 写道:
>>
>> On 1/2/2024 3:24 PM, Ido Schimmel wrote:
>>> On Thu, Dec 28, 2023 at 02:23:20PM +0200, Ido Schimmel wrote:
>>>> On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
>>>>> v2: 
>>>>> https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
>>>>>
>>>>> Hi all,
>>>>>
>>>>> I hope this is good to go now, just fixed the locking (and threw
>>>>> lockdep at it to confirm, which of course I should have done to begin
>>>>> with...) and picked up tags.
>>>> Hi,
>>>>
>>>> After pulling the v6.7 changes we started seeing the following memory
>>>> leaks [1] of 'struct iova_magazine'. I'm not sure how to reproduce it,
>>>> which is why I didn't perform bisection. However, looking at the
>>>> mentioned code paths, they seem to have been changed in v6.7 as 
>>>> part of
>>>> this patchset. I reverted both patches and didn't see any memory leaks
>>>> when running a full regression (~10 hours), but I will repeat it to be
>>>> sure.
>>> FYI, we didn't see the leaks since reverting these two patches whereas
>>> before we saw them almost everyday, so I'm quite sure they introduced
>>> the leaks.
>>
>> Seems some magazines were not freed when one CPU is dead (hot 
>> unplugged) ?
>>
>> static void free_cpu_cached_iovas(unsigned int cpu, struct 
>> iova_domain *iovad)
>> {
>>     struct iova_cpu_rcache *cpu_rcache;
>>     struct iova_rcache *rcache;
>>     unsigned long flags;
>>     int i;
>>
>>     for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>>         rcache = &iovad->rcaches[i];
>>         cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>>         spin_lock_irqsave(&cpu_rcache->lock, flags);
>>         iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
>>
>> +     iova_magazine_free(cpu_rcache->loaded);
>>
>>         iova_magazine_free_pfns(cpu_rcache->prev, iovad);
>>
>> +     iova_magazine_free(cpu_rcache->prev);
>>
>>         spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>>     }
>> }
> It seems cpu_rcache->loaded and cpu_rcache->prev will be freed in 
> free_iova_rcaches(), and it should not cause memory leak because 
> iova_magazine_free() will be called for each possible cpu.
> free_cpu_cached_iovas() is used to free cached iovas in magazines.

Yup, looked  closely.  possible cpu, not online cpu.

Thanks,

Ethan

>
> Thanks,
> Zekun
>
>
>

