Return-Path: <linux-kernel+bounces-52096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9E849407
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60959280C07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC84C153;
	Mon,  5 Feb 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYrp53hL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078CBE4A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116082; cv=none; b=Dwp4kjmxQmAweT+GpMRFdcquAWZndiApl8WO8ysDmW+6ODAW3bBHAKPB7i20t7Gd9KocRKqGUH8DA3E0UOAmdZYdyLyCO06Uwvxx4K2Ig+LmjNaEbgdwHXHEpCpToutnOQ1ftargRPY50seBFg4SXBxx8bVxBejj9HXXr+nh6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116082; c=relaxed/simple;
	bh=9RL5KR1hpJcQae+rJ4QHCvOl5EYuXsE3JTpP7Zi4wtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pnl1TmgTVNdITdjrymQQBouOaT059WMvQD7QB3x8DkDv7/UB4+dVcQcElTKh6N5HTHwzxClA49jzMrLs5wwIBiKmPcCy8uGosqNcFnInOZ01G/9y/PKjK3/RM2n0TmuANgnO/NSloMoOkOEvgV/X8ySverc4KkfsxAwrNXeKhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYrp53hL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707116080; x=1738652080;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9RL5KR1hpJcQae+rJ4QHCvOl5EYuXsE3JTpP7Zi4wtY=;
  b=MYrp53hLcklRtfNo+/hVj2EG58UNDRAu7KJXPUVppVM8HQPmc/MaVxBP
   T82JO+Z5fOhg2MrqWfJcyesEYE18g3rpZmSZvoLLst04yN+PglP2+5J44
   /k576YX4bl/p8gwmlW7oDtOmKekrPkuhUmX7ncAaWHAgfricBvPAatGSK
   VhMLHmgL40MA6QZ+tLN9dshXSP+vbK3QRbl+ojP2JUyFLNFfvnRBMHzwb
   XXaxi1X6gAkobS3DY1e7Gao4Z/k0qhI+NFP4hQJc8+rXnZS6TsUoY32PU
   lcTg8pkBizSXPBfFFMzdas/z5q3+LkmhuQsTXrr8PYlD/Q+pAafR7s/PS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11553999"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11553999"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 22:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="930460"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 22:54:37 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <willy@infradead.org>,
  <fengwei.yin@intel.com>,  <aneesh.kumar@linux.ibm.com>,
  <shy828301@gmail.com>,  <hughd@google.com>,  <david@redhat.com>,
  <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] filemap: avoid unnecessary major faults in filemap_fault()
In-Reply-To: <85e03dd9-8bd7-d516-ebe4-84dd449a9fb2@huawei.com> (zhangpeng's
	message of "Mon, 5 Feb 2024 14:43:07 +0800")
References: <20240204093526.212636-1-zhangpeng362@huawei.com>
	<87zfwf39ha.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<85e03dd9-8bd7-d516-ebe4-84dd449a9fb2@huawei.com>
Date: Mon, 05 Feb 2024 14:52:40 +0800
Message-ID: <87mssf2yiv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"zhangpeng (AS)" <zhangpeng362@huawei.com> writes:

> On 2024/2/5 10:56, Huang, Ying wrote:
>
>> Peng Zhang <zhangpeng362@huawei.com> writes:
>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>
>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>> in application, which leading to an unexpected performance issue[1].
>>>
>>> This caused by temporarily cleared PTE during a read/modify/write update
>>> of the PTE, eg, do_numa_page()/change_pte_range().
>>>
>>> For the data segment of the user-mode program, the global variable area
>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>> (anonymous pages), but the original file pages cannot be locked and may
>>> be reclaimed. If the global variable (private anon page) is accessed when
>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>
>>> At this time, the original private file page may have been reclaimed.
>>> If the page cache is not available at this time, a major fault will be
>>> triggered and the file will be read, causing additional overhead.
>>>
>>> Fix this by rechecking the PTE without acquiring PTL in filemap_fault()
>>> before triggering a major fault.
>>>
>>> Testing file anonymous page read and write page fault performance in ext4
>>> and ramdisk using will-it-scale[2] on a x86 physical machine. The data
>>> is the average change compared with the mainline after the patch is
>>> applied. The test results are within the range of fluctuation, and there
>>> is no obvious difference. The test results are as follows:
>>> 			processes processes_idle threads threads_idle
>>> ext4 file write:	-1.14%    -0.08%         -1.87%  0.13%
>>> ext4 file read:		 0.03%	  -0.65%         -0.51%	-0.08%
>>> ramdisk file write:	-1.21%    -0.21%         -1.12%  0.11%
>>> ramdisk file read:	 0.00%    -0.68%         -0.33% -0.02%
>>>
>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>> [2] https://github.com/antonblanchard/will-it-scale/
>>>
>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>> Suggested-by: Yin Fengwei <fengwei.yin@intel.com>
>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>> RFC->v1:
>>> - Add error handling when ptep == NULL per Huang, Ying and Matthew Wilcox
>>> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>>>    Huang, Ying and Yin Fengwei
>>> - Add pmd_none() check before PTE map
>>> - Update commit message and add performance test information
>>>
>>>   mm/filemap.c | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 142864338ca4..b29cdeb6a03b 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -3238,6 +3238,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>   			mapping_locked = true;
>>>   		}
>>>   	} else {
>>> +		if (!pmd_none(*vmf->pmd)) {
>>> +			pte_t *ptep;
>>> +
>>> +			ptep = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>>> +						     vmf->address, &vmf->ptl);
>>> +			if (unlikely(!ptep))
>>> +				return VM_FAULT_NOPAGE;
>>> +			/*
>>> +			 * Recheck pte as the pte can be cleared temporarily
>>> +			 * during a read/modify/write update.
>>> +			 */
>> I think that we should add some comments here about the racy checking.
>
> I'll add comments in a v2 as follows:
> /*
>  * Recheck PTE as the PTE can be cleared temporarily
>  * during a read/modify/write update of the PTE, eg,
>  * do_numa_page()/change_pte_range(). This will trigger
>  * a major fault, even if we use mlockall, which may
>  * affect performance.
>  */

Sorry, my previous words aren't clear enough.  I mean some comments as
follows,

We don't hold PTL here, so the check is still racy.  But acquiring PTL
hurts performance and the race window seems small enough.

--
Best Regards,
Huang, Ying

>>> +			if (unlikely(!pte_none(ptep_get_lockless(ptep))))
>>> +				ret = VM_FAULT_NOPAGE;
>>> +			pte_unmap(ptep);
>>> +			if (unlikely(ret))
>>> +				return ret;
>>> +		}
>>> +
>>>   		/* No page in the page cache at all */
>>>   		count_vm_event(PGMAJFAULT);
>>>   		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

