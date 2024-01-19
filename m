Return-Path: <linux-kernel+bounces-31386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD80832D95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647DF28206D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D599D5578A;
	Fri, 19 Jan 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X68lbgkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620A53E03
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683540; cv=none; b=P0wkw0FEWiRjgiVDexUfrnIhlNLER/vWeEYtdOZagbXe73pMaIv001LvZfkcfnepK8gdw4vY+MYSwG2YOPa72QYz+xVoBO/xDjGTwq6Rrl4/EmjBBv8Nuc4xwxdfSGkCDVi2P04Z5ChZfRXpoEJ4z7fbPFr+263Rn5JZf/Dkvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683540; c=relaxed/simple;
	bh=fqBOEKEg4Hj4a2jaXHGkAmSwRgJ5++JiGt7Wa7nQxT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+sthhhaJFN33NJfZjgk7kRU8jk9VKHLXQERbRJpidC3+MfBXhLORbrbnofzPMNciEFMb83YD19vW1Xjxhn1w5vDKOJ6G7Gb0NG9z2dI/SgB+p7hqfGR5yriTaq046vFZt27AmzoHPbPZgn60MnSxjX39EGRYlk4iKGyhYWgxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X68lbgkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8A2C43394
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705683539;
	bh=fqBOEKEg4Hj4a2jaXHGkAmSwRgJ5++JiGt7Wa7nQxT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X68lbgkK1OVnsJRtgycZodLBmHJqEfyUa73IjVwVIaA13n1J0uo+93UjrPJL/NPEW
	 49Pj5rVP6YUK6aKMns8DXpvgmIZ39/fT1K+6Bf91bT8bnyg+4AM0xVho/mQefjfo5n
	 AeXuugLv5AK73EJFx6ZU4H+3ccGfcoAy9UL/o82z4+EFuVPwxBaN2TucMO8WV0I9WP
	 KFYAUmh/8znH10oYy/MigVfw/ZbZKyiDm1jxbcg53s8OikchYLNPYDuHI3mcAK4pGQ
	 glL67xDDFDKFzfBzOOjy74bFFlBJTEPSZ1nkjxhtgWzLOYkvVNB/Qgmevvl7CEl+jo
	 v7sG/kaHgEHlQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso10937121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:58:59 -0800 (PST)
X-Gm-Message-State: AOJu0YxjaNvfuOJoksru1U+oTpSgV4Q84pY7ZsOfSmuEgMZfblbswjHx
	6YeluN0wI/4x/ZaobFAxoGPo2cpB+zaAyqzPPxrnLytKC1hCxwnIULw6sx9kPIPrxwo1vZKNcT6
	76dn//Y+cKL6pSzThLf8nJx/R7Q==
X-Google-Smtp-Source: AGHT+IG2KxV4qGtvyodScbrBpT5jBo5AONFS/VOMsNOPKVFpjTo3QwBI9D8ADQQwK4Y4uVPYM51mCl0kDBUqjIKBOuY=
X-Received: by 2002:a19:6518:0:b0:50e:77c7:f6c1 with SMTP id
 z24-20020a196518000000b0050e77c7f6c1mr791422lfb.27.1705683537909; Fri, 19 Jan
 2024 08:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119160528.GA5336@willie-the-truck> <20240119163408.GA468084-robh@kernel.org>
In-Reply-To: <20240119163408.GA468084-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 19 Jan 2024 10:58:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLu8A22OidU-n=nbpyoEZcB+nsc=5ZiXmT2A+s4VdrLkw@mail.gmail.com>
Message-ID: <CAL_JsqLu8A22OidU-n=nbpyoEZcB+nsc=5ZiXmT2A+s4VdrLkw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for -rc1
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 10:34=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Fri, Jan 19, 2024 at 04:05:28PM +0000, Will Deacon wrote:
> > Hi Linus,
> >
> > Please pull these arm64 fixes for -rc1. I think the main one is fixing
> > the dynamic SCS patching when full LTO is enabled (clang was silently
> > getting this horribly wrong), but it's all good stuff. Rob just pointed
> > out that the fix to the workaround for erratum #2966298 might not be
> > necessary, but in the worst case it's harmless and since the official
> > description leaves a little to be desired here, I've left it in.
> >
> > Cheers,
> >
> > Will
> >
> > --->8
> >
> > The following changes since commit db32cf8e280b46726065c518e90761bb0229=
bacf:
> >
> >   Merge branch 'for-next/fixes' into for-next/core (2024-01-04 12:32:33=
 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/ar=
m64-fixes
> >
> > for you to fetch changes up to 1b20d0486a602417defb5bf33320d31b2a7a47f8=
:
> >
> >   arm64: Fix silcon-errata.rst formatting (2024-01-18 11:15:43 +0000)
> >
> > ----------------------------------------------------------------
> > arm64 fixes for -rc1
> >
> > - Fix shadow call stack patching with LTO=3Dfull
> >
> > - Fix voluntary preemption of the FPSIMD registers from assembly code
> >
> > - Fix workaround for A520 CPU erratum #2966298 and extend to A510
> >
> > - Fix SME issues that resulted in corruption of the register state
> >
> > - Minor fixes (missing includes, formatting)
> >
> > ----------------------------------------------------------------
> > Ard Biesheuvel (2):
> >       arm64: scs: Work around full LTO issue with dynamic SCS
> >       arm64: fpsimd: Bring cond_yield asm macro in line with new rules
> >
> > Mark Brown (3):
> >       arm64/ptrace: Don't flush ZA/ZT storage when writing ZA via ptrac=
e
> >       arm64/fpsimd: Remove spurious check for SVE support
> >       arm64/sme: Always exit sme_alloc() early with existing storage
> >
> > Mark Rutland (2):
> >       arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
>
> I've commented on the patch, but this doesn't fix anything. The original
> work-around was fine.

Sorry, failed to read your commentary at the top. I suppose all this
is fine. It would be nice to have a chance to see all this before it
gets sent upstream.

Rob

