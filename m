Return-Path: <linux-kernel+bounces-106885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2B87F4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4421C215CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42ED29E;
	Tue, 19 Mar 2024 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WvymFvAW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F3846D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710811623; cv=none; b=LfMWHoP39eBbsReINx+c+raXnsiUmmBT236CESaiaS+5niBzdmPDC+NCczq5MRJzGlHup7ESBNN4otsAFBw5yd2XJD5Ltz82iZnvoXBVw9iPwYRsmordi7i/Sd7RxpGS/CrqyNhwv1s3NkY9xOf8lcMMuwcVMBzU9Xapj9jwWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710811623; c=relaxed/simple;
	bh=uF1M09ZOHElrWt23+graGTrtLvlXtEJP/fROzFQdPf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNYO4tnFTYgt95f76IS3zx+2q3iV0IiO2j8ADsZdpQecOp82m8C8NYXTZWa+yzcqB7r76lRYFNN0YCzmmHerMVUYnqvtBmkztWtkpypIQbKN7l6Gy16xxWRVmLuJoTCLHTClZj6tbSvvlEDDla2wp15FyHunRehlm3DZjXz7LHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WvymFvAW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so10446093a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710811619; x=1711416419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFSq6DTagALYbPcbIPuPh63ocgP8pwtxE9YIUg3PGiA=;
        b=WvymFvAWtJ+EdPMGzeCRaH16xTdsoa4NE+LM08lNd5C79qCLs0H/Cz0F7uw6jqkhXq
         cUi0TSAZrfXDjwqCWNWSmi9+kov0sgEkkvOmVEOCYOoStM15EsYIDcxq4Nf6ygZUbkL9
         J06Gdt5z4Vz4g15NswGMna8l0ojUdRBlhhzDi448Rd3C9eJw3HkMoHCItu+a//Ssug4W
         oyWBwk8v32NLA9TMj8HQv6AV4UtGjglWUxhIeaETnBJM68/snSHbLdT6syTz/rcxAwTQ
         kINWQQM/DKdmlz+KnYrUBqvj+LNgskLpaaeEVmrwjL5su4cZnaQWcd8qNSISfc9fkbw1
         G0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710811619; x=1711416419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFSq6DTagALYbPcbIPuPh63ocgP8pwtxE9YIUg3PGiA=;
        b=FAm1wciSyIQ3MtE3BZ/xFtgT4C2vHPa6l36yZ6GHenXXRXnQdDTjKKxR1I47XksJdF
         aCWGc1056tDcvZK1KXXzuRSjJGhWYPv1ljgwZyp4U3X/Ro9JB6RHEkgQQB1m8NYTZNL9
         0jM6in8axfD3q41DA6aToh4MLzP4VecawBjiDQVkdz2ZVsWkFlPgqNWgc35czxgNssfr
         TnVtlyIviSrkKRIeNeSsPZ+6nRU3p6zIcrVLfCaK2epLoPXxKdMg2CQrmoW1xmKYQtew
         Avl1EotkgeZ359wQEAvAklHu0eDZqyUWffRsLYGbCgx24RKN9HsZ+VvrqzYSCnDT0UIN
         vlUw==
X-Forwarded-Encrypted: i=1; AJvYcCU7O23kP2QJOCU+zfbFrI3+hlYixqv5eQcmI9+AFMyb71MdV70Tt613sWkIhVz8kBYsmrxMWctJ7FSBQoqRTe9zSCs4UwwpWP0TRK0j
X-Gm-Message-State: AOJu0Yy2ou9bAA0Jw/uoCRvRHCJmmGfUVxU+G4w95+pHx2WW8/zkV/9+
	Z6d8NKbCPiY8stgbDNNgDnGtCDWAtoY2V2A0ckLbWYcj0oKr2TPRL76uthOeWwQSC+4B7yheW4L
	8GnaSCrHUqKj+stUPgFnDzHC9v6pku+Pns7sMfQ==
X-Google-Smtp-Source: AGHT+IHdlISdIaT/ImAoSJpPeaXM5kRQ/Vqqlgzc8RUwbti7lxpVu6RejPXie1u1Hwn/85EmZ+Fd9ZqlSF6Hk1R0Nvs=
X-Received: by 2002:a05:6402:388b:b0:566:59a2:7a10 with SMTP id
 fd11-20020a056402388b00b0056659a27a10mr1226565edb.1.1710811619408; Mon, 18
 Mar 2024 18:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710525524.git.yan@cloudflare.com> <491d3af6c7d66dfb3b60b2f210f38e843dfe6ed2.1710525524.git.yan@cloudflare.com>
 <790ce7e7-a8fd-4d28-aaf3-1b991a898be2@paulmck-laptop>
