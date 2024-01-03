Return-Path: <linux-kernel+bounces-15201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E37A7822849
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D46F1F23B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1A179AB;
	Wed,  3 Jan 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNtSvJn9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A817998
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 06:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECCCC43395
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 06:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704262395;
	bh=z/qNbHh+NlBS5hX320x9+NBvr2P9LUzSZy2GnNKm5QY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JNtSvJn9RJpeR0XWef0dE8t/wOQFi5ntoV2m+5TqucGpI7y1bXyJPKhjP05eSySPl
	 9YSuRbDCPC/I6yOrTl8idVOGIY5LFXVkBWxF01VIQ6zVLaqkp9v+kP6llMquvkTGTM
	 hj+qeuwiTrjbaWQkPs45Pkl9igxRxd6p41WhuakemonUHHLk8AiXWGTvPtdV0x1Ksp
	 2AiUwZ/LJiscpml5iwxazdOGi/KnhEuCSp7XmH2nNb3EnPh8xiXu8jzqzmGocoWAPE
	 22VHr7CF3G6B7ylUabI4D4gsICAg7Faz+XUJB7yYxzlyDXaqNNq/HVUplNn0s9g7Nb
	 vWduyM0ZPDolQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a27874c861aso391981366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 22:13:15 -0800 (PST)
X-Gm-Message-State: AOJu0YzOCS3Qp5O7WOrpWhujYGx/di0hkTP+pAfu55ZGs/As2Jm+bIjs
	2amWxKBqZ5amj6YIlBhjqcLlxFJFjjpYNYkKmUQ=
X-Google-Smtp-Source: AGHT+IGJuzpOmRkw/xyuUi+C8wN7h1/8qf8xhLPUJqszMKx19sp3cLUgfTLinASn37jh2aF+hmmPWC2KUX/wY4RV12M=
X-Received: by 2002:a17:906:46d8:b0:a28:9633:dff9 with SMTP id
 k24-20020a17090646d800b00a289633dff9mr186586ejs.135.1704262393480; Tue, 02
 Jan 2024 22:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-2-guoren@kernel.org>
 <20240102-4f12393de3c6313650a24c17@orel>
In-Reply-To: <20240102-4f12393de3c6313650a24c17@orel>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 3 Jan 2024 14:13:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRRqbC5RTGtwhQD1pR+JoP_D64+AUMdO2r5ff-cR5AaUg@mail.gmail.com>
Message-ID: <CAJF2gTRRqbC5RTGtwhQD1pR+JoP_D64+AUMdO2r5ff-cR5AaUg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions & cpufeature
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

On Tue, Jan 2, 2024 at 6:32=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Cache-block prefetch instructions are HINTs to the hardware to
> > indicate that software intends to perform a particular type of
> > memory access in the near future. This patch adds prefetch.i,
> > prefetch.r and prefetch.w instruction definitions by
> > RISCV_ISA_EXT_ZICBOP cpufeature.
>
> It also adds S-type instruction encoding support which isn't mentioned.
> Actually, it'd probably be best to put the new instruction encoding in
> its own separate patch.
Okay, I would separate the instruction encoding patch in the next version.

