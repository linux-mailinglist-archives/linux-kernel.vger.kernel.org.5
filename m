Return-Path: <linux-kernel+bounces-140684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293B8A17B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0950A1F224C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CCD1862E;
	Thu, 11 Apr 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aVniZs3+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD717C60
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846621; cv=none; b=lAtWGf++MFFOVxbsqH7/5hAFSXBFBjU77OQfvaLPEYMKBvNBNDRV+ucGmv0ghAVjBN5iBR+Ru6hwzOMO4e0YwkQvcEytdm7OvA/xNLk+El6GvEgbmg5dbls0NLNPSPh9kpXfALxQGbkpPs32twsYa0JyL+u940zr6vR4L6xyzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846621; c=relaxed/simple;
	bh=gYeTtQfvKPxsXRKWox96oLZ05Hu2i+oxkyWXQLKUook=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cghG6IVnC0bZLBM9cwYWLZuIOFPTTpsyPNBkQOjgMS+kQ09cxK/STwf6LxL4mQ5+7xcdwltqQvIrbP4qNFtRulk18lyx8pNo+po3qe1RWVDKwi+a9npPSaBZJcJQnwzLTZBlmSZe2/Jlm8NSbYyzCyKGULNV94KDi6OY/liGKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aVniZs3+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qv1t8eFWmdekM+4JNneNzP5Db+pE1gAcLNcy+QQxoYY=; b=aVniZs3+gUkbfsGMO/2meZfM4z
	gkZIFVsDMsZXYwi4DYa+L9v4BpWrCXuAbvpagVtUtwo4ybzfiqQgrRyVPSoU4kH59D4kdFXYeKUMm
	xCZMYZ2gqEzasuW7/OsivRMUzokmMs5jhnTFzSdAyda+KFhyG9Kf4oXHG6HFon58yX3EqJ2ovO4ao
	YKyqrU7J+YewxWtYPBKBYmuYhgK9kvK6Pf/peE69engXbgQS2B2qgsrBRB7nBD+Jc3AzBfudxPlvZ
	Oq0ovrr2Pe++X4nPxKLUz3BhOFWme0ulrtrM+nHaaRS8uJhZSj29iXdZqBLCcqPRHoOwJ/vqpwu/C
	piraIPYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruveC-00000008fSy-1Am7;
	Thu, 11 Apr 2024 14:43:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E87E4300487; Thu, 11 Apr 2024 16:43:27 +0200 (CEST)
Date: Thu, 11 Apr 2024 16:43:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
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
Message-ID: <20240411144327.GB40213@noisy.programming.kicks-ass.net>
References: <cover.1712337227.git.bristot@kernel.org>
 <1abba9e7f47ad4a5dfd8b2dfb59aa607983cdce4.1712337227.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1abba9e7f47ad4a5dfd8b2dfb59aa607983cdce4.1712337227.git.bristot@kernel.org>

On Fri, Apr 05, 2024 at 07:28:02PM +0200, Daniel Bristot de Oliveira wrote:
> Add an interface for fair server setup on debugfs.
> 
> Each CPU has three files under /debug/sched/fair_server/cpu{ID}:
> 
>  - runtime: set runtime in ns
>  - period:  set period in ns
>  - defer:   on/off for the defer mechanism
> 
> This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to set
> bounds on admission control.
> 
> The interface also add the server to the dl bandwidth accounting.

I suppose most people will want to use it like:

  for i in /debug/sched/fair_server/cpu*
  do
	  echo $PERIOD > ${i}/period
	  ecoh $RUNTIME > ${i}/runtime
  done

And I think we agreed to keep this loop in userspace, but memory is
vague.

The 'defer' thing is dubious though, I don't suppose anybody would ever
want to actually change that, other than you while poking around at this
code, right?

