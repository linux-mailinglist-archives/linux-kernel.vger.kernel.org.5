Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD475859C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGRTfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjGRTfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E351992
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8811160AFF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76708C433C7;
        Tue, 18 Jul 2023 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689708939;
        bh=1egJyzR6y/L4MZT/n7f53P/+YJM8/Awvoyio2kgGnUw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=K/oKj3a7ep1WSBGY2mbv2PgH66luRF/ngNMoNiW/uza/dMtXC1p+4sW2QI+cZ+DOg
         gokQCdSZEIOq1q3oXZHYpinwik5G+DjzGn0O6QEYh9NeTJWUp68yVSKac/0KaHaGuA
         5evK6x4Q7QBL/si/+bmsSGiYMEMN4W9K1lmUcQMMUh6N+hnx2ZkD+cMl+j+P7d0thS
         PHD7JTFnWfejg2kSJ9Ed1Emjf+zS1h+ipWuEO2PyCU9M7RH9zixsluwUb+Fce5YBhF
         WYKRf/454lDhmrQxEaHpk2m2vugSaf3suxiZUTlBivzt1m5pl8isTBf0iOC6s41T70
         Pjv11veAETYog==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Celeste Liu <coelacanthushex@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Celeste Liu <CoelacanthusHex@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: Re: [PATCH v2] riscv: entry: set a0 prior to
 syscall_enter_from_user_mode
In-Reply-To: <20230718162940.226118-1-CoelacanthusHex@gmail.com>
References: <20230718162940.226118-1-CoelacanthusHex@gmail.com>
Date:   Tue, 18 Jul 2023 21:35:37 +0200
Message-ID: <87pm4p2et2.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Celeste Liu <coelacanthushex@gmail.com> writes:

> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
> get ENOSYS instead. We got same result with 9c2598d43510 ("riscv: entry: =
Save a0
> prior syscall_enter_from_user_mode()").
>
> After analysing code, we think that regs->a0 =3D -ENOSYS should be advanc=
ed before
> syscall_enter_from_user_mode to fix this problem. In __seccomp_filter, wh=
en
> seccomp rejected this syscall with specified errno, they will set a0 to r=
eturn
> number as syscall ABI, and then return -1. This return number is finally =
pass
> as return number of syscall_enter_from_user_mode, and then is compared
> with NR_syscalls after converted to ulong (so it will be ULONG_MAX).
> The condition syscall < NR_syscalls will always be false, so regs->a0 =3D=
 -ENOSYS
> is always executable. It covered a0 set by seccomp, so we always get
> ENOSYS when match seccomp RET_ERRNO rule.

Isn't something like...

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..15a8b4898a6c 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_break(=
struct pt_regs *regs)
 asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *r=
egs)
 {
 	if (user_mode(regs)) {
-		ulong syscall =3D regs->a7;
+		long syscall =3D regs->a7;
=20
 		regs->epc +=3D 4;
 		regs->orig_a0 =3D regs->a0;
@@ -306,7 +306,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_=
u(struct pt_regs *regs)
=20
 		syscall =3D syscall_enter_from_user_mode(regs, syscall);
=20
-		if (syscall < NR_syscalls)
+		if (syscall > -1 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
 		else
 			regs->a0 =3D -ENOSYS;


...easier to read?


Bj=C3=B6rn
