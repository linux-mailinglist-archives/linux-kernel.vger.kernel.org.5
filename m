Return-Path: <linux-kernel+bounces-141492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F2A8A1EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36441C233F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CD1401B;
	Thu, 11 Apr 2024 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuXWU9F/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EF134A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861593; cv=none; b=XETM665WhMXAVn2YZhuDpprZ1+El1KKU98wIebtl1MXz1XZqiFnxI7n37JCOEVdGA91KUekw3nvfRI9HuH4JI5mAXcaC/Nc7g6HpIqlxIHLwvByHHYzRH7FkZSSDExFyXDs8mSgPzCJiASsU2CWZ2EB8B5HnxNi0tmN752rSlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861593; c=relaxed/simple;
	bh=G/wFuE75kJPCnyn9PRHwIbpNnaCSkJbgx9CGgXcf9FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxDFfTh6VBWdQKUw/zX+fNy27gHvRCT4aa1NeUTRCSmdvwBlb2xI51pKYPi4ZUtF00/OEFMzLsm5CTEaDDnZAzyxdDBQZ75vpTTcyvnGtEj2hPze4rti5grZmcSRU0m2TIPZbfD3P+rni3Kk3umZJoib98iR6zYjSrta5mzGji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GuXWU9F/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so16785e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712861590; x=1713466390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LIX5a6E1i7fexWQlCRn4NOBQwVNtOheBQ3QgKVWs1g=;
        b=GuXWU9F/pA3yB0o+z5WJi1TNzi8rsGp65J3ABBiLZYW6fqQYXX986/GvPges5fGpts
         fxSilrY4vwymbB5LhKMMoqIwLHCYszOXkkQU/jpGrb/QxaJzLoNE5DnIwPagT6d69XNy
         1qdTCBSh6Q3ZjAJjXklV81eqDzMpFlpO4HGkT2kHQiSPq3WCpAKoBEPgvMWBbTPqEdmt
         nUEc8D9QnncKzqiOMd6VC7KKTlV1OXNCI2nWd3qj65pE1WRmpgAHrpLRzh5YB5XZXG2h
         +SjuVFmh+BUcUMkFokbh/FYO3PB9bgqQ/1RjCsY0+VWNzdJDQI1VywDVZmSjorhEPLtP
         A8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712861590; x=1713466390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LIX5a6E1i7fexWQlCRn4NOBQwVNtOheBQ3QgKVWs1g=;
        b=ikghzvNYMgtUzIDynDxtJMO7WGTuoc04nkPaerLBF6bVPjhCR89e+ARIbdk+WokT9s
         904rLmpuBLW6T81FAj3vHPUJn+zbTPtOoLTYBfURIuRuv7CIJw9WnxlilyIHEs6rj0N6
         mSGUmv5Ru9068tIidXk5Q7KM9Kk8KfF3E7ZhAmRYmdm1ek0nof5T8JuFGb4BnnuQc1DM
         9fr7AHy87Y8M2o86u8x41o2ZOWi98fBkVKKS0AG26YiWQofIfEO3XoWIc2pwZepUUiwx
         yVgA/XmxRgmniYQzzDxZ+ctVtcfF7VrcDQDfl4s75TefcUHXGYqYZRpBBw/se3bfE0OJ
         WpbA==
X-Gm-Message-State: AOJu0YyLMSfVA4qL0Rq2fLKtxYCWKUCzzCZUvmye5y48wXJ9tGWhjYGW
	A48rb9qT4xNM3QiLTEozYlndwHsI2hyu3zdtY7dK0YPtZq9YBqlg6C9hYGjtYZRjut1KTC041rf
	QBGnMkAfUZ+VrLcSj+bLpvxAck5WHa0QWqDI=
X-Google-Smtp-Source: AGHT+IEqfkg/WJeJH3rGbE5tKy9mP/1LUOvRu3pXtV0xM7l/e0Z9WS8/Fa+EPHoEgkhwtVMj9O+AwDkF8S6LJDBcLZc=
X-Received: by 2002:a05:600c:1c11:b0:416:6cca:c147 with SMTP id
 j17-20020a05600c1c1100b004166ccac147mr18842wms.4.1712861590189; Thu, 11 Apr
 2024 11:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401234439.834544-1-jstultz@google.com> <20240401234439.834544-2-jstultz@google.com>
 <xhsmhbk6ia52c.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhbk6ia52c.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: John Stultz <jstultz@google.com>
Date: Thu, 11 Apr 2024 11:52:57 -0700
Message-ID: <CANDhNCp0hOp9zmfnthFmFM13vGDMBf4TFYHPeRZ=69FjdQVc5w@mail.gmail.com>
Subject: Re: [RESEND][PATCH v9 1/7] locking/mutex: Remove wakeups from under mutex::wait_lock
To: Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:12=E2=80=AFAM Valentin Schneider <vschneid@redhat.=
com> wrote:
> On 01/04/24 16:44, John Stultz wrote:
> > @@ -934,6 +942,7 @@ static noinline void __sched __mutex_unlock_slowpat=
h(struct mutex *lock, unsigne
> >               }
> >       }
> >
> > +     preempt_disable();
> >       raw_spin_lock(&lock->wait_lock);
> >       debug_mutex_unlock(lock);
> >       if (!list_empty(&lock->wait_list)) {
> > @@ -952,8 +961,8 @@ static noinline void __sched __mutex_unlock_slowpat=
h(struct mutex *lock, unsigne
> >               __mutex_handoff(lock, next);
> >
>
> (minor nit) Could the preempt_disable() be moved here instead? IMO if it'=
s
> closer to the unlock it makes it clearer why it is there
> (e.g. sched/core.c::affine_move_task(), rt_mutex_setprio(), __sched_setsc=
heduler().
>
> >       raw_spin_unlock(&lock->wait_lock);
> > -
> >       wake_up_q(&wake_q);
> > +     preempt_enable();
> >  }

Heh. Comically, that's how it started, but I was earlier advised to switch =
it:
  https://lore.kernel.org/lkml/034a302d-773d-5bdb-a32b-bd283d6c7710@redhat.=
com/

I'm happy to go back if that's really preferred.  But the current
style also matches __mutex_lock_common's nesting.


> > @@ -1775,8 +1782,9 @@ static int __sched rt_mutex_slowlock(struct rt_mu=
tex_base *lock,
> >        * irqsave/restore variants.
> >        */
> >       raw_spin_lock_irqsave(&lock->wait_lock, flags);
> > -     ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state);
> > +     ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
> >       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> > +     wake_up_q(&wake_q);
>
> Shouldn't this also be wrapped in a preempt-disabled region?
>
> >       rt_mutex_post_schedule();
> >
> >       return ret;
>
> > @@ -122,6 +123,7 @@ static int __sched __rwbase_read_lock(struct rwbase=
_rt *rwb,
> >       if (!ret)
> >               atomic_inc(&rwb->readers);
> >       raw_spin_unlock_irq(&rtm->wait_lock);
> > +     wake_up_q(&wake_q);
>
> Same question wrt preemption.

Yeah, thanks for pointing out that inconsistency. I'll rework and test
with that.

thanks again for the review and feedback!
-john

