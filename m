Return-Path: <linux-kernel+bounces-101225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D4987A43F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1419282266
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B71A286;
	Wed, 13 Mar 2024 08:51:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6512E73
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319865; cv=none; b=BgpDGAnrFvGGi1ni9xm47s++pf519CNExLHCSKI0tXsKSxHIrp4haUI5AMrgiitAtae5KgkFYvlPiI2iIppzpcznljMCen038IyJCXo5+HPDjHvUxQ2V5/Y4PABWPkAfTs1phcPGGPvIvkbEv6qyJRN/rqHWWAzD7aeQJXsc4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319865; c=relaxed/simple;
	bh=gZxNSeva8JfKY+GiGnoxI+gN4pgBisVb5qOB8r7dw+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LE1Xl3/O0z6tPEpMjWM0v5YDajV0xXtV1sumT5jFqiLPUa24Suln2RECO/xXdpcOcI7KMPZefeGViznVqOg+kS/AAP+nNZBHSTQhapJu9OnyJI1415gR0Owh32saFvNDhSt/2AnQWLZvBUvqk/aj0yTKWLVh2SBdvmfEulB3oJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4C91007;
	Wed, 13 Mar 2024 01:51:32 -0700 (PDT)
Received: from [10.57.67.164] (unknown [10.57.67.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 091143F73F;
	Wed, 13 Mar 2024 01:50:52 -0700 (PDT)
Message-ID: <3d60e840-00e1-4e6e-a9f4-e67d905b1782@arm.com>
Date: Wed, 13 Mar 2024 08:50:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Swap-out mTHP without splitting
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <878r2n516c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <28914585-80bd-4308-b3aa-dd0dbb2cb201@arm.com>
 <2fbc83bf-2e51-40fa-8865-499911ba8102@arm.com>
 <87zfv32aq7.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87zfv32aq7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 01:15, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 12/03/2024 08:49, Ryan Roberts wrote:
>>> On 12/03/2024 08:01, Huang, Ying wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> Hi All,
>>>>>
>>>>> This series adds support for swapping out multi-size THP (mTHP) without needing
>>>>> to first split the large folio via split_huge_page_to_list_to_order(). It
>>>>> closely follows the approach already used to swap-out PMD-sized THP.
>>>>>
>>>>> There are a couple of reasons for swapping out mTHP without splitting:
>>>>>
>>>>>   - Performance: It is expensive to split a large folio and under extreme memory
>>>>>     pressure some workloads regressed performance when using 64K mTHP vs 4K
>>>>>     small folios because of this extra cost in the swap-out path. This series
>>>>>     not only eliminates the regression but makes it faster to swap out 64K mTHP
>>>>>     vs 4K small folios.
>>>>>
>>>>>   - Memory fragmentation avoidance: If we can avoid splitting a large folio
>>>>>     memory is less likely to become fragmented, making it easier to re-allocate
>>>>>     a large folio in future.
>>>>>
>>>>>   - Performance: Enables a separate series [4] to swap-in whole mTHPs, which
>>>>>     means we won't lose the TLB-efficiency benefits of mTHP once the memory has
>>>>>     been through a swap cycle.
>>>>>
>>>>> I've done what I thought was the smallest change possible, and as a result, this
>>>>> approach is only employed when the swap is backed by a non-rotating block device
>>>>> (just as PMD-sized THP is supported today). Discussion against the RFC concluded
>>>>> that this is sufficient.
>>>>>
>>>>>
>>>>> Performance Testing
>>>>> ===================
>>>>>
>>>>> I've run some swap performance tests on Ampere Altra VM (arm64) with 8 CPUs. The
>>>>> VM is set up with a 35G block ram device as the swap device and the test is run
>>>>> from inside a memcg limited to 40G memory. I've then run `usemem` from
>>>>> vm-scalability with 70 processes, each allocating and writing 1G of memory. I've
>>>>> repeated everything 6 times and taken the mean performance improvement relative
>>>>> to 4K page baseline:
>>>>>
>>>>> | alloc size |            baseline |       + this series |
>>>>> |            |  v6.6-rc4+anonfolio |                     |
>>>>> |:-----------|--------------------:|--------------------:|
>>>>> | 4K Page    |                0.0% |                1.4% |
>>>>> | 64K THP    |              -14.6% |               44.2% |
>>>>> | 2M THP     |               87.4% |               97.7% |
>>>>>
>>>>> So with this change, the 64K swap performance goes from a 15% regression to a
>>>>> 44% improvement. 4K and 2M swap improves slightly too.
>>>>
>>>> I don't understand why the performance of 2M THP improves.  The swap
>>>> entry allocation becomes a little slower.  Can you provide some
>>>> perf-profile to root cause it?
>>>
>>> I didn't post the stdev, which is quite large (~10%), so that may explain some
>>> of it:
>>>
>>> | kernel   |   mean_rel |   std_rel |
>>> |:---------|-----------:|----------:|
>>> | base-4K  |       0.0% |      5.5% |
>>> | base-64K |     -14.6% |      3.8% |
>>> | base-2M  |      87.4% |     10.6% |
>>> | v4-4K    |       1.4% |      3.7% |
>>> | v4-64K   |      44.2% |     11.8% |
>>> | v4-2M    |      97.7% |     13.3% |
>>>
>>> Regardless, I'll do some perf profiling and post results shortly.
>>
>> I did a lot more runs (24 for each config) and meaned them to try to remove the
>> noise in the measurements. It's now only showing a 4% improvement for 2M. So I
>> don't think the 2M improvement is real:
>>
>> | kernel   |   mean_rel |   std_rel |
>> |:---------|-----------:|----------:|
>> | base-4K  |       0.0% |      3.2% |
>> | base-64K |      -9.1% |     10.1% |
>> | base-2M  |      88.9% |      6.8% |
>> | v4-4K    |       0.5% |      3.1% |
>> | v4-64K   |      44.7% |      8.3% |
>> | v4-2M    |      93.3% |      7.8% |
>>
>> Looking at the perf data, the only thing that sticks out is that a big chunk of
>> time is spent in during contpte_convert(), called as a result of
>> try_to_unmap_one(). This is present in both the before and after configs.
>>
>> This is an arm64 function to "unfold" contpte mappings. Essentially, the PMD is
>> being split during shrink_folio_list()  with TTU_SPLIT_HUGE_PMD, meaning the
>> THPs are PTE-mapped in contpte blocks. Then we are unmapping each pte one-by-one
>> which means the contpte block needs to be unfolded. I think try_to_unmap_one()
>> could potentially be optimized to batch unmap a contiguously mapped folio and
>> avoid this unfold. But that would be an independent and separate piece of work.
> 
> Thanks for more data and detailed explanation.

And thanks for your review! I'll address all your comments (and any others that
I get in the meantime) and repost after the merge window. It would be great if
we can get this in for v6.10.

> 
> --
> Best Regards,
> Huang, Ying


