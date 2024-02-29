Return-Path: <linux-kernel+bounces-86634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EFE86C81D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120101F2556F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DC77C0A1;
	Thu, 29 Feb 2024 11:35:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778487AE41
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206525; cv=none; b=gQu1/uVZplbd4rZPsscfEEJVgKo2SEMZH4wo1gVmPjKess7tlAaw2bMEwj5aV+oRBkvPVTKTH6etS4hXZuQLm/LeXsEpPOsQFJbP/Kfytu0jXPbUP9/kU3bgcxN/f/ismGJgOGZbMEMEfjSFKnDvQFdKRI9apu6mce8yppdckTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206525; c=relaxed/simple;
	bh=Tcv85mJuRG7F5HJeDHob15mnxzEcXiChVN1WZIyv8vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d28nRl76nfI0CGU4w4uDFzED099y1VvGRSTYheAyfdBJHHEiX+dG5AxPr6ujC3Mi9CUMkQSxDPSw8ysDoJsRCDix/34Zt4byvrM4duUngSoxXlIiAaAbQHBybYcmUSqkvckaPAa7QgHCyM23YvuJj59XPAB12BmHQVOYJZLBiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9159B1FB;
	Thu, 29 Feb 2024 03:36:01 -0800 (PST)
Received: from [10.57.68.58] (unknown [10.57.68.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3C43F762;
	Thu, 29 Feb 2024 03:35:21 -0800 (PST)
Message-ID: <ce00f9b2-f73f-4ae8-864e-ef2b9a62dbf5@arm.com>
Date: Thu, 29 Feb 2024 11:35:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory.c: do_numa_page(): remove a redundant page
 table read
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>
References: <20240228034151.459370-1-jhubbard@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240228034151.459370-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 03:41, John Hubbard wrote:
> do_numa_page() is reading from the same page table entry, twice, while
> holding the page table lock: once while checking that the pte hasn't
> changed, and again in order to modify the pte.
> 
> Instead, just read the pte once, and save it in the same old_pte
> variable that already exists. This has no effect on behavior, other than
> to provide a tiny potential improvement to performance, by avoiding the
> redundant memory read (which the compiler cannot elide, due to
> READ_ONCE()).
> 
> Also improve the associated comments nearby.
> 
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0bfc8b007c01..df0711982901 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4928,18 +4928,18 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	int flags = 0;
>  
>  	/*
> -	 * The "pte" at this point cannot be used safely without
> -	 * validation through pte_unmap_same(). It's of NUMA type but
> -	 * the pfn may be screwed if the read is non atomic.
> +	 * The pte cannot be used safely until we verify, while holding the page
> +	 * table lock, that its contents have not changed during fault handling.
>  	 */
>  	spin_lock(vmf->ptl);
> -	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
> +	/* Read the live PTE from the page tables: */
> +	old_pte = ptep_get(vmf->pte);
> +
> +	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  		goto out;
>  	}
>  
> -	/* Get the normal PTE  */
> -	old_pte = ptep_get(vmf->pte);
>  	pte = pte_modify(old_pte, vma->vm_page_prot);
>  
>  	/*


