Return-Path: <linux-kernel+bounces-89311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31886EE24
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C5228710F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC99BA45;
	Sat,  2 Mar 2024 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ndJiAJi0"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8821749F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709346274; cv=none; b=ifpfUGIQUIMmdPKZKWafq/xXaPLfZqxnQHPJV8NY6QwDekG/5/LgFSrDiQgsYKdyj5qj0SGKtkR5en9JNzdyx4LEhhHtnOlWFet45crVq6I8dHv1nz4UAC+KAjDBtq4897kHGCwjKc0l0GgB2gbWfA313vUciu5TFWCDAzzkNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709346274; c=relaxed/simple;
	bh=ZbRjRfGgsE7JtMXZ7+GBMuqAIJuCRArBk/R4UQi4fa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5QnDjFncTZNW/aIoqBT4sN6xsqa7GzIe2ho7VUl58gcECrvx66v05Hn0FajTCmZVrt3NV4hll1nYyYuFiCbjOPrvGmpt8EB9pDwcCUKRaZNf1951pIhJqkmX1YEDqgyfhNMJ/CETvX/wCPDTqSDm1t6HPYQAfcI+j+pJoZhSH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=ndJiAJi0; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d1094b5568so30981581fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 18:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709346271; x=1709951071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BPRTmka5fJv1/6kKHd7XoCtkBtwYqpJPZBGmWQG3Mo=;
        b=ndJiAJi0ZLdzKkVqWLckKAG83dKa+i7ZKFjdJe0u7P+lBwSBg8A9ySV49jg0W+LXCr
         jhS0IXEegG6x7obSBiB1C5eX0qcVW2NRK7Su0qxhn4iLl1Oix6ukPLVDGNtc5XPDXyrU
         qgvwY52pPfR9IhbMgXGZvX+1Cn5WkakYmhBQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709346271; x=1709951071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BPRTmka5fJv1/6kKHd7XoCtkBtwYqpJPZBGmWQG3Mo=;
        b=ZsKB7pNX+ifdoHAwNKhbEjCzeIFk3KsIs344bDJSRiES8eX5f3EHwPD/lqS46SgBqg
         PzoMxo2U+ZKvw/5IaEKTTI2oRVfIkAIC9AajqfcBlpCW4L5/J6cwL662MrkOnHDy9VWN
         TcMgzJOj1KtDZa3o3PCx/gOML9TcQ9POPxSS3p5/b89KBW/K0N8PijWEYKV49d1I6jhq
         0duvWzyX5NgjwxFGyuJ0NGbXpOpBwNbRnZfh063/GZ6TRiC2pGC5Q8YRUreIFBuIAYxK
         raXWacRUtKnmKkxim0kZJShYNCJzcg3ZA3bPQQH8kgVybAISj1cSIbiug/PnJC9M6N1z
         zz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU9BeZIQdR4moAyxu3sJ/whjoImKaIJwjELbzZFyoq7WZKXg5cUAs9joePav/CxLPZTUhYVjSTHwWsZ6zJX+xa2tnp6CJ2uZqWHwmb
X-Gm-Message-State: AOJu0YynlLSWN0NVvKGn+nZ/AOUTZG/vwojHNJXihKVu+KW+CEaLamAB
	yG8YNMiDS5QBeboPUF/J3YIUOBEMlpP5g3cWNsN2CAxGBP3Qh/j/HV6QgU5zOWuL/HKTRcN01tm
	u88sqrUvVjuKCFZ56pEfZaxYUH6Jl2PR1TYUDRA==
X-Google-Smtp-Source: AGHT+IH98YLZnMxBAG59okgQ+PyTSyL2rsPj7i9rV8TY6srfxIhgylxvaw0NdCb2O9sVvrFMBArv71G6Pgzuxs54Gso=
X-Received: by 2002:a2e:a688:0:b0:2d2:a9d6:c435 with SMTP id
 q8-20020a2ea688000000b002d2a9d6c435mr2033116lje.34.1709346270566; Fri, 01 Mar
 2024 18:24:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org> <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
In-Reply-To: <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 1 Mar 2024 21:24:15 -0500
Message-ID: <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Shrinking CC a bit)

