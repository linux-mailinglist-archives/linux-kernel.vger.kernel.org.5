Return-Path: <linux-kernel+bounces-28454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF082FEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C5A1C23C27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C3A1C11;
	Wed, 17 Jan 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAs1fLK5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAA17D9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705457274; cv=none; b=mn55AswA0HSvq+Q9mdR7QDz21Wog07WZnRaBWX18VAwoCwUcQVe7AT7zgSFFDDzf4Iqory/vsdu0MzhMOb8sb3lcmzjC3wAwOrX7ycC4e05cwmfQ0f7eOyqFtqXJmdPKeIie69vx2XRyexSt7/Qsw941dRw+vlB59V/ekNusAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705457274; c=relaxed/simple;
	bh=MvDgQ746ZQj3zns1FQX1QH5YMZ8gw9t0/lB20+1RlyI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=rEP6t04I2Eevam0bounJ/JmkfV+b3SJ22a4fUKGHoCKdZ2cWccsBwuM81BmKV3mJ/l43X0uKF2jaxOMg9XHhuj8zugLVZWfV3X2yGU99LoXC3l3jPQKu4Gnhba+qlUUj/HqBf05l4CoJs4F5rw81QXo7ITttD057/DnYh+GoFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAs1fLK5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e884de7b9so4227295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705457271; x=1706062071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk5vckSqwRb1btcseiXm1KAIOaiR88MR+jDMsfvoLlU=;
        b=gAs1fLK57oONyAuiuETxTJRbUKj7LorN4nDLHgFQigiETxYqj9Z6Cd4u5pSchJ+h7y
         LdZuuGH4FHRDShTQyzDw8/5FQE3mSIKs+3ge90D9FbWKNgTNlMvI3/7cdSwTSKYJsPwL
         lh2vP/Ltf2dRlA/8PFKeWoqBT9izsXG/gkqY/VZJGPuknXckOKctA8HDZ0/wL+IOMDzh
         tvzM5cYJ5cYZA7sbDZofMdv1BqrViniNDxSuGHz2SlBOq3ETbm3P4JUs/KawStv1OUgH
         z3xARjaNFHBMm25JYNNOD0KCx5HA7rIem7xYTtLVuXynKwRc4wvuXunvXXdsVnKVQlw+
         LK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705457271; x=1706062071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk5vckSqwRb1btcseiXm1KAIOaiR88MR+jDMsfvoLlU=;
        b=wRPfIs8J/Ae7grvWQcC09xg4+ZLAaVu0k7/0kRoBt3pCITz0azWZ+HpClqSraielUx
         gCgr0MpIkeqGnriE6eElNv6Fjs6AGfu1kgHsiESc2yMKi8+4CpSNMJg4adwITIrnUqqK
         Tjk1y3IjmNWdUxUN+YiVRwWI5/jIjo4LrJUkLGPWUvfiSymWKjJDVJLjn7wTTKBJtzcT
         bQBhfrcuGmOD36VPMIROi7K+vQJ7/WCSfrOrKKRCdYL4nQ/hlIh7rjTZW3g7pVSRw9Yl
         f/eekcOypz6vB+Pw+NF61y/YUQTU9bWIgQ8VtdE+VdEKxC4+f3Pv2hDYTNK7ngZ3/OAp
         96jw==
X-Gm-Message-State: AOJu0YyRIeYQeplB/QV8qb5NmUI/lsoiiiAAOrT9idIH3r4OWS7udhKg
	Bh5VxhHLiLFi3FQeFOdZaS2T14rFDuka8IkB2aw=
X-Google-Smtp-Source: AGHT+IHP2eti1ulQloyUHRUSDb5uoVsghLJLXWZ6tMQ1lQbdTCVdK9/UurRHaZXt8SPvtjiAJHrPMdq8fZbNbYMOIuQ=
X-Received: by 2002:a05:600c:1713:b0:40e:4d17:b239 with SMTP id
 c19-20020a05600c171300b0040e4d17b239mr3954441wmn.60.1705457270812; Tue, 16
 Jan 2024 18:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705308796-13547-1-git-send-email-zhiguo.niu@unisoc.com> <ZabBHHwZd70IDDxP@boqun-archlinux>
In-Reply-To: <ZabBHHwZd70IDDxP@boqun-archlinux>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 17 Jan 2024 10:07:39 +0800
Message-ID: <CAHJ8P3K-mJOwpThm67QshCRM6uhXZhfXT_P=eL=Wr5EcRK9Z4w@mail.gmail.com>
Subject: Re: [PATCH] lockdep: fix deadlock issue between lockdep and rcu
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, xuewen.yan@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Boqun

