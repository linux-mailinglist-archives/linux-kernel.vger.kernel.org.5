Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384FC77F7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351473AbjHQN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351453AbjHQN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BE0211E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 567FF6390B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4C9C433C9;
        Thu, 17 Aug 2023 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692278836;
        bh=N7FOBKn6lVaujIc2fp+E6e+ga7diecnqFscfWVPh/C8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=tRn4KRnriHXnC/fn1AMuvXbbTYhmGvx/qn58YB0AL7kg9FZnQIl0zZ6HBu2aSJKj2
         ytNC4XhS+8ptKqzIzPae5q9fHmYKsWsozd5BTG3AtllOSvlXRFQUzVCukP1GSuKz+I
         aP899IJXsajbULeBYxvhQTgKWQlfP4fxk6yQRZMNGXAVsDoeE92DzjXp09tuVOLumn
         xdQ/UgfW+UU3oIxAHQjaEBrLkqwawRqQ5e9zJHFdJ0tCxpIfieI0zzrCNxgVrZ+1Wb
         F2SSVwRooyzzHKJgo/kXohULYbKgJ4hu3CsB4z0bwWHu2JxkQ4stPD9FnFttCqxHHd
         Zwrq/qfowY0jw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        bjorn@rivosinc.com, conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: add userland instruction dump to RISC-V splats
In-Reply-To: <20230817114130.24662-1-cuiyunhui@bytedance.com>
References: <20230817114130.24662-1-cuiyunhui@bytedance.com>
Date:   Thu, 17 Aug 2023 15:27:14 +0200
Message-ID: <87msyphk99.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yunhui Cui <cuiyunhui@bytedance.com> writes:

> Added userland instruction dump in dump_kernel_instr().
>
> An example:
> [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> [    0.823817] Run /init as init process
> [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005be18=
 in bb[10000+5fb000]
> [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-gbd6=
44290aa72-dirty #187
> [    0.841373] Hardware name:  , BIOS
> [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 0000003f=
ffcafda0
> [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 00000000=
00000000
> [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 00000000=
00000000
> [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 0000003f=
ffcafe18
> [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000=
00000000
> [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000000=
00000000
> [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 00000000=
00000000
> [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 00000000=
00000000
> [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 00000000=
00000000
> [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 00000000=
00000000
> [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 cause: =
0000000000000002
> [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000 (8=
053) f002
> [    0.851016] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000004
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/traps.c | 10 +++++++---
>  include/linux/uaccess.h   |  5 +++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d..a6a850e42d59 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -33,7 +33,7 @@ int show_unhandled_signals =3D 1;
>=20=20
>  static DEFINE_SPINLOCK(die_lock);
>=20=20
> -static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
> +static void dump_instr(const char *loglvl, struct pt_regs *regs)
>  {
>  	char str[sizeof("0000 ") * 12 + 2 + 1], *p =3D str;
>  	const u16 *insns =3D (u16 *)instruction_pointer(regs);
> @@ -42,7 +42,10 @@ static void dump_kernel_instr(const char *loglvl, stru=
ct pt_regs *regs)
>  	int i;
>=20=20
>  	for (i =3D -10; i < 2; i++) {
> -		bad =3D get_kernel_nofault(val, &insns[i]);
> +		if (user_mode(regs))
> +			bad =3D get_user_nofault(val, &insns[i]);
> +		else
> +			bad =3D get_kernel_nofault(val, &insns[i]);
>  		if (!bad) {
>  			p +=3D sprintf(p, i =3D=3D 0 ? "(%04hx) " : "%04hx ", val);
>  		} else {
> @@ -71,7 +74,7 @@ void die(struct pt_regs *regs, const char *str)
>  	print_modules();
>  	if (regs) {
>  		show_regs(regs);
> -		dump_kernel_instr(KERN_EMERG, regs);
> +		dump_instr(KERN_EMERG, regs);
>  	}
>=20=20
>  	cause =3D regs ? regs->cause : -1;
> @@ -104,6 +107,7 @@ void do_trap(struct pt_regs *regs, int signo, int cod=
e, unsigned long addr)
>  		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
>  		pr_cont("\n");
>  		__show_regs(regs);
> +		dump_instr(KERN_EMERG, regs);
>  	}
>=20=20
>  	force_sig_fault(signo, code, (void __user *)addr);
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 3064314f4832..ba8cb37a7241 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -385,6 +385,11 @@ long strncpy_from_user_nofault(char *dst, const void=
 __user *unsafe_addr,
>  		long count);
>  long strnlen_user_nofault(const void __user *unsafe_addr, long count);
>=20=20
> +#define get_user_nofault(val, ptr) ({				\
> +	const typeof(val) *__gk_ptr =3D (ptr);			\
> +	copy_from_user_nofault(&(val), __gk_ptr, sizeof(val));\
> +})
> +

Your previous version had a check:
  |         /* The user space code from other tasks cannot be accessed. */
  |         if (regs !=3D task_pt_regs(current))
  |                 return -EPERM;

Why was that left out? Is it not needed?

Your get_user_nofault is only used in this file, so maybe it's better to
do what x86 does, and introduce a static "copy_code()" that deals with
the user/kernel checks/copy?


Bj=C3=B6rn