In-Reply-To: <790ce7e7-a8fd-4d28-aaf3-1b991a898be2@paulmck-laptop>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 18 Mar 2024 20:26:48 -0500
Message-ID: <CAO3-PbqZ9L5XPAHhD3kojHJZ3RRHre_4AkTq=aERVtLD-SeJKw@mail.gmail.com>
Subject: Re: [PATCH v4 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: paulmck@kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 12:41=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Fri, Mar 15, 2024 at 12:55:03PM -0700, Yan Zhai wrote:
> > There are several scenario in network processing that can run
> > extensively under heavy traffic. In such situation, RCU synchronization
> > might not observe desired quiescent states for indefinitely long period=
.
> > Create a helper to safely raise the desired RCU quiescent states for
> > such scenario.
> >
> > Currently the frequency is locked at HZ/10, i.e. 100ms, which is
> > sufficient to address existing problems around RCU tasks. It's unclear
> > yet if there is any future scenario for it to be further tuned down.
>
> I suggest something like the following for the commit log:
>
> ------------------------------------------------------------------------
>
> When under heavy load, network processing can run CPU-bound for many tens
> of seconds.  Even in preemptible kernels, this can block RCU Tasks grace
> periods, which can cause trace-event removal to take more than a minute,
> which is unacceptably long.
>
> This commit therefore creates a new helper function that passes
> through both RCU and RCU-Tasks quiescent states every 100 milliseconds.
> This hard-coded value suffices for current workloads.
>
> ------------------------------------------------------------------------
>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v3->v4: comment fixup
> >
> > ---
> >  include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 0746b1b0b663..da224706323e 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -247,6 +247,30 @@ do { \
> >       cond_resched(); \
> >  } while (0)
> >
> > +/**
> > + * rcu_softirq_qs_periodic - Periodically report consolidated quiescen=
t states
> > + * @old_ts: last jiffies when QS was reported. Might be modified in th=
e macro.
> > + *
> > + * This helper is for network processing in non-RT kernels, where ther=
e could
> > + * be busy polling threads that block RCU synchronization indefinitely=
  In
> > + * such context, simply calling cond_resched is insufficient, so give =
it a
> > + * stronger push to eliminate all potential blockage of all RCU types.
> > + *
> > + * NOTE: unless absolutely sure, this helper should in general be call=
ed
> > + * outside of bh lock section to avoid reporting a surprising QS to up=
daters,
> > + * who could be expecting RCU read critical section to end at local_bh=
_enable().
> > + */
>
> How about something like this for the kernel-doc comment?
>
> /**
>  * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
>  * @old_ts: jiffies at start of processing.
>  *
>  * This helper is for long-running softirq handlers, such as those
>  * in networking.  The caller should initialize the variable passed in
>  * as @old_ts at the beginning of the softirq handler.  When invoked
>  * frequently, this macro will invoke rcu_softirq_qs() every 100
>  * milliseconds thereafter, which will provide both RCU and RCU-Tasks
>  * quiescent states.  Note that this macro modifies its old_ts argument.
>  *
>  * Note that although cond_resched() provides RCU quiescent states,
>  * it does not provide RCU-Tasks quiescent states.
>  *
>  * Because regions of code that have disabled softirq act as RCU
>  * read-side critical sections, this macro should be invoked with softirq
>  * (and preemption) enabled.
>  *
>  * This macro has no effect in CONFIG_PREEMPT_RT kernels.
>  */
>
It would be more accurate this way, I like it. Thanks!

Yan

>                                                         Thanx, Paul
>
> > +#define rcu_softirq_qs_periodic(old_ts) \
> > +do { \
> > +     if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> > +         time_after(jiffies, (old_ts) + HZ / 10)) { \
> > +             preempt_disable(); \
> > +             rcu_softirq_qs(); \
> > +             preempt_enable(); \
> > +             (old_ts) =3D jiffies; \
> > +     } \
> > +} while (0)
> > +
> >  /*
> >   * Infrastructure to implement the synchronize_() primitives in
> >   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
> > --
> > 2.30.2
> >
> >

