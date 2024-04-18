Return-Path: <linux-kernel+bounces-150749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E08AA416
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67591C214E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD316C69F;
	Thu, 18 Apr 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCIu2P61"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AA5427E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472600; cv=none; b=Dmdd78UIUzA4nGnXNK12Shn/BkulKK7/4dAXHzOMfymIkTAlI7glQmLXVf+0Iy78yMok37IrzeKwmudwV7a2rpP581nR2Xs6M7V4IxSZern2eTc/oVrKCIMKlxJv/E7uF/ucrHNB5lcG13d9O2a+unZUqRC8kHahhxQayGKk5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472600; c=relaxed/simple;
	bh=Mh9F5g+oXDReUBU4BN7gIrjCxYn7HhvawXsn2aMyfys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2phfzRtL/9IKintDOVuHouPxV/VhB7eBIQ7ySC5VaPboiE77LhgUWXWd9H93PsAh2utn3xgOSVWd4keQGLfVzTIDvBHbqwq8HjRqi+UWKlOgkyGyFhYWJgLUaBeTPZ+6SzGnXo8XEoLdLHkouN7bfOnZmf97PwNy/S0V4ic3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCIu2P61; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-418dde387a3so10449475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713472597; x=1714077397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPfiNmCGro4QcNjJ3nhSDpGjz+OaJx9a/1wRIxpFgzM=;
        b=iCIu2P61J+hhXakJ7d+xXEVgSSM7nIV2x9JOrQjUVsxNu+C4DOjSgJr9J0Hw7RjYDz
         gHjtItDWLGkAZr4rBVuHHMmpRFE1dCwTR57qg0GyiAs3Ft7GSwK8LFn/ZvhvUhg1gYKi
         m1C3M8vsWa3I1E/Xb9daTi6P369kEEr0t+1e5yXPSQvcA5wc0uAdYH9du5syViNYk0ki
         BOLbGegpCN9T2zIpM4FFzu3iOOxy36nh5gBlRjneNL/q/uHdiDBG46wmEfWyzmM9ySVs
         2feYtQnDqWYQu5iQ5Ho47SvJNE2mzdZV06iTEjNX/QbcCvsbe2DrwoZHN/PnHph6WBzL
         ogDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472597; x=1714077397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPfiNmCGro4QcNjJ3nhSDpGjz+OaJx9a/1wRIxpFgzM=;
        b=VCMQIn+9aSYKsy5f5bEfR0igGXDDk+wSj2ZmWQmOKg6kp/pf8+oiEwSvtNjLU+YaCG
         BtJ6/p9IjFehXzJ2G38o7fsjmlt2oBzgmSZAiEYNbh5cHRvP6KqQmLgQ95e2d6FrSsYj
         9rSaNtelC78Grr2vBdEwh5knkwcYuDGTBbT5mqsNYGruIaavovvyNJuH9pt1I3bxQ4tJ
         8hCkEOVBR6Gu6pjL7UOYk4XDKymu/zkM5VEA4x3lA+178/2tXZMppCMr0ZrG2XLtZXxF
         0VgVH/0ciE/27otx4VdGqWTiUMMcnbeTU6msZ/PeB12AsTu+gx78z2f9dCA2G52d22jF
         K4kw==
X-Gm-Message-State: AOJu0Yzi0WA/9cskVaEofF46uje/IT6dnapcRzPQdAMIWUHupchEyAN2
	FQQj9LN0mlC8BN0RmDzXXf1cQxjusPhhQjUpaRxuuZHH2NOytx2yV9AZWJn7h1bHTW0PlwicvQB
	jliOFTXsL6U1pTfZwnkBanq3nF8oUmISDFywb
X-Google-Smtp-Source: AGHT+IEklnrO2WDKzaHiHi1PW4ToHeoh/2oQmHUuqMoeV/OGXWxyGt114S8v7P7qexVSDvkVt7+5mI6IM3kvYQJn1V0=
X-Received: by 2002:adf:a495:0:b0:341:d6c3:5c4f with SMTP id
 g21-20020adfa495000000b00341d6c35c4fmr32719wrb.21.1713472596846; Thu, 18 Apr
 2024 13:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418201705.3673200-2-ardb+git@google.com>
