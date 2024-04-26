Return-Path: <linux-kernel+bounces-159375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859D8B2DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD031F215C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11BA63A;
	Fri, 26 Apr 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5H6Ex6l"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911B37B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090369; cv=none; b=icP9GalenRQte3XxH3pL8vEygkN8Fu0OsTPll+Hk5u/Ss1ZuCT5Z3ABcfY5KOf3O1XgVtyE0yc6K/RSpSzV6Ug8b7Xq+iDBBqeO++OkPDlQ9af3zAZ5KLV5bY7+V9GqRhyBombP0VKXPRjunpzqzhQJNqSu/bwF5KDVkVdFBV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090369; c=relaxed/simple;
	bh=jNO40jfwLPG3VrQKqrW1igKQcAK5YtlhLDZJ2mz7Kew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCTuR5Dx3OSDLgRaxJdv5jI/SG+W1pKVh+p3cD1Asu6V2YzkgCRu9QE64p0Dct5Mc1m33Dzv3f4cKn7lMgW3z7rnXow1GB8nXlUwDVEdD8h2nq1dcvH3ItRfc+1ZSHOiTTHC90dmcx5JQ+BI+iFzqjDiCWxnLOrlwIpxqNzH5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5H6Ex6l; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so6460a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 17:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714090365; x=1714695165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwxYvBhMHHB/LmVKzHkLlF1tZDOYiQfYDOkfq8CH5MQ=;
        b=A5H6Ex6lCnBDYF/mokff/MEabJyFmiwwXIxERxXB1mHb2iIHnk2/nNeOphiShOa4y9
         1q6arVvxvypGJgqzdrghhe/I/A/wE1ZuC3dq9mLcumydSZeso5iIJ3PI55jL4fNPq+WT
         c9HV+Sea9rRqk5RSH+B+LfunIdSeYwG+eVFFTygjys6ZSvj/s9FSNVKh7hVMw9YDlTTQ
         6OUyK3jJwhT1hRQToFW9BIgsjjHOrj4Oe1P7PWxAXjadFocjwyzIv23rnt6Ph7vKmlXk
         Fu0XL/mm/RFbzY8NI2oslvErIuI0bCZQHYnVwd+k5zS+v0498+9HJPidYMxE17PRuzlq
         hB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714090365; x=1714695165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwxYvBhMHHB/LmVKzHkLlF1tZDOYiQfYDOkfq8CH5MQ=;
        b=YjFp4DOntZjiDcf4UWarMibhl2iUlV9Yf3AHSLQ3O+czbnr58wVt889RUx1HZd4ziQ
         WxY3FbA6TPR4+5sNa5LqspFHH5gczUPjcysUd4t8wg25z6nFwEd6qQJwSAwIoqMoOjjz
         C6hJKTkDY2cJ6xTNtb3DzQws82/pZE3Lal3LIhYufpcDmO4hiSy2cs4DM+xLwQVeGM9I
         2Rm1y8o+ELJ7rc/HyFvBaHVIBHKYC8PBqwmXWs7iHkqCsh/84fMakPGmPR+7mZYb+dyC
         ye/vjaj9cKR3xI6gF9oNFfJtyKhpwU8kyMfqun0srqGEtnmBrRqM57F96zhQRpgGMgtg
         pTdA==
X-Forwarded-Encrypted: i=1; AJvYcCWL4ZDXPtZzEL+LPYAFZmvjpYT999D712dr62s+5V8YA79WZiP3WnL5XRK4XNnjoyg2C7NWehXk1/L5TATdcn+wVUAl8D7hbkXAi33G
X-Gm-Message-State: AOJu0YwPurjXJzSUZb7u0crfLiJBDXb3elLHm68XKUyyipt0xhBgkd4p
	iRzdXUKhK85s9Rm9wwwgl9zTww+EcuSjRyPxTnmftYe3wduZu0a3BMMYJSmiFETPET8A+l8AQ6m
	NAHJnJGzP5gwZoJeB05xkHgAn899jGvKYkbNi
X-Google-Smtp-Source: AGHT+IFvArnrXY0e9UaqZHthhyesNM310pIg4F/HpvG54YaR/QDShbIlonC0lh8IGIeIOi8sS5EW0ZMOaW30ppQpOrI=
X-Received: by 2002:a05:6402:5203:b0:572:1486:452 with SMTP id
 s3-20020a056402520300b0057214860452mr61469edd.1.1714090365435; Thu, 25 Apr
 2024 17:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
 <20240425210540.3265342-1-jeffxu@chromium.org> <7054B528-C603-4EAC-B48D-784480DFE4B6@oracle.com>
In-Reply-To: <7054B528-C603-4EAC-B48D-784480DFE4B6@oracle.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 25 Apr 2024 17:12:07 -0700
Message-ID: <CALmYWFsW5XcM8PYwd=SCthfgjC3TxqVz=DjnCuV8TU7k+_jLaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: "jeffxu@chromium.org" <jeffxu@chromium.org>, Andrew Brownsword <andrew.brownsword@oracle.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "jannh@google.com" <jannh@google.com>, 
	"sroettger@google.com" <sroettger@google.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:49=E2=80=AFPM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
