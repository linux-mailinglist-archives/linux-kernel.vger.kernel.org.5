Return-Path: <linux-kernel+bounces-13815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304578212D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 03:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE351F22595
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F142578;
	Mon,  1 Jan 2024 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deuTnnbh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27840210B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 02:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA4BC433C9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 02:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704076174;
	bh=NxcQt/1WVdElhgcHVwYbzLY/6vPTKg2Mr7ScZIEVR7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=deuTnnbhP22cVt2mKII+KMjMY/MdkNY5Tvkb/5RpiAWGhNn7wEPfvUzw1PybSQpwh
	 vru6kbn9xK/daV/HLaPB9JDtK7e2/N/4H4jV4tNeL+N1nYP6a5hudu7CPKLYDp2jXO
	 +15rND5Phz5X1ycirGD85UrH+LzdzO93K5WljP4mRSeIuv4BbMaD69LEKj7bpIWDla
	 4ausGfo+FDNdYsDEsaDIOhANCU0ywF1Au0WC/CKBjf43BQ9Xfb6pXnmVoJfM3Z6sIT
	 Wzq40HjMvjxAV4nJCH53zj3MBKTaO40MRDQ13DmeYLwAVHLppyJ5C5+EMl7DsF+Grf
	 eTT4b5/ocprvA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55559e26ccfso4211518a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 18:29:34 -0800 (PST)
X-Gm-Message-State: AOJu0YxiY0Bj6wzZTuODEz0dr/MAm3RSAaK+nuezZKk9SUecQqXlRwnw
	MLd8+RsubReCZBl4a+rrisk13EMhbE6yga+zew4=
X-Google-Smtp-Source: AGHT+IFYhP/lTo9lpMwcHTK1Xjo1hbbfc1WD5tZJurTZJC1E2j/Mg8ZBMjQY1xh6HrQvXAx9kEtDW4p5Eh59NHPbY8c=
X-Received: by 2002:a50:8e17:0:b0:54f:51cc:6570 with SMTP id
 23-20020a508e17000000b0054f51cc6570mr6935713edw.63.1704076173099; Sun, 31 Dec
 2023 18:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-3-guoren@kernel.org>
In-Reply-To: <20231231082955.16516-3-guoren@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 1 Jan 2024 10:29:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTZeN+rfG6szdB+J1QySQ2tAadwpG_zt2cRir7Bn+Yh4g@mail.gmail.com>
Message-ID: <CAJF2gTTZeN+rfG6szdB+J1QySQ2tAadwpG_zt2cRir7Bn+Yh4g@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] riscv: Add ARCH_HAS_PRETCHW support with Zibop
To: paul.walmsley@sifive.com, palmer@dabbelt.com, guoren@kernel.org, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, ajones@ventanamicro.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 4:30=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Enable Linux prefetchw primitive with Zibop cpufeature, which preloads
> cache line into L1 cache for the next write operation.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/processor.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index f19f861cda54..8d3a2ab37678 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -13,6 +13,9 @@
>  #include <vdso/processor.h>
>
>  #include <asm/ptrace.h>
> +#include <asm/insn-def.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/hwcap.h>
>
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW     (UL(1) << (MMAP_VA_BITS - 1))
> @@ -106,6 +109,19 @@ static inline void arch_thread_struct_whitelist(unsi=
gned long *offset,
>  #define KSTK_EIP(tsk)          (task_pt_regs(tsk)->epc)
>  #define KSTK_ESP(tsk)          (task_pt_regs(tsk)->sp)
>
> +#ifdef CONFIG_RISCV_ISA_ZICBOP
> +#define ARCH_HAS_PREFETCHW
> +
> +#define PREFETCHW_ASM(x)                                               \
> +       ALTERNATIVE(__nops(1), CBO_PREFETCH_W(x, 0), 0,                 \
> +                   RISCV_ISA_EXT_ZICBOP, CONFIG_RISCV_ISA_ZICBOP)
The PREFETCHW_ASM(x) definition should be out of "ifdef
CONFIG_RISCV_ISA_ZICBOP... #endif", because xchg_small may use this
macro without CONFIG_RISCV_ISA_ZICBOP.

> +
> +
> +static inline void prefetchw(const void *x)
> +{
> +       __asm__ __volatile__(PREFETCHW_ASM(%0) : : "r" (x) : "memory");
> +}
> +#endif /* CONFIG_RISCV_ISA_ZICBOP */
>
>  /* Do necessary setup to start up a newly executed thread. */
>  extern void start_thread(struct pt_regs *regs,
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren

