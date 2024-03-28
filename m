Return-Path: <linux-kernel+bounces-122422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDED88F723
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6431C258E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD1405FC;
	Thu, 28 Mar 2024 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjCBogZL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2AD304
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603436; cv=none; b=UzYALGjIrtFkb3eCvJYUiFGMLr1tAsWNws7r3nV/g2oBY317soXYk0oLYDPqY8LnWZOLzMsiYs2cjrUO13wxW2xcFS4A95A8z8R+Mp514xWyyqtzNUAi6W2GJKJTwpkKAPblyX/8Fm2akDU/FndMJ/XmqkArfK/KbjBf3uUGS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603436; c=relaxed/simple;
	bh=lr3vnsOJwKQS0Kkh+w8aXgTiGji+fdCT1durYgzHSYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eedqYf5mHj4J9aHeoM+NUYqMy1Afiz6/wa2gWo90rf3dwHtw9GFXrKZtZ1pNnVn4x/cV3HJlk4yVyGEIaWKnqWIrzaev+fiDjqlZH3skHpnow3OwGG5n7tNFsxo/l+uwtQJHopLPFpAFf2YjC9WRbP555+IaqEzbfKuNrrpCSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjCBogZL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711603434; x=1743139434;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lr3vnsOJwKQS0Kkh+w8aXgTiGji+fdCT1durYgzHSYg=;
  b=TjCBogZLTeHQi5X2REf3ZywBhSFsZcTRsLSxMyCCyN6uLCiOHKheYLPu
   tse7owqGoI+RaYs1wHn5FOJgoVNagWB00PNwrdXuKHV1T8CU6T/ktU8sO
   5U31YWLQn9x5gKHfHB7ajKSW+rRHBr4cb9lF5YJ8by19hHT0w7oAjcdF2
   zvtes0HSJgpwVL9Pof+ki8rmGTtT+v8Gw9GYR8b7qP9AarYNljHiJY8QF
   aUqUKL5woI1jQEY6Qpp2Vzas2L/steN2cDcngQoaEooD6M6SeqMhPHWVI
   xnto5oSA8fEDOjEu3pILkvsjbEKoG3c4QCM2HxkFi6alRWf5OjmZLS8HE
   A==;
X-CSE-ConnectionGUID: ulDs/qFtQ+uqyk3l6j9NfA==
X-CSE-MsgGUID: uA8G5ohYQXygjZZa/EIpYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6868370"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6868370"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 22:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21247737"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 22:23:52 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 1/2] sched/numa: Fault count based NUMA hint fault
 latency
In-Reply-To: <e059df52-48fc-4e65-9eb0-c0d197625e6e@amd.com> (Bharata B. Rao's
	message of "Thu, 28 Mar 2024 10:09:50 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
	<20240327160237.2355-2-bharata@amd.com>
	<87r0fvktkn.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<e059df52-48fc-4e65-9eb0-c0d197625e6e@amd.com>
Date: Thu, 28 Mar 2024 13:21:58 +0800
Message-ID: <87msqjkk21.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> On 28-Mar-24 7:26 AM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>> [snip]
>> 
>>> @@ -1750,25 +1753,20 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
>>>  }
>>>  
>>>  /*
>>> - * For memory tiering mode, when page tables are scanned, the scan
>>> - * time will be recorded in struct page in addition to make page
>>> - * PROT_NONE for slow memory page.  So when the page is accessed, in
>>> - * hint page fault handler, the hint page fault latency is calculated
>>> - * via,
>>> + * For memory tiering mode, when page tables are scanned, the current
>>> + * hint fault count will be recorded in struct page in addition to
>>> + * make page PROT_NONE for slow memory page.  So when the page is
>>> + * accessed, in hint page fault handler, the hint page fault latency is
>>> + * calculated via,
>>>   *
>>> - *	hint page fault latency = hint page fault time - scan time
>>> + * hint page fault latency = current hint fault count - fault count at scan time
>>>   *
>>>   * The smaller the hint page fault latency, the higher the possibility
>>>   * for the page to be hot.
>>>   */
>>> -static int numa_hint_fault_latency(struct folio *folio)
>>> +static inline int numa_hint_fault_latency(struct folio *folio, int count)
>>>  {
>>> -	int last_time, time;
>>> -
>>> -	time = jiffies_to_msecs(jiffies);
>>> -	last_time = folio_xchg_access_time(folio, time);
>>> -
>>> -	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
>>> +	return count - folio_xchg_fault_count(folio, count);
>>>  }
>> 
>> I found count is task->mm->hint_faults.  That is a process wide
>> counting.  How do you connect the hotness of a folio with the count of
>> hint page fault in the process?  How do you compare the hotness of
>> folios among different processes?
>
> The global hint fault count that we already maintain could
> be used instead of per-task fault. That should take care
> of the concern you mention right?

I have plotted the total number of hint faults per second before, and it
changes a lot along the time.  So I don't think it is a good
measurement.

--
Best Regards,
Huang, Ying

