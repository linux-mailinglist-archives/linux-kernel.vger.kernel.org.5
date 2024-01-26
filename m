Return-Path: <linux-kernel+bounces-40604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A683E30C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3128C1F26529
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140A22F1A;
	Fri, 26 Jan 2024 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Il1IIDZV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE622627;
	Fri, 26 Jan 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299486; cv=none; b=kGyGXlcnXECVwh1pFXhuKm4kjlw/quDacPS1BEJWyyQMJbuUYQIHAoJfzeUN7s8OWQE2HK8MKblFcnTS/C7DNUMwHqNdyUdwGwKpbcpqB0sNTBpxcakpGSyz5R/+eUmpK8N+GHOxF0hB6PPqiprhJ6Ki3pXlfx0SV5SHUP+rzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299486; c=relaxed/simple;
	bh=ccMl1PBgz/NjqHuJ3/eVNttfjTwPLda4GTqEe0hDckI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfjp16J+kxxMFMOHBkcsYiMuHClY/oX8Y1OPA76sut+NvRfLHV8cCBS+ae2uXKbPKIDNiM21yKjmYamT/Pzl4VUUWiNnQCNwL54BXQeLT7BeDaj0jltObn3/WoaGNOI35pc87NPG7tzwDX/6N9E4EwW60OCjjUTv8yRaNXwrJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Il1IIDZV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jnmyjvSQEp/q0Ynx/vobufARP3No6TCftfqQmRh9fMk=; b=Il1IIDZVBS/VzUt1WtD259RrFI
	8MtFMppx7LpmljStyWkBjpRUCfi92AfoBvWG9c+I5TzsWH3ZtNjOu0f6Je4+13YeieRvZa+4VH6nD
	D7WV05AGGwWgBvsYNeSYe+SHXFf/kK2iB7+82vwjHk1TcZ09gEY5iGZErvn2JH5FF0HP4pGUfFXib
	509XCEb8DkYbFt5kfrPfeVl+IEYn3xq4BgfpOOW2BAmGJePJ24+FwoODa/wJWn0xZVI7Pe0PpJ9mA
	GB7syuG1ClK8Jy0LBb5lsEGzB1SqrozsONGhzbiVq4sS7z9dDnClx1KWM6KdEbkXUJqO9BJdpCaTz
	pJXkvuyw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTSRQ-00000005Jol-1izF;
	Fri, 26 Jan 2024 20:04:44 +0000
Date: Fri, 26 Jan 2024 12:04:44 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Daniel Gomez <da.gomez@samsung.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <ZbQQXO5YhKhdr1Ou@bombadil.infradead.org>
References: <20231104005747.1389762-2-da.gomez@samsung.com>
 <202311152254.610174ff-oliver.sang@intel.com>
 <ZVfS8fiudvHADtoR@bombadil.infradead.org>
 <ZVfT3bs9+F0jqIAw@casper.infradead.org>
 <ZVfUnhzv4UDigZKa@bombadil.infradead.org>
 <ZbQEA6WIh0HrFTbP@bombadil.infradead.org>
 <ZbQHWf0Hh04OwoZx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQHWf0Hh04OwoZx@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Jan 26, 2024 at 07:26:17PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 26, 2024 at 11:12:03AM -0800, Luis Chamberlain wrote:
> > On Fri, Nov 17, 2023 at 01:01:18PM -0800, Luis Chamberlain wrote:
> > > On Fri, Nov 17, 2023 at 08:58:05PM +0000, Matthew Wilcox wrote:
> > > > On Fri, Nov 17, 2023 at 12:54:09PM -0800, Luis Chamberlain wrote:
> > > > > +/*
> > > > > + * Can be used in contexts which busy loop on large number of entries but can
> > > > > + * sleep and timing is if no importance to test correctness.
> > > > > + */
> > > > > +#define XA_BUG_ON_RELAX(xa, x) do {				\
> > > > > +	if ((tests_run % 1000) == 0)				\
> > > > > +		schedule();					\
> > > > > +	XA_BUG_ON(xa, x);					\
> > > > > +} while (0)
> > > > 
> > > > That is awful.  Please don't do that.  You're mixing two completely
> > > > unrelated thing into the same macro, which makes no sense.  Not only
> > > > that, it's a macro which refers to something in the containing
> > > > environment that isn't a paramter to the macro.
> > > 
> > > I figured you'd puke. Would you prefer I just open code the check on the loop
> > > though? I'm sure another alternative is we *not care* about these
> > > overloaded systems running the test. What would you prefer?
> > 
> > OK without any particular preferences outlined this is what I have,
> > splitting the two contexts and making the busy loop fix clearer.
> > 
> > +#define XA_BUSY_LOOP_RELAX(xa, x) do {                         \
> > +       if ((i % 1000) == 0)                                    \
> > +               schedule();                                     \
> > +} while (0)
> > +
> > +/*
> > + * Can be used in contexts which busy loop on large number of entries but can
> > + * sleep and timing is if no importance to test correctness.
> > + */
> > +#define XA_BUG_ON_RELAX(i, xa, x) do {                         \
> > +       XA_BUSY_LOOP_RELAX(i);                                  \
> > +       XA_BUG_ON(xa, x);                                       \
> > +} while (0)
> 
> No.  XA_BUG_ON_RELAX is not OK.  Really.
> 
> We have a perfectly good system for "relaxing":
> 
>         xas_for_each_marked(&xas, page, end, PAGECACHE_TAG_DIRTY) {
>                 xas_set_mark(&xas, PAGECACHE_TAG_TOWRITE);
>                 if (++tagged % XA_CHECK_SCHED)
>                         continue;
> 
>                 xas_pause(&xas);
>                 xas_unlock_irq(&xas);
>                 cond_resched();
>                 xas_lock_irq(&xas);
>         }

And yet we can get a soft lockup with order 20 (1,048,576 entries),
granted busy looping over 1 million entries is insane, but it seems it
the existing code may not be enough to avoid the soft lockup. Also
cond_resched() may be eventually removed [0].

Anyway, we can ignore the soft lockup then.

[0] https://lwn.net/Articles/950581/

  Luis

