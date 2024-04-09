Return-Path: <linux-kernel+bounces-136819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047FB89D8A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012B11C218EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50554129E9E;
	Tue,  9 Apr 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmTLO8/8"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB3129E81
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663989; cv=none; b=CCiu/ZK9vv3wdUr79TnMUpCO+YCpfDQdnEw5CXj7C3X3vA7VxCBC5TAyXNNkXUSII8WGmJtuAcZHoPR/H6Mq58elPu59hSJdg7MWKFJQXcL8KcSpqVrQqhGnnhMHhFn4gCNjTK9Y0L5/NGrDqsc+yTrtPq5vKDknvW4izAJVLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663989; c=relaxed/simple;
	bh=cKXGyQ9ugO3FhOEEQMeDF4UljKTgHKI4IxvzJMDPhNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJAvs5lYzfC6HD7thFm+q2faRhfSxteET3KwPXSlHpqE/+hZzvGk7/iaOTEDpkpp3zNk9Rv9paM+quKUd4TdYg1mbXjxEe3UTzpJM0f8vuWwp1Cg9UFc5uP7xdb4BJy7QDt29Jl5VLEowHPvayX+P8S/i201hpTBf54va5T5jvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmTLO8/8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d89346eb45so25146131fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712663986; x=1713268786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA6yM//l15RQkg/PQ3vqwqQ/y4GYtRX2qaa5WJPkuhw=;
        b=PmTLO8/8Zm8W273oyEE2JInli51o6YzzKenG3GDN4xIxkpQ49QUleWUZs9mVH6r3kO
         swZmKYrRVSUrJ9YnCM5gw/IffWfq5NM0bZyPxU2esxt2rqHrSSP7octuOkrg3HmjKwZO
         gfQAEfO3M7hqMRGcJu2TE5OKdtJr0MgnXzQKXbiAqqOhYdAyYnyDI+gH9OewXnE1UmzJ
         J00X3d8859mX4h+lO3jWpoQ3aauaZiowWXJyeai7krh3TM59nynOtQ+CJ3XOFxzUheGw
         Rpmjt+dVpFshy+drdv+JbHtYGC+tLE9kE5VSZBUwCBFOk6ivdVyB53L/pK/qmWoh3zVg
         BqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712663986; x=1713268786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA6yM//l15RQkg/PQ3vqwqQ/y4GYtRX2qaa5WJPkuhw=;
        b=t18l/CEnrOWB9kyZpBDhSfDqlAeDul6ywxD0l+t8XtYuSxny4gmOSS4jMUkMr+kTcQ
         X7Rri0t0LGtnWy8VxSZFEG7nCoMubonHFBsYbbge16HbvVjXmtot84RckJ6Vsmgec7lM
         Ie7F7kpOnYspoH83VTYcL7yUYBr7zT0TApvWdmDtVK4xly+pr9lw4FctVRhDe35RaMzc
         aFbFw7yAsI2T7xj392Zx3HwnhnuhJldHS/7K10hg4+0GmcsjhhF4NLeDLZ7Qp4ZzyMcf
         zW9CExAwkx6N41+jmcFTStdkxSbCErgXLdC0iEiB8E+eUuK8JK9T/xnuzalCcrtMjHnR
         I4zw==
X-Forwarded-Encrypted: i=1; AJvYcCVYE877E9+gmYZVlrwlCSCdhUqSnac8flSnuNzmoxMOHGN3+i24jhszpZpLgaO09hsH278PadyIgNYwVffKgQOS9dolw7eazMOwlIi4
X-Gm-Message-State: AOJu0YwhYanXr2LYXwIs9eARn7dE3yqU5Ay6Hl0eJJ3aCuTQyTh8G102
	JrvQHoGPT2en9UZumjMH4CmZfWXc9M2IAJwHZl9EEXhRFJMt40Ya+q/jf3/TGC48X/UduaZQ++J
	bcor4oY9TCDYDNlmzZJi8/2sADZjThVgYAKOaKA==
