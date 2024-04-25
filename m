Return-Path: <linux-kernel+bounces-158117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338CB8B1BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AA51F250E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CE56BFCC;
	Thu, 25 Apr 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGg1s3Vu"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D443A268
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029766; cv=none; b=iiT1YDP3wrYsQuyyT5osWCkb731SP2AWB7LtBTCJI1S8VcC0Y/9E+TJloqld+7mfoMJbtSpP4ztO59AoRc+Z2zxOvOImCV2M6Un126IE+0N/T0wIqbDF7e94eSwr0WYzvifZw2fcGcY8EP/VhtLi2ne0jiP2a7PXPeAUZZyoJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029766; c=relaxed/simple;
	bh=nWP0uJlqGHLcY558e1BVtlGLpdNXHwpcc1niEhs6pd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqLcZxam68Gk4PDLc+RGZiYviLDjH2sGYXMH8sVWmuNCi1o/C1SMsjhGDd3FqUlmPUDT5l+TBLsymi2XgAQfxBVaG4dkmRsbOCkfBJqB0c8uPL020Cvoy4sx01CQqOJahDMowr5InRw6aH6M0cTB9ei9GYXeWIcLVMZ+9nN4rkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGg1s3Vu; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa2551d33dso457711eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714029763; x=1714634563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1eBQVaboKafOVXFDPe1fYNkoEELHKBEMQnicl+9GfA=;
        b=uGg1s3VuO1ZrDMAKhwrGugBMMh5Xvq7fXC2PPR/D+RD95dtVh5/0rxv383Go1HNqOL
         dogilihB7fc44lN4Yx1LoRys7imZQv5xwdVOKDcbpVb8Ogzsnq8HWxN3N1lmyUCKzH0N
         WScoGJTvLzrW/zzU1YITjVYURysztZs2xU//R4FdB51usk6plGwqQbriQhFGxjshcLOU
         7ntt4JIDA1Fe/9hjnGCflzDa7UQ0DM4Pq+UzckrrLZ3qZa2OrvMh/DR4xzrcmreJWuhf
         D+c0gd2RyB5eIMaZyrHJO/yYku3ZPffi5VyFRvtuipeqKxhKSFegGgNXbyYDeuWAeC1t
         pxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029763; x=1714634563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1eBQVaboKafOVXFDPe1fYNkoEELHKBEMQnicl+9GfA=;
        b=XYltMYqxBwiYGKE/bwzyPy8GmKfOR+2FZI/IW/uHmoxyE7RvsA1KhNU6spLHhdKw+7
         Uee01ck8ZW+VPHTs6BpER6ZXSzoHMOIkkaCcD31rJg+YRj+sypV/HpmKyIjypsik+3X4
         +ASFOaEDD1QwE0e1k4AmgFKhD0cD/MlwpZZcIZp4xX+KQhYUTGcTsp0iAMPl0L1ZWBlS
         9BeRR9WmjhaNcjeIIGmPWqfeJmE+OSDuRCPdyXxd+gQbC38OcpcD1gJ2Z5FlufapP/Ub
         lmaj3C/T/X0lkndhjJxbz4hCU2ViC91sFHGwCxhaLb/hc8YFnzL9CVEXNiE6OGTDJi66
         pi2g==
X-Forwarded-Encrypted: i=1; AJvYcCUlu9rBn0IjvTJIK/sY1YT5ySAd/0qw5WmXBtwg4Aww4S5rhGDudB4RSHoA1DJkMOLbJMaWp8QbF93Pwd/4v0srSiA6JyvK8JzMiS4T
X-Gm-Message-State: AOJu0YzL6dHt9U5oxbhghlSox6vtHES23TCaR2kMHnIGkQjNMZJid4H8
	WeszETXUTgKtmu/FDFRUaHWN5RPU29sridNE6VrWyu7LiV5dOllIXLo4NGALfaZLeI2bOQViL7p
	WWeU/WsOssBAjVe3wl3q6vb9aq9ynG1vAzGkM
