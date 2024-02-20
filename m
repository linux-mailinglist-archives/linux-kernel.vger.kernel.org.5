Return-Path: <linux-kernel+bounces-72499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E5285B442
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CCB22C72
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0459B5BAE9;
	Tue, 20 Feb 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/KkaRfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC863612D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415735; cv=none; b=OzhWGtYZfUXB7a4Ox0Um5uxFhoooh1Y8cRl4yQsJ7If7Wxk98xq63YFEDotNqbcxRg4gtvMOKG96eu4rpLp1zZU/3tdW/jQagMK/y2DruC/FJPiWjPcG4K0dQ/Iu3Eo9F1lJMN6JpJpZ6AwPFnGEJLDgCjAiQcLSv3UboKLWBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415735; c=relaxed/simple;
	bh=f3WPduM2Ig8V5cgj1DfBjqEf15R5HRkvy/vPU24LCwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg3y78qiRx5YXF05e1m27BELAFy4G5qY+ErMZ03oz+K/ouCwyqp7RzXiZabEePN0q2lkgHWqIIntHPelZ8tCoSQbI8MSqF82JqcYV5Rf2fKQ3LMU1S+Iw9iBhO75Cpac/GDiNJLln6oa30ROtkk3a8K3WI9jzlxJxD4K1SHScKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/KkaRfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2246FC433A6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708415735;
	bh=f3WPduM2Ig8V5cgj1DfBjqEf15R5HRkvy/vPU24LCwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T/KkaRfIYJGwyJ8YQ+YD/aX+3tlk2QqHIH+77RVC89HmCVVox3iPUnN+2B1qT6AC0
	 ThsmjE2klTt1tTixXRm3yGOaGsyA0shqgkef3mAH8t/KTuytDwAbQdtW2689abo572
	 hiJroV5ScvBJCHBVCmC7GDlX4NSxMIg6EdWUa5mPDxNP9J7b552WhUC+u6sv6Bm6J9
	 OOjVOxnkMFOE/UQhcMsGoex+GZyoSvU8DZA/5TS+3SWB0oTNi3T2D/+MGuMcURpnl/
	 1B3W/ZZTy+5bBRo0bGrcrjuNWCw1JVXGOh1cttbSuUKvWdpt8aXKfLaeXrenG8C7x7
	 bDGMQmXyDg2gg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512be9194b7so1316505e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:55:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlIcuD9JSjeJbAzqo319eKcu25JehQuxueAFonfL36AjYJZEHQQ5ALeFeGY8xfXIlkOAmHLZ/sB2GB7JyMDHcFrkZrgsR3xa/qVmSL
X-Gm-Message-State: AOJu0YwwZ1FZacuJgSMX7/7n0FnPpo+YCWOE2v9XJgMptkrp3x57TuUG
	TY6QgRI2CnCA2GS7ybsVefLetYuVvNMQixp6ai9bQIppkv67Gb5MR6IBSITmjMctijwWPxB7ugA
	0hjI4SrX/3JxxD6Zut1z1X0WgQPs=
X-Google-Smtp-Source: AGHT+IEHvmf56fDp9ycd1vXL1KRsmZb0HNhXBt3lrxbsb6nioQdCqHJB7fwiyngz1754RyIUgKepzOdj2VVV+Wh61GI=
X-Received: by 2002:ac2:5451:0:b0:512:b3ef:79b8 with SMTP id
 d17-20020ac25451000000b00512b3ef79b8mr2412781lfn.69.1708415733220; Mon, 19
 Feb 2024 23:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206074552.541154-1-maskray@google.com> <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
 <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
 <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
 <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
 <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
 <dca5b082-90d1-40ab-954f-8b3b6f51138c@app.fastmail.com> <ZdOcXTvvHyl8s56I@FVFF77S0Q05N>
In-Reply-To: <ZdOcXTvvHyl8s56I@FVFF77S0Q05N>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 20 Feb 2024 08:55:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGWiTusoFWPCwM9OVwxp5=BHPfUdG-CurO13mWOdQr6Hg@mail.gmail.com>
Message-ID: <CAMj1kXGWiTusoFWPCwM9OVwxp5=BHPfUdG-CurO13mWOdQr6Hg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Fangrui Song <maskray@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 at 19:22, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Feb 19, 2024 at 06:06:19PM +0100, Arnd Bergmann wrote:
> > On Mon, Feb 19, 2024, at 16:41, Ard Biesheuvel wrote:
> > > On Mon, 19 Feb 2024 at 15:43, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> > >> On Mon, Feb 19, 2024 at 11:57=E2=80=AFAM Ard Biesheuvel <ardb@kernel=
org> wrote:
> > >> > On Mon, 19 Feb 2024 at 11:56, Ard Biesheuvel <ardb@kernel.org> wro=
te:
> >
> > >> > https://godbolt.org/z/GTnf3vPaT
> > >>
> > >> I could reproduce the issue on v6.8-rc5 using arm64 defconfig
> > >> and x86_64-gcc-5.5.0-nolibc-aarch64-linux.tar.xz from
> > >> https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/:
> > >>
> > >
> > > OK, I managed to do so as well.
> > >
> > > And GCC 6.4 from the same source works correctly.
> > >
> > > Not sure whether there are any plans to bump the minimal GCC version
> > > any time soon (cc'ing Arnd), but we should probably drop this change
> > > until that happens.
> >
> > From what I can tell, we may as well formally raise the minimum
> > gcc version to 8.1+ already, as that is a version that is
> > actually used in distros, and we have been on 5.1+ for a few
> > years already.
> >
> > Not sure if there are any other benefits to gcc-8 besides
> > allowing minor cleanups.
>
> Arguably a minor cleanup, but on arm64 that'd allow us to get rid of the =
old
> mcount-based ftrace implementation and rely on -fpatchable-function-entry=
.
> On its own that'd save ~130 lines of asm and ~70 lines of C, but it'd als=
o
> remove some constraints on other features (e.g. the mcount-based form's g=
raph
> tracer isn't compatible with pointer authentication), it would simplify a=
 few
> things going forwards (e.g. the implementation of RELIABLE_STACKTRACE, si=
nce we
> could rely on having ftrace_regs and a single trampoline), and the remain=
ing
> support would be better tested.
>
> I've wanted to remove the old ftrace implementation for a while, but on i=
ts own
> it was never important/urgent enough to justify bumping to GCC 8+.
>

I don't think this is minor, tbh. Supporting two versions of the
highly complex tracing infrastructure for a toolchain that is only
used in CI seems like a waste of time and effort.

I checked x86, and it needs at least GCC 7 for retpoline support, so I
reckon at least GCC 5/6 support might be dropped there as well.

