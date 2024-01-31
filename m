Return-Path: <linux-kernel+bounces-47216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6255E844A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F218D1F2276B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755BF39AF0;
	Wed, 31 Jan 2024 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5bIouCx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58154848A;
	Wed, 31 Jan 2024 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738308; cv=none; b=RREqfd1GgoszwjXYTObXfV3FyxQUi2w0oTvivnFvFKVArHCZcB4cE5TneuZYni5hTyF18lBHElydafH4+3WCdFB4/vQdwnJN+TFYNwVYxy/+rKxNjU3sXdfoYBI3QxIg0+F8zChwZcp6SKMsai7kSRnDTEIM41BkQq2GbKe5LPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738308; c=relaxed/simple;
	bh=OCJeKfhQ9glNLXX2ntf9uF6fRDRZS3kJloQ6WG9qz+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oss+OhbgcqQ1dcGfO9SCkNHAVb2Ex4DaXWA+5i4qzURSoURH9NufE/mfrO5cgfql+iid3GVVBp0lsazN6OPzDRZEpFOXqGx1MPnxSIH0bBlF2qiX0ebp8QzhrWE+UEfwU6REAzsLK0bMN/yX+f3yA8nu2+1+g6OXW5uWS5beEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h5bIouCx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iQfXW37ZK31yG37Afle32aWwrDr+gCC0dupCwANd1vs=; b=h5bIouCxLjtlG+frdiQOFKm2uX
	U/2ZniW40PsD232UWulNNlEaoHXQ8vL020jg5yOCCTTa2+x+4cp4iN0RKjKmw/OFYhACLIHTwfHrr
	+OCXquWfqnT2hOYEFwKT6LLOUBLWA2LhvBYQNZ6mEUsnh/xuiGHLX8KHfraUJLSPSPCZ74ckbjL4L
	P5vpWzCdDLZG1+r+ZaXFv+NzQs/EblX49p6GNr5b3Ps9H8UMa0RrlxLERCzxFBPLMYC6RjWIx12M3
	DUQzLrOfxDW43HkIUxSepWMBLAeXVqd6+SjoBG1E1Agz2p7Wd/eMuy2VQiUevb74HBKrZx5tEEB4E
	CXo+TkOA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVIbC-00000005dEB-100a;
	Wed, 31 Jan 2024 21:58:26 +0000
Date: Wed, 31 Jan 2024 13:58:26 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Daniel Gomez <da.gomez@samsung.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <ZbrCglszF4n3BtGA@bombadil.infradead.org>
References: <20231104005747.1389762-2-da.gomez@samsung.com>
 <202311152254.610174ff-oliver.sang@intel.com>
 <ZVfS8fiudvHADtoR@bombadil.infradead.org>
 <ZVfT3bs9+F0jqIAw@casper.infradead.org>
 <ZVfUnhzv4UDigZKa@bombadil.infradead.org>
 <ZbQEA6WIh0HrFTbP@bombadil.infradead.org>
 <ZbQHWf0Hh04OwoZx@casper.infradead.org>
 <ZbQQXO5YhKhdr1Ou@bombadil.infradead.org>
 <ZbQW3PRAIw8e7m0m@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQW3PRAIw8e7m0m@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Jan 26, 2024 at 08:32:28PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 26, 2024 at 12:04:44PM -0800, Luis Chamberlain wrote:
> > > We have a perfectly good system for "relaxing":
> > > 
> > >         xas_for_each_marked(&xas, page, end, PAGECACHE_TAG_DIRTY) {
> > >                 xas_set_mark(&xas, PAGECACHE_TAG_TOWRITE);
> > >                 if (++tagged % XA_CHECK_SCHED)
> > >                         continue;
> > > 
> > >                 xas_pause(&xas);
> > >                 xas_unlock_irq(&xas);
> > >                 cond_resched();
> > >                 xas_lock_irq(&xas);
> > >         }
> > 
> > And yet we can get a soft lockup with order 20 (1,048,576 entries),
> > granted busy looping over 1 million entries is insane, but it seems it
> > the existing code may not be enough to avoid the soft lockup. Also
> > cond_resched() may be eventually removed [0].
> 
> what?  you're in charge of when you sleep.  you can do this:
> 
> unsigned i = 0;
> rcu_read_lock();
> xas_for_each(...) {
> 	...
> 	if (iter++ % XA_CHECK_SCHED)
> 		continue;
> 	xas_pause();
> 	rcu_read_unlock();
> 	rcu_read_lock();
> }
> rcu_read_unlock();
> 
> and that will get rid of the rcu warnings.  right?

The RCU warning was due to my getting an try call missing an RCU lock,
I fixed that. The pending issue was a soft lockup that I get on low end systems
testing test_xarray with higher order but after testing on a 2 vcpus
with only 2 GiB of RAM I cannot reproduce so we can address this later.
I forget the exact type of low end system I tested this on... but anyway
I can't reproduce now. I suspect it may have been similar to the issue
0-day had found long ago and you noted an overloaded system [0]

[0] https://lore.kernel.org/all/20190306120843.GI13380@bombadil.infradead.org/

  Luis

