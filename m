Return-Path: <linux-kernel+bounces-131884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716E898D24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B8C1C24828
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A712D74D;
	Thu,  4 Apr 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HAhC2m7Z"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9D14A8B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251315; cv=none; b=nyPdSwJTXYuLN2oUrnqKzsa9kjbURyAxRKcI9dzEYBTBbVtf7ucXSoY3VRwmisWo5lvkcfCXHCLC0TdJ022i1b1EOq0RoWpbcq5nghE5tivL2SULLjTML6WGjNhP98iMnH+YsIdnbBMzAKmBKGovAIQnBp0AV0fxy3Pylpzb1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251315; c=relaxed/simple;
	bh=I/Y7BkE/ovvkHXAQwnA3lR9TA6Ahb13PwB8H9hTUXKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPnHwZFnLDotz3UsdcK33M8oMzhtZwnqGtQGNB8cmk5Q8ylpODIDtB0QvUiii1tImjGu9JujGtsKWGfwYGTWXlDN9Nviwq7VVPAIJJ0/9YY6LZQLE429XXYL2oq+lwZbhpu1DPPzFAzVUsmwndFQO38B56hcr2BmD/QWKlTzkwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HAhC2m7Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2AAEG8ys83OU4EuRCbJQyodfMWerUNVMHCfTJ2nvxPU=; b=HAhC2m7ZVzD6zPrXiQJLgjLHaW
	AO3AVTmlWvFBXCD1yKqq7bWONdClkxDKKJ3ou7VzLfGQ/SMxwkrdwQqdaZQAlCW1NbH0geh5Jid2q
	9AAaaRG/qZaJvCcgYoNWMcAgIXza61/yE3cZ/QBg0Wxsvzg5hrrq9waG574EojwJgRNGAp6yrHLrA
	xwXaqqkcWFNBIABKNY7wzOXtPho8VvFFLo+wkpM8JbBkVGaPIbBs298IlNWBXmC5qoNiLkBaeE8c7
	+1o3MRkpK6xiKTBkPvFLTjVOE9SGQhc2JGcEPImDkJFyBRKoLIgobIMBAGJ4QbwPF321JJtG1x7/J
	HhzVRtHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQmc-00000008WpL-1PQc;
	Thu, 04 Apr 2024 17:21:50 +0000
Date: Thu, 4 Apr 2024 18:21:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, surenb@google.com,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, zhengqi.arch@bytedance.com,
	kaleshsingh@google.com, ngeoffray@google.com
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
Message-ID: <Zg7hrt5HudXLBUn_@casper.infradead.org>
References: <20240404171726.2302435-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404171726.2302435-1-lokeshgidra@google.com>

On Thu, Apr 04, 2024 at 10:17:26AM -0700, Lokesh Gidra wrote:
> -		folio_move_anon_rmap(src_folio, dst_vma);
> -		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> -
>  		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
>  		/* Folio got pinned from under us. Put it back and fail the move. */
>  		if (folio_maybe_dma_pinned(src_folio)) {
> @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
>  			goto unlock_ptls;
>  		}
>  
> +		folio_move_anon_rmap(src_folio, dst_vma);
> +		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +

This use of WRITE_ONCE scares me.  We hold the folio locked.  Why do
we need to use WRITE_ONCE?  Who's looking at folio->index without
holding the folio lock?