X-Google-Smtp-Source: AGHT+IH1PWHwg9n77tQRksuEOzxZE4efRPhvf6GNA0HjKXxBwPeDgkZXXC4Zay2WtZe+7P2OqcWBKdLsNkwwG4F8L/Y=
X-Received: by 2002:a4a:e689:0:b0:5af:4b3c:e2f8 with SMTP id
 u9-20020a4ae689000000b005af4b3ce2f8mr4532348oot.0.1714029763326; Thu, 25 Apr
 2024 00:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410164558.316665885@linutronix.de> <20240410165552.572304080@linutronix.de>
 <20240418163811.GA23440@redhat.com> <20240418181821.GA26239@redhat.com>
 <20240419110632.GA3198@redhat.com> <87sezbu69x.ffs@tglx> <87plufttru.ffs@tglx>
In-Reply-To: <87plufttru.ffs@tglx>
From: Andrei Vagin <avagin@google.com>
Date: Thu, 25 Apr 2024 00:22:31 -0700
Message-ID: <CAEWA0a6E1=XouGERJtUa7R6Aia2azeOOF02_=cbjCPdB4gyZKA@mail.gmail.com>
Subject: Re: [patch V2 26/50] signal: Get rid of resched_timer logic
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 6:48=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Apr 23 2024 at 23:18, Thomas Gleixner wrote:
> > On Fri, Apr 19 2024 at 13:06, Oleg Nesterov wrote:
> >> Today SI_TIMER < 0. We could introduce SI_TIMER_KERNEL > 0 with the mi=
nimal
> >> changes, but this can't help because the commit 66dd34ad31e59 allows t=
o send
> >> any siginfo to itself.
>
> Well that predates the __SI_CODE() removal. So I doubt it's required
> today, but what do I know about CRIU.

CRIU needs to restore siginfo-s of pending signals so that a task sees
the same siginfo in a signal handler as it would be without
checkpoint/restore. CRIU will not be affected, if rt_sigqueueinfo denies
any non-negative si_code that is never reported by the kernel.

> >> Otoh, I have no idea how CRIU restores the posix timers. If a process =
has
> >> a pending blocked SI_TIMER signal, then I guess it actually needs to e=
nqueue
> >> this signal at restore time, but resched_timer will be never true?
> >
> > It can't restore the correct sys_si_private value because that is
> > nowhere exposed to user space.

We are open to ideas how it can be restored properly.

>
> It is exposed via PTRACE_PEEKSIGINFO, but it's useless.

When PTRACE_PEEKSIGINFO was added, it didn't expose it.  Then it was
changed by cc731525f26a ("signal: Remove kernel internal si_code magic").

The idea of PTRACE_PEEKSIGINFO is to get a siginfo that a process would
see in a signal handler.

>
> > There is no special treatment for SI_TIMER, so the signal restore might
> > just end up queueing a random extra SI_TIMER signal if there was one
> > pending.
>
> It does. The sys_si_private value is not going to match the timer side
> value and obviously the missing prealloc flag prevents it from trying to
> rearm the timer.
>
> > I checked the CRIU source and it looks like this just "works" by
> > reconstructing and rearming the timer with the last expiry value. As
> > that is in the past it will fire immediately and queue the signal.
>
> It's not necessarily in the past, but it will fire eventually and in the
> case of a blocked signal there will be two SI_TIMER signals queued.
>
> So the patch is not completely wrong except that there is nothing which
> prevents setting sys_si_private via rt_sigqueueinfo(), but that's
> obviously a solvable problem. With that solved the condition:
>
>                 *resched_timer =3D
>                         (first->flags & SIGQUEUE_PREALLOC) &&
>                         (info->si_code =3D=3D SI_TIMER) &&
>                         (info->si_sys_private);
>
> really can be reduced to:
>
>        info->code =3D=3D SI_TIMER && info->si_sys_private
>
> In fact it makes a lot of sense _not_ to allow user space to set
> info->si_sys_private because that's a kernel internal value and should
> never be exposed to user space in the first place.

We can zero out all of them in rt_sigqueueinfo.

Thanks,
Andrei

