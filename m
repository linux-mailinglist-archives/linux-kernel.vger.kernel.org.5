Return-Path: <linux-kernel+bounces-51999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E3184928C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9903128340E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941610A0F;
	Mon,  5 Feb 2024 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKJWEpf9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B24101CE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707101798; cv=none; b=Jg3Ijui1ggfjYZiBmJaDGMDKQCBDgZxAWpc/e9dcUf0Z04euvufGHywLhUEHRnvL40Kr3oDF4armUcprxT4dzdulpvFiVbLBre6Ee0GEgUvnRqDVM7ZHR9+BzWGGQ9HXguXHR05VitQLA0Wck8uDsEm93AAlcKDFa77P57rHg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707101798; c=relaxed/simple;
	bh=SZWNQ8FoWi3M3figUlWgt62ZFK1sUamebkXL8IH7FkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFxOjvBgQNQNIcpQYZfwdloLQhD+6/pkKic1qVTIGHNKY5VHCiVsITBNmbV5apeIhK8XkiIE1Zr9sP2cIlfQQAMl9ykk+QNtM3boflgXC2zbP5ktBh8XsVD1Nrce4sLiBM1F6PShQNHEGxE+eW5VfHVVbeRGRo18OGMBZLa6uGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKJWEpf9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707101796; x=1738637796;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SZWNQ8FoWi3M3figUlWgt62ZFK1sUamebkXL8IH7FkQ=;
  b=YKJWEpf9gWLbOtfUJMVtlBVTfSSevcfEigUqttHdyl7YZ165n5huCDYC
   ynbO9aIntAu2WAwWoqO6AZAyoNkWCtwNGoZeZfeUrvfgq5hBnkpqMFyPN
   qmQymRJimqDx0sGJ86UF7oL/jBczH277jPy6vqGTv7Fcb6aPqQGY9HW4N
   cVK/J09bp8QXU2tjFMKo8vdy78DX5wQz4l2x+MGtxW4y+YBOIhWzqcI4x
   yuDtt6VQBAysFzG/sQcAnpCVgOXP5R/v+K6DkfQ3bLk6e9RutgVSh7uXJ
   vaXQ/qUKMdR2EAkQqlH+dVWH/r6p0wZ7l4oodaNdrgWHY6JJfqPaVHa2r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="690670"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="690670"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 18:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5222594"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 18:56:32 -0800
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
Date: Mon, 05 Feb 2024 10:54:36 +0800
Message-ID: <874jen4o43.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

IIUC, this is the regression test results.  Right?  Can you also show
improvement test results to justify the change?

--
Best Regards,
Huang, Ying

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

