Return-Path: <linux-kernel+bounces-134879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818D089B82B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C941C2188D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9B29409;
	Mon,  8 Apr 2024 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McDUH0wr"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707828DC1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560499; cv=none; b=LHlNnCiJTFUARORAnZKFJpqgqUKojU7C+y82Kl9ulK39NYPNqemw07wwMka+WZAX9m+m1etv/3U5MLOJGQ5FamtA0qEJYcxp61WjNi9PR0dQcqel1z8GL9q7CgJWkVzqh4dNT6/olW3+6NzjTEmzwNih6miiTIDQIIJrVv60qT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560499; c=relaxed/simple;
	bh=C2xhL0nI23QjPQklQsKuF/VubFAsgzG7gnv/H3QRaQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcGMnhKmAXBXdXUmKVt5gMVmcR7QedYsTWDhkw29eibTdbvOsPuQL/+zZtKnUmmRu7j7wQAqLgQx/6CDo29WMYPXjEO/jOTh4sebyG1SpBu5je4kJEiWXVt6q13yMf4TH+8DxbAy7cNTzaDVrJ1nL3ctMlsTWEKSSoifFno2UFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=McDUH0wr; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3180423a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712560497; x=1713165297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Raaf3+85+lHTOV/l8VlFH54Y4HifOW4cP581Tiah58A=;
        b=McDUH0wrWldbFPsI7H24ykCcHSoAcCwcPpHWsKk5TjaeEfRTod98H+pMvjbEzJigk7
         G985THMcCpT1us5mMroACka14H6t7i2hfD37dpU55Q9QuX2561W19HCuF0SA8ejS5l5N
         2KqW7MnBPW8k2E2UlJ4d7NndukoNvtyv/KOZGte0gOplmA3eniET8Rc/H+EpdET8/9+k
         duoD3TNkAPV79HThXz6XKCUpcKf6OtHKQ0/Bu8ElawnFb1W9qe31SmOWi/MHmEsEs8PY
         BI5S4nkTwwLkmUZkbv/pMwy9OVIJhwEaCdYG/o/z0tfXbJHHg1/xildqt4cyKRnpGYOR
         VTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712560497; x=1713165297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Raaf3+85+lHTOV/l8VlFH54Y4HifOW4cP581Tiah58A=;
        b=J0fYyd+h1FNUMLXHXnylie/B0+fsowfAgPs7459Xi79ERXOg5DlQ7PN1m1vTnzFcfh
         QVCHoq7WjI9Lf6XniE86oxNCJW7J+UWHwoCXC8NFxICZpoibQEC8hHxgJ6JL9XvNJ3tu
         yO3hJDCstAPmOGjRtsl8OC3FsxEY2J5jpe9VDTmTNtYs5Ne+LOvwPm//dJiwn/2lulak
         fxsQnY5REhh8WcRm3TBA8eDFd+sIpRvWOB2G0sLMMh1RYuo2qtmCduDcFkY4voaQmpWi
         VTraV/HePUhNPIWrrk+bpG7RLOfRLFDCij9k88S9ddoQw1oh4p9o+S9zw5bRoyblEMLf
         Oqbg==
X-Forwarded-Encrypted: i=1; AJvYcCWl3xOuvUrvYSAYesdiw+/jrpJOC2Nujrwv/Jfz51vpmKJBaWoOzf4e84/aBjJQPE6HoOqsPkKg6VMdeatrS/HbvmQ8bmXWawi5Zj0N
X-Gm-Message-State: AOJu0YwxnHF7iWkYWx4zo0IxvC4tF2Ns6x+6YRlYsp53yCLQpimsodcz
	cqxt2790xK1l3UPYrxch3dQ+OAm/aW05hIDt5AG9YyhfGinLohLsTXOY60ITD5gc0JIWUD0dRlI
	5vPYxmzXewoPgvoFKUxPU80/tOxktFx28JQikig==
X-Google-Smtp-Source: AGHT+IHvZobSCyEEjgJaLd9q6CHlKfzTREVwg+AeG24Frt11z1635zSMOJh+VqzPj92a+Xt5pPyqh+8dAlohONZn2eY=
X-Received: by 2002:a17:902:d486:b0:1e3:e87b:423f with SMTP id
 c6-20020a170902d48600b001e3e87b423fmr4225323plg.65.1712560497500; Mon, 08 Apr
 2024 00:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403005930.1587032-1-qyousef@layalina.io> <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240404220500.dmfl2krll37znbi5@airbuntu> <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu>
