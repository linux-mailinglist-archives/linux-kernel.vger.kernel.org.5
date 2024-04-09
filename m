Return-Path: <linux-kernel+bounces-136565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52389D591
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67820B2400D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E17F7D5;
	Tue,  9 Apr 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZDM6A0+i"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AE7E774
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654878; cv=none; b=U5XxH6c7fkGizqz8KKy/qQWVuQ0zacQZpJH9ILM7cj2YHgcw2BCaUrewudFoWf7PRboAaOdQS+JuXr3DqODBXHK3yRsu/sjZCDD31VSIT96xRRP5cmLFMIQRCCvNff4FGIQozqUn/j8jK+aqjZNKtjd9Tj0QcidvEaH4vWi4kAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654878; c=relaxed/simple;
	bh=ZrJn5rLnT+JCbS97fpbkz18bOihhjAaBly7S2GsFo3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YANF1bJ+wrEGLMR4BxvchyHkpRoHSeuFOjpPlSf0IsLFUgiqxD6S0926dyIW20yuorpZj+IsjDAaF4dJ7vYAQFdNCCfbImnGeG//V7PKfbxChkYMdgZTifRYgGuf+rZ/3TxyWSG3YnUoPIV55iIVeV9u3hqcj6tVsqsZ7FD+aW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZDM6A0+i; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eM8TFlhQwm3BI0r2noLJtAUcd0kSaO4TRLYAU10VTPk=; b=ZDM6A0+iSwIClxWfTXAvtxyFHU
	4qjm5ACkC/UDHPahIKjnUyJ44YCRzD3Be0Eu8+JseeP/F1PmEGcUJ68qEde6C9jlWKd8m2jwhfZzZ
	THF2xcVsSyuBigBkagzlNLxnCX0+jvFM3jJw7WtTEeOYDsGjn963U6ZXPwZ8iaM9kchQyPgEwcQkV
	CRn1ouekiDdzogq9szEkv0ii04xN+YCKSndSAZjFHzxFI5Gm9ruO4jQ489vzQRD0lKkkMwmxLSc0i
	bijKqjFVnkBJZiRAK7B3E4LUJ2LEpf/n7dWMz0ROPOuJgjX1wkuqHL2BX9LJjuFUB1qWoU/vcxAVT
	YRVcIXuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7le-00000007Wi6-1vuT;
	Tue, 09 Apr 2024 09:27:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C72030040C; Tue,  9 Apr 2024 11:27:50 +0200 (CEST)
Date: Tue, 9 Apr 2024 11:27:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/5] sched/fair: Rename set_next_buddy() to
 set_next_pick()
Message-ID: <20240409092749.GC2665@noisy.programming.kicks-ass.net>
References: <20240407084319.1462211-1-mingo@kernel.org>
 <20240407084319.1462211-6-mingo@kernel.org>
 <20240408091605.GE21904@noisy.programming.kicks-ass.net>
 <ZhT9O6yd868GuAxr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhT9O6yd868GuAxr@gmail.com>

On Tue, Apr 09, 2024 at 10:32:59AM +0200, Ingo Molnar wrote:

> I don't think we want to nuke it - there's 3 users:
> 
>  - yield()
>  - CFS bandwidth
>  - wakeup
> 
> I think the yield() and CFS bandwidth ones are genuine, but non-working due 
> to NEXT_BUDDY at 0. Wakeup was the original intended NEXT_BUDDY logic, but 
> it got turned off due to some performance or latency considerations that 
> might or might not be valid & relevant today.
> 
> 2)
> 
> Even the task_hot() use of ->next isn't spurious: if a task has been marked 
> as run-next, then presumably the current task is descheduling and we should 
> probably not tear its ->next away in load-balancing.
> 
> 3)
> 
> Side note: a set rq->next should probably reduce a candidate runqueue's 
> weight both in periodic load-balancing and in idle-balancing, by rq->curr's 
> weight or so?
> 
> So what I think we should do is to keep ->next and fix all its intended 
> uses, and make it all unconditional by removing both NEXT_BUDDY and 
> CACHE_HOT_BUDDY. I can cook up a series if you agree in principle.

So yes on fixing those yield_to() and cfs_bandwidth thingies, but put
then under a new knob -- if the fix regresses we can simply flip it.

Ack on removing the current knobs, for them not having been changed in
forever.

