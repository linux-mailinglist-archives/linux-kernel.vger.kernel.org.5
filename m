Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C378DD9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbjH3Sw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbjH3Ia5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A61A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313B660FCB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B111C433C7;
        Wed, 30 Aug 2023 08:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693384253;
        bh=lAVk6c1+p9O2qSt5rKI5PqpuZY72+W78iTkgLcschGk=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=parAkT0Ds18TJwR+j7UWPJnms792Pv8js1LYPxxGM2z6f1T4f4VAmCCq4MMn/mXu4
         NDfxvgfuaoWiTuAlHNUprD10kV+cQXAsPh7WuE4O3thWXEtfTaCxJIlkKh1LBw+hM/
         HV3xydmxr+QTtOjJDxqz+PE+j3Vl3VR+a1l31O5SStz0hql7zFB3vk5IZN/DjazBSm
         TzWHg/owO5vV6ZENJaltw/S082HA/f2PlC3NL1gFPvteOHxkyw/h4m5cvRLQ2OMyzr
         kKkIUX9QxLk8pAPNwlYTXanYVxkdwNbPEWesxjIWjfafJVjtpXzfvvkvakMYmRdy0T
         re66oz8u8pu6Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Puranjay Mohan <puranjay12@gmail.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/3] bpf, riscv: use BPF prog pack allocator
 in BPF JIT
In-Reply-To: <9ab91c63-0712-d2d8-9b2b-6f2098287baa@iogearbox.net>
References: <20230828165958.1714079-1-puranjay12@gmail.com>
 <87edjmb1t8.fsf@all.your.base.are.belong.to.us>
 <9ab91c63-0712-d2d8-9b2b-6f2098287baa@iogearbox.net>
Date:   Wed, 30 Aug 2023 10:30:50 +0200
Message-ID: <87h6oh2apx.fsf@all.your.base.are.belong.to.us>
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

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 8/29/23 12:06 PM, Bj=C3=B6rn T=C3=B6pel wrote:
>> Puranjay Mohan <puranjay12@gmail.com> writes:
>>=20
>>> Changes in v2 -> v3:
>>> 1. Fix maximum width of code in patches from 80 to 100. [All patches]
>>> 2. Add checks for ctx->ro_insns =3D=3D NULL. [Patch 3]
>>> 3. Fix check for edge condition where amount of text to set > 2 * pages=
ize
>>>     [Patch 1 and 2]
>>> 4. Add reviewed-by in patches.
>>> 5. Adding results of selftest here:
>>>     Using the command: ./test_progs on qemu
>>>     Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>>     With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>>
>>> Changes in v1 -> v2:
>>> 1. Implement a new function patch_text_set_nosync() to be used in bpf_a=
rch_text_invalidate().
>>>     The implementation in v1 called patch_text_nosync() in a loop and i=
t was bad as it would
>>>     call flush_icache_range() for every word making it really slow. Thi=
s was found by running
>>>     the test_tag selftest which would take forever to complete.
>>>
>>> Here is some data to prove the V2 fixes the problem:
>>>
>>> Without this series:
>>> root@rv-selftester:~/src/kselftest/bpf# time ./test_tag
>>> test_tag: OK (40945 tests)
>>>
>>> real    7m47.562s
>>> user    0m24.145s
>>> sys     6m37.064s
>>>
>>> With this series applied:
>>> root@rv-selftester:~/src/selftest/bpf# time ./test_tag
>>> test_tag: OK (40945 tests)
>>>
>>> real    7m29.472s
>>> user    0m25.865s
>>> sys     6m18.401s
>>>
>>> BPF programs currently consume a page each on RISCV. For systems with m=
any BPF
>>> programs, this adds significant pressure to instruction TLB. High iTLB =
pressure
>>> usually causes slow down for the whole system.
>>>
>>> Song Liu introduced the BPF prog pack allocator[1] to mitigate the abov=
e issue.
>>> It packs multiple BPF programs into a single huge page. It is currently=
 only
>>> enabled for the x86_64 BPF JIT.
>>>
>>> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed =
now.
>>>
>>> This patch series enables the BPF prog pack allocator for the RISCV BPF=
 JIT.
