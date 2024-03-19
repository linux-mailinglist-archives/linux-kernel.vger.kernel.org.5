Return-Path: <linux-kernel+bounces-108176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691B088071C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCDD1C21B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A305FBAD;
	Tue, 19 Mar 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fsBVhhXI"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947459B77
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885639; cv=none; b=hycQ+82ll0GsPbpwVXtFCZkI7NVWaOfLEHT32khZANZyHty1CAxut8Vr3WG2zLfQ+PbERp4KU01VFK+t/oF1PvvaBbbmDGTGoGSLeIfKtqGWScTNkdktx310+XMcthMgN8DwyFsIXIn2FzGY/DhFPxy4QdmiNj4ufL7paBdtbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885639; c=relaxed/simple;
	bh=Mc4k+kbklbPnEXg97Kq7UPLqkC4uwhIrgjA+RZ2iDoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncD/ldgFt6z5muLz/bwaH4GnZVqH28fAoKupqBn74SeMfzzo3+0i+lVAMU9nlJBxSteNNJc5aaUFAScR+TlaOcttpoTAR0lnBD9jcbQyF/uOfjq94AUeufiZNXfN9HbmJx1pB7haBPBJzoRhU0vbnfhUmLKhlj/T1zPJeEB0jqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fsBVhhXI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so7739107a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710885635; x=1711490435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkxJvAO7aT61jpsRIV0uu9cV36OWqHLBjjnDa2Y11rs=;
        b=fsBVhhXIPndKEUBQK4VZ7vBvQ2ejbexRNkBMegEPJ/XQZd9NKFmitgmA17OvmVHRbS
         PVnYaThMH+mbn4y9cK5xXcssIRj4eVAiY8lwMOgWi9b9ZnR57353vKPJ+esoPyB8uTua
         GvxDGyLijna5GbMdtc918Pdt5ifOoUZMLHYFywWqxHHTdOn48iPN0p3/9TcnGSny2mIL
         iEQZcukO2266tamSEGLnGJheJglSYDLj4rFYTyULKiAHv45oHdsYcHYhKS4t2d3xKSqY
         5EA2XcbKIpxbiBUOicWH3XdLIVO6oui+00GAGkGNq9u1yfJcSvm7gfJ686Vl3HVjIdBC
         g2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885635; x=1711490435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkxJvAO7aT61jpsRIV0uu9cV36OWqHLBjjnDa2Y11rs=;
        b=veJUKdXDeXLuQKFAN17UWm30DeX+JwV/fII3YVn6dm1sB9jAJPazCaGUDRLG1v7ycR
         8szuRIHEBF4mk0tv9tnc9G/LtUpbhQ/e7yolptCzazmYIjeMWBTSkqd2S9drBi44yGMg
         0GdL5rQ1qhL9iVyBieCKoTTV8H86DEPkjyJoKicDKfDPDR7RPRlb+Xrzd3mcrlEICrHk
         Nv0EaX/XolnWxZHA+YhprLE+H8QCwX6/Xvl1KEwA4AeTOSmLW1q/M4q2b4WN2qVK/TrP
         y+jGaBqCQw/rFojMq4L6tUraNL1L7518ApK+waOI5zrKJAsjiCj3hhpLadczSdH5b0/s
         ScFA==
X-Forwarded-Encrypted: i=1; AJvYcCUO6mnhsuILUCEqe8EXwqINdd9wTvOlHgJu0pf54biqtlba0ax6wkvpzy+lT+0JxGhAph+UzpZgyxDrpKpxwvzQwcdD2Ka1Rk5X22Ay
X-Gm-Message-State: AOJu0Yzn2JK5ZsXQwJPjq2QboEiA6TnZpCyrpmQdwEUkmdZRMxgLr6jf
	5FyCwGGstW2Pve85v4l5XBbQLlQ5+4E+X/SHestBhKK619EPEPlPpK5ewAyOMAIBk1Y5b+GcKEQ
	JU7VlJG1Ul9fG++rGduQx9sC9R44P6c10Q1H9dg==
X-Google-Smtp-Source: AGHT+IG8DtJ0F0cEhoaRWxpsmdFeQCVtIhOxMVx8byMycPcTIUdxziY9hK5SozaLVMnu+Nykaa/eGLFxsfFWOxEjwfs=
X-Received: by 2002:a05:6402:5007:b0:566:4aa9:7143 with SMTP id
 p7-20020a056402500700b005664aa97143mr12964134eda.14.1710885635488; Tue, 19
 Mar 2024 15:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710877680.git.yan@cloudflare.com> <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <6149ecfc-2a3b-4bea-a79f-ef5be0a36cd7@paulmck-laptop>
In-Reply-To: <6149ecfc-2a3b-4bea-a79f-ef5be0a36cd7@paulmck-laptop>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 19 Mar 2024 17:00:24 -0500
Message-ID: <CAO3-PbotP8pRFRC4jX+qgPjmVkRJCfSPGD3ipxa8+ph7vGVr6g@mail.gmail.com>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: paulmck@kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	Joel Fernandes <joel@joelfernandes.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Mar 19, 2024 at 4:31=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Mar 19, 2024 at 01:44:34PM -0700, Yan Zhai wrote:
> > When under heavy load, network processing can run CPU-bound for many
> > tens of seconds. Even in preemptible kernels (non-RT kernel), this can
> > block RCU Tasks grace periods, which can cause trace-event removal to
> > take more than a minute, which is unacceptably long.
> >
> > This commit therefore creates a new helper function that passes through
> > both RCU and RCU-Tasks quiescent states every 100 milliseconds. This
> > hard-coded value suffices for current workloads.
> >
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> If you would like me to take this one via -rcu, I would be happy to take
> it.  If it would be easier for you to push these as a group though
> networking:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>

Since the whole series aims at fixing net problems, going through net
is probably more consistent.
Also, thank you for your help through the series!

Yan

> > ---
> > v4->v5: adjusted kernel docs and commit message
> > v3->v4: kernel docs error
> >
> > ---
> >  include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 16f519914415..17d7ed5f3ae6 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -247,6 +247,37 @@ do { \
> >       cond_resched(); \
> >  } while (0)
> >
> > +/**
> > + * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
> > + * @old_ts: jiffies at start of processing.
> > + *
> > + * This helper is for long-running softirq handlers, such as NAPI thre=
ads in
> > + * networking. The caller should initialize the variable passed in as =
@old_ts
> > + * at the beginning of the softirq handler. When invoked frequently, t=
his macro
> > + * will invoke rcu_softirq_qs() every 100 milliseconds thereafter, whi=
ch will
> > + * provide both RCU and RCU-Tasks quiescent states. Note that this mac=
ro
> > + * modifies its old_ts argument.
> > + *
> > + * Because regions of code that have disabled softirq act as RCU read-=
side
> > + * critical sections, this macro should be invoked with softirq (and
> > + * preemption) enabled.
> > + *
> > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kerne=
ls would
> > + * have more chance to invoke schedule() calls and provide necessary q=
uiescent
> > + * states. As a contrast, calling cond_resched() only won't achieve th=
e same
> > + * effect because cond_resched() does not provide RCU-Tasks quiescent =
states.
> > + */
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

