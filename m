Return-Path: <linux-kernel+bounces-71606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E985A7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D91F22C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0183AC1E;
	Mon, 19 Feb 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUW/Qgfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759C3A297
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357276; cv=none; b=CKXm09vnX+zLJXH+7Pyciz9L7BHwizgfNC4fydcsIGYhGaJSQfJgMEBgAifrRurqjl6y9Unee23TQIEgeTcB1skGf1rGlY2p7LnR97ihjV5BhraV25+qDSjY4lOM0+pvin354OWpLxnhDE/Uf7YEkmVK373yo0OnNbIqVxBCLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357276; c=relaxed/simple;
	bh=kN7/FxZg2B4U0kkEnp+f+35AOQ3P4uh2oK/ZbnyEGPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBwdy7v3qk6MTzBJtvUFddHJ7FdDwjWLTD7zfAS6KtilKgvchCSexkBamThjsVa3LDPrAg/WGCtb3uXjv6hDOVxFew7I/71EUtPZB/YywWibFHyUaC2mQ2R0Ez5oobr69BzWo5x2ZFrWro65gWLhScrJpSp2OaChjcUyLNKN4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUW/Qgfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB30C43399
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708357276;
	bh=kN7/FxZg2B4U0kkEnp+f+35AOQ3P4uh2oK/ZbnyEGPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tUW/QgfmsH4Vdh129JzdOQ8l/LvoHRZylg24rMkxUzMkcwRP1NM25hd7+faU2GhR9
	 s/DK0pnKYYV336dXciaX/y4OGC/Jl01tgSop5r5DS61s4vWMgAhUESaw4UJAHxLjGC
	 W7HMQl3b5xWjxXbpyzfblL74xUvZfQ7ddbg1Hvjdk9I+Y4zq+xkXjjMfBtNvOCr4yA
	 1rLt1TWxGokbLVqvOGWPSZonAlTHfmMqfMkRnfSC1sklpMmDXdJJaFgWJqBqnoElte
	 IdIVCGoBxUuvjgS2V9oN8EcTXyhccQOL4NNdlCqWQH/kz625CAO4bPOIuwHFxj/Hnm
	 L24vMOtufDYvg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d204e102a9so57343221fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:41:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgdnoC3eJq82dl1keITXN9xB310UZu+Fc0i6m+MKjmmglLWxAAuBy4mdtwWDPfZWRtu0OmWeCKqqfCaKRz+ySjoqPPkxwemQPz4ATM
X-Gm-Message-State: AOJu0YwGIpe63u8JZUZtMOsCRkXnTdu0ejdOdWt5gVNjD6q0Np5vOqDy
	H4DjTQhzt9wCxNCPD6lYpSo0v9KiP12Jz3BOE6nhbSrsU2u0HDKILPdfcmnSfldqsU/Q0jDhK/S
	o2Ft5eipFMAYlJ62HPMgnpkQNC0g=
X-Google-Smtp-Source: AGHT+IHkRv5759OCKHrFBcoZL5QX4beAd5RFXwDpYEZXX7suzJ+JwQ8On/fgdp7Ct96YAZ0TiFYkz+Xfo3acVf3B/Lo=
X-Received: by 2002:a05:651c:218:b0:2d2:3437:ef4a with SMTP id
 y24-20020a05651c021800b002d23437ef4amr2717698ljn.42.1708357274494; Mon, 19
 Feb 2024 07:41:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206074552.541154-1-maskray@google.com> <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
 <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
 <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com> <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
In-Reply-To: <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Feb 2024 16:41:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
Message-ID: <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Fangrui Song <maskray@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 at 15:43, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ard,
>
> On Mon, Feb 19, 2024 at 11:57=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> > On Mon, 19 Feb 2024 at 11:56, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Mon, 19 Feb 2024 at 11:03, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> > > > On Tue, Feb 6, 2024 at 8:46=E2=80=AFAM Fangrui Song <maskray@google=
com> wrote:
> > > > > The generic constraint "i" seems to be copied from x86 or arm (an=
d with
> > > > > a redundant generic operand modifier "c"). It works with -fno-PIE=
 but
> > > > > not with -fPIE/-fPIC in GCC's aarch64 port.
> > > >
> > > > Thanks for your patch, which is now commit f9daab0ad01cf9d1 ("arm64=
:
> > > > jump_label: use constraints "Si" instead of "i"") in v6.8-rc5.
> > > >
> > > > > The machine constraint "S", which denotes a symbol or label refer=
ence
> > > > > with a constant offset, supports PIC and has been available in GC=
C since
> > > > > 2012 and in Clang since 7.0. However, Clang before 19 does not su=
pport
> > > > > "S" on a symbol with a constant offset [1] (e.g.
> > > > > `static_key_false(&nf_hooks_needed[pf][hook])` in
> > > > > include/linux/netfilter.h), so we use "i" as a fallback.
> > > >
> > > > https://gcc.gnu.org/releases.html says gcc-5 was released in 2015,
> > > > i.e. after 2012 ...
> > > >
> > > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > > > Link: https://github.com/llvm/llvm-project/pull/80255 [1]
> > > > >
> > > > > ---
> > > > > Changes from
> > > > > arm64: jump_label: use constraint "S" instead of "i" (https://lor=
e.kernel.org/all/20240131065322.1126831-1-maskray@google.com/)
> > > > >
> > > > > * Use "Si" as Ard suggested to support Clang<19
> > > > > * Make branch a separate operand
> > > > >
> > > > > Changes from v1:
> > > > >
> > > > > * Use asmSymbolicName for readability
> > > >
> > > > But it still fails on gcc-5:
> > > >
> > > >     arch/arm64/include/asm/jump_label.h:25:2: error: invalid 'asm':
> > > > invalid operand
> > > >       asm goto(
> > > >       ^
> > > >
> > > > http://kisskb.ellerman.id.au/kisskb/buildresult/15129281/
> > > >
> > >
> > > How odd. godbolt.org has 5.4 and it seems perfectly happy with it.
>
> > https://godbolt.org/z/GTnf3vPaT
>
> I could reproduce the issue on v6.8-rc5 using arm64 defconfig
> and x86_64-gcc-5.5.0-nolibc-aarch64-linux.tar.xz from
> https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/:
>

OK, I managed to do so as well.

And GCC 6.4 from the same source works correctly.

Not sure whether there are any plans to bump the minimal GCC version
any time soon (cc'ing Arnd), but we should probably drop this change
until that happens.

