Return-Path: <linux-kernel+bounces-154940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6D8AE351
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BCA1C21A09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A87C09F;
	Tue, 23 Apr 2024 11:03:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF45812B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870218; cv=none; b=McmGZiH4EAY2fbOTK7od/6l8h6YtPAVJtpHjgdOrJm7YXxqxDMV47HuHLwGtK05xR7KIIpLJO5Z+IHYDmJkbMHAkadJaG+pmmdumVO0ZjfKO/fbCk3dJZ/GHKaWAR5l2jVfhEFkQrxWCZXgnvAJpvUPUO969ekYdKvcvEUxnrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870218; c=relaxed/simple;
	bh=Q/2gtcyulav/9Q2+HHK8JUU7iDQ7d8y7qqKXMLxj2GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTwgsEei+BjFfjrPa55spKkeTLYotOkO8IctrgbEgAnX7D7Z2+C/W4IUPIJFXpvT0In1ZW7e2UiwIuNnuhlzje4n3OjuGGisFQJ2Z8jrAjv38svU+xYFyFVaplsB13FKSvFrIP2/fwpT7rvgSow4DCMo4rz50annTHjOqCpfWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F8B6339;
	Tue, 23 Apr 2024 04:04:00 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1936F3F7BD;
	Tue, 23 Apr 2024 04:03:29 -0700 (PDT)
Message-ID: <6aa25e2a-a6b6-4ab7-8300-053ca3c0d748@arm.com>
Date: Tue, 23 Apr 2024 12:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] mm: memory: extend finish_fault() to support
 large folio
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <358aefb1858b63164894d7d8504f3dae0b495366.1713755580.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <358aefb1858b63164894d7d8504f3dae0b495366.1713755580.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 08:02, Baolin Wang wrote:
> Add large folio mapping establishment support for finish_fault() as a preparation,
> to support multi-size THP allocation of anonymous shared pages in the following
> patches.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/memory.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b6fa5146b260..094a76730776 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4766,7 +4766,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct page *page;
> +	struct folio *folio;
>  	vm_fault_t ret;
> +	int nr_pages, i;
> +	unsigned long addr;
>  
>  	/* Did we COW the page? */
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
> @@ -4797,22 +4800,30 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  			return VM_FAULT_OOM;
>  	}
>  
> +	folio = page_folio(page);
> +	nr_pages = folio_nr_pages(folio);
> +	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);

I'm not sure this is safe. IIUC, finish_fault() is called for any file-backed
mapping. So you could have a situation where part of a (regular) file is mapped
in the process, faults and hits in the pagecache. But the folio returned by the
pagecache is bigger than the portion that the process has mapped. So you now end
up mapping beyond the VMA limits? In the pagecache case, you also can't assume
that the folio is naturally aligned in virtual address space.


>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> -				      vmf->address, &vmf->ptl);
> +				       addr, &vmf->ptl);
>  	if (!vmf->pte)
>  		return VM_FAULT_NOPAGE;
>  
>  	/* Re-check under ptl */
> -	if (likely(!vmf_pte_changed(vmf))) {
> -		struct folio *folio = page_folio(page);
> -
> -		set_pte_range(vmf, folio, page, 1, vmf->address);
> -		ret = 0;
> -	} else {
> +	if (nr_pages == 1 && vmf_pte_changed(vmf)) {
>  		update_mmu_tlb(vma, vmf->address, vmf->pte);
>  		ret = VM_FAULT_NOPAGE;
> +		goto unlock;
> +	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {

I think you have grabbed this from do_anonymous_page()? But I'm not sure it
works in the same way here as it does there. For the anon case, if userfaultfd
is armed, alloc_anon_folio() will only ever allocate order-0. So we end up in
the vmf_pte_changed() path, which will allow overwriting a uffd entry. But here,
there is nothing stopping nr_pages being greater than 1 when there could be a
uffd entry present, and you will fail due to the pte_range_none() check. (see
pte_marker_handle_uffd_wp()).

Thanks,
Ryan

> +		for (i = 0; i < nr_pages; i++)
> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
> +		ret = VM_FAULT_NOPAGE;
> +		goto unlock;
>  	}
>  
> +	set_pte_range(vmf, folio, &folio->page, nr_pages, addr);
> +	ret = 0;
> +
> +unlock:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	return ret;
>  }


