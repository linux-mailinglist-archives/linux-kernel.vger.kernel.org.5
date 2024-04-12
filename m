Return-Path: <linux-kernel+bounces-141850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E7E8A243B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D241F23902
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B717BD4;
	Fri, 12 Apr 2024 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KtW9kNUd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE017BA3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891671; cv=none; b=MGZB1Wb9G0CiChHcjDIsmZIdVYdZNx/Eb+haVhs9W3EDZNHHllVZLBmGww9JztwV9wKVKg/mSUJECtkSQnCVn8EZLEJgg6h+6duVa38CGTNudWeyTcIcbpz9CUEbXO/M/w/j6VjwwR67r3hXgOuPTyereoWNsZSY/emVLICMny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891671; c=relaxed/simple;
	bh=rAQk+kKyo5+ykiCHa3D6Bcpj5Kr3HCi018yi7/XzLg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjVSj3pQkYcR05DL4dvOiXomJtMTZ9Y1Eg1JjSwDDKJcukyYvUxwtGk8Yp1Io0voFhXBEAGeFgYISqp8aME0+PI2qPLE0l4G9B4SXdhAj5F4vW3NH2Xkas6gkOUxMiBBYKrc9y2NVek9c22kFVd3r59j0VUKLQA/M0BBwNUrfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KtW9kNUd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wPr+h0K5F7dGg0tbz5/EPlcYvQeTFXmy0cKIv+ld4zo=; b=KtW9kNUd9SNwiVUFb1dvz18ngy
	fp5w3WqcTYHQz/YeqZZFLfRcnm9XUW+my2nnrFj7DcG4K/NW+A3s5cXEixFmtiEkApmN+he9l6lZC
	B4/y6LudZkZD5xlRxmfqdNIDoKDCLG7wLor4ZSa7ztXGrtjZIOs9pNP5CCkVrc04SatWQE8iqS5pM
	1Sm089TgDyL11WUQGrHTO6R2AtZYywaAoR2+hWycKdhj4n2a99Sc10i9e/Z3FW2cMDh6aeRD3X0E1
	k7SbyQupmNi8PXBjSm3EjEk8kZVj3lKHkz3bdugnqVZQV2bZmV9tz4OUFIhQu9VoMM5n81uY7d1vq
	dw1DlrKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv7Mn-00000008Hlx-03RU;
	Fri, 12 Apr 2024 03:14:17 +0000
Date: Fri, 12 Apr 2024 04:14:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhinCD-PoblxGFm0@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhhd-A7w1A8JUadM@casper.infradead.org>

On Thu, Apr 11, 2024 at 11:02:32PM +0100, Matthew Wilcox wrote:
> > How many instructions it takes for a late RETRY for WRITEs to private file
> > mappings, fallback to mmap_sem?
> 
> Doesn't matter.  That happens _once_ per VMA, and it's dwarfed by the
> cost of allocating and initialising the COWed page.  You're adding
> instructions to every single page fault.  I'm not happy that we had to
> add extra instructions to the fault path for single-threaded programs,
> but we at least had the justification that we were improving scalability
> on large systems.  Your excuse is "it makes the code cleaner".  And
> honestly, I don't think it even does that.

Suren, what would you think to this?

diff --git a/mm/memory.c b/mm/memory.c
index 6e2fe960473d..e495adcbe968 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5821,15 +5821,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
        if (!vma_start_read(vma))
                goto inval;

-       /*
-        * find_mergeable_anon_vma uses adjacent vmas which are not locked.
-        * This check must happen after vma_start_read(); otherwise, a
-        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
-        * from its anon_vma.
-        */
-       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
-               goto inval_end_read;
-
        /* Check since vm_start/vm_end might change before we lock the VMA */
        if (unlikely(address < vma->vm_start || address >= vma->vm_end))
                goto inval_end_read;

That takes a few insns out of the page fault path (good!) at the cost
of one extra trip around the fault handler for the first fault on an
anon vma.  It makes the file & anon paths more similar to each other
(good!)

We'd need some data to be sure it's really a win, but less code is
always good.

We could even eagerly initialise vma->anon_vma for anon vmas.  I don't
know why we don't do that.

