Return-Path: <linux-kernel+bounces-86174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF886C0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF99C1C20B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6F42A8C;
	Thu, 29 Feb 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsZXghKi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C323FB87
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188388; cv=none; b=RA0HskuSbAUUWhgAGlAuwfdM1CHQIcuzN/px/GkMtQgtE7DjsJbbociJssw4YroA4jbtThI5sERXqil3OSiNz5P9sq1lxVNVcJK/cWzG5jKDbbYOaQxGgMZNeIhYO5ARhGFasYm4wYKhioBv3Fcns+qC4lt2DkrxOcnzNwb/R7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188388; c=relaxed/simple;
	bh=NSlHiZ9lIHUdp/N5IbtcCw+XhruNoYntUSB5WUs3eCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PriOrrI3foo15yphCp3YEounxtVqvsAv6MaOKnqj/LS/aJrOjtc+ngDR5nVkhAu7kBeRFWefFp4IvI8LKEeufdryGaRze2sOLXphLnqcj84J4TrjX8vRO5kqcN+dAYY6vn9EaNFKqJ3VJkScT8YNYqfD3Q8LZuDE29XLIsrG26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsZXghKi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709188386; x=1740724386;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NSlHiZ9lIHUdp/N5IbtcCw+XhruNoYntUSB5WUs3eCI=;
  b=OsZXghKi7axyU79XrKauUALLG8OjESQVFhS8jom0WDwkNfyLkPsn3MT0
   MKt2dAyr3KtBAfwiwD5L2umTCx2WjNb1neRroImHtua/edMELTa9PZbz2
   olH/u+mxnwlOlcgmFNlOJlqPTak5NRCbG1DRDJucmAWh385aIYuAs7kEj
   /Zk5F31DTZW73PXW4u8/2rxJ23WxMAKlosh3GUshPVMRVlxgwVVLIPEce
   1d4xDvxASL0PqPsh2XFLXtQ0JpnbDroBD1e1TbeXancy+N/KhcIstkxk8
   PrRs3tALANzi+u1zUXrv7fdv1d4HpeG2GHICWdGJAALYeuWWt3OuWZDsb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21095163"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="21095163"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 22:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7928578"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 22:33:02 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <willy@infradead.org>,
  <fengwei.yin@intel.com>,  <david@redhat.com>,
  <aneesh.kumar@linux.ibm.com>,  <shy828301@gmail.com>,
  <hughd@google.com>,  <wangkefeng.wang@huawei.com>,
  <sunnanyong@huawei.com>
Subject: Re: [PATCH v3] filemap: avoid unnecessary major faults in
 filemap_fault()
In-Reply-To: <20240229060907.836589-1-zhangpeng362@huawei.com> (Peng Zhang's
	message of "Thu, 29 Feb 2024 14:09:07 +0800")
References: <20240229060907.836589-1-zhangpeng362@huawei.com>
Date: Thu, 29 Feb 2024 14:31:07 +0800
Message-ID: <87il27dbo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> in application, which leading to an unexpected issue[1].
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
> At this time, the original private file page may have been reclaimed.
> If the page cache is not available at this time, a major fault will be
> triggered and the file will be read, causing additional overhead.
>
> This issue affects our traffic analysis service. The inbound traffic is
> heavy. If a major fault occurs, the I/O schedule is triggered and the
> original I/O is suspended. Generally, the I/O schedule is 0.7 ms. If
> other applications are operating disks, the system needs to wait for
> more than 10 ms. However, the inbound traffic is heavy and the NIC buffer
> is small. As a result, packet loss occurs. But the traffic analysis service
> can't tolerate packet loss.
>
> Fix this by holding PTL and rechecking the PTE in filemap_fault() before
> triggering a major fault. We do this check only if vma is VM_LOCKED. In
> our service test environment, the baseline is 7 major faults / 12 hours.
> After the patch is applied, no major fault will be triggered.
>
> Testing file anonymous page read and write page fault performance in
> ext4, tmpfs and ramdisk using will-it-scale[2] on a x86 physical machine.
> The data is the average change compared with the mainline after the patch
> is applied. The test results are indicates some performance regressions.
> We do this check only if vma is VM_LOCKED, therefore, no performance
> regressions is caused for most common cases.
>
> The test results are as follows:
>                           processes processes_idle threads threads_idle
> ext4    private file write: -0.51%    0.08%          -0.03%  -0.04%
> ext4    shared  file write:  0.135%  -0.531%          2.883% -0.772%
> ramdisk private file write: -0.48%    0.23%          -1.08%   0.27%
> ramdisk private file  read:  0.07%   -6.90%          -5.85%  -0.70%

Have you retested with the VM_LOCKED optimization?  Why are there still
performance regression?

> tmpfs   private file write: -0.344%  -0.110%          0.200%  0.145%
> tmpfs   shared  file write:  0.958%   0.101%          2.781% -0.337%
> tmpfs   private file  read: -0.16%    0.00%          -0.12%   0.41%
>
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
> [2] https://github.com/antonblanchard/will-it-scale/
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2->v3:
> - Do this check only if vma is VM_LOCKED per David Hildenbrand
> - Hold PTL and recheck the PTE
> - Place the recheck code in a new function filemap_fault_recheck_pte()
>
> v1->v2:
> - Add more test results per Huang, Ying
> - Add more comments before check PTE per Huang, Ying, David Hildenbrand
>   and Yin Fengwei
> - Change pte_offset_map_nolock to pte_offset_map as the PTL won't
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
>  mm/filemap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4858d89f1b1..2668bac68df7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3181,6 +3181,42 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	return fpin;
>  }
>  
> +/*
> + * filemap_fault_recheck_pte - hold PTL and recheck whether pte is none.
> + * @vmf - the vm_fault for this fault.
> + *
> + * Recheck PTE as the PTE can be cleared temporarily during a read+clear/modify
> + * /write update of the PTE, eg, do_numa_page()/change_pte_range(). This will
> + * trigger an unexpected major fault, even if we use mlockall(), which may
> + * increase IO and thus cause other unexpected behavior.
> + *
> + * Return VM_FAULT_NOPAGE if the PTE is not none or pte_offset_map_lock()
> + * fails. In other cases, 0 is returned.
> + */
> +static vm_fault_t filemap_fault_recheck_pte(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
> +	pte_t *ptep;
> +
> +	if (!(vma->vm_flags & VM_LOCKED))
> +		return ret;
> +
> +	if (pmd_none(*vmf->pmd))
> +		return ret;
> +

How about check PTE without lock firstly?  I guess that this can improve
performance in common case (no race).

> +	ptep = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> +				   &vmf->ptl);
> +	if (unlikely(!ptep))
> +		return VM_FAULT_NOPAGE;
> +
> +	if (unlikely(!pte_none(ptep_get(ptep))))
> +		ret = VM_FAULT_NOPAGE;
> +
> +	pte_unmap_unlock(ptep, vmf->ptl);
> +	return ret;
> +}
> +
>  /**
>   * filemap_fault - read in file data for page fault handling
>   * @vmf:	struct vm_fault containing details of the fault
> @@ -3236,6 +3272,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  			mapping_locked = true;
>  		}
>  	} else {
> +		ret = filemap_fault_recheck_pte(vmf);
> +		if (unlikely(ret))
> +			return ret;
> +
>  		/* No page in the page cache at all */
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

--
Best Regards,
Huang, Ying

