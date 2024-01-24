Return-Path: <linux-kernel+bounces-36434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF4483A0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31347289ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9EC2D9;
	Wed, 24 Jan 2024 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7ob5gC4"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEF17D2;
	Wed, 24 Jan 2024 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071498; cv=none; b=OGWGPZqN9fTGvpxsBIyWfFoWaPAi9GXNPYjW+2i2axVG/proOigEzb2kTJHCEFCGVnnHMyPmPhlXLsZlQ4dz1BQ6hkRDmFUGJudVslXtr1dzmmPC4f0g5m+yRbz5Tvq94Xl1g7OkbwV1NFYqlqrceF7ZH+IGlPxwfvp0wP2wI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071498; c=relaxed/simple;
	bh=jIDbZT3qUcVRtGHFWULgSi1tg2ry54pXTMQUM+DJpoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqOhCIiKO6CgHJNQ6ojFkS9cA4wKXjWR56Bqfg6BpXIL6UJatlVxvQoZqQMvqyy484d7OwlZKCYYKW+xZki7da2AXlGGmKmQeKVaSNq6OcHH6LSfC8fW4I/vfY47QkAqj1XlK3mENJeOly114h8iNJ5Mi9iApy5HiZTeCzUUFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7ob5gC4; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbb4806f67so4097410b6e.3;
        Tue, 23 Jan 2024 20:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706071495; x=1706676295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jy6s0Qg+fjVCF27h2ukFDp0KtsugVL/LaCil2Eh2nI=;
        b=b7ob5gC4k0d7Hjvd1bGA9g+PEhy6x/cpvotAHOlPubzOqCFQNwTMZov7bD2D7zi9j5
         6bqyKvPwKVOttqpcKrkiGuZEhNr6qoatW1a4l8X4JsO3bBcbm1k0PX7iPuV1buL894O3
         dxmQePUEESsSZ/aoiCA+FRimW0CWFYI7UWhCdWVck0scpyTJHc0eTU8YiyxFcAtuyvbi
         jSFAgriBaT+pfSPw41sEidDsTBwwbFSOJX9eWIe/YvNXWgEMpzFGoYpndOPqGFtoRIvT
         S0RlVAVr/qQWo5IbuHy+FRVN/GcxMLLPIDH1EdVC16K/BHtP9v3WcMd+ubTl2SDijlK+
         eihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706071495; x=1706676295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jy6s0Qg+fjVCF27h2ukFDp0KtsugVL/LaCil2Eh2nI=;
        b=LX/yuCAmf/KlYGAaBhzk6HxScTNjFLQIQh+N7aFU6vD2zasdoIvZc8/Fa4ryfWg+v6
         Y3pDl13pLhS5lVbMKYaA5bkl557h3Pt+Q7tqYg3Pj8BgKgltkD6tnXOyvK3x5C7qh/rh
         S5LUDLQmsEBu7NNmP5OZKRnAGhkJJr62GzCUOdszzqLZ8pz0QHMehjaWii01w/nDZ/AQ
         R3+5Ne9DgQgUQSNvyg6k1OywhI2I5WVg1dUvy5cOwkFSGjxHT02Lsj9ker6QWugYz5RT
         NV2K4huZWhqDymylZ2LJikkRUGirbAUNsbtimkPJ1Z6HUNpm3ILHs/RnBUJf7EeF2XY6
         xT0g==
X-Gm-Message-State: AOJu0YyBQQ5HWTsxBeWgnm/CowlQuAWmhNK4P9Z2Wv7gqfOvt8deJSdf
	8uS/RhTp1aeXqNIvV7jWYfT2FHm5XKgZCqBSmVSWX7vWr24TANtC9wRmHrsZd6vbwTnkfraD2I7
	C7sMdLovss8xIz1EM5MIdQn89+8Y=
X-Google-Smtp-Source: AGHT+IH14duJhxk/J7Ezw+RwEx+BSPTMU3OFmuuHIeuODYLe7ZFza+NjEjh2gS2LWDxm5Kvvl5Ir4lkiGq52gicURIs=
X-Received: by 2002:a05:6808:21a0:b0:3bd:974f:5c64 with SMTP id
 be32-20020a05680821a000b003bd974f5c64mr1096718oib.45.1706071495370; Tue, 23
 Jan 2024 20:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117102616.18302-1-qiang.zhang1211@gmail.com>
 <ZafC_YkTJKsOropE@localhost.localdomain> <3b63cf39-3805-4c1d-b79b-fdd5aeb17db3@paulmck-laptop>
 <Zart693B-klrEF5I@pavilion.home>
