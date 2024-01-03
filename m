Return-Path: <linux-kernel+bounces-15212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B9822866
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37C0B22D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA3179B2;
	Wed,  3 Jan 2024 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlyNNFIr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C76179AA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 06:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43B5C433CA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 06:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704262801;
	bh=Syb/OqAPuzYkJd/5Px0xgqgiiqYsgunBbJPRk+8KkZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AlyNNFIr6NoDkL9xxWN9VczUDw46k1TflXh7bQMBuHSzD11Z4FU5+iMgKEXg4OpMU
	 zbuAwfJJQJNmF7GT3FIQiIK7yRJ9tj1VN7FfWlfrBU1/hYfbmxwQtW2tjPtwdPmyGE
	 xyIi2BRMTJyviX1Q+FQ0ZZnCAimyNPROaAzJNmYvhElvRFhUjK1DxgC/AW5pz78F3/
	 TywLH8kjm4igzOoJF8CIhnqXJXexFB1fkqSLwhcTiu7Wpj3VVtTuEQdUphzFiMjey+
	 aCM0kGCpLbGUZt78lm1Rv39XMCMZwNxGEp9+gKIKEPDm3NpiRuotDZ6AhLo8G2qJB0
	 QDWmWgeiJmaTg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-556996d52e5so1412642a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 22:20:01 -0800 (PST)
X-Gm-Message-State: AOJu0YwboaRO1NssJbJnQQfedlKIlehP0cQub3sP741hTATPYc/Qqp+j
	IVY83x3IRX+PVQA21Yx6yfKJJKRZShWwEruteT8=
X-Google-Smtp-Source: AGHT+IFuqReRJk5xVqnVeZa5r5yG7/RHdYMjjYSaCy4RdhwvqtTkrOn7uiNzIFtRiAXwoRAR+JW8Lr1qkPKp+W3wpfQ=
X-Received: by 2002:a17:906:c012:b0:a25:49d5:e272 with SMTP id
 e18-20020a170906c01200b00a2549d5e272mr8392516ejz.12.1704262800314; Tue, 02
 Jan 2024 22:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-3-guoren@kernel.org>
 <20240102-7e62facbd8322db4dee4b0dd@orel>
In-Reply-To: <20240102-7e62facbd8322db4dee4b0dd@orel>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 3 Jan 2024 14:19:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRv4UgSHMTp_tOhNGV2mQXBt1dPj6RdB2XXBGfT6iCWSw@mail.gmail.com>
Message-ID: <CAJF2gTRv4UgSHMTp_tOhNGV2mQXBt1dPj6RdB2XXBGfT6iCWSw@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] riscv: Add ARCH_HAS_PRETCHW support with Zibop
To: Andrew Jones <ajones@ventanamicro.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, panqinglin2020@iscas.ac.cn, 
	bjorn@rivosinc.com, conor.dooley@microchip.com, leobras@redhat.com, 
	peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn, 
	xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 6:45=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
>
> s/Zibop/Zicbop/ <<<$SUBJECT
okay

>
> On Sun, Dec 31, 2023 at 03:29:52AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Enable Linux prefetchw primitive with Zibop cpufeature, which preloads
>
> Also s/Zibop/Zicbop/ here
okay, thx.

>
> > cache line into L1 cache for the next write operation.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/processor.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/as=
m/processor.h
> > index f19f861cda54..8d3a2ab37678 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -13,6 +13,9 @@
> >  #include <vdso/processor.h>
> >
> >  #include <asm/ptrace.h>
> > +#include <asm/insn-def.h>
> > +#include <asm/alternative-macros.h>
> > +#include <asm/hwcap.h>
> >
> >  #ifdef CONFIG_64BIT
> >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > @@ -106,6 +109,19 @@ static inline void arch_thread_struct_whitelist(un=
signed long *offset,
> >  #define KSTK_EIP(tsk)                (task_pt_regs(tsk)->epc)
> >  #define KSTK_ESP(tsk)                (task_pt_regs(tsk)->sp)
> >
> > +#ifdef CONFIG_RISCV_ISA_ZICBOP
> > +#define ARCH_HAS_PREFETCHW
> > +
> > +#define PREFETCHW_ASM(x)                                             \
> > +     ALTERNATIVE(__nops(1), CBO_PREFETCH_W(x, 0), 0,                 \
> > +                 RISCV_ISA_EXT_ZICBOP, CONFIG_RISCV_ISA_ZICBOP)
> > +
> > +
> > +static inline void prefetchw(const void *x)
> > +{
> > +     __asm__ __volatile__(PREFETCHW_ASM(%0) : : "r" (x) : "memory");
> > +}
>
> Shouldn't we create an interface which exposes the offset input of
> the instruction, allowing a sequence of calls to be unrolled? But
> I guess that could be put off until there's a need for it.
I want to put it off until there's a user. Let's keep the whole
imm[11:0] zero for the current.

>
> > +#endif /* CONFIG_RISCV_ISA_ZICBOP */
> >
> >  /* Do necessary setup to start up a newly executed thread. */
> >  extern void start_thread(struct pt_regs *regs,
> > --
> > 2.40.1
> >
>
> Thanks,
> drew



--=20
Best Regards
 Guo Ren

