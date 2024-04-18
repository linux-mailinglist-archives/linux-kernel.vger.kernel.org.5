Return-Path: <linux-kernel+bounces-150599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793268AA178
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A36E285C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957B41442F4;
	Thu, 18 Apr 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1gWsDdC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6216ABEB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462736; cv=none; b=IhA4Chy/XpKsI9FBPgq/nOApn2hM71xA2LFUSQti+C1BTCdJeK/gNEhrp4I16ZKor+vf5yZ8rpcYYNfgFvNPqcp/TuiZDXe+RYZdGaw5rkl3luYlvQ3ukRP0WZQqGoKQ39bQhXOSbajvmklyI3jxo1zGthPT+iXjWpU3xDR69WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462736; c=relaxed/simple;
	bh=FuurGdaMgzX2x9p9hW7DG1u1zyapQ60UbXomusCQDWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvLGWe0QT8CsAy7lKUKbtGRkpj7MmrJm2HeNxC6/YCHHpIH4LoC8GYHwUFU99z8hKdj+KAu3vI2hdw3A+ctr113jAHF/8zcfvu4+fxLrhPa4OeukvfEdNcHD+4vijkU4m20JRRMq5Jew5BEhix5CIwP/Cg/qjQUqICDBtWp9HWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1gWsDdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBFAC116B1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713462736;
	bh=FuurGdaMgzX2x9p9hW7DG1u1zyapQ60UbXomusCQDWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B1gWsDdCM5chwfVvYQ7F1WiUne5F3k72zs6SUwyzDGG3ytxhuFQVregWM3Mxansm7
	 +ht/aj0M3ydyimFo84Yh/Rpt0cqRZA59WPhuiBRzfU1M7gV/SnyRG6o0bH5IoceeFw
	 ZJOAojA5PmIECZMYbeMYXK5OIlaKQeVjU4kq6D/pvA89TNd0zFKZwgP4jKT+JaN0kU
	 qM/FtnjswkoWbARZBmCiotULJEIeVyaugwBAWEQo0+FpSQi3uPgamSBPVDIGDA1wrt
	 0egIIyTkEeMOWpfxjwav2jQdH/G0q3Gaj0UkKGb8kdcUuzLwZ+W67XUWQdBnGeW8TG
	 Jfxxrpz5yu1qA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso1917684e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:52:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTHbDHXWaRyiSx9vq5ZOYZSjVh28576woONxSNUs5gU5jbTfvKoIfKGkKV57lh3lr4rzQPgPC8gi13xbtmc9q2MxtT9lumlTtbM1S2
X-Gm-Message-State: AOJu0Yypm5IJPQAyBfPz87f1U4JwvUVrwT7jd3eLEK5Im4kJUjwUJFy9
	DGkxFDvLm0s9slVaFRrSdMUu3bkiMjvxXpN6st5VPIS3Ycqr2joISX2SJqLUbKLdQecmYIhAe9n
	TU+3f6/psVMLyMDaRc5tGjwpahRg=
X-Google-Smtp-Source: AGHT+IFgOoZ35fIoBRDwtYB/gUP3OwO3ayk4YzHoyfLfTWb9cECzk627m65adD5U6JRBjMeAd8GzGefyc7XUTyMezvE=
X-Received: by 2002:a19:9148:0:b0:519:a55:7ee7 with SMTP id
 y8-20020a199148000000b005190a557ee7mr2561185lfj.26.1713462734773; Thu, 18 Apr
 2024 10:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
 <46343CD5-24D6-46BF-92A7-0B0FA0E6937D@alien8.de> <CAKwvOd=3Jrzju++=Ve61=ZdeshxUM=K3-bGMNREnGOQgNw=aag@mail.gmail.com>
 <CAMj1kXH+rNU4pa0ywcgkohXBu4G+iCXML_s9WVJW03ZRwtwW-w@mail.gmail.com>
In-Reply-To: <CAMj1kXH+rNU4pa0ywcgkohXBu4G+iCXML_s9WVJW03ZRwtwW-w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 18 Apr 2024 19:52:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE_1STgZot48Fb_AKb1omMqDFg=65LcFjNAW+6vrLfpBQ@mail.gmail.com>
Message-ID: <CAMj1kXE_1STgZot48Fb_AKb1omMqDFg=65LcFjNAW+6vrLfpBQ@mail.gmail.com>
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

On Thu, 18 Apr 2024 at 17:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 18 Apr 2024 at 17:44, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
> >
> > On Thu, Apr 18, 2024 at 4:15=E2=80=AFAM Borislav Petkov <bp@alien8.de> =
wrote:
> > > How much of this silliness should we expect now for other parts of th=
e kernel?
> >
> > Looks like ARCH=3Dpowerpc sets -mcmodel=3Dlarge for modules and ARCH=3D=
um
> > does for the whole kernel. So that LLVM change may have implications
> > for those 2 other architectures.  Not sure we've had any bug reports
> > or breakage in CI yet, like we have for x86+kexec.
> >
> > > Can we turn this off?
> >
> > Maybe we need to revisit
> > commit e16c2983fba0 ("x86/purgatory: Change compiler flags from
> > -mcmodel=3Dkernel to -mcmodel=3Dlarge to fix kexec relocation errors")
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3De16c2983fba0fa6763e43ad10916be35e3d8dc05
> >
> > at least the -mcmodel=3Dkernel addition (since that patch added a few
> > additional compiler flags that still LGTM).
> >
> ...
>
> > + Fangrui, Ard, who might know of alternative solutions to
> > -mcmodel=3Dlarge for e16c2983fba0.
> >
>
> I think it would be better to use -mcmodel=3Dsmall -fpic. As Nick
> explains, the large code model is really more suitable for executables
> that span a large memory range. The issue with the purgatory seems to
> be that it can be placed anywhere in memory, not that it is very big.
>
> -mcmodel=3Dsmall -fpic is what user space typically uses, so it is much
> less likely to create problems.
>
> Note that I have been looking into whether we can build the entire
> kernel with -fpic (for various reasons). There are some issues to
> resolve there, mostly related to per-CPU variables and the per-CPU
> stack protector, but beyond that, things work happily and the number
> of boot time relocations drops dramatically, due to the use of
> RIP-relative references. So for the purgatory, I wouldn't expect too
> many surprises.
>

Replacing -mcmodel=3Dlarge in PURGATORY_CFLAGS with

--mcmodel=3Dsmall -fpic -fvisibility=3Dhidden

seems to do the trick for me.

