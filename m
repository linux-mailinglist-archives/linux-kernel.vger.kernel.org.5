Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA778FA6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjIAJF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjIAJFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7910D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FBFF60A29
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED147C433C7;
        Fri,  1 Sep 2023 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693559151;
        bh=bqIQfHHns56XlqLjVZklK3xIcE+Q1rtzJas0HrLow6w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Z9SbDqJW8wKthxnD3bt/OkJ4t/JXVjKo6TwW0NTQnqvHfiVkxk61U0X55NvjAAixa
         Sh4kff34C0uwBzH1gwTENhVUNN5N6ybV7YFm6gIctrKWCVecUsJ97ihOy71pxnn60l
         rvHMFcPadyX10OANQlRDRdHE5cmV5z2d+Z4Rs8Oot5TQe0OxRn7jg3MdZNkkEPUV/T
         Ri9qnDPU7+GVCZcMo6seO0lo6hO4g/QrzEvPOGtp4RBk5HZTQ2EDmSLtQ3iFR48+S6
         7AvgoID8Szf61kM1Iy/F5fcw/b+L5Zwi4ntACILsV/QhH3tDVGThW0FzTEky0p4TJM
         QLgbvHkdfmpow==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     yunhui cui <cuiyunhui@bytedance.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, dave.hansen@linux.intel.com,
        elver@google.com, glider@google.com, cyphar@cyphar.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v4] riscv: add userland instruction dump
 to RISC-V splats
In-Reply-To: <CAEEQ3wmL90oOZcmpv8G34u7kg44zGscpHJiiRHLi=_LAm=C1jg@mail.gmail.com>
References: <20230818121504.60492-1-cuiyunhui@bytedance.com>
 <878ra8o4qa.fsf@all.your.base.are.belong.to.us>
 <CAEEQ3wmL90oOZcmpv8G34u7kg44zGscpHJiiRHLi=_LAm=C1jg@mail.gmail.com>
Date:   Fri, 01 Sep 2023 11:05:48 +0200
Message-ID: <87msy6p8k3.fsf@all.your.base.are.belong.to.us>
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
> On Fri, Aug 18, 2023 at 9:33=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
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
>>
>> Nice!
>>
>> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> When can this patch be applied to the linux-next branch?

It looks like you're getting a sparse warning on the patch [1], and
that's probably why it hasn't been considered. You need something like:

--
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 69b5d18b5ae9..c5364131b8bd 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -34,7 +34,7 @@ int show_unhandled_signals =3D 1;
 static DEFINE_SPINLOCK(die_lock);
=20
 #define get_user_nofault(val, ptr) ({                          \
-       const typeof(val) *__gk_ptr =3D (ptr);                    \
+       const typeof(val) __user *__gk_ptr =3D (__force const typeof(val) _=
_user *)(ptr); \
        copy_from_user_nofault(&(val), __gk_ptr, sizeof(val));\
 })
--

IDK, maybe it worth removing the define all together, and just open code
it.

When you're submitting patches, it's a good thing to track patchwork for
warnings/errors.


Bj=C3=B6rn

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20230818121504.6=
0492-1-cuiyunhui@bytedance.com/
