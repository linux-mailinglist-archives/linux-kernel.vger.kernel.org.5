Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E1180FB89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377481AbjLLXpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjLLXpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:45:34 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48C8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:45:40 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5e2b8f480b3so380887b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702424740; x=1703029540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyjaDMcAOxN0dCLePetIVRjmx5K1JwIuU6FTTfYueuY=;
        b=HBdGiqKwvrDjWIT9O0tBbrNs0N781+aWJlZBmHpcmurV8Y9WSFkYJDM69AQdXm+MdO
         e4B9oRIpi5Zlmq8WMobdy2U9v6KtR8mnDVosPDP4RCdkZoELhiDsJj96TZZRznjcOlDW
         E7czyvZ9vOIhxPFarEMLNF5IN3AfzYbHW5l0ZOytOid+1etTqmfSDIOXRqiiltWyx1mh
         7mfBsPCBJx2n19aW3zGCgdR4AxHOz1iodmN8HfaayJJtT4Q9n/ryXt6xldIbckGG7wqi
         7YQ4xKSdm4DMez5bo5QELGBJkCE47E7RjUivcUirHhSt89acskn6ocLk35hXYiV6VKgk
         1q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424740; x=1703029540;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyjaDMcAOxN0dCLePetIVRjmx5K1JwIuU6FTTfYueuY=;
        b=RSb8L0lgbmSScYmle7/sIrCKtYXKIsmjgTH1pas4dvLJXrFb2lyjg72Z7IJpnvGWRq
         JKZKBCArRlEeznjV3UGsbOhYTtYNIf5Rhcj/q/X+gUFkY72gL2ajfHgJ86RPK4LGmGbU
         l0Cwq0mPz2bPWZgCjtXw4k9uxB9YXBzmH2GxtSc1m+FlvhhxDrb26+fKDLg/4nnvoUGn
         4lUInz+fCC/HJ33BNiBc8xLWkqmNW8MQ6i7tW3OY4uUN9pXfNdHapxhx49rsV9PLSQI0
         qtLRtUZRYrYp9JVockOyjCS5rLrDNSQaCN6v00OuS1QfRWk7kJbEJNc/YYe1qG8b5oHA
         fmlA==
X-Gm-Message-State: AOJu0Yw5ud0eaXrmFQYDablB7I5F/v6G3/hxUqT4ry7s/s8lpJtApL55
        n2RKMWv+bnccRI7khOloqVS3rq8+J8lGyRI44GQPpKmQzfPt6iPQFDcosA==
X-Received: by 2002:a5b:889:0:b0:db9:e78d:7eff with SMTP id
 e9-20020a5b0889000000b00db9e78d7effmt942246ybq.59.1702424739879; Tue, 12 Dec
 2023 15:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20231212234310.2034900-1-debug@rivosinc.com>
In-Reply-To: <20231212234310.2034900-1-debug@rivosinc.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Tue, 12 Dec 2023 15:45:28 -0800
Message-ID: <CAKC1njTpVN51j=xFHkbZBY6PDeGp8tVRBcgATTZPVHMuaGEz8A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] riscv: abstract envcfg CSR
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some issues in workflow. Patches didn't come out separately.

Ignore this.

