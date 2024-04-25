Return-Path: <linux-kernel+bounces-158480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EB8B20B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6152830F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85012BEB6;
	Thu, 25 Apr 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XRFkJtJW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4612BE89
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045800; cv=none; b=gDsLfxwBBmeKvooEYvq2Ei+rDe2qM5UCu8wJIVi6hr8AxCZmx5ODWI3bDQN7M4gKJ2lPqhhX3J7T2GKAtRpgMIcI+b3qmrwsvDhRgxf7kRiR0OY5WDzMCfd8/nPv0b1XX/CcQS0MvVgxOUhe7dtY3C7WNtTDGztH/iSPnfV08wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045800; c=relaxed/simple;
	bh=P8V7MCi9hduS/hZkRXSgoYkKYCb9Aj7iqmWztCrkDM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk4hVYA1IkLEdEFXYEclNlangfh+C/LpNMbGBKy4w3Puyf0mDwcBW7+XoMgtMEJVo6ApdLUDLEa9s7+XIgIKh9Siwa0RLob1JZ5pGfdVxpEXN2MJS0XLux6K+maSL3CwZbeVxyEhaS/kX1D/DB1/n8bkQ1brQyigK7zyjy6sNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XRFkJtJW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Oifw9qpN855aTC4DmsgN7sJLcbfvYepEMTuQVWv2urU=; b=XRFkJtJWZj5kAwdOO6wmYxN4wd
	UwxVp5cVEbLRnswZP16F810uwmr2MZwOo5ksRiuMLd/eRnvXCEpiU5DQsF8FAk3KveUsv7JiFguLb
	DNhbHxWiAodeawjNXlEX0fB5vWCCCsgP5PgxwbRBoklQXy0UraPF6/pZHUZ9RuOHsna/qukGHX+s4
	qMd2e9GVZQRrjTXRPo4Uehh8+6WB2g96wt7sOoafXC5qqngz5jPXu6fwJJPM7wAQLezuFxoU+RF3h
	+aiKc6+raTVCSG0K0n0rA8bsaxaUDcP3AUF7gjW9OGv9upPCRCmm+7SjqGRjTiSpsN9elEEdpiZ1t
	gkimiX0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzxbp-0000000ErD3-2v8o;
	Thu, 25 Apr 2024 11:49:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 575D6300439; Thu, 25 Apr 2024 13:49:49 +0200 (CEST)
Date: Thu, 25 Apr 2024 13:49:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	nd <nd@arm.com>, John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240425114949.GH12673@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425104220.GE21980@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 12:42:20PM +0200, Peter Zijlstra wrote:

> > I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
> > utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
> > higher OPP's in the big cores, leading to poor decisions for energy efficiency.
> 
> Notably util_est_update() gets delayed. Given we don't actually do an
> enqueue when a delayed task gets woken, it didn't seem to make sense to
> update that sooner.

The PELT runnable values will be inflated because of delayed dequeue.
cpu_util() uses those in the @boost case, and as such this can indeed
affect things.

This can also slightly affect the cgroup case, but since the delay goes
away as contention goes away, and the cgroup case must already assume
worst case overlap, this seems limited.

/me goes ponder things moar.

