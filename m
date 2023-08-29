Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D8D78BE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjH2F5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjH2F4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A7EC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F0D62B2D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EABC433CA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693288607;
        bh=GHHkPR35toSxzOfxlddnnJ703WBXHEWeFZs2AlRYTcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ItiyHdGa5vJTY81r4sMWGGJGrcXn7GIRxjMZ/wQDd02NCME/plVcQXhrY/s0f2wuD
         pilpjxljACTzSaYIm8hzY2gFIprgOoOOOKhZqMzuiKZWiEPH/how8RKnr9Oz9Li9E3
         ScBlvma2MITIXPiBvGDm4+1sLaX5pU3nZVQVl3n4xsegP70nQA1djK1OBJ4DCeyRzj
         PG8VSKURBodV/LAP47R9hQ9QwOaNLobGEAMYBAHMK1vOlAoobCp5tin+m+FC0XYsC4
         4HJdg0RquZ/g5GmRflODwgPyIZzeUYcjsWifExWrmPRy4HqU6Af7vCrsR7Dd/PnoIF
         VEtzoVpERlnIg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so10171563a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:56:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YxmPXTx3CW6eF9WdCvNacMREsmky/YJGU1639CjrEqmabGsHyAN
        4WKKCRJmjwatCUU0+7aWc7RQ4rzDvUS2omCcOwY=
X-Google-Smtp-Source: AGHT+IEhuS/SYYom6A9cFYHQOUWJI/C4KpeyQx3moGfAV70g1L72S35b6Vfbvo5SPks92ju6HiVUV3Po9s/Uj7hxgLk=
X-Received: by 2002:a05:6402:42c5:b0:51d:cf7b:c9f0 with SMTP id
 i5-20020a05640242c500b0051dcf7bc9f0mr2143427edc.12.1693288605619; Mon, 28 Aug
 2023 22:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230827205641.46836-1-namcaov@gmail.com>
In-Reply-To: <20230827205641.46836-1-namcaov@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 29 Aug 2023 13:56:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQysBBSbtFcx1uY_ztTnzN5jRWpG2OD4O3aJ0u9Ekwsag@mail.gmail.com>
Message-ID: <CAJF2gTQysBBSbtFcx1uY_ztTnzN5jRWpG2OD4O3aJ0u9Ekwsag@mail.gmail.com>
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 4:56=E2=80=AFAM Nam Cao <namcaov@gmail.com> wrote:
>
> uprobes expects is_trap_insn() to return true for any trap instructions,
> not just the one used for installing uprobe. The current default
> implementation only returns true for 16-bit c.ebreak if C extension is
> enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> exception from userspace: uprobes asks is_trap_insn() who says there is n=
o
> trap, so uprobes assume a probe was there before but has been removed, an=
d
> return to the trap instruction. This cause an infinite loop of entering
> and exiting trap handler.
>
> Instead of using the default implementation, implement this function
> speficially for riscv which checks for both ebreak and c.ebreak.
>
> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/kernel/probes/uprobes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probe=
s/uprobes.c
> index 194f166b2cc4..91f4ce101cd1 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -3,6 +3,7 @@
>  #include <linux/highmem.h>
>  #include <linux/ptrace.h>
>  #include <linux/uprobes.h>
> +#include <asm/insn.h>
>
>  #include "decode-insn.h"
>
> @@ -17,6 +18,15 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
>  #endif
>  }
 >
> +bool is_trap_insn(uprobe_opcode_t *insn)
> +{
> +#ifdef CONFIG_RISCV_ISA_C
Can we remove the CONFIG_RISCV_ISA_C? As you said, "uprobes expects
is_trap_insn() to return true for any trap instructions". So userspace
wouldn't be limited by CONFIG_RISCV_ISA_C.

> +       if (riscv_insn_is_c_ebreak(*insn))
> +               return true;
> +#endif
> +       return riscv_insn_is_ebreak(*insn);
> +}
> +
>  unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
>  {
>         return instruction_pointer(regs);
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