On Tue, Dec 12, 2023 at 3:43=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> This patch abstracts envcfg CSR in kernel (as is done for other homonyn
> CSRs). CSR_ENVCFG is used as alias for CSR_SENVCFG or CSR_MENVCFG dependi=
ng
> on how kernel is compiled.
>
> Additionally it changes CBZE enabling to start using CSR_ENVCFG instead o=
f
> CSR_SENVCFG.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h   | 2 ++
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 306a19a5509c..b3400517b0a9 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -415,6 +415,7 @@
>  # define CSR_STATUS    CSR_MSTATUS
>  # define CSR_IE                CSR_MIE
>  # define CSR_TVEC      CSR_MTVEC
> +# define CSR_ENVCFG CSR_MENVCFG
>  # define CSR_SCRATCH   CSR_MSCRATCH
>  # define CSR_EPC       CSR_MEPC
>  # define CSR_CAUSE     CSR_MCAUSE
> @@ -439,6 +440,7 @@
>  # define CSR_STATUS    CSR_SSTATUS
>  # define CSR_IE                CSR_SIE
>  # define CSR_TVEC      CSR_STVEC
> +# define CSR_ENVCFG CSR_SENVCFG
>  # define CSR_SCRATCH   CSR_SSCRATCH
>  # define CSR_EPC       CSR_SEPC
>  # define CSR_CAUSE     CSR_SCAUSE
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index b3785ffc1570..98623393fd1f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -725,7 +725,7 @@ arch_initcall(check_unaligned_access_all_cpus);
>  void riscv_user_isa_enable(void)
>  {
>         if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_IS=
A_EXT_ZICBOZ))
> -               csr_set(CSR_SENVCFG, ENVCFG_CBZE);
> +               csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>  }
>
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> --
> 2.43.0
>
>
> From 2ad5b91bda97f6dbc9f48a2e0e8c6eae5b8452ca Mon Sep 17 00:00:00 2001
> From: Deepak Gupta <debug@rivosinc.com>
> Date: Tue, 12 Dec 2023 14:28:59 -0800
> Subject: [PATCH v1 2/2] riscv: envcfg save and restore on trap entry/exit
>
> envcfg CSR defines enabling bits for cache management instructions and so=
on
> will control enabling for control flow integrity and pointer masking feat=
ures.
>
> Control flow integrity and pointer masking features need to be enabled on=
 per
> thread basis. Additionally, I believe cache management instructions need =
to be
> enabled on per thread basis. As an example a seccomped task on riscv may =
be
> restricted to not use cache management instructions
>
> This patch creates a place holder for envcfg CSR in `thread_info` and add=
s
> logic to save and restore on trap entry and exits. This allows such isa f=
eature
> to be enabled on per thread basis.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/thread_info.h | 1 +
>  arch/riscv/kernel/asm-offsets.c      | 1 +
>  arch/riscv/kernel/entry.S            | 6 ++++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 574779900bfb..320bc899a63b 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -57,6 +57,7 @@ struct thread_info {
>         long                    user_sp;        /* User stack pointer */
>         int                     cpu;
>         unsigned long           syscall_work;   /* SYSCALL_WORK_ flags */
> +       unsigned long envcfg;
>  #ifdef CONFIG_SHADOW_CALL_STACK
>         void                    *scs_base;
>         void                    *scs_sp;
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index a03129f40c46..cdd8f095c30c 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -39,6 +39,7 @@ void asm_offsets(void)
>         OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_co=
unt);
>         OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>         OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
> +       OFFSET(TASK_TI_ENVCFG, task_struct, thread_info.envcfg);
>  #ifdef CONFIG_SHADOW_CALL_STACK
>         OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>  #endif
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 54ca4564a926..a1d87013f15a 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -64,12 +64,14 @@ SYM_CODE_START(handle_exception)
>         csrr s3, CSR_TVAL
>         csrr s4, CSR_CAUSE
>         csrr s5, CSR_SCRATCH
> +       csrr s6, CSR_ENVCFG
>         REG_S s0, PT_SP(sp)
>         REG_S s1, PT_STATUS(sp)
>         REG_S s2, PT_EPC(sp)
>         REG_S s3, PT_BADADDR(sp)
>         REG_S s4, PT_CAUSE(sp)
>         REG_S s5, PT_TP(sp)
> +       REG_S s6, TASK_TI_ENVCFG(tp)
>
>         /*
>          * Set the scratch register to 0, so that if a recursive exceptio=
n
> @@ -129,6 +131,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>         addi s0, sp, PT_SIZE_ON_STACK
>         REG_S s0, TASK_TI_KERNEL_SP(tp)
>
> +       /* restore envcfg bits for current thread */
> +       REG_L s0, TASK_TI_ENVCFG(tp)
> +       csrw CSR_ENVCFG, s0
> +
>         /* Save the kernel shadow call stack pointer */
>         scs_save_current
>
> --
> 2.43.0
>
