Return-Path: <linux-kernel+bounces-133226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFC89A0CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4A1C23071
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE116F851;
	Fri,  5 Apr 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR6crsSw"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406816F28B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330222; cv=none; b=m5Kn/F8CsYA+dk7wLvgSxdpO6hAnj/rWiN8tFK+qUMxJVMBnplRxtbyL5jR/szTlXoWuYALwBpbVjcOPJ5yesccJb0h3UTND5Zev8Hzt5z5bLGtKHBtgBfpPM30qD2Lo0FRZa94/B6p8MLvNTeGRgxzljPQnPndc8fx9SshojlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330222; c=relaxed/simple;
	bh=z2aQ7DpVqxi/SOBMC1I1b8bannThp9LA1uhBUa3ir1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WD/VW5ikx+5ZgJtEserReMuOmkvhOWTKUfOAE+qokHPY7DAoFkmtu1crb34Vmb4nhVMcIa+e7pkFMnfNKO4Pf0r2goqv5zEqRIKWIjZT3CMOsLWwdJkY52AEP7YvjPp0W7gj4wpsW/pQj0aNIRnFaCl8iKFuA/lgjiLe+Tqwuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR6crsSw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d872102372so1989391fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712330219; x=1712935019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2ENZHCS9JQV8b2GdMqLyoK4cT04Sq4gyCwITbWTEGI=;
        b=BR6crsSwrukVZQVcBqT8rSpcb2kp1+5hfTfk0pKoAqMFu+kUhEkfDOtHeR21jzIKBm
         WhubFg7kzosnuEz6NMS7p84vtzPcb1cRGaZAfDSW4O+/Qgg2SP4Rv9TRi7CIwnh37uVG
         owf3im7KszIfGkPI4d071EDsdP4yCL8JN7+5g4slGM0cSR46T8mBTUzJqUDpInyg0UhK
         DLokasFjsc/eYyfUs7a0O1SkkUSVCcutI1Jwyb3axP/9206f1CN39W4AQPsrZZCM88Ax
         DNQYfsjFoSslgrrfuVfUDbnSi2vbH5l4hJAx02SxloYC8IlccOZYA82zmhBD4QIruy07
         Bm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330219; x=1712935019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2ENZHCS9JQV8b2GdMqLyoK4cT04Sq4gyCwITbWTEGI=;
        b=cnYiD7AejPtp/SYHhUp9alp1kYxfDZIHuYwg0fB9fj2wAlxCVgu03XMwk5zVCuH3Ci
         pUtHbw0iXjEpZE75Sjl8reei/v9PUWYQ5BZIlmR49MQZlGvxL+US5l7QPCLpdnjNPExl
         EM6bk1FKvdeoqrD8aAEn4cuwzHfQjuoNZzvICQE2s9Q9TlCVjcFfH+MSWEB7bYrmMFYJ
         jGvnKJ7TpGNDyPpPmHa71BBDWmzqFI8e/h1qDy1wvrCn9kFNmYq0dl4vMlwhMClLzHg4
         Mpss/HCchawjQ2ZCQ8VmyRhwtkbccv7xfdEHEV9UPiqwB3OOjjJXanAUnt/WNPgoyWOm
         DnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuwD+sKU7Q7yUDZX+j/ssHEtBBJhk4oWiFvg34nnExAIMSVbdqBRh/IYASMhi/9Rk23caGh2P12103l2cdnxlxqKTB/Qvw5h/xqZFH
X-Gm-Message-State: AOJu0YzhQao9v7x7te/eaiZrJdcBRFCsNG6aqvKsoZHXgsbtD4Wk6Cfn
	asK1oZ9KUepnryComVZ4b1tY1qKi+kQpUbg887JbptUdFy+zbd7urSlg4bRxzLstGQ9TeD+V46V
	l0eVLiXMKxaI999E+XLr8n8n9qPI=
