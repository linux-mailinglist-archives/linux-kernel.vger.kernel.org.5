Return-Path: <linux-kernel+bounces-137245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61589DF67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2981F215F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD90A13AD3F;
	Tue,  9 Apr 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmiOk1oY"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135913AD17
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677048; cv=none; b=TDPBRoGn+xLgvAqql46R4tKL9NNTohl9DyofjK1r/AMJiHJ10kN6QitNieY5bewcUe1pa1m9CsSyC3x1U4febVEJtOWp2tITJQf16WqUyfTllXoUKqDPHiDbNrRtsHJES4e4afZF2RP5HQfVJ0xh6n9TAzLpOYW7I+d/a8FpOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677048; c=relaxed/simple;
	bh=Aqminu13BA5RfzICIWKV4tMcJYaOt32oW1/5Ll0JWxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrzaF4gIyCRBrNRF2LX5dkBollPPAaOdOfvb0NswQRyHhvLT2TVSVzR3hrMKQ6UkSXzxnv9nru+HHsrXnNIY0qBF1l9Qiy2a/doPWxQ3ErxzSLbt7geHcVu0VGSgCIefDbSkOZ31ntfUUilHtscfdBH9NTph1Av56E1o+U/jc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmiOk1oY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34641b7c49aso344006f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712677045; x=1713281845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3wHvYb+xH1G7TOL58ej8375ZusY8e96JWmR5Aw1tE4=;
        b=gmiOk1oYSBunqK3ErTTHgzFtPqAjq1VzuV3RShmBJNsj5JMsyqqfi1tOU5EVF6zVtb
         B7kOnT9nlSc6xdLpAfwM1XE07m2yr3xMKrazayG+ZTdw5TBmgRsSYq/HUbH1l0pM1MZX
         dQjHK58SvJgP2BubR5/0mya3hylLzINvF2yNBUpUQJ1MCUaZk4U+y0R6D5ybf7Bbr1mU
         SGDNcWUyMcV1PUJGlHMWY0mqigE8d/9uC8uNTvp6sgmh8+oD+J0m9bkRLnWDcOjV36J5
         j+iUaG5/7/AUDWhZRXI4rlExegyiRUsv9saMhbO0reki/hZl/SaP+45qb7SHncRfpAG/
         6uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677045; x=1713281845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3wHvYb+xH1G7TOL58ej8375ZusY8e96JWmR5Aw1tE4=;
        b=I6EEINP8B0bMoy5JrR8sY1FPCshyxeSuq4G4hTwpI7YFtSw8N3RTPnZ9GxHVct+D97
         s2JB410/kF9b94lbgeIJH5xE/bjxzeqCsHmRoCtzMN/XErr+HEBioYNrboa650Ub1rZ3
         cLfZXNBKQ0Iss+m/zVP0cxjDjFB0xz6J7zy9GHpoxcVWezsoQxtDW0LqmOHQ9nInD5FV
         wqgoDcailkiWJrQcZmKny8wycgoMSkx5lbrt/Umgx2oNUiRppimmJrJqvHvWIjrdi4q3
         SPbgZH+e2JBXB/xZFs0Bs+bZuWUSA/j8lsSuDTuLo6vRBWmeonFgkbEUSynbCfkl/i9E
         P3jA==
X-Forwarded-Encrypted: i=1; AJvYcCWfM/o6cvvIj6tQEWcIAViDr52dNFc85ZigMgh+IWe0bCTyzufvvOkZEqoqqvLjFlvHw4sebCQ6NOoBV3W1NYhd7xKmJ7X7adElyFtA
X-Gm-Message-State: AOJu0YxP8VyRBwYw4c4xAfd3+EbIvNk5AG7i90KnCWc/zKPo857shJxc
	CPnqrD9s03UsEYxGuYLiQVhLTBUTi7IFjkjefYY62mpj13KjfmqO/O1eKHZiQy2f+f1/c45vOLN
	9gSF73Kuarww9MrFiT7SiUBLD6AwQivfRPsyw
