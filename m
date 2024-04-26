Return-Path: <linux-kernel+bounces-160728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64558B4208
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC101C220EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C9C376E9;
	Fri, 26 Apr 2024 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxY0bmdA"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A639374EB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168931; cv=none; b=SOH9PkwPjRf7mbggZ3X1pYCavukL9lLdW+dotCy8gGk9SJjys/XSQy1nL/V/J7D9n5LwqBSdqPRj32br3Zi6C5A9v0qeTGs08iO5sUfzuYlq9yA5YNMqOBPBASbzQqq/LrgqW6IRZq3d7dhFGQtKts6sCNee1jXjpurYp11u0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168931; c=relaxed/simple;
	bh=PHlZXvishSCx8p5aQiaYNJK80P/epYgCrzogk/D89Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E438GSw4bNBloAwJkg3EXfE2vj9TeZh3QSZ/rEzwTyEc8SQT0cMzvvGIEFuZ573+A68jqlLcHN6mXVaQV75pp5x0nXfNgi+zLpyYfYuQ9BUGYyWxYR1e7LagEGoSck3GK9xgfDxy1FHAvwUKBZhULLraHtiOmZjjHamjBmalk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxY0bmdA; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c709e5e4f9so1663357b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714168929; x=1714773729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nYqAuReYPhHyvG0oPzkahRacQ09qyjEfadJ1sZsoe0=;
        b=cxY0bmdAy5aabtYHxL3i8sxxp2KPQJK5FB3fKJgOqIO6iyetsMwo3tHN+dPwhIoErg
         NO8ZNVRKPw9ZKVDcjBZh6eUFF7zRjeTjNcIHjTuhFTYiW0PqZzaLTuBy/CkulVAVMbBC
         tDuabA4wjxm8arXNS1libTPrSOxaYxslJoBJrhTsT39T9DI1iyhHzFOGiUAT1xli/0ch
         O6wyQG/EyWbs3q9bvMRWNP2PDnjemFN1ejOuG1NPeenbDJyNpE5o1xnzNbccOu+RWTqK
         Rn3DWYxCadtG9cM1Qj/w4YBVcXNh36kz/QMW52W0mqHbEgoR19qK5ywlbPSsPd4I6Q2B
         C+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714168929; x=1714773729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nYqAuReYPhHyvG0oPzkahRacQ09qyjEfadJ1sZsoe0=;
        b=uSzAPB3JSp6w9shVoR7hwZBIncyvnROMm8YUnZlZ6Neq+n+k+0XFcbBJKQtVR9S+e3
         hIoV5L+nVq08/mymOPOeh22mA47r9mf0+vweI2Wc4FoYM2QTK2ZkBZ8BJjYo3QJAYJKT
         9IcX/tDyKdt/R+dk2riRNh1QwUcKXLO3pVF//Vw4o4trHoAETDd+qeMnHAZRuOb0zZk0
         EzIikWvayHrSpZUYWKlyoDKef7rhP9d1m0DVEBBI9rQXydT7L5l+2Us4Lq7eLEIgvkCb
         +B5KAIB/1BkNpTsrVh9xTOqerbcgV0AVa8HnaBwoWJXQ2EfA/SiFZfnXt/HR7kvY/oyQ
         4mFg==
X-Forwarded-Encrypted: i=1; AJvYcCWWR3FX/jib255mV6/K90HKMDvwfOBij87cbVVJ5zs6HvNqtVkLOP5HmALVwG2/C323iylIMknGiVqP7c0ajQdwyW1JV+WDqDsSmtZa
X-Gm-Message-State: AOJu0Yzyz37iqyLFexYT9v3tYsjvvjzK7oAUzm5wzaJLhhmCXbUCWKy7
	oap31OhjTsDgdbAb7gZo8qwkjvIvPRx9ag0rq9GIVA29KcYStAymdt7/UVGaRuLBrf+rMiT3uNI
	4P6yNwvgy0cpHCXU9XDm9BO47L1HkhOBOOweZ
X-Google-Smtp-Source: AGHT+IEs1ykGyWpd9bWv0zuEtnDD6fLODh+Z8H3PEk3ZDG8Dsx0ZeeH/0Uf9MhgRXy6UD8+Wrar9mYVG/U5ZUTThPBM=
X-Received: by 2002:a05:6808:18e:b0:3c7:2616:554e with SMTP id
 w14-20020a056808018e00b003c72616554emr4071966oic.57.1714168929111; Fri, 26
 Apr 2024 15:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-13-ardb+git@google.com> <20240424182659.GA2126602@dev-arch.thelio-3990X>
 <pgsqflimo7d2ozhpmdrmscx25mxs5lypcvwq6mgjs7uixsxvsl@5papnq46mwbs> <20240426215351.GA3278657@dev-arch.thelio-3990X>
In-Reply-To: <20240426215351.GA3278657@dev-arch.thelio-3990X>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 26 Apr 2024 15:01:56 -0700
Message-ID: <CAFhGd8pasnTTv87V3LYpzCz=DdS8dXGA8Z9qGEqw=K+C_Xvf=A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, 
	kexec@lists.infradead.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:53=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Fri, Apr 26, 2024 at 09:32:52PM +0000, Justin Stitt wrote:
> > Hi,
> >
> > On Wed, Apr 24, 2024 at 11:26:59AM -0700, Nathan Chancellor wrote:
> > > On Wed, Apr 24, 2024 at 05:53:12PM +0200, Ard Biesheuvel wrote:
> > > >  arch/x86/purgatory/stack.S        | 18 ------------------
> > >
> > > This needs a small fix up to build.
> > >
> > >   make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', n=
eeded by 'arch/x86/purgatory/purgatory.ro'.
> > >
> >
> > I was trying to reproduce this build failure, but to no avail. I am
> > curious what your build target / build command was.
> >
> > It is clear that stack.S has been removed so your change makes sense, I
> > don't doubt that -- I just cannot get that specific error message you
>
> Odd, I was using my distribution configuration for the test but it is
> easily reproducible with allmodconfig:
>
>   $ make -skj"$(nproc)" ARCH=3Dx86_64 LLVM=3D1 allmodconfig arch/x86/purg=
atory/
>   make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', neede=
d by 'arch/x86/purgatory/purgatory.ro'.
>   ...

Agh, I was just doing a defconfig followed by a menuconfig to manually
enable all the kexec and purgatory stuff. I wonder which one I missed.

allyes/allmodconfig is what I needed here :thumbs_up:

>
> > encountered (what is a .ro file supposed to be, anyway?).
>
> Read only? Relocatable object? *shrug*
>
> Cheers,
> Nathan

