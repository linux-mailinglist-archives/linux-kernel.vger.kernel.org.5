Return-Path: <linux-kernel+bounces-123772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845DB890D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D9A1C31BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1611713B292;
	Thu, 28 Mar 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1mhqT/S"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7313A3E7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664552; cv=none; b=EMe+bpWMeCX9Q1zkl1++xXMjTcMwO4KoTiMf5/jc+tiak8i8W/JQDhCbz2Jgn5nmdy73XrahCkDw1CN/M0IdIWnxS5JpH03nbsunWJqzAoKZTOA8V3K8JCENuaweUTFJbHDWJc9nT7OD118opilk17whM6kYY9829QkPQRtY+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664552; c=relaxed/simple;
	bh=pgT/xSr/q7YOUPevv2EeewjHySxRn4YCFK6IyZ/aNb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYvrLAPWhh4C0IjGzkqPXhaVl9kMzLjcetLYe9F25ujISD3TgtTmhEt6rwjJn2djSBoWKR07O9RyhcdxqsCQEYtlIorujIDiTO4VyYYIVG2U2rTN40zDAvCQ7Nh2GDedqZ0KD24PakrL2lKtzkondpB6XdQ2zKJnlIxf5lIe5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1mhqT/S; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so2594716a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711664548; x=1712269348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/OjdkXwLEp7mczzswJbuZjPn4dGgroiJ8sIvpa89YE=;
        b=j1mhqT/SyNftpjfNH+zYEEP9coHGcwBWWQy/ZSkTjfvAw3rA19DMTGMJiwNV3HdhUy
         eNUFWhiedCnTiuIp04Dms8Fr6D7OH5YRFeGZZzUv9ZsuZD4nL+3e/cA4l1MPR2SbezvJ
         sFLCzZ0OUW56mQaCkqV+wu8GcI8C6+BDQNexgcqbADDnIR5ok3GtzkkMpd5EO4OA3vdA
         /MQVFKxjI6/3knvDHqZYGsG04bLtLFuCUbrBYRHpPl6T1nN3y4FGLHi2OSOdDKcEZ1lT
         AgtX/QwNA6h/Esdg4Yh+w2uRRgvWOofOF6YgOawUgg2fvTDA37hsJnIXFTMdwGixGgy7
         9TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711664548; x=1712269348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/OjdkXwLEp7mczzswJbuZjPn4dGgroiJ8sIvpa89YE=;
        b=Fz7VMBiYsJksfyIJm8N9SjmRSE6btGVdSjz031orH13r3ABBcwARuWFz4lVlgok3SU
         qA/7U39blwx1vSeRiDs5TilyS4CyLLi2+nAM54IHoMqSCAVlV8q05oE0VJ0R9H/hnGei
         kjsnmKu6we/Ypiyt3qI+Dbyud/wFVbdY+0PXnl7Ab4uxLqDtATD+ONrid7Fm0NCC7oNy
         XErKIjBTkMnZmhe5BylOLwjkHdh1v1vQoaSOFUylORFQxJz6CVISzsjiFWR01+GBdgfh
         q+Nu5FRR2Zw03dw3G0eLkPnsYprvTcNF1huf0XmHBzaZswWM4onfbL3C5qg36XQAeMHt
         eR3g==
X-Gm-Message-State: AOJu0Yy8qBDxje9m1itMEmC0UCfCzQOECnommLtXS4H4T+qPDizAAjyI
	zHlxLUEMNS4+ABSQ/V0zJ+JCqeudCjRP+jr/GiTRbdcLvaser7I1/Q+I7UVz0ZNNKE+IemtkITc
	rtFFj92MBPSNVGGyc83sPlP0G9rp749YMHQGJ
X-Google-Smtp-Source: AGHT+IGxckfdewYCc6Tjhn2/sl6SaRBJ+pS/iXe46GfGkpDclyLzmNtDvyladQRwAYhZrkyCk/zHbrjCjRNd7FWr0Ac=
X-Received: by 2002:a50:9feb:0:b0:56c:53b2:9e32 with SMTP id
 c98-20020a509feb000000b0056c53b29e32mr527053edf.13.1711664547964; Thu, 28 Mar
 2024 15:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-5-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-5-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 15:22:16 -0700
Message-ID: <CAFhGd8qDCMkP6rZ6A6i3b7DuJ0Rzem=V0TxAkvmMTsZM3NH43A@mail.gmail.com>
Subject: Re: [PATCH 4/9] kcov: avoid clang out-of-range warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The area_size is never larger than the maximum on 64-bit architectutes:
>
> kernel/kcov.c:634:29: error: result of comparison of constant 11529215046=
06846975 with expression of type '__u32' (aka 'unsigned int') is always fal=
se [-Werror,-Wtautological-constant-out-of-range-compare]
>                 if (remote_arg->area_size > LONG_MAX / sizeof(unsigned lo=
ng))
>                     ~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>
> The compiler can correctly optimize the check away and the code appears
> correct to me, so just add a cast to avoid the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  kernel/kcov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index f9ac2e9e460f..c3124f6d5536 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -627,7 +627,8 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsig=
ned int cmd,
>                 mode =3D kcov_get_mode(remote_arg->trace_mode);
>                 if (mode < 0)
>                         return mode;
> -               if (remote_arg->area_size > LONG_MAX / sizeof(unsigned lo=
ng))
> +               if ((unsigned long)remote_arg->area_size >
> +                   LONG_MAX / sizeof(unsigned long))
>                         return -EINVAL;
>                 kcov->mode =3D mode;
>                 t->kcov =3D kcov;
> --
> 2.39.2
>

