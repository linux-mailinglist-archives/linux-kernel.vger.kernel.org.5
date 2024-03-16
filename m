Return-Path: <linux-kernel+bounces-105206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFA87DA81
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CA4281EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F81B299;
	Sat, 16 Mar 2024 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ggrXv090"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530917BAF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710601177; cv=none; b=ZvqMDCrVDAEubOyl8/0hdGQ7AZJ//oxpl3AiGN8ltlROwruombgGLAB4RNfHckcxyvcAdkMSrtv7X1i+FT6NmN9oM/Gm53CaAGc0Aau/PQ832ed5mon79fUEgaAmiSjeeD0RUM9BMmSJRIFZaYf70KCFSrEUmxKZkEHivv2yTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710601177; c=relaxed/simple;
	bh=DKs5vf95fwSrcVB7tav+pGIufXiuij6EFgK8cxV0ums=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XACqNaAuOcRlq1lAHaTCc6Kr4DLzgWLTB9Y4p2sPm/OhCUq38mDpamQ3WtbVEneyOZabk7zWqPZ6f0jYqV4fg4VXGlIA5yA8fRSo1a1plGalgRSFc1L2iTnGPPmpeFKGhidx3XvUMASpTpzVcBxUeTHFJfVHijaf8OQIAfrD3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ggrXv090; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=iKLiE9BwjTzP4t6SGnAORjeXAHz+HjoyGfvPRPIakTw=; b=ggrXv090/BWmzassxYCgEqKIZ8
	ryZZsHN7L9tmEIqXwbeJMsqrCqH53fdw4cC56qJNZoauy00szde4QM/9nxhrMC1hMvYDRu+w19JeH
	CuZxTAtrnsxCjobbmFBorfB/WQqbQrHivi/iHmLpuqKv3nZPwmuLzUQy3jUGFYD6vh8oREWn13rB3
	GjlS/+qsqivToYGqXOnxFBgaRR9ZpMS1bWGPpVpY1ZewKBqJDbDDWiMEl9qQmnUi7TSgPQDsDN/jB
	cE1LJyHJUreYH1Myfq4aZceqrXufrQ/r5M2QmqZu3XqOd2TsG4Q4ZGYuZmxLwSL2BKl3ypQcRp2Ss
	20tZ4tcA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlVVE-0000000CiuI-1XfW;
	Sat, 16 Mar 2024 14:59:16 +0000
Date: Sat, 16 Mar 2024 14:59:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCH] mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZfWzxOq7JupJtZtg@casper.infradead.org>
References: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com>
 <ZfRDJTrFJq3KSbIB@casper.infradead.org>
 <CAGWkznGiVrqMs9fX2WGG9QsfTm72ffFj-cWXSUo3azrgeBOgAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznGiVrqMs9fX2WGG9QsfTm72ffFj-cWXSUo3azrgeBOgAg@mail.gmail.com>

On Sat, Mar 16, 2024 at 04:53:09PM +0800, Zhaoyang Huang wrote:
> On Fri, Mar 15, 2024 at 8:46 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Mar 14, 2024 at 04:39:21PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Panic[1] reported which is caused by lruvec->list break. Fix the race
> > > between folio_isolate_lru and release_pages.
> > >
> > > race condition:
> > > release_pages could meet a non-refered folio which escaped from being
> > > deleted from LRU but add to another list_head
> >
> > I don't think the bug is in folio_isolate_lru() but rather in its
> > caller.
> >
> >  * Context:
> >  *
> >  * (1) Must be called with an elevated refcount on the folio. This is a
> >  *     fundamental difference from isolate_lru_folios() (which is called
> >  *     without a stable reference).
> >
> > So when release_pages() runs, it must not see a refcount decremented to
> > zero, because the caller of folio_isolate_lru() is supposed to hold one.
> >
> > Your stack trace is for the thread which is calling release_pages(), not
> > the one calling folio_isolate_lru(), so I can't help you debug further.
> Thanks for the comments.  According to my understanding,
> folio_put_testzero does the decrement before test which makes it
> possible to have release_pages see refcnt equal zero and proceed
> further(folio_get in folio_isolate_lru has not run yet).

No, that's not possible.

In the scenario below, at entry to folio_isolate_lru(), the folio has
refcount 2.  It has one refcount from thread 0 (because it must own one
before calling folio_isolate_lru()) and it has one refcount from thread 1
(because it's about to call release_pages()).  If release_pages() were
not running, the folio would have refcount 3 when folio_isolate_lru()
returned.

>    #0 folio_isolate_lru          #1 release_pages
> BUG_ON(!folio_refcnt)
>                                          if (folio_put_testzero())
>    folio_get(folio)
>    if (folio_test_clear_lru())