X-Google-Smtp-Source: AGHT+IHGs366whFfeFHulBYqBWYZVeT/3v/poOaEEdA/Lyj0oV/G5vwbW1LQY0NaJuXRSvYhENtpV1LJT+RIO34KCBY=
X-Received: by 2002:a2e:a312:0:b0:2d6:9054:5b5c with SMTP id
 l18-20020a2ea312000000b002d690545b5cmr597928lje.26.1712330218459; Fri, 05 Apr
 2024 08:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402175058.52649-1-ubizjak@gmail.com> <0F9CDB7B-E8DD-43E5-9394-233A9289B3E0@gmail.com>
In-Reply-To: <0F9CDB7B-E8DD-43E5-9394-233A9289B3E0@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 5 Apr 2024 17:16:46 +0200
Message-ID: <CAFULd4YWP7VE2aRF-wwaaHiea9UOkyjhbV7OE-a36HpyTecrmg@mail.gmail.com>
Subject: Re: [PATCH] x86/percpu: Use __force to cast from __percpu address space
To: Nadav Amit <nadav.amit@gmail.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Charlemagne Lasse <charlemagnelasse@gmail.com>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 4:38=E2=80=AFPM Nadav Amit <nadav.amit@gmail.com> wr=
ote:
>
>
>
> > On 2 Apr 2024, at 20:50, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Fix sparse warning when casting from __percpu address space by using
> > __force in the cast. x86 named address spaces are not considered to
> > be subspaces of the generic (flat) address space, so explicit casts
> > are required to convert pointers between these address spaces and the
> > generic address space (the application should cast to uintptr_t and
> > apply the segment base offset). The cast to uintptr_t removes
> > __percpu address space tag and sparse reports:
> >
> >  warning: cast removes address space '__percpu' of expression
> >
> > Use __force to inform sparse that the cast is intentional.
> >
> > Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
> > Closes: https://lore.kernel.org/lkml/CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=
=3DaunFieVqZg3mt14A@mail.gmail.com/
> > Fixes: 9a462b9eafa6 ("x86/percpu: Use compiler segment prefix qualifier=
")
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Nadav Amit <nadav.amit@gmail.com>
> > Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: Denys Vlasenko <dvlasenk@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> > arch/x86/include/asm/percpu.h | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percp=
u.h
> > index 1f6404e0c428..20696df5d567 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -77,7 +77,7 @@
> > #define arch_raw_cpu_ptr(_ptr) \
> > ({ \
> > unsigned long tcp_ptr__ =3D __raw_my_cpu_offset; \
> > - tcp_ptr__ +=3D (unsigned long)(_ptr); \
> > + tcp_ptr__ +=3D (__force unsigned long)(_ptr); \
> > (typeof(*(_ptr)) __kernel __force *)tcp_ptr__; \
> > })
> > #else
> > @@ -96,8 +96,8 @@
> > #endif /* CONFIG_SMP */
> >
> > #define __my_cpu_type(var) typeof(var) __percpu_seg_override
> > -#define __my_cpu_ptr(ptr) (__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
> > -#define __my_cpu_var(var) (*__my_cpu_ptr(&var))
> > +#define __my_cpu_ptr(ptr) (__my_cpu_type(*ptr)*)(__force uintptr_t)(pt=
r)
> > +#define __my_cpu_var(var) (*__my_cpu_ptr(&(var)))
>
> If you use "(var)=E2=80=9D in __my_cpu_var(),, you might just as well cha=
nge the first to:
>
>   #define __my_cpu_ptr(ptr) (__my_cpu_type(*(ptr))*)(__force uintptr_t)(p=
tr)
>
> [ not that I think of any real issue it might cause - just for consistenc=
y]

Yes, I have changed it in one of the follow-up percpu patches [1].

[1] https://lore.kernel.org/lkml/20240404094218.448963-2-ubizjak@gmail.com/

Thanks,
Uros.

