Return-Path: <linux-kernel+bounces-100997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64287A099
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFA82832B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42170A951;
	Wed, 13 Mar 2024 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TU+j76oW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE98BE0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292649; cv=none; b=b4kIEVMoTo6/kHZACYN4UtxXP5EnoNXsKPfUhXr3/V328+sGp7j91YFLDbPqnappN6xMZCVCMttTwwf3UFQfoJXc0aO7fPRWCjYVMMzo50EuhHCwUlF1Dvzp/C0BLqYpBy6++oS7+6rdKKR98XA9Pw9Fn5cE9gbPZ7r7gCol30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292649; c=relaxed/simple;
	bh=xEGbOoNHJhjnq2qS3X1dBXqH+R61Z8ym2sUNKikj51A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYvk62Go35ss1rdUz5FM+PS05jPrJ/oY4XT73jv3JUEkwkpXxhkGyy70aNH2BKEwfd6bMhwxzawAlp5NzUGw1NOFYwdMgZnr888LK4TzvFKp6GkqX4Gtd5b6Vgb0zyNAK71uY6DxwLlKQhY9AAEAMBcnIvBUm3ulvXA4EMu8+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TU+j76oW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710292647; x=1741828647;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xEGbOoNHJhjnq2qS3X1dBXqH+R61Z8ym2sUNKikj51A=;
  b=TU+j76oWktLX19SVo2oRqbFebtP8aKndPe+9EpGS69AeO4E9vg+zb2js
   ldgNrWZa6+9dXYtOVRJSqRevdxmwWFmb8STMI9xSbIpo9+6GffN0e1Cts
   4Zb5OuIDFW6WC5Xi0GHj22C4cy0C1p6tWoo7ugg7ChDThcIa8xgsRp0na
   ZZt3RzoL5oqKye5rejTa6pojatwLAAZxiaIbmMmPoMnaz9akTlXG48Il7
   R5VIDpzpznHbEhg086QaoFiOXF9MDJXkfYpN+xQkM3FTT5QA4nF0TbzIa
   8F5NbeHoAf68TFF8voTeC+CQajrFSuzr70/e3os2pJoNUQbP5W+I4HMyv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4903259"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4903259"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11802862"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:17:23 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] Swap-out mTHP without splitting
In-Reply-To: <2fbc83bf-2e51-40fa-8865-499911ba8102@arm.com> (Ryan Roberts's
	message of "Tue, 12 Mar 2024 13:56:58 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<878r2n516c.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<28914585-80bd-4308-b3aa-dd0dbb2cb201@arm.com>
	<2fbc83bf-2e51-40fa-8865-499911ba8102@arm.com>
Date: Wed, 13 Mar 2024 09:15:28 +0800
Message-ID: <87zfv32aq7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 12/03/2024 08:49, Ryan Roberts wrote:
>> On 12/03/2024 08:01, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> Hi All,
>>>>
>>>> This series adds support for swapping out multi-size THP (mTHP) without needing
>>>> to first split the large folio via split_huge_page_to_list_to_order(). It
>>>> closely follows the approach already used to swap-out PMD-sized THP.
>>>>
>>>> There are a couple of reasons for swapping out mTHP without splitting:
>>>>
>>>>   - Performance: It is expensive to split a large folio and under extreme memory
>>>>     pressure some workloads regressed performance when using 64K mTHP vs 4K
>>>>     small folios because of this extra cost in the swap-out path. This series
>>>>     not only eliminates the regression but makes it faster to swap out 64K mTHP
>>>>     vs 4K small folios.
>>>>
>>>>   - Memory fragmentation avoidance: If we can avoid splitting a large folio
>>>>     memory is less likely to become fragmented, making it easier to re-allocate
>>>>     a large folio in future.
>>>>
>>>>   - Performance: Enables a separate series [4] to swap-in whole mTHPs, which
>>>>     means we won't lose the TLB-efficiency benefits of mTHP once the memory has
>>>>     been through a swap cycle.
>>>>
>>>> I've done what I thought was the smallest change possible, and as a result, this
>>>> approach is only employed when the swap is backed by a non-rotating block device
>>>> (just as PMD-sized THP is supported today). Discussion against the RFC concluded
>>>> that this is sufficient.
>>>>
>>>>
>>>> Performance Testing
>>>> ===================
>>>>
>>>> I've run some swap performance tests on Ampere Altra VM (arm64) with 8 CPUs. The
>>>> VM is set up with a 35G block ram device as the swap device and the test is run
>>>> from inside a memcg limited to 40G memory. I've then run `usemem` from
>>>> vm-scalability with 70 processes, each allocating and writing 1G of memory. I've
>>>> repeated everything 6 times and taken the mean performance improvement relative
>>>> to 4K page baseline:
>>>>
>>>> | alloc size |            baseline |       + this series |
>>>> |            |  v6.6-rc4+anonfolio |                     |
>>>> |:-----------|--------------------:|--------------------:|
>>>> | 4K Page    |                0.0% |                1.4% |
>>>> | 64K THP    |              -14.6% |               44.2% |
>>>> | 2M THP     |               87.4% |               97.7% |
>>>>
>>>> So with this change, the 64K swap performance goes from a 15% regression to a
>>>> 44% improvement. 4K and 2M swap improves slightly too.
>>>
>>> I don't understand why the performance of 2M THP improves.  The swap
>>> entry allocation becomes a little slower.  Can you provide some
>>> perf-profile to root cause it?
>> 
>> I didn't post the stdev, which is quite large (~10%), so that may explain some
>> of it:
>> 
>> | kernel   |   mean_rel |   std_rel |
>> |:---------|-----------:|----------:|
>> | base-4K  |       0.0% |      5.5% |
>> | base-64K |     -14.6% |      3.8% |
>> | base-2M  |      87.4% |     10.6% |
>> | v4-4K    |       1.4% |      3.7% |
>> | v4-64K   |      44.2% |     11.8% |
>> | v4-2M    |      97.7% |     13.3% |
>> 
>> Regardless, I'll do some perf profiling and post results shortly.
>
> I did a lot more runs (24 for each config) and meaned them to try to remove the
> noise in the measurements. It's now only showing a 4% improvement for 2M. So I
> don't think the 2M improvement is real:
>
> | kernel   |   mean_rel |   std_rel |
> |:---------|-----------:|----------:|
> | base-4K  |       0.0% |      3.2% |
> | base-64K |      -9.1% |     10.1% |
> | base-2M  |      88.9% |      6.8% |
> | v4-4K    |       0.5% |      3.1% |
> | v4-64K   |      44.7% |      8.3% |
> | v4-2M    |      93.3% |      7.8% |
>
> Looking at the perf data, the only thing that sticks out is that a big chunk of
> time is spent in during contpte_convert(), called as a result of
> try_to_unmap_one(). This is present in both the before and after configs.
>
> This is an arm64 function to "unfold" contpte mappings. Essentially, the PMD is
> being split during shrink_folio_list()  with TTU_SPLIT_HUGE_PMD, meaning the
> THPs are PTE-mapped in contpte blocks. Then we are unmapping each pte one-by-one
> which means the contpte block needs to be unfolded. I think try_to_unmap_one()
> could potentially be optimized to batch unmap a contiguously mapped folio and
> avoid this unfold. But that would be an independent and separate piece of work.

Thanks for more data and detailed explanation.

--
Best Regards,
Huang, Ying

