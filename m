Return-Path: <linux-kernel+bounces-3997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE40817678
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF98284AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369BC3D54A;
	Mon, 18 Dec 2023 15:58:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BBC42388
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 088922F4;
	Mon, 18 Dec 2023 07:58:53 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F40D3F5A1;
	Mon, 18 Dec 2023 07:58:07 -0800 (PST)
Message-ID: <2edb0a15-a677-4e4e-b4f9-ba2d85bfaa46@arm.com>
Date: Mon, 18 Dec 2023 15:58:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/39] mm/huge_memory: page_add_file_rmap() ->
 folio_add_file_rmap_pmd()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-10-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-10-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2023 15:56, David Hildenbrand wrote:
> Let's convert remove_migration_pmd() and while at it, perform some folio
> conversion.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/huge_memory.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3a387c6f18b6..1f5634b2f374 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3577,6 +3577,7 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  
>  void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  {
> +	struct folio *folio = page_folio(new);
>  	struct vm_area_struct *vma = pvmw->vma;
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long address = pvmw->address;
> @@ -3588,7 +3589,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  		return;
>  
>  	entry = pmd_to_swp_entry(*pvmw->pmd);
> -	get_page(new);
> +	folio_get(folio);
>  	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
>  	if (pmd_swp_soft_dirty(*pvmw->pmd))
>  		pmde = pmd_mksoft_dirty(pmde);
> @@ -3599,10 +3600,10 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  	if (!is_migration_entry_young(entry))
>  		pmde = pmd_mkold(pmde);
>  	/* NOTE: this may contain setting soft-dirty on some archs */
> -	if (PageDirty(new) && is_migration_entry_dirty(entry))
> +	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
>  		pmde = pmd_mkdirty(pmde);
>  
> -	if (PageAnon(new)) {
> +	if (folio_test_anon(folio)) {
>  		rmap_t rmap_flags = RMAP_COMPOUND;
>  
>  		if (!is_readable_migration_entry(entry))
> @@ -3610,9 +3611,9 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  
>  		page_add_anon_rmap(new, vma, haddr, rmap_flags);
>  	} else {
> -		page_add_file_rmap(new, vma, true);
> +		folio_add_file_rmap_pmd(folio, new, vma);
>  	}
> -	VM_BUG_ON(pmd_write(pmde) && PageAnon(new) && !PageAnonExclusive(new));
> +	VM_BUG_ON(pmd_write(pmde) && folio_test_anon(folio) && !PageAnonExclusive(new));
>  	set_pmd_at(mm, haddr, pvmw->pmd, pmde);
>  
>  	/* No need to invalidate - it was non-present before */


