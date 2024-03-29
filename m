Return-Path: <linux-kernel+bounces-123956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C8891044
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0A41F28611
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69A1426A;
	Fri, 29 Mar 2024 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxDxcoL8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0266EAE7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674960; cv=none; b=kScf1DxnZO+H0ySdFjprdJ1pqUDUZtR7+qUR6egqYv2hxU9Z+e73yIz4DbafJWhibA5sXUaSm2lOQiyXWLXEBrXjqzc4rO6p8ncaoIHs+Csg+/GLpQqYf+ExYmEskMZaPo5DElHlekZTVhiBTJgtNkIytupSeSo1Ew+B8MPGG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674960; c=relaxed/simple;
	bh=cGgwB0n8cSC0WP9JjZ7Cf0+zxSHRWczsVZP28R7/w6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pwSFjWpujA5ZxJLAUbWOMI9bn1wdNToep3TjiFBf6s5XRL6WBMANoaY+EpiuuqjdyavMUZuF8fLVZ94zz3tgMTS+ZVprLa00ornMikHkKn3qvGiJ3/Oj5BnjcsepSRgtaILlT1aQtDXudVyvw58wM4hdrdf/WX1T1DLcL6ALzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxDxcoL8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711674959; x=1743210959;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cGgwB0n8cSC0WP9JjZ7Cf0+zxSHRWczsVZP28R7/w6E=;
  b=bxDxcoL8MYYMCJ2QF2KPhAN4GlSFuVDouVT0rwwrUV/LcxMAvQFEc3VL
   q8cxTQptlHO2svBkRqwyC67alF3g7Ag3Zg733PZA5rSPum28ZyLitnv5l
   OgqDkMFXZiJQ4Lo9QcrdTtJp/tkDhPdp0g7xBJaL9McJ33JuUpacrrgJL
   DuXoIS60ZWjWuanlVlnPMajQRvf6JNV6MglIzJsUXHg8AmQYeUjhq8R7K
   T7kIl8kHsRgIJeBuIEgLarlhji9nvPa4urcVmPf+PGJ+hNOBS6aK38Oel
   Te2oLFvJ//WDJ4JkdEQMrBBNvLB+UlUbCX/UrGTqXvJ4GRkSXUNMZ3eNK
   g==;
X-CSE-ConnectionGUID: Xa56BMEhQR6gLyb+VdjwFg==
X-CSE-MsgGUID: yUU8jYo1QmyZTDeYaJWehQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6800282"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6800282"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21290431"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:15:55 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large
 address space
In-Reply-To: <929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com> (Bharata B. Rao's
	message of "Thu, 28 Mar 2024 11:59:15 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
	<87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
	<87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
Date: Fri, 29 Mar 2024 09:14:02 +0800
Message-ID: <875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> On 28-Mar-24 11:33 AM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> On 28-Mar-24 11:05 AM, Huang, Ying wrote:
>>>> Bharata B Rao <bharata@amd.com> writes:
>>>>
>>>>> In order to check how efficiently the existing NUMA balancing
>>>>> based hot page promotion mechanism can detect hot regions and
>>>>> promote pages for workloads with large memory footprints, I
>>>>> wrote and tested a program that allocates huge amount of
>>>>> memory but routinely touches only small parts of it.
>>>>>
>>>>> This microbenchmark provisions memory both on DRAM node and CXL node.
>>>>> It then divides the entire allocated memory into chunks of smaller
>>>>> size and randomly choses a chunk for generating memory accesses.
>>>>> Each chunk is then accessed for a fixed number of iterations to
>>>>> create the notion of hotness. Within each chunk, the individual
>>>>> pages at 4K granularity are again accessed in random fashion.
>>>>>
>>>>> When a chunk is taken up for access in this manner, its pages
>>>>> can either be residing on DRAM or CXL. In the latter case, the NUMA
>>>>> balancing driven hot page promotion logic is expected to detect and
>>>>> promote the hot pages that reside on CXL.
>>>>>
>>>>> The experiment was conducted on a 2P AMD Bergamo system that has
>>>>> CXL as the 3rd node.
>>>>>
>>>>> $ numactl -H
>>>>> available: 3 nodes (0-2)
>>>>> node 0 cpus: 0-127,256-383
>>>>> node 0 size: 128054 MB
>>>>> node 1 cpus: 128-255,384-511
>>>>> node 1 size: 128880 MB
>>>>> node 2 cpus:
>>>>> node 2 size: 129024 MB
>>>>> node distances:
>>>>> node   0   1   2 
>>>>>   0:  10  32  60 
>>>>>   1:  32  10  50 
>>>>>   2:  255  255  10
>>>>>
>>>>> It is seen that number of pages that get promoted is really low and
>>>>> the reason for it happens to be that the NUMA hint fault latency turns
>>>>> out to be much higher than the hot threshold most of the times. Here
>>>>> are a few latency and threshold sample values captured from
>>>>> should_numa_migrate_memory() routine when the benchmark was run:
>>>>>
>>>>> latency	threshold (in ms)
>>>>> 20620	1125
>>>>> 56185	1125
>>>>> 98710	1250
>>>>> 148871	1375
>>>>> 182891	1625
>>>>> 369415	1875
>>>>> 630745	2000
>>>>
>>>> The access latency of your workload is 20s to 630s, which appears too
>>>> long.  Can you try to increase the range of threshold to deal with that?
>>>> For example,
>>>>
>>>> echo 100000 > /sys/kernel/debug/sched/numa_balancing/hot_threshold_ms
>>>
>>> That of course should help. But I was exploring alternatives where the
>>> notion of hotness can be de-linked from the absolute scanning time to
>> 
>> In fact, only relative time from scan to hint fault is recorded and
>> calculated, we have only limited bits.
>> 
>>> the extent possible. For large memory workloads where only parts of memory
>>> get accessed at once, the scanning time can lag from the actual access
>>> time significantly as the data above shows. Wondering if such cases can
>>> be addressed without having to be workload-specific.
>> 
>> Does it really matter to promote the quite cold pages (accessed every
>> more than 20s)?  And if so, how can we adjust the current algorithm to
>> cover that?  I think that may be possible via extending the threshold
>> range.  And I think that we can find some way to extending the range by
>> default if necessary.
>
> I don't think the pages are cold but rather the existing mechanism fails
> to categorize them as hot. This is because the pages were scanned way
> before the accesses start happening. When repeated accesses are made to
> a chunk of memory that has been scanned a while back, none of those
> accesses get classified as hot because the scan time is way behind
> the current access time. That's the reason we are seeing the value
> of latency ranging from 20s to 630s as shown above.

If repeated accesses continue, the page will be identified as hot when
it is scanned next time even if we don't expand the threshold range.  If
the repeated accesses only last very short time, it makes little sense
to identify the pages as hot.  Right?

The bits to record scan time or hint page fault is limited, so it's
possible for it to overflow anyway.  We scan scale time stamp if
necessary (for example, from 1ms to 10ms).  But it's hard to scale fault
counter.  And nobody can guarantee the frequency of hint page fault must
be less 1/ms, if it's 10/ms, it can record even short interval.

--
Best Regards,
Huang, Ying

