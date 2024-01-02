Return-Path: <linux-kernel+bounces-14283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5B821AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539091F227AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88697EAC0;
	Tue,  2 Jan 2024 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeDzh8jA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7CE544;
	Tue,  2 Jan 2024 11:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B48C433C7;
	Tue,  2 Jan 2024 11:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704194465;
	bh=9BxRzEOBTvR+ppxG806EdQKoWFFjbUS/+GzPU/AwX9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GeDzh8jA6WHp/CxKP0OUKid/aof8nCv7fI6c2Z6/esAnHXjkaYY5h9T5qBYA9bGhq
	 F55tRn31n4Ja8nd0kjwpooY0qXEZqPg8h1XltOwsqwEkCHWla6jI1W+mpSOniWCRIO
	 cTyHNZY3uVgxbGTuAFKDeJwSGtCFDksU0Z+GPvAzFL5FBR55w5FH6CZgbi9tFUZsPn
	 k2ABDr0oG0AhvA7h+BD/cjpRdlJgEyEx15b8i2C4yiSrz5fsFFUjSIiLUzFggCeJGR
	 YlQ9eFU/CVl4LE6PzYCHykNQPZyO+jrzwfwt0NvBg/RPWeZq4aZfX8orOhWYPBGycq
	 yqEI3TKmy0F+w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a282cb36d37so75148066b.3;
        Tue, 02 Jan 2024 03:21:05 -0800 (PST)
X-Gm-Message-State: AOJu0YyWpCIG103YPc8b5oIQIClbz88SxTAoa/UhK5vyt6aEtwCLFmbc
	z4rhouJ53e5A1cnU1v5mpHAvitB4Nn1b6StRhRQ=
X-Google-Smtp-Source: AGHT+IFlsPq24WCd2yxgqmcSvJkW3nbzdQEW3v5ivSTAT0THQwBtZN9+rL4w0A9AFZUm25f69rf/1O7XVxbOBueUL+0=
X-Received: by 2002:a17:906:7399:b0:a23:68ec:a863 with SMTP id
 f25-20020a170906739900b00a2368eca863mr7697697ejl.87.1704194463900; Tue, 02
 Jan 2024 03:21:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102101711.10872-2-xry111@xry111.site> <f6e0b3a0e08a8100fa5dc9345af8582ff664321c.camel@xry111.site>
 <7a6aa1bbdbbe2e63ae96ff163fab0349f58f1b9e.camel@xry111.site>
In-Reply-To: <7a6aa1bbdbbe2e63ae96ff163fab0349f58f1b9e.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 2 Jan 2024 19:20:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7oMB62mSL1O4QPdUNW5z1_12G3L5QAm81KsSwDv_GsEg@mail.gmail.com>
Message-ID: <CAAhV-H7oMB62mSL1O4QPdUNW5z1_12G3L5QAm81KsSwDv_GsEg@mail.gmail.com>
Subject: Re: MIPS: fcsr31 may be dirty after execve when kernel preempt is
 enabled (was: Re: [PATCH v2] LoongArch: Fix and simplify fcsr initialization
 on execve)
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>, 
	loongarch@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 6:48=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Tue, 2024-01-02 at 18:25 +0800, Xi Ruoyao wrote:
> > On Tue, 2024-01-02 at 18:17 +0800, Xi Ruoyao wrote:
> > > The only other architecture setting FCSR in SET_PERSONALITY2 is MIPS.
> > > They do this for supporting different FP flavors (NaN encodings etc).
> > > which do not exist on LoongArch.  I'm not sure how MIPS evades the is=
sue
> > > (or maybe it's just buggy too) but I'll investigate it later.
> >
> > Phew.  I just managed to recommission my 3A4000 and I can reproduce the
> > issue as well with Linux 5.18.1 (the latest kernel release when I
> > decommissioned it) and CONFIG_PREEMPT=3Dy.
> >
> > % cat measure.c
> > #include <fenv.h>
> > int main() { return fetestexcept(FE_INEXACT); }
> >
> > % echo $((1./3))
> > 0.33333333333333331
> >
> > % while ./a.out; do ; done
> > (stopped in seconds)
> >
> > I'm building the mainline kernel on the 3A4000 now, will see if the
> > issue still exists...
>
> Still happening with 6.7.0-rc8.  I'm not sure how to fix it for MIPS.
> Maybe lose_fpu in SET_PERSONALITY2? But to me doing so will be really
> nasty.  Anyway I'll leave this for MIPS maintainers.
Disable preemption in SET_PERSONALITY2 and enable in START_THREAD?

Huacai

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