X-Google-Smtp-Source: AGHT+IHw7vOfR8eGw1oZjXBiod/DvgknmgFEPtkUfg6glfmn8GOHjjxnRb2AUbjjkSwA53q1VyFDk1hcDde1wZqc81A=
X-Received: by 2002:a2e:bc13:0:b0:2d8:6ca7:2165 with SMTP id
 b19-20020a2ebc13000000b002d86ca72165mr13695836ljf.46.1712663985471; Tue, 09
 Apr 2024 04:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409100503.274629-1-ubizjak@gmail.com> <20240409100503.274629-4-ubizjak@gmail.com>
 <ZhUhWcjo556WoTF4@FVFF77S0Q05N>
In-Reply-To: <ZhUhWcjo556WoTF4@FVFF77S0Q05N>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 9 Apr 2024 13:59:33 +0200
Message-ID: <CAFULd4ZcAhCyjkxm+FLQFz2Gw1AWvzY+_4TeUyODxwQk7hfh+w@mail.gmail.com>
Subject: Re: [PATCH 3/6] locking/atomic/x86: Use READ_ONCE before
 atomic{,64}_try_cmpxchg loops
To: Mark Rutland <mark.rutland@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:07=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Tue, Apr 09, 2024 at 12:03:54PM +0200, Uros Bizjak wrote:
> > The value preload before the cmpxchg loop does not need to be atomic,
> > but should use READ_ONCE to prevent compiler from merging, refetching
> > or reordering the read.
> >
>
> Yes, and that's what arch_atomic_read() and arch_atomic64_read() do...
>
> > This patch unifies arch_atomic{,64}_{,fetch}_{and,or,xor}() macros
> > between x86_32 and x86_64 targets.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/atomic.h      |  8 ++++----
> >  arch/x86/include/asm/atomic64_64.h | 20 ++++++++++----------
> >  2 files changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomi=
c.h
> > index 55a55ec04350..b166da21ee98 100644
> > --- a/arch/x86/include/asm/atomic.h
> > +++ b/arch/x86/include/asm/atomic.h
> > @@ -20,7 +20,7 @@ static __always_inline int arch_atomic_read(const ato=
mic_t *v)
> >        * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() =
here,
> >        * it's non-inlined function that increases binary size and stack=
 usage.
> >        */
> > -     return __READ_ONCE((v)->counter);
> > +     return __READ_ONCE(v->counter);
>
> Removing the unncessary brackets is fine, but the commit message didn't m=
ention this.

It was just a change in passing. I didn't think it even needed a comment.

> [...]
>
> >  static __always_inline int arch_atomic_fetch_and(int i, atomic_t *v)
> >  {
> > -     int val =3D arch_atomic_read(v);
> > +     int val =3D __READ_ONCE(v->counter);
>
> This is the wrong thing to do; arch_atomic_read() already has the require=
d
> semantic, and it more clearly aligns with the use of arch_atomic_try_cmpx=
chg()
> below. It contains the documentation regarding why we use __READ_ONCE()
> specifically (which we should probably note in arch_atomic64_read()).
>
> Please leave this as-is, and likewise for the other cases below. Similarl=
y, the
> prior patch should use arch_atomic{,_64}_read() rather than using
> __READ_ONCE().

Please note that arch_atomic64_read implements true 64-bit atomic read
on x86_32. I tried to bypass this using __READ_ONCE(), but your
suggestion to use arch_atomic64_read_tearable() is indeed a much
better approach.

> [...]
>
> >  static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *=
v)
> >  {
> > -     s64 val =3D arch_atomic64_read(v);
> > +     s64 val =3D __READ_ONCE(v->counter);
> > +
> > +     do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
> >
> > -     do {
> > -     } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
> >       return val;
>
> I think this reformatting is what you meant in the commit message when yo=
u said:
>
> | This patch unifies arch_atomic{,64}_{,fetch}_{and,or,xor}() macros
> | between x86_32 and x86_64 targets.

Actually, it was the change to use __READ_ONCE(). The reformatting
follows the functions from atomic.h, e.g. arch_atomic_fetch_and() and
was another case of change in passing, not worth mentioning in the
commit message. I will rewrite this in v2 of the patch, so these
functions will uniformly use arch_atomic64_read_tearable().

> Assuming so, can you please jsut do that, and say:
>
>   This patch reformats the x86_64 arch_atomic{,64}_{,fetch}_{and,or,xor}(=
)
>   functions to match the x86_32 versions.

Thanks,
Uros.

