Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED378C1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjH2Jsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjH2Jsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D3E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2000C614BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ECFC433CA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693302512;
        bh=Ie5xcTYnrckxg5XqByJnbSDX/dunTFFUtMXUS58dsIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YNT4xgy7zjQeED/xAJkzhazs0cVi0PZzFcHbcPyB3fNMMk/1T7eruJjHxw4onQC3l
         7IOAaLRZ4tfKzwKPhexWoMsAR5QBxSXFu+nNcwdsH3hXvrvS681e7Y2fbV2H4VuuT8
         fJQw4TmIGhM63/lnUyIx8+Rq3K3ftr+lF2EnXHEOWh351NGUhIMCatpu0h02jfgLVo
         2IO2BlcU/qCdblDjMAuZ/h54bjVGRr6js2GXRRu2VPc8lr0JVDUtYkFnSKvgI1tfvv
         GJqAB+GbdRakKJqu7l3DjEX5j9VzoCVR3L8E+4Ry95coZHjBekwS6Ot7zoTVRPhJbJ
         uPPlvQ9Ah8LxA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52a3aa99bcdso5870509a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:48:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YxwZkbuqN5Zkbr3TJ/q7/x3vbRCLIGyRauvlutH13/FK1zl/H30
        rsGAxE7kUq38XjPRV21MFaOY7kj7Y071kx+s1Pg=
X-Google-Smtp-Source: AGHT+IGlVJEQGrdz0NMMhRYrrwdVqAz+hx4g2Fcuryt6QGy9sIKlI9nXA9wCpnaKjF5re6+FCHvT26gKZTR/GNPWOsw=
X-Received: by 2002:a05:6402:b29:b0:523:4a4e:3b57 with SMTP id
 bo9-20020a0564020b2900b005234a4e3b57mr21591777edb.13.1693302510808; Tue, 29
 Aug 2023 02:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230829083614.117748-1-namcaov@gmail.com>
In-Reply-To: <20230829083614.117748-1-namcaov@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 29 Aug 2023 17:48:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTdEY-H7QrVyY31Z5nCG0yqo4Zo9W1dBbGEzRqZdec55Q@mail.gmail.com>
Message-ID: <CAJF2gTTdEY-H7QrVyY31Z5nCG0yqo4Zo9W1dBbGEzRqZdec55Q@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: provide riscv-specific is_trap_insn()
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn@kernel.org, conor.dooley@microchip.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
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

Thx for the fix.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Tue, Aug 29, 2023 at 4:37=E2=80=AFPM Nam Cao <namcaov@gmail.com> wrote:
>
> uprobes expects is_trap_insn() to return true for any trap instructions,
> not just the one used for installing uprobe. The current default
> implementation only returns true for 16-bit c.ebreak if C extension is
> enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> exception from userspace: uprobes asks is_trap_insn() who says there is n=
o
> trap, so uprobes assume a probe was there before but has been removed, an=
d
> return to the trap instruction. This causes an infinite loop of entering
> and exiting trap handler.
>
> Instead of using the default implementation, implement this function
> speficially for riscv with checks for both ebreak and c.ebreak.
>
> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
> v2: remove #ifdef CONFIG_RISCV_ISA_C (Guo Ren)
>
>  arch/riscv/kernel/probes/uprobes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probe=
s/uprobes.c
> index 194f166b2cc4..4b3dc8beaf77 100644
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
> @@ -17,6 +18,11 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
>  #endif
>  }
>
> +bool is_trap_insn(uprobe_opcode_t *insn)
> +{
> +       return riscv_insn_is_ebreak(*insn) || riscv_insn_is_c_ebreak(*ins=
n);
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
