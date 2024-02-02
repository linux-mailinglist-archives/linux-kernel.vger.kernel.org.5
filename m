Return-Path: <linux-kernel+bounces-49066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1177846575
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8151B28C7F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03095BE7C;
	Fri,  2 Feb 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ur2X3BqM"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFABE5A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837751; cv=none; b=qE6pIugqodabZAzkGX3cFFeuYJSWnR0V4vqCRbRUKeCS8IQ6O7FA4exI+bpoy7guyV9qMBpizhEHktH9rtJSf98nRMvKJvhPUr+SHuurKyH/ip0H/JbUAIBYqgHwe9QV7TUmYxJogulQTfXl1jzSkLOqfu4u1iDl6uNxShTRhBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837751; c=relaxed/simple;
	bh=F9ZNWMC1priDn66Isq/cwxCImYuia0oBTmu0GO7YjOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2zN7EBTm1dkrZu3NJ4yEkQsZwVI3pUEQtIvFLOl1j0LdwsMj234a+7vI9EBcESFS/rZIRYM8VWpoiJSCJeQKJXODc/EmCvS6CHPv5/wNV08hNovoboTismg2VONtRudTFZWpRSip1Die3h4IiMv1bzsQAhRZIfO330qlyL/AZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ur2X3BqM; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706837740; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=K/ZwJLmczXG17maGF/I5cgBZNRxSQmwfPe60uv2e8mY=;
	b=ur2X3BqM89C+m/pVM0arfF46SljowHYDNN7TTNt/aKlZUSEUlTEVMyUq7zQeG7pvCr8NLvsLVOaB++PVTjVQeP2tcI/SmQHXWuOup/mXL3FOZepCZysIFYSCDCGrXqWFZtVdHbDC4jm9svtvslBXpH1qh0k9C5ttdtkPSe4pyKs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.v4q.H_1706837738;
Received: from 30.97.56.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.v4q.H_1706837738)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 09:35:39 +0800
Message-ID: <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
Date: Fri, 2 Feb 2024 09:35:58 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zbu4cD1XLFLfKan8@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/1/2024 11:27 PM, Michal Hocko wrote:
> On Thu 01-02-24 21:31:13, Baolin Wang wrote:
>> Since commit 369fa227c219 ("mm: make alloc_contig_range handle free
>> hugetlb pages"), the alloc_contig_range() can handle free hugetlb pages
>> by allocating a new fresh hugepage, and replacing the old one in the
>> free hugepage pool.
>>
>> However, our customers can still see the failure of alloc_contig_range()
>> when seeing a free hugetlb page. The reason is that, there are few memory
>> on the old hugetlb page's node, and it can not allocate a fresh hugetlb
>> page on the old hugetlb page's node in isolate_or_dissolve_huge_page() with
>> setting __GFP_THISNODE flag. This makes sense to some degree.
>>
>> Later, the commit ae37c7ff79f1 (" mm: make alloc_contig_range handle
>> in-use hugetlb pages") handles the in-use hugetlb pages by isolating it
>> and doing migration in __alloc_contig_migrate_range(), but it can allow
>> fallbacking to other numa node when allocating a new hugetlb in
>> alloc_migration_target().
>>
>> This introduces inconsistency to handling free and in-use hugetlb.
>> Considering the CMA allocation and memory hotplug relying on the
>> alloc_contig_range() are important in some scenarios, as well as keeping
>> the consistent hugetlb handling, we should remove the __GFP_THISNODE flag
>> in isolate_or_dissolve_huge_page() to allow fallbacking to other numa node,
>> which can solve the failure of alloc_contig_range() in our case.
> 
> I do agree that the inconsistency is not really good but I am not sure
> dropping __GFP_THISNODE is the right way forward. Breaking pre-allocated
> per-node pools might result in unexpected failures when node bound
> workloads doesn't get what is asssumed available. Keep in mind that our
> user APIs allow to pre-allocate per-node pools separately.

Yes, I agree, that is also what I concered. But sometimes users don't 
care about the distribution of per-node hugetlb, instead they are more 
concerned about the success of cma allocation or memory hotplug.

> The in-use hugetlb is a very similar case. While having a temporarily
> misplaced page doesn't really look terrible once that hugetlb page is
> released back into the pool we are back to the case above. Either we
> make sure that the node affinity is restored later on or it shouldn't be
> migrated to a different node at all.

Agree. So how about below changing?
(1) disallow fallbacking to other nodes when handing in-use hugetlb, 
which can ensure consistent behavior in handling hugetlb.
(2) introduce a new sysctl (may be named as 
"hugetlb_allow_fallback_nodes") for users to control to allow 
fallbacking, that can solve the CMA or memory hotplug failures that 
users are more concerned about.

