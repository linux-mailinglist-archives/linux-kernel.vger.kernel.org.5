Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A083C7EDF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjKPLLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345083AbjKPLLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:11:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54042AA;
        Thu, 16 Nov 2023 03:11:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C03C433C7;
        Thu, 16 Nov 2023 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700133076;
        bh=S39I4q3Z2eyaTdKnVU0kVAHPshukGXcnGgf90hu5hNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kFY3JkENtL0CxjTkP/J8DwUB+SNQglfyJDHH7+sTiuRn0h/RUE7p3oaQ9qmm2EqUz
         lJ8fKPSOka5GNjCzNZHxSf7AG6Gxycoolw68U9X3zNLhbf+PorV19XXd+0AJ9dW/Xv
         Rs1D2g3X/xGGTH1hLuNRHeoRpA6X+9eMtKXDG3WLqM4c7l+4a5VetChSvtL3/ZQrwI
         U355iW85fbSl1wMHuMOjIACUU9o+H6yzVw3tyyJmpQB9iKCoTXzWcBj5tSPrEMsbRa
         JotGEznqCUVHoaEh6BM6b7ygvXrc8KQcKlmNu5a3klH/eu9lvDm5WiyUxcJJGGmqV1
         WVw+8Ya70CViw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c6b5841f61so7347201fa.0;
        Thu, 16 Nov 2023 03:11:15 -0800 (PST)
X-Gm-Message-State: AOJu0Ywscy8wiDPGFjgcafrbTxcYyYihQieq1sou7jrvNexEPYYivadF
        zHsROOAexZil6XVizYMZPVhrmr2PpdWU8Lrqst4=
X-Google-Smtp-Source: AGHT+IFuerTCkQll0+xraF3KBCWCtKLNVm468vnWCiWQYEjYBagDH99HbCteNccZAey1E04nPRwuluu4JS60wiQzko0=
X-Received: by 2002:a05:651c:20b:b0:2c6:edf1:b05e with SMTP id
 y11-20020a05651c020b00b002c6edf1b05emr580932ljn.15.1700133074166; Thu, 16 Nov
 2023 03:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20231115095830.20607-1-quic_aiquny@quicinc.com>
In-Reply-To: <20231115095830.20607-1-quic_aiquny@quicinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Nov 2023 21:11:03 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEHjY2NmEztvfQR34k903Jgx_4fqgHpkxq4YAiTc5szyA@mail.gmail.com>
Message-ID: <CAMj1kXEHjY2NmEztvfQR34k903Jgx_4fqgHpkxq4YAiTc5szyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: kprobes: Explicitly reserve r7 for local variables
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     linux@armlinux.org.uk, mhiramat@kernel.org, kernel@quicinc.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_lijuang@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 19:58, Maria Yu <quic_aiquny@quicinc.com> wrote:
>
> Registers r7 is removed in clobber list, so compiler may choose r7 for
> local variables usage, while r7 will be actually updated by the inline asm
> code. This caused the runtime behavior wrong.
> While those kind of reserved registers cannot be set to clobber list
> because of error like "inline asm clobber list contains reserved
> registers".
> Explicitly reserve r7 by adding attribute no-omit-frame-pointer for needed
> function, then in T32 asm code r7 is used as a frame pointer and is not
> available for use as a general-purpose register.
> Note that "no-omit-frame-pointer" will make the code size a little bigger
> to store the stack frame pointer. So limited to needed functions can have
> the less impact than the full source file.
>
> Fixes: dd12e97f3c72 ("ARM: kprobes: treat R7 as the frame pointer register in Thumb2 builds")
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/probes/kprobes/actions-thumb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/probes/kprobes/actions-thumb.c b/arch/arm/probes/kprobes/actions-thumb.c
> index 51624fc263fc..c2fdaf9f6dba 100644
> --- a/arch/arm/probes/kprobes/actions-thumb.c
> +++ b/arch/arm/probes/kprobes/actions-thumb.c
> @@ -438,7 +438,7 @@ t16_simulate_branch(probes_opcode_t insn,
>         regs->ARM_pc = pc + (offset * 2);
>  }
>
> -static unsigned long __kprobes
> +static unsigned long __kprobes __attribute__((optimize("no-omit-frame-pointer")))
>  t16_emulate_loregs(probes_opcode_t insn,
>                    struct arch_probes_insn *asi, struct pt_regs *regs)
>  {
> @@ -521,7 +521,7 @@ t16_decode_hiregs(probes_opcode_t insn, struct arch_probes_insn *asi,
>         return INSN_GOOD;
>  }
>
> -static void __kprobes
> +static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
>  t16_emulate_push(probes_opcode_t insn,
>                 struct arch_probes_insn *asi, struct pt_regs *regs)
>  {
> @@ -557,7 +557,7 @@ t16_decode_push(probes_opcode_t insn, struct arch_probes_insn *asi,
>         return INSN_GOOD;
>  }
>
> -static void __kprobes
> +static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
>  t16_emulate_pop_nopc(probes_opcode_t insn,
>                 struct arch_probes_insn *asi, struct pt_regs *regs)
>  {
> @@ -576,7 +576,7 @@ t16_emulate_pop_nopc(probes_opcode_t insn,
>                 );
>  }
>
> -static void __kprobes
> +static void __kprobes __attribute__((optimize("no-omit-frame-pointer")))
>  t16_emulate_pop_pc(probes_opcode_t insn,
>                 struct arch_probes_insn *asi, struct pt_regs *regs)
>  {
>
> base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
> --
> 2.17.1
>
