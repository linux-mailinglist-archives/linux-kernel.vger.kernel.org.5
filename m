Return-Path: <linux-kernel+bounces-159209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959EA8B2AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B910A1C21788
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FD1153812;
	Thu, 25 Apr 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pz4CWDRp"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11209155723
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080539; cv=none; b=gZjTmQlHiPVNvRUHOxEjcW2nbv2jSsWezmjTKeJ/HsXigvPXEbTeeivbjaDsePT2l7lZd6uE6VY8O4p//xV8ZcfQ2COL4lBaojxEMQ2qlS+hmjSkbbY78wZchwfaGkIIy1mmKz2KMVEDdz+5Qr3pryAtvmmd/fjsc6TtaRDoPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080539; c=relaxed/simple;
	bh=9jSpEdYa004FZK9qFbCHvGP08fb/ZcRrODOXMtJYP10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlKSIs3RVowXpYAU3wV1/+JiitZOD9kTfZTQA9Y/HDGXT/spxuyJ2EtkQkv24r7rUUxgMCRg0Ij2ywfGPsI8i7+lAxc1wAjmEtE4CnC3Cr5qSfY8y2uI6y1yQw2C8xGFL2tqOvkt9RNze/WZPfjUVvvKMFuOODH+qNIXpZ4n3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=pz4CWDRp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db13ca0363so23106991fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1714080535; x=1714685335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=worxA1pvOBzETE6ru+4nE/r4sL2lZnf/28s/MZcUJIE=;
        b=pz4CWDRp3uu2HuFk85IPAGft8u/aGzemt3y/ZCBw8HlqpNpXmdV1hJn3JkIbdtmcDu
         4wrnjVz7IqpqMK6uvHnWrAYTYb5AwcSh/E2HUN1i37QymskWxJ553PxzRGMJFZqKLo1t
         A7+MV4mwyVYYnHwN2x3f12VEIjN9D4juRbs78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080535; x=1714685335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=worxA1pvOBzETE6ru+4nE/r4sL2lZnf/28s/MZcUJIE=;
        b=K2S6OwqJFm/VAqN7oLJT2Fe/2xyh1S8wDh00F5QaTjTKj4Z2fUoG5DoWtqJ9EgnE0f
         YWExvn13u02Hqq+lnIRAWIMdXIzvJADDpQcy830p5JCOxoBGYiZB70ux+OU4riWkmx+D
         Mxj60ffzgNkNViFq86Y+697W5HD2nx/3YFuSF9wc3foDVRp8rSKISh+6xc0JWm3OPWRr
         dVm1tCm/tUlzut0/hgC5jj1D05MpVusHABlEVFYChg0b9TB3OE5utFsuAQgJ4EOMT+f0
         K5RkaNJVaSycLGxQbwIF1b8jBABfS4woqylJky9qGg6dbaqbauoAJocWWpRJY9pOGvo1
         xBbA==
X-Forwarded-Encrypted: i=1; AJvYcCWlNoGgcbHNoTRPeu285tEgakLUOxULLl3mEhYnoniKlUWMnriDLCXse7OE/2JtuWK1+vr5brvzInC3XRu/qiz5QkHd0YDtpAkSP++3
X-Gm-Message-State: AOJu0Yz8QECEwk0vCnw1SQPIkxfLqDSeUbCtZx3nW5gSpg+j7tu+xYSV
	IlYS9t5uzSzkvIfQCgLFjIPQBcrd/y+eb2VSs883qtsfam867+bY5RdvupjGVUbEruQt9SUG9sl
	ylYhZAa1nUlnUBZx3faP7T4Me9XCsFuZI9F4OIg==
X-Google-Smtp-Source: AGHT+IHaIK3YEoQ9riwqLhBdcM1GA+h2JOcJaGvfWSnc0sw5XqoKi6JS93ZzTHZQUDXxOjnkurTGbbwgIi+Fm4Tasds=
X-Received: by 2002:a05:651c:230c:b0:2d8:6ca7:2165 with SMTP id
 bi12-20020a05651c230c00b002d86ca72165mr383002ljb.46.1714080534673; Thu, 25
 Apr 2024 14:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111024835.2164816-1-tj@kernel.org> <20231111024835.2164816-13-tj@kernel.org>
 <20240323023732.GA162856@joelbox2> <Zf9Tz2wHT6KYtqEG@slm.duckdns.org>