>>> This series needs a patch[3] from the ARM64 series to work.
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>> Performance Analysis of prog pack allocator on RISCV64
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>>
>>> Test setup:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Host machine: Debian GNU/Linux 11 (bullseye)
>>> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
>>> u-boot-qemu Version: 2023.07+dfsg-1
>>> opensbi Version: 1.3-1
>>>
>>> To test the performance of the BPF prog pack allocator on RV, a stresser
>>> tool[4] linked below was built. This tool loads 8 BPF programs on the s=
ystem and
>>> triggers 5 of them in an infinite loop by doing system calls.
>>>
>>> The runner script starts 20 instances of the above which loads 8*20=3D1=
60 BPF
>>> programs on the system, 5*20=3D100 of which are being constantly trigge=
red.
>>> The script is passed a command which would be run in the above environm=
ent.
>>>
>>> The script was run with following perf command:
>>> ./run.sh "perf stat -a \
>>>          -e iTLB-load-misses \
>>>          -e dTLB-load-misses  \
>>>          -e dTLB-store-misses \
>>>          -e instructions \
>>>          --timeout 60000"
>>>
>>> The output of the above command is discussed below before and after ena=
bling the
>>> BPF prog pack allocator.
>>>
>>> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The =
rootfs
>>> was created using Bjorn's riscv-cross-builder[5] docker container linke=
d below.
>>>
>>> Results
>>> =3D=3D=3D=3D=3D=3D=3D
>>>
>>> Before enabling prog pack allocator:
>>> ------------------------------------
>>>
>>> Performance counter stats for 'system wide':
>>>
>>>             4939048      iTLB-load-misses
>>>             5468689      dTLB-load-misses
>>>              465234      dTLB-store-misses
>>>       1441082097998      instructions
>>>
>>>        60.045791200 seconds time elapsed
>>>
>>> After enabling prog pack allocator:
>>> -----------------------------------
>>>
>>> Performance counter stats for 'system wide':
>>>
>>>             3430035      iTLB-load-misses
>>>             5008745      dTLB-load-misses
>>>              409944      dTLB-store-misses
>>>       1441535637988      instructions
>>>
>>>        60.046296600 seconds time elapsed
>>>
>>> Improvements in metrics
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> It was expected that the iTLB-load-misses would decrease as now a singl=
e huge
>>> page is used to keep all the BPF programs compared to a single page for=
 each
>>> program earlier.
>>>
>>> --------------------------------------------
>>> The improvement in iTLB-load-misses: -30.5 %
>>> --------------------------------------------
>>>
>>> I repeated this expriment more than 100 times in different setups and t=
he
>>> improvement was always greater than 30%.
>>>
>>> This patch series is boot tested on the Starfive VisionFive 2 board[6].
>>> The performance analysis was not done on the board because it doesn't
>>> expose iTLB-load-misses, etc. The stresser program was run on the board=
 to test
>>> the loading and unloading of BPF programs
>>>
>>> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
>>> [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gma=
il.com/
>>> [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gma=
il.com/
>>> [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
>>> [5] https://github.com/bjoto/riscv-cross-builder
>>> [6] https://www.starfivetech.com/en/site/boards
>>>
>>> Puranjay Mohan (3):
>>>    riscv: extend patch_text_nosync() for multiple pages
>>>    riscv: implement a memset like function for text
>>>    bpf, riscv: use prog pack allocator in the BPF JIT
>>=20
>> Thank you! For the series:
>>=20
>> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> @Alexei @Daniel This series depends on a core BPF patch from the Arm
>>                  series [3].
>>=20
>> @Palmer LMK if you have any concerns taking the RISC-V text patching
>>          stuff via the BPF tree.
>
> Palmer, did the riscv PR already go to Linus?
>
> If not yet, perhaps you could ship this series along with your PR to Linus
> during this merge window given the big net PR (incl. bpf) was already mer=
ged
> yesterday. So from our side only fixes ship to Linus.
>
> Otherwise we could take it into bpf-next for the next dev cycle if there =
are
> no objections, let us know.

Daniel, I'll bring this up on the RISC-V patchwork sync meeting [1]
today.

[1] https://lore.kernel.org/linux-riscv/mhng-775d4068-6c1e-48a4-a1dc-b4a76f=
f26bb3@palmer-ri-x1c9a/
