Return-Path: <linux-kernel+bounces-139253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9D8A0089
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE3E1F27094
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4112918131B;
	Wed, 10 Apr 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPY0K8DI"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577017F370
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777001; cv=none; b=o5LNL1wxqGtUybyiTp0Sa7VK7bHBdmyPg3o7Aa8ey5ft0kIxTIYBF1z7LCXLGyEyeEThCUBX7uPXRVBoSo7P5/VAvjmoFpqnd8Vs8SrFx/8KZD+FIk1i4VmQBNH9mFVuZys4DmiJu9lL2QcaviOexKACQhsye5lVSapF36e4ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777001; c=relaxed/simple;
	bh=lT1Zm8JHcfddh2weMtUQK4dvHTVIqbaTDfgt1QyEJTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBhmR+aUOQEUngEG0oZpO9MEkxO2sBiY+L9zHn1E3lv77D6cp6Ih++blFL0Id4doRZS+YeX57TcYc+YvN7VPBPTsCaIikyMY7llu+nL/cKSWyCT5zwDcRw0JhW4D5TpO+QhJK4bAzJE//r9S9P+1ZECHAVt3ocnNncyC9imbShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPY0K8DI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so91a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712776998; x=1713381798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqRnr/YaOnp8eBWYbEFORhlsTmhT0mCO9vyhiwgW7oI=;
        b=IPY0K8DIB4JxcC1O1tITCzfEPe7nEDDPSB4R6eVXZTp2p+3EStTKbTr3quYdBNemW7
         Q0RB66OTIWxS92Hww8VzFN+Qu4jP/U0VkzK8/Ut+UmfKOhVTlQUXmeBokSRzgRmczcSU
         ekg8cNL24/jAD3D9HXZ3p3JnQ86vbrWVd7SWzT96PnwpxraaN2UjVvzOvdasYpRUdcUc
         L2apEcnlP+02032C8GvwUA7xXZQYjlhAthutKgIusASeklyJ7b1mjQHgh2mYa7TO2kxt
         394JlFxvoUE/jb0W6dBCFuQrItx8mvc5aAIPh8J0YMJOgIBndJ5UJRSXrvHc/EtlRL4J
         0sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712776998; x=1713381798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqRnr/YaOnp8eBWYbEFORhlsTmhT0mCO9vyhiwgW7oI=;
        b=P5okikkbCb95ufmLthUYQjq4x/qJnc6MCshjJZhLFo4tmbNY9oW8Nsan7gPmmJGB4I
         9X1WQoP5gKaP3+k6W2HqdmNJn+U4YcPU94nL0BtfM9bfowB8IdyLUzld1FJ4bXaOlC2H
         WiY4+8WYV7ykErdRp/pvgaHkOPmCE8MIcom6CLoDiialeE2N8lCrqGnc9+UbqQl6tAGg
         SP8DrHYbDHMIweWqujQOwKdHFOSjVJaGfVOuWFCgbjqrPD6XXIsrazKvvkfcQcyF+YDd
         FJPF+1fcxF7Io+Qoc5yfOhcYg4mMXMb/GC2zTPVf6wJsB9jrBPVzIdUhhLHDOqMrB6yf
         a68A==
X-Forwarded-Encrypted: i=1; AJvYcCWu+7Hg9yCzGRbkG49PqNBVpoHMviqm0OoAi9RJwKHdpH6kVrKX0cjqE9cXtehuFPVNGER7wgEaergW7MYJ9uXbqx7J9MKoG3QWBa0U
X-Gm-Message-State: AOJu0YwoVkVftdlHAlRHD2XoQ1MQe/5fuCYnCUI/xigE0DlTt/L30BMr
	/SnqtyR5g4sgUj+WsS+tUqoW9jIY363I5o004YD5+7Kp3v98V6n3XDeiFRojYk3GSfr6vaVRY51
	FdSmg0Zh/OqlI+qmNjWWIkGI1APd8r1CVH9k=
