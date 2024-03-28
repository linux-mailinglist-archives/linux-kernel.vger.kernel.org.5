Return-Path: <linux-kernel+bounces-122430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9288F757
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AD8B23E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90EF47F5B;
	Thu, 28 Mar 2024 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngQC02l1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1D46424
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604261; cv=none; b=qh8wx8NFazzWWtDV9GEq7+/3W5anUhtFMYWi5xxiQ8nVilewCaWz4oCBKIEqW+vCyqg4Nkskpmm6FfBn91/WEXmi/CXMrmSReSM/Y9RbC65ZHLdzb9uoiMEY5PPfhH5eOZZq/dkNnNORd3Z6sv1KKEv6ITKrXRx1bDePlD3c5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604261; c=relaxed/simple;
	bh=I1zV8l2wxGw1MD2JHTbYzY6hhxw7196Gef6nl+ubcWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XUTWaxikwSdYJn0xY3b/uIL6qU5msDlCuP6Ug0hqBaRc3EoF9O3XQ9OCRl8EmP154GWMMnvvqf1vrG9BoXNDxqQnV3Yqe/oJmlxxv7rAvf80KELQVmqpYFo+BxiQIVczMKYS3wgtbZi2EiGnrpJLKmRw0s/SHAFFIErw9rrnRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngQC02l1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711604260; x=1743140260;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=I1zV8l2wxGw1MD2JHTbYzY6hhxw7196Gef6nl+ubcWg=;
  b=ngQC02l1/HP1+ipq3fwjccUwlwWVLGLFoogeAIAwkUOrVrR/Dy7UqHCg
   FYOCjV6MqjTd7z62Yuk+bGCMWYXF8fA8mp+OoZ2xQHSfNebeK7j7/E+Ny
   6PkyEAPIiq2FVaaAwwuB+iBNo+JFJUKszgs+W1Axp4/f5YkImapQPIV9c
   lkc5gM+beIApjsAD+blSuCL3vEe4+boPkViP9t3I3vJ/JhKUMc4tjZunA
   qvmd3jP+Ag1o48I0rWG5NY2azd+ScRfHur9366541TgDBdzspmFArKWvP
   7426a67YxHk7G869MgaVIPBVUOTe3RJZ0oTKPzkOfg4BzYxhxavTu9Au6
   g==;
X-CSE-ConnectionGUID: M6TAfwOxRnqDuI2HXuDH/A==
X-CSE-MsgGUID: QF/2cYRuR0ONyhnyp16hQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18122846"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="18122846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 22:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="47732570"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 22:37:36 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large
 address space
In-Reply-To: <20240327160237.2355-1-bharata@amd.com> (Bharata B. Rao's message
	of "Wed, 27 Mar 2024 21:32:35 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
Date: Thu, 28 Mar 2024 13:35:42 +0800
Message-ID: <87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> In order to check how efficiently the existing NUMA balancing
> based hot page promotion mechanism can detect hot regions and
> promote pages for workloads with large memory footprints, I
> wrote and tested a program that allocates huge amount of
> memory but routinely touches only small parts of it.
>
> This microbenchmark provisions memory both on DRAM node and CXL node.
> It then divides the entire allocated memory into chunks of smaller
> size and randomly choses a chunk for generating memory accesses.
> Each chunk is then accessed for a fixed number of iterations to
> create the notion of hotness. Within each chunk, the individual
> pages at 4K granularity are again accessed in random fashion.
>
> When a chunk is taken up for access in this manner, its pages
> can either be residing on DRAM or CXL. In the latter case, the NUMA
> balancing driven hot page promotion logic is expected to detect and
> promote the hot pages that reside on CXL.
>
> The experiment was conducted on a 2P AMD Bergamo system that has
> CXL as the 3rd node.
>
> $ numactl -H
> available: 3 nodes (0-2)
> node 0 cpus: 0-127,256-383
> node 0 size: 128054 MB
> node 1 cpus: 128-255,384-511
> node 1 size: 128880 MB
> node 2 cpus:
> node 2 size: 129024 MB
> node distances:
> node   0   1   2 
>   0:  10  32  60 
>   1:  32  10  50 
>   2:  255  255  10
>
> It is seen that number of pages that get promoted is really low and
> the reason for it happens to be that the NUMA hint fault latency turns
> out to be much higher than the hot threshold most of the times. Here
> are a few latency and threshold sample values captured from
> should_numa_migrate_memory() routine when the benchmark was run:
>
> latency	threshold (in ms)
> 20620	1125
> 56185	1125
> 98710	1250
> 148871	1375
> 182891	1625
> 369415	1875
> 630745	2000

The access latency of your workload is 20s to 630s, which appears too
long.  Can you try to increase the range of threshold to deal with that?
For example,

echo 100000 > /sys/kernel/debug/sched/numa_balancing/hot_threshold_ms

[snip]

--
Best Regards,
Huang, Ying

