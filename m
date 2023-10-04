Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BEC7B8606
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbjJDRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243574AbjJDRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E5E4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:00:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A667AC433C7;
        Wed,  4 Oct 2023 17:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696438817;
        bh=KxobSUMg1rt6ffq3jOXrRjFXKWaC8yDqN/GRlH/RhbU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eHHxGslhcn/F6x7OMgav3hUp2/iuk6S+vwIZZI2Mhjnv+Zs7BKcJU4Z0sHYuRhvop
         52f6cn5z4ersd0wPqX4eV66/S1n211XoMydLRI2FRdtuA7t6xHYbdts26/Kut7AVQ8
         x/E12kodmiXyyP7LRIrAau7/MQk0nRv0unkQpxUhy2vv0WbLOXtab5G1sBWio93tw/
         DQkwwU60L1kXk2+BLEH7SIzdQpfiNeZR14EAOtDiyaKxxASz6sZIj9AeApWIUofg7K
         NVGc9KvZrgKJyEsnirRregQuOjL9UUG8lMHr6M7v+/QTy+yECzLC/fvXAe9b6jvMrg
         /6/1nvrJTNBnw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?utf-8?Q?Bj=C3=B6rn?= Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2 2/8] riscv: add support for misaligned trap handling
 in S-mode
In-Reply-To: <20231004151405.521596-3-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
 <20231004151405.521596-3-cleger@rivosinc.com>
Date:   Wed, 04 Oct 2023 19:00:14 +0200
Message-ID: <871qeagw69.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> writes:

> Misalignment trap handling is only supported for M-mode and uses direct
> accesses to user memory. In S-mode, when handling usermode fault, this
> requires to use the get_user()/put_user() accessors. Implement
> load_u8(), store_u8() and get_insn() using these accessors for
> userspace and direct text access for kernel.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/Kconfig                    |   8 ++
>  arch/riscv/include/asm/entry-common.h |  14 +++
>  arch/riscv/kernel/Makefile            |   2 +-
>  arch/riscv/kernel/traps.c             |   9 --
>  arch/riscv/kernel/traps_misaligned.c  | 119 +++++++++++++++++++++++---
>  5 files changed, 129 insertions(+), 23 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6d..6e167358a897 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -636,6 +636,14 @@ config THREAD_SIZE_ORDER
>  	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
>  	  affects irq stack size, which is equal to thread stack size.
>=20=20
> +config RISCV_MISALIGNED
> +	bool "Support misaligned load/store traps for kernel and userspace"
> +	default y
> +	help
> +	  Say Y here if you want the kernel to embed support for misaligned
> +	  load/store for both kernel and userspace. When disable, misaligned
> +	  accesses will generate SIGBUS in userspace and panic in kernel.
> +
>  endmenu # "Platform type"
>=20=20
>  menu "Kernel features"
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/a=
sm/entry-common.h
> index 6e4dee49d84b..7ab5e34318c8 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -8,4 +8,18 @@
>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
>=20=20
> +#ifdef CONFIG_RISCV_MISALIGNED
> +int handle_misaligned_load(struct pt_regs *regs);
> +int handle_misaligned_store(struct pt_regs *regs);
> +#else
> +static inline int handle_misaligned_load(struct pt_regs *regs)
> +{
> +	return -1;
> +}
> +static inline int handle_misaligned_store(struct pt_regs *regs)
> +{
> +	return -1;
> +}
> +#endif
> +
>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 95cf25d48405..0d874fb24b51 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -59,7 +59,7 @@ obj-y	+=3D patch.o
>  obj-y	+=3D probes/
>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
>=20=20
> -obj-$(CONFIG_RISCV_M_MODE)	+=3D traps_misaligned.o
> +obj-$(CONFIG_RISCV_MISALIGNED)	+=3D traps_misaligned.o
>  obj-$(CONFIG_FPU)		+=3D fpu.o
>  obj-$(CONFIG_RISCV_ISA_V)	+=3D vector.o
>  obj-$(CONFIG_SMP)		+=3D smpboot.o
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 19807c4d3805..d69779e4b967 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -179,14 +179,6 @@ asmlinkage __visible __trap_section void do_trap_ins=
n_illegal(struct pt_regs *re
>=20=20
>  DO_ERROR_INFO(do_trap_load_fault,
>  	SIGSEGV, SEGV_ACCERR, "load access fault");
> -#ifndef CONFIG_RISCV_M_MODE
> -DO_ERROR_INFO(do_trap_load_misaligned,
> -	SIGBUS, BUS_ADRALN, "Oops - load address misaligned");
> -DO_ERROR_INFO(do_trap_store_misaligned,
> -	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
> -#else
> -int handle_misaligned_load(struct pt_regs *regs);
> -int handle_misaligned_store(struct pt_regs *regs);
>=20=20
>  asmlinkage __visible __trap_section void do_trap_load_misaligned(struct =
pt_regs *regs)
>  {
> @@ -229,7 +221,6 @@ asmlinkage __visible __trap_section void do_trap_stor=
e_misaligned(struct pt_regs
>  		irqentry_nmi_exit(regs, state);
>  	}
>  }
> -#endif
>  DO_ERROR_INFO(do_trap_store_fault,
>  	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
>  DO_ERROR_INFO(do_trap_ecall_s,
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index e7bfb33089c1..9daed7d756ae 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -12,6 +12,7 @@
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <asm/entry-common.h>
>=20=20
>  #define INSN_MATCH_LB			0x3
>  #define INSN_MASK_LB			0x707f
> @@ -151,21 +152,25 @@
>  #define PRECISION_S 0
>  #define PRECISION_D 1
>=20=20
> -static inline u8 load_u8(const u8 *addr)
> +#ifdef CONFIG_RISCV_M_MODE
> +static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_va=
l)
>  {
>  	u8 val;
>=20=20
>  	asm volatile("lbu %0, %1" : "=3D&r" (val) : "m" (*addr));
> +	*r_val =3D val;
>=20=20
> -	return val;
> +	return 0;
>  }
>=20=20
> -static inline void store_u8(u8 *addr, u8 val)
> +static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>  {
>  	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
> +
> +	return 0;
>  }
>=20=20
> -static inline ulong get_insn(ulong mepc)
> +static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_in=
sn)
>  {
>  	register ulong __mepc asm ("a2") =3D mepc;
>  	ulong val, rvc_mask =3D 3, tmp;
> @@ -194,9 +199,87 @@ static inline ulong get_insn(ulong mepc)
>  	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
>  	  [xlen_minus_16] "i" (XLEN_MINUS_16));
>=20=20
> -	return val;
> +	*r_insn =3D val;
> +
> +	return 0;
> +}
> +#else
> +static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_va=
l)
> +{
> +	if (user_mode(regs)) {
> +		return __get_user(*r_val, addr);
> +	} else {
> +		*r_val =3D *addr;
> +		return 0;
> +	}

One nit (...well two) ;-)

If you're respinning I'd get rid of the "inlines", and personally I
think early exit is easier to read. Applies to the whole patch.

  | {
  | 	if (user_mode(regs))
  | 		return __get_user(*r_val, addr);
  |=20
  |         *r_val =3D *addr;
  | 	return 0;
  | }


Regardless if you change or not,

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
