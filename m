Return-Path: <linux-kernel+bounces-165783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A38B9187
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3471F22E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A772E165FD6;
	Wed,  1 May 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUA60mfw"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DB1649A8;
	Wed,  1 May 2024 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601174; cv=none; b=BMju/YlitrRB4m6FKMByVfEUVlPnrdcDk91BDgeJ7weOHcUuZTZfxc8FilmLXfdBeUI8WheGveD3CgMP6bMevTit0TuSP1d9/feVvGat7J6KQ0eMf7/fphP36cftry4IC7iAMnab8lLHWUkDTHzdU9uMei2DK0qfKd9TQ24v+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601174; c=relaxed/simple;
	bh=h5/Bf9TDZQL4DKdeJo0EsruEaQY9edKPqbpWJiW44JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEIfz2kF9vMgNVc0q6T6TOuzrahJ/ok3fqi/hj9hWXq7eVvLMv0i6rsD7qMW5q+fBzBnzrPVhfNW6SVH4jfd3TfZakfDL7KwzQ9ZIWk+/6qlJcJIBzlS0rTWAgxrNzKToH+J4/al6NwXUTehCeEtmqDo5qAiHKipATqTY/QApnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PUA60mfw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sm0RzHylR5Zw9bOYvZFFoHhRX899/0BlSNXO6Xo2wxI=; b=PUA60mfwCcmYT5Y4hGx/5oenxS
	JcgVYk8xSO4t/Iktb2IEdf8FSfSP5/+Q8uDWlEt1sAyG7YWVLHmfAw2CXARVf6u4dktB7l1dL9npd
	pEg2ZZyTdDRg9wU+MDdQw7nB3mo5S7kbH2/ioilACesFLIop/JtDuSx0hWYimDbEKebt6gjNArEXR
	3rJ9rqMmv8QCYyFDivehLSsg1UU3vIwj2QhAU/j40xmLMfO96RwOHc20ZgmbR6YfPaZSVGWJ78LJE
	Fm9IS2M355V6DPt0w4Gyckjp+iGMaYPGbuCCee1w9RcQvl+S2jQHq4Dew4HKLYFQbiXZZMMl03QDM
	oa7yPR1Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2I5U-0000000Amjt-1n7n;
	Wed, 01 May 2024 22:06:04 +0000
Date: Wed, 1 May 2024 15:06:04 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, linux-mm@kvack.org,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy@infradead.org, hare@suse.de,
	john.g.garry@oracle.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH] mm/huge_memory: move writeback and truncation checks
 early
Message-ID: <ZjK8zDzIjN3xPR9n@bombadil.infradead.org>
References: <20240424225736.1501030-1-mcgrof@kernel.org>
 <37374089-895f-4c6f-a2f5-33859eb02b13@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37374089-895f-4c6f-a2f5-33859eb02b13@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Apr 25, 2024 at 11:40:48AM +0200, David Hildenbrand wrote:
> On 25.04.24 00:57, Luis Chamberlain wrote:
> > We should check as early as possible if we should bail due to writeback
> > or truncation. This will allow us to add further sanity checks earlier
> > as well.
> > 
> > This introduces no functional changes.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   mm/huge_memory.c | 23 +++++++++++------------
> >   1 file changed, 11 insertions(+), 12 deletions(-)
> > 
> > While working on min order support for LBS this came up as an improvement
> > as we can check for the min order early earlier, so this sets the stage
> > up for that.
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 86a8c7b3b8dc..32c701821e0d 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3055,8 +3055,17 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >   	if (new_order >= folio_order(folio))
> >   		return -EINVAL;
> > -	/* Cannot split anonymous THP to order-1 */
> > -	if (new_order == 1 && folio_test_anon(folio)) {
> > +	if (folio_test_writeback(folio))
> > +		return -EBUSY;
> > +
> 
> Why earlier than basic input parameter checks (new_order?
> 
> Sorry, but I don't see the reason for that change. It's all happening
> extremely early, what are we concerned about?
> 
> It's likely better to send that patch with the actual patch "to add further
> sanity checks earlier as well", and why they have to be that early.

It's a clear eye-sore when we add min order, I'll leave the eyesores for
others. It can wait.

  Luis

