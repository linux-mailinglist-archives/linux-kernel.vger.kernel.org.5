Return-Path: <linux-kernel+bounces-83590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E9869BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209DA1F2282D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AA14830B;
	Tue, 27 Feb 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bwO859o9"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2943148300
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050954; cv=none; b=i0GqLiWcHE1f5gNmuK90czqS95+ARFn20rFhmF2eGD4ooSRy0krKOZE++glvNIF1tlqbBHGRxufFRTYKASmshtsw9Y61MUU9IVL0kyK35VVtNuaC7tFV4t7eed5v1mMbdNoKlWDWUJaDtjspPXxAf1O5TVgA8FyM+ug0UR7mESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050954; c=relaxed/simple;
	bh=mpaHnrQXVxhzTPAmuA5VRi7J9LYcCMPR3gS0wa9laMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwAW4H/NazNbg9pjpqOQu+my0VZVejuZki6ofVSVhIp0kbqKAugHMdlSM8GvuZhRG+fsMtVOBtULVP2/3TROaNBp8zKSwi3SRqg3waaT63V272DnMnMsM04jFltcTSc3/1/Q9Q2bJ0l3bPBsQb824tFFJpAyBLuyfNVcWInI6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bwO859o9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 11:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709050950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpwdoTPDbBoPf3QYWjOhHZc19Xb5Er/Lboo1nmZhqcA=;
	b=bwO859o9nXk2p9RatAo3p5C1/sszAl7urqmVyqYIj76c/O++eLQ2fFVcxbPxk+/xgYiBF1
	d/ZtnwEjP6Tl3Ey6WYdXoJAHfQ682oQonvYCCwO5IXX8NTU2/eiI2L2EhFkFB+aWXpZbUi
	pNflFYXlz5yMYfcD+4N3ENtkARdq5p4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, david@fromorbit.com, 
	chandan.babu@oracle.com, akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, 
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 03/13] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <hjrsbb34ghop4qbb6owmg3wqkxu4l42yrekshwfleeqattscqp@z2epeibc67lt>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-4-kernel@pankajraghav.com>
 <Zdyi6lFDAHXi8GPz@casper.infradead.org>
 <37kubwweih4zwvxzvjbhnhxunrafawdqaqggzcw6xayd6vtrfl@dllnk6n53akf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37kubwweih4zwvxzvjbhnhxunrafawdqaqggzcw6xayd6vtrfl@dllnk6n53akf>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 11:06:37AM +0100, Pankaj Raghav (Samsung) wrote:
> On Mon, Feb 26, 2024 at 02:40:42PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 26, 2024 at 10:49:26AM +0100, Pankaj Raghav (Samsung) wrote:
> > > From: Luis Chamberlain <mcgrof@kernel.org>
> > > 
> > > Supporting mapping_min_order implies that we guarantee each folio in the
> > > page cache has at least an order of mapping_min_order. So when adding new
> > > folios to the page cache we must ensure the index used is aligned to the
> > > mapping_min_order as the page cache requires the index to be aligned to
> > > the order of the folio.
> > 
> > This seems like a remarkably complicated way of achieving:
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 5603ced05fb7..36105dad4440 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2427,9 +2427,11 @@ static int filemap_update_page(struct kiocb *iocb,
> >  }
> >  
> >  static int filemap_create_folio(struct file *file,
> > -		struct address_space *mapping, pgoff_t index,
> > +		struct address_space *mapping, loff_t pos,
> >  		struct folio_batch *fbatch)
> >  {
> > +	pgoff_t index;
> > +	unsigned int min_order;
> >  	struct folio *folio;
> >  	int error;
> >  
> > @@ -2451,6 +2453,8 @@ static int filemap_create_folio(struct file *file,
> >  	 * well to keep locking rules simple.
> >  	 */
> >  	filemap_invalidate_lock_shared(mapping);
> > +	min_order = mapping_min_folio_order(mapping);
> > +	index = (pos >> (min_order + PAGE_SHIFT)) << min_order;
> 
> That is some cool mathfu. I will add a comment here as it might not be
> that obvious to some people (i.e me).

you guys are both wrong, just use rounddown()

