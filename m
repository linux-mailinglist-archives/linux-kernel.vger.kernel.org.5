Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1D7AFFED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjI0J0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjI0J0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:26:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C0010E;
        Wed, 27 Sep 2023 02:26:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5C5C433CC;
        Wed, 27 Sep 2023 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695806801;
        bh=8E27F9vDg06n7KRZbD66quQ/0obCYve0d6wN7L4/mIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KUf/QhYmt4vezb7gL5zmxcPipL6aEHrAU0O1FSPwJgQsND9bZ76JxnOrpTj6yx0Td
         BDOoxm72gtrUwFxAukZ1l08as3Phvh8wOpuv5GWxiBlK260884XxfQNob5+CxcAgf0
         G2mZnsx/wuG1dY0m17/lI7NBM0laCHiq2jyPZo9GHwhxieYdkV6qo07RPTpElE6QNr
         dER926bG0jSlV928zY92OAW1XKY3FEXq2MJKaDbNw/RdlLZDllMdG5bm7PeJ6TImPN
         Xinq6VMFCBkARoiyHypA9v635fJDUMER1iWiHaMmBg7+NMdNbLNkH4ZVq23IkIBDsf
         a7zZsXc4LBK7w==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c123eed8b2so178042261fa.0;
        Wed, 27 Sep 2023 02:26:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YyOs9ENQPEStpWOXiePa+/7MffdTUX9K4h36hLAlYId8s7yE4H0
        TPjnNH8AJ1sabRYiNIGWvAnrLJ+PyXtqLBFtRbc=
X-Google-Smtp-Source: AGHT+IH/ulAKGuCmgc8cYYmNPY9EPUC3Ee98HEPl/vUQhauUGM2xJnvYC87tZYHNuXQ9gWNZ5whG/YJU+1RgsBmoPms=
X-Received: by 2002:a2e:b6d3:0:b0:2c1:7fcf:c974 with SMTP id
 m19-20020a2eb6d3000000b002c17fcfc974mr1290153ljo.23.1695806799422; Wed, 27
 Sep 2023 02:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230927055954.3755-1-quic_aiquny@quicinc.com>
In-Reply-To: <20230927055954.3755-1-quic_aiquny@quicinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Sep 2023 09:26:28 +0000
X-Gmail-Original-Message-ID: <CAMj1kXEh=yQ12v1Ht6=-vgXVe8VCQTPdUD8AowkKcpyDXh_0mg@mail.gmail.com>
Message-ID: <CAMj1kXEh=yQ12v1Ht6=-vgXVe8VCQTPdUD8AowkKcpyDXh_0mg@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: Explicitly assign register for local variables
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     linux@armlinux.org.uk, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, quic_lijuang@quicinc.com,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maria,

On Wed, 27 Sept 2023 at 06:00, Maria Yu <quic_aiquny@quicinc.com> wrote:
>
> Registers r7 is removed in clobber list, so compiler may choose r7 for
> local variables usage, while r7 will be actually updated by the inline asm
> code.

The inline asm does not update R7, it preserves and restores it.

> This caused the runtime behavior wrong.

Could you explain how, exactly? In which cases is the preserve/restore
of R7 failing to achieve the intended result?

> While those kind of reserved registers cannot be set to clobber list
> because of error like "inline asm clobber list contains reserved
> registers".
> To both working for reserved register case and non-reserved register case,
> explicitly assign register for local variables which will be used as asm
> input.
>

If we make this change, could we remove the references to R7 altogether?