On Wed, Jan 17, 2024 at 1:47=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Jan 15, 2024 at 04:53:16PM +0800, Zhiguo Niu wrote:
> > There is a deadlock scenario between lockdep and rcu when
> > rcu nocb feature is enabled, just as following call stack:
> >
> >      rcuop/x
> > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFF817F2A8A80, val =3D ?)
> > -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> > -001|do_raw_spin_lock(lock =3D 0xFFFFFF817F2A8A80)
> > -002|__raw_spin_lock_irqsave(inline)
> > -002|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F2A8A80)
> > -003|wake_nocb_gp_defer(inline)
> > -003|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F30B680)
> > -004|__call_rcu_common(inline)
> > -004|call_rcu(head =3D 0xFFFFFFC082EECC28, func =3D ?)
> > -005|call_rcu_zapped(inline)
> > -005|free_zapped_rcu(ch =3D ?)// hold graph lock
> > -006|rcu_do_batch(rdp =3D 0xFFFFFF817F245680)
> > -007|nocb_cb_wait(inline)
> > -007|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F245680)
> > -008|kthread(_create =3D 0xFFFFFF80803122C0)
> > -009|ret_from_fork(asm)
> >
> >      rcuop/y
> > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFFC08291BBC8, val =3D 0)
> > -001|queued_spin_lock()
> > -001|lockdep_lock()
> > -001|graph_lock() // try to hold graph lock
> > -002|lookup_chain_cache_add()
> > -002|validate_chain()
> > -003|lock_acquire
> > -004|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F211D80)
> > -005|lock_timer_base(inline)
> > -006|mod_timer(inline)
> > -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> > -006|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F2A8680)
> > -007|__call_rcu_common(inline)
> > -007|call_rcu(head =3D 0xFFFFFFC0822E0B58, func =3D ?)
> > -008|call_rcu_hurry(inline)
> > -008|rcu_sync_call(inline)
> > -008|rcu_sync_func(rhp =3D 0xFFFFFFC0822E0B58)
> > -009|rcu_do_batch(rdp =3D 0xFFFFFF817F266680)
> > -010|nocb_cb_wait(inline)
> > -010|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F266680)
> > -011|kthread(_create =3D 0xFFFFFF8080363740)
> > -012|ret_from_fork(asm)
> >
> > rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> >
>
> Nice! Looks like you find the root cause ;-) nocb_gp_lock and graph_lock
> have an ABBA deadlock due to lockdep's dependency on RCU. I assume this
> actually fixes the problem you saw?
yes, this deadlock issue can be fixed by this fixes base our test.
>
> However, I want to suggest a different fix, please see below:
>
> > This patch release the graph lock before lockdep call_rcu.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/locking/lockdep.c | 38 +++++++++++++++++++++++++-------------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 151bd3d..c1d432a 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -6186,23 +6186,29 @@ static struct pending_free *get_pending_free(vo=
id)
> >  /*
> >   * Schedule an RCU callback if no RCU callback is pending. Must be cal=
led with
> >   * the graph lock held.
> > + *
> > + * Return true if graph lock need be released by the caller, otherwise=
 false
> > + * means graph lock is released by itself.
> >   */
> > -static void call_rcu_zapped(struct pending_free *pf)
> > +static bool call_rcu_zapped(struct pending_free *pf)
> >  {
> >       WARN_ON_ONCE(inside_selftest());
> >
> >       if (list_empty(&pf->zapped))
> > -             return;
> > +             return true;
> >
> >       if (delayed_free.scheduled)
> > -             return;
> > +             return true;
> >
> >       delayed_free.scheduled =3D true;
> >
> >       WARN_ON_ONCE(delayed_free.pf + delayed_free.index !=3D pf);
> >       delayed_free.index ^=3D 1;
> >
> > +     lockdep_unlock();
> >       call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > +
> > +     return false;
> >  }
> >
> >  /* The caller must hold the graph lock. May be called from RCU context=
 */
> > @@ -6228,6 +6234,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
> >  {
> >       struct pending_free *pf;
> >       unsigned long flags;
> > +     bool need_unlock;
> >
> >       if (WARN_ON_ONCE(ch !=3D &delayed_free.rcu_head))
> >               return;
> > @@ -6243,9 +6250,9 @@ static void free_zapped_rcu(struct rcu_head *ch)
> >       /*
> >        * If there's anything on the open list, close and start a new ca=
llback.
> >        */
> > -     call_rcu_zapped(delayed_free.pf + delayed_free.index);
> > -
> > -     lockdep_unlock();
> > +     need_unlock =3D call_rcu_zapped(delayed_free.pf + delayed_free.in=
dex);
> > +     if (need_unlock)
> > +             lockdep_unlock();
>
> Instead of returning a bool to control the unlock, I think it's better
> that we refactor the call_rcu_zapped() a bit, so it becomes a
> prepare_call_rcu_zapped():
>
>         // See if we need to queue an RCU callback, must called with
>         // the lockdep lock held, returns false if either we don't have
>         // any pending free or the callback is already scheduled.
>         // Otherwise, a call_rcu() must follow this function call.
>         static bool prepare_call_rcu_zapped(struct pending_free *pf)
>         {
>                 WARN_ON_ONCE(inside_selftest());
>
>                 if (list_empty(&pf->zapped))
>                         return false;
>
>                 if (delayed_free.scheduled)
>                         return false;
>
>                 delayed_free.scheduled =3D true;
>
>                 WARN_ON_ONCE(delayed_free.pf + delayed_free.index !=3D pf=
);
>                 delayed_free.index ^=3D 1;
>
>                 return true;
>         }
>
> , and here we can:
>
>         <lockdep_lock() is called previous>
>         need_callback =3D prepare_call_rcu_zapped(...);
>         lockdep_unlock();
>         raw_local_irq_restore(flags);
>
>         if (need_callback)
>                 call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>
> compared to your fix, we don't have a special logic where
> call_rcu_zapped() can be an unlock in some conditions, which prevents
> local correctness reasoning.
>
> Thoughts?
Thanks for your suggestions, It seems that your modification is more
reasonable.
I will modify PATCH v2 according to your suggestion.
Thanks!
>
> Regards,
> Boqun
>
> >       raw_local_irq_restore(flags);
> >  }
> >
> [...]

