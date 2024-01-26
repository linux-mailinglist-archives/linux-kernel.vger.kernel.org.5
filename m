Return-Path: <linux-kernel+bounces-40630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A383E368
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C56287F52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADC2249FE;
	Fri, 26 Jan 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iel542Jf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE5241E0;
	Fri, 26 Jan 2024 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301154; cv=none; b=BUWxq2bS/pNZNwKnS6iepysPBcsYffp2lT6bkUjg2y0E+zrM8djwmtPTbjIZPW41Bg0OtQY7xCtAIvdiaNHOy9IZTYGQB1ATAXaxhAhieIpwDcxx1SIhri25FP/UXbl4e/eeNMnbN5W27lT7IYJ19bSoi7AoxdVfTeynehK9uqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301154; c=relaxed/simple;
	bh=wANifjjWbLBVVOsC8JHualEA+NV/bbYwL17PG/8F3KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM/HPR4GJkIw/BtIzn7UMyB444NKCtTWbAQiV3CPHLBQ4Y/2FN7wPYKmfsJODlngjC48mBMhPB6JOn8jduZiqrlS8Wurwjyy+BsteuydPQN6F6dJswjvb5qATX6OqYqgyUqb9ty2ZPfU6b3IgOu1Ats8uP4yBh2Ue/xvtSm2ZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iel542Jf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bsC6ldb06AJMfiIpCUpPZRXENhb0M6TRf0RwF7flu9o=; b=Iel542JfGo31xCXqKw1qko80Pp
	3gVntou9F6oP1w9OxCWex9PXg/j2IQmM7G/oIhV9iy3U6dOCvZNKxn/yj2StLF3PFAtFXxTIsfU+9
	jKc8+2CtDtjq4S2VVH/VMx561ASDzLXuUR3qsH/3w1HPng8iWgLy9dQeGYBTvMTXCckD2v9wTzeRh
	nzhV5+02SNQWWOSCK5owo38cvpCnQbyxypcpDLq+Rm/w1cs7j1+ZtT1CuYrI8c+S17ZcxfakkHd1k
	iWHO9+5JUr50jz7Wp8i+WAAYxI7+KnMESIprOdmOQGW9uZHNqjPKy6iB7iQJZ71kr9eR8SeUTfsNN
	OMuh4eaA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTSsG-0000000EmYd-1CgM;
	Fri, 26 Jan 2024 20:32:28 +0000
Date: Fri, 26 Jan 2024 20:32:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Daniel Gomez <da.gomez@samsung.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <ZbQW3PRAIw8e7m0m@casper.infradead.org>
References: <20231104005747.1389762-2-da.gomez@samsung.com>
 <202311152254.610174ff-oliver.sang@intel.com>
 <ZVfS8fiudvHADtoR@bombadil.infradead.org>
 <ZVfT3bs9+F0jqIAw@casper.infradead.org>
 <ZVfUnhzv4UDigZKa@bombadil.infradead.org>
 <ZbQEA6WIh0HrFTbP@bombadil.infradead.org>
 <ZbQHWf0Hh04OwoZx@casper.infradead.org>
 <ZbQQXO5YhKhdr1Ou@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQQXO5YhKhdr1Ou@bombadil.infradead.org>

On Fri, Jan 26, 2024 at 12:04:44PM -0800, Luis Chamberlain wrote:
> > We have a perfectly good system for "relaxing":
> > 
> >         xas_for_each_marked(&xas, page, end, PAGECACHE_TAG_DIRTY) {
> >                 xas_set_mark(&xas, PAGECACHE_TAG_TOWRITE);
> >                 if (++tagged % XA_CHECK_SCHED)
> >                         continue;
> > 
> >                 xas_pause(&xas);
> >                 xas_unlock_irq(&xas);
> >                 cond_resched();
> >                 xas_lock_irq(&xas);
> >         }
> 
> And yet we can get a soft lockup with order 20 (1,048,576 entries),
> granted busy looping over 1 million entries is insane, but it seems it
> the existing code may not be enough to avoid the soft lockup. Also
> cond_resched() may be eventually removed [0].

what?  you're in charge of when you sleep.  you can do this:

unsigned i = 0;
rcu_read_lock();
xas_for_each(...) {
	...
	if (iter++ % XA_CHECK_SCHED)
		continue;
	xas_pause();
	rcu_read_unlock();
	rcu_read_lock();
}
rcu_read_unlock();

and that will get rid of the rcu warnings.  right?


