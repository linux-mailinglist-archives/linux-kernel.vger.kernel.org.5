Return-Path: <linux-kernel+bounces-107170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1987F866
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37523280A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33853E34;
	Tue, 19 Mar 2024 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMKn6wbb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F353E36
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833286; cv=none; b=TXwL9FZ9QqqyPhBIZmdXUULvGCzgNJOAKXueHBk27NGhKxMYzn3ru7fFFm6vOYQq9/CfaiB8efkV91tg24oK4wJBBErmBext6Z4Pbm2rRpbJOxkk98+4lgqKdt2JetkfnQKvWls0LR/2sB8SZxbLPC9jvzKFA62TlDqnfxTGemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833286; c=relaxed/simple;
	bh=FImFzrjqHBVVOA7dU39YkUTetJNlBqVKjjYLN+R7wTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDYVSIKYx92uQX6JJn9NJAUovGgbih9dA7fsDPVznFCsIWeFq+ftecGP9sH7HjX4ht/2lxVT5m/qZPLgmaieSiSjr/oRnmxzwtUenBeUt7vOzaN5Pwdrc5tkVRDk/xbcVQxSMcd5WoyAbySgmF7Qs3BE9LJoq+kcchJWv9xt6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMKn6wbb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710833284; x=1742369284;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FImFzrjqHBVVOA7dU39YkUTetJNlBqVKjjYLN+R7wTU=;
  b=eMKn6wbb/R0REdsH/Bqp/OMY65Rw4q8PDsasYwrO0NpqHPXnKb1O29n5
   a50c3otaKkOOxbcio4sFH7fUvHk4NlHkgGG23xQzf8XlDgUJfLhgTqzrm
   jb/HWQY9Ml9d2gbzcpcApedGhEBVXg6KbvCPP9qSdgjwJ9ZYmvD7ddctC
   cBVD9620R1DnxhotVRk0jC7a5KSXyhEx+I7362Tv0kxPSWCRvr4mGimYM
   mwNHXctY9qU1K7BMJQXYpUs//HPGnyqSmmUr96o35QphWBf+ZeDYH5aSc
   Ae1Ach+zbbQoYvjH/E7ecOhGloJngXJY9H4ySbkiXwRMb4Kti9PZslKRa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5519397"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5519397"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 00:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18300377"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 00:28:01 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <akpm@linux-foundation.org>,  <david@redhat.com>,
  <mgorman@techsingularity.net>,  <wangkefeng.wang@huawei.com>,
  <jhubbard@nvidia.com>,  <21cnbao@gmail.com>,  <ryan.roberts@arm.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm: support multi-size THP numa balancing
