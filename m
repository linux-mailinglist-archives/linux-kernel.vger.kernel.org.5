Return-Path: <linux-kernel+bounces-82480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41C868521
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62661282AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C6723D0;
	Tue, 27 Feb 2024 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=delyan.me header.i=@delyan.me header.b="jUfkWOjo"
Received: from chi120.greengeeks.net (chi120.greengeeks.net [173.236.97.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818A17FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.236.97.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994718; cv=none; b=VIH/d+pjuv42zsxT/bmPhds+0g+6lClOKEpDT3oB4MtYdN5Grq8fGwXUQWqpxYRPyXcQmdQ94PeyAuh9EFxCYOg9hX0/lWWevxaepm/eunE9MYW6BtFPUkW2/KcQXHHxyN78DShrlJr597q5zgCw2M6aQPTTvIyoUQoJiz0/fjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994718; c=relaxed/simple;
	bh=7+H2MX6xwa9i7NO5yIxjPjOVCwU6yvq3m4R7rDSH9sI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OygHIFSsfoB9xNFFgH51SeB5d3ctl7jtv4DARGZjnF53zHWT/7nTKBsYifF9ScJldZqrYhDpQ5uJspPqvcdg75tz/A5waGd11jJIGBerYdOCbBX4MyYJHlsPs1aHOmGOInB5L72wS445CP7lqzgyy9RRBXX21+C2hizl1WlY7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delyan.me; spf=pass smtp.mailfrom=delyan.me; dkim=pass (2048-bit key) header.d=delyan.me header.i=@delyan.me header.b=jUfkWOjo; arc=none smtp.client-ip=173.236.97.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delyan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delyan.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=delyan.me;
	s=default; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ha1SPmpwr7o54xPSvG08jcbF74dcwj7k4612WTVV0U8=; b=jUfkWOjooy8nEg3LDdIRlCFl3T
	9oTNHNnU6XlTufwazPK/ZcOPMCzguudgV540s6qU8j9twtm29PeR+vrnjfGItzAkYLHEIiBwC0ZYc
	lRB1l7QNOHKe5EdGZ4wayI2/di1KlJdG57gVi1h3UMQh5UVRH4ahdYVrcmC6pE3l1JSX5JMWdPYhA
	Czyl13mSiZMZ0KU71xmuC189fz1CZwu3C+wVk3E69rZS4bGlDHMqjoLT0RYV2pL/wexfUl5CvB1dQ
	2zDxCMcDU9gtWWOivLraekvQZX2ZJSMgAVuYCt4Oqkxi/Q92vKSoiNlctQGO8fBkjKgi2PLoXgS1w
	E0MyPpiw==;
Received: from c-98-47-236-196.hsd1.ca.comcast.net ([98.47.236.196]:39084 helo=discovery.localnet)
	by chi120.greengeeks.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <delyan@delyan.me>)
	id 1relLo-0001lg-3B;
	Mon, 26 Feb 2024 18:29:39 -0600
From: Delyan Kratunov <delyan@delyan.me>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Posix process cpu timer inaccuracies
Date: Mon, 26 Feb 2024 16:29:38 -0800
Message-ID: <4547873.LvFx2qVVIh@discovery>
In-Reply-To: <87cyt0gr9r.ffs@tglx>
References: <87cyt0gr9r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chi120.greengeeks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - delyan.me
X-Get-Message-Sender-Via: chi120.greengeeks.net: authenticated_id: delyan@delyan.me
X-Authenticated-Sender: chi120.greengeeks.net: delyan@delyan.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Thanks for your detailed response, Thomas, I appreciate you taking the time 
with my random side quest!

> [...]
>
> That's wishful thinking and there is no way to ensure that.
> Just for the record: setitimer() has been marked obsolescent in the
> POSIX standard issue 7 in 2018. The replacement is timer_settime() which
> has a few interesting properties vs. the overrun handling.

This is a great point and I think it overrides anything I have to say about 
setitimer. Overall, I have nothing to rehash on the process signal delivery 
point, I understand the situation now, thanks to your thorough explanation!

> [...]
> I don't know and those assumptions have been clearly wrong at the point
> where the tool was written.

That was my impression as well, thanks for confirming. (I've found at least 3 
tools with this same incorrect belief)

> [...]
> > they still have the same distribution issues.
> 
> CLOCK_THREAD_CPUTIME_ID exists for a reason and user space can correlate
> the thread data nicely.
> 
> Aside of that there are PMUs and perf which solve all the problems you
> are trying to solve in one go.

Absolutely, the ability to write a profiler with perf_event_open is not in 
question at all. However, not every situation allows for PMU or 
perf_event_open access. Timers could form a nice middle ground, in exactly the 
way people have tried to use them.

I'd like to push back a little on the "CLOCK_THREAD_CPUTIME_ID fixes things" 
point, though. From an application and library point of view, the per-thread 
clocks are harder to use - you need to either orchestrate every thread to 
participate voluntarily or poll the thread ids and create timers from another 
thread. In perf_event_open, this is solved via the .inherit/.inherit_thread 
bits.

More importantly, they don't work for all workloads. If I have 10 threads that 
each run for 5ms, a 10ms process timer would fire 5 times, while per-thread 
10ms timers would never fire. You can easily imagine an application that 
accrues all its cpu time in a way that doesn't generate a single signal (in 
the extreme, threads only living a single tick).

Overall, what I want to establish is whether there's a path to achieve the 
_assumed_ interface that these tools expect - process-wide cpu signals that 
correlate with where cpu time is spent - through any existing or extended 
timer API. This interface would be imminently useful, as people have clearly,
albeit misguidedly, demonstrated.

If the answer is definitely "no," I'd like to at least add some notes to the 
man pages.

-- Delyan



