Return-Path: <linux-kernel+bounces-109050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AF8813F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1ABB283668
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0334C629;
	Wed, 20 Mar 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EVVWGDMH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC94AEF0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946639; cv=none; b=rz1cx1Ej+x17z1ZGphQFZ5NDqFmErUiQrtwha8gZNUFhWaWUOMmWzyZJnXqy1aVqiqSUiVTTt918NqnstZrbzqfWBPWCY2awg7h9WzLXWO63m8G6Llc5O5hbr72+HufexjlXPeOVjrfVfP4OqyqOY01lJSJkovPZze/X92TXtho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946639; c=relaxed/simple;
	bh=jxz90Vwk/KeGSdB2hNfASqxAyf8cA8P0aDldD+//xo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcIU1UXRid8DcUVFefm7s85LGnZZPjXAn0Fv90nNWig8dAWINOLws+hg5GTc1aQu0vYDLg388R6JwSpbyriJ8vhYwTSlQC0WUBNOR8GaxtnOCBXkwQoMjHXDCu0ZbVJIkY3EbaInoVBW3k0VfBG3hmiQ3L5bZqhYtnVi5HuqXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EVVWGDMH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Szd1k6J35ASlBha6qDCIcbBM34pxQ+1tlBnb0g8bakY=; b=EVVWGDMHntouYHloCKFTSu25qU
	hLiwXHyWtSPq4aS6Hmp5aUxbm4R7R/zC730IRBc+tZMghRepCk60nZRJF2VJHmiPQy0U/7W4ocxyk
	l8pUjKGok21IIOKXID0r4WffiNWPtA4rok3tt2oLwx3m+O2LFh4U1Xsg88EyudMLo5afiNoPG9CbX
	sILZSufHCo1UOuSS0HlLZ/f5kk9sUQQwP6Bg4Ge6V7+EVra9CA1TQT58jW7W0Z0sAewpVghPvn7t4
	gei9LJFhbncfTLcClsNHLTMe5rUC0woPmQDBiKsHZ0cTt+3IXeB4WnwjtWoxooWgsns1RAYbVQgAz
	J+AejQGg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmxNL-00000004Wkk-04sO;
	Wed, 20 Mar 2024 14:57:07 +0000
Date: Wed, 20 Mar 2024 14:57:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com, Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/11] mm/ksm: use folio in write_protect_page
Message-ID: <Zfr5QgvplFSury6o@casper.infradead.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
 <20240320074049.4130552-7-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320074049.4130552-7-alexs@kernel.org>

On Wed, Mar 20, 2024 at 03:40:42PM +0800, alexs@kernel.org wrote:
> -static int write_protect_page(struct vm_area_struct *vma, struct page *page,
> +static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
>  			      pte_t *orig_pte)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> -	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, 0);
> +	DEFINE_PAGE_VMA_WALK(pvmw, &folio->page, vma, 0, 0);

We have a DEFINE_FOLIO_VMA_WALK

> -	pvmw.address = page_address_in_vma(page, vma);
> +	pvmw.address = page_address_in_vma(&folio->page, vma);

We don't yet have a folio_address_in_vma().  This needs more study,
so I approve of how you've converted this line.

> -	BUG_ON(PageTransCompound(page));

I might make this a VM_BUG_ON(folio_test_large(folio))

> @@ -1505,7 +1503,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>  	 * ptes are necessarily already write-protected.  But in either
>  	 * case, we need to lock and check page_count is not raised.
>  	 */
> -	if (write_protect_page(vma, page, &orig_pte) == 0) {
> +	if (write_protect_page(vma, (struct folio *)page, &orig_pte) == 0) {

I don't love this cast.  I see why it's safe (called split_huge_page()
above), but I'd rather see a call to page_folio() just to keep things
tidy.

