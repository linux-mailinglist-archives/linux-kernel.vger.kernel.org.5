Return-Path: <linux-kernel+bounces-4008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F4817695
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E96C1C25587
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73E4238F;
	Mon, 18 Dec 2023 16:00:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4394237C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2EB42F4;
	Mon, 18 Dec 2023 08:01:18 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05403F5A1;
	Mon, 18 Dec 2023 08:00:32 -0800 (PST)
Message-ID: <5cae7442-360e-449e-a1a4-50c33b02b9ed@arm.com>
Date: Mon, 18 Dec 2023 16:00:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/39] mm/rmap: remove page_add_file_rmap()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-13-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-13-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2023 15:56, David Hildenbrand wrote:
> All users are gone, let's remove it.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/rmap.h |  2 --
>  mm/rmap.c            | 21 ---------------------
>  2 files changed, 23 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 1753900f4aed..7198905dc8be 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -240,8 +240,6 @@ void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address);
>  void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
> -void page_add_file_rmap(struct page *, struct vm_area_struct *,
> -		bool compound);
>  void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
>  		struct vm_area_struct *);
>  #define folio_add_file_rmap_pte(folio, page, vma) \
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4f30930a1162..2ff2f11275e5 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1467,27 +1467,6 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>  #endif
>  }
>  
> -/**
> - * page_add_file_rmap - add pte mapping to a file page
> - * @page:	the page to add the mapping to
> - * @vma:	the vm area in which the mapping is added
> - * @compound:	charge the page as compound or small page
> - *
> - * The caller needs to hold the pte lock.
> - */
> -void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
> -		bool compound)
> -{
> -	struct folio *folio = page_folio(page);
> -
> -	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
> -
> -	if (likely(!compound))
> -		folio_add_file_rmap_pte(folio, page, vma);
> -	else
> -		folio_add_file_rmap_pmd(folio, page, vma);
> -}
> -
>  /**
>   * page_remove_rmap - take down pte mapping from a page
>   * @page:	page to remove mapping from


