Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C067B810707
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378057AbjLMAxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377870AbjLMAxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:53:43 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4999
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:53:49 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-2030c48c44bso615419fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1702428829; x=1703033629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLdUANKx1unw1AGMMFZA8UJQoW39VHxwZQDjHsgtVuo=;
        b=sO/8D06rnK00fbeBSlsSJSvDtgND33HU8uuqJoJXmaviEr7ucLJAoo8HVmzxWvwi/0
         PdRwPRKkIly8PmkxZHi2CKqWLkQH4X7oJv3fNOkRMAks7MMgUKyEyvAKWIxHgmGWtIE3
         3PU59+4MozNsns5Jo94FMY6S2RIlYf2sY5kUJ7HvdEy+WiStn9Zv6jDWMWSCzna23Jze
         lNpuGuZEcy8lxdGakOA7EsieRahuDEVSoWZTj5Go6NpY+7MbFI2YD9xYIyoIbdoHaYC7
         TMX1dPFvPT5roTQZHnos/D9IDBrNhnF7Ka3cXBiL/+mxfxdlwqA6fwDnBiwSHW5Wodwq
         kN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702428829; x=1703033629;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLdUANKx1unw1AGMMFZA8UJQoW39VHxwZQDjHsgtVuo=;
        b=hKlrVcx/PFCYElucbk21P7BP1+CEGKO886Uu88BZO0ALCHFTdemPD1+TGF+5kA9ztr
         5utNHq+YN3CrFk6+ZUeaU+AevFqoTLfQdTbn2v8jzBGTRFFFM+Jha1Opw5jf2b4KzSqb
         /qQbRVXXnGRbJoBF8hpucWPCX0KkNWSCq96sOxV9SCwX/LDqyczjG2LyuwlOlHyoHQ5Z
         2MC3P0qdHJetx3WjYgp2jTvCLv3S0wzqaJ/n5HntGiABVi4+7NedmqvKrjqREY9Mp32b
         wpIjjHqY1v96u6KxH/7OSws53UKiqvUnGcF7weoFLWyWmLRj0RvAAR8GW2osQAmzQXj1
         nEbA==
X-Gm-Message-State: AOJu0YyV0NzaC9xU7w9ZMx+HNqqJktLdvb21vFKotqFyXTRsmyWXD9Tc
        rS9gbwh0+3kWGgVizl36sVFznA==
X-Google-Smtp-Source: AGHT+IGyVfDGoC7uEkGdgEpcr0ILaIXni8QSJmDJiAwHxn36ZwOh21g2jQ843mnPTqLdQDHoedWuIg==
X-Received: by 2002:a05:6870:e256:b0:1fb:29af:7359 with SMTP id d22-20020a056870e25600b001fb29af7359mr8173956oac.81.1702428828908;
        Tue, 12 Dec 2023 16:53:48 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id s7-20020a656447000000b005c693386cb6sm7430216pgv.13.2023.12.12.16.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:53:48 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:53:48 -0800 (PST)
X-Google-Original-Date: Tue, 12 Dec 2023 16:53:31 PST (-0800)
Subject:     Re: [PATCH v1 2/2] riscv: envcfg save and restore on trap entry/exit
In-Reply-To: <20231212235003.2036221-1-debug@rivosinc.com>
CC:     debug@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        ajones@ventanamicro.com, guoren@kernel.org,
        mchitale@ventanamicro.com, waylingii@gmail.com,
        greentime.hu@sifive.com, samitolvanen@google.com,
        Bjorn Topel <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        jeeheng.sia@starfivetech.com, Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>, jszhang@kernel.org,
        cleger@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     debug@rivosinc.com
Message-ID: <mhng-ae72b5fd-358d-48e2-87cf-f571b67afe9e@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 15:49:25 PST (-0800), debug@rivosinc.com wrote:
> envcfg CSR defines enabling bits for cache management instructions and soon
> will control enabling for control flow integrity and pointer masking features.
>
> Control flow integrity and pointer masking features need to be enabled on per
> thread basis. Additionally, I believe cache management instructions need to be
> enabled on per thread basis. As an example a seccomped task on riscv may be
> restricted to not use cache management instructions

Do we have anything in the kernel that actually does that?  Generally we 
need some use, I couldn't find any user-mode writable envcfg bits in any 
extesions I looked at (admittidly just CFI and pointer masking), and 
unless I'm missing something there's no per-thread state in the kernel.

> This patch creates a place holder for envcfg CSR in `thread_info` and adds
> logic to save and restore on trap entry and exits. This allows such isa feature
> to be enabled on per thread basis.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/thread_info.h | 1 +
>  arch/riscv/kernel/asm-offsets.c      | 1 +
>  arch/riscv/kernel/entry.S            | 6 ++++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 574779900bfb..320bc899a63b 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -57,6 +57,7 @@ struct thread_info {
>  	long			user_sp;	/* User stack pointer */
>  	int			cpu;
>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
> +	unsigned long envcfg;
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	void			*scs_base;
>  	void			*scs_sp;
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index a03129f40c46..cdd8f095c30c 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -39,6 +39,7 @@ void asm_offsets(void)
>  	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
> +	OFFSET(TASK_TI_ENVCFG, task_struct, thread_info.envcfg);
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>  #endif
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 54ca4564a926..a1d87013f15a 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -64,12 +64,14 @@ SYM_CODE_START(handle_exception)
>  	csrr s3, CSR_TVAL
>  	csrr s4, CSR_CAUSE
>  	csrr s5, CSR_SCRATCH
> +	csrr s6, CSR_ENVCFG
>  	REG_S s0, PT_SP(sp)
>  	REG_S s1, PT_STATUS(sp)
>  	REG_S s2, PT_EPC(sp)
>  	REG_S s3, PT_BADADDR(sp)
>  	REG_S s4, PT_CAUSE(sp)
>  	REG_S s5, PT_TP(sp)
> +	REG_S s6, TASK_TI_ENVCFG(tp)
>
>  	/*
>  	 * Set the scratch register to 0, so that if a recursive exception
> @@ -129,6 +131,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  	addi s0, sp, PT_SIZE_ON_STACK
>  	REG_S s0, TASK_TI_KERNEL_SP(tp)
>
> +	/* restore envcfg bits for current thread */
> +	REG_L s0, TASK_TI_ENVCFG(tp)
> +	csrw CSR_ENVCFG, s0
> +
>  	/* Save the kernel shadow call stack pointer */
>  	scs_save_current
