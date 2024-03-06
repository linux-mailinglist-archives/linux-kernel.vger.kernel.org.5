Return-Path: <linux-kernel+bounces-93533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5E1873116
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31619282665
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB8D5D8EA;
	Wed,  6 Mar 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAIWm4NP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E85BAD4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714986; cv=none; b=BZYcjWLmtKbe/s9zBA3tp52dGmHO0sV1Fki25KK2yWv2OWYyKpMtKmjVWjcaJ5+9TUtdWO65N049JIx8o/NLFqryNsGqJxSWSoj+uQL7PmUdcYP4u5ytktYeW/+BGPR4kBgxMn+/5cfks/AUkv4muRYQ5yqR57ROvvtgkHRhHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714986; c=relaxed/simple;
	bh=yYuU7VBni22INYGto9gt3oHjxTlQN5HG/8o/ajfAzJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A656mz4033mDe+V4v3BUWH8kT0QfdThBTaB26RqRf4AsCZSPorcqLAYVrNJPfhUsHZRsFd/ECGWhsmuMAcpLa1SGMEQk2NwYvo8Z9JJNGv3P2TL+xzYDKy7ztaFwJJyQAd5qBbROYgayEI8drzPMEWsD9ZBn17hq/vxB6m+41Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAIWm4NP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709714984; x=1741250984;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yYuU7VBni22INYGto9gt3oHjxTlQN5HG/8o/ajfAzJk=;
  b=hAIWm4NPKv2/Ya0UsDn56gZ82PDpk7uYTfLZBt+pm/+fKTFCJbbzgic8
   DU7Dpj4yNK2YqG0tXF/WytQNY1rztsJ+h60zXyDFlNZO83VyDCkHNImSX
   FAPy79lpe1aH/G2QUWG/NuahW2hIdbrv5nh0mWI7FiZW7+puOcdZ63Xyr
   dk0syn1HUm/ftprQ1IZbEJ/AxCi/wJBBY68RwODgrQMQ0uC4Pbvc9nWZW
   1K+R3eE277euqJm8T05a1fh/OBoqg7QX3Gpwj2kJkiS7NgCA5Mdo/zxnn
   7jGiJXFx3j6oYqM3BuF1eieyAki8QTspAmqJjOiXj1CANyLlSwYJGBvln
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="29765374"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="29765374"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 00:49:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9628784"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 00:49:40 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <willy@infradead.org>,
  <fengwei.yin@intel.com>,  <david@redhat.com>,
  <aneesh.kumar@linux.ibm.com>,  <shy828301@gmail.com>,
  <hughd@google.com>,  <wangkefeng.wang@huawei.com>,
  <sunnanyong@huawei.com>
Subject: Re: [PATCH v4] filemap: avoid unnecessary major faults in
 filemap_fault()
In-Reply-To: <20240306083809.1236634-1-zhangpeng362@huawei.com> (Peng Zhang's
	message of "Wed, 6 Mar 2024 16:38:09 +0800")
References: <20240306083809.1236634-1-zhangpeng362@huawei.com>
Date: Wed, 06 Mar 2024 16:47:45 +0800
Message-ID: <871q8n926m.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> triggering a major fault. We do this check only if vma is VM_LOCKED to
> reduce the performance impact in common scenarios.
>
> In our product environment, there were 7 major faults every 12 hours.
> After the patch is applied, no major fault have been triggered.
>
> Testing file page read and write page fault performance in ext4 and
> ramdisk using will-it-scale[2] on a x86 physical machine. The data is
> the average change compared with the mainline after the patch is applied.
> The test results are within the range of fluctuation. We do this check
> only if vma is VM_LOCKED, therefore, no performance regressions is caused
> for most common cases.
>
> The test results are as follows:
>                           processes processes_idle  threads threads_idle
> ext4    private file write:  0.22%    0.26%           1.21%  -0.15%
> ext4    private file  read:  0.03%    1.00%           1.39%   0.34%
> ext4    shared  file write: -0.50%   -0.02%          -0.14%  -0.02%
> ramdisk private file write:  0.07%    0.02%           0.53%   0.04%
> ramdisk private file  read:  0.01%    1.60%          -0.32%  -0.02%
>
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
> [2] https://github.com/antonblanchard/will-it-scale/
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

LGTM, Thanks!  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
> v3->v4:
> - Update the performance data and commit message
> - Check PTE without lock firstly per Huang, Ying
> - Update comments for recheck function per David Hildenbrand
> - Simply return 0 to make it easier to read per David Hildenbrand
> - Check !FAULT_FLAG_ORIG_PTE_VALID instead of pmd_none()
>
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
>  mm/filemap.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4858d89f1b1..31ab455c4537 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3181,6 +3181,48 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	return fpin;
>  }
>  
> +static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
> +	pte_t *ptep;
> +
> +	/*
> +	 * We might have COW'ed a pagecache folio and might now have an mlocked
> +	 * anon folio mapped. The original pagecache folio is not mlocked and
> +	 * might have been evicted. During a read+clear/modify/write update of
> +	 * the PTE, such as done in do_numa_page()/change_pte_range(), we
> +	 * temporarily clear the PTE under PT lock and might detect it here as
> +	 * "none" when not holding the PT lock.
> +	 *
> +	 * Not rechecking the PTE under PT lock could result in an unexpected
> +	 * major fault in an mlock'ed region. Recheck only for this special
> +	 * scenario while holding the PT lock, to not degrade non-mlocked
> +	 * scenarios. Recheck the PTE without PT lock firstly, thereby reducing
> +	 * the number of times we hold PT lock.
> +	 */
> +	if (!(vma->vm_flags & VM_LOCKED))
> +		return 0;
> +
> +	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
> +		return 0;
> +
> +	ptep = pte_offset_map(vmf->pmd, vmf->address);
> +	if (unlikely(!ptep))
> +		return VM_FAULT_NOPAGE;
> +
> +	if (unlikely(!pte_none(ptep_get_lockless(ptep)))) {
> +		ret = VM_FAULT_NOPAGE;
> +	} else {
> +		spin_lock(vmf->ptl);
> +		if (unlikely(!pte_none(ptep_get(ptep))))
> +			ret = VM_FAULT_NOPAGE;
> +		spin_unlock(vmf->ptl);
> +	}
> +	pte_unmap(ptep);
> +	return ret;
> +}
> +
>  /**
>   * filemap_fault - read in file data for page fault handling
>   * @vmf:	struct vm_fault containing details of the fault
> @@ -3236,6 +3278,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  			mapping_locked = true;
>  		}
>  	} else {
> +		ret = filemap_fault_recheck_pte_none(vmf);
> +		if (unlikely(ret))
> +			return ret;
> +
>  		/* No page in the page cache at all */
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

