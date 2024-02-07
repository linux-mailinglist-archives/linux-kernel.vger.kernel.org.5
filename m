Return-Path: <linux-kernel+bounces-56588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B894484CC36
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B6A2871B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090A07C08B;
	Wed,  7 Feb 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF4VTWox"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77EA7A713
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314384; cv=none; b=G27vQAo5UNAqhA4/ZD0IOXPMrQN3IJAQev4xRwzd+Ma1juk5k8nShT7bZPnF9GNkdY1LaTLiVzIcgl+umouDji/vbwMd/7K1QHhepTSuJQWLBDSruosfUrSqQfE7+zxLErm9ktOKeJWhT/r8akKDRi6ONQdzaQc8mTByCbuVBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314384; c=relaxed/simple;
	bh=bHfb+EwTJeKy7SvSI9eKeuIfA5z13z8rAU/c56oCrkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrJvdY2k5K6sm7k5V5fZac0vBfjmBRZMxRxoe5soJTZV7kQgD3pyHQemVfEGaODhpp3A9HLfKfqEpx8JMsfkxKTta5KMAsKaG48u8dGWKo/1MsYHI5H/CyCrunO5sJm5zStkyrpsoffziBK8Nd0rVAsFDWw2NLX+6+kxbQ3tiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SF4VTWox; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707314381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBR9it5N9UXG0CkxBIj40SLEEuG3r+6CTLKQmmsG/eg=;
	b=SF4VTWoxFO+H4a4p2UCU35VXK525zh7gQ/is+29vP7yTcqgpa5kMBuLQyNJH05qcnGgH8m
	jPcWsu7MXLJxsuz6NxSa5+18UBYVk6M8MzECsmCaXuZPzF/+B2kfOEFESnGLANkSm61HF4
	q0nmU84ilgVPthPsCPNTbJyb+QnbVtk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-RByV5KkYOLWzRUoPJvdsEw-1; Wed, 07 Feb 2024 08:59:36 -0500
X-MC-Unique: RByV5KkYOLWzRUoPJvdsEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD6B0101FA30;
	Wed,  7 Feb 2024 13:59:35 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 136F1C08EF7;
	Wed,  7 Feb 2024 13:59:35 +0000 (UTC)
Date: Wed, 7 Feb 2024 09:00:53 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] writeback: add a writeback iterator
Message-ID: <ZcONFXlqpi3nsbPb@bfoster>
References: <20240203071147.862076-1-hch@lst.de>
 <20240203071147.862076-13-hch@lst.de>
 <ZcD/4HNZt1zu2eZF@bfoster>
 <ZcJICXOyW7XbiEPp@bfoster>
 <20240207084224.o6nn4l7owwhzb5e3@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207084224.o6nn4l7owwhzb5e3@quack3>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Feb 07, 2024 at 09:42:24AM +0100, Jan Kara wrote:
> On Tue 06-02-24 09:54:01, Brian Foster wrote:
> > On Mon, Feb 05, 2024 at 10:33:52AM -0500, Brian Foster wrote:
> > > On Sat, Feb 03, 2024 at 08:11:46AM +0100, Christoph Hellwig wrote:
> > > > Refactor the code left in write_cache_pages into an iterator that the
> > > > file system can call to get the next folio for a writeback operation:
> > > > 
> > > > 	struct folio *folio = NULL;
> > > > 
> > > > 	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> > > > 		error = <do per-foli writeback>;
> > > > 	}
> > > > 
> > > > The twist here is that the error value is passed by reference, so that
> > > > the iterator can restore it when breaking out of the loop.
> > > > 
> > > > Handling of the magic AOP_WRITEPAGE_ACTIVATE value stays outside the
> > > > iterator and needs is just kept in the write_cache_pages legacy wrapper.
> > > > in preparation for eventually killing it off.
> > > > 
> > > > Heavily based on a for_each* based iterator from Matthew Wilcox.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  include/linux/writeback.h |   4 +
> > > >  mm/page-writeback.c       | 192 ++++++++++++++++++++++----------------
> > > >  2 files changed, 118 insertions(+), 78 deletions(-)
> > > > 
> > > ...
> > > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > > index 3abb053e70580e..5fe4cdb7dbd61a 100644
> > > > --- a/mm/page-writeback.c
> > > > +++ b/mm/page-writeback.c
> > > ...
> > > > @@ -2434,69 +2434,68 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
> > > >  }
> > > >  
> > > >  /**
> > > ...
> > > >   */
> > > > -int write_cache_pages(struct address_space *mapping,
> > > > -		      struct writeback_control *wbc, writepage_t writepage,
> > > > -		      void *data)
> > > > +struct folio *writeback_iter(struct address_space *mapping,
> > > > +		struct writeback_control *wbc, struct folio *folio, int *error)
> > > >  {
> > > ...
> > > > +	} else {
> > > >  		wbc->nr_to_write -= folio_nr_pages(folio);
> > > >  
> > > > -		if (error == AOP_WRITEPAGE_ACTIVATE) {
> > > > -			folio_unlock(folio);
> > > > -			error = 0;
> > > > -		}
> > > > +		WARN_ON_ONCE(*error > 0);
> > > 
> > > Why the warning on writeback error here? It looks like new behavior, but
> > > maybe I missed something. Otherwise the factoring LGTM.
> > 
> > Err, sorry.. I glossed over the > 0 check and read it as < 0.
> > Disregard, this seems reasonable to me as long as we no longer expect
> > those AOP returns (which I'm not really clear on either, but anyways..):
> > 
> > Reviewed-by: Brian Foster <bfoster@redhat.com>
> 
> So my understanding is that AOP_WRITEPAGE_ACTIVATE should be now handled
> directly by the caller of ->writepage hook and not by writeback_iter()
> which is the reason why the warning is here.
> 

Yeah, I wasn't really familiar with the AOP error codes, saw that
multiple existed and just assumed they might be arbitrarily relevant
across different aop callbacks (and so then filtered the check/clear for
WRITEPAGE_ACTIVATE out of my brain ;). On taking a closer look, it seems
like the only other one (AOP_TRUNCATED_PAGE) doesn't have any relevance
to ->writepage(), so this all makes more sense to me now. Thanks.

Brian

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 


