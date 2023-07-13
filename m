Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2F752945
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjGMQ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE58268B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782AB61AF0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFC1C433C9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689267594;
        bh=TqUzlchrwXhWN1S5Z6sliL6d9960E2KXgd/K23x2LgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=azdQ1ugZPoeMI5qSZANJA6Lxx/V6JE58/ySohLcHWmGP4h4naCXlLhhYvL+bQ6eyp
         hmb+/VEbXL1tjjkOCF3YO8WFJ1bTRfbY79uEDb1xT2O7kcC4OSAF4TaC7bE4CoeAdu
         X7i1vfurRjXdm+/4bBzE5Ddd4nCi3Y1JTdufCnB/UeKdRKjeL7PCidoQKy4bm5ItGg
         0vl32hZbHg43dlBzvt6+OCEOiYmhzwLMptPTpeIkSALRMl6EFRXxgIgVtBt8Mby1BI
         IvaLZSNq8wAXt93+Ux8P4sFTQ9DfBEoGVUq81pCTVJrkKqx+EuBzeUkjuV6T3oGKtP
         b4STEcjOZA/vw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51e43473ee0so1145919a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:59:54 -0700 (PDT)
X-Gm-Message-State: ABy/qLYB8X5zGXVZJSpbYFumQBQ3dHw5MLzf/Leeiet54u58q9MA4d8W
        Xo9HeC0A84eJlzcOCzHX8uoErizmPxFNfPU+KXE=
X-Google-Smtp-Source: APBJJlHHq6Js4fVdWS/uvXkMp8W5udysBEttpg8LjaaxKrtysI0emny2lCbalKT5PSYGULPvocJPPEv3oQKm7THOQRU=
X-Received: by 2002:a50:ef16:0:b0:51e:5322:a642 with SMTP id
 m22-20020a50ef16000000b0051e5322a642mr2114442eds.27.1689267593039; Thu, 13
 Jul 2023 09:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230711062202.3542367-1-CoelacanthusHex@gmail.com>
 <CAJF2gTRgXbEfQWiWtZtVNBDhpY2miG_ByHrVZF2fbfu60hCHcQ@mail.gmail.com> <37a22693-e33c-f64a-e3d7-febed8e9f195@gmail.com>
In-Reply-To: <37a22693-e33c-f64a-e3d7-febed8e9f195@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 13 Jul 2023 12:59:40 -0400
X-Gmail-Original-Message-ID: <CAJF2gTTmKPR-jwEpKFT4qzNqZLQV--RMzSH5LA-EPw8eSVi56g@mail.gmail.com>
Message-ID: <CAJF2gTTmKPR-jwEpKFT4qzNqZLQV--RMzSH5LA-EPw8eSVi56g@mail.gmail.com>
Subject: Re: [PATCH] riscv: entry: set a0 prior to syscall_handler
To:     Celeste Liu <coelacanthushex@gmail.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:28=E2=80=AFAM Celeste Liu <coelacanthushex@gmail=
.com> wrote:
>
>
> On 2023/7/13 08:00, Guo Ren wrote:
> > On Tue, Jul 11, 2023 at 2:22=E2=80=AFAM Celeste Liu <coelacanthushex@gm=
ail.com> wrote:
> >>
> >> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> >> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we wil=
l
> >> get ENOSYS. We got same result with 9c2598d43510 ("riscv: entry: Save =
a0
> >> prior syscall_enter_from_user_mode()").
> >>
> >> Compared with x86 and loongarch's implementation of this part of the
> >> function, we think that regs->a0 =3D -ENOSYS should be advanced before
> >> syscall_handler to fix this problem. We have written the following pat=
ch,
> >> which can fix this problem after testing. But we don't know enough abo=
ut
> >> this part of the code to explain the root cause. Hope someone can find
> >> a reasonable explanation. And we'd like to reword this commit message
> >> according to the explanation in v2
> >>
> >> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> >> Reported-by: Felix Yan <felixonmars@archlinux.org>
> >> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> >> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> >> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> >> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> >> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> >> Tested-by: Felix Yan <felixonmars@archlinux.org>
> >> ---
> >>  arch/riscv/kernel/traps.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >> index f910dfccbf5d2..ccadb5ffd063c 100644
> >> --- a/arch/riscv/kernel/traps.c
> >> +++ b/arch/riscv/kernel/traps.c
> >> @@ -301,6 +301,7 @@ asmlinkage __visible __trap_section void do_trap_e=
call_u(struct pt_regs *regs)
> >>
> >>                 regs->epc +=3D 4;
> >>                 regs->orig_a0 =3D regs->a0;
> >> +               regs->a0 =3D -ENOSYS;
> > Oh, no. You destroyed the a0 for syscall_handler, right? It's not
> > reasonable. Let's see which syscall_handler needs a0=3D-ENOSYS.
>
> syscall_handler always use orig_a0, not a0.
> And I have a mistake in original email, corret one is
> syscall_enter_from_user_mode not syscall_handler.
I misunderstood. Yes, a0 would be replaced by orig_a0:
syscall_enter_from_user_mode_work ->  syscall_rollback

If the syscall was denied by syscall_enter_from_user_mode(), the
return number is forced to be -ENOSYS. Maybe regs->a0 has already been
updated by SYSCALL_WORK_SECCOMP. eg:

__seccomp_filter() {
...
        case SECCOMP_RET_TRAP:
                /* Show the handler the original registers. */
                syscall_rollback(current, current_pt_regs());
                /* Let the filter pass back 16 bits of data. */
                force_sig_seccomp(this_syscall, data, false);
                goto skip;

>
> > Could you give out more detail on your test case?
> >
> >>
> >>                 riscv_v_vstate_discard(regs);
> >>
> >> @@ -308,8 +309,6 @@ asmlinkage __visible __trap_section void do_trap_e=
call_u(struct pt_regs *regs)
> >>
> >>                 if (syscall < NR_syscalls)
> >>                         syscall_handler(regs, syscall);
> >> -               else
> >> -                       regs->a0 =3D -ENOSYS;
> >>
> >>                 syscall_exit_to_user_mode(regs);
> >>         } else {
> >> --
> >> 2.41.0
> >>
> >
> >
>


--=20
Best Regards
 Guo Ren
