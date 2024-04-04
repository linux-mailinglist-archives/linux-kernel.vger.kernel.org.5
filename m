Return-Path: <linux-kernel+bounces-130762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3544897CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534241F2930D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77057F6;
	Thu,  4 Apr 2024 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PVDumhZv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF64689;
	Thu,  4 Apr 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189168; cv=none; b=BuRjEJq6iQndF8x/0p+T2aIYVXUD00+bU+zn1rgr0Wm2O6zlDHJope6UqNwfZ7UWz7Gq+rkMrXG57i5cgcnBfvRM/HUPUJ2MQCdejhfsi4c5kOamx/K4OCa//zbANLLmveiOOKvfDJnWEDTZIxpnMSHDVdAuuIjB55f4sMGevZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189168; c=relaxed/simple;
	bh=86HGuT92NJSuhazygmUlHsFjgMiiNB/mak1t22rWe5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOw8ceAZ8v9Fort0/c5PSmQI+GePlgprNfiW0XimhNrpq0PInNm8T8W8jSuEvJ22NSp2p8Tter9vENdbzD7anObGYAu3A+HHZ3w7dq0fbL3SbJfXgiVGwbVHCBvJJs5yD2jdXuEmdulEZdI0ZJQx/a0sf/hyqlZ3knduR9jWSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PVDumhZv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MhHyco6xzCUVvkgLlQHxaZjjr+F8wY1VDbF9HT0EPEk=; b=PVDumhZvavwMCqaVxRJqsbjYqp
	KJmz0/Tx3eUNvoC933V7Vr1eQHBJYCBsGuXvIr8UfZ8LMacSqG/9jfCUm/urGf5/j/KJc6DKjdgmK
	sg22bYodFxLdcSqqweqoWC4nMNdd0ldiCw2k8ShOTyf9WhgcpLQF5UwJJr/N8b6YKlWhkCnttXhJ2
	pqd4rnB6YlJTep2QWdde+vJgpJX41E8cPAKm2QbcQX7lKCZltPb79z4QGRPI53yNG9+kXWMS98LzY
	9KdU2CyVAeCJo6E/m0e/573R/XtEchj+gtz+SRXjH8NzfvMP6QK0/OQEHlGtJXFkXbEylzdHvjWcz
	jn5/ChDA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsAc9-00000006m5v-26wq;
	Thu, 04 Apr 2024 00:05:57 +0000
Date: Thu, 4 Apr 2024 01:05:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ryan Roberts <ryan.roberts@arm.com>, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/3] mm: Allow anon exclusive check over hugetlb tail
 pages
Message-ID: <Zg3u5Sh9EbbYPhaI@casper.infradead.org>
References: <20240403013249.1418299-1-peterx@redhat.com>
 <20240403013249.1418299-2-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403013249.1418299-2-peterx@redhat.com>

On Tue, Apr 02, 2024 at 09:32:47PM -0400, peterx@redhat.com wrote:
> +++ b/include/linux/page-flags.h
> @@ -1095,7 +1095,13 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
>  static __always_inline int PageAnonExclusive(const struct page *page)
>  {
>  	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
> -	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
> +	/*
> +	 * Allow the anon-exclusive check to work on hugetlb tail pages.
> +	 * Here hugetlb pages will always guarantee the anon-exclusiveness
> +	 * of the head page represents the tail pages.
> +	 */
> +	if (PageHuge(page) && !PageHead(page))
> +		page = compound_head(page);

I think this should be written as:

	/*
	 * HugeTLB stores this information on the head page; THP keeps
	 * it per page
	 */
	if (PageHuge(page))
		page = compound_head(page);

>  	return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
>  }

