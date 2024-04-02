Return-Path: <linux-kernel+bounces-127405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53E7894AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69E91C2190E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27C18624;
	Tue,  2 Apr 2024 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o5SNWltq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76841805A;
	Tue,  2 Apr 2024 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036040; cv=none; b=r56YcHOBVo1M+CTovoDuT3Vvmi0/bJpSKhUy7APu7BB+pXQOApSNbX37BV5e7+SGnlQfu73etlBAu1zBxeYiSGz7MUjtdP5YfXbTun+lKWvjaVYiCznRMsl31YNhFCC/rMXY1u2EJJCqUNdZyqy7O8y7k9M60c7hAxnh8hhvDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036040; c=relaxed/simple;
	bh=/XDMOAH0zgBJ+JWms6+5MCYJwxngTNToGSNYTncbdAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTLWEVuCIqzUcrthY8iLGhZ3vDTgDS/DgkQsyxK5RuaM3drq/VJpHxzxHmeD+b/9TK9J/SXkq2Oh3u8WSsphaeOGRUKZBWYGi18ELzzyc6Fnks5wLPQGYKL1RqNQ90Csiq3iZVm+QqAnl5AEFOF7dhVqZiWlLxV7+fACCuf5U6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o5SNWltq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hjLgNLhFLW4hN7k/B3OvpVJsjxBcTs6HemIA9FmIj8M=; b=o5SNWltqSwrtoE6l+7NaQpj6Ls
	SNh3k15mQztIVwni1JOQOeF257R2q9ZJ6EufcW9N04cq5kJ6PhHAzrYickWkjj0fuXKRmAz8j652y
	C662IDwEvd6dN90TIiEbZzUG/fzEdARfo0ODa5t+Wwd8Y1pw6AQxYHe0901q7YHoFVuIcpl0CFURT
	zQM6vF4QcLaQKgFkta0iLT51au5GKFk4CtF6D3Cqx47C0hrMg7dEE5tSB61i8U5iaOIvSGJLrEZkt
	ElHrc2zTvvOcm53FzAmH1qp12/jhlU7WYWcrR15Poo4/pQZuIrW1qiTOB3blWzEqHIJHsbefD8sZr
	1C4VJsiA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrWmR-00000002IaN-3ush;
	Tue, 02 Apr 2024 05:33:56 +0000
Date: Tue, 2 Apr 2024 06:33:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "bounds: support non-power-of-two CONFIG_NR_CPUS"
 failed to apply to 5.4-stable tree
Message-ID: <ZguYw9Dke_uq5UZU@casper.infradead.org>
References: <20240327122125.2836828-1-sashal@kernel.org>
 <ZgQowqqGf-E7Cpcz@casper.infradead.org>
 <2024032935-antsy-imitation-1453@gregkh>
 <2024032959-ladies-circling-3a5e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032959-ladies-circling-3a5e@gregkh>

On Fri, Mar 29, 2024 at 06:05:20PM +0100, Greg KH wrote:
> On Fri, Mar 29, 2024 at 02:34:43PM +0100, Greg KH wrote:
> > On Wed, Mar 27, 2024 at 02:10:10PM +0000, Matthew Wilcox wrote:
> > > On Wed, Mar 27, 2024 at 08:21:25AM -0400, Sasha Levin wrote:
> > > > The patch below does not apply to the 5.4-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > 
> > > Looks like you just need a little more fuzz on the patch.
> > > 
> > > diff --git a/kernel/bounds.c b/kernel/bounds.c
> > > index 9795d75b09b2..a94e3769347e 100644
> > > --- a/kernel/bounds.c
> > > +++ b/kernel/bounds.c
> > > @@ -19,7 +19,7 @@ int main(void)
> > >  	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
> > >  	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
> > >  #ifdef CONFIG_SMP
> > > -	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
> > > +	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
> > >  #endif
> > >  	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
> > >  	/* End of constants */
> > 
> > Now fuzzed, thanks.
> 
> But it breaks the build on 4.19.y, so I'll go drop it from there.  If
> you want it added there, please provide a working fix.

Looks like bits_per() didn't exist in 4.19.  It was added as part of commit 69842cba9ace84849bb9b8edcdf2cefccd97901c
Author: Patrick Bellasi <patrick.bellasi@arm.com>
Date:   Fri Jun 21 09:42:02 2019 +0100

    sched/uclamp: Add CPU's clamp buckets refcounting

Up to you; I can provide bits_per() to 4.19 which will aid backporting
other fixes (we currently have 17 uses of bits_per() in 6.9), or we can
just drop this whole thing for 4.19.

