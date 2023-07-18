Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80575891C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjGRXlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGRXlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B79F7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A61A61517
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D748C433C7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689723659;
        bh=DRh2FHZCzUx96KLTXcTCK0u1TO+iirQ1LzrX8lftc1E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d8TRYo6DvYZ0iN7seeckDNZjYusIFnpLA1F1v+O209G2BEKGF2z1QsIK7R7Ee7k6C
         wV50snzfO80fItw6pFd0d6PpNbenD202za+AcaZkyXupCRmeMTpCtotVHoI/osrE4p
         gnfOjU/IwzR74mInqSdVOrCnHm8YTFFjV/TEH7RCTnSSDj0MBTgOmMzDD9AMJUM7aG
         HZocnnM4uK4yscLH6XXexohygWbtlOcYYkOdXKTLFEN6z+gwE6csBiUqTP88oIFVDB
         KMiW5HK+xHQZNlmfmW8R6a7UNQVGAMgqu7vevk3BNG8EONZQ6jY4PzJ6RPZHqKQI5/
         RbEsCr8OIl0uw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so10265676e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:40:59 -0700 (PDT)
X-Gm-Message-State: ABy/qLaaYudXqWs3J5wxr2WUpTOQ9op+Bri/PtDpJonhHCAECLDTj3Ak
        Jl80X/+TfIwpYV9Dol7xzJMihmZyiPLqnHyRMNk=
X-Google-Smtp-Source: APBJJlEImN9uPdbo58WUltonLKZ018auQOFm5qSKBq4+c7OS2ZWjghv07EZij1SX+ehsOn6+kGBHQuLLandLCPb9JJA=
X-Received: by 2002:a05:6512:3414:b0:4fb:7b2a:78de with SMTP id
 i20-20020a056512341400b004fb7b2a78demr852126lfr.45.1689723657633; Tue, 18 Jul
 2023 16:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
In-Reply-To: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 Jul 2023 07:40:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRf0UOYhqwUm6=1YMvZt8q_72WRUHqN=L+nOWaipL+H1Q@mail.gmail.com>
Message-ID: <CAJF2gTRf0UOYhqwUm6=1YMvZt8q_72WRUHqN=L+nOWaipL+H1Q@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall != -1
To:     Celeste Liu <coelacanthushex@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 5:01=E2=80=AFAM Celeste Liu <coelacanthushex@gmail.=
com> wrote:
>
> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
> get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv: =
entry:
> Save a0 prior syscall_enter_from_user_mode()").
>
> After analysing code, we think that regs->a0 =3D -ENOSYS should only be e=
xecuted
> when syscall !=3D -1 In __seccomp_filter, when seccomp rejected this sysc=
all with
> specified errno, they will set a0 to return number as syscall ABI, and th=
en
> return -1. This return number is finally pass as return number of
> syscall_enter_from_user_mode, and then is compared with NR_syscalls after
> converted to ulong (so it will be ULONG_MAX). The condition
> syscall < NR_syscalls will always be false, so regs->a0 =3D -ENOSYS is al=
ways
> executed. It covered a0 set by seccomp, so we always get ENOSYS when matc=
h
> seccomp RET_ERRNO rule.
>
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Reported-by: Felix Yan <felixonmars@archlinux.org>
> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> Tested-by: Felix Yan <felixonmars@archlinux.org>
> ---
>
> v2 -> v3: use if-statement instead of set default value,
>           clarify the type of syscall
> v1 -> v2: added explanation on why always got ENOSYS
>
>  arch/riscv/kernel/traps.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d2..5cef728745420 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -297,6 +297,10 @@ asmlinkage __visible __trap_section void do_trap_bre=
ak(struct pt_regs *regs)
>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs =
*regs)
>  {
>         if (user_mode(regs)) {
> +               /*
> +                * Convert negative numbers to very high and thus out of =
range
> +                * numbers for comparisons.
> +                */
>                 ulong syscall =3D regs->a7;
>
>                 regs->epc +=3D 4;
> @@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap_ecal=
l_u(struct pt_regs *regs)
>
>                 if (syscall < NR_syscalls)
>                         syscall_handler(regs, syscall);
> -               else
> +               else if ((long)syscall !=3D -1L)
Maybe we should define an explicit macro for this ERRNO in
__seccomp_filter, and this style obeys the coding convention.

For this patch:
Reviewed-by: Guo Ren <guoren@kernel.org>

Cc: loongarch guy, please check loongarch's code. :)

>                         regs->a0 =3D -ENOSYS;
>
>                 syscall_exit_to_user_mode(regs);
> --
> 2.41.0
>


--=20
Best Regards
 Guo Ren