In-Reply-To: <20240405171653.boxbylrdak5fopjv@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Apr 2024 09:14:46 +0200
Message-ID: <CAKfTPtAKV0B5VUizN=ks_u1DZBkYm9VFSk2PttUfbBNm_OnxJQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	John Stultz <jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 19:16, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 04/05/24 14:15, Vincent Guittot wrote:
> > On Fri, 5 Apr 2024 at 00:05, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 04/03/24 15:11, Vincent Guittot wrote:
> > > > On Wed, 3 Apr 2024 at 02:59, Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > For fair tasks inheriting the priority (nice) without reweighting is
> > > > > a NOP as the task's share won't change.
> > > >
> > > > AFAICT, there is no nice priority inheritance with rt_mutex; All nice
> > >
> > > Hmm from what I see there is
> > >
> > > > tasks are sorted with the same "default prio" in the rb waiter tree.
> > > > This means that the rt top waiter is not the cfs with highest prio but
> > > > the 1st cfs waiting for the mutex.
> > >
> > > This is about the order on which tasks contending for the lock more than the
> > > effective priority the task holding the lock should run at though, no?
> >
> > No, they are ordered by priority in the rb tree so you can get the
> > priority of the top waiter and apply it to the owner of the lock
>
> I think I see what you're getting at now. There's no guarantee the top waiter
> is the higher priority fair task. Yes.
>
> >
> > >
> > > >
> > > > >
> > > > > This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
> > > > > with low priority values are susceptible to starvation leading to PI
> > > > > like impact on lock contention.
> > > > >
> > > > > The logic in rt_mutex will reset these low priority fair tasks into nice
> > > > > 0, but without the additional reweight operation to actually update the
> > > > > weights, it doesn't have the desired impact of boosting them to allow
> > > > > them to run sooner/longer to release the lock.
> > > > >
> > > > > Apply the reweight for fair_policy() tasks to achieve the desired boost
> > > > > for those low nice values tasks. Note that boost here means resetting
> > > > > their nice to 0; as this is what the current logic does for fair tasks.
> > > >
> > > > But you can at the opposite decrease the cfs prio of a task
> > > > and even worse with the comment :
> > > > /* XXX used to be waiter->prio, not waiter->task->prio */
> > > >
> > > > we use the prio of the top cfs waiter (ie the one waiting for the
> > > > lock) not the default 0 so it can be anything in the range [-20:19]
> > > >
> > > > Then, a task with low prio (i.e. nice > 0) can get a prio boost even
> > > > if this task and the waiter are low priority tasks
> > >
> > > I don't see this effect. The only change I am doing here
> > > is that when we set the prio that we are supposed to be inheriting, instead of
> > > simply changing prio, I also ensure we reweight so that we run at the inherited
> > > nice value. I am not changing how the waiter logic works.
> >
> > But if you look more deeply in the code, you will see that all cfs are
> > sorted with the same default prio so cfs tasks are not sorted and are
> > considered to be the same.
>
> Yes I saw that. We can potentially revert 715f7f9ece46 ("locking/rtmutex:
> Squash !RT tasks to DEFAULT_PRIO") ;-)
>
> /hides
>
> >
> > All that to say that I think the weight is not applied on purpose.
> > This might work for your particular case but there are more changes to
> > be done if you want to apply prio inheritance between cfs tasks.
> >
> > As an example, what about the impact of cgroup on the actual weight
> > and the inherited priority of a task ? If the owner and the waiter
> > don't belong to the same cgroup their own prio is meaningless... task
> > nice -20 in a group with a weight equal to nice 19 vs a task nice 19
> > in a group with a weight equals to nice -20
>
> That is on my mind actually. But I thought it's a separate problem. That has to
> do with how we calculate the effective priority of the pi_task. And probably
> the sorting order to if we agree we need to revert the above. If that is done
> appropriately, I hope the current reweight approach could be used as-is. Hmm
> but but as I write this I realize the compound weight will still be different.
> Maybe we should inherit the weight rather than the prio, which IIUC should
> already be the effective weight taking cgroup into account?
>
> Just to put it out on the clear, you don't think the issue is wrong, but just
> that we need to look further for a proper fix, right? ie: it is a problem we
> should fix, but we need to nail down more details IIUC.

Yes, I agree about your problem but your current proposal is not
correct because there are more things to consider and fix

>
> If that's the case it'd be good to know what else beside sorting order and
> handling cgroup I need to take into account to make this more correct.
>
> There's the obvious SCHED_IDLE case of course that needs a policy promotion,
> beside weight adjustment.
>
> >
> >
> > >
> > > Here's my test app FWIW
> > >
> > >         https://github.com/qais-yousef/pi_test
> > >
> > > When I run
> > >
> > >         pi_test --lp-nice 0 --lp-nice 10
> > >
> > > the lp thread runs at 0 still
> > >
> > > If I do
> > >
> > >         pi_test --lp-nice 10 --lp-nice 5
> > >
> > > low priority thread runs at 5
> > >
> > > What combination are you worried about? I can give it a try. I use
> > > sched-analyzer-pp [1] to see the division of runnable/running or you can
> > > monitor them on top
> > >
> > >         #!/bin/bash
> > >         set -eux
> > >
> > >         sudo sched-analyzer &
> > >
> > >         ./pi_test --lp-nice ${1:-10} --hp-nice ${2:-0} --affine-cpu ${3:-0} &
> > >
> > >         sleep 10
> > >
> > >         pkill -SIGKILL pi_test
> > >
> > >         sudo pkill -SIGINT sched-analyzer
> > >
> > >         sched-analyzer-pp --sched-states pi_test sched-analyzer.perfetto-trace
> > >
> > > Picutres of output is attached for before and after
> > >
> > >         pi_test --lp-nice 10 --hp-nice 0
> > >
> > > [1] https://github.com/qais-yousef/sched-analyzer

