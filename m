Return-Path: <linux-kernel+bounces-157180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB38B0DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DEAB23C92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7C15FA6A;
	Wed, 24 Apr 2024 15:20:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7115ECC1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972021; cv=none; b=RU2vxg17RRHFoEyUJR3FtzcWGX9uVSdlAjFAV1VmfoObaqzQs4IJaCkxWzheuXTBB2AfoijDYhv4ApuMXId7/aFqNUAiMw/3NTUgc5IDntRW16j5o+CJrtch2hcBML+oB0gyWngYUlW0BBofykMJguge/gMsPIqqPtVDFLODo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972021; c=relaxed/simple;
	bh=nwgezUI4IzzCaVHCCJcYkE9hKNW1UZyxciId9pUKDkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3apZV9KwpkiYcYlnKHU3dOUI4U1QXtUCSeXr7oMn/LoaNdkFEQknfwCkHq49Z2T/2Jdu/cG8k+zPqfWRkbezc3fmnbCbTWpJYmgXpXdzqoJUY7bZHs/ud2eJWkx/wmAYDQIr0x7nNQTYa6g+eVk82AqpRlY0UlsbYM1vlOFGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E0741063;
	Wed, 24 Apr 2024 08:20:45 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21C53F73F;
	Wed, 24 Apr 2024 08:20:16 -0700 (PDT)
Message-ID: <11455268-d522-4b3a-8961-892e42cc50f0@arm.com>
Date: Wed, 24 Apr 2024 16:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: introduce per-order mTHP split counters
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 akpm@linux-foundation.org
Cc: 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240424135148.30422-1-ioworker0@gmail.com>
 <ab18a4b1-bcbf-4417-b43a-5feae3b5ba66@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ab18a4b1-bcbf-4417-b43a-5feae3b5ba66@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2024 16:00, David Hildenbrand wrote:
> On 24.04.24 15:51, Lance Yang wrote:
>> Hi all,
>>
>> At present, the split counters in THP statistics no longer include
>> PTE-mapped mTHP. Therefore, we want to introduce per-order mTHP split
>> counters to monitor the frequency of mTHP splits. This will assist
>> developers in better analyzing and optimizing system performance.
>>
>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>>          split_page
>>          split_page_failed
>>          deferred_split_page
>>
>> Thanks,
>> Lance
>> ---
>>
>> Lance Yang (2):
>>   mm: add per-order mTHP split counters
>>   mm: add docs for per-order mTHP split counters
>>
>>   Documentation/admin-guide/mm/transhuge.rst | 16 ----------------
> 
> We really have to start documenting these, and what the sementics are.

I think the diffstat is backwards; the series definitely adds more lines than it
removes. And patch 2 is adding 16 lines of docs, not removing them. How are you
generating this? `git format-patch` should do it correctly for you.

> 
> E.g., is split_page_failed contained in split_page? Is deferred_split_page
> contained in split_page?
> 
> But also: just don't call it "split_page". Drop the "_page".
> 
> split
> split_failed
> split_deferred

I guess we are back in "should we be consistent with the existing vmstats"
territory, which uses split_page/split_page_failed/deferred_split_page

But here, I agree that dropping _page is nicer.

> 
> ?
> 


