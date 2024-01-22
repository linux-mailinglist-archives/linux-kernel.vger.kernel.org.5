Return-Path: <linux-kernel+bounces-33170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92A8365B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7E2B23AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772043D54E;
	Mon, 22 Jan 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="APxl7Ms3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C963D544
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934224; cv=none; b=ZHb9VMxEabbuFlmOyS2pQoVA8L5oNwsaUP0qC6VM9fllDwqzF3L6wPcat3ZQQwhb7I+jZckNDBR21ln6iCqMhdQsWlfvR7TFYanl13WXgLoHWm1oQWt0kl8rvMsHh6gwS10MkVBdbYfTKzsI381eITx+wIwzZHihFplePQZmWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934224; c=relaxed/simple;
	bh=26TXqE0I3suZk+nKGcDcgvoY9dpAQvnBxZiJe5xwpJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqQ+SXp2MjmCVmcHWiqxJyqotPNgB+T2gM0JVS1KFs1/rIKJ01FYM/UMTdVwRFpi5AY/QS56/9aptU+w7GPGEq21ergONM7iDvEGtUQMJM/F8mg1gwXbJmVkUKLcljVv1p+ladnEQCx/OsMIWI/TQ8Mns6Lu22nG4Qga2Flsgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=APxl7Ms3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=23mc1Gz7YM/7Y/77qDqmY1P4erCWeAQLAQ8g9ZunkZo=; b=APxl7Ms3TEQqeSxTaHu52iznIR
	8Yo+cRs6rHBF5rCsgp+cC2tI2n0z5TJEVdPZzTJOKuoi16mpnOx/cHLl8Xdi9kwcePbJKZ3KFp/nb
	yUK+lO97HfVh4eYHd7nEieGnwjdhArEyd0FGxVQT5+WeSeXXSpBqK/jUb6KNme/70GeM66z7H9qnf
	oe74OVggK4dO3LxDvnAB8zKcTqggDTk6tvzqo1HStX5QBXdbWdsMMmeiU1ltItX6sUhHiANWVnU3r
	Tjzxur7VteYEIv4SUzUxNs55pQ5+t/epsxSVNF74g9Xo1gAHkoKK0M7O9Zmp/xiKx7QKdAxTZnEl3
	+wAP4N5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRvPz-0000000092M-35Es;
	Mon, 22 Jan 2024 14:36:55 +0000
Date: Mon, 22 Jan 2024 14:36:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: naoya.horiguchi@nec.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: fix crash in split_huge_page_to_list
 from soft_offline_page
Message-ID: <Za59h0ORxsj3t3GW@casper.infradead.org>
References: <20240120065729.3276395-1-linmiaohe@huawei.com>
 <Zax60-Qu14QFuDod@casper.infradead.org>
 <aaff56ad-7bbe-8aa9-cd18-2ac9f4ea23f4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaff56ad-7bbe-8aa9-cd18-2ac9f4ea23f4@huawei.com>

On Mon, Jan 22, 2024 at 08:57:06PM +0800, Miaohe Lin wrote:
> On 2024/1/21 10:00, Matthew Wilcox wrote:
> > On Sat, Jan 20, 2024 at 02:57:29PM +0800, Miaohe Lin wrote:
> >>  {
> >> -	/* Soft offline could migrate non-LRU movable pages */
> >> -	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
> >> +	/*
> >> +	 * Soft offline could migrate non-LRU movable pages.
> >> +	 * Note that page->mapping is overloaded with slab->slab_list or slabs
> >> +	 * fields which might make slab pages appear like non-LRU movable pages.
> >> +	 * So __PageMovable() has to be done after PageSlab() is checked.
> >> +	 */
> >> +	if ((flags & MF_SOFT_OFFLINE) && !PageSlab(page) && __PageMovable(page))
> >>  		return true;
> >>  
> >>  	return PageLRU(page) || is_free_buddy_page(page);
> > 
> > I think would make more sense as
> > 
> > +	if (PageSlab(page))
> > +		return false;
> 
> Do you mean add PageSlab check above "if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))" block
> so we don't need to add more comment?

Yes, although not just that we don't need to add a comment.
Fundamentally, if you see PageSlab, you don't need to test anything
else, you know it's not migratable.

> I have a concern that __PageMovable() seems unreliable now if we access page from random context.
> This might introduce some potential problems. For example, offline_pages() might be stumped with
> such pages without any progress until signal occurs IIUC:
> 
>   offline_pages
>     ..
>     do {
>       scan_movable_pages
>         if (__PageMovable(page)) -- It might be slab page here. ret will also be set to 0.
>           goto found;
>       do_migrate_range -- Failed to isolate slab page and retry.
>     } while (!ret) -- retry since ret is 0.
> 
> There might be many similar scenes, but I haven't taken them more closely. Maybe these are
> just dumb problems...

Yep, lots of places are insufficiently careful about testing
PageMovable.  This will get fixed with memdescs, but we're a fair way
from having memdescs ...

