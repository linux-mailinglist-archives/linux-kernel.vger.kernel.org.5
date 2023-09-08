Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E999798BCA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbjIHSBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbjIHSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:01:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B9268A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:01:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7042BC433D9;
        Fri,  8 Sep 2023 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196058;
        bh=j5UUaXb8RGSEciFJtoJmgCe8/tVFxQk6ZmOw1l6vuDQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NUd8H4XGUmIbpfXJ4nSJDCyUWIba4C/yKXXNnUoDmgKVA6N0O48Xl7R9VKJdgZWvf
         SD9ZJwAphWGUDSWDlOxCp2LuZH/QhbU9ozpEkEIHr3lh7cal+Y7CStKB3eN0tmY7OL
         qf/tEQ7G7FGQJ05iHGCMkm0Z+okPShWcdANAErepGkTk3L5gUzPI2Ro6UIyCPf9Yru
         vwQUZ8mzXBL1MmFkBcqHI8gTdelPF2/czKUhcF7ZJdd+2YPVdu5FN1wo2ZdX3NmDzs
         7bf7SrTmrhfhG3Nl+WodJCFS0fdqWKXPDy8lO16W25M5eMM6cVXMk/aVjkEXqG05HF
         bMLFJkkXudP5A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     yunhui cui <cuiyunhui@bytedance.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, dave.hansen@linux.intel.com,
        elver@google.com, glider@google.com, cyphar@cyphar.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v5] riscv: add userland instruction dump
 to RISC-V splats
In-Reply-To: <CAEEQ3wnDAJOMo2SZAB23aZgOhBKPmZegC9E048YJaFhiXEkA-A@mail.gmail.com>
References: <20230901123043.73700-1-cuiyunhui@bytedance.com>
 <878r9hvn3m.fsf@all.your.base.are.belong.to.us>
 <CAEEQ3wnDAJOMo2SZAB23aZgOhBKPmZegC9E048YJaFhiXEkA-A@mail.gmail.com>
Date:   Fri, 08 Sep 2023 20:00:55 +0200
Message-ID: <87r0n8pmso.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yunhui cui <cuiyunhui@bytedance.com> writes:

> Hi Bj=C3=B6rn=EF=BC=8C
>
> On Fri, Sep 8, 2023 at 2:45=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>>
>> Yunhui Cui <cuiyunhui@bytedance.com> writes:
>>
>> > Add userland instruction dump and rename dump_kernel_instr()
>> > to dump_instr().
>> >
>> > An example:
>> > [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
>> > [    0.823817] Run /init as init process
>> > [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005b=
e18 in bb[10000+5fb000]
>> > [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-g=
bd644290aa72-dirty #187
>> > [    0.841373] Hardware name:  , BIOS
>> > [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 00000=
03fffcafda0
>> > [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 00000=
00000000000
>> > [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 00000=
00000000000
>> > [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 00000=
03fffcafe18
>> > [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000=
00000000000
>> > [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000=
00000000000
>> > [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 00000=
00000000000
>> > [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 00000=
00000000000
>> > [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 00000=
00000000000
>> > [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 00000=
00000000000
>> > [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
>> > [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 caus=
e: 0000000000000002
>> > [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000=
 (8053) f002
>> > [    0.851016] Kernel panic - not syncing: Attempted to kill init! exi=
tcode=3D0x00000004
>> >
>> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> > ---
>> >  arch/riscv/kernel/traps.c | 19 ++++++++++++++++---
>> >  1 file changed, 16 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> > index f798c853bede..923b49c38985 100644
>> > --- a/arch/riscv/kernel/traps.c
>> > +++ b/arch/riscv/kernel/traps.c
>> > @@ -33,7 +33,19 @@ int show_unhandled_signals =3D 1;
>> >
>> >  static DEFINE_SPINLOCK(die_lock);
>> >
>> > -static void dump_kernel_instr(const char *loglvl, struct pt_regs *reg=
s)
>> > +static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
>> > +{
>> > +     if (!user_mode(regs))
>> > +             return get_kernel_nofault(*val, insns);
>> > +
>> > +     /* The user space code from other tasks cannot be accessed. */
>> > +     if (regs !=3D task_pt_regs(current))
>> > +             return -EPERM;
>> > +
>> > +     return copy_from_user_nofault(val, insns, sizeof(*val));
>>
>> Hmm, I think you missed the actual problem in [1]. I'm still getting:
>>
>>   |   CHECK   arch/riscv/kernel/traps.c
>>   | arch/riscv/kernel/traps.c:46:44: warning: incorrect type in argument=
 2 (different address spaces)
>>   | arch/riscv/kernel/traps.c:46:44:    expected void const [noderef] __=
user *src
>>   | arch/riscv/kernel/traps.c:46:44:    got unsigned short const [userty=
pe] *insns
>>
>
> How did the warnings above come about? I don't have one locally. What
> is your risc-v gcc version?

It's from the "sparse" tool. Pass "C=3D1" to make. Unfortunately RV sparse
needs to be built manually: https://github.com/ConchuOD/sparse

 | make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- C=3D1 W=3D1 arch/ri=
scv/kernel/traps.o


Thanks!
Bj=C3=B6rn
