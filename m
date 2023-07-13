Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF17514E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjGMAAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGMAAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8BE1BF6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52D24619AF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9394C433CA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689206433;
        bh=m45Eh51GK33EfykT/kNO3/YeUg+Yoa9HKS4dDxqE0rk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CCaEzlcjriTjavqYQVOTOB6EsstWPysLatVaXgEL/u5HGSogUw2l7BywOrVgxasUI
         Jz92tvE079LpxJP+x2YRaFchKVUX+vyfUW2rWfKvYKRk7yoW/LZvrRIbunivAiO4Vg
         WtRbuB6dUOY5pSnmLd+orHKzSHWViRoMAn0SppLvy6WXmmsKI5eylBB/uD9hUUuHxe
         ZCWbRIP1f99l2Qz+FtFWwPZUy/uqRoNqavUvk749Hk9KjawIkCnIUtdktfAuce72cl
         Dq4XWbFuKL2QTOgdb6inPxdQehwjR+ZaIXDXmypwkwQBE6sr2GUhk0v7yTIXtHIHHb
         GIpAqJTZIRfZg==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3094910b150so233975f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:00:33 -0700 (PDT)
X-Gm-Message-State: ABy/qLYRYBcqFC9VWhmVRDh58v4d58EYt4JAeLpS50X2JfUfhyn7yXPF
        NC8C+zc8s+Eo5G0DuuBw5CQf09wiO+AIuILH2Tw=
X-Google-Smtp-Source: APBJJlEwQerlQY1yjKz9UoeRLB1mSvniYAH+OyMJVU01a2VyNNFlAgaIbAe+pLUu7MhF6S5iwoGh+G44SA+ZwPAxHqU=
X-Received: by 2002:adf:f44d:0:b0:30a:ec3b:58d8 with SMTP id
 f13-20020adff44d000000b0030aec3b58d8mr21784626wrp.3.1689206431973; Wed, 12
 Jul 2023 17:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230711062202.3542367-1-CoelacanthusHex@gmail.com>
In-Reply-To: <20230711062202.3542367-1-CoelacanthusHex@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 12 Jul 2023 20:00:20 -0400
X-Gmail-Original-Message-ID: <CAJF2gTRgXbEfQWiWtZtVNBDhpY2miG_ByHrVZF2fbfu60hCHcQ@mail.gmail.com>
Message-ID: <CAJF2gTRgXbEfQWiWtZtVNBDhpY2miG_ByHrVZF2fbfu60hCHcQ@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 2:22=E2=80=AFAM Celeste Liu <coelacanthushex@gmail.=
com> wrote:
>
> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
> get ENOSYS. We got same result with 9c2598d43510 ("riscv: entry: Save a0
> prior syscall_enter_from_user_mode()").
>
> Compared with x86 and loongarch's implementation of this part of the
> function, we think that regs->a0 =3D -ENOSYS should be advanced before
> syscall_handler to fix this problem. We have written the following patch,
> which can fix this problem after testing. But we don't know enough about
> this part of the code to explain the root cause. Hope someone can find
> a reasonable explanation. And we'd like to reword this commit message
> according to the explanation in v2
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
>  arch/riscv/kernel/traps.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d2..ccadb5ffd063c 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -301,6 +301,7 @@ asmlinkage __visible __trap_section void do_trap_ecal=
l_u(struct pt_regs *regs)
>
>                 regs->epc +=3D 4;
>                 regs->orig_a0 =3D regs->a0;
> +               regs->a0 =3D -ENOSYS;
Oh, no. You destroyed the a0 for syscall_handler, right? It's not
reasonable. Let's see which syscall_handler needs a0=3D-ENOSYS.

Could you give out more detail on your test case?

>
>                 riscv_v_vstate_discard(regs);
>
> @@ -308,8 +309,6 @@ asmlinkage __visible __trap_section void do_trap_ecal=
l_u(struct pt_regs *regs)
>
>                 if (syscall < NR_syscalls)
>                         syscall_handler(regs, syscall);
> -               else
> -                       regs->a0 =3D -ENOSYS;
>
>                 syscall_exit_to_user_mode(regs);
>         } else {
> --
> 2.41.0
>


--=20
Best Regards
 Guo Ren