> Fixes: dd12e97f3c72 ("ARM: kprobes: treat R7 as the frame pointer register in Thumb2 builds")
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>  arch/arm/probes/kprobes/actions-thumb.c | 32 ++++++++++++++++---------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/probes/kprobes/actions-thumb.c b/arch/arm/probes/kprobes/actions-thumb.c
> index 51624fc263fc..f667b2f00b3e 100644
> --- a/arch/arm/probes/kprobes/actions-thumb.c
> +++ b/arch/arm/probes/kprobes/actions-thumb.c
> @@ -442,8 +442,10 @@ static unsigned long __kprobes
>  t16_emulate_loregs(probes_opcode_t insn,
>                    struct arch_probes_insn *asi, struct pt_regs *regs)
>  {
> -       unsigned long oldcpsr = regs->ARM_cpsr;
> -       unsigned long newcpsr;
> +       register unsigned long oldcpsr asm("r8") = regs->ARM_cpsr;
> +       register unsigned long newcpsr asm("r9");
> +       register void *rregs asm("r10") = regs;
> +       register void *rfn asm("lr") = asi->insn_fn;
>
>         __asm__ __volatile__ (
>                 "msr    cpsr_fs, %[oldcpsr]     \n\t"
> @@ -454,10 +456,10 @@ t16_emulate_loregs(probes_opcode_t insn,
>                 "mov    r7, r11                 \n\t"
>                 "mrs    %[newcpsr], cpsr        \n\t"
>                 : [newcpsr] "=r" (newcpsr)
> -               : [oldcpsr] "r" (oldcpsr), [regs] "r" (regs),
> -                 [fn] "r" (asi->insn_fn)
> +               : [oldcpsr] "r" (oldcpsr), [regs] "r" (rregs),
> +                 [fn] "r" (rfn)
>                 : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r11",
> -                 "lr", "memory", "cc"
> +                 "memory", "cc"
>                 );
>
>         return (oldcpsr & ~APSR_MASK) | (newcpsr & APSR_MASK);
> @@ -525,6 +527,9 @@ static void __kprobes
>  t16_emulate_push(probes_opcode_t insn,
>                 struct arch_probes_insn *asi, struct pt_regs *regs)
>  {
> +       register void *rfn asm("lr") = asi->insn_fn;
> +       register void *rregs asm("r10") = regs;
> +
>         __asm__ __volatile__ (
>                 "mov    r11, r7                 \n\t"
>                 "ldr    r9, [%[regs], #13*4]    \n\t"
> @@ -534,9 +539,9 @@ t16_emulate_push(probes_opcode_t insn,
>                 "str    r9, [%[regs], #13*4]    \n\t"
>                 "mov    r7, r11                 \n\t"
>                 :
> -               : [regs] "r" (regs), [fn] "r" (asi->insn_fn)
> +               : [regs] "r" (rregs), [fn] "r" (rfn)
>                 : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r8", "r9", "r11",
> -                 "lr", "memory", "cc"
> +                 "memory", "cc"
>                 );
>  }
>
> @@ -561,6 +566,9 @@ static void __kprobes
>  t16_emulate_pop_nopc(probes_opcode_t insn,
>                 struct arch_probes_insn *asi, struct pt_regs *regs)
>  {
> +       register void *rfn asm("lr") = asi->insn_fn;
> +       register void *rregs asm("r8") = regs;
> +
>         __asm__ __volatile__ (
>                 "mov    r11, r7                 \n\t"
>                 "ldr    r9, [%[regs], #13*4]    \n\t"
> @@ -570,9 +578,9 @@ t16_emulate_pop_nopc(probes_opcode_t insn,
>                 "str    r9, [%[regs], #13*4]    \n\t"
>                 "mov    r7, r11                 \n\t"
>                 :
> -               : [regs] "r" (regs), [fn] "r" (asi->insn_fn)
> +               : [regs] "r" (rregs), [fn] "r" (rfn)
>                 : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r9", "r11",
> -                 "lr", "memory", "cc"
> +                 "memory", "cc"
>                 );
>  }
>
> @@ -581,6 +589,8 @@ t16_emulate_pop_pc(probes_opcode_t insn,
>                 struct arch_probes_insn *asi, struct pt_regs *regs)
>  {
>         register unsigned long pc asm("r8");
> +       register void *rfn asm("lr") = asi->insn_fn;
> +       register void *rregs asm("r10") = regs;
>
>         __asm__ __volatile__ (
>                 "mov    r11, r7                 \n\t"
> @@ -591,9 +601,9 @@ t16_emulate_pop_pc(probes_opcode_t insn,
>                 "str    r9, [%[regs], #13*4]    \n\t"
>                 "mov    r7, r11                 \n\t"
>                 : "=r" (pc)
> -               : [regs] "r" (regs), [fn] "r" (asi->insn_fn)
> +               : [regs] "r" (rregs), [fn] "r" (rfn)
>                 : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r9", "r11",
> -                 "lr", "memory", "cc"
> +                 "memory", "cc"
>                 );
>
>         bx_write_pc(pc, regs);
>
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> --
> 2.17.1
>
