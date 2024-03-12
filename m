Return-Path: <linux-kernel+bounces-100916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA1879F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F96B222EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A647784;
	Tue, 12 Mar 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3cKdCrS"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C546447
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285447; cv=none; b=GuWTiSZeD8UyuR+iOUnTdNce0HYfE0i8BfsfBZ3VfgzX+IO8keKDKTFQG7QfGWkpN1sE4fJOZffXwC4mkmhk3exhPyAha3BfiUpuZbV8uRGy61TaXsTFmE6xpjcN+Mm246aDQHGZzEL/CKK44QLpCY9unVc497114bSYaErpzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285447; c=relaxed/simple;
	bh=mEVVZfaqQll7hPHGOE2jyppJk2XufCVC8jkqkZ3Q1hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWCll7QFwEcoBIOaPbIU+eT0OF7Di5o0NTQPRadei5bN+puIX8DPrWWLPd0qmzuzlLZlgF9dBR2L1F+qI/lu85QMWnCoBVfPo1jqsOOgBWLbbtARVpVClaK+tGaa3LlWGnLmnkOO40xzRgsFvj9HiXhUupF1C0T5iaH/7ztYyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3cKdCrS; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609ff069a40so54997807b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710285444; x=1710890244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bry8Qeic+As0rVPkAapNZ1WCNptnnv3zdt3A6f6/O8k=;
        b=d3cKdCrSWccKwsYC6H7cO9rq9tph94RMmEiuO8nBKCv9OEtoNOaKM4S4xEm2r62nXG
         x0FsCBEhnMK3517290W9wz8RWVD/Di5eEAkaSptLeo+o0Y1rT/JziA4PhQGEC2GhK12b
         mVAbIXq1PUSxoBPd/tbEiJPYNeqp+pRA39LrOvIqFzrK8+xmFqRfptPHwldch7GJogyz
         caTz5Tga1USVEpMwAqjwuMhKMUVjxVixwiJcAO01wwNyzn6ghO2DdvW7yKPlb2LH9JQt
         GhlhKj4U62gYctZejhNwsDjih9EA2U974fdj3XM+P3vNHqbf0ygI1MJzkTNLuSwomF52
         1s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710285444; x=1710890244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bry8Qeic+As0rVPkAapNZ1WCNptnnv3zdt3A6f6/O8k=;
        b=GpAlF2nT0P9TuJXJR37YqSHY2WeBiti63mCHiyxViYTMMLA3+Bq/iTV5sdRB2nWvuT
         8KIZI80nHavmn4nK4G4vrDHJpsRRsf4kinNDVb+O3N2YKOxjpR2trmcJBw8a4GkcqqKG
         Ve3hZWrZMd9Sh5uNcffWIqKZpKxLjfrtjFgSK2MjIl074FyIbIjs4Doz0CuV/SgTmtHS
         MIVInSOYN2k5E6j+TNO2EAqtiBrdw5BArMs62RTBZgzV2aX8Z/0hvpcFr2se7PPl9nSK
         GaMHmM6NThfNexbCMB/ii1JdbBRK6ZJsZx7wA0JKqagxgmImGmfBdHFoufGfGe29Z8R/
         UqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2HRt9cVJaQu1hTxVnEptpg79HUEbTBg3Ne1NjqX4cnOpKuA1pJUgIuRhM7uRqIpXzBQL8BD5/KQ3/tmwgNtGw23OwaLFded8pZwsl
X-Gm-Message-State: AOJu0Yy02DNziVO20YqcHuJo2B0Pbo5FDiHDHHPb2lU/sIjw1z7+2+1t
	01X2xNvCKH4MplA4GpV6xMt1Wo2HHFicsZ7ZnreqrWnV+VGTpvP03+snQ6N+VxItqWZmZGQzN+O
	TOElc+MZa592ND1SuEwx64gX0gUNc0MsfkXga
X-Google-Smtp-Source: AGHT+IGxgNlSk8iECd52HZgQnxnv4ZmO0xEy9uERtH6eteP0xP4NePdMcxhqXSkh3Si2f4B2CjhzJOAdogg6nXOAuh8=
X-Received: by 2002:a0d:f907:0:b0:60a:431b:c989 with SMTP id
 j7-20020a0df907000000b0060a431bc989mr978119ywf.26.1710285443999; Tue, 12 Mar
 2024 16:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org> <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com> <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
 <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com> <20240312182820.GA5122@altlinux.org>
 <CAHC9VhTw2h6V3Z4fut8vHf59kOJeYqDrPqbRmRDNtZmVnM4g6Q@mail.gmail.com> <ad5333de-0c89-4191-a217-014f3953a1df@schaufler-ca.com>
