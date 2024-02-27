Return-Path: <linux-kernel+bounces-83560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41EC869B91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD18B2FC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140221474B1;
	Tue, 27 Feb 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KqpHDucB"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FEE535AE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049621; cv=none; b=NPFxqP3GAi/s3awH06rsCCeUsCe46VStnPuBzBw/1FbqT5bmjXnwTczLRdKtQYQTAVNEcxlk9tXvHo27lbAxeTaKWiMn11tqubgMRG23YGV6Ba1rWh+AisZk3IhHxA6ksGmLDq1uNSjP+r8wfnmfopmqPue8AGK6OByrWs9jd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049621; c=relaxed/simple;
	bh=/ZcKHB3se7dZ04rBs98kiLqPFcRbaht4NCHpVlNlawI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUgk5Jf4yAStEu0UMDHI2b4cfSfq/ufWG8m9R9i5t0Lg1NAqI+6QHLhqTA3pPok5e5QCIUMrXeH/M3ulWbHXg/oSWlB9P8+mlQIO32Rg83jQf/PxN+Elz5fUlG6e8rXTKUN+279TonUHVWp4PPh5Ywjr5yLcHWxxuFqjJBPDLg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KqpHDucB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CuJB5bRBJbOy4In+KKiCZi5akTRyl9NVfEAfw816xy4=; b=KqpHDucBRg5Iv9IKONlQDUmmIM
	NTRyFQtftMfeOC0U1oENORYEroE+VVuyz/8hcWrZl4Bx0JyDioMkktPp3WzKojAvOv9335Wo772Bz
	uefvIc6c0w/grkBdW+Z03XO9A4ZguEhzaM7MLmY6PgcDv/UmTwl5UWywzVMTJ7qM79ZjUfRxUON63
	5tpxRgb81hq1YYpXiAIaz9Qss0A0oPFyd9b7+U3vcyKFdrOitsYeDX9wOMlgeqwgXmgwc+dFVMARW
	yzmPSUW2rC1VYqoU77sSzHjJT/2+juunQbH1ojNBFtTXXmQxMdKC3Q3Gt9JVWNf3994BuHcyhIMkr
	3wXQm3rQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezsQ-00000005tJI-0eyv;
	Tue, 27 Feb 2024 16:00:18 +0000
Date: Tue, 27 Feb 2024 08:00:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Yin Fengwei <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
Message-ID: <Zd4HEjS6vpIvwfR9@infradead.org>
References: <20240227024050.244567-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227024050.244567-1-21cnbao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 27, 2024 at 03:40:50PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> madvise and some others might need folio_pte_batch to check if a range
> of PTEs are completely mapped to a large folio with contiguous physcial
> addresses. Let's export it for others to use.

It doesn't look exported to me in the patch (and that's a good thing!).

But even for making it non-static you probably want to include that in
the series actually making use of it.

> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> +		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> +		bool *any_writable);

no need for the extern here.

