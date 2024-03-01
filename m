Return-Path: <linux-kernel+bounces-87738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7086D85E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B4B2846EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5492571;
	Fri,  1 Mar 2024 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8tNM22X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11981FAB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253313; cv=none; b=FPXX5BRFrCj7FN52VfxthqSZ0o7gzbS6D/DxN384LGtzii6A3ZBKBlnwHRAwVpx+15CTgRaDKDz8uYa0K2oMsya1lEK2BXGjzYqf94+hnI8IQii+3KN8u1BSeotKPBcC1MXlsnDBl4oqnAXKF86h7SDSutDQ6qwqw2MeLL6Cx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253313; c=relaxed/simple;
	bh=ZD9CfVPw76C//U5gqjrmuX+/zXDZnhaO8eUOwWKoqXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qa1pXvgFSsEOAtekySMTxzcY7aWXWbd74lhsIdgm7qYqWVGzOc2AHNChgT0JWmo+KpT2MYP530gAzrWCcafT2SNtR54os0Iy2u7GDz3rbKWr9O/BftFoy/YlnAgDT/sjftLQHgbYMnXYQAtU1ys2uEJ3wxsw5VlRNjxNFezKp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8tNM22X; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709253312; x=1740789312;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZD9CfVPw76C//U5gqjrmuX+/zXDZnhaO8eUOwWKoqXM=;
  b=T8tNM22XZedH6SBjYHxqOeN6G1c/weDxIvrjQn8HajNCwnyCt2MLkAvY
   +j/AzCT1madROexubU8BL7QzLTnrWgPpVsQE8bMApy3GW8+IVmqsc4hcM
   EPVXpF6zxUezbnwY0KX57jYfCrKP1/qRWnptbhZuqA/59qBINqRrLZAA/
   od3D3wVmk/I1do6+OI/lgr5X3UBY/C3zfkbYhfPXJPGukASAoyiHsSjz1
   AFwjP9Mps7BpPxpGqVKyN05O6oqTWpAYziR/Lz/h0A0yRN9pako7bquVl
   RrhKX1PKHykoopRjn4VwKgp4US2YRGA8K470YFkrEsBI6BQTjlQroI2LY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15184500"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="15184500"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 16:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12599031"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 16:35:07 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Byungchul Park <byungchul@sk.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  kernel_team@skhynix.com,  akpm@linux-foundation.org,
  vernhao@tencent.com,  mgorman@techsingularity.net,  hughd@google.com,
  willy@infradead.org,  peterz@infradead.org,  luto@kernel.org,
  tglx@linutronix.de,  mingo@redhat.com,  bp@alien8.de,
  dave.hansen@linux.intel.com,  rjgolo@gmail.com
Subject: Re: [RESEND PATCH v8 0/8] Reduce TLB flushes by 94% by improving
 folio migration
In-Reply-To: <54053f0d-024b-4064-8d82-235cc71b61f8@redhat.com> (David
	Hildenbrand's message of "Thu, 29 Feb 2024 10:33:44 +0100")
References: <20240226030613.22366-1-byungchul@sk.com>
	<20240229092810.GC64252@system.software.com>
	<54053f0d-024b-4064-8d82-235cc71b61f8@redhat.com>
Date: Fri, 01 Mar 2024 08:33:11 +0800
Message-ID: <87wmqmbxko.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 29.02.24 10:28, Byungchul Park wrote:
>> On Mon, Feb 26, 2024 at 12:06:05PM +0900, Byungchul Park wrote:
>>> Hi everyone,
>>>
>>> While I'm working with a tiered memory system e.g. CXL memory, I have
>>> been facing migration overhead esp. TLB shootdown on promotion or
>>> demotion between different tiers. Yeah.. most TLB shootdowns on
>>> migration through hinting fault can be avoided thanks to Huang Ying's
>>> work, commit 4d4b6d66db ("mm,unmap: avoid flushing TLB in batch if PTE
>>> is inaccessible"). See the following link:
>>>
>>> https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
>>>
>>> However, it's only for ones using hinting fault. I thought it'd be much
>>> better if we have a general mechanism to reduce the number of TLB
>>> flushes and TLB misses, that we can ultimately apply to any type of
>>> migration, I tried it only for tiering for now tho.
>>>
>>> I'm suggesting a mechanism called MIGRC that stands for 'Migration Read
>>> Copy', to reduce TLB flushes by keeping source and destination of folios
>>> participated in the migrations until all TLB flushes required are done,
>>> only if those folios are not mapped with write permission PTE entries.
>>>
>>> To achieve that:
>>>
>>>     1. For the folios that map only to non-writable TLB entries, prevent
>>>        TLB flush at migration by keeping both source and destination
>>>        folios, which will be handled later at a better time.
>>>
>>>     2. When any non-writable TLB entry changes to writable e.g. through
>>>        fault handler, give up migrc mechanism so as to perform TLB flush
>>>        required right away.
>>>
>>> I observed a big improvement of TLB flushes # and TLB misses # at the
>>> following evaluation using XSBench like:
>>>
>>>     1. itlb flush was reduced by 93.9%.
>>>     2. dtlb thread was reduced by 43.5%.
>>>     3. stlb flush was reduced by 24.9%.
>> Hi guys,
>
> Hi,
>
>> The TLB flush reduction is 25% ~ 94%, IMO, it's unbelievable.
>
> Can't we find at least one benchmark that shows an actual improvement
> on some system?
>
> Staring at the number TLB flushes is nice, but if it does not affect
> actual performance of at least one benchmark why do we even care?
>
> "12 files changed, 597 insertions(+), 59 deletions(-)"
>
> is not negligible and needs proper review.

And, the TLB flush is reduced at cost of memory wastage.  The old pages
could have been freed.  That may cause regression for some workloads.

> That review needs motivation. The current numbers do not seem to be
> motivating enough :)

--
Best Regards,
Huang, Ying

