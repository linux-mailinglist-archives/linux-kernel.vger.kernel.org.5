Return-Path: <linux-kernel+bounces-66239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56878558ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F20EB276C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81201392;
	Thu, 15 Feb 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i4x4HRTx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA112184E;
	Thu, 15 Feb 2024 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707963327; cv=none; b=fhoXx8O13Z2VoUBYjWwmrAqZS344/4VSDP3Kqhn4MltZWPWrN3znxULfWOqlgUQxF3yiQj2B1LRmlxYKWZShBnTCFqYM90CWe7eqPUyhFydw1kGgcHUtSqbKTrR2stSD7sdUMj7M/12PusJS4VDzcM5gduPcT7z4qCG5eK6Xzs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707963327; c=relaxed/simple;
	bh=Os4e0r0XH5+lXccwqGEMksaDDZuHN+IEX+6a1tIrWfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssNE9/dOuzEO3DrDVGGQyMkFDEARuZkzO1Yd3v7HfQXVxN6vGbS/g6znbhtgFHoLZM7DeIer1IFLmY9QrLh5QssWtmdjK004l4GuIuOC3DHE68+7bchdTgUIWppm3MVIyQHklrraLGtocs2/xJl6IHkY01QNoCZ7R03OLfIA0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i4x4HRTx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2xgKFSUqBYBFWruocdjixxesRScsvvle8lCKIAmFZm8=; b=i4x4HRTx6ntolPm6BiLkFfMoz6
	xcuKPRa7KG+1LPBqJYU6CTf2R/4QlAzv1Ekme00BaPXWJghRpIRnFkvKP6amTPMzNrMramUBDcqPP
	f2mzYUGmAI+4vkaMUVTun/EdF52LzJrDITLGs6NUxn57zdDW692Im7cHD9rXMugy59fvO5y07S9hJ
	0W/WQ112MTzZLx5HdXKVg+QHYkWbVPaMT1K9UCpTnpK6AwcPIN6JrgX2csR8iRdgprnXaP0jmdUL9
	UELBgEeLuJqrj4Tae0pVNFfjneZ3YrAf9NeHiz0jsBGDNlMfaxLFiWPVg+maRFKo2SAqp+rHJy0tT
	325XYYow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raRHY-0000000EniA-3gLF;
	Thu, 15 Feb 2024 02:15:24 +0000
Date: Wed, 14 Feb 2024 18:15:24 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Daniel Gomez <da.gomez@samsung.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <Zc1zvBpL6x1kpsfk@bombadil.infradead.org>
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

The RCU splat is long gone on my last iteration merged now on
linux-next, what's left is just a soft lockup over 22 seconds when you
enable disable preemption and enable RCU prooving and use 2 vcpus. This
could happen for instance if we loop over test_get_entry() and don't
want to use xas_for_each() API, in this case we don't as part of the
selftest is to not trust the xarray API and test it.

So in the simplest case for instance, this is used:

check_xa_multi_store_adv_add(xa, base, order, &some_val);               
                                                                                
for (i = 0; i < nrpages; i++)                                           
	XA_BUG_ON(xa, test_get_entry(xa, base + i) != &some_val);  

test_get_entry() will do the RCU locking for us. So while I agree that
if you are using the xarray API using xas_for_each*() is best, we want
to not trust the xarray API and prove it. So what do you think about
something like this, as it does fix the soft lockup.

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index d4e55b4867dc..ac162025cc59 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -781,6 +781,7 @@ static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
 {
 	XA_STATE(xas, xa, index);
 	void *p;
+	static unsigned int i = 0;
 
 	rcu_read_lock();
 repeat:
@@ -790,6 +791,17 @@ static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
 		goto repeat;
 	rcu_read_unlock();
 
+	/*
+	 * This is not part of the page cache, this selftest is pretty
+	 * aggressive and does not want to trust the xarray API but rather
+	 * test it, and for order 20 (4 GiB block size) we can loop over
+	 * over a million entries which can cause a soft lockup. Page cache
+	 * APIs won't be stupid, proper page cache APIs loop over the proper
+	 * order so when using a larger order we skip shared entries.
+	 */
+	if (++i % XA_CHECK_SCHED == 0)
+		schedule();
+
 	return p;
 }
 

