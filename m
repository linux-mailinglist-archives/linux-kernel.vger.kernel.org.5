Return-Path: <linux-kernel+bounces-107861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD98802AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768B01F24E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E61171C;
	Tue, 19 Mar 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AK5+6/aU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE3101EB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866777; cv=none; b=hPVoswhBhHBevNgYUO4wxrz1YFuZyezqYS/hQauZjPgbbLgZ16XIDxOrJgA+jl+2p45FI6+ukO1YqyjkBtAqN9X41PA932yzSQ4Qksm3Z8xA+fj5zVzGSu2qW6jTW04oJ5Gd1Gla17Rj3TNGrROKHVzvF9Y7gXuZ/ZJE00nA9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866777; c=relaxed/simple;
	bh=jf8w8ii2uTlcW7NwOINkLfBd497lj8VqXhipSYtKB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb0cBZOWaJr0L7R4as/4XmcttOfR+HmB+zL876BFBuF2L4he/VVlOmoZvUHNNwzZss0hmI0qDCMsjgaU0h31WMjaPy1nGJ8LZHnemVRFuokWCg38RafFdHNDXfWYX9Lxg9qJkuBTlobsIOt+dShZp3F6lkFW3W6C3XB9B11bO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AK5+6/aU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e12kOj6qXl56fZI+rOW98a1AZQ8vEm9EskkUsKr5Dsw=; b=AK5+6/aUf96uh/P0XgVlqjfmLQ
	LlQM3DgfiHkzqjMXb38Boyk6/hx6ohO8/HV5wOpCaQfuiLYQMotglTvwjYZadWdS2AY1aGpj8n8/U
	9KBgJHZg+8Hbo9UGFQBnZYRf6yS5gFq0JD00ZLD3/vnmeA2yTvXnoxINmocShKUTncyBfJwqKQdsI
	WqU8hlEjzqWxAJdisrHyZMTckViM/Anz5mJN8JMWamSYwP7DA4av7lL5KyXa4gFwcT+vSzd7NesxZ
	VaH2DneHCowTqD5do57m9ji6qPFNFovlKrO5PJd6kov5gsHRWHwPvFiIFh2oKfdQcS+YECJTlqoeH
	Td5Shw3g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmcbG-00000002KpW-3m92;
	Tue, 19 Mar 2024 16:46:06 +0000
Date: Tue, 19 Mar 2024 16:46:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/filemap: return early if failed to allocate
 memory for split
Message-ID: <ZfnBTnXTIGck4lVR@casper.infradead.org>
References: <20240319092733.4501-1-ryncsn@gmail.com>
 <20240319092733.4501-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319092733.4501-2-ryncsn@gmail.com>

On Tue, Mar 19, 2024 at 05:27:30PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> xas_split_alloc could fail with NOMEM, and in such case, it should abort
> early instead of keep going and fail the xas_split below.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

The usual way of programming with an xa_state is to not do any error
handling; the xas_ functions check for error and become no-ops, so we
only have to check at the end.

I think this case is worth making an exception for because we avoid
acquiring/releasing the lock.  Not that we should be getting ENOMEM
very often; we only allocate about 8 nodes usually and we get 7
nodes/page.

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  mm/filemap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7437b2bd75c1..f07ea0b97698 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -880,9 +880,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
>  		void *entry, *old = NULL;
>  
> -		if (order > folio_order(folio))
> +		if (order > folio_order(folio)) {
>  			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
>  					order, gfp);
> +			if (xas_error(&xas))
> +				goto error;
> +		}
>  		xas_lock_irq(&xas);
>  		xas_for_each_conflict(&xas, entry) {
>  			old = entry;
> -- 
> 2.43.0
> 

