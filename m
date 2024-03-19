Return-Path: <linux-kernel+bounces-106926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7F87F580
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676281F2211A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70017BAF7;
	Tue, 19 Mar 2024 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="O9PcIsVU"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D77B3F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815996; cv=none; b=pKljE1l7sXRu+HyTV5j9/Krld8N1PRSJmkvhqPHE3tr/VkgxeL8PgHA2fa4p2SGhwFT4HeDnYqm4kntumvN3tXcVAgJ9dP9d26BpM3DB1pwbult1jMgRKq0YP2ysvPXp4RxkD4SLxUxL63a7aQ/VR3xThBtWA1RVdXiZtITnXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815996; c=relaxed/simple;
	bh=8QoXSEm31MtGdn+MSEJmwxksvUcR3ZoTjZ8J0ChYpB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwVmi/3p0TDxwGcqutmrRODqskLZqwk07ol73XNQTA+jqC4PkJWSkbLfocq2w30B9c8OJ91Z3fiu2skMSWJ3Htap/T+pyydJ3Ev1cpu4dNQMbgnyAfzjyZMdNgrYupmjUs0NXDgbKWW00bRRqRkpFqAkLe3RqTpPqF/LfkMBDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=O9PcIsVU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so7407856a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710815993; x=1711420793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeX+LTwD9WxbRtGgUoz+Zy2vkpmlwUIv1l9IuZGj3fY=;
        b=O9PcIsVU2FLQ0f0+jP95syE1l8lMZifYXSM5jYJpT6/8borPSCutpk/SolXPGI42G/
         l/E0wqzQ/I4ozLu/U85ElHyL9NVcOhCBpFTkb0GPhLMv5f6buyQbbAgRDeApbo9di7nJ
         HCaQvBcLN2851/CcVIAflKpAFJvTYk46YMvnA4f8qaOTocTFk45yulPi6k64SwLxYVAp
         2WuBJ0ktfDI9ZfN8c0s9JT8DqpcDXdYG4TEgUq9HZPmQkUd1FgHsDhv7UTgpUy+a+6lP
         8jBpIyVELJa2anr7q3SRQeJklyVMmIavtsSAYB5ywse3vMO5bMpfHQkYhfHVWFOBFdrk
         IWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710815993; x=1711420793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeX+LTwD9WxbRtGgUoz+Zy2vkpmlwUIv1l9IuZGj3fY=;
        b=rl6Rfp/vpSC/PcSa1I+ZJ3MAoajUUL1mzbF1iNt7q0Ewep6QGPnNT7vwu0TT9u2kkL
         oJDj4IFeR/T/MQK1T3qepq2avJPkntI3h5vjgjEYV2xsbhrl1Xl/bGJk8WtoHv+jfWP2
         xW3BGKIcF3T0pglFXX9v9DufCXhIXkhqKt6SWuTDPk4OBwQlPVxD8ZhVX+BVvsgN92Wu
         F79izf71VC0ANWeqFQo7fbuqrL5jd7lqOYCJHMPLv2jfXjT9xtBb+JEJh2dJNcI22rwf
         ceUO0Wg9Ac0bsh18Q+tdGN+p0kccd3sdvXNuIqXhvFAif/9MPAttP1mX1Uf8VB1HyZlJ
         wdcw==
X-Forwarded-Encrypted: i=1; AJvYcCWUu7B5ppoyVy8P9y9vzJMrQwma/vBqk/5cHYLa1p2V09RW69L+q79LlVEHylBbvvnpWtozRlJL+Mi2nEXF/92OnnHUEbdixcL3ySrH
X-Gm-Message-State: AOJu0YzaCXeIR7cKPoO6qzhQ9G5A8BX0mepXjf4LIHH3Iopk+LqpwlGr
	TmnZ4/X5vtyuueYoqIkWSsclb39h92OeCdrdaD1Lr8qyT97cn1m6b7pN8R1JfwKvnQmjCuoBtkI
	KDwiY7o1m+scY+zXue0ZKo/umutMDA1nEkWDF+Q==
X-Google-Smtp-Source: AGHT+IEarWSrU9kPysuNRWZYBqj2CweoN+Wd66G3E6MHg2KIDu//l5cc1cXWz6AW7X2NByfYc5k7tCSv9TaDlE4EOF8=
X-Received: by 2002:a17:907:8e9a:b0:a46:5f6c:e04b with SMTP id
 tx26-20020a1709078e9a00b00a465f6ce04bmr11272764ejc.52.1710815993004; Mon, 18
 Mar 2024 19:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710525524.git.yan@cloudflare.com> <491d3af6c7d66dfb3b60b2f210f38e843dfe6ed2.1710525524.git.yan@cloudflare.com>
 <790ce7e7-a8fd-4d28-aaf3-1b991a898be2@paulmck-laptop> <ZfgecVqd6p-ACSZ5@FVFF77S0Q05N>
 <CAO3-Pbp6fCayWeJ11U6JtqHn-Rs3OFXoZ9uMohUefSYUvSGUKA@mail.gmail.com>