In-Reply-To: <Zf9Tz2wHT6KYtqEG@slm.duckdns.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 25 Apr 2024 17:28:40 -0400
Message-ID: <CAEXW_YR02g=DetfwM98ZoveWEbGbGGfb1KAikcBeC=Pkvqf4OA@mail.gmail.com>
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	Andrea Righi <andrea.righi@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 6:12=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Joel.
>
> On Fri, Mar 22, 2024 at 10:37:32PM -0400, Joel Fernandes wrote:
> ...
> > I was wondering about the comment above related to 'wakeup_preempt', co=
uld
> > you clarify why it is not useful (NOOP) in the sched-ext class?
> >
> > wakeup_preempt() may be called via:
> > sched_ttwu_pending() ->
> >       ttwu_do_activate() ->
> >               wakeup_preempt()
> >
> >
> > at which point the enqueue of the task could have already happened via:
> >
> > sched_ttwu_pending() ->
> >       ttwu_do_activate() ->
> >               activate_task() ->
> >                       enqueue_task()
> >
> > But the comment above says "task isn't tied to the CPU" ?
>
> In sched_ext, a scheduling queue isn't tied to a particular CPU. For
> example, it's trivial to share a single global scheduling queue across th=
e
> whole system or any subset of CPUs. To support this behavior, tasks can b=
e
> hot-migrated in the dispatch path just before it starts executing:
>
>  https://github.com/sched-ext/sched_ext/blob/sched_ext/kernel/sched/ext.c=
#L1335
>
> So, the CPU picked by ops.select_cpu() in the enqueue path often doesn't
> determine the CPU the task is going to execute on. If the picked CPU matc=
hes
> the CPU the task is eventually going to run on, there's a small performan=
ce
> advantage as the later hot migration can be avoided.
>
> As the task isn't actually tied to the CPU being picked, it's a bit awkwa=
rd
> to ask "does this task preempt this CPU?" Instead, preemption is implemen=
ted
> by calling scx_bpf_kick_cpu() w/ SCX_KICK_PREEMPT or using the
> SCX_ENQ_PREEMPT flag from the enqueue path which allows preempting any CP=
U.
>

Got it. I took some time to look at it some more. Now I am wondering
why check_preempt_curr() has to be separately implemented for a class
and why the enqueue() handler of each class cannot take care of
preempting curr via setting resched flags.

The only reason I can see is that, activate_task() is not always
followed by a check_preempt_curr() and sometimes there is an
unconditional resched_curr() happening following the call to
activate_task().

But such issues don't affect sched_ext in its current form I guess.

Btw, if sched_ext were to be implemented as a higher priority class
above CFS [1], then check_preempt_curr() may preempt without even
calling the class's check_preempt_curr() :

void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
{
        if (p->sched_class =3D=3D rq->curr->sched_class)
                rq->curr->sched_class->check_preempt_curr(rq, p, flags);
        else if (sched_class_above(p->sched_class, rq->curr->sched_class))
                resched_curr(rq);

But if I understand, sched_ext is below CFS at the moment, so that
should not be an issue.

[1] By the way, now that I brought up the higher priority class thing,
I might as well discuss it here :-D :

One of my use cases is about scheduling high priority latency sensitive thr=
eads:
I think if sched_ext could have 2 classes, one lower than CFS and one
above CFS, that would be beneficial to those who want a gradual
transition to use scx, instead of switching all tasks to scx at once.

One reason is EAS (in CFS).  It may be beneficial for people to use
the existing EAS for everything but latency critical tasks (much like
how people use RT class for those). This is quite involved and
reimplementing EAS in BPF may be quite a project. Not that it
shouldn't be implemented that way, but EAS is about a decade old with
all kinds of energy modeling, math and what not. Having scx higher
than cfs alongside the lower one is less of an invasive approach than
switching everything on the system to scx.

Do you have any opinions on that? If it makes sense, I can work on
such an implementation.

Another reason for this is, general purpose systems run very varied
workloads, and big dramatic changes are likely to be reverted due to
power and performance regressions.  Hence, the request for a higher
scx, so that we (high priority task scx users) can take baby steps.

thanks,

 - Joel