In-Reply-To: <20240418201705.3673200-2-ardb+git@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 18 Apr 2024 13:36:22 -0700
Message-ID: <CAKwvOdnNurTJNb7iOVW4dpkV-rZGWg2t3HuLkL+B5sNOin39WA@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>, 
	Ricardo Ribalda <ribalda@kernel.org>, Fangrui Song <maskray@google.com>, 
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org, 
	Steve Wahl <steve.wahl@hpe.com>, Vaibhav Rustagi <vaibhavrustagi@google.com>, 
	Andreas Smas <andreas@lonelycoder.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:17=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> On x86, the ordinary, position dependent 'small' and 'kernel' code models=
 only
> support placement of the executable in 32-bit addressable memory, due to
> the use of 32-bit signed immediates to generate references to global
> variables. For the kernel, this implies that all global variables must
> reside in the top 2 GiB of the kernel virtual address space, where the
> implicit address bits 63:32 are equal to sign bit 31.
>
> This means the kernel code model is not suitable for other bare metal
> executables such as the kexec purgatory, which can be placed arbitrarily
> in the physical address space, where its address may no longer be
> representable as a sign extended 32-bit quantity. For this reason,
> commit
>
>   e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=3Dker=
nel to -mcmodel=3Dlarge to fix kexec relocation errors")
>
> switched to the 'large' code model, which uses 64-bit immediates for all
> symbol references, including function calls, in order to avoid relying
> on any assumptions regarding proximity of symbols in the final
> executable.
>
> The large code model is rarely used, clunky and the least likely to
> operate in a similar fashion when comparing GCC and Clang, so it is best
> avoided. This is especially true now that Clang 18 has started to emit
> executable code in two separate sections (.text and .ltext), which
> triggers an issue in the kexec loading code at runtime.
>
> Instead, use the position independent small code model, which makes no
> assumptions about placement but only about proximity, where all
> referenced symbols must be within -/+ 2 GiB, i.e., in range for a
> RIP-relative reference. Use hidden visibility to suppress the use of a
> GOT, which carries absolute addresses that are not covered by static ELF
> relocations, and is therefore incompatible with the kexec loader's
> relocation logic.
>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>

Thanks Ard!

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: ns <0n-s@users.noreply.github.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2016
Fixes: e16c2983fba0 ("x86/purgatory: Change compiler flags from
-mcmodel=3Dkernel to -mcmodel=3Dlarge to fix kexec relocation errors")

(I don't have a kexec setup ready to go; maybe someone that does can
help test it.)

> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Ricardo Ribalda <ribalda@kernel.org>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Arthur Eubanks <aeubanks@google.com>
> Link: https://lore.kernel.org/all/20240417-x86-fix-kexec-with-llvm-18-v1-=
0-5383121e8fb7@kernel.org/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/purgatory/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index bc31863c5ee6..a18591f6e6d9 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -42,7 +42,8 @@ KCOV_INSTRUMENT :=3D n
>  # make up the standalone purgatory.ro
>
>  PURGATORY_CFLAGS_REMOVE :=3D -mcmodel=3Dkernel
> -PURGATORY_CFLAGS :=3D -mcmodel=3Dlarge -ffreestanding -fno-zero-initiali=
zed-in-bss -g0
> +PURGATORY_CFLAGS :=3D -mcmodel=3Dsmall -ffreestanding -fno-zero-initiali=
zed-in-bss -g0
> +PURGATORY_CFLAGS +=3D -fpic -fvisibility=3Dhidden
>  PURGATORY_CFLAGS +=3D $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFI=
LING
>  PURGATORY_CFLAGS +=3D -fno-stack-protector
>
> --
> 2.44.0.769.g3c40516874-goog
>


--=20
Thanks,
~Nick Desaulniers

