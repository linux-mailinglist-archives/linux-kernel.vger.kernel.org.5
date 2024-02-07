Return-Path: <linux-kernel+bounces-55849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604E84C27A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF901F22554
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF613FC0A;
	Wed,  7 Feb 2024 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3urytyN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E0FBF7
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272611; cv=none; b=ha9kVJel20ybcjsVvhA4Pmx0p8f/GEbZgKBMdx3sv7OXkFzq7qbrvt56M3vGqJrL1WkQWprO7amHe09Bvfbs7GxNK5af5o36yPjbkkSQ2UkpMSgLoSs2ctEyAQzGE/ASblBQ4BfzOsqGZKkMAP8oIIanqOQNqqEWSyotWHdu9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272611; c=relaxed/simple;
	bh=4N/5tP5iMHWmFVdx1HRYIF5wy7QwMIH1xbJY0jDg6SY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1+aKBqWlC8P026nnTROTGur8z09Rc6NUZgC4fRNIK2wscY6lrs58cNA6I/MHt32XaM3VcVw6MgbBDDf7+iQJp6kd07+QqI9UGOB1o3rR5X9Cl5KM39F0WuGkEFfEKwu3eIRv/OA+BB0d+la2vLJfF7A6eMKGFvXPTK45EEz2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3urytyN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707272609; x=1738808609;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4N/5tP5iMHWmFVdx1HRYIF5wy7QwMIH1xbJY0jDg6SY=;
  b=n3urytyNasUK34OoiMnU4phaxGdhXeafV4HkxRtvVEGX5EdTMkFeg/v7
   osaatDIplz9Y+GdPWvp4z+AZlYN/glPDXOC2YEHXT+bj6fMiETvHHLMZr
   Fdk5dFYmanzhXNCYL6q+DbvHEtf0+zFLqg7jC47CM8fvqYR3WMBa2563s
   Huif5A9EghdghP5HAQzk8S5ckv+4+bZHUHbNdTkWVc2jcNmgs0J/R7r0u
   L1NtcNfiT1sgaUoesj6tMNGftFtqHhrpvY3ICv4tvEJqGeRht6fWqUxo2
   T4YYt5DWaexDEtUSgVIbH+SFO7LegoDDXhAFkbL8vX21PgB6xmDLJaE4k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="780232"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="780232"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 18:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1421154"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 18:23:25 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <willy@infradead.org>,
  <fengwei.yin@intel.com>,  <aneesh.kumar@linux.ibm.com>,
  <shy828301@gmail.com>,  <hughd@google.com>,  <david@redhat.com>,
  <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] filemap: avoid unnecessary major faults in
 filemap_fault()
In-Reply-To: <20240206092627.1421712-1-zhangpeng362@huawei.com> (Peng Zhang's
	message of "Tue, 6 Feb 2024 17:26:27 +0800")
References: <20240206092627.1421712-1-zhangpeng362@huawei.com>
Date: Wed, 07 Feb 2024 10:21:29 +0800
Message-ID: <87jznhypxy.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> This caused by temporarily cleared PTE during a read+clear/modify/write
> update of the PTE, eg, do_numa_page()/change_pte_range().
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

You still claim that there's no difference in the test results.  If so,
why do you implement the patch?  IMHO, you need to prove your patch can
improve the performance in some cases.

> 	                 processes processes_idle threads threads_idle
> ext4    private file write: -1.14%  -0.08%         -1.87%   0.13%
> ext4    shared  file write:  0.14%  -0.53%          2.88%  -0.77%
> ext4    private file  read:  0.03%  -0.65%         -0.51%  -0.08%
> tmpfs   private file write: -0.34%  -0.11%          0.20%   0.15%
> tmpfs   shared  file write:  0.96%   0.10%          2.78%  -0.34%
> ramdisk private file write: -1.21%  -0.21%         -1.12%   0.11%
> ramdisk private file  read:  0.00%  -0.68%         -0.33%  -0.02%
>
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
> [2] https://github.com/antonblanchard/will-it-scale/
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v1->v2:
> - Add more test results per Huang, Ying
> - Add more comments before check PTE per Huang, Ying, David Hildenbrand
>   and Yin Fengwei
> - Change pte_offset_map_nolock to pte_offset_map as the ptl lock won't
>   be used
>
> RFC->v1:
> - Add error handling when ptep == NULL per Huang, Ying and Matthew
>   Wilcox
> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>   Huang, Ying and Yin Fengwei
> - Add pmd_none() check before PTE map
> - Update commit message and add performance test information
>
>  mm/filemap.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 142864338ca4..a2c1a98bc771 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3238,6 +3238,40 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  			mapping_locked = true;
>  		}
>  	} else {
> +		if (!pmd_none(*vmf->pmd)) {
> +			pte_t *ptep;
> +
> +			ptep = pte_offset_map(vmf->pmd, vmf->address);
> +			if (unlikely(!ptep))
> +				return VM_FAULT_NOPAGE;
> +			/*
> +			 * Recheck PTE as the PTE can be cleared temporarily
> +			 * during a read+clear/modify/write update of the PTE,
> +			 * eg, do_numa_page()/change_pte_range(). This will
> +			 * trigger a major fault, even if we use mlockall,
> +			 * which may affect performance.
> +			 * We don't hold PTL here as acquiring PTL hurts
> +			 * performance. So the check is still racy, but
> +			 * the race window seems small enough.
> +			 *
> +			 * If we lose the race during the check, the page_fault
> +			 * will be triggered. Butthe page table entry lock
> +			 * still make sure the correctness:
> +			 * - If the page cache is not reclaimed, the page_fault
> +			 *   will work like the page fault was served already
> +			 *   and bail out.
> +			 * - If the page cache is reclaimed, the major fault
> +			 *   will be triggered, page cache is filled,
> +			 *   page_fault also work like the page fault was
> +			 *   served already and bail out.
> +			 */

IMHO, this is too long.  It can be shorten to like,

If we lose the race, major fault may be triggered unnecessary.  This
hurts performance but not functionality.

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

--
Best Regards,
Huang, Ying

