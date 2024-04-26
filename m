Return-Path: <linux-kernel+bounces-160499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873338B3E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AA728A3EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E13715B579;
	Fri, 26 Apr 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hn9Z4gVI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E8148854
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152884; cv=none; b=nSd5QVROJZ7AH2zVVuHQLntYUDYvJAEYi4qIH/TWCHPsA9xWrUUsdj11ZhAd9rv9SAyxzbP6jiLU1q9UxMIiTrqco9pRSYSzFOIJLifxZtLmW+pEg63irSx1liJQMzponXji3S6ouq6PJiCaobRUvMpn69SggPY0LRl+xi1Sm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152884; c=relaxed/simple;
	bh=mRqrrwqCUQE1blvTPKPlca0CB4j+Sib/FmUAKUGcrYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzX8h8pMo8l54M7E2s9uOWPbNcg9pJIq+ymQLkEEqfb072dZE5hq3URWT/TnaN/IYIyRlqotUHxgc8ovFXW0WLTnMCe5RLBvtJ1dkOmdUCPWfHu5D/TAJNxXkWml1z0TiDSTIom4GHCM2zbLONvP5JUo/phyqzEWPvAnsm0dwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hn9Z4gVI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UUvYm71fjkEqtSxLHnGtOJW9nzuNwvObOROt5Vq5kDE=; b=hn9Z4gVIqvr6bBM9IEZqJ0TI8o
	48x4aZu0SVYcFUsy6Cxy8stS0svKwc8tqPOO+gti0aEyxKfYg/AIm2lxzKawlKfXchIMWCEcUhV1P
	8yFxyH+5DuHxjXsLZ9xZ/mmxIe5Am9vCLUJE1G4I4A+BRlDiYf/kYJt5+lD156c4raXEKREk0Sm8b
	Nu7D1dEbwoxbSzutsI5wCUCB6jOLZganYUzNajBnEVvGMHkNn/7duLouwqKgXHFtbTx51M81kYs5J
	crh6KuZ7D00yUEbzDbGWLS4WDkZ2bKp8Pp0oZbAdCyTzdrUN3W7eC66kzft0xiy4tSO7DVCJenCDk
	IatHAwYg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0PT2-00000005gwQ-3NQu;
	Fri, 26 Apr 2024 17:34:36 +0000
Date: Fri, 26 Apr 2024 18:34:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, linmiaohe@huawei.com,
	jane.chu@oracle.com, nao.horiguchi@gmail.com, osalvador@suse.de
Subject: Re: [PATCH] mm/memory-failure: remove shake_page()
Message-ID: <ZivlrMAwRI6xJhc-@casper.infradead.org>
References: <20240426171511.122887-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426171511.122887-1-sidhartha.kumar@oracle.com>

On Fri, Apr 26, 2024 at 10:15:11AM -0700, Sidhartha Kumar wrote:
> Use a folio in get_any_page() to save 5 calls to compound head and
> convert the last user of shake_page() to shake_folio(). This allows us
> to remove the shake_page() definition.

So I didn't do this before because I wasn't convinced it was safe.
We don't have a refcount on the folio, so the page might no longer
be part of this folio by the time we get the refcount on the folio.

I'd really like to see some argumentation for why this is safe.

> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/memory-failure.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 16ada4fb02b79..273f6fef29f25 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -385,11 +385,6 @@ void shake_folio(struct folio *folio)
>  }
>  EXPORT_SYMBOL_GPL(shake_folio);
>  
> -static void shake_page(struct page *page)
> -{
> -	shake_folio(page_folio(page));
> -}
> -
>  static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
>  		unsigned long address)
>  {
> @@ -1433,6 +1428,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>  {
>  	int ret = 0, pass = 0;
>  	bool count_increased = false;
> +	struct folio *folio = page_folio(p);
>  
>  	if (flags & MF_COUNT_INCREASED)
>  		count_increased = true;
> @@ -1446,7 +1442,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>  				if (pass++ < 3)
>  					goto try_again;
>  				ret = -EBUSY;
> -			} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
> +			} else if (!folio_test_hugetlb(folio) && !is_free_buddy_page(p)) {
>  				/* We raced with put_page, retry. */
>  				if (pass++ < 3)
>  					goto try_again;
> @@ -1459,7 +1455,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>  			 * page, retry.
>  			 */
>  			if (pass++ < 3) {
> -				shake_page(p);
> +				shake_folio(folio);
>  				goto try_again;
>  			}
>  			ret = -EIO;
> @@ -1467,7 +1463,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>  		}
>  	}
>  
> -	if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
> +	if (folio_test_hugetlb(folio) || HWPoisonHandlable(p, flags)) {
>  		ret = 1;
>  	} else {
>  		/*
> @@ -1475,12 +1471,12 @@ static int get_any_page(struct page *p, unsigned long flags)
>  		 * it into something we can handle.
>  		 */
>  		if (pass++ < 3) {
> -			put_page(p);
> -			shake_page(p);
> +			folio_put(folio);
> +			shake_folio(folio);
>  			count_increased = false;
>  			goto try_again;
>  		}
> -		put_page(p);
> +		folio_put(folio);
>  		ret = -EIO;
>  	}
>  out:
> @@ -1643,7 +1639,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>  
>  	/*
>  	 * try_to_unmap() might put mlocked page in lru cache, so call
> -	 * shake_page() again to ensure that it's flushed.
> +	 * shake_folio() again to ensure that it's flushed.
>  	 */
>  	if (mlocked)
>  		shake_folio(folio);
> -- 
> 2.44.0
> 

