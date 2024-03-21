Return-Path: <linux-kernel+bounces-109717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D9881CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A01F21E21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E6B4DA10;
	Thu, 21 Mar 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xYGUUWPB"
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88289381AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005180; cv=none; b=dHj2R4MKCLiHVvyJsaxZsbJSL2+h1VumHvTscO+jO7dNYhIGXbyAlMZjFlmzt4YarTe/uO0ElySi18JMwrcKTigHKw2af6bcCHCCISliO4SMLciksQ/XS0eGG6SkBjyEZIl2oa5QXaiM610WPB81tCrvVP1SRen8GwpJmWNzrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005180; c=relaxed/simple;
	bh=v2D+Mb6HR3GIyVn6wZk/TJSbu5Z8XX46BLEwR8TLToI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pdl2Dw6xXf0jALp7Z4HC1A/fEw0P/etm4KG0TfUokWN0Kic4gVmi3E8ftgLM0oI4cHOi86m44Yz5CWasL3Rvg9JUKN5DNjuQF8N4KrcAXoNY683X+pjdXR/ny2qt/Ldqmyuub7vRNGlERrX+SuKJa6DEsNZ326EiIBIDPSh5bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xYGUUWPB; arc=none smtp.client-ip=47.90.199.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711005166; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LJLz95zB5IfCEFx0NOpBepvRP5+Xo9tzfNvsPiZl1EA=;
	b=xYGUUWPBW+bw8KcGdBYNDq37rMWgrgpLJtqjHCPnKnZQJG4ts7XWbRY8p9qfze1oUbChHrHNkBe6r4AnrSVA8ngV458MUkJcJeHQD4O/KALrXFnVHQ/i2OQpphPghu7IhqxQ5GL2ZNBqP4tBKDKD5Ku8IWpnpdlAXWdtcnQRsms=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W2zxvbB_1711005164;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W2zxvbB_1711005164)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 15:12:45 +0800
Message-ID: <dc8ecc32-54c8-4931-9a13-64a3c3b41d35@linux.alibaba.com>
Date: Thu, 21 Mar 2024 15:12:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm: support multi-size THP numa balancing
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, mgorman@techsingularity.net,
 wangkefeng.wang@huawei.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <903bf13fc3e68b8dc1f256570d78b55b2dd9c96f.1710493587.git.baolin.wang@linux.alibaba.com>
 <871q88vzc4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f00316da-e45d-46c1-99b8-ee160303eaaa@linux.alibaba.com>
 <87sf0mvg1c.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87sf0mvg1c.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(sorry for late reply)

On 2024/3/19 15:26, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 2024/3/18 14:16, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>>>> but the numa balancing still prohibits mTHP migration even though it is an
>>>> exclusive mapping, which is unreasonable. Thus let's support the exclusive
>>>> mTHP numa balancing firstly.
>>>>
>>>> Allow scanning mTHP:
>>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>>>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>>> NUMA-migrate COW pages that have other uses") change to use page_count()
>>>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>>> issue, although there is still a GUP race, the issue seems to have been
>>>> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_estimated_sharers()
>>>> to skip shared CoW pages though this is not a precise sharers count. To
>>>> check if the folio is shared, ideally we want to make sure every page is
>>>> mapped to the same process, but doing that seems expensive and using
>>>> the estimated mapcount seems can work when running autonuma benchmark.
>>>>
>>>> Allow migrating mTHP:
>>>> As mentioned in the previous thread[1], large folios are more susceptible
>>>> to false sharing issues, leading to pages ping-pong back and forth during
>>>> numa balancing, which is currently hard to resolve. Therefore, as a start to
>>>> support mTHP numa balancing, only exclusive mappings are allowed to perform
>>>> numa migration to avoid the false sharing issues with large folios. Similarly,
>>>> use the estimated mapcount to skip shared mappings, which seems can work
>>>> in most cases (?), and we've used folio_estimated_sharers() to skip shared
>>>> mappings in migrate_misplaced_folio() for numa balancing, seems no real
>>>> complaints.
>>> IIUC, folio_estimated_sharers() cannot identify multi-thread
>>> applications.  If some mTHP is shared by multiple threads in one
>>
>> Right.
>>
>>> process, how to deal with that?
>>
>> IMHO, seems the should_numa_migrate_memory() already did something to help?
>>
>> ......
>> 	if (!cpupid_pid_unset(last_cpupid) &&
>> 				cpupid_to_nid(last_cpupid) != dst_nid)
>> 		return false;
>>
>> 	/* Always allow migrate on private faults */
>> 	if (cpupid_match_pid(p, last_cpupid))
>> 		return true;
>> ......
>>
>> If the node of the CPU that accessed the mTHP last time is different
>> from this time, which means there is some contention for that mTHP
>> among threads. So it will not allow migration.
> 
> Yes.  The two-stage filter in should_numa_migrate_memory() helps at some
> degree.
> 
> But the situation is somewhat different after your change.  Previously,
> in one round of NUMA balancing page table scanning, the number of the
> hint page fault for one process and one folio is 1.  After your change,
> the number may become folio_nr_pages().  So we need to evaluate the

Yes, this follows the same strategy as THP.

> original algorithm in the new situation and revise.  For example, use a
> N-stage filter for mTHP.

Yes, let me try if N-stage filter for mTHP can helpful.

> 
> Anyway, the NUMA balancing algorithm adjustment needs to be based on
> test results.
> 
> Another possibility is to emulate the original behavior as much as
> possible to try to reuse the original algorithm.  For example, we can
> restore all PTE maps upon the first hint page fault of a folio.  Then,
> the behavior is almost same as the original PMD mapped THP.  Personally,
> I prefer to use this as the first step.  Then, try to adjust the
> algorithm to take advantage of more information available.

OK, sounds reasonable, I will try.

>>
>> If the contention for the mTHP among threads is light or the accessing
>> is relatively stable, then we can allow migration?
>>
>>> For example, I think that we should avoid to migrate on the first fault
>>> for mTHP in should_numa_migrate_memory().
> 
> I am referring to the following code in should_numa_migrate_memory().
> 
> 	/*
> 	 * Allow first faults or private faults to migrate immediately early in
> 	 * the lifetime of a task. The magic number 4 is based on waiting for
> 	 * two full passes of the "multi-stage node selection" test that is
> 	 * executed below.
> 	 */
> 	if ((p->numa_preferred_nid == NUMA_NO_NODE || p->numa_scan_seq <= 4) &&
> 	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
> 		return true;
> 
> But, after thought about this again, I realized that the original PMD
> mapped THP may be migrated on the first fault sometimes.  So, this isn't
> a new problem.  We may "optimize" it.  But it needn't to be part of this
> series.

Make sense. Thanks for your input.