X-Google-Smtp-Source: AGHT+IFAOIO1d/iE/5tpsvrjq0hzFjN9sk6VBlLidVlN49CH1ZkO6MA65QTtwl46FDq7idQCIyEQI7r1t4J0W6UQ5z8=
X-Received: by 2002:a05:6402:214d:b0:56e:72a3:e5a8 with SMTP id
 bq13-20020a056402214d00b0056e72a3e5a8mr25655edb.3.1712776997947; Wed, 10 Apr
 2024 12:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <20240408084934.GC21904@noisy.programming.kicks-ass.net> <CAHk-=witEwVvJ6Wh4xdP-sUkLQSwcRTtg_NSuGMMgvYmcs3teQ@mail.gmail.com>
 <CAHk-=wg=Wdct5f9W2-tvwfRefv3xmw1-9Ko+RG+6=xjLu4ndFg@mail.gmail.com>
 <20240409104540.GB21779@noisy.programming.kicks-ass.net> <CAKwvOdktV5vnKwET1PhM8x0urK+LUhAC=uc28RXHUsvq-7_vbA@mail.gmail.com>
In-Reply-To: <CAKwvOdktV5vnKwET1PhM8x0urK+LUhAC=uc28RXHUsvq-7_vbA@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Wed, 10 Apr 2024 12:23:01 -0700
Message-ID: <CAGG=3QWEbY0UbMHBkFMm6RxEz=CG8mauztsc1sT9efcy_MMjUA@mail.gmail.com>
Subject: Re: More annoying code generation by clang
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:37=E2=80=AFAM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Tue, Apr 9, 2024 at 3:45=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Mon, Apr 08, 2024 at 12:42:31PM -0700, Linus Torvalds wrote:
> >
> > > Actually, one of the github issues pages has more of an explanation
> > > (and yes, it's tied to impedance issues between the inline asm syntax
> > > and how clang works):
> > >
> > >       https://github.com/llvm/llvm-project/issues/20571#issuecomment-=
980933442
> > >
> >
> > So that same issue seems to suggest Nick is actually working on this an=
d
> > got stuff merged. Nick, what is the status of your efforts and should w=
e
> > indeed do the below as Linus suggests or should he upgrade his compiler=
?
>
> Sorry, I'm no longer working on the issue.  I should mark that as such.
>
> The feature got hung up on rewriting one of the register allocation
> frameworks in llvm.
> https://github.com/llvm/llvm-project/pull/74344
>
> I have a new set of responsibilities at work so I probably wont be
> working on that issue any time soon.
>
I plan on picking this up. Could you please create a WIP branch on
GitHub with your current work?

-bw

> >
> > > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-=
clang.h
> > > index 49feac0162a5..0dee061fd7a6 100644
> > > --- a/include/linux/compiler-clang.h
> > > +++ b/include/linux/compiler-clang.h
> > > @@ -118,3 +118,15 @@
> > >
> > >  #define __diag_ignore_all(option, comment) \
> > >       __diag_clang(13, ignore, option)
> > > +
> > > +/*
> > > + * clang has horrible behavior with "g" or "rm" constraints for asm
> > > + * inputs, turning them into something worse than "m". Avoid using
> > > + * constraints with multiple possible uses (but "ir" seems to be ok)=
:
> > > + *
> > > + *   https://github.com/llvm/llvm-project/issues/20571
> > > + *   https://github.com/llvm/llvm-project/issues/30873
> > > + *   https://github.com/llvm/llvm-project/issues/34837
>
> 20571 is the cannonical bug for this.
>
> > > + */
> > > +#define ASM_INPUT_G "ir"
> > > +#define ASM_INPUT_RM "r"
> > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_=
types.h
> > > index 2abaa3a825a9..e53acd310545 100644
> > > --- a/include/linux/compiler_types.h
> > > +++ b/include/linux/compiler_types.h
> > > @@ -380,6 +380,15 @@ struct ftrace_likely_data {
> > >  #define asm_goto_output(x...) asm volatile goto(x)
> > >  #endif
> > >
> > > +/*
> > > + * Clang has trouble with constraints with multiple
> > > + * alternative behaviors (mainly "g" and "rm").
> > > + */
> > > +#ifndef ASM_INPUT_G
> > > +  #define ASM_INPUT_G "g"
> > > +  #define ASM_INPUT_RM "rm"
> > > +#endif
> > > +
> > >  #ifdef CONFIG_CC_HAS_ASM_INLINE
> > >  #define asm_inline asm __inline
> > >  #else
> > > --
> > > 2.44.0.330.g4d18c88175
> > >
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
>

