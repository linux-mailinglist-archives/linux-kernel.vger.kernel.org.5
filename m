Return-Path: <linux-kernel+bounces-160595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71408B3FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788F01F221FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2B10942;
	Fri, 26 Apr 2024 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SalqeF2/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40555BE4E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158326; cv=none; b=GzozDhhiS8wgrBxuX+a7CdSOkeCA3uOCeeaE3Nt3uA6MZPEoQ5Vr35mZwpHMZ5MDIt1iGSwfWW9zgxCt3xJRnyYIScks6I3U7TOhdZcwJnzjVXHlsUYkiS2CIdYzLbqa9qSZtjNpWAB59BvaeCP0IRwwjjxfy27k7BlbOnkzgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158326; c=relaxed/simple;
	bh=splLkRiiHzPsaFd1425CF9fQqUGE4dwhc9c1R8aCo1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHqrxfFpED/3y+R2i+RwccNMqGj0u7R5NDey7FSSUxNkh4Y+q5fW+2hkgxIlh25CyWeBeuvGwT9WY73Loc7ACtDeDI4kZ5EuPwF3KY2kAZcM0zNdXpdEqmN44ElJv2rtFdvw4KpevJTifXnuSahfxbhtaKSEZwbNjwMS8otyPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SalqeF2/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J9hzjQzDOk6bgui0ZQTXguiwfYozRtBaHNSEEFobqG8=; b=SalqeF2/y6+XjXTwdw2qUijjlL
	YbazM9RYU7erDUktOkFEsLCooaBAJg0Xw3Ce+NJmWAFAGh2IL9trO0IXSCu5uWeMddLj+hMl6Tbqo
	9FivPMriPCjqktelGcq7wXyuhZY38ZPMtxRGN7wigGJOhBwCmDACZYieCW/bBDwXXSTLEaWoISCdL
	Es2sL4DEEAFtFq50FAwMAPQ+0pR20uTqA1uRY3Y4wFYAIzCbsB1zpw0ulIaivm3fozFr5GBcKC7U8
	qTj4E3+O57dIynIli2nRn7x5GPEBxaWKdmtYmuTE1/D0ffFtkQIW90Ei3Ji5s+/urNH2m81TOyjz5
	GDy67bpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Qsp-00000005pno-0JIt;
	Fri, 26 Apr 2024 19:05:19 +0000
Date: Fri, 26 Apr 2024 20:05:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, linmiaohe@huawei.com,
	jane.chu@oracle.com, nao.horiguchi@gmail.com, osalvador@suse.de
Subject: Re: [PATCH] mm/memory-failure: remove shake_page()
Message-ID: <Ziv67sGBi02YCYZ5@casper.infradead.org>
References: <20240426171511.122887-1-sidhartha.kumar@oracle.com>
 <ZivlrMAwRI6xJhc-@casper.infradead.org>
 <d05cbf22-f3e8-414a-a2e3-03e0b857eaca@oracle.com>
 <ZivyC3vqa2BIBoMj@casper.infradead.org>
 <c40cfd0b-f045-4887-a955-fee7e0392cf1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40cfd0b-f045-4887-a955-fee7e0392cf1@oracle.com>

On Fri, Apr 26, 2024 at 11:53:01AM -0700, Sidhartha Kumar wrote:
> On 4/26/24 11:27 AM, Matthew Wilcox wrote:
> > On Fri, Apr 26, 2024 at 10:57:31AM -0700, Sidhartha Kumar wrote:
> > > On 4/26/24 10:34 AM, Matthew Wilcox wrote:
> > > > On Fri, Apr 26, 2024 at 10:15:11AM -0700, Sidhartha Kumar wrote:
> > > > > Use a folio in get_any_page() to save 5 calls to compound head and
> > > > > convert the last user of shake_page() to shake_folio(). This allows us
> > > > > to remove the shake_page() definition.
> > > > 
> > > > So I didn't do this before because I wasn't convinced it was safe.
> > > > We don't have a refcount on the folio, so the page might no longer
> > > > be part of this folio by the time we get the refcount on the folio.
> > > > 
> > > > I'd really like to see some argumentation for why this is safe.
> > > 
> > > If I moved down the folio = page_folio() line to after we verify
> > > __get_hwpoison_page() has returned 1, which indicates the reference count
> > > was successfully incremented via foliO_try_get(), that means the folio
> > > conversion would happen after we have a refcount. In the case we don't call
> > > __get_hwpoison_page(), that means the MF_COUNT_INCREASED flag is set. This
> > > means the page has existing users so that path would be safe as well. So I
> > > think this is safe after moving page_folio() after __get_hwpoison_page().
> > 
> > See if you can find a hole in this chain of reasoning ...
> > 
> > memory_failure()
> >          p = pfn_to_online_page(pfn);
> >          res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
> > (not a hugetlb)
> >          if (TestSetPageHWPoison(p)) {
> > (not already poisoned)
> >          if (!(flags & MF_COUNT_INCREASED)) {
> >                  res = get_hwpoison_page(p, flags);
> > 
> > get_hwpoison_page()
> >                  ret = get_any_page(p, flags);
> > 
> > get_any_page()
> > 	folio = page_folio(page)
> 
> That would be unsafe, the safe way would be if we moved page_folio() after
> the call to __get_hw_poison() in get_any_page() and there would still be one
> remaining user of shake_page() that we can't convert. A safe version of this
> patch would result in a removal of one use of PageHuge() and two uses of
> put_page(), would that be worth submitting?
> 
> get_any_page()
> 	if(__get_hwpoison_page())
> 		folio = page_folio() /* folio_try_get() returned 1, safe */

I think we should convert __get_hwpoison_page() to return either the folio
or an ERR_PTR or NULL.  Also, I think we should delete the "cannot catch
tail" part and just loop in __get_hwpoison_page() until we do catch it.
See try_get_folio() in mm/gup.c for inspiration (although you can't use
it exactly because that code knows that the page is mapped into a page
table, so has a refcount).

But that's just an immediate assessment; you might find a reason that
doesn't work.

