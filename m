Return-Path: <linux-kernel+bounces-40562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563583E278
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F961C217EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D0224E7;
	Fri, 26 Jan 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5SjkSvb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC0224DA;
	Fri, 26 Jan 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297182; cv=none; b=MSLegGBFg8KuofeB4H1n9kdegAncrBoIabsV/9D+I71F3qAahI4vsB2J02w09nWYUs7diMvTVYaoeplTRBxoOgzzlQJvPjcd7evYhED9x+zWN8pOaDUZ8VhVqNBj50KxMOF+NdMaI6e6VyQlB87HRMol/9M22v99v8fIpa7JqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297182; c=relaxed/simple;
	bh=T2Dsd8FsdX7PC+vZVdIMwKBV3nNVwsFSL3SmRekSYOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS3gLAUjTiFLv6LBqNdYNmnfoDKvlIAW1mNryupt6cPd0gmATYACw79fENMEZroS0jzTmwNF3tSU+BGCTnZz948jWeL2p4Mw7jiR+vAInrY9M9AOLpArz3eEjmc5DDbwQCEqVbNvevCY/6Oxnu4idhb7hBgiU3QsCfNTr70ohhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h5SjkSvb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HaAu8QaTfuj/1bKwP39c5NDE0gj5e/ufSqth9B+stzU=; b=h5SjkSvbAZ8Nl4MpgfmkPoV4mj
	DmLxDEQt1ChnBYPk5yokNEItG291CMfJ9OvlnL8LPg/TKHM9b7kFPwIXS4n7+yjSwQwtUycfSv3Qm
	EuOnR8TNpHdkfjAUKSTH8vfjS014Pt0SaDQuf8JOQjvDMQ18Nj95okj4dkFaYjAvVeb7VbVK6bk1p
	863YD96Xmg1mEvHYiPqv1vApb/8KvO2Xka42Ktl8FbgbirFR1Er/4lUp9qH8fyGp6oMCwtNuVscWR
	DHgLp8D+cBmehdUUtqkw1qbeaueiv99Bxn3j/YE1CjftKVKoTLfVjBTuXrnigunVwArYeBbhHkwv+
	vpeoH7GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTRqD-0000000EcFc-1O9T;
	Fri, 26 Jan 2024 19:26:17 +0000
Date: Fri, 26 Jan 2024 19:26:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Daniel Gomez <da.gomez@samsung.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <ZbQHWf0Hh04OwoZx@casper.infradead.org>
References: <20231104005747.1389762-2-da.gomez@samsung.com>
 <202311152254.610174ff-oliver.sang@intel.com>
 <ZVfS8fiudvHADtoR@bombadil.infradead.org>
 <ZVfT3bs9+F0jqIAw@casper.infradead.org>
 <ZVfUnhzv4UDigZKa@bombadil.infradead.org>
 <ZbQEA6WIh0HrFTbP@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQEA6WIh0HrFTbP@bombadil.infradead.org>

On Fri, Jan 26, 2024 at 11:12:03AM -0800, Luis Chamberlain wrote:
> On Fri, Nov 17, 2023 at 01:01:18PM -0800, Luis Chamberlain wrote:
> > On Fri, Nov 17, 2023 at 08:58:05PM +0000, Matthew Wilcox wrote:
> > > On Fri, Nov 17, 2023 at 12:54:09PM -0800, Luis Chamberlain wrote:
> > > > +/*
> > > > + * Can be used in contexts which busy loop on large number of entries but can
> > > > + * sleep and timing is if no importance to test correctness.
> > > > + */
> > > > +#define XA_BUG_ON_RELAX(xa, x) do {				\
> > > > +	if ((tests_run % 1000) == 0)				\
> > > > +		schedule();					\
> > > > +	XA_BUG_ON(xa, x);					\
> > > > +} while (0)
> > > 
> > > That is awful.  Please don't do that.  You're mixing two completely
> > > unrelated thing into the same macro, which makes no sense.  Not only
> > > that, it's a macro which refers to something in the containing
> > > environment that isn't a paramter to the macro.
> > 
> > I figured you'd puke. Would you prefer I just open code the check on the loop
> > though? I'm sure another alternative is we *not care* about these
> > overloaded systems running the test. What would you prefer?
> 
> OK without any particular preferences outlined this is what I have,
> splitting the two contexts and making the busy loop fix clearer.
> 
> +#define XA_BUSY_LOOP_RELAX(xa, x) do {                         \
> +       if ((i % 1000) == 0)                                    \
> +               schedule();                                     \
> +} while (0)
> +
> +/*
> + * Can be used in contexts which busy loop on large number of entries but can
> + * sleep and timing is if no importance to test correctness.
> + */
> +#define XA_BUG_ON_RELAX(i, xa, x) do {                         \
> +       XA_BUSY_LOOP_RELAX(i);                                  \
> +       XA_BUG_ON(xa, x);                                       \
> +} while (0)

No.  XA_BUG_ON_RELAX is not OK.  Really.

We have a perfectly good system for "relaxing":

        xas_for_each_marked(&xas, page, end, PAGECACHE_TAG_DIRTY) {
                xas_set_mark(&xas, PAGECACHE_TAG_TOWRITE);
                if (++tagged % XA_CHECK_SCHED)
                        continue;

                xas_pause(&xas);
                xas_unlock_irq(&xas);
                cond_resched();
                xas_lock_irq(&xas);
        }