In-Reply-To: <ad5333de-0c89-4191-a217-014f3953a1df@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 19:17:13 -0400
Message-ID: <CAHC9VhSmZvxkmjeUuYyUZjKDLGpacweLod7rnmeYrWwZH444Sg@mail.gmail.com>
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, linux-security-module@vger.kernel.org, jmorris@namei.org, 
	serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:18=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
com> wrote:
> On 3/12/2024 3:06 PM, Paul Moore wrote:
> > On Tue, Mar 12, 2024 at 2:28=E2=80=AFPM Dmitry V. Levin <ldv@strace.io>=
 wrote:
> >> On Tue, Mar 12, 2024 at 10:44:38AM -0700, Casey Schaufler wrote:
> >>> On 3/12/2024 10:06 AM, Paul Moore wrote:
> >>>> On Tue, Mar 12, 2024 at 11:27=E2=80=AFAM Casey Schaufler <casey@scha=
ufler-ca.com> wrote:
> >>>>> On 3/12/2024 6:25 AM, Paul Moore wrote:
> >>>>>> On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Dmitry V. Levin <ldv@strac=
e.io> wrote:
> >>>>>>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> >>>>>>> [...]
> >>>>>>>> --- a/security/lsm_syscalls.c
> >>>>>>>> +++ b/security/lsm_syscalls.c
> >>>>>>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned i=
nt, attr, struct lsm_ctx __user *,
> >>>>>>>>  {
> >>>>>>>>       return security_getselfattr(attr, ctx, size, flags);
> >>>>>>>>  }
> >>>>>>>> +
> >>>>>>>> +/**
> >>>>>>>> + * sys_lsm_list_modules - Return a list of the active security =
modules
> >>>>>>>> + * @ids: the LSM module ids
> >>>>>>>> + * @size: pointer to size of @ids, updated on return
> >>>>>>>> + * @flags: reserved for future use, must be zero
> >>>>>>>> + *
> >>>>>>>> + * Returns a list of the active LSM ids. On success this functi=
on
> >>>>>>>> + * returns the number of @ids array elements. This value may be=
 zero
> >>>>>>>> + * if there are no LSMs active. If @size is insufficient to con=
tain
> >>>>>>>> + * the return data -E2BIG is returned and @size is set to the m=
inimum
> >>>>>>>> + * required size. In all other cases a negative value indicatin=
g the
> >>>>>>>> + * error is returned.
> >>>>>>>> + */
> >>>>>>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __u=
ser *, size,
> >>>>>>>> +             u32, flags)
> >>>>>>> I'm sorry but the size of userspace size_t is different from the =
kernel one
> >>>>>>> on 32-bit compat architectures.
> >>>>>> D'oh, yes, thanks for pointing that out.  It would have been nice =
to
> >>>>>> have caught that before v6.8 was released, but I guess it's better
> >>>>>> than later.
> >>>>>>
> >>>>>>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modu=
les, ..)
> >>>>>>> now.  Other two added lsm syscalls also have this issue.
> >>>>>> Considering that Linux v6.8, and by extension these syscalls, are =
only
> >>>>>> a few days old, I think I'd rather see us just modify the syscalls=
 and
> >>>>>> avoid the compat baggage.  I'm going to be shocked if anyone has
> >>>>>> shifted to using the new syscalls yet, and even if they have (!!),
> >>>>>> moving from a "size_t" type to a "u64" should be mostly transparen=
t
> >>>>>> for the majority of native 64-bit systems.  Those running the abso=
lute
> >>>>>> latest kernels on 32-bit systems with custom or bleeding edge
> >>>>>> userspace *may* see a slight hiccup, but I think that user count i=
s in
> >>>>>> the single digits, if not zero.
> >>>>>>
> >>>>>> Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
> >>>>>> compat shim if we can.
> >>>>>>
> >>>>>> Casey, do you have time to put together a patch for this (you shou=
ld
> >>>>>> fix the call chains below the syscalls too)?  If not, please let m=
e
> >>>>>> know and I'll get a patch out ASAP.
> >>>>> Grumble. Yes, I'll get right on it.
> >>>> Great, thanks Casey.
> >>> Look like lsm_get_self_attr() needs the same change. lsm_set_self_att=
r()
> >>> doesn't, need it, but I'm tempted to change it as well for consistenc=
y.
> >>> Thoughts?
> >> As lsm_get_self_attr() has the same issue, it needs the same treatment=
.
> >>
> >> lsm_set_self_attr() could be left unchanged.  In fact, changing the ty=
pe
> >> of syscall arguments from size_t to an explicit 64-bit type would be
> >> problematic because 32-bit syscalls cannot have 64-bit arguments.
> > You might as well convert all of the size_t parameters, pointers or
> > otherwise, in the three syscalls to u32 Casey.
>
> Well, nuts. So much for that coin flip. V2 coming real soon.

Yeah, sorry for the false starts today ...

--=20
paul-moore.com