In-Reply-To: <Zart693B-klrEF5I@pavilion.home>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 24 Jan 2024 12:44:43 +0800
Message-ID: <CALm+0cV_9FcC1jm=Xv8hCX0D7dNjccGdoOOfCkHqMn1AqYOEsg@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Check rdp_gp->nocb_timer in __call_rcu_nocb_wake()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, quic_neeraju@quicinc.com, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Le Thu, Jan 18, 2024 at 06:51:57AM -0800, Paul E. McKenney a =C3=A9crit :
> > On Wed, Jan 17, 2024 at 01:07:25PM +0100, Frederic Weisbecker wrote:
> > > Le Wed, Jan 17, 2024 at 06:26:16PM +0800, Zqiang a =C3=A9crit :
> > > > Currently, only rdp_gp->nocb_timer is used, for nocb_timer of
> > > > no-rdp_gp structure, the timer_pending() is always return false,
> > > > this commit therefore need to check rdp_gp->nocb_timer in
> > > > __call_rcu_nocb_wake().
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > ---
> > > >  kernel/rcu/tree_nocb.h | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > > index 54971afc3a9b..3f85577bddd4 100644
> > > > --- a/kernel/rcu/tree_nocb.h
> > > > +++ b/kernel/rcu/tree_nocb.h
> > > > @@ -564,6 +564,7 @@ static void __call_rcu_nocb_wake(struct rcu_dat=
a *rdp, bool was_alldone,
> > > >   long lazy_len;
> > > >   long len;
> > > >   struct task_struct *t;
> > > > + struct rcu_data *rdp_gp =3D rdp->nocb_gp_rdp;
> > > >
> > > >   // If we are being polled or there is no kthread, just leave.
> > > >   t =3D READ_ONCE(rdp->nocb_gp_kthread);
> > > > @@ -608,7 +609,7 @@ static void __call_rcu_nocb_wake(struct rcu_dat=
a *rdp, bool was_alldone,
> > > >           smp_mb(); /* Enqueue before timer_pending(). */
> > > >           if ((rdp->nocb_cb_sleep ||
> > > >                !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
> > > > -             !timer_pending(&rdp->nocb_timer)) {
> > > > +             !timer_pending(&rdp_gp->nocb_timer)) {
> > >
> > > Hehe, good eyes ;-)
> > >
> > > I had that change in mind but while checking that area further I actu=
ally
> > > wondered what is the actual purpose of this RCU_NOCB_WAKE_FORCE thing=
 If
> > > we reach that place, it means that the nocb_gp kthread should be awak=
en
> > > already (or the timer pending), so what does a force wake up solve in=
 that
> > > case?
> > >
> > > Paul, any recollection of that?
> >
> > Huh.  We never actually do RCU_NOCB_WAKE_FORCE in v6.7, if I followed
> > all the code paths correctly.
> >
> > Historically, I have been worried about lost wakeups.  Also, there
> > used to be code paths in which a wakeup was not needed, for example,
> > because we knew that the ending of the current grace period would take
> > care of things.  Unless there was some huge pile of callbacks, in which
> > case an immediate wakeup could avoid falling behind a callback flood.
>
> Ok then looks like it's time for me to add RCU_NOCB_WAKE_FORCE removal in
> my TODO list...unless Zqiang would like to give it a try? :-)

Thank you Frederic,  apologies for the delayed reply. I'm currently traveli=
ng,
after my vacation is over, I would like to try it  if it hasn't been
done yet :-) .


Thanks
Zqiang


>
> >
> > Given that rcutorture does test callback flooding, we appear to be OK,
> > but maybe it is time to crank up the flooding more.
> >
> > On the other hand, I have started seeing the (very) occasional OOM
> > on TREE03.
> > (In addition to those that show up from time to time on the
> > single-CPU TREE09 scenario.)
>
> Interesting, are those recent? Bisectable?
>
> Thanks!

