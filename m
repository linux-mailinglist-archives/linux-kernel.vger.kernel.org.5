Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214BE77B14D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjHNGPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjHNGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392BEF4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CADA163421
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C65C433C7;
        Mon, 14 Aug 2023 06:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691993689;
        bh=eTq5lg24E4jKVRcCvUSUIYtJjm4KTPFGD0GKMh0DwbY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pwFkuPtx46gDfSQ66A/GRRPyzJjcJt1TI5pNb82BdeWjlND/GZO+giPGpnxXDRVVA
         TGGBHnuZ+PN07ZH3/NXiuZ7sepOrEs6yvGMslevzLBNWwkoMfYyewErt664hm7hj1Q
         m11doQknDFzC1bTt5ake8lMFvycE/Bs0dw43da0clEL3pgb8UHUXETDgzHTKKEAhL4
         wKI2tou1K/8cHSYoJh9t7Np2BQIWIlGO746RNbUYtOtI3yQHk5sY+64TAhP5PgdFCX
         gdVaHRssYwAKX9ut8WcogxzN3+wAY69OynwpSXeVjVx6pyuZSOlkPSCcbFBN9lyCDE
         7043B8bPTtE5w==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: use BPF prog pack allocator in
 BPF JIT
In-Reply-To: <87ttt21yd1.fsf@all.your.base.are.belong.to.us>
References: <20230720154941.1504-1-puranjay12@gmail.com>
 <87ttt21yd1.fsf@all.your.base.are.belong.to.us>
Date:   Mon, 14 Aug 2023 08:14:46 +0200
Message-ID: <874jl2up49.fsf@all.your.base.are.belong.to.us>
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

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Puranjay Mohan <puranjay12@gmail.com> writes:
>
>> BPF programs currently consume a page each on RISCV. For systems with ma=
ny BPF
>> programs, this adds significant pressure to instruction TLB. High iTLB p=
ressure
>> usually causes slow down for the whole system.
>>
>> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above=
 issue.
>> It packs multiple BPF programs into a single huge page. It is currently =
only
>> enabled for the x86_64 BPF JIT.
>>
>> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed n=
ow.
>>
>> This patch series enables the BPF prog pack allocator for the RISCV BPF =
JIT.
>> This series needs a patch[3] from the ARM64 series to work.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> Performance Analysis of prog pack allocator on RISCV64
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>
>> Test setup:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Host machine: Debian GNU/Linux 11 (bullseye)
>> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
>> u-boot-qemu Version: 2023.07+dfsg-1
>> opensbi Version: 1.3-1
>>
>> To test the performance of the BPF prog pack allocator on RV, a stresser
>> tool[4] linked below was built. This tool loads 8 BPF programs on the sy=
stem and
>> triggers 5 of them in an infinite loop by doing system calls.
>>
>> The runner script starts 20 instances of the above which loads 8*20=3D16=
0 BPF
>> programs on the system, 5*20=3D100 of which are being constantly trigger=
ed.
>> The script is passed a command which would be run in the above environme=
nt.
>>
>> The script was run with following perf command:
>> ./run.sh "perf stat -a \
>>         -e iTLB-load-misses \
>>         -e dTLB-load-misses  \
>>         -e dTLB-store-misses \
>>         -e instructions \
>>         --timeout 60000"
>>
>> The output of the above command is discussed below before and after enab=
ling the
>> BPF prog pack allocator.
>>
>> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The r=
ootfs
>> was created using Bjorn's riscv-cross-builder[5] docker container linked=
 below.
>
> Back in the saddle! Sorry for the horribly late reply...
>
> Did you run the test_progs kselftest test, and passed w/o regressions? I
> ran a test without/with your series (plus the patch from the arm64
> series that you pointed out), and I'm getting regressions with this
> series:
>
> w/o Summary: 318/3114 PASSED, 27 SKIPPED, 60 FAILED
> w/  Summary: 299/3026 PASSED, 33 SKIPPED, 79 FAILED
>
> I'm did the test on commit 4c75bf7e4a0e ("Merge tag
> 'kbuild-fixes-v6.5-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild").
>
> I'm re-running, and investigating now.

I had a bad environment on for the rebuild; A proper rebuild worked. No
regressions. Sorry for the noise!
