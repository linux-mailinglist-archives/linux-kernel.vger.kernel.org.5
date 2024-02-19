Return-Path: <linux-kernel+bounces-71157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56885A174
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4861C2188D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7D28DDA;
	Mon, 19 Feb 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8VuS35S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E228DBD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340198; cv=none; b=nINtB7Opk8mqYr9zSiAwK9ku5gRKNVU1cdZbt2QtL74BfomOcEG1Q/z2c7rctNZuNV5XLhqmcXHGLlr2nX9ZZkln12UZjFLLUOOvCNGNi/jMf7GDUzqAHsCl/HNTmwr27cbCOKFnZ24qtzQpKiCwFLPQNMqQfBwNfvH2y9r1iZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340198; c=relaxed/simple;
	bh=Uy1Jl1CqfhrDZgwbUBQbiwomFF5GZX4KFrXVlHyX7b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjfWERlpRiZeNW4MadutJgLzKmTJxE/gOjSQTBUdtFGUQVWF/xFDt2w1zNYlgyjqdGGArezItQ14RBT5NiEg8CyxJVzTHv+NOnQC45SIIH9fjufXqN2to8tCDVi5YMVhnN5/HwtC/GfObl/rVhHCDLB+WWkh8QpM/a70mVReau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8VuS35S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A4BC433F1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708340197;
	bh=Uy1Jl1CqfhrDZgwbUBQbiwomFF5GZX4KFrXVlHyX7b8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B8VuS35SYdcI7h1o6HRcYf8GFBxnlQ0Mn87b2ZOKsIwl+YT8cnZ+iUzLgGOCSTkR5
	 MU7RllgRnk4DD9SDZOKmcJMCWB5RPtlnutz9Y78yzJqrLVq8Ln/4iUECBB+XM/bbdx
	 HW1NrSItDnX6A7Na0jD6goQBjZ8sHK4H/uJ2ylbgLXkPbDNGD/vZo9DahMZKNB+1jE
	 hOQuZWZptWu5zECzCSesnz7BCRb7W3yK68TtSBjGagqZjxCUCL2tte2YW3+Hwkm7Nq
	 eVWwq9ysFobA2xdy4ui69NweWeR5ZwCwZbf5aDsAelyyB4+yIaRBAL+YFBV52eqOdd
	 yDOTgcrn9le6g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so472417e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:56:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJjLPOvTrR0IXg+KOmTzJx4mdwzb1Rez7eovMOfHKF+j3LQUuDz0XhPihRZuxDl7p+gg97lg/V0VEmbmjSmBqJMPlrgNP1GGbfdqvE
X-Gm-Message-State: AOJu0YyHMKueNY08QZ3HxNRtWXm4bFyBCcCwV76OmmvA7rXTQY9My/fD
	W5nMH+NVs2ddzW1dRz58eMauIh8QtKKZeavYKC/ZalYEPqnTR9bZslyEeZp9PM5EWRecBlWAklx
	QxWkxr6/Ye51UaAuIDbFQhAuZbAc=
X-Google-Smtp-Source: AGHT+IGjAfOlfWjVl33b+jbVBz4EBHg+YiDe0EqEg12/9/I5auQLZKZLVOB24y7lWixLN8X8PebjOFVxpbNL3CLg4aU=
X-Received: by 2002:a05:6512:3ba5:b0:511:2e7c:768f with SMTP id
 g37-20020a0565123ba500b005112e7c768fmr9887369lfv.46.1708340195832; Mon, 19
 Feb 2024 02:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206074552.541154-1-maskray@google.com> <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
In-Reply-To: <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Feb 2024 11:56:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
Message-ID: <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fangrui Song <maskray@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 at 11:03, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Fangrui,
>
> On Tue, Feb 6, 2024 at 8:46=E2=80=AFAM Fangrui Song <maskray@google.com> =
wrote:
> > The generic constraint "i" seems to be copied from x86 or arm (and with
> > a redundant generic operand modifier "c"). It works with -fno-PIE but
> > not with -fPIE/-fPIC in GCC's aarch64 port.
>
> Thanks for your patch, which is now commit f9daab0ad01cf9d1 ("arm64:
> jump_label: use constraints "Si" instead of "i"") in v6.8-rc5.
>
> > The machine constraint "S", which denotes a symbol or label reference
> > with a constant offset, supports PIC and has been available in GCC sinc=
e
> > 2012 and in Clang since 7.0. However, Clang before 19 does not support
> > "S" on a symbol with a constant offset [1] (e.g.
> > `static_key_false(&nf_hooks_needed[pf][hook])` in
> > include/linux/netfilter.h), so we use "i" as a fallback.
>
> https://gcc.gnu.org/releases.html says gcc-5 was released in 2015,
> i.e. after 2012 ...
>
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Link: https://github.com/llvm/llvm-project/pull/80255 [1]
> >
> > ---
> > Changes from
> > arm64: jump_label: use constraint "S" instead of "i" (https://lore.kern=
el.org/all/20240131065322.1126831-1-maskray@google.com/)
> >
> > * Use "Si" as Ard suggested to support Clang<19
> > * Make branch a separate operand
> >
> > Changes from v1:
> >
> > * Use asmSymbolicName for readability
>
> But it still fails on gcc-5:
>
>     arch/arm64/include/asm/jump_label.h:25:2: error: invalid 'asm':
> invalid operand
>       asm goto(
>       ^
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/15129281/
>

How odd. godbolt.org has 5.4 and it seems perfectly happy with it.

https://godbolt.org/z/szzG3s59K

