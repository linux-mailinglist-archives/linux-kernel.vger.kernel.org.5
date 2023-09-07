Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959FB797C31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbjIGSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbjIGSpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:45:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04546197
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:45:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199AEC433C8;
        Thu,  7 Sep 2023 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694112336;
        bh=QXlLEPcw9T8cbpBpm+xTTvQEb5fFY7BYBMzEoncfs1w=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=FQYSpc/YwsYLsLl4MwCTQYuIUJv5RdIsiXNP7TtdCi00h3kOcAH8oGMaWFtF4BSID
         d6pwrhst3nsRHariq4NIshjUuJbHmGbvpNxewFuZA8eEJloTom+jhxy+LLRBWiooOv
         xBJXO2gM5PFlO2x8ghXkwnSEzxsXHKqV1PXngxt3643B2ILJyVyxDXR9g0K6HNBXWt
         zwzg84GXERQnqaqPtFlRTyKd4PTGD5PEPHWJ426+Oo5JNe1nsHSycPR8XCcbxcBAoH
         PoQ2GJnpg5pVvYGIOzSwcALE3lL0Vjl2SmCPf+LZSQVFBhC5kKsnD9y9QM6KYAguTR
         huvv4BEyKCNjw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        bjorn@rivosinc.com, conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] riscv: add userland instruction dump to RISC-V splats
In-Reply-To: <20230901123043.73700-1-cuiyunhui@bytedance.com>
References: <20230901123043.73700-1-cuiyunhui@bytedance.com>
Date:   Thu, 07 Sep 2023 20:45:33 +0200
Message-ID: <878r9hvn3m.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yunhui Cui <cuiyunhui@bytedance.com> writes:

> Add userland instruction dump and rename dump_kernel_instr()
> to dump_instr().
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
>  arch/riscv/kernel/traps.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f798c853bede..923b49c38985 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -33,7 +33,19 @@ int show_unhandled_signals =3D 1;
>=20=20
>  static DEFINE_SPINLOCK(die_lock);
>=20=20
> -static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
> +static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
> +{
> +	if (!user_mode(regs))
> +		return get_kernel_nofault(*val, insns);
> +
> +	/* The user space code from other tasks cannot be accessed. */
> +	if (regs !=3D task_pt_regs(current))
> +		return -EPERM;
> +
> +	return copy_from_user_nofault(val, insns, sizeof(*val));

Hmm, I think you missed the actual problem in [1]. I'm still getting:

  |   CHECK   arch/riscv/kernel/traps.c
  | arch/riscv/kernel/traps.c:46:44: warning: incorrect type in argument 2 =
(different address spaces)
  | arch/riscv/kernel/traps.c:46:44:    expected void const [noderef] __use=
r *src
  | arch/riscv/kernel/traps.c:46:44:    got unsigned short const [usertype]=
 *insns

This only moves the problem. You needs to cast the "insn" with something
like:

  | const void __user *uaddr =3D  (__force const void __user *)insn;

...and pass uaddr to copy_from_user_nofault().

  | long copy_from_user_nofault(void *dst, const void __user *src, size_t s=
ize);

Notice the "__user" tag to src.


Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/87msy6p8k3.fsf@all.your.base.are.be=
long.to.us/