>
>
> > On Apr 25, 2024, at 2:05=E2=80=AFPM, jeffxu@chromium.org wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > On 3/21/24 14:56, Aruna Ramakrishna wrote:
> >> Enabling both the non-zero pkey (for the thread) and pkey zero (in
> >> userspace) will not work for us. We cannot have the alt stack writeabl=
e
> >> by all - the rationale here is that the code running in that thread
> >> (using a non-zero pkey) is untrusted and should not have access to the
> >> alternate signal stack (that uses pkey zero), to prevent the return
> >> address of a function from being changed. The expectation is that kern=
el
> >> should be able to set up the alternate signal stack and deliver the
> >> signal to the application even if pkey zero is explicitly disabled by
> >> the application. The signal handler accessibility should not be dictat=
ed
> >> by the PKRU value that the thread sets up.
> >>
> > We have a similar threat model that we don't want "untrusted threads" t=
o
> > access altstack. I think this patch need not be restricted to the
> > use case of zero pkey for altstack, i.e. application can also set
> > non-zero pkey to altstack and expect the same.
>
> Agreed. In the latest version of this patchset, this assumption has been =
removed.
>
> Link here:
> https://lore.kernel.org/lkml/20240425180542.1042933-1-aruna.ramakrishna@o=
racle.com/T/#t
>
> >
> >> Solution:
> >> The PKRU register is managed by XSAVE, which means the sigframe conten=
ts
> >> must match the register contents - which is not the case here. We want
> >> the sigframe to contain the user-defined PKRU value (so that it is
> >> restored correctly from sigcontext) but the actual register must be
> >> reset to init_pkru so that the alt stack is accessible and the signal
> >> can be delivered to the application. It seems that the proper fix here
> >> would be to remove PKRU from the XSAVE framework and manage it
> >> separately, which is quite complicated. As a workaround, this patch do=
es
> >> something like this:
> >>
> >>       orig_pkru =3D rdpkru();
> >>       wrpkru(init_pkru & orig_pkru);
> >>       xsave_to_user_sigframe();
> >>       put_user(pkru_sigframe_addr, orig_pkru)
> >>
> > The default PKRU of thread [1] is set as 01 (disable access) for each P=
KEY
> > from 1 to 15, and 00 (RW) for PKEY 0.
> >
> > Let's use pkey 1 as an example:
> > The init_pkru is 01, if the thread has PKRU (orig_pkru) as 10 (disable =
write
> > but have read) then new_pkru from (init_pkru & orig_pkru) is 00, which =
gives
> > RW access to the pkey 1.
> >
> > When the thread has orig_pkru as 01 (disable access) or 00 (RW), new_pk=
ru is
> > unchanged from orig_pkru.
> >
> > Now take pkey 0:
> > the init_pkru is 00, regardless what threads has, new_pkru will always =
be 00.
> >
> > This seems to work out well for pkey 1 to 15, i.e. signal handing code =
in
> > kernel only give write access when the thread alrady has read access to=
 the
> > PKEY that is used by the altstack. The threat model interesting here is=
 to
> > prevent untrusted threads from writing to altstack, and read is probabl=
y less
> > of a problem.
> >
>
> This piece of code assumed that the init PKRU value allows writes to the =
alternative
> signal stack. As you mentioned earlier, that may not always be true - a n=
on-zero pkey
> can be used for the altstack.
>
Only PKEY 0 has init PKRU as 00.
So in your case, the thread doesn't have write access to pkey 0, and
need the write
access to pkey 0 during signal handling.

> So the new version simply does write_pkru(0) (i.e. enabled all pkeys) bef=
ore XSAVE.
> Is this more reasonable?
>
write_pkru(0) will work, but it is unnecessary in the current patch.

Consider the following case: A thread has no access to pkey 1,  and
use pkey 1 for its altstack.

In V3 (use write_pkru(0):
Signal will be dispatched to the user, i.e. write to signal frame is
OK, but it will SEGV at sigreturn.

In V2:
it will SEGV earlier at dispatch stage when writing to sigframe.

I would rather that the code fails earlier for this case.

> >
> > Does this meet what you want? (Note the pkey 0 is different than 1-15)
> >
> > Suppose someone also like to disable all access to altstack, then there=
 is one
> > more place to mind: in sigreturn(), it calls restore_altstack(), and re=
quires
> > read access to altstack. However, at the time, PKRU is already restored=
 from
> > sigframe, so SEGV will raise (the value in sigframe doesn't have read a=
ccess
> > to the PKEY).
> >
> > Without changing sigreturn, using wrpkru(0) here might not be necessary=
:
> > the dispatch to user space works fine, only to crash at sigreturn step.
> >
> > [1] defined by init_pkru_value in pkeys.c
> >
> > Best regards,
> > -Jeff
>
>
> I see what you're saying. In rt_sigreturn():
>
>         if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags)) =
<=E2=80=94 restores PKRU, disabling access to altstack
>                 goto badframe;
> ...
>         if (restore_altstack(&frame->uc.uc_stack)) <=E2=80=94 needs read =
access to altstack
>                 goto badframe;
>
>
> I=E2=80=99m wary about reordering anything in here. Also, this code is no=
t aware of the altstack permissions. I=E2=80=99m wondering if wrpkru(0) is =
needed here too.
>
We can't change PKRU after restore_sigcontext,  the calling thread
would have PKRU 0, not the original PKRU from before handling the
signal.

