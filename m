Return-Path: <linux-kernel+bounces-135787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02C89CB43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA2F1F22541
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0B1442F1;
	Mon,  8 Apr 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VU9qvBGB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914031E489
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598939; cv=none; b=I2s4srn2YMj1UdOLPo0L27OF1B2T5Y+yRLrWy2PK+Epv5As+/Ooz/qAvSFPwUJbvW3+6qYJEHpsIaIs6wtogt7pD7LHAkU0s3QZ8ZscqKQgFsk07L2OpF3MgEQKgqINPcbPmjCj974gKpHY31HWCHsuVBfGr5Cz+LhfHUMIqunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598939; c=relaxed/simple;
	bh=qniWEKwNE35bzfapSfWb242LZ3enrNguNfhPcNyKSlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbYXT81UFrTIb4brLCEFXwpoGEEQCbtI2HD52cogeV47nmp7eg/te8NY6hLxv0vQ1dr1V/fc5fgzZax7CarhKIodjtR6Q1CpWQjVFmKywK3nQPlPud8nW9KMJd51uxEWo2cqWx56qmGEQ0mpUvfUcHefZMbGVH15rVFwaLHMPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VU9qvBGB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vprri69ntE5tXl2ejHYWa++Fhx4661tQjtCllU5TZfM=; b=VU9qvBGBmxEoWgYzjI8zdCVZ/6
	SvoD7Tq9v8jBXn+Wjn1JYHI/t6YLeXlfa2sDpK7JF9a6C66vG7M/Irt+HBmihjAKAcKbuIit21MUF
	rzsqWVD4B5ABo3JISbVk0vo/VUzuqhJwK6PSgarQMfwOaMmNGyi80sPG9R8tFQNfhM7y8BydZvGvS
	PvJ9QBUv2LK4kS/9COxpsn+IB8YH/5fUd5is5JJ+xc3IRme7C9yVtNlgv9hZvzS01yL6N6eHGeNYA
	3J+yYo5Ud9v+mhXcOUglBFzw963SKO5VBTVk2jAoEn83BFrZt2l+bn7nAEJCwI6Gr/FwHfRE1l12J
	zRT3JBAA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rttDS-00000000Kgm-3C1L;
	Mon, 08 Apr 2024 17:55:34 +0000
Date: Mon, 8 Apr 2024 18:55:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] hugetlb: Convert hugetlb_wp() to use struct
 vm_fault
Message-ID: <ZhQvlpOETGxXO_MG@casper.infradead.org>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-4-vishal.moola@gmail.com>
 <7d001108-157d-4139-bfa9-5b4102166f17@linux.dev>
 <ZhQtoFNZBNwBCeXn@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQtoFNZBNwBCeXn@fedora>

On Mon, Apr 08, 2024 at 10:47:12AM -0700, Vishal Moola wrote:
> -static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
> -		       struct folio *pagecache_folio,
> +static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  		       struct vm_fault *vmf)
>  {
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct mm_struct *mm = vma->vm_mm;

I think 'vmf' should be the first parameter, not the second.
Compare:

static vm_fault_t do_page_mkwrite(struct vm_fault *vmf, struct folio *folio)
static inline void wp_page_reuse(struct vm_fault *vmf, struct folio *folio)
static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf, struct folio *folio)
static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
void set_pte_range(struct vm_fault *vmf, struct folio *folio,
                struct page *page, unsigned int nr, unsigned long addr)
int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
                      unsigned long addr, int page_nid, int *flags)
static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
                                        unsigned long fault_addr, pte_t *fault_pte,
                                        bool writable)
static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
                                       struct folio *folio, pte_t fault_pte,
                                       bool ignore_writable, bool pte_write_upgrade)
static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)

numa_migrate_prep() is the only one which doesn't have vmf as the first
param.  It's a subtle inconsistency, but one you notice after a while
.. then wish you'd done right the first time, but can't quite bring
yourself to submit a patch to fix ;-)

