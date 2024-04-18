Return-Path: <linux-kernel+bounces-150440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364388A9F62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666381C21C21
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A116F84E;
	Thu, 18 Apr 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T94+CWwt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8315D5AE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456006; cv=none; b=VUcqGFopiflQIV1HvND8+yWuwlUr35vV91S0ytaRVjsTCSkQdRgpJYEEgfwBs1BiilOKFO4pyLcCJdqNTu08hbOcuwfwu4k0BsJzlkqlQFiK6GbRV33nk4uVXn0WYyCYN66Zy0H2wtJB3Uw0A13fME8QRR4cppc5zsdq361TJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456006; c=relaxed/simple;
	bh=Hp5KTEXhVIq6MVBrhhK0mtcu3ZcUPbGX9anKs1DqGQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4xQ9hPB11egmkcg9t7AG2+TiixRneMXJRNNncZ/8QJ+G/tE1DtzYN8OhGntzfMJjb83Kw7Epv19xsVmzAsvqh7wU3L+hRnv/cc0C1ib+5RDIEeVcMi4mXzHeBBwyEp3ahsfz4AzheaietFD+Di727c03x9lw5dN01BivTjp/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T94+CWwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA2FC113CC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456006;
	bh=Hp5KTEXhVIq6MVBrhhK0mtcu3ZcUPbGX9anKs1DqGQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T94+CWwtWNbbqAdBfNV0gGtJZEWong40cDwDpSpNSmGVixSCnauAIbPcl9O5cL0Mm
	 OYpPaH5XLOojp/uzgCK5ZyxI3sQ5iW8SA0Tmoii6cA3nKjluL+S/AdGaOMBLiRFnRp
	 GW1Mj4mjcljYxW5tu8JbBS+qRNtsYd4M9ElgIyuGbFlKpawTYkr2/4iVoEvnCu5SQl
	 p3gls9UM+zOskZJdZJOLgj8DKLEk7lpvizR0ZfU0PIcV9bQzFkOZK4mSKjrXzNSjc+
	 Sx7+f7V+HrFkjWzzixjH9C85x9NUq31ATzr55IcJ0ryU2FBsG49AhMvz9i6CWQfx0j
	 8kaxfzRfTf+nQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5193363d255so1298591e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:00:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYjnkUhLvqU1xQAprOVSWmCuY/PwfFEIBo9kNPoqEcHibICRcxd+zomVvg0/OTHFyobkrjWWUyTNQmLmlmfl0A/OycxsOems8SD52z
X-Gm-Message-State: AOJu0YxAIiqijB1Q9Bk3veNsBwbWS87DpMpjNFRF968R+2H2ahalEfKk
	dJxvdpRr7qKl6JLbaavydqqJduJ7WZJIPHMgRS31inlnKUvpENvlQ3mbWy2HA/fOCGDEpM50IKt
	b+jaJY4TOG82eDK5h8kAN2l04i9I=
X-Google-Smtp-Source: AGHT+IE3esknj6rnGRTfXAha0sULnP3J2grUQPDIpHSNw5T4GNwd0MTsH9nhVMktl4LlEDfMcVvDnMxpDtmmvnTlV7Q=
X-Received: by 2002:ac2:5334:0:b0:518:bb48:f060 with SMTP id
 f20-20020ac25334000000b00518bb48f060mr1630854lfh.19.1713456004867; Thu, 18
 Apr 2024 09:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
 <46343CD5-24D6-46BF-92A7-0B0FA0E6937D@alien8.de> <CAKwvOd=3Jrzju++=Ve61=ZdeshxUM=K3-bGMNREnGOQgNw=aag@mail.gmail.com>
In-Reply-To: <CAKwvOd=3Jrzju++=Ve61=ZdeshxUM=K3-bGMNREnGOQgNw=aag@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 18 Apr 2024 17:59:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+rNU4pa0ywcgkohXBu4G+iCXML_s9WVJW03ZRwtwW-w@mail.gmail.com>
Message-ID: <CAMj1kXH+rNU4pa0ywcgkohXBu4G+iCXML_s9WVJW03ZRwtwW-w@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/purgatory: Avoid kexec runtime warning with LLVM 18
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Arthur Eubanks <aeubanks@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, morbo@google.com, 
	justinstitt@google.com, song@kernel.org, ribalda@chromium.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	ns <0n-s@users.noreply.github.com>, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Apr 2024 at 17:44, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> On Thu, Apr 18, 2024 at 4:15=E2=80=AFAM Borislav Petkov <bp@alien8.de> wr=
ote:
> > How much of this silliness should we expect now for other parts of the =
kernel?
>
> Looks like ARCH=3Dpowerpc sets -mcmodel=3Dlarge for modules and ARCH=3Dum
> does for the whole kernel. So that LLVM change may have implications
> for those 2 other architectures.  Not sure we've had any bug reports
> or breakage in CI yet, like we have for x86+kexec.
>
> > Can we turn this off?
>
> Maybe we need to revisit
> commit e16c2983fba0 ("x86/purgatory: Change compiler flags from
> -mcmodel=3Dkernel to -mcmodel=3Dlarge to fix kexec relocation errors")
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3De16c2983fba0fa6763e43ad10916be35e3d8dc05
>
> at least the -mcmodel=3Dkernel addition (since that patch added a few
> additional compiler flags that still LGTM).
>
..

> + Fangrui, Ard, who might know of alternative solutions to
> -mcmodel=3Dlarge for e16c2983fba0.
>

I think it would be better to use -mcmodel=3Dsmall -fpic. As Nick
explains, the large code model is really more suitable for executables
that span a large memory range. The issue with the purgatory seems to
be that it can be placed anywhere in memory, not that it is very big.

-mcmodel=3Dsmall -fpic is what user space typically uses, so it is much
less likely to create problems.

Note that I have been looking into whether we can build the entire
kernel with -fpic (for various reasons). There are some issues to
resolve there, mostly related to per-CPU variables and the per-CPU
stack protector, but beyond that, things work happily and the number
of boot time relocations drops dramatically, due to the use of
RIP-relative references. So for the purgatory, I wouldn't expect too
many surprises.

> Otherwise, I think the dedicated linker script is the way to go. We
> really want tight control over what is or is not in the purgatory
> image.

Linker scripts are a bit tedious when it comes to maintenance,
especially with weird executables such as this one and needing to
support different linkers. So I'd prefer to avoid this.

