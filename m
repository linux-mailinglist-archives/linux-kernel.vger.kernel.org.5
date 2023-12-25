Return-Path: <linux-kernel+bounces-10903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8181DE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF39DB20EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91F15B9;
	Mon, 25 Dec 2023 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h682B12Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE2110E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <135b3189-f459-4b57-9861-bb8acb999d91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703485805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXkiPRdEVvfi9LIMu0a4pQRnrGa3opN+NyWjT9LajSI=;
	b=h682B12QYqT/ZiBDMXBg7hxqm2zl3GqlcPYEpS6y3r1bGCN3rdgqF0yDtrO4pW4CUYWVXI
	sTJy5rRK3CQjhtBukguGXtqnO65rzWMecb3dF6Bh7A7RdO4oHUmUtz51k8Yklj7jcfBANa
	Xv5L0ZESaqeE7oGtj7aq7bWJxH5I2r4=
Date: Mon, 25 Dec 2023 14:29:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 03/13] mm: Provide generic pmd_thp_or_huge()
To: peterx@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Kravetz <mike.kravetz@oracle.com>,
 Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>, Andrew Jones <andrew.jones@linux.dev>,
 linux-arm-kernel@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
 "Kirill A . Shutemov" <kirill@shutemov.name>, linuxppc-dev@lists.ozlabs.org,
 Rik van Riel <riel@surriel.com>, linux-riscv@lists.infradead.org,
 Yang Shi <shy828301@gmail.com>, James Houghton <jthoughton@google.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>
References: <20231219075538.414708-1-peterx@redhat.com>
 <20231219075538.414708-4-peterx@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231219075538.414708-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2023/12/19 15:55, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>
> ARM defines pmd_thp_or_huge(), detecting either a THP or a huge PMD.  It
> can be a helpful helper if we want to merge more THP and hugetlb code
> paths.  Make it a generic default implementation, only exist when
> CONFIG_MMU.  Arch can overwrite it by defining its own version.
>
> For example, ARM's pgtable-2level.h defines it to always return false.
>
> Keep the macro declared with all config, it should be optimized to a false
> anyway if !THP && !HUGETLB.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/pgtable.h | 4 ++++
>   mm/gup.c                | 3 +--
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index af7639c3b0a3..6f2fa1977b8a 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1355,6 +1355,10 @@ static inline int pmd_write(pmd_t pmd)
>   #endif /* pmd_write */
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
> +#ifndef pmd_thp_or_huge

I think it may be the time to rename to pmd_thp_or_hugetlb,
the "huge" is really confusing. thp is not huge? Actually,
it is huge. It is better to make it more specific from now on, like
"hugetlb".

BTW, please cc me via the new email (muchun.song@linux.dev) next edition.

Thanks.

> +#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
> +#endif
> +
>   #ifndef pud_write
>   static inline int pud_write(pud_t pud)
>   {
> diff --git a/mm/gup.c b/mm/gup.c
> index 0a5f0e91bfec..efc9847e58fb 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3004,8 +3004,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
>   		if (!pmd_present(pmd))
>   			return 0;
>   
> -		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
> -			     pmd_devmap(pmd))) {
> +		if (unlikely(pmd_thp_or_huge(pmd) || pmd_devmap(pmd))) {
>   			/* See gup_pte_range() */
>   			if (pmd_protnone(pmd))
>   				return 0;


