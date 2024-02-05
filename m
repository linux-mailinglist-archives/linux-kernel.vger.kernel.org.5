Return-Path: <linux-kernel+bounces-52681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23410849B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D052829E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D051CA85;
	Mon,  5 Feb 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kJQAAakD"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905C1C6B8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138369; cv=none; b=ZeB9NUi7AsAWXHzsooqcxDjU1rs1sFMeckUvmUZk8sm+xtG5WVCSh4L20YSFAPeEuenDl7Zl+C7pWuIXoiVSssRZE470YOpQykvkfytB/uZvzKfhP3rlZ+F9ZiRPq+DJwiA4vZVx8ZtRLEGuC2xSq0XmifKcChNboGf7XVKj4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138369; c=relaxed/simple;
	bh=y1MzrmTKyQQMIDspxzrWiCyHC2RD/xxzWm2WCEN+Cik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhaUYVJKZteu3FdRiRmZilcFYma4nJSd5KfbHKyG7bguuLohy76v9rrTUlJlM4AgCNeh+G1v8+lOXg8xIq4lnsPGsqPtvwEBrCj6hzqgLL60zAz2bVzDDgu6WgMAaUXv9+Ocm+Bwj7UkIogKFHF53D0fsgZ/tz9iFMEO7XdpbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kJQAAakD; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707138364; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HGoNLv2jRKFKzJDTTarPrBhake1p0+Zm7zJYtCUBCmY=;
	b=kJQAAakDRvJFUP/eunMdBqWVKgxAjsEp9FsJcilFBXXUO9ftzu+W0laMmOqPhNjYtLMrtE1RFtu6++1IvGv6x2GPlFPW8hN3ki99/2K6LRfpqExpy9B9G8kev54FyXgxDYT1DKE8WuDtgaG5NCto+QbgzkZ3oPqe6wMTQ+B58g0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0AXnX7_1707138362;
Received: from 192.168.0.105(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0AXnX7_1707138362)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 21:06:03 +0800
Message-ID: <2613b670-84f8-4f97-ab4e-0d480fc1a3f8@linux.alibaba.com>
Date: Mon, 5 Feb 2024 21:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
 <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
 <ZbylJr_bbWCUMjMl@tiehlicka>
 <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
 <Zby7-dTtPIy2k5pj@tiehlicka>
 <909cee7d-0201-4429-b85d-7d2662516e45@linux.alibaba.com>
 <ZcCnNPkNpE7KTHZu@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZcCnNPkNpE7KTHZu@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/5/2024 5:15 PM, Michal Hocko wrote:
> On Mon 05-02-24 10:50:32, Baolin Wang wrote:
>>
>>
>> On 2/2/2024 5:55 PM, Michal Hocko wrote:
>>> On Fri 02-02-24 17:29:02, Baolin Wang wrote:
>>>> On 2/2/2024 4:17 PM, Michal Hocko wrote:
>>> [...]
>>>>>> Agree. So how about below changing?
>>>>>> (1) disallow fallbacking to other nodes when handing in-use hugetlb, which
>>>>>> can ensure consistent behavior in handling hugetlb.
>>>>>
>>>>> I can see two cases here. alloc_contig_range which is an internal kernel
>>>>> user and then we have memory offlining. The former shouldn't break the
>>>>> per-node hugetlb pool reservations, the latter might not have any other
>>>>> choice (the whole node could get offline and that resembles breaking cpu
>>>>> affininty if the cpu is gone).
>>>>
>>>> IMO, not always true for memory offlining, when handling a free hugetlb, it
>>>> disallows fallbacking, which is inconsistent.
>>>
>>> It's been some time I've looked into that code so I am not 100% sure how
>>> the free pool is currently handled. The above is the way I _think_ it
>>> should work from the usability POV.
>>
>> Please see alloc_and_dissolve_hugetlb_folio().
> 
> This is the alloc_contig_range rather than offlining path. Page
> offlining migrates in-use pages to a _different_ node (as long as there is one
> available) via do_migrate_range and it disolves free hugetlb pages via
> dissolve_free_huge_pages. So the node's pool is altered but as this is
> an explicit offling operation I think there is not choice to go
> differently.
>   
>>>> Not only memory offlining, but also the longterm pinning (in
>>>> migrate_longterm_unpinnable_pages()) and memory failure (in
>>>> soft_offline_in_use_page()) can also break the per-node hugetlb pool
>>>> reservations.
>>>
>>> Bad
>>>
>>>>> Now I can see how a hugetlb page sitting inside a CMA region breaks CMA
>>>>> users expectations but hugetlb migration already tries hard to allocate
>>>>> a replacement hugetlb so the system must be under a heavy memory
>>>>> pressure if that fails, right? Is it possible that the hugetlb
>>>>> reservation is just overshooted here? Maybe the memory is just terribly
>>>>> fragmented though?
>>>>>
>>>>> Could you be more specific about numbers in your failure case?
>>>>
>>>> Sure. Our customer's machine contains serveral numa nodes, and the system
>>>> reserves a large number of CMA memory occupied 50% of the total memory which
>>>> is used for the virtual machine, meanwhile it also reserves lots of hugetlb
>>>> which can occupy 50% of the CMA. So before starting the virtual machine, the
>>>> hugetlb can use 50% of the CMA, but when starting the virtual machine, the
>>>> CMA will be used by the virtual machine and the hugetlb should be migrated
>>>> from CMA.
>>>
>>> Would it make more sense for hugetlb pages to _not_ use CMA in this
>>> case? I mean would be better off overall if the hugetlb pool was
>>> preallocated before the CMA is reserved? I do realize this is just
>>> working around the current limitations but it could be better than
>>> nothing.
>>
>> In this case, the CMA area is large and occupies 50% of the total memory.
>> The purpose is that, if no virtual machines are launched, then CMA memory
>> can be used by hugetlb as much as possible. Once the virtual machines need
>> to be launched, it is necessary to allocate CMA memory as much as possible,
>> such as migrating hugetlb from CMA memory.
> 
> I am afraid that your assumption doesn't correspond to the existing
> implemntation. hugetlb allocations are movable but they are certainly
> not as movable as regular pages. So you have to consider a bigger
> margin and spare memory to achieve a more reliable movability.
> 
> Have you tried to handle this from the userspace. It seems that you know
> when there is the CMA demand to you could rebalance hugetlb pools at
> that moment, no?

Maybe this can help, but this just mitigates the issue ...

>> After more thinking, I think we should still drop the __GFP_THISNODE flag in
>> alloc_and_dissolve_hugetlb_folio(). Firstly, not only it potentially cause
>> CMA allocation to fail, but it might also cause memory offline to fail like
>> I said in the commit message. Secondly, there have been no user reports
>> complaining about breaking the per-node hugetlb pool, although longterm
>> pinning, memory failure, and memory offline can potentially break the
>> per-node hugetlb pool.
> 
> It is quite possible that traditional users (like large DBs) do not use
> CMA heavily so such a problem was not observed so far. That doesn't mean
> those problems do not really matter.

CMA is just one case, as I mentioned before, other situations can also 
break the per-node hugetlb pool now.

Let's focus on the main point, why we should still keep inconsistency 
behavior to handle free and in-use hugetlb for alloc_contig_range()? 
That's really confused.

