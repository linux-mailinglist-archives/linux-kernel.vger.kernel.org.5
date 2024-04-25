Return-Path: <linux-kernel+bounces-158372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3DA8B1EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F6D1C24C16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361248627E;
	Thu, 25 Apr 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uzUYTEvv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E5F6EB52;
	Thu, 25 Apr 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040198; cv=none; b=eV6BDHJWOaGvSQUId656ziVgnvyfjQb+N3WKqgI7IgxRyMkzCHVGKqwlw0nI3zBA5PbD8PTMJqqS2U88smZNZrPDOOvPHpScKmXHfUWb+U+MlgozS+RUjuPIX6IzgnahjqqfYn5qv4V+dL8TcT6IryYNh05JTh9f6GDwS1WtEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040198; c=relaxed/simple;
	bh=a6Sn+sWhrhHLnyLvMXI/BR9bFRVdcAoRJvkbmTOd8Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGbryF4SnagqlOTP+CauuXCjOc5HM3k0zD1w5XE+qqayFBTC43p3XYrdrWlkgLpGrMLO6pKOIXBPX7+8v8NYzHuU51xYnY5Vh5jugOyKvAoTqcTsyWIoXwl7SurHDVTetp8TxgJo23mATrn8TBB/uD+OLPBZ8T4dEBcWEmw4lE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uzUYTEvv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rEzHqrXFU6DDtueUKvIbqzzaqFrI4YVCMEuWV9mWzlo=; b=uzUYTEvvtcVYX/zuDrGYv0v85n
	mopOn/mI6X1RfhRcI4ARSi6AMKUyUOF9bhbksroSxa/bBf92/0xUETGFczcSuD4ONzc+w3EMLdRSX
	wG3Q0IKtAlpLP4xy62zGKf5scXGiH4MxQNeDf0riTv0iNaAZbmVYVDIIcF+FxI/NBemrP3PaSfnBi
	nGU6BX3+ClW7IABB9yeejCI/lI7O9IzTWzeahg/389hcyN7VLDr9SC975vbCrp3Q8DJiV/xvPk/rp
	r03n5fKR2lKtsZ73HSUug+v+GrI+8gzb4F1Q8s2Q5tYtw2/vA6uDuZ5RqfCjnzSUOyhQzoNguP3UG
	ixI+eB+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzw9W-00000002nvh-22pw;
	Thu, 25 Apr 2024 10:16:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BEE3B300439; Thu, 25 Apr 2024 12:16:29 +0200 (CEST)
Date: Thu, 25 Apr 2024 12:16:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH 4/4] sched/core: split iowait state into two states
Message-ID: <20240425101629.GC21980@noisy.programming.kicks-ass.net>
References: <20240416121526.67022-1-axboe@kernel.dk>
 <20240416121526.67022-5-axboe@kernel.dk>
 <20240424100127.GV40213@noisy.programming.kicks-ass.net>
 <f82fdfa3-8743-4d42-82d4-a4ca9bc24e15@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82fdfa3-8743-4d42-82d4-a4ca9bc24e15@arm.com>

On Wed, Apr 24, 2024 at 11:08:42AM +0100, Christian Loehle wrote:
> On 24/04/2024 11:01, Peter Zijlstra wrote:
> > On Tue, Apr 16, 2024 at 06:11:21AM -0600, Jens Axboe wrote:
> >> iowait is a bogus metric, but it's helpful in the sense that it allows
> >> short waits to not enter sleep states that have a higher exit latency
> >> than would've otherwise have been picked for iowait'ing tasks. However,
> >> it's harmless in that lots of applications and monitoring assumes that
> >> iowait is busy time, or otherwise use it as a health metric.
> >> Particularly for async IO it's entirely nonsensical.
> > 
> > Let me get this straight, all of this is about working around
> > cpuidle menu governor insaity?
> > 
> > Rafael, how far along are we with fully deprecating that thing? Yes it
> > still exists, but should people really be using it still?
> > 
> 
> Well there is also the iowait boost handling in schedutil and intel_pstate
> which, at least in synthetic benchmarks, does have an effect [1].

Those are cpufreq not cpuidle and at least they don't use nr_iowait. The
original Changelog mentioned idle states, and I hate on menu for using
nr_iowait.

> io_uring (the only user of iowait but not iowait_acct) works around both.
> 
> See commit ("8a796565cec3 io_uring: Use io_schedule* in cqring wait")
> 
> [1]
> https://lore.kernel.org/lkml/20240304201625.100619-1-christian.loehle@arm.com/#t

So while I agree with most of the short-commings listed in that set,
however that patch is quite terrifying.

I would prefer to start with something a *lot* simpler. How about a tick
driven decay of iops count per task. And that whole step array
*shudder*.

