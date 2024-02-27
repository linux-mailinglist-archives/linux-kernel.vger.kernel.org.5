Return-Path: <linux-kernel+bounces-83502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB009869A52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49363282D82
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884AC145345;
	Tue, 27 Feb 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bnx2+Zze"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9E145333
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047640; cv=none; b=l6sBNKz7nsi50I8LNGOQyUro71OsOMaChZkp7BvoDuz3cdx6CM3eOlStcJ5Lhq+LcWtXMJq5oPMvQ/vbnV6bsMAyvIb3QRTETaku3zy14Yy22QbwRVVY69XuSq+Uv/1XwKncwKxB0jcdm4Ht9whOwqk2plz2cqL3Yj6WnfK6qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047640; c=relaxed/simple;
	bh=+91XHvtqCSwckwpW+bDkNlibO7BWY/dG0AEhx9p+xgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGu7OarGSvXGr1kyo3Bs8ge09PpJktd8yQUdjlU55CczU1aPQrtIL8zrefoycwkuYaSNEPb4ZMUpCODiBrsyUiiISS16NJSR5V2NyYScAjIQ3QEyeVHNF4JL+K88ueJScgmLj2tgZWZziRW7nauPsVVdPOjKDhjWH4nwAggo0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bnx2+Zze; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GaUbM6bqN08OMdLhbJnuxGOqey6Y7OVLpt4cMrcB0fU=; b=bnx2+ZzeZUZXwd+CL9uMuyRenA
	0YW9CXDzxwKtZAmYivJzi2dIfK3H6HWxhbtgXa22P7Ih3EXrWm6fqMy5xV5TwOn13L779uLEuokr7
	nFo1NLBPFbq7UQ+wPNvKrRGUEfE8y/ixEt9iauL96ctekuStaO8CyJLVWZa4/2xBjFVwm+oMuw01L
	7MfawEytTWr51W1fF/enq/CMGRPR0ZwohP+VBnOfHH0T3iBMt82CUl+DsrjGve8CiefoFfQe41Btf
	xbFMQDdIg/O8vK9AKQZlD4CSJDqQAaH42yuo2pr2598zWf4rtiVrU3nzBw/2MN920DOx6mBtnSGr+
	QwakEwBg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezMS-00000002iZA-2Ys0;
	Tue, 27 Feb 2024 15:27:16 +0000
Date: Tue, 27 Feb 2024 15:27:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] mm/memfd: refactor memfd_tag_pins() and
 memfd_wait_for_pins()
Message-ID: <Zd3_VEcoXaN9rAER@casper.infradead.org>
References: <20240226141324.278526-1-david@redhat.com>
 <20240226141324.278526-2-david@redhat.com>
 <Zdy3KRi3mnA2ZaDQ@casper.infradead.org>
 <02e4e497-d70f-4f4b-8b2c-55fe3a0b726e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e4e497-d70f-4f4b-8b2c-55fe3a0b726e@redhat.com>

On Mon, Feb 26, 2024 at 05:56:09PM +0100, David Hildenbrand wrote:
> > > @@ -95,20 +90,15 @@ static int memfd_wait_for_pins(struct address_space *mapping)
> > >   		xas_set(&xas, 0);
> > >   		xas_lock_irq(&xas);
> > > -		xas_for_each_marked(&xas, page, ULONG_MAX, MEMFD_TAG_PINNED) {
> > > +		xas_for_each_marked(&xas, folio, ULONG_MAX, MEMFD_TAG_PINNED) {
> > >   			bool clear = true;
> > > -			cache_count = 1;
> > > -			if (!xa_is_value(page) &&
> > > -			    PageTransHuge(page) && !PageHuge(page))
> > > -				cache_count = HPAGE_PMD_NR;
> > > -
> > > -			if (!xa_is_value(page) && cache_count !=
> > > -			    page_count(page) - total_mapcount(page)) {
> > > +			if (!xa_is_value(folio) &&
> > > +			    memfd_folio_has_extra_refs(folio)) {
> > 
> > ... so we don't need to test it here because we'll never see any value
> > entries.  No?
> 
> I was not able to convince myself that swapout code would clear the mark
> when replacing the entry.
> 
> shmem_writepage()->shmem_delete_from_page_cache()->shmem_replace_entry()
> 
> will perform a xas_store() with swp_to_radix_entry(swap) under
> xa_lock_irq().
> 
> Reading the doc, and staring at the code for a bit too long, I think
> xas_store() would only clear tags when deleting an entry (passing NULL).
> 
> But maybe xas_store() will always clear tags?

No, xas_store() will leave the tag alone ... this is the right thing to
do for the pagecache because we always clear the tags before removing
a folio from the cache.

> In memfd code, I think we could see swapout between memfd_tag_pins() and the
> check for tags, where we drop the xa_lock. Unless some other lock (inode
> lock?) protects us.

.. and if it does happen, we see the value entry tagged and clear the
tag on it.  OK.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

