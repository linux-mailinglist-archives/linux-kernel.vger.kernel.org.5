Return-Path: <linux-kernel+bounces-63159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A486852BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1336284B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E61B7E6;
	Tue, 13 Feb 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ksqZQxr+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D381175AC;
	Tue, 13 Feb 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814452; cv=none; b=NCX/bkt+lnCtZDccwHB54RJ+lKvsvU8X2yDG+iAwz8+Wgb7Xo6j+sO4COfy71dG0F7VQqfqapwnB55LWdFOXbPuW6wR0+tQiQrCMsMMgmF+5t3owIJBUKQJYq7ZmkEdOqc0GZ7EQMTmKbv5c4A2tyr7UFRR2Pg7BgWurbZa0TY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814452; c=relaxed/simple;
	bh=yH5iJuFTV0xeh1KPzyvaw7lEQZTLFezfU6BQWvs75tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyS992iyUbgs/5afjzTHA0L/fzMG1x1UUBx6PhKBZGdKr45oFJlfNlzFdaw0Za4LrRLSyQXucIt0X84+c4zKubcexvSwCSIYRB4NKh/PINVqszutNQVXmQXWCHB7SslA5vZpTf8ljvzBc0yQzSXJkFJD5hvpubskG6wHzVmFMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ksqZQxr+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yGL5RRER78TPI6/TiT3IpzYTDrtbMwQINDuYFmVqcUA=; b=ksqZQxr+Ouc3OlY5xP98g9Wgyd
	BZWIl8ArFuzArbQXWvjoph8FqJbcYxuIGBeyeeP/D50cRmaHpURkm2QubuzDTd8KiXRYSljDFhLHN
	XDpSq0faHyyPbLudLg3JHaUHdozASMCJC2AU3+5MhDUpWV6VFlp38tJlC9vrDvrqrW/6VKqSXzRHG
	3jRYlNOOgB9Ddy+PDL1sSe99jgHJ+SYz41vc5tg5LyW1L6D3YNZgLwS4gfkUbFnK0pFJqFozHGPKT
	Z/n4ghaL0NWvUbaudjGBFKWfV4WEDPnuC1RmVRnDs2ee3zC+FQQzEo+bYaX7nirme5L8y0CgxKPC9
	Yy5c86lA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZoYG-0000000DIJX-19uR;
	Tue, 13 Feb 2024 08:54:04 +0000
Date: Tue, 13 Feb 2024 08:54:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, vbabka@suse.cz,
	dhowells@redhat.com, david@redhat.com, surenb@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	# see patch description <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Message-ID: <ZcsuLLhNPPylU-hi@casper.infradead.org>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>

On Tue, Feb 13, 2024 at 02:18:10PM +0530, Charan Teja Kalla wrote:
> An anon THP page is first added to swap cache before reclaiming it.
> Initially, each tail page contains the proper swap entry value(stored in
> ->private field) which is filled from add_to_swap_cache(). After
> migrating the THP page sitting on the swap cache, only the swap entry of
> the head page is filled(see folio_migrate_mapping()).
> 
> Now when this page is tried to split(one case is when this page is again
> migrated, see migrate_pages()->try_split_thp()), the tail pages
> ->private is not stored with proper swap entry values.  When this tail
> page is now try to be freed, as part of it delete_from_swap_cache() is
> called which operates on the wrong swap cache index and eventually
> replaces the wrong swap cache index with shadow/NULL value, frees the
> page.
> 
> This leads to the state with a swap cache containing the freed page.
> This issue can manifest in many forms and the most common thing observed
> is the rcu stall during the swapin (see mapping_get_entry()).
> 
> On the recent kernels, this issues is indirectly getting fixed with the
> series[1], to be specific[2].
> 
> When tried to back port this series, it is observed many merge
> conflicts and also seems dependent on many other changes. As backporting
> to LTS branches is not a trivial one, the similar change from [2] is
> picked as a fix.
> 
> [1] https://lore.kernel.org/all/20230821160849.531668-1-david@redhat.com/
> [2] https://lore.kernel.org/all/20230821160849.531668-5-david@redhat.com/

I am deeply confused by this commit message.

Are you saying there is a problem in current HEAD which this fixes, or
are you saying that this problem has already been fixed, and this patch
is for older kernels?

> Closes: https://lore.kernel.org/linux-mm/69cb784f-578d-ded1-cd9f-c6db04696336@quicinc.com/
> Fixes: 3417013e0d18 ("mm/migrate: Add folio_migrate_mapping()")
> Cc: <stable@vger.kernel.org> # see patch description, applicable to <=6.1
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5957794..cc5273f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2477,6 +2477,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  	if (!folio_test_swapcache(page_folio(head))) {
>  		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail);
>  		page_tail->private = 0;
> +	} else {
> +		set_page_private(page_tail, (unsigned long)head->private + tail);
>  	}
>  
>  	/* Page flags must be visible before we make the page non-compound. */
> -- 
> 2.7.4
> 

