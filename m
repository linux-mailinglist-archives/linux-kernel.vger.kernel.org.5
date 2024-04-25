Return-Path: <linux-kernel+bounces-158408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE498B1F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B4B1C209B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8D72031D;
	Thu, 25 Apr 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v+BOFv5e"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9A1865
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041753; cv=none; b=b6E/nawiWKAW7NyWIsUbvswnrbV5oyinYLSGbS1S5PWzt7sNV0iCrfDFZonBwLT8jWKN1zH/kz/fxNPL6e6/U/hh+Mw+ExMQ7GgkIPfVBhUTtTwUZfZWRVJQwUI4gf1nk/Lk20VlkrI1PFVVnZuVOmpYooHVtcjFrJqCju3OxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041753; c=relaxed/simple;
	bh=/r9C2Rdjx/dej0MOPcNKR8WH/CjnanoIVxfs1k4AJXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsIgUBiprLPZF8BoA+/5izp1QOtk7tWGmA0/9xUPstXN1M0gFInp/e7P8aLCPrpro3P9DEmLX9e/pp2hW+y4htJI4XsHdJzrJzbWZmVaeshiAZn1RUF1AQJoaMRYzRmxOM6Xd/6jvJRTiDaI6v+yOyOekaoaw05+aApKDf5dn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v+BOFv5e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CLU0CWx+zn8bjJdpCgnHQM0eSQvzJLmaK6f1Wl5JDYk=; b=v+BOFv5eU9cp2MJ/v0c3Z+tAN/
	Huc1ZXYjGgqTbWoQHN0dWao2gV0tJ6aCw+5aAWMu9DSqszb2Q56+qzQXZmPG1orRsxzhXZyW11E2n
	GdWvt7VUrX5Z/8PRDITztZCmUmlJUwcUxNE2O6IG0Lh/zVM77CYy/huhKLdjzw4a2X14ZPqqCxdWy
	cst7B/Wmn6LwEkpP+TH7pcSm1v2SaQo862LDJgMHE0uGyrxL9y2w27slxP+gi2fIn5c911ihXT1xz
	OLGj6LPMtwKd8DepXcw3x+5FX5e6WXXsz7LbYdDJ7mZ+u4K0s2IZaqbmu9LMo8yIcRgf1tAl0ilMS
	v5wTQcEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzwYW-00000002qds-3HvC;
	Thu, 25 Apr 2024 10:42:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 71DAE300439; Thu, 25 Apr 2024 12:42:20 +0200 (CEST)
Date: Thu, 25 Apr 2024 12:42:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	nd <nd@arm.com>, John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240425104220.GE21980@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461277e-af68-41e7-947c-9178b55810b1@arm.com>

On Wed, Apr 24, 2024 at 04:15:42PM +0100, Luis Machado wrote:

> > Bisecting through the patches in this series, I ended up with patch 08/10
> > as the one that improved things overall for these benchmarks.
> > 
> > I'd like to investigate this further to understand the reason behind some of
> > these dramatic improvements.
> > 
> 
> Investigating these improvements a bit more, I noticed they came with a significantly
> higher power usage on the Pixel6 (where EAS is enabled). I bisected it down to the delayed
> dequeue patch. Disabling DELAY_DEQUEUE and DELAY_ZERO at runtime doesn't help in bringing
> the power usage down.

Hmm, that is unexpected. The intent was for NO_DELAY_DEQUEUE to fully
disable things. I'll go have a prod at it.

> Though I don't fully understand the reason behind this change in behavior yet, I did spot
> the benchmark processes running almost entirely on the big core cluster, with little
> to no use of the little core and mid core clusters.
> 
> That would explain higher power usage and also the significant jump in performance.

ISTR you (arm) has these tools to trace and plot the varioud util
values. This should be readily reflected there if that is the case, no?

> I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
> utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
> higher OPP's in the big cores, leading to poor decisions for energy efficiency.

Notably util_est_update() gets delayed. Given we don't actually do an
enqueue when a delayed task gets woken, it didn't seem to make sense to
update that sooner.

I'll go over all that again.