>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig                | 15 ++++++++
> >  arch/riscv/include/asm/hwcap.h    |  1 +
> >  arch/riscv/include/asm/insn-def.h | 60 +++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c    |  1 +
> >  4 files changed, 77 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 24c1799e2ec4..fcbd417d65ea 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -579,6 +579,21 @@ config RISCV_ISA_ZICBOZ
> >
> >          If you don't know what to do here, say Y.
> >
> > +config RISCV_ISA_ZICBOP
> > +     bool "Zicbop extension support for cache block prefetch"
> > +     depends on MMU
> > +     depends on RISCV_ALTERNATIVE
> > +     default y
> > +     help
> > +       Adds support to dynamically detect the presence of the ZICBOP
> > +       extension (Cache Block Prefetch Operations) and enable its
> > +       usage.
> > +
> > +       The Zicbop extension can be used to prefetch cache block for
>
> blocks
>
> > +       read/write fetch.
> > +
> > +       If you don't know what to do here, say Y.
> > +
> >  config TOOLCHAIN_HAS_ZIHINTPAUSE
> >       bool
> >       default y
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index 06d30526ef3b..77d3b6ee25ab 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -57,6 +57,7 @@
> >  #define RISCV_ISA_EXT_ZIHPM          42
> >  #define RISCV_ISA_EXT_SMSTATEEN              43
> >  #define RISCV_ISA_EXT_ZICOND         44
> > +#define RISCV_ISA_EXT_ZICBOP         45
> >
> >  #define RISCV_ISA_EXT_MAX            64
> >
> > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm=
/insn-def.h
> > index e27179b26086..bbda350a63bf 100644
> > --- a/arch/riscv/include/asm/insn-def.h
> > +++ b/arch/riscv/include/asm/insn-def.h
> > @@ -18,6 +18,13 @@
> >  #define INSN_I_RD_SHIFT                       7
> >  #define INSN_I_OPCODE_SHIFT           0
> >
> > +#define INSN_S_SIMM7_SHIFT           25
> > +#define INSN_S_RS2_SHIFT             20
> > +#define INSN_S_RS1_SHIFT             15
> > +#define INSN_S_FUNC3_SHIFT           12
> > +#define INSN_S_SIMM5_SHIFT            7
> > +#define INSN_S_OPCODE_SHIFT           0
> > +
> >  #ifdef __ASSEMBLY__
> >
> >  #ifdef CONFIG_AS_HAS_INSN
> > @@ -30,6 +37,10 @@
> >       .insn   i \opcode, \func3, \rd, \rs1, \simm12
> >       .endm
> >
> > +     .macro insn_s, opcode, func3, rs2, simm12, rs1
> > +     .insn   s \opcode, \func3, \rs2, \simm12(\rs1)
> > +     .endm
> > +
> >  #else
> >
> >  #include <asm/gpr-num.h>
> > @@ -51,10 +62,20 @@
> >                (\simm12 << INSN_I_SIMM12_SHIFT))
> >       .endm
> >
> > +     .macro insn_s, opcode, func3, rs2, simm12, rs1
> > +     .4byte  ((\opcode << INSN_S_OPCODE_SHIFT) |             \
> > +              (\func3 << INSN_S_FUNC3_SHIFT) |               \
> > +              (.L__gpr_num_\rs2 << INSN_S_RS2_SHIFT) |       \
> > +              (.L__gpr_num_\rs1 << INSN_S_RS1_SHIFT) |       \
> > +              ((\simm12 & 0x1f) << INSN_S_SIMM5_SHIFT) |     \
> > +              (((\simm12 >> 5) & 0x7f) << INSN_S_SIMM7_SHIFT))
> > +     .endm
> > +
> >  #endif
> >
> >  #define __INSN_R(...)        insn_r __VA_ARGS__
> >  #define __INSN_I(...)        insn_i __VA_ARGS__
> > +#define __INSN_S(...)        insn_s __VA_ARGS__
> >
> >  #else /* ! __ASSEMBLY__ */
> >
> > @@ -66,6 +87,9 @@
> >  #define __INSN_I(opcode, func3, rd, rs1, simm12)     \
> >       ".insn  i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n"
> >
> > +#define __INSN_S(opcode, func3, rs2, simm12, rs1)    \
> > +     ".insn  s " opcode ", " func3 ", " rs2 ", " simm12 "(" rs1 ")\n"
> > +
> >  #else
> >
> >  #include <linux/stringify.h>
> > @@ -92,12 +116,26 @@
> >  "             (\\simm12 << " __stringify(INSN_I_SIMM12_SHIFT) "))\n" \
> >  "    .endm\n"
> >
> > +#define DEFINE_INSN_S                                                 =
       \
