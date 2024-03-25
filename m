Return-Path: <linux-kernel+bounces-116538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB788A077
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3735E2C3A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D5912AAE0;
	Mon, 25 Mar 2024 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4DtAfvF"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8212A15F;
	Mon, 25 Mar 2024 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711344393; cv=none; b=KlhtdYIUh74QCU7WVxfqH+A3U5cg/EHvM6ex641eO3dXB5NPHgSHmzrEsAhDrwQ9jKywVerKTbSBDNVi0KwD7p5A9vVpnmnO6qTGshdtu51vXwLJmQWSZxea+l864AXoAlTnIhs/dk2PTnZsxE0AhiqhV1yTKEcA4v9q7XpCSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711344393; c=relaxed/simple;
	bh=MdLWQdSv4kYFG+IQVkoS9+G+X7KR88bya9BAlLHX0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaFnsQUPxerEXpV4sYoSxnwoKyzd05et+zmFsfJ2nIDnFC0vOvnlwz414UEOovfpirqiGs/2se+JGJ3fVjK6GalKqj2zxZHDHN6w+kbUq+Ky0u3h6IUO8MCn7zPDR00XN17zsW51IQnlJQwBy3F+0QDuK2L9F94Jaw7ClL6a8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4DtAfvF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1804363a12.3;
        Sun, 24 Mar 2024 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711344391; x=1711949191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7v4hPt5uV6xpjwU14niqrhjwBhvAavG1cjOu3hK29/0=;
        b=E4DtAfvF6NOwBAy85T1xKbigVGwkBiXhYYLx/uMzS9uFKE2NjFR1A8ObPVjop918Lt
         p+Ep/oQbMysm0VSXGUu6sRjNPsUl2wXKmzsygU56NCZhQKqhlbMGEdc8kIMsbMMN0lcs
         wr04M1ixPUAC+nyIb4rzBiXWu75d1Dc5qU6MvKIJfHsh6LaGr7shBDKQtXmKczT4hLiM
         jDyInqxmqr8SI6uABmGdPejlogDvYHoZLHgxRIKWia+PG21yr8SqE0yGCXf9uPrVAmyP
         ZcQI2LtJ0ctn9dw8FJ6XwiSVYle1e/J4Gx47XYV+n3guOKJwlfDLnKljjTSPWODjwHxq
         jnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711344391; x=1711949191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v4hPt5uV6xpjwU14niqrhjwBhvAavG1cjOu3hK29/0=;
        b=o91PQg8ckiLq3QvtPYFDsOeJdz/+BUDbjOL80rmbrCcixICrsI7LF7PXdsa7a5/i5H
         r6Ov1GRCr9mnnffXP73rMvCaB3qem6+MNlr4nbOkF8sfA9SZ4TzQ2srLfI3uc/3c76hp
         Ts0p+N50t+RgcC6i8YGvOVH3uZqHN7qJ7IqtebhEdbFKpIi405B2hp8OJfxhtHvgO4nh
         zr1SqttYGvw4sEhyWpG5W5guyj+QRxStvj6XMy6qqrwCk5ZJ38kIGar+jAAaX29VymfB
         yT4RWRTeVwWd6xocosTBs51WwaNU+e3c8StzJQgQI+sqUz9oiOIDVzjRAqw5wbWoxMjG
         dcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrgRWj7DWpu33hluNAJGZ6T50YZO7dTdPk7MnLu/ufEs3FALn4Adjvd1Qc5Bxm1n+yWJt+515owMD8Fm4CgoLAKRGaZT2JeHJ7qKcunSjTtwP5Z/Kdvf/3WHceca5wU1KZ
X-Gm-Message-State: AOJu0YxSnTYaLC0MQBU4rsdmvV0mvbnB9PCCzTcU+bignrmDwwHlkXFZ
	XhYk40Ablg4HM406uTdzCmbtaYJ4AitdjMgKi+Gka6Po1mVNRwOp+J67Ex7Vbs4sKjwfRWldsc/
	w9NHVahflpSt7OF6uP+absGmk4IWspxdtBcc=
X-Google-Smtp-Source: AGHT+IFyWCbqBIIn2Yck9+ARagR1fMR3j/QnyfxUdZVrnMNma5gL4DY2brZKPdeT1+sEHi5nq6fUHtwQ6A7Dn/sHnCw=
X-Received: by 2002:a05:6a20:dda5:b0:1a1:484b:bb72 with SMTP id
 kw37-20020a056a20dda500b001a1484bbb72mr4756783pzb.51.1711344390752; Sun, 24
 Mar 2024 22:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324124224.615-1-qiang.zhang1211@gmail.com> <fded324e-19bd-47a0-bd92-f25aaeddfc1f@paulmck-laptop>
In-Reply-To: <fded324e-19bd-47a0-bd92-f25aaeddfc1f@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 25 Mar 2024 13:26:19 +0800
Message-ID: <CALm+0cUiXDY3n6dvOWSmBqr3MTpAsxO+uwFzMvXySUbw1tBkZQ@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Make rcutorture support srcu double call test
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sun, Mar 24, 2024 at 08:42:24PM +0800, Zqiang wrote:
> > This commit also allows rcutorture to support srcu double call test
> > with CONFIG_DEBUG_OBJECTS_RCU_HEAD option enabled. since the spinlock
>
>                                                    ^ Comma ","?
>
> > will be called in call_srcu(), in RT-kernel, the spinlock is sleepable,
>
> You lost me on "the spinlock will be called in call_srcu()".

