Return-Path: <linux-kernel+bounces-117345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F1788AA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EEB341998
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8386774E;
	Mon, 25 Mar 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phAxrXaO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCA3DAC19
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379708; cv=none; b=lz4TO/hwtxpHTuXZASRgzC9pw7xGbrLrhUqYYqHlqbkB5/eDpm4tKWJ4d0870YaYdLsYV0qg1qd1bf7zNY5Zisumd++ReTzF8ndxMcanNwr5hah9d9QWCgD4757fnpYXeiUaSoAtwtPhVdLjldeTTcADdDm2HKtxaz3b/ubUSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379708; c=relaxed/simple;
	bh=5BLlb1WsYWJmK+oZT7FsKXb4sOeQvUD882nSbGqGyb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZSr7jS20JSIEA/E5vDpfvrAKYqEz7CGSspZaqwixbzQFPP5UW6blIs5fmgv6IdABXWWAcwG63bkC6ew965+SquJ6045KPI53L49ieChTCS0MBeth6+39zQvpxxC13jKFGKIUk62jROIS6CMykI/8yZmRKkx02Otxmk+vGd33mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phAxrXaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CFDC43390
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711379708;
	bh=5BLlb1WsYWJmK+oZT7FsKXb4sOeQvUD882nSbGqGyb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=phAxrXaOtEXGZoOTJbwp95NKyP9jTjuxq5k7pgxPNLKiRDsSMJ/a+cuhnqroUD+9M
	 TL5Lpu5x8vzMFuP0uMm41yCHp0C7N6srqr0LQqpi2AAE09e3R1Qd4s9UpSRbcj4yEc
	 787Z4kRn6MXmXSDV0YZKkNK1PLcoJuTa2qOmXRLcDt6Z9JToT8WRrJts4j+f2zJUZL
	 FF86SUKUJyZnVGvCBedt4c0XBCyO/m6mfCUWGsspqAJvY4JGkgEj0qFMd9hU4vDAeK
	 MScCgx2VoFFlWGOoCBKGMLiWK4IgGxehXMy4d2Ty9FSNFbYtOofao4VbNb3NXrUKGO
	 NJnKtjkqdp6Pg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so32042551fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:15:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTzXKpn//NLDgUP3bvy1HPDW01/PdcUi2XvNAJrefG2Dm10my+n754oxCuCD3sqeAjlVIc2KdCjePL07/6wM1EAgPmjFpyc2Xdasn2
X-Gm-Message-State: AOJu0YydbJvGLfrVWUJAj4tVkHX1LmX8opzsqJ3WNj2kqSzBX/423oZ+
	H0UZ15pMxhe+nuFZpcbhU9zeOOprAApxWk3jUnaHtFcfAeWf+NnZ7s6PVxDJtzd5BDuNusxF/jO
	PtjOj2Z5ADrhRgHvPNl+NUiuncUU=
X-Google-Smtp-Source: AGHT+IFpisd6LgVDCNfYPykT/hY4ChG1b93iTIxrU0E5AXZ6ZR9ugciUs8cuK/EJl4N6N5z/iZrMGEyB38F5coNt3yU=
X-Received: by 2002:a2e:9b83:0:b0:2d2:346a:f199 with SMTP id
 z3-20020a2e9b83000000b002d2346af199mr4662731lji.47.1711379706657; Mon, 25 Mar
 2024 08:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
 <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com> <d82bebfc-3eaa-406d-8ea6-22113da30ed5@app.fastmail.com>
In-Reply-To: <d82bebfc-3eaa-406d-8ea6-22113da30ed5@app.fastmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Mar 2024 17:14:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFXh7xFOGKjUK=Fjc+YK=Zwni=LBVr_T2EUNUjRBBk2EA@mail.gmail.com>
Message-ID: <CAMj1kXFXh7xFOGKjUK=Fjc+YK=Zwni=LBVr_T2EUNUjRBBk2EA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, David Laight <David.Laight@aculab.com>, 
	Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 00:55, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 23, 2024, at 17:16, Linus Torvalds wrote:
> >
..
> > So there doesn't seem to be a major reason to up the versioning, since
> > the stack protector thing can just be disabled for older versions.
> >
> > But maybe even enterprise distros have upgraded anyway, and we should
> > be proactive.
> >
> > Cc'ing Arnd, who has historically been one of the people pushing this.
> > He may no longer care because we haven't had huge issues.
>
> I'm not aware of any major issues, but it keeps coming up and
> a number of people have asked me about it because of smaller
> ones. Unfortunately I didn't write down what the problems
> were.
>
> I think based on what compiler versions are shipped
> by LTS distros, gcc-8.1 is the next logical step when we
> do it, covering Debian 10, RHEL 8 and Ubuntu 20.04, which
> are probably the oldest we still need to support.
>
> RHEL 7 and SLES 12 are still technically supported distros
> as well, but those shipped with gcc-4.8, so we dropped them
> in 2020 with the move to gcc-4.9.
>
> So in short, not a lot to gain or lose from raising the
> minimum to 8.1, but it would be nice to reduce the possible
> test matrix from 10 gcc versions back to the 7 we had in
> the past, as well as clean up a few version dependencies.
> Similarly we can probably raise the oldest binutils version
> to 2.30, as that seems to be the earliest version that was
> paired with gcc-8 (in RHEL-8).
>

x86_64/SMP uses a pile of hacks to create a runtime relocatable
kernel, one of which is a workaround for the offset based addressing
of per-CPU variables. This requires RIP-relative per-CPU references,
e.g.,

  leal %gs:foo(%rip), %reg

to be fixed up in the opposite direction (displacement subtracted
rather than added) in the decompressor. This scheme is used because
older GCCs can only access the stack protector cookie via a fixed
offset of GS+40, and so GS must carry the address of the start of the
per-CPU region rather than an arbitrary relative offset between the
per-CPU region in vmlinux and the one belonging to a CPU.

GCC 8.1 and later allow the cookie to be specified using a symbol, and
this would allow us to revert to the ordinary per-CPU addressing,
where the base is the vmlinux copy of a symbol, and each CPU carries a
different offset in GS that produces the address of its respective
private copy. [0]

With that out of the way, we could get rid of the weird relocation
format and just use the linker to link vmlinux in PIE mode (like other
architectures), using the condensed RELR format which only takes a
fraction of the space. Using PIC codegen and PIE linking also brings
us closer to what toolchains expect, and so fewer quirks/surprises
when moving to newer versions. (Currently on x86, we do a position
dependent link of vmlinux, and rely on the static relocations produced
by --emit-relocs to create the metadata we need to perform the
relocation fixups. Static relocations cannot describe all the
transformations and relaxations that the linker might apply, and so
static relocations might go out of sync with the actual code.)

Another minor cleanup is __GCC_ASM_FLAG_OUTPUTS__, which would always
be supported if we require 8.1 or newer.

None of this is high priority, though, so not a reason in itself to
deprecate GCC 7 and older, more of a nice bonus when we do get there.

-- 
Ard.



[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-remove-absolute-percpu

