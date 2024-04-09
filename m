Return-Path: <linux-kernel+bounces-137335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F405E89E0A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F701F243E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6683153587;
	Tue,  9 Apr 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHQJUeYv"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3012FB38
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680788; cv=none; b=DdTq+dALq6eEVplerv5kSRH8Yxv9BnlugzvkYEgmVgPbaJECyZBC1bnnS1TrvDubVa4HyobyNlwBmci+GFPGUx9QOMH19XnglfAEjxd5xFy2H2+nR8chVVjyLYGkGrGIEu7cPeDZb+YqqnpL2GHLNS+CCM7vAyEy4GFR+1F1FQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680788; c=relaxed/simple;
	bh=CeqwEfn7hxixV7Q4IJX2Msi1UfXF2jeUhIQ3WoMPvo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koVps0IXFkdz4H3j5humi07ohgKzCBxt8Zw/D9Pd0fTkAw7rDgkzgzzzOTEkUy1vgoNtefOhoR00yaUySpmHDlkYA8wF/TFBt+iuKNeITDwsSzaiDag+Nff225PzbXw5ry6KS1u1nioTVw64gTPwxK104zEjqX2uEUFm/FYgWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHQJUeYv; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d872102372so27315721fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680785; x=1713285585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBT+lMHdoxQPnN8zguId+6Um+09l9JZ+jGkhPwm7jEg=;
        b=eHQJUeYvzaFE54aubf2NhzoE+PTohb/9fZFwjPVLB4XKbwPCyKpiF7O9fH/gx8xWuT
         8LotlBTHKhdIHTqdZdzvQftOcTkZxf0BDC8CI5FXCxtJbm5kCLAkevmkrv81qYDvvatB
         e2GqDu3xvqEwHXiZkxaBN9K6wJEo12DmrYkPTSOXLuN9NCPbAunwIgAX2Rqo1hCrazSC
         ZWUWTimPCegOXt6GtEzUsPnf5tiUmCYVmR9VNb7TBPBAt7JXMiHltGo2kKdkrJuGPXX/
         XOkjw+jehtTSm1jazc1epRCjRmzo4ChgIiW7UVdG5X5HQBmboGpxPrmvGNjwt83J9Yqo
         nVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680785; x=1713285585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBT+lMHdoxQPnN8zguId+6Um+09l9JZ+jGkhPwm7jEg=;
        b=EKC0iBggIW6q1cev6pTqYwQGdUpa7vnPWQaToet7JihniNvYC3vehEOtCYcnBVuUdR
         5szvLU4Gs00F4V4mJHA45Qs6MQSeOkF8hOhSBLpEfP4+2jn+mA59jgpxAAW2K6CrtVMe
         aoXTfwuZ0wnJCzMH4WI0E+SSu8fn+oCkynnmds91AVXKBc5WMrulXZKS3V4wBzKwT7F7
         Sp55zydxC3kLxoMIRhc35SSmkJvQwSbOoStbVqB5Cqz5U3FViCZ1cnUWZtvxDTjouC4S
         4Z98Sha0/dIq4l+toHJkjXEX4tmUk/5DxlADYyPYie/+NRclWBSgEeDj1EHHTLzss6cq
         LTJA==
X-Forwarded-Encrypted: i=1; AJvYcCVB6vjnfYPcNNnuYZmeMNK/fTXlvu61gDLKAwHCzmTagDtlwqnOYcTPiHA11eQ8dGc+frHhcwaq2EDxB6KNnhXEK6QVHTXPCP/XKcEc
X-Gm-Message-State: AOJu0YyZ56kqZ8kkUSHs0AhYfay8Cibivtnv27D53OCb/RvT4K8kLitF
	BoKNaaiPJEARcQ3SKJLmvnBfBLAGfGz1NRSQNVNQGMP6OTv3QOiu2QVZkjee8Z8FnwSveUCXPgD
	hxY117YaWhVouJkmQ9IH3hUMnFM4=
