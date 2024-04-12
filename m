Return-Path: <linux-kernel+bounces-142168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7F8A2868
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506001F2353D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695824D595;
	Fri, 12 Apr 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZHPJPU+D"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A684AED7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907811; cv=none; b=H9BMTXiS0Xf8FvOJygKNECwFhCWkKG3EYBQhoPavwer6+Yp5rGoVUy/ct8jhN5bP60CPDKbGE5F5d7cK0GmqVc0rHb/TdJMmwyszCyJrYua9vQNoy8fEkzbg08jH6inh84ZqsvQFKBNxpbExJLWibElMsyZGALFfBrBHBG/949U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907811; c=relaxed/simple;
	bh=StuD/HabmuU7PxPUah/OQP/1NIIFVO5VCeXkpG1dpsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdV+nZSYBFapVqt3S1dFNRl/yvSpoam5zyBP2RkfTnOeixaCUta+XxfBy5ZMu0t1OsDMxQJdmyDC7wxlQPDNoxzJ+ARSMHJ4cSbbjcE1ZIir2HleEeN2azdG1B8yGMfTlzsUDJiGRnIg+aXQX52wNQlxd/EelnEpE9L2uPClI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZHPJPU+D; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1YvrhE8TYy7MSDseUcEX6cz+zJ82RxWENHKzY8nEqT8=; b=ZHPJPU+D5hwpm4wgpiMkbWmAxe
	zXeC9sXfI+1FJnmhRYSQcLRzNzJM4biKq0RAhRlaWBiTbu7fVxyM62i/DPuAWZ/QapdcdXA13H69b
	5CgUBm7Ejn1AeJZHCANVRys0942eAYLDwkZRr5j2FULQtNrk9WDqEtlduc69/83QPIV+RoriSTIRQ
	a11icLFVn3uMaB36w7E2w9dfiPtrOUhmWSOIVakxOe4fyvcWea1lTxsw7JbE33cJ17IV3dcXJI4ok
	7embbdWMXspwSvH7rH0e7bQGxpMI4e3BHjN3f+XmScIEf0+vR5qC1i0YeHWWCM8KX8IKjNJK0o5Uu
	FaqJ+82g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBZ6-000000091se-2gk3;
	Fri, 12 Apr 2024 07:43:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4DD8A3004D5; Fri, 12 Apr 2024 09:43:16 +0200 (CEST)
Date: Fri, 12 Apr 2024 09:43:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: Re: [PATCH V6 3/6] sched/fair: Fair server interface
Message-ID: <20240412074316.GF30852@noisy.programming.kicks-ass.net>
References: <cover.1712337227.git.bristot@kernel.org>
 <1abba9e7f47ad4a5dfd8b2dfb59aa607983cdce4.1712337227.git.bristot@kernel.org>
 <20240411144327.GB40213@noisy.programming.kicks-ass.net>
 <e4efd69c-b155-4c13-99c3-9603f5769f93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4efd69c-b155-4c13-99c3-9603f5769f93@kernel.org>

On Thu, Apr 11, 2024 at 05:02:41PM +0200, Daniel Bristot de Oliveira wrote:
> On 4/11/24 16:43, Peter Zijlstra wrote:

> > The 'defer' thing is dubious though, I don't suppose anybody would ever
> > want to actually change that, other than you while poking around at this
> > code, right?
> 
> In a setup where all real-time tasks are DL (without fixed-priority tasks (FIFO/RR))
> the defer = 0 makes more sense because the bandwidth is reserved anyways, and the
> DL server would have a relatively low prio (long period).

Tell me more -- how is it better in that case? I would think it wouldn't
matter much.