On Thu, Feb 29, 2024 at 1:29=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Feb 29, 2024 at 12:41:55PM -0500, Joel Fernandes wrote:
> > > On Feb 29, 2024, at 11:57=E2=80=AFAM, Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > > =EF=BB=BFOn Thu, Feb 29, 2024 at 09:21:48AM -0500, Joel Fernandes wro=
te:
> > >>> On 2/28/2024 5:58 PM, Paul E. McKenney wrote:
> > >>> On Wed, Feb 28, 2024 at 02:48:44PM -0800, Alexei Starovoitov wrote:
> > >>>> On Wed, Feb 28, 2024 at 2:31=E2=80=AFPM Steven Rostedt <rostedt@go=
odmis.org> wrote:
> > >>>>>
> > >>>>> On Wed, 28 Feb 2024 14:19:11 -0800
> > >>>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >>>>>
> > >>>>>>>>
> > >>>>>>>> Well, to your initial point, cond_resched() does eventually in=
voke
> > >>>>>>>> preempt_schedule_common(), so you are quite correct that as fa=
r as
> > >>>>>>>> Tasks RCU is concerned, cond_resched() is not a quiescent stat=
e.
> > >>>>>>>
> > >>>>>>> Thanks for confirming. :-)
> > >>>>>>
> > >>>>>> However, given that the current Tasks RCU use cases wait for tra=
mpolines
> > >>>>>> to be evacuated, Tasks RCU could make the choice that cond_resch=
ed()
> > >>>>>> be a quiescent state, for example, by adjusting rcu_all_qs() and
> > >>>>>> .rcu_urgent_qs accordingly.
> > >>>>>>
> > >>>>>> But this seems less pressing given the chance that cond_resched(=
) might
> > >>>>>> go away in favor of lazy preemption.
> > >>>>>
> > >>>>> Although cond_resched() is technically a "preemption point" and n=
ot truly a
> > >>>>> voluntary schedule, I would be happy to state that it's not allow=
ed to be
> > >>>>> called from trampolines, or their callbacks. Now the question is,=
 does BPF
> > >>>>> programs ever call cond_resched()? I don't think they do.
> > >>>>>
> > >>>>> [ Added Alexei ]
> > >>>>
> > >>>> I'm a bit lost in this thread :)
> > >>>> Just answering the above question.
> > >>>> bpf progs never call cond_resched() directly.
> > >>>> But there are sleepable (aka faultable) bpf progs that
> > >>>> can call some helper or kfunc that may call cond_resched()
> > >>>> in some path.
> > >>>> sleepable bpf progs are protected by rcu_tasks_trace.
> > >>>> That's a very different one vs rcu_tasks.
> > >>>
> > >>> Suppose that the various cond_resched() invocations scattered throu=
ghout
> > >>> the kernel acted as RCU Tasks quiescent states, so that as soon as =
a
> > >>> given task executed a cond_resched(), synchronize_rcu_tasks() might
> > >>> return or call_rcu_tasks() might invoke its callback.
> > >>>
> > >>> Would that cause BPF any trouble?
> > >>>
> > >>> My guess is "no", because it looks like BPF is using RCU Tasks (as =
you
> > >>> say, as opposed to RCU Tasks Trace) only to wait for execution to l=
eave a
> > >>> trampoline.  But I trust you much more than I trust myself on this =
topic!
> > >>
> > >> But it uses RCU Tasks Trace as well (for sleepable bpf programs), no=
t just
> > >> Tasks? Looks like that's what Alexei said above as well, and I confi=
rmed it in
> > >> bpf/trampoline.c
> > >>
> > >>        /* The trampoline without fexit and fmod_ret progs doesn't ca=
ll original
> > >>         * function and doesn't use percpu_ref.
> > >>         * Use call_rcu_tasks_trace() to wait for sleepable progs to =
finish.
> > >>         * Then use call_rcu_tasks() to wait for the rest of trampoli=
ne asm
> > >>         * and normal progs.
> > >>         */
> > >>        call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_task=
s);
> > >>
> > >> The code comment says it uses both.
> > >
> > > BPF does quite a few interesting things with these.
> > >
> > > But would you like to look at the update-side uses of RCU Tasks Rude
> > > to see if lazy preemption affects them?  I don't believe that there
> > > are any problems here, but we do need to check.
> >
> > Sure I will be happy to. I am planning look at it in detail over the 3 =
day weekend. Too much fun! ;-)
>
> Thank you, and looking forward to seeing what you come up with!
>
> The canonical concern would be that someone somewhere is using either
> call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() to wait for
> non-preemptible regions of code that does not account for the possibility
> of preemption in CONFIG_PREEMPT_NONE or PREEMPT_PREEMPT_VOLUNTARY kernels=
.
>
> I *think* that these are used only to handle the possibility
> of tracepoints on functions on the entry/exit path and on the
> RCU-not-watching portions of the idle loop.  If so, then there is no
> difference in behavior for lazy preemption.  But who knows?

Hi Paul, regarding CONFIG_PREEMPT_AUTO, for Tasks RCU rude, I think
the following patch will address your concern about quiescent states
on CPUs spinning away in kernel mode:

"sched/fair: handle tick expiry under lazy preemption"
Link: https://lore.kernel.org/all/20240213055554.1802415-24-ankur.a.arora@o=
racle.com/

In this patch Ankur makes sure that the scheduling-clock interrupt
will reschedule the CPU after a tick and not let queued tasks starve
due to lazy re-scheduling. So my impression is the
"schedule_on_each_cpu()" should schedule a worker thread in time to
apply the implied Tasks RCU quiescent state even if the rescheduling
was a LAZY-reschedule.

Also, not sure if the "voluntary mode" of CONFIG_PREEMPT_AUTO behaves
differently. My feeling is regardless of preemption mode,
CONFIG_PREEMPT_AUTO should always preempt after a tick if something
else needs to run. It just will not preempt immediately like before
(although CFS did already have some wakeup preemption logic to slow it
down a bit). I am reviewing Ankur's patches more to confirm that and
also reviewing his patches more to see how it could affect.

thanks,

 - Joel