X-Google-Smtp-Source: AGHT+IEATApo3o8XfWViXxHA3nBf59pbXIp4qO5W17tsNOoEx8kff/kEukGenu4hXqklT5aG6y50jY3+j+NZ6v/SAgs=
X-Received: by 2002:adf:ec50:0:b0:33e:8aba:cd0a with SMTP id
 w16-20020adfec50000000b0033e8abacd0amr75524wrn.9.1712677044575; Tue, 09 Apr
 2024 08:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <20240408084934.GC21904@noisy.programming.kicks-ass.net> <CAHk-=witEwVvJ6Wh4xdP-sUkLQSwcRTtg_NSuGMMgvYmcs3teQ@mail.gmail.com>
 <CAHk-=wg=Wdct5f9W2-tvwfRefv3xmw1-9Ko+RG+6=xjLu4ndFg@mail.gmail.com> <20240409104540.GB21779@noisy.programming.kicks-ass.net>
In-Reply-To: <20240409104540.GB21779@noisy.programming.kicks-ass.net>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 9 Apr 2024 08:37:10 -0700
Message-ID: <CAKwvOdktV5vnKwET1PhM8x0urK+LUhAC=uc28RXHUsvq-7_vbA@mail.gmail.com>
Subject: Re: More annoying code generation by clang
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 3:45=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Apr 08, 2024 at 12:42:31PM -0700, Linus Torvalds wrote:
>
> > Actually, one of the github issues pages has more of an explanation
> > (and yes, it's tied to impedance issues between the inline asm syntax
> > and how clang works):
> >
> >       https://github.com/llvm/llvm-project/issues/20571#issuecomment-98=
0933442
> >
>
> So that same issue seems to suggest Nick is actually working on this and
> got stuff merged. Nick, what is the status of your efforts and should we
> indeed do the below as Linus suggests or should he upgrade his compiler?

Sorry, I'm no longer working on the issue.  I should mark that as such.

The feature got hung up on rewriting one of the register allocation
frameworks in llvm.
https://github.com/llvm/llvm-project/pull/74344

I have a new set of responsibilities at work so I probably wont be
working on that issue any time soon.

>
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-cl=
ang.h
> > index 49feac0162a5..0dee061fd7a6 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -118,3 +118,15 @@
> >
> >  #define __diag_ignore_all(option, comment) \
> >       __diag_clang(13, ignore, option)
> > +
> > +/*
> > + * clang has horrible behavior with "g" or "rm" constraints for asm
> > + * inputs, turning them into something worse than "m". Avoid using
> > + * constraints with multiple possible uses (but "ir" seems to be ok):
> > + *
> > + *   https://github.com/llvm/llvm-project/issues/20571
> > + *   https://github.com/llvm/llvm-project/issues/30873
> > + *   https://github.com/llvm/llvm-project/issues/34837

20571 is the cannonical bug for this.

> > + */
> > +#define ASM_INPUT_G "ir"
> > +#define ASM_INPUT_RM "r"
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_ty=
pes.h
> > index 2abaa3a825a9..e53acd310545 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -380,6 +380,15 @@ struct ftrace_likely_data {
> >  #define asm_goto_output(x...) asm volatile goto(x)
> >  #endif
> >
> > +/*
> > + * Clang has trouble with constraints with multiple
> > + * alternative behaviors (mainly "g" and "rm").
> > + */
> > +#ifndef ASM_INPUT_G
> > +  #define ASM_INPUT_G "g"
> > +  #define ASM_INPUT_RM "rm"
> > +#endif
> > +
> >  #ifdef CONFIG_CC_HAS_ASM_INLINE
> >  #define asm_inline asm __inline
> >  #else
> > --
> > 2.44.0.330.g4d18c88175
> >
>


--=20
Thanks,
~Nick Desaulniers

