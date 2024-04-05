Return-Path: <linux-kernel+bounces-132875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92027899B86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2CB238F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ACB16C42D;
	Fri,  5 Apr 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owT5ZZcc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3D16ABF2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315043; cv=none; b=Ka49cdNHqwaPgEOLE2SvqRGr+5QvQDg95/gBTNNTuWK9Vx3Guyid7PQwucJkIJKekJIPe7Sv3mBWKC6S+c25/5car85mSbsqvYejR7Y8GsVE4x4k4Wrkmz1qA5XvMEVrdf7CDITRznqB0kv1iWfFUnAZCzEaXyU0Pel5IOtNmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315043; c=relaxed/simple;
	bh=bkikQb+6+SHIGDTye0SwNIDKwDhn2zrsNbUjXKpeaas=;
	h=Message-Id:Date:From:To:Cc:Subject; b=dBfzxFaxJ5DA3zOc/htvwwQdprPRca2gjGGBH1sr7hdMf5Uyam9Uiz9qY/87JxYDx5RNihMO2m7y28Yh+tT6fV58fQr9ra9LWcVoEJLXEkiZpFpCCJdMWxFLgrAEnBZY2c5s4iHHTEHzI+tTlRDnfyvn67pJrIFCZWS+REU+C1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=owT5ZZcc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Q1YsIJqjHocfz/fHFc5NKmKtYv2nkqF2ZzLoogGGG4s=; b=owT5ZZccQk8ZrvT+1QTJLXd0Io
	6KlbVtvZSox0O3wT6ZiGgLnKLQnUOA9FVSBFK/rcAcikVUuUWghSBibhx9vvIhavrs/FUqcjkwb1l
	Y6G5eKFy8M4X+hgAr97sUXTMq2CS0Y1iDIGIGFXn+ouSqG0wnTIch+UBiYUG8rKUIY2SO0aA4poQs
	DI+T36LritOY28D1KE8Vft8i/C+dvervZWuYRe/CE3nB0Mjw+KEqNgTRTLNfOXPvnRQfXwCji6CXh
	+M7gTlv7UrKpydpB0/1vLpADOuqowvtLU0Ss0MQ805L5ylr2JjkH3zT0nh5H3TH0/x+g6G7ygcCzQ
	v9wuDH/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMG-00000005Z8g-3Qch;
	Fri, 05 Apr 2024 11:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 7802D300DD1; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405102754.435410987@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:27:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC][PATCH 00/10] sched/fair: Complete EEVDF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all,

I'm slowly crawling back out of the hole and trying to get back to work.
Availability is still low on my end, but I'll try and respond to some email.

Anyway, in order to get my feet wet again with sitting behind a computer, find
here a few patches that should functionally complete the EEVDF journey.

This very much includes the new interface that exposes the extra parameter that
EEVDF has. I've chosen to use sched_attr::sched_runtime for this over a
nice-like value because some workloads actually know their slice length (can be
dynamically measured in the same way as for deadline using
CLOCK_THREAD_CPUTIME_ID) and using the real request size is much more effective
than some relative measure.

 [[ using too short a request size will increase job preemption overhead,
    using too long a request size will decrease timeliness ]]

The whole delayed-dequeue thing is I think a fundamental thing that was missing
from the EEVDF paper. Without something like this EEVDF will simply not work
right. IIRC this was mentioned to me many years ago when people worked on BFQ
iosched and ran into this same issue. Time had erased the critical aspect of
this note and I had to re-discover it again.

Also, I think Ben expressed concern that preserving lag over long periods
doesn't make sense a while back.

The implementation presented here is one that should work with our cgroup mess
and keeps most of the ugly inside fair.c unlike previous versions which puked
all over the core scheduler code.

Critically cfs-cgroup throttling is not tested, and cgroups are only tested in
so far that a systemd infected machine now boots (took a bit).

Other than that, it works well enough to build the next kernel and it passes
the few trivial latency-slice tests I ran.

Anyway, please have a poke and let me know...


