Return-Path: <linux-kernel+bounces-122448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9988F7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178621F269FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564114F8BB;
	Thu, 28 Mar 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REtFROjd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623AFBF0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605952; cv=none; b=AC9STZKuYIUjS1GUbOnLZpcHtzYvVVxUXxE+e1v3pgRhith6nE00bn3tongedUubcTTqWBc3lSZFk2ZirZNWvtSfl/fzYy7qRr8JdpIt68SFEmFfJM4ulC+nZuYCT6pzfXCxSCy+WcCveixI1tJB066XCbYIkDATLQOd07AQQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605952; c=relaxed/simple;
	bh=nHVqUgy0BzoNR9z7rYrLXoLxZPoFsJsPCfy9cl7qqXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lgI+zqxlCMPvZvHbJnXkLFYsTsv/M4ClGSfRwIUo9uUyUekZLHLmxAOwrsI8mZ/hKK8iN1y/9i4lm+iByytbeQIwoLZiMP36/MQpYrFJVHqhjLPUoqIkgRS7et6j4Vs7j886EMHQE+2b+C0iPHnOuMI8tQYY1i3OAVXJVdE6sxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REtFROjd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711605949; x=1743141949;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nHVqUgy0BzoNR9z7rYrLXoLxZPoFsJsPCfy9cl7qqXI=;
  b=REtFROjdc8jPM1ojGhA6leQ90JGPScvQc7CwrcwJ0jrp1BWw5GapAbQC
   cOXB58E24rJv7XGruKymuWoZwWXx/z8X3+wsK/oZuS+qnFQmOQ8ycFQq2
   1In/S+34NBcAr08t7Z752KWOvu45coiTIYSI9qlAkkrO5Q34/OvcPmkiF
   v8Tvq78CkqGIp8UTpsjjCzh5B+4DnYdfLyOPC6JzXsFqx69vC9l6E8jZm
   DyZkMvPq/cOG8Tt0t19kD6sApSZfZrGVftbDVL8FS8vDPxlCa8C11gcQD
   I4OyyHMDrRfZVJVO61vpNm2YOmLAdyVoNBPVsdNGXQIA2kWmZpIgsyAwW
   w==;
X-CSE-ConnectionGUID: Hk0uYfzfQ+CWVQn+7qMWFQ==
X-CSE-MsgGUID: 8NfOc0ARRa6LT7iP41k1oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6934134"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6934134"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 23:05:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21201112"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 23:05:46 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large
 address space
In-Reply-To: <dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com> (Bharata B. Rao's
	message of "Thu, 28 Mar 2024 11:19:40 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
	<87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
Date: Thu, 28 Mar 2024 14:03:53 +0800
Message-ID: <87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> On 28-Mar-24 11:05 AM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> In order to check how efficiently the existing NUMA balancing
>>> based hot page promotion mechanism can detect hot regions and
>>> promote pages for workloads with large memory footprints, I
>>> wrote and tested a program that allocates huge amount of
>>> memory but routinely touches only small parts of it.
>>>
>>> This microbenchmark provisions memory both on DRAM node and CXL node.
>>> It then divides the entire allocated memory into chunks of smaller
>>> size and randomly choses a chunk for generating memory accesses.
>>> Each chunk is then accessed for a fixed number of iterations to
>>> create the notion of hotness. Within each chunk, the individual
>>> pages at 4K granularity are again accessed in random fashion.
>>>
>>> When a chunk is taken up for access in this manner, its pages
>>> can either be residing on DRAM or CXL. In the latter case, the NUMA
>>> balancing driven hot page promotion logic is expected to detect and
>>> promote the hot pages that reside on CXL.
>>>
>>> The experiment was conducted on a 2P AMD Bergamo system that has
>>> CXL as the 3rd node.
>>>
>>> $ numactl -H
>>> available: 3 nodes (0-2)
>>> node 0 cpus: 0-127,256-383
>>> node 0 size: 128054 MB
>>> node 1 cpus: 128-255,384-511
>>> node 1 size: 128880 MB
>>> node 2 cpus:
>>> node 2 size: 129024 MB
>>> node distances:
>>> node   0   1   2 
>>>   0:  10  32  60 
>>>   1:  32  10  50 
>>>   2:  255  255  10
>>>
>>> It is seen that number of pages that get promoted is really low and
>>> the reason for it happens to be that the NUMA hint fault latency turns
>>> out to be much higher than the hot threshold most of the times. Here
>>> are a few latency and threshold sample values captured from
>>> should_numa_migrate_memory() routine when the benchmark was run:
>>>
>>> latency	threshold (in ms)
>>> 20620	1125
>>> 56185	1125
>>> 98710	1250
>>> 148871	1375
>>> 182891	1625
>>> 369415	1875
>>> 630745	2000
>> 
>> The access latency of your workload is 20s to 630s, which appears too
>> long.  Can you try to increase the range of threshold to deal with that?
>> For example,
>> 
>> echo 100000 > /sys/kernel/debug/sched/numa_balancing/hot_threshold_ms
>
> That of course should help. But I was exploring alternatives where the
> notion of hotness can be de-linked from the absolute scanning time to

In fact, only relative time from scan to hint fault is recorded and
calculated, we have only limited bits.

> the extent possible. For large memory workloads where only parts of memory
> get accessed at once, the scanning time can lag from the actual access
> time significantly as the data above shows. Wondering if such cases can
> be addressed without having to be workload-specific.

Does it really matter to promote the quite cold pages (accessed every
more than 20s)?  And if so, how can we adjust the current algorithm to
cover that?  I think that may be possible via extending the threshold
range.  And I think that we can find some way to extending the range by
default if necessary.

--
Best Regards,
Huang, Ying

