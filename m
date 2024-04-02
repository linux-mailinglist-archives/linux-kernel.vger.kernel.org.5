Return-Path: <linux-kernel+bounces-127277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2260C89491E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A44285B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDCCD53C;
	Tue,  2 Apr 2024 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ev9PO7FZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D0BA2D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023533; cv=none; b=BwhtPWtPjz2j/5ivfmXOUh16w/nmXifQhlhDbnc5YOI85j3M+X0cgEPEG15+1jST2tG6gW0gLSegrI1kgrgKLU/VAnQ6BIJDuDgX1bZExN/GnL1w/pmIoqGiklyor8KRb/qaXBKhDzKkRpruaPwQGH7xaNw3Im6hGdn6kM7p4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023533; c=relaxed/simple;
	bh=Zsrq55HsUs8+9JmV9nnFtceZ2D2s/p9Q4BjxBGEMSEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hpjbwPmNkVS+/JC1Xe40wvxvp9bsRXkzXnUD/u5tXX1cHdarJ0LUUlzQPJg1/VFnG5lFaybT6c5e0TGj2W5i10H4psXhl/OTHpZbS88xS4utbJsUUsVthLow8B3b8sGbX05O4zItpE1TRlqXv7Lylb3mbtBQe4gkyBecW2KT1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ev9PO7FZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712023532; x=1743559532;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Zsrq55HsUs8+9JmV9nnFtceZ2D2s/p9Q4BjxBGEMSEs=;
  b=ev9PO7FZwNDW6qg2KeGHJcY9a04EggV7tzKiEl/8cLi74fmmo7lxBleY
   uaVFhUq3myOKL2aAGmDikMTtT0FvZeYLkiElbdu7mz5uOgtrqGk/Ua+82
   z+JCb3EN2LSmIEMbg69InJUM2obpBzud12oScu4Md0vmYDHeIEnEEel5l
   TTSiT9TBq1igfw4Om7vNDG9VCWUHNUEyvDcO6dydtV/FljuYhzCjLAKIA
   hpt9XMYMQ8KsjP8SZX5+lmUJLTSGVCJSR12evhvyDpVob/S4NQbHRVO4P
   u4I1O8JdLeffRMphfSUvrybitPI9FM3UkzSyhouODNjolhBFLzA1tZGwR
   Q==;
X-CSE-ConnectionGUID: tKiCsixlTxOBDsYZBtO+bg==
X-CSE-MsgGUID: wcZqbtIKSTeT1aIZ3FLlXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7072601"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7072601"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17864259"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:05:29 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large
 address space
In-Reply-To: <7e373c71-b2dc-4ae4-9746-c840f2a513a5@amd.com> (Bharata B. Rao's
	message of "Mon, 1 Apr 2024 17:50:57 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
	<87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
	<87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
	<875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<7e373c71-b2dc-4ae4-9746-c840f2a513a5@amd.com>
Date: Tue, 02 Apr 2024 10:03:34 +0800
Message-ID: <87o7asfrm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> On 29-Mar-24 6:44 AM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
> <snip>
>>> I don't think the pages are cold but rather the existing mechanism fails
>>> to categorize them as hot. This is because the pages were scanned way
>>> before the accesses start happening. When repeated accesses are made to
>>> a chunk of memory that has been scanned a while back, none of those
>>> accesses get classified as hot because the scan time is way behind
>>> the current access time. That's the reason we are seeing the value
>>> of latency ranging from 20s to 630s as shown above.
>> 
>> If repeated accesses continue, the page will be identified as hot when
>> it is scanned next time even if we don't expand the threshold range.  If
>> the repeated accesses only last very short time, it makes little sense
>> to identify the pages as hot.  Right?
>
> The total allocated memory here is 192G and the chunk size is 1G. Each
> time one such 1G chunk is taken up randomly for generating memory accesses.
> Within that 1G, 262144 random accesses are performed and 262144 such
> accesses are repeated for 512 times. I thought that should be enough
> to classify that chunk of memory as hot.

IIUC, some pages are accessed in very short time (maybe within 1ms).
This isn't repeated access in a long period.  I think that pages
accessed repeatedly in a long period are good candidates for promoting.
But pages accessed frequently in only very short time aren't.

> But as we see, often times
> the scan time is lagging the access time by a large value.
>
> Let me instrument the code further to learn more insights (if possible)
> about the scanning/fault time behaviors here.
>
> Leaving the fault count based threshold apart, do you think there is
> value in updating the scan time for skipped pages/PTEs during every
> scan so that the scan time remains current for all the pages?

No, I don't think so.  That makes hint page fault latency more
inaccurate.

>> 
>> The bits to record scan time or hint page fault is limited, so it's
>> possible for it to overflow anyway.  We scan scale time stamp if
>> necessary (for example, from 1ms to 10ms).  But it's hard to scale fault
>> counter.  And nobody can guarantee the frequency of hint page fault must
>> be less 1/ms, if it's 10/ms, it can record even short interval.
>
> Yes, with the approach I have taken, the time factor is out of the
> equation and the notion of hotness is purely a factor of the number of
> faults (or accesses)

Sorry, I don't get your idea here.  I think that the fault count may be
worse than time in quite some cases.

--
Best Regards,
Huang, Ying