Hi, Paul

I mean that
call_srcu()
->srcu_gp_start_if_needed
    ->spin_lock_irqsave_sdp_contention
         -> spin_trylock_irqsave_rcu_node     (may be return false)
          ->spin_lock_irqsave_rcu_node(ssp->srcu_sup, *flags);   <---spinlock

>
> > therefore remove disable-irq and disable-preempt protection.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> Nice!  A question below.
>
> > ---
> >  kernel/rcu/rcutorture.c | 36 +++++++++++++++++++++---------------
> >  1 file changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 3f9c3766f52b..6571a69142f8 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -388,6 +388,7 @@ struct rcu_torture_ops {
> >       int extendables;
> >       int slow_gps;
> >       int no_pi_lock;
> > +     int debug_objects;
> >       const char *name;
> >  };
> >
> > @@ -573,6 +574,7 @@ static struct rcu_torture_ops rcu_ops = {
> >       .irq_capable            = 1,
> >       .can_boost              = IS_ENABLED(CONFIG_RCU_BOOST),
> >       .extendables            = RCUTORTURE_MAX_EXTEND,
> > +     .debug_objects          = 1,
> >       .name                   = "rcu"
> >  };
> >
> > @@ -743,6 +745,7 @@ static struct rcu_torture_ops srcu_ops = {
> >       .cbflood_max    = 50000,
> >       .irq_capable    = 1,
> >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > +     .debug_objects  = 1,
> >       .name           = "srcu"
> >  };
> >
> > @@ -782,6 +785,7 @@ static struct rcu_torture_ops srcud_ops = {
> >       .cbflood_max    = 50000,
> >       .irq_capable    = 1,
> >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > +     .debug_objects  = 1,
> >       .name           = "srcud"
> >  };
> >
> > @@ -3481,35 +3485,37 @@ static void rcu_test_debug_objects(void)
> >  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> >       struct rcu_head rh1;
> >       struct rcu_head rh2;
> > +     int idx;
> > +
> > +     if (!cur_ops->debug_objects || !cur_ops->call ||
> > +                     !cur_ops->cb_barrier)
>
> If this is built-in, could we please WARN if there is a conflict?

WARN_ON_ONCE(!cur_ops->debug_objects) ?

> Otherwise, it looks like the test succeeded.
>
> > +             return;
> > +
> >       struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> >
> >       init_rcu_head_on_stack(&rh1);
> >       init_rcu_head_on_stack(&rh2);
> > -     pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
> > +     pr_alert("%s: WARN: Duplicate call_%s() test starting.\n", KBUILD_MODNAME, cur_ops->name);
> >
> >       /* Try to queue the rh2 pair of callbacks for the same grace period. */
> > -     preempt_disable(); /* Prevent preemption from interrupting test. */
>
> What makes us not need this preempt_disable() in the RCU case?

the cur_ops->readlock/unlock() can guarantee that the callback will
not be called
when in the readlock/unlock() critical section.
Besides, for srcu, if invoke preempt_disable(), and the call_srcu()
internally calls
spinlock, which will trigger a lockdep warning in RT-kernels.


>
> > -     rcu_read_lock(); /* Make it impossible to finish a grace period. */
> > -     call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> > -     local_irq_disable(); /* Make it harder to start a new grace period. */
>
> Same question for the local_irq_disable()?
>
> > -     call_rcu_hurry(&rh2, rcu_torture_leak_cb);
> > -     call_rcu_hurry(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
> > +     idx = cur_ops->readlock(); /* Make it impossible to finish a grace period. */
> > +     cur_ops->call(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> > +     cur_ops->call(&rh2, rcu_torture_leak_cb);
> > +     cur_ops->call(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
> >       if (rhp) {
> > -             call_rcu_hurry(rhp, rcu_torture_leak_cb);
> > -             call_rcu_hurry(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
> > +             cur_ops->call(rhp, rcu_torture_leak_cb);
> > +             cur_ops->call(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
> >       }
> > -     local_irq_enable();
> > -     rcu_read_unlock();
> > -     preempt_enable();
> > +     cur_ops->readunlock(idx);
> >
> >       /* Wait for them all to get done so we can safely return. */
> > -     rcu_barrier();
> > -     pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
> > +     cur_ops->cb_barrier();
> > +     pr_alert("%s: WARN: Duplicate call_%s() test complete.\n", KBUILD_MODNAME, cur_ops->name);
> >       destroy_rcu_head_on_stack(&rh1);
> >       destroy_rcu_head_on_stack(&rh2);
> >       kfree(rhp);
> >  #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > -     pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
> > +     pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_%s()\n", KBUILD_MODNAME, cur_ops->name);
> >  #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>
> It might be possible to simplify the code by turning this #ifdef into
> IS_ENABLED().

mean that IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)?

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> >  }
> >
> > --
> > 2.17.1
> >