X-Google-Smtp-Source: AGHT+IGeyFaVNayjG1Bq8qW14pbrDUA7Kk+azh0qkwYKueseqjpB2wN9iesJA7SXTQeIcEhKYudX3ewOfe9rMXCEtqk=
X-Received: by 2002:a05:651c:1050:b0:2d8:606d:c797 with SMTP id
 x16-20020a05651c105000b002d8606dc797mr58893ljm.10.1712680784496; Tue, 09 Apr
 2024 09:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409100503.274629-1-ubizjak@gmail.com> <20240409100503.274629-3-ubizjak@gmail.com>
 <ZhUixk5I_n53dbBb@FVFF77S0Q05N> <CAFULd4bBmQ85UsPOOEA+5dj-_JOBNWeyM-jipM7Zov2V484quQ@mail.gmail.com>
 <CAFULd4Z8JTc_5p8apO680es0fYO5ke9yYPpPUfp=15XrRbKESQ@mail.gmail.com> <ZhVuG4J7aocGvd0-@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZhVuG4J7aocGvd0-@FVFF77S0Q05N.cambridge.arm.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 9 Apr 2024 18:39:32 +0200
Message-ID: <CAFULd4ZRcnEjKeR7uAjQEAY72YnidKLY5bmK7kaJU4aXHB9P8Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] locking/atomic/x86: Rewrite x86_32
 arch_atomic64_{,fetch}_{and,or,xor}() functions
To: Mark Rutland <mark.rutland@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:34=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:

> > > > ... and then use that in each of the instances below.
> > > >
> > > > That way the subtlety is clearly documented, and it'd more clearly =
align with
> > > > the x86_64 verions.
> > >
> > > This is an excellent idea. The separate definitions needs to be place=
d
> > > in atomic64_32.h and atomic_64_64.h (due to use of atomic64_t
> > > typedef), but it will allow the same unification of functions between
> > > x64_32 and x64_64 as the approach with __READ_ONCE().
> >
> > Something like this:
> >
> > --cut here--
> > /*
> >  * This function is intended to preload the value from atomic64_t
> >  * location in a non-atomic way. The read might be torn, but can
> >  * safely be consumed by the compare-and-swap loop.
> >  */
> > static __always_inline s64 arch_atomic64_read_tearable(atomic64_t *v)
> > {
> >     /*
> >      * See the comment in arch_atomic_read() on why we use
> >      * __READ_ONCE() instead of READ_ONCE_NOCHECK() here.
> >      */
> >     return __READ_ONCE(v->counter);
> > }
> > --cut here--
> >
> > Thanks,
> > Uros.
>
> Yeah, something of that shape.
>
> Having thought for a bit longer, it's probably better to use '_torn' rath=
er
> than '_tearable' (i.e. name this arch_atomic64_read_torn()).
>
> It'd be nice if we could specify the usage restrictions a bit more clearl=
y,
> since this can only be used for compare-and-swap loops that implement
> unconditional atomics. (e.g. arch_atomic64_and(), but not
> arch_atomic_add_unless()).
>
> So I'd suggest:

Eh, just sent a v2 a second before I received your mail. I'll respin
the patchset tomorrow to include your suggested text. Please note that
v2 patch set avoids all cosmetic  changes.

Thanks,
Uros.

>
> /*
>  * Read an atomic64_t non-atomically.
>  *
>  * This is intended to be used in cases where a subsequent atomic operati=
on
>  * will handle the torn value, and can be used to prime the first iterati=
on of
>  * unconditional try_cmpxchg() loops, e.g.
>  *
>  *      s64 val =3D arch_atomic64_read_torn(v);
>  *      do { } while (!arch_atomic_try_cmpxchg(v, &val, val OP i);
>  *
>  * This is NOT safe to use where the value is not always checked by a
>  * subsequent atomic operation, such as in conditional try_cmpxchg() loop=
s that
>  * can break before the atomic, e.g.
>  *
>  *      s64 val =3D arch_atomic64_read_torn(v);
>  *      do {
>  *              if (condition(val))
>  *                      break;
>  *      } while (!arch_atomic_try_cmpxchg(v, &val, val OP i);
>  */
> static __always_inline s64 arch_atomic64_read_torn(atomic64_t *v)
> {
>     /* See comment in arch_atomic_read() */
>     return __READ_ONCE(v->counter);
> }
>
> Mark.

