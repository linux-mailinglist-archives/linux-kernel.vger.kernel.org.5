Return-Path: <linux-kernel+bounces-108267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A5880889
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D139D1C2284C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BAE15C9;
	Wed, 20 Mar 2024 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tf93vdkt"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074F1364
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894657; cv=none; b=jsGXQE6vtIBE5og102rmI/wDgztWOCiCug4VleTT0nW9ij0rXBbZSdhXUhzq6EWTXXR/AGvc8NWA0FppZSh4Ugl4rPEuuA7yg2loO+pi2Actmw0j2ocAowT0oDSQ+2lhlWq5S2BeMWUSwAdZ7gLVmh1MbqYvdDVy91EmXIBjBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894657; c=relaxed/simple;
	bh=w6xT7TQIIw629OsLA2mpj4+Cm8CL0j6xp7UsXUzQdAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzFJ+sYDJPr8CpPfU3aq6N+ALyppFgGg7roIcqnjvHDXlGXlSadW115bTS85u41qaybh8qDRoe5gIRHS3tyS9l+k56f3CrAVcv2OV7jpdGOCTRi+KhA3iQH33d0FGvNnwRAKIfZqeBQt7seE2CFdfDkPzVcHYrCb2u6eFnNBUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tf93vdkt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so7738692a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710894654; x=1711499454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZl/MC6G04dgdXWq6n8Jo9rFZ4kdECi4eDf/v32uMoM=;
        b=tf93vdktKGXgvMi2OBANw36z3xAQA+ILE9EafUgsuib/q7vga3OOWWo2hGr6FyLB9Z
         o8gg7Na2jnjmB+TK4OukDIHEEk6CkwwR58z9ElI8cldehaLEYbQduWKyuiQWUhe8KsP5
         s+d56Pufm/MfbK1wSXLb9MxQngrTcXmb3LdMWwBCGILbIkwCE/++7+zcSrwn75g5aTCp
         KCHId80aBV0JBKBeT+htDQjFC5+ok6P/2wSmYYYuyI3EGExpxgxNzQXTIxelWNsrw/FI
         Ns9Klbtp9aFBW36HI4UyQaTdoI4ObKcte+AtM5XKJmohZt8jmw4hoJZg4v0vMZGwYCrP
         ZVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710894654; x=1711499454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZl/MC6G04dgdXWq6n8Jo9rFZ4kdECi4eDf/v32uMoM=;
        b=rkVBARHDwKTHkvN44lHqZr1oT4WAwX4wA0s3/IjoCk/nR22cJCHmQMYfj7DTAtxmuq
         eO5W7YRmeR6HsiY+BdvEY8ntAkKgTKrI7L3iVD2eMdpoZzFiZlJ3rC51vxGVrvZhH49L
         JTpeQV8A2GW3Bkrx61bGCk2dMGhjeS9YIKeyLr5KpfDttfZ209fWmvZltzynDxTyl9LD
         4c941+e1y+6/W+YPZcAJwjyhNEO3Gup2fcuHU9jyk1lak+IGTI3SLm2qux8/QYXqS1Ww
         4Uf/m8b+paHsIbOAYXIGaUj9yBhorX9z4zBNHyj/swIMVhv26UFdo2l/l5rQBukop6Kx
         e/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4bks0j6NnsZifw3vQ6K0sDZMQA33IIxHScJkysxI7SNDvJbqlq/5Z0tfBzxcmcgMkX1HF5S6wXcXvVfbxbbK5r8HGiMWrEDl+TRKB
X-Gm-Message-State: AOJu0Yxw5Vl/QO0B85sSogFdf9keNv3dMHEXqc3l2lKH2B1EC149MeHM
	zS7AgMIgVVzkjPQmpLXZdkbHMq8epvRlAoI5vJmnV9/P+AWjZxpPjGK0tgkpQqT6Z65Sy5gqzvD
	Vywut6nfLHm6bnehpWPFcsQbWLHPsZbAcYTFV
X-Google-Smtp-Source: AGHT+IFVRbRtTK93+JswPYwn75sDfz6NqIQ9pLfPvYXf2GKGX5xRtCwHXsSI1NF/q7+RSh2ICglMKo8eb6X0v/DUYE8=
X-Received: by 2002:a05:6402:5d1:b0:566:b09e:80c4 with SMTP id
 n17-20020a05640205d100b00566b09e80c4mr242572edx.19.1710894654186; Tue, 19 Mar
 2024 17:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
 <20240319-tracing-fully-silence-wstring-compare-v1-2-81adb44403f5@kernel.org>
In-Reply-To: <20240319-tracing-fully-silence-wstring-compare-v1-2-81adb44403f5@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 19 Mar 2024 17:30:41 -0700
Message-ID: <CAFhGd8q_4QfjPwGhtfOA40ZGNF7_wf3V43rAvcb_qXQnz1TFOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: Ignore -Wstring-compare with diagnostic macros
To: Nathan Chancellor <nathan@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	ndesaulniers@google.com, morbo@google.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:08=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Commit b1afefa62ca9 ("tracing: Use strcmp() in __assign_str() WARN_ON()
> check") addressed a clang warning, -Wstring-compare, with the use of
> __builtin_constant_p() to dispatch to strcmp() if the source string is a
> string literal and a direct comparison if not. Unfortunately, even with
> this change, the warning is still present because __builtin_constant_p()
> is not evaluated at this stage of the pipeline, so clang still thinks
> the else branch could occur for this situation:
>
>   include/trace/events/sunrpc.h:705:4: error: result of comparison agains=
t a string literal is unspecified (use an explicit string comparison functi=
on instead) [-Werror,-Wstring-compare]
>   ...
>   include/trace/stages/stage6_event_callback.h:40:15: note: expanded from=
 macro '__assign_str'
>      40 |                              (src) !=3D __data_offsets.dst##_pt=
r_);       \
>         |                                    ^
>   ...
>
> Use the compiler diagnostic macros to disable this warning around the
> WARN_ON_ONCE() expression since a string comparison function, strcmp(),
> will always be used for the comparison of string literals.
>
> Fixes: b1afefa62ca9 ("tracing: Use strcmp() in __assign_str() WARN_ON() c=
heck")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYs=3DOTKAZS6g1P1Ewadfr0qoe6LgOV=
SohqkXmFXotEODdg@mail.gmail.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  include/trace/stages/stage6_event_callback.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace=
/stages/stage6_event_callback.h
> index 83da83a0c14f..56a4eea5a48e 100644
> --- a/include/trace/stages/stage6_event_callback.h
> +++ b/include/trace/stages/stage6_event_callback.h
> @@ -35,9 +35,14 @@
>         do {                                                            \
>                 char *__str__ =3D __get_str(dst);                        =
 \
>                 int __len__ =3D __get_dynamic_array_len(dst) - 1;        =
 \
> +               __diag_push();                                          \
> +               __diag_ignore(clang, 11, "-Wstring-compare",            \
> +                             "__builtin_constant_p() ensures strcmp()" \
> +                             "will be used for string literals");      \
>                 WARN_ON_ONCE(__builtin_constant_p(src) ?                \
>                              strcmp((src), __data_offsets.dst##_ptr_) : \
>                              (src) !=3D __data_offsets.dst##_ptr_);      =
 \

What exactly is the point of the literal string comparison? Why
doesn't strcmp do the trick?

> +               __diag_pop();                                           \
>                 memcpy(__str__, __data_offsets.dst##_ptr_ ? :           \
>                        EVENT_NULL_STR, __len__);                        \
>                 __str__[__len__] =3D '\0';                               =
 \
>
> --
> 2.44.0
>