In-Reply-To: <CAO3-Pbp6fCayWeJ11U6JtqHn-Rs3OFXoZ9uMohUefSYUvSGUKA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 18 Mar 2024 21:39:42 -0500
Message-ID: <CAO3-PbrssUurD5dpMjxNduYhUj8dAikuwOHgZDn78o+Jqv_dBA@mail.gmail.com>
Subject: Re: [PATCH v4 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	Toke Hoiland-Jorgensen <toke@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 9:32=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> On Mon, Mar 18, 2024 at 5:59=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > On Fri, Mar 15, 2024 at 10:40:56PM -0700, Paul E. McKenney wrote:
> > > On Fri, Mar 15, 2024 at 12:55:03PM -0700, Yan Zhai wrote:
> > > > There are several scenario in network processing that can run
> > > > extensively under heavy traffic. In such situation, RCU synchroniza=
tion
> > > > might not observe desired quiescent states for indefinitely long pe=
riod.
> > > > Create a helper to safely raise the desired RCU quiescent states fo=
r
> > > > such scenario.
> > > >
> > > > Currently the frequency is locked at HZ/10, i.e. 100ms, which is
> > > > sufficient to address existing problems around RCU tasks. It's uncl=
ear
> > > > yet if there is any future scenario for it to be further tuned down=
.
> > >
> > > I suggest something like the following for the commit log:
> > >
> > > ---------------------------------------------------------------------=
---
> > >
> > > When under heavy load, network processing can run CPU-bound for many =
tens
> > > of seconds.  Even in preemptible kernels, this can block RCU Tasks gr=
ace
> > > periods, which can cause trace-event removal to take more than a minu=
te,
> > > which is unacceptably long.
> > >
> > > This commit therefore creates a new helper function that passes
> > > through both RCU and RCU-Tasks quiescent states every 100 millisecond=
s.
> > > This hard-coded value suffices for current workloads.
> >
> > FWIW, this sounds good to me.
> >
> > >
> > > ---------------------------------------------------------------------=
---
> > >
> > > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > > > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > > > ---
> > > > v3->v4: comment fixup
> > > >
> > > > ---
> > > >  include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
> > > >  1 file changed, 24 insertions(+)
> > > >
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 0746b1b0b663..da224706323e 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -247,6 +247,30 @@ do { \
> > > >     cond_resched(); \
> > > >  } while (0)
> > > >
> > > > +/**
> > > > + * rcu_softirq_qs_periodic - Periodically report consolidated quie=
scent states
> > > > + * @old_ts: last jiffies when QS was reported. Might be modified i=
n the macro.
> > > > + *
> > > > + * This helper is for network processing in non-RT kernels, where =
there could
> > > > + * be busy polling threads that block RCU synchronization indefini=
tely.  In
> > > > + * such context, simply calling cond_resched is insufficient, so g=
ive it a
> > > > + * stronger push to eliminate all potential blockage of all RCU ty=
pes.
> > > > + *
> > > > + * NOTE: unless absolutely sure, this helper should in general be =
called
> > > > + * outside of bh lock section to avoid reporting a surprising QS t=
o updaters,
> > > > + * who could be expecting RCU read critical section to end at loca=
l_bh_enable().
> > > > + */
> > >
> > > How about something like this for the kernel-doc comment?
> > >
> > > /**
> > >  * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent state=
s
> > >  * @old_ts: jiffies at start of processing.
> > >  *
> > >  * This helper is for long-running softirq handlers, such as those
> > >  * in networking.  The caller should initialize the variable passed i=
n
> > >  * as @old_ts at the beginning of the softirq handler.  When invoked
> > >  * frequently, this macro will invoke rcu_softirq_qs() every 100
> > >  * milliseconds thereafter, which will provide both RCU and RCU-Tasks
> > >  * quiescent states.  Note that this macro modifies its old_ts argume=
nt.
> > >  *
> > >  * Note that although cond_resched() provides RCU quiescent states,
> > >  * it does not provide RCU-Tasks quiescent states.
> > >  *
> > >  * Because regions of code that have disabled softirq act as RCU
> > >  * read-side critical sections, this macro should be invoked with sof=
tirq
> > >  * (and preemption) enabled.
> > >  *
> > >  * This macro has no effect in CONFIG_PREEMPT_RT kernels.
> > >  */
> >
> > Considering the note about cond_resched(), does does cond_resched() act=
ually
> > provide an RCU quiescent state for fully-preemptible kernels? IIUC for =
those
> > cond_resched() expands to:
> >
> >         __might_resched();
> >         klp_sched_try_switch()
> >
> > ... and AFAICT neither reports an RCU quiescent state.
> >
> > So maybe it's worth dropping the note?
> >
> > Seperately, what's the rationale for not doing this on PREEMPT_RT? Does=
 that
> > avoid the problem through other means, or are people just not running e=
ffected
> > workloads on that?
> >
> It's a bit anti-intuition but yes the RT kernel avoids the problem.
> This is because "schedule()" reports task RCU QS actually, and on RT
> kernel cond_resched() call won't call "__cond_resched()" or
> "__schedule(PREEMPT)" as you already pointed out, which would clear
> need-resched flag. This then allows "schedule()" to be called on hard
> IRQ exit time by time.
>

And these are excellent questions that I should originally include in
the comment. Thanks for bringing it up.
Let me send another version tomorrow, allowing more thoughts on this if any=
.

thanks
Yan

> Yan
>
> > Mark.
> >
> > >
> > >                                                       Thanx, Paul
> > >
> > > > +#define rcu_softirq_qs_periodic(old_ts) \
> > > > +do { \
> > > > +   if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> > > > +       time_after(jiffies, (old_ts) + HZ / 10)) { \
> > > > +           preempt_disable(); \
> > > > +           rcu_softirq_qs(); \
> > > > +           preempt_enable(); \
> > > > +           (old_ts) =3D jiffies; \
> > > > +   } \
> > > > +} while (0)
> > > > +
> > > >  /*
> > > >   * Infrastructure to implement the synchronize_() primitives in
> > > >   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
> > > > --
> > > > 2.30.2
> > > >
> > > >