In-Reply-To: <f00316da-e45d-46c1-99b8-ee160303eaaa@linux.alibaba.com> (Baolin
	Wang's message of "Mon, 18 Mar 2024 17:42:35 +0800")
References: <903bf13fc3e68b8dc1f256570d78b55b2dd9c96f.1710493587.git.baolin.wang@linux.alibaba.com>
	<871q88vzc4.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<f00316da-e45d-46c1-99b8-ee160303eaaa@linux.alibaba.com>
Date: Tue, 19 Mar 2024 15:26:07 +0800
Message-ID: <87sf0mvg1c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2024/3/18 14:16, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>>> but the numa balancing still prohibits mTHP migration even though it is an
>>> exclusive mapping, which is unreasonable. Thus let's support the exclusive
>>> mTHP numa balancing firstly.
>>>
>>> Allow scanning mTHP:
>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>> NUMA-migrate COW pages that have other uses") change to use page_count()
>>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>> issue, although there is still a GUP race, the issue seems to have been
>>> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_estimated_sharers()
>>> to skip shared CoW pages though this is not a precise sharers count. To
>>> check if the folio is shared, ideally we want to make sure every page is
>>> mapped to the same process, but doing that seems expensive and using
>>> the estimated mapcount seems can work when running autonuma benchmark.
>>>
>>> Allow migrating mTHP:
>>> As mentioned in the previous thread[1], large folios are more susceptible
>>> to false sharing issues, leading to pages ping-pong back and forth during
>>> numa balancing, which is currently hard to resolve. Therefore, as a start to
>>> support mTHP numa balancing, only exclusive mappings are allowed to perform
>>> numa migration to avoid the false sharing issues with large folios. Similarly,
>>> use the estimated mapcount to skip shared mappings, which seems can work
>>> in most cases (?), and we've used folio_estimated_sharers() to skip shared
>>> mappings in migrate_misplaced_folio() for numa balancing, seems no real
>>> complaints.
>> IIUC, folio_estimated_sharers() cannot identify multi-thread
>> applications.  If some mTHP is shared by multiple threads in one
>
> Right.
>
>> process, how to deal with that?
>
> IMHO, seems the should_numa_migrate_memory() already did something to help?
>
> ......
> 	if (!cpupid_pid_unset(last_cpupid) &&
> 				cpupid_to_nid(last_cpupid) != dst_nid)
> 		return false;
>
> 	/* Always allow migrate on private faults */
> 	if (cpupid_match_pid(p, last_cpupid))
> 		return true;
> ......
>
> If the node of the CPU that accessed the mTHP last time is different
> from this time, which means there is some contention for that mTHP
> among threads. So it will not allow migration.

Yes.  The two-stage filter in should_numa_migrate_memory() helps at some
degree.

But the situation is somewhat different after your change.  Previously,
in one round of NUMA balancing page table scanning, the number of the
hint page fault for one process and one folio is 1.  After your change,
the number may become folio_nr_pages().  So we need to evaluate the
original algorithm in the new situation and revise.  For example, use a
N-stage filter for mTHP.

Anyway, the NUMA balancing algorithm adjustment needs to be based on
test results.

Another possibility is to emulate the original behavior as much as
possible to try to reuse the original algorithm.  For example, we can
restore all PTE maps upon the first hint page fault of a folio.  Then,
the behavior is almost same as the original PMD mapped THP.  Personally,
I prefer to use this as the first step.  Then, try to adjust the
algorithm to take advantage of more information available.

>
> If the contention for the mTHP among threads is light or the accessing
> is relatively stable, then we can allow migration?
>
>> For example, I think that we should avoid to migrate on the first fault
>> for mTHP in should_numa_migrate_memory().

I am referring to the following code in should_numa_migrate_memory().

	/*
	 * Allow first faults or private faults to migrate immediately early in
	 * the lifetime of a task. The magic number 4 is based on waiting for
	 * two full passes of the "multi-stage node selection" test that is
	 * executed below.
	 */
	if ((p->numa_preferred_nid == NUMA_NO_NODE || p->numa_scan_seq <= 4) &&
	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
		return true;

But, after thought about this again, I realized that the original PMD
mapped THP may be migrated on the first fault sometimes.  So, this isn't
a new problem.  We may "optimize" it.  But it needn't to be part of this
series.

>> More thoughts?  Can we add a field in struct folio for mTHP to count
>> hint page faults from the same node?
>
> IIUC, we do not need add a new field for folio, seems we can reuse
> ->_flags_2a field. But how to use it? If there are multiple
> consecutive NUMA faults from the same node, then allow migration?
>
>>> Performance data:
>>> Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
>>> Base: 2024-3-15 mm-unstable branch
>>> Enable mTHP=64K to run autonuma-benchmark
>>>
>>> Base without the patch:
>>> numa01
>>> 222.97
>>> numa01_THREAD_ALLOC
>>> 115.78
>>> numa02
>>> 13.04
>>> numa02_SMT
>>> 14.69
>>>
>>> Base with the patch:
>>> numa01
>>> 125.36
>>> numa01_THREAD_ALLOC
>>> 44.58
>>> numa02
>>> 9.22
>>> numa02_SMT
>>> 7.46
>>>

[snip]

--
Best Regards,
Huang, Ying

