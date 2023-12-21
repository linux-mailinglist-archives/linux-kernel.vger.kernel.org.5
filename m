Return-Path: <linux-kernel+bounces-8550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED181B946
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF931C25DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E9539F2;
	Thu, 21 Dec 2023 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bZIVVC7v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D2539FC;
	Thu, 21 Dec 2023 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=INzY/QT6atUS/BlSFmLSlk6lzsjHKIwMNfkkrynBCJg=; b=bZIVVC7v1vf6vYj48TvYaHjrbx
	ZkZZ4WD32xzOnBaOLhtDpgrIhFWUsaTT+yYhwGdrhniEN0EBV1TB7+PbMDUOHOMNic+6wQFxBcXbA
	b454QACHPdfjB3wJs48q6ftA3V/eZjqFsttl3DR2LpYWuXc74Ys9/HZrf3D0xobLYZFvNTW23us3E
	apA2mPckdE+KDqQ1tKauphuRa405ibsf3zpCcXJJE9qbeF2Sk93zQ3r/c7S4qUye6v/njyrrtUPXy
	YKdv9lfurmjPV7exUYRdt5CuB1PeAbpWLyaubFkGLtdeRf1NjiyiyKzPPUrvSrKDoGQM1NikCz/WU
	ldEZXVCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGJgY-005NPh-Fm; Thu, 21 Dec 2023 14:06:02 +0000
Date: Thu, 21 Dec 2023 14:06:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rientjes@google.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
Message-ID: <ZYRGSv0OzJknmVPY@casper.infradead.org>
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
 <ZYO8IqiHeqs8LktJ@casper.infradead.org>
 <CA+CK2bBJuZPF5yC2Axo0S_P4ApjwgBWu9YwnDo+yOiOiL16Bhg@mail.gmail.com>
 <CA+CK2bAHLpRWJfHCAPzAjSzF8Hue1wK_SW5GxSue9rOW6OtT5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAHLpRWJfHCAPzAjSzF8Hue1wK_SW5GxSue9rOW6OtT5Q@mail.gmail.com>

On Thu, Dec 21, 2023 at 12:42:41AM -0500, Pasha Tatashin wrote:
> On Thu, Dec 21, 2023 at 12:13 AM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Wed, Dec 20, 2023 at 11:16 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 03:19:12AM +0000, Pasha Tatashin wrote:
> > > > This series frees empty page tables on unmaps. It intends to be a
> > > > low overhead feature.
> > > >
> > > > The read-writer lock is used to synchronize page table, but most of
> > > > time the lock is held is reader. It is held as a writer for short
> > > > period of time when unmapping a page that is bigger than the current
> > > > iova request. For all other cases this lock is read-only.
> > > >
> > > > page->refcount is used in order to track number of entries at each page
> > > > table.
> > >
> > > Have I not put enough DANGER signs up around the page refcount?
> > >
> > >  * If you want to use the refcount field, it must be used in such a way
> > >  * that other CPUs temporarily incrementing and then decrementing the
> > >  * refcount does not cause problems.  On receiving the page from
> > >  * alloc_pages(), the refcount will be positive.
> > >
> > > You can't use refcount for your purpose, and honestly I'm shocked you
> > > haven't seen any of your WARNings trigger.
> >
> > Hi Matthew,
> >
> > Thank you for looking at this.
> >
> > Could you please explain exactly why refcount can't be used like this?
> >
> > After alloc_page() refcount is set to 1, we never reduce it to 0,
> > every new entry in a page table adds 1, so we get up-to 513, that is
> > why I added warn like this: WARN_ON_ONCE(rc > 513 || rc < 2); to
> 
> I guess, what you mean is that other CPUs could temporarily
> increase/decrease refcount outside of IOMMU management, do you have an
> example of why that would happen? I could remove the above warning,
> and in the worst case we would miss an opportunity to free a page
> table during unmap, not a big deal, it can be freed during another
> map/unmap event. Still better than today, where we never free them
> during unmaps.

Both GUP-fast and the page cache will find a page under RCU protection,
inc it's refcount if not zero, check the page is still the one they were
looking for, and if not will dec the refcount again.  That means if a
page has been in the page cache or process page tables and you can't
guarantee that all CPUs have been through the requisite grace periods,
you might see the refcount increased.

I'm not prepared to make a guarantee that these are the only circumstances
under which you'll see a temporarily higher refcount than you expect.
Either currently or in the future.  If you use the refcount as anything
other than a refcount, you're living dangerously.  And if you think that
you'll be the one to do the last refcount put, you're not necessarily
correct (see the saga around __free_pages() which ended up as commit
e320d3012d25 fixed by 462a8e08e0e6 (which indicates the rare race does
actually happen)).

Now, it seems like from your further explanation that the consequence
of getting this wrong is simply that you fail to free the page early.
That seems OK, but I insist that you insert some comments explaining
what is going on and why it's safe so somebody auditing uses of refcount
doesn't have to reanalyse the whole thing for themself.  Or worse that
somebody working on the iommu sees this and thinks they can "improve"
on it.

