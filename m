Return-Path: <linux-kernel+bounces-153250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70F8ACB77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC741C21ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E11465B7;
	Mon, 22 Apr 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8T6PrCT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F28146006;
	Mon, 22 Apr 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783269; cv=none; b=h3RHn5GU7i8odmU7L/uNSyIPDIICRxxPAy+PFoQM3GpIvs4xhLpp2T6hTBZOxOdn2y17ax/G/L3BzlaKpDqDY66uumzN1II3c0PGg3gL5TjLZa2Yl2f/roXakzvqeUEDYOTJHpNJCIm6O9RfXNUdwASH6PlW3mDPO0atRGkCULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783269; c=relaxed/simple;
	bh=Y8oWTGmW1mp+gUweWdjbgRIr3XR+PFMgE5gNzpaFnfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVcqX+TBHDVskIxSJWdCQz7CM1yCEVhVjqL+zCO0af4WAjpueCDFj2gTryfGTjOmfCjoJHUplW3hLyCXynCCoottCIdSKbHPRSu1B/LxDjdG57COJ47+fTJ64gaDRDnyaf3RUAyecDima2jyWe2l9p61TNYx5fadn+N7mcn2Rk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m8T6PrCT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oZEeguo2b2jtBnPbKaY5/9sstm18yBWC6j46f2+Lpkw=; b=m8T6PrCTf/zqyGaoLOTNGzy+Cm
	BjDM4Ul2VP01WHEvLTKqhdrBlax+GYn4vTGhvO/BHQUeGHHZrVOajZThjO8CsMQNh4fVzSGfCxFK+
	R9ccetuloSu+3l6D/Fsej1NG2GAkS/mM8lI5rHhqvIHtampPbCN8+XnSrFuzHSZYeuRgSJqyEWJHY
	KJxg+cx/WLfR4+68zVs/LDlJOtnmaIm+JNUtkG0JpEtzN/5LsO/xHqm3wKm3Rgklq2Izu+AD3mPoR
	JRO4ew/AOaKz9OvtyEvtaL8212VPHOHaFVapFAP2ruyQqDStecdvNLOrtf2C011TEBDJdassVVFKS
	ZH1SJDMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryrJY-0000000DdIE-2YmC;
	Mon, 22 Apr 2024 10:54:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 436B430045D; Mon, 22 Apr 2024 12:54:24 +0200 (CEST)
Date: Mon, 22 Apr 2024 12:54:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <msnitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Message-ID: <20240422105424.GM30852@noisy.programming.kicks-ass.net>
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
 <20240417175538.GP40213@noisy.programming.kicks-ass.net>
 <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>

On Wed, Apr 17, 2024 at 08:00:22PM +0200, Mikulas Patocka wrote:
> 
> 
> On Wed, 17 Apr 2024, Peter Zijlstra wrote:
> 
> > On Wed, Apr 17, 2024 at 07:49:17PM +0200, Mikulas Patocka wrote:
> > > Index: linux-2.6/kernel/sched/completion.c
> > > ===================================================================
> > > --- linux-2.6.orig/kernel/sched/completion.c	2024-04-17 19:41:14.000000000 +0200
> > > +++ linux-2.6/kernel/sched/completion.c	2024-04-17 19:41:14.000000000 +0200
> > > @@ -290,6 +290,26 @@ wait_for_completion_killable_timeout(str
> > >  EXPORT_SYMBOL(wait_for_completion_killable_timeout);
> > >  
> > >  /**
> > > + * wait_for_completion_long_io - waits for completion of a task
> > > + * @x:  holds the state of this particular completion
> > > + *
> > > + * This is like wait_for_completion_io, but it doesn't warn if the wait takes
> > > + * too long.
> > > + */
> > > +void wait_for_completion_long_io(struct completion *x)
> > > +{
> > > +	/* Prevent hang_check timer from firing at us during very long I/O */
> > > +	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
> > > +
> > > +	if (timeout)
> > > +		while (!wait_for_completion_io_timeout(x, timeout))
> > > +			;
> > > +	else
> > > +		wait_for_completion_io(x);
> > > +}
> > > +EXPORT_SYMBOL(wait_for_completion_long_io);
> > 
> > Urgh, why is it a sane thing to circumvent the hang check timer? 
> 
> The block layer already does it - the bios can have arbitrary size, so 
> waiting for them takes arbitrary time.

Yeah, but now you make it generic and your comment doesn't warn people
away, it makes them think this is a sane thing to do.

