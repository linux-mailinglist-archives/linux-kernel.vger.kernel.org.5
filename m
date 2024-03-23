Return-Path: <linux-kernel+bounces-112419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C2887994
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0CE1F21A9A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F44DA13;
	Sat, 23 Mar 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYQZ2hR8"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759545024
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711213280; cv=none; b=jo+Fk9jiKPhCs51ESQexcRGvXMg7l4TiKRPFBNRStLjH0h5pYT07IFvFNz/UzxahNJGrSC5ky431lC0rsj378dstSSlRB0o2BhS1/IoyPhxIImDBBsr7pZR2/7UoWQkIvLLYZkeMJ7HKpOBBAXl5/eAONdS22AZx54EuJDqs10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711213280; c=relaxed/simple;
	bh=1sBnguAVfkUfiEkbapnN0YLn9KfTnORFOl8wc07Si0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiGNq4HLHJ1AqTRxhyidZhRGqTLbfN9Z3+Xlgc5z0dYe5/+2mTRsBOtaVYt/Re5+9AAKWqajBcIK8YYjCMgV6nJf+Y5Gr0cnYPjTZuBESlNekqWN/OgAYXLkzkBA5szz+RR/lBni87DnGIlMZl5b3zFjoxRBWpU3S6uKsOFCBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYQZ2hR8; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so38599281fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711213277; x=1711818077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+lGh23g6J15PY5KwALiSxS7vG45fb3PifLq6Y840SM=;
        b=VYQZ2hR8QnnxvyOA2vMnIKkmUFXTpWw30dEbuXsDfQCZD4QBADJhwqt9gYJat88K6p
         Cl/dP3fLEF6hoBwf5beUXz5FeIAnDNvRU47K/FOQtQ5FPZ2E3j6s3qnBBfads4HZ5gUq
         pQS1AX6duEmRrqJMU61xBSkWbdk5z4itYhEwJqx53UsO8PAG8Gq4BmoCi0lv380+OKb3
         Zw4VzM9iXvJDZh6Ogiv3Sqy9tIWLwVdR9go82x0/8Y62KUt7HqYKGmonD31GjsQ7w6JD
         QBCi6HT3GCIlVsguLnNSMAOZZmduyndlr/HjZ+UNFjtu9Olj0LNBt32UmLVM7nYMjC7n
         TKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711213277; x=1711818077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+lGh23g6J15PY5KwALiSxS7vG45fb3PifLq6Y840SM=;
        b=jpDI63nspP99sBm60Rpw5VtCemkVq2DEq68cIwZpAXGoKu/Nudpm4erM4CAt4hcObO
         X4n7s/sFGvbgJgy5GN176A7XUvfNi/Rmo0Ejz8PLUNi9uD1JxKZkPziM9Z3J6bNHreBS
         tJ3RAq+NPnRwhF7qFUft49jdj+meIdnVCTNmy8NnM5OPzeJj6bfjf5kl/eWSv6JWFARB
         RbTQHzzd1KxEqDbIrA5blNsP7fgFHAXQOl5V2+UGG1KwnyxgyeeYJSCyFQWD+9ZOo7oS
         kbQJRVs07voGIyffOf+EryuTSA3Wunr6Sx3yeeUdfwZdyGLjY+xIokAB2AYEO5ma3a+K
         07cQ==
X-Gm-Message-State: AOJu0YyZu09DASPm7lu58p35jNkqOoN6OeqmTWryB0lI00Bnh77MyjrK
	CYTKitxfjAwBxon9oorKLjqUAbM6C/hzlPfKZDyZAPeDjlfSf9K0BvNlBNYiyjqdRya1uTrzLHP
	fCPenNfwwhfwurVQJ1eHbqngH0mE=
X-Google-Smtp-Source: AGHT+IHKn/Ou+EVnVTSGJQIcUAv8ILNL7tKfgjx3POAOkZWpAPKdYFi9wk2W+8k3dczHnDNJpLDWW3q3AmerELT/mDM=
X-Received: by 2002:a05:651c:199f:b0:2d6:cd05:1891 with SMTP id
 bx31-20020a05651c199f00b002d6cd051891mr116039ljb.15.1711213277028; Sat, 23
 Mar 2024 10:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <20240322165233.71698-3-brgerst@gmail.com>
In-Reply-To: <20240322165233.71698-3-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 23 Mar 2024 18:01:15 +0100
Message-ID: <CAFULd4adOp=5iBLMHEWiuo2RJ4y2rGFd2_tikx_4txLb+NFE=w@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] x86/stackprotector/64: Remove stack protector
 test script
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> This test for the stack protector was added in 2006 to make sure the
> compiler had the PR28281 patch applied.  With GCC 5.1 being the minimum
> supported compiler now, it is no longer necessary.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/Kconfig                          | 5 ++---
>  scripts/gcc-x86_64-has-stack-protector.sh | 4 ----
>  2 files changed, 2 insertions(+), 7 deletions(-)
>  delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f326903cbe67..88d72227e3cb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -411,12 +411,11 @@ config PGTABLE_LEVELS
>
>  config CC_HAS_SANE_STACKPROTECTOR
>         bool
> -       default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS)) if 64BIT
> +       default y if 64BIT
>         default $(cc-option,-mstack-protector-guard-reg=3Dfs -mstack-prot=
ector-guard-symbol=3D__stack_chk_guard)
>         help
>           We have to make sure stack protector is unconditionally disable=
d if
> -         the compiler produces broken code or if it does not let us cont=
rol
> -         the segment on 32-bit kernels.
> +         the compiler does not allow control of the segment and symbol.
>
>  menu "Processor type and features"
>
> diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_=
64-has-stack-protector.sh
> deleted file mode 100755
> index 75e4e22b986a..000000000000
> --- a/scripts/gcc-x86_64-has-stack-protector.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0=
 -mcmodel=3Dkernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q=
 "%gs"
> --
> 2.44.0
>

