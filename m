Return-Path: <linux-kernel+bounces-72407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079585B2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460481C21AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF5059158;
	Tue, 20 Feb 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahNPY3Aw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CCD59149
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410426; cv=none; b=lKCaCbxJBBvr2hhDKAY6sThCooKPB2s8FzSa3gLGqLxxh0WAQhWhSauUrLRnJqj7yb0IC14mR6SR+PSB8GC73u7IjTxZr1444MS3NEoaT7a93OqE1gSbKYfHQAoWeOLGryXZPdhvyLudRqiVyxnYpOx4MNJcmwTFwXptDNAQ6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410426; c=relaxed/simple;
	bh=KjbpEsZcL6BLoOczV14V5gdnm8XEq0JhlG2bKfRK0nA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N8NDgOyr9WxlvFQP7UEf5UX50vyBJNYiuVh5vJEqXYyER3Ga2FzhFlSqYzXwOI8szo4tkK7GabdlQVYN7g4AvHpWcGK4JyJz+FiRY0BFdSZp6qhUmEEhkBPE3yInJXK04tu73t8Ld0wBp3VKPGpQHUQ4sfHJ9mjH3/Oout/ix6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahNPY3Aw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708410425; x=1739946425;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KjbpEsZcL6BLoOczV14V5gdnm8XEq0JhlG2bKfRK0nA=;
  b=ahNPY3AwbFpLa1SEt8FpZlVYc7uXRENmfD3+JEIXDWf4YbT9jwaw1BFU
   D2FrjcrVC+uY0viMwO70++sif4yJBDndP5PXktGBalm/MPicDfIRvmrRd
   vJl7f7GXjOUL+0rNQiZ2PB/aavaJjOFub3QCjjppHz2KnP/VchcE6TssA
   rMreKARDjUm9W6aotACujfOsbW1Qo0Nq8Va9j0noPb20SejPKb9VlYq1q
   UvVT3qGWlBdEb5d/EZN30av/izDfKJ2U49yYOmXOe2PpSup4fIu9vgg/0
   sd3G8Nu3yGiaJsaiB5mTk6EE2kJJBZCRmFq17QcwTHpmPh5cvH6NcrEde
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2401599"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2401599"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="27842144"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:26:59 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Donet Tom
 <donettom@linux.ibm.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Dave Hansen <dave.hansen@linux.intel.com>,
  Mel Gorman <mgorman@suse.de>,  Ben Widawsky <ben.widawsky@intel.com>,
  Feng Tang <feng.tang@intel.com>,  Michal Hocko <mhocko@kernel.org>,
  Andrea Arcangeli <aarcange@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van Riel
 <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Mike Kravetz <mike.kravetz@oracle.com>,  Vlastimil
 Babka <vbabka@suse.cz>,  Dan Williams <dan.j.williams@intel.com>,  Hugh
 Dickins <hughd@google.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,
  Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
In-Reply-To: <21f343fa-84a7-4539-91e2-6fc963dbfb62@kernel.org> (Aneesh Kumar
	K. V.'s message of "Tue, 20 Feb 2024 09:40:00 +0530")
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
	<20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
	<63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
	<20240219172130.82a16c1ebecbf8ba86a8987d@linux-foundation.org>
	<21f343fa-84a7-4539-91e2-6fc963dbfb62@kernel.org>
Date: Tue, 20 Feb 2024 14:25:03 +0800
Message-ID: <87frxnps8w.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Aneesh Kumar K.V" <aneesh.kumar@kernel.org> writes:

> On 2/20/24 6:51 AM, Andrew Morton wrote:
>> On Mon, 19 Feb 2024 14:04:23 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
>> 
>>>>> --- a/mm/mempolicy.c
>>>>> +++ b/mm/mempolicy.c
>>>>> @@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>>>>   		if (node_isset(curnid, pol->nodes))
>>>>>   			goto out;
>>>>>   		z = first_zones_zonelist(
>>>>> -				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>>>>> +				node_zonelist(thisnid, GFP_HIGHUSER),
>>>>>   				gfp_zone(GFP_HIGHUSER),
>>>>>   				&pol->nodes);
>>>>>   		polnid = zone_to_nid(z->zone);
>>>> 	int thisnid = cpu_to_node(thiscpu);
>>>>
>>>> Is there any dofference between numa_node_id() and
>>>> cpu_to_node(raw_smp_processor_id())?  And it it explicable that we're
>>>> using one here and not the other?
>>>
>>> Hi Andrew
>>>
>>> Both numa_node_id() and cpu_to_node(raw_smp_processor_id()) return the current execution node id,
>>> Since the current execution node is already fetched at the beginning (thisnid) we can reuse it instead of getting it again.
>> 
>> Sure, but mine was a broader thought: why do we have both?  Is one
>> preferable and if so why?
>
> IIUC these are two helpers to fetch current numa node id. and either of them can be used based on need. The default implementation shows the details.
> (One small difference is numa_node_id() can use optimized per cpu reader because it is fetching the per cpu variable of the currently running cpu.)
>
> #ifndef numa_node_id
> /* Returns the number of the current Node. */
> static inline int numa_node_id(void)
> {
> 	return raw_cpu_read(numa_node);
> }
> #endif
>
> #ifndef cpu_to_node
> static inline int cpu_to_node(int cpu)
> {
> 	return per_cpu(numa_node, cpu);
> }
> #endif
>
> In mpol_misplaced function, we need the cpu details because we are using that in other place (should_numa_migreate_memory()). So it makes it easy
> to use cpu_to_node(thiscpu) instead of numa_node_id(). 

IIUC, numa_node_id() is faster than cpu_to_node(thiscpu), even if we
have thiscpu already.  cpu_to_node() is mainly used to get the node of
NOT current CPU.  So, IMHO, we should only use numa_node_id() in this
function.

--
Best Regards,
Huang, Ying