> > +     __DEFINE_ASM_GPR_NUMS                                           \
> > +"    .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> > +"    .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> > +"             (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> > +"             (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ")=
 |" \
> > +"             (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ")=
 |" \
> > +"             ((\\simm12 & 0x1f) << " __stringify(INSN_S_SIMM5_SHIFT) =
") |" \
> > +"             (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_=
SHIFT) "))\n" \
> > +"    .endm\n"
> > +
> >  #define UNDEFINE_INSN_R                                               =
       \
> >  "    .purgem insn_r\n"
> >
> >  #define UNDEFINE_INSN_I                                               =
       \
> >  "    .purgem insn_i\n"
> >
> > +#define UNDEFINE_INSN_S                                               =
       \
> > +"    .purgem insn_s\n"
> > +
> >  #define __INSN_R(opcode, func3, func7, rd, rs1, rs2)                 \
> >       DEFINE_INSN_R                                                   \
> >       "insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 =
"\n" \
> > @@ -108,6 +146,11 @@
> >       "insn_i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n" \
> >       UNDEFINE_INSN_I
> >
> > +#define __INSN_S(opcode, func3, rs2, simm12, rs1)                    \
> > +     DEFINE_INSN_S                                                   \
> > +     "insn_s " opcode ", " func3 ", " rs2 ", " simm12 ", " rs1 "\n"  \
> > +     UNDEFINE_INSN_S
> > +
> >  #endif
> >
> >  #endif /* ! __ASSEMBLY__ */
> > @@ -120,6 +163,10 @@
> >       __INSN_I(RV_##opcode, RV_##func3, RV_##rd,              \
> >                RV_##rs1, RV_##simm12)
> >
> > +#define INSN_S(opcode, func3, rs2, simm12, rs1)                      \
> > +     __INSN_S(RV_##opcode, RV_##func3, RV_##rs2,             \
> > +              RV_##simm12, RV_##rs1)
> > +
> >  #define RV_OPCODE(v)         __ASM_STR(v)
> >  #define RV_FUNC3(v)          __ASM_STR(v)
> >  #define RV_FUNC7(v)          __ASM_STR(v)
> > @@ -133,6 +180,7 @@
> >  #define RV___RS2(v)          __RV_REG(v)
> >
> >  #define RV_OPCODE_MISC_MEM   RV_OPCODE(15)
> > +#define RV_OPCODE_OP_IMM     RV_OPCODE(19)
> >  #define RV_OPCODE_SYSTEM     RV_OPCODE(115)
> >
> >  #define HFENCE_VVMA(vaddr, asid)                             \
> > @@ -196,4 +244,16 @@
> >       INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
> >              RS1(base), SIMM12(4))
> >
> > +#define CBO_PREFETCH_I(base, offset)                         \
> > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),               \
> > +            SIMM12(offset), RS1(base))
> > +
> > +#define CBO_PREFETCH_R(base, offset)                         \
> > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),               \
> > +            SIMM12(offset), RS1(base))
> > +
> > +#define CBO_PREFETCH_W(base, offset)                         \
> > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > +            SIMM12(offset), RS1(base))
>
> Shouldn't we ensure the lower 5-bits of offset are zero by masking it?
The spec says:
"These instructions operate on the cache block whose effective address
is the sum of the base address specified in rs1 and the sign-extended
offset encoded in imm[11:0], where imm[4:0] shall equal 0b00000. The
effective address is translated into a corresponding physical address
by the appropriate translation mechanisms."

So, the user of prefetch.w should keep imm[4:0] zero. Just like the
patch has done, the whole imm[11:0] is zero.

>
> > +
> >  #endif /* __ASM_INSN_DEF_H */
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index b3785ffc1570..bdb02b066041 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -168,6 +168,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >       __RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> >       __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> >       __RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> > +     __RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),
>
> zicbop should be above zicboz (alphabetical)
Yes, I would correct it, next.

>
> >       __RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> >       __RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
> >       __RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> > --
> > 2.40.1
> >
>
> Thanks,
> drew



--=20
Best Regards
 Guo Ren

