Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8314975864D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGRUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGRUuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:50:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E081FEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B9960F75
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B9DC433C7;
        Tue, 18 Jul 2023 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689713437;
        bh=gEw8p5anenofWHBZHWKW/M+NiMyaqUqwak/8urPi6d0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KoWuP96wI+fWF75KtEEfSTM7QZlGgyUN+r99fgZJAOZCbu3s3WepGiN78qpbm23ec
         ELTNWYXCY6CDlPQg1F8OkTZdxeWP5A9VRfECDCxWwUV52mEfW873IZv1hsrV+tw5i3
         fb3jJua0QevRiYL+4UX7YS34g6PetCisPQBcr2nLSlv3K3uDSbHcco5tW/9AUFv6dt
         8v36TclnokUEie2tDstig83bO+u56kGL7ZkzdPbfb66wSuYgf9DXdytSVbxRTvzsfL
         WFuJ1k/zhiuVDGmnBI3m4fXipJNgg0jGyGprr74eW4lIX3akkuzV//duzrZWov14Vt
         7Cx6CnyRphAig==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Celeste Liu <coelacanthushex@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: Re: [PATCH v2] riscv: entry: set a0 prior to
 syscall_enter_from_user_mode
In-Reply-To: <03206759-8d6a-a410-a8f9-d4678236bdbf@gmail.com>
References: <20230718162940.226118-1-CoelacanthusHex@gmail.com>
 <87pm4p2et2.fsf@all.your.base.are.belong.to.us>
 <03206759-8d6a-a410-a8f9-d4678236bdbf@gmail.com>
Date:   Tue, 18 Jul 2023 22:50:35 +0200
Message-ID: <87r0p5kkpw.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Celeste Liu <coelacanthushex@gmail.com> writes:

> On 2023/7/19 03:35, Bj=C3=B6rn T=C3=B6pel wrote:
>> Celeste Liu <coelacanthushex@gmail.com> writes:
>>=20
>>> When we test seccomp with 6.4 kernel, we found errno has wrong value.
>>> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
>>> get ENOSYS instead. We got same result with 9c2598d43510 ("riscv: entry=
: Save a0
>>> prior syscall_enter_from_user_mode()").
>>>
>>> After analysing code, we think that regs->a0 =3D -ENOSYS should be adva=
nced before
>>> syscall_enter_from_user_mode to fix this problem. In __seccomp_filter, =
when
>>> seccomp rejected this syscall with specified errno, they will set a0 to=
 return
>>> number as syscall ABI, and then return -1. This return number is finall=
y pass
>>> as return number of syscall_enter_from_user_mode, and then is compared
>>> with NR_syscalls after converted to ulong (so it will be ULONG_MAX).
>>> The condition syscall < NR_syscalls will always be false, so regs->a0 =
=3D -ENOSYS
>>> is always executable. It covered a0 set by seccomp, so we always get
>>> ENOSYS when match seccomp RET_ERRNO rule.
>>=20
>> Isn't something like...
>>=20
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index f910dfccbf5d..15a8b4898a6c 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_bre=
ak(struct pt_regs *regs)
>>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs=
 *regs)
>>  {
>>  	if (user_mode(regs)) {
>> -		ulong syscall =3D regs->a7;
>> +		long syscall =3D regs->a7;
>>=20=20
>>  		regs->epc +=3D 4;
>>  		regs->orig_a0 =3D regs->a0;
>> @@ -306,7 +306,7 @@ asmlinkage __visible __trap_section void do_trap_eca=
ll_u(struct pt_regs *regs)
>>=20=20
>>  		syscall =3D syscall_enter_from_user_mode(regs, syscall);
>>=20=20
>> -		if (syscall < NR_syscalls)
>> +		if (syscall > -1 && syscall < NR_syscalls)
>>  			syscall_handler(regs, syscall);
>>  		else
>>  			regs->a0 =3D -ENOSYS;
>>=20
>>=20
>> ...easier to read?
>>=20
>>=20
>> Bj=C3=B6rn
>
> It seems that your change turn it back to the beginning. If syscall =3D=
=3D -1,
> it is supposed to go neither first nor else branch. It should do NOTHING.
> However it was still a great idea. It may be better to use a set of if-st=
atement
> to clarify the logic.

Ah, gotcha! (Notice that arch/x86/entry/common.c has

  | 	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr !=3D =
-1) {

and in do_syscall_x64()

  | 	/*
  | 	 * Convert negative numbers to very high and thus out of range
  | 	 * numbers for comparisons.
  | 	 */
  | 	unsigned int unr =3D nr;


> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d2..d0bd725244594 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -306,7 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecal=
l_u(struct pt_regs *regs)
>=20=20
>  		syscall =3D syscall_enter_from_user_mode(regs, syscall);
>=20=20
> -		if (syscall < NR_syscalls)
> +		if (syscall =3D=3D -1)
> +			// Do nothing
> +		else if (syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
>  		else
>  			regs->a0 =3D -ENOSYS;

Maybe something a bit more explicit?

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..5cef72874542 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -297,6 +297,10 @@ asmlinkage __visible __trap_section void do_trap_break=
(struct pt_regs *regs)
 asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *r=
egs)
 {
 	if (user_mode(regs)) {
+		/*
+		 * Convert negative numbers to very high and thus out of range
+		 * numbers for comparisons.
+		 */
 		ulong syscall =3D regs->a7;
=20
 		regs->epc +=3D 4;
@@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_=
u(struct pt_regs *regs)
=20
 		if (syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else
+		else if ((long)syscall !=3D -1L)
 			regs->a0 =3D -ENOSYS;
=20
 		syscall_exit_to_user_mode(regs);


Bj=C3=B6rn
