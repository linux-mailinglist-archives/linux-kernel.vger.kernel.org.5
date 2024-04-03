Return-Path: <linux-kernel+bounces-129857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA27897155
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9741C2467B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684414831F;
	Wed,  3 Apr 2024 13:40:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80060145B36
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151606; cv=none; b=nE7o6VPX6zIAFcdvtpfqMOjf6CzG41iv1VaduKMV8n9anUx3TQFDCglAuWDM2LRXnVUjui9YFlDPGzyOQvK2a2h0Jd4eKQMjfJ5SRanM3lizWFyvR6aiv0GTVKh37NQy9fkm8l7QOeTGNiRRfHFC2iYfCy+TZ+QrmsQGBuoffYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151606; c=relaxed/simple;
	bh=rZ8RKwrxusezQ6XtZmnAt0t/LoLT/TISBYJDEc/S8WY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FF8AWqZ+8fbJ6I30m2ok9AOhQ2GWXczqGm/ES+pQ9F7tvklSfz+yvqsIFYDYfS586yHFGSWe1bqZlb4FibvuV7hSz+IgNZlZ6IpzvORcjrU5tlmMwRm6NMw7+wO5sJbUP3SOSJwbZVsIi6+AgSesP2M8ILrLtqKgN7jJmUx9Bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8DCC43390;
	Wed,  3 Apr 2024 13:40:04 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:42:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, Joel
 Fernandes <joel@joelfernandes.org>, John Stultz <jstultz@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org,
 Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240403094224.105fdef0@gandalf.local.home>
In-Reply-To: <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
References: <20240403005930.1587032-1-qyousef@layalina.io>
	<CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 15:11:06 +0200
Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Wed, 3 Apr 2024 at 02:59, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > For fair tasks inheriting the priority (nice) without reweighting is
> > a NOP as the task's share won't change.  
> 
> AFAICT, there is no nice priority inheritance with rt_mutex; All nice
> tasks are sorted with the same "default prio" in the rb waiter tree.
> This means that the rt top waiter is not the cfs with highest prio but
> the 1st cfs waiting for the mutex.

I think the issue here is that the running process doesn't update its
weight and if there are other tasks that are not contending on this mutex,
they can still starve the lock owner.

IIUC (it's been ages since I looked at the code), high nice values (low
priority) turn to at lease nice 0 when they are "boosted". It doesn't
improve their chances of getting the lock though.

> 
> >
> > This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
> > with low priority values are susceptible to starvation leading to PI
> > like impact on lock contention.
> >
> > The logic in rt_mutex will reset these low priority fair tasks into nice
> > 0, but without the additional reweight operation to actually update the
> > weights, it doesn't have the desired impact of boosting them to allow
> > them to run sooner/longer to release the lock.
> >
> > Apply the reweight for fair_policy() tasks to achieve the desired boost
> > for those low nice values tasks. Note that boost here means resetting
> > their nice to 0; as this is what the current logic does for fair tasks.  
> 
> But you can at the opposite decrease the cfs prio of a task
> and even worse with the comment :
> /* XXX used to be waiter->prio, not waiter->task->prio */
> 
> we use the prio of the top cfs waiter (ie the one waiting for the
> lock) not the default 0 so it can be anything in the range [-20:19]
> 
> Then, a task with low prio (i.e. nice > 0) can get a prio boost even
> if this task and the waiter are low priority tasks


Yeah, I'm all confused to exactly how the inheritance works with
SCHED_OTHER. I know John Stultz worked on this for a bit recently. He's
Cc'ed. But may not be paying attention ;-)

-- Steve

