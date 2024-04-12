Return-Path: <linux-kernel+bounces-142635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192468A2E17
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1E41C21504
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BEF55E7B;
	Fri, 12 Apr 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQ0Mzhee"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFA5028B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924285; cv=none; b=o5CZfrfOLKzpAZ9qPOhZcu+esX1h9abSK/pkkE3y0aS5SiSjtb5RiSTwHHJTODnBbZx/slvtcJvgDoDxFgBz5P0wYVCZPAIpSqOgWhgO52HpPJpzwu8DesjcJFTZDinbo9Nbe7KPHK018wKiDPkOW9PE5T4b4Ck9ER8Fh6sqncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924285; c=relaxed/simple;
	bh=7BxRefvjJRrPvYcOpk7/kHwta1DM0oIs0imjlic/h7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWLTgZDPhcfFv3BiluBebrv39gqoDA3nDZbk1NQwnVQ41GJ5vQlDFGvhewQPpSoGjmSyNdJJFaHHugh/Z/hZoGIj9Fsa3N1uuDcuprHdKRN9ZUpH+0MjVo7Q/UJFykAmSbiZ8D3Hrij14wbuUFpig3qBgh44QzpObaAFl7nSbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eQ0Mzhee; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZqXAj2wZ5R12P6C44OmA4h+tQYrqOIgYJQ2uEwiP/bU=; b=eQ0MzheeDDB9sQAcZLhIIMqr2R
	l2XwhdMHgjEfH5Q27nNvzsvoNVfAQbAE/HVPgUtZLiE/SM5PPTyDueqc4le2zXC1nyNpl0BMSqRJU
	X9Y34ws5wcNzqaLfBiOgm8hOWk3NKqy+NDDUEbvQAKVXo9sAEfe65KtF8OPn5LSp+PfYZqp5MGa3A
	1DxNqamcf9bUc7KdQ09bJl7cJtSwY/WqzT3mqP516mjfXroKaxAj0odl7U7/QxP11uSeI6rXlJG1q
	5v9sLxbyz16ZUZS9O6kVBeaV2V52m22t5Rqq7zbVx9ugx3tYwHXe/58PDHi+9jvpC3WG1CHKwwher
	iQ1Tz1Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvFqq-000000097Gs-0rGV;
	Fri, 12 Apr 2024 12:17:52 +0000
Date: Fri, 12 Apr 2024 13:17:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>,
	Haifeng Xu <haifeng.xu@shopee.com>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Clear __GFP_COMP flag when allocating 0 order page
Message-ID: <ZhkmcNwOKktO3pxT@casper.infradead.org>
References: <20240411091832.608280-1-haifeng.xu@shopee.com>
 <5482360c-0a0b-e5f5-b88e-4a6ec4d43f7d@linux.com>
 <5d3c4a5e-0c27-4058-adf1-91e9602e5ccb@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d3c4a5e-0c27-4058-adf1-91e9602e5ccb@suse.cz>

On Fri, Apr 12, 2024 at 10:01:29AM +0200, Vlastimil Babka wrote:
> On 4/11/24 6:51 PM, Christoph Lameter (Ampere) wrote:
> > On Thu, 11 Apr 2024, Haifeng Xu wrote:
> > 
> >> @@ -1875,6 +1875,13 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
> >> 	struct slab *slab;
> >> 	unsigned int order = oo_order(oo);
> >>
> >> +	/*
> >> +	 * If fallback to the minimum order allocation and the order is 0,
> >> +	 * clear the __GFP_COMP flag.
> >> +	 */
> >> +	if (order == 0)
> >> +		flags = flags & ~__GFP_COMP;
> > 
> > 
> > This would be better placed in allocate_slab() when the need for a
> > fallback to a lower order is detected after the first call to alloc_slab_page().
> 
> Yeah. Although I don't really see the harm of __GFP_COMP with order-0 in the
> first place, if the only issue is that the error output might be confusing.
> I'd also hope we should eventually get rid of those odd non-__GFP_COMP
> high-order allocations and then can remove the flag.

The patch seems pointless to me.  I wouldn't clear the flag.  If
somebody finds it confusing, that's really just their expectations being
wrong.  folio_alloc() sets __GFP_COMP on all allocations, whether or not
they're order 0.

