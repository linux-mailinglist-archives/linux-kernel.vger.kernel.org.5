Return-Path: <linux-kernel+bounces-52001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA3849290
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04101F227D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6FF1170F;
	Mon,  5 Feb 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEVuMn+n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615611701
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707101883; cv=none; b=sOifaWuM35eB8oWFDHD+Y/Kax/iA7bPKLhplvwRS3qjeww9mgUwP+sxf8p53siOnjhhVh4mQRJz3+UR5ssJaS6Q3j5VpWElxlW8C+Q0HR0FvQNklNAuUlmltKCSrdkyEphRaBU/ocw3BzJmNPrXRcDCvLYrtoTr52l3Ci0ieJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707101883; c=relaxed/simple;
	bh=QtqgH51ZBA2W9PA1o3tEExSDvsMBkuJFIerDweVQyWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CKqjy3XzYVpAUdvlmLH4zF8zRrcyTZAzRy0nn7GlvBZh+G7+axhlioLiTtkWx7RrJuG0VH3hdUovQ+6qUGHjV+LZs43KY4skF5pchKcxws/L5FpxbWTwCq1RYzcZWej60oZCLX8yr24PwLMoAZWRpigkQA2Fm4iWrvl6yMN0MvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEVuMn+n; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707101881; x=1738637881;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QtqgH51ZBA2W9PA1o3tEExSDvsMBkuJFIerDweVQyWQ=;
  b=YEVuMn+nQKKyXCDvZDeFhg2m9ReFqfVYvyqSU4kv7D2Fa7GmnlG8nWan
   OFUB+XqyEXnudhVb8YwRIaHnQy+hf04/BdSf1Ya7QM/8cikjm7WyHgfQ1
   wQosN+09L/zyWBA4CcXKpwGJ8PpgajYD1akVyNADQfUBzSn2vtLcmxvZ8
   mEl+G3UqbykKNVKRCpw+8Kr8jNm8JtEBIJqPm4ThbY3ZEnXe5Nj8nvVAW
   8XY6RvDAnLHsCtioq2JxQvBmTieUFRYASUaSq8yNoABoaWcdQSSlmFfuP
   rakkFox1gUiCZd5HhhV5SfUYpsthQNCK3WDekyNKNqnLLflNZeF2IHWFK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="602419"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="602419"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 18:58:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="652545"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 18:57:57 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <willy@infradead.org>,
  <fengwei.yin@intel.com>,  <aneesh.kumar@linux.ibm.com>,
  <shy828301@gmail.com>,  <hughd@google.com>,  <david@redhat.com>,
  <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] filemap: avoid unnecessary major faults in filemap_fault()
In-Reply-To: <20240204093526.212636-1-zhangpeng362@huawei.com> (Peng Zhang's
	message of "Sun, 4 Feb 2024 17:35:26 +0800")
References: <20240204093526.212636-1-zhangpeng362@huawei.com>
Date: Mon, 05 Feb 2024 10:56:01 +0800
Message-ID: <87zfwf39ha.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Peng Zhang <zhangpeng362@huawei.com> writes:

> From: ZhangPeng <zhangpeng362@huawei.com>
>
> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
> in application, which leading to an unexpected performance issue[1].
>
> This caused by temporarily cleared PTE during a read/modify/write update
> of the PTE, eg, do_numa_page()/change_pte_range().
>
> For the data segment of the user-mode program, the global variable area
> is a private mapping. After the pagecache is loaded, the private anonymous
> page is generated after the COW is triggered. Mlockall can lock COW pages
> (anonymous pages), but the original file pages cannot be locked and may
> be reclaimed. If the global variable (private anon page) is accessed when
> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>
> At this time, the original private file page may have been reclaimed.
> If the page cache is not available at this time, a major fault will be
> triggered and the file will be read, causing additional overhead.
>
> Fix this by rechecking the PTE without acquiring PTL in filemap_fault()
> before triggering a major fault.
>
> Testing file anonymous page read and write page fault performance in ext4
> and ramdisk using will-it-scale[2] on a x86 physical machine. The data
> is the average change compared with the mainline after the patch is
> applied. The test results are within the range of fluctuation, and there
> is no obvious difference. The test results are as follows:
> 			processes processes_idle threads threads_idle
> ext4 file write:	-1.14%    -0.08%         -1.87%  0.13%
> ext4 file read:		 0.03%	  -0.65%         -0.51%	-0.08%
> ramdisk file write:	-1.21%    -0.21%         -1.12%  0.11%
> ramdisk file read:	 0.00%    -0.68%         -0.33% -0.02%
>
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
> [2] https://github.com/antonblanchard/will-it-scale/
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> RFC->v1:
> - Add error handling when ptep == NULL per Huang, Ying and Matthew Wilcox
> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>   Huang, Ying and Yin Fengwei
> - Add pmd_none() check before PTE map
> - Update commit message and add performance test information
>
>  mm/filemap.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 142864338ca4..b29cdeb6a03b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3238,6 +3238,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  			mapping_locked = true;
>  		}
>  	} else {
> +		if (!pmd_none(*vmf->pmd)) {
> +			pte_t *ptep;
> +
> +			ptep = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
> +						     vmf->address, &vmf->ptl);
> +			if (unlikely(!ptep))
> +				return VM_FAULT_NOPAGE;
> +			/*
> +			 * Recheck pte as the pte can be cleared temporarily
> +			 * during a read/modify/write update.
> +			 */

I think that we should add some comments here about the racy checking.

--
Best Regards,
Huang, Ying

> +			if (unlikely(!pte_none(ptep_get_lockless(ptep))))
> +				ret = VM_FAULT_NOPAGE;
> +			pte_unmap(ptep);
> +			if (unlikely(ret))
> +				return ret;
> +		}
> +
>  		/* No page in the page cache at all */
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

