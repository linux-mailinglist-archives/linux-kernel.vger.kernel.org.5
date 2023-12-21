Return-Path: <linux-kernel+bounces-7727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A081AC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA84F1F244B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940F8F54;
	Thu, 21 Dec 2023 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oZZWve4Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B968BED;
	Thu, 21 Dec 2023 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3ZMr2K4ZM51kzwTGCrD3Nr7SGwnJ6/0epE07/0Ggvfg=; b=oZZWve4YRYVIqgNSLe8LOCViXd
	LRUyk7GzurgZpMFQCKdRfagaixj+u7M26bruOAm4G/J0SkBeeGoWJOtXGX8rAb+5brB//aAH6vCRw
	IsimSTvhNHCfbcOHa5PlIaIwkZFvtgmcMUJeQieBBMIopqjQq5R0MUuMSLs8iIUZ4bcFs0HoYVqIv
	689KyaBlMn9O0CvdEkh2+wPgc7kgnQPmY/99rLkRKDJMI6XxYJU70cbpN6QN71nIrueJz91ApuXCS
	YovE/QwxJbQlvimp2u08ngohjnUUu7V5mbGi5Nal2UK6EnLVGhdOKEl6vP9vmRFpWDK5dHMz+ZLCw
	EYXAG8TQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rG7vZ-004XUJ-14; Thu, 21 Dec 2023 01:32:45 +0000
Date: Thu, 21 Dec 2023 01:32:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <ZYOVvKJW4F/NZvUz@casper.infradead.org>
References: <20231221111847.689ea41f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221111847.689ea41f@canb.auug.org.au>

On Thu, Dec 21, 2023 at 11:18:47AM +1100, Stephen Rothwell wrote:
> I have applied the following merge resolution patch:

The merge resolution is correct ...

> +++ b/fs/netfs/buffered_write.c
> @@ -566,7 +566,7 @@ static void netfs_kill_pages(struct address_space *mapping,
>  			folio_end_fscache(folio);
>  		folio_end_writeback(folio);
>  		folio_lock(folio);
> -		generic_error_remove_page(mapping, folio_page(folio, 0));

but what Dave wrote here is _not_.

Call folio_page() when you need to go back from folio to page for
something that is intrinsically page based, like kmap().  This isn't
that case.  This is an interface that hadn't been converted yet, and
specifying &folio->page is the correct way to handle this because it's
an indication that there is work here to do before we can call the folio
conversion complete.

Please be more careful.

