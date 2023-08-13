Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC55677AB30
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 22:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjHMU17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 16:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHMU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 16:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1773113
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 13:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2839F6167A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 20:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C93C433C7;
        Sun, 13 Aug 2023 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691958477;
        bh=UI+HJGlY4c8tNlNy8au0tYd05GI/E0b/TVdswYXHTtY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bVZ/63W9BGAGVk8mfvcdwe7q5sdVcixQXWd1gi4tiwzma7ug21CEoXTooBIjPw2kw
         hgzPwfG5yKT+vQiJ0b4LkTN6pQMxVXng/VUJD/SvwwtXQ8joDM8m7WzZy/Zn/hUTi0
         E6ciW5tl2Eu/Qk2EEC4mHmmzBPM+XKXIw5Txha2RFmW9Rao2oK84jCjleRQRTA1oi9
         zpBjEKmbMmxMU7xpjT3sHr+jumZLc1As9EYOt3bXzZ+wBm43XA6Wtwv3J+zGm0p+rN
         Q3dTY6c9ig6OkAKsrmaOhrn6qLm07AomDbUtxul8zm24616SgXrgRg2v8CKaKJR1EL
         Lj+xCwggjTK/A==
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
In-Reply-To: <20230720154941.1504-1-puranjay12@gmail.com>
References: <20230720154941.1504-1-puranjay12@gmail.com>
Date:   Sun, 13 Aug 2023 22:27:54 +0200
Message-ID: <87ttt21yd1.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Puranjay Mohan <puranjay12@gmail.com> writes:

> BPF programs currently consume a page each on RISCV. For systems with man=
y BPF
> programs, this adds significant pressure to instruction TLB. High iTLB pr=
essure
> usually causes slow down for the whole system.
>
> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above =
issue.
> It packs multiple BPF programs into a single huge page. It is currently o=
nly
> enabled for the x86_64 BPF JIT.
>
> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed no=
w.
>
> This patch series enables the BPF prog pack allocator for the RISCV BPF J=
IT.
> This series needs a patch[3] from the ARM64 series to work.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Performance Analysis of prog pack allocator on RISCV64
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> Test setup:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Host machine: Debian GNU/Linux 11 (bullseye)
> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
> u-boot-qemu Version: 2023.07+dfsg-1
> opensbi Version: 1.3-1
>
> To test the performance of the BPF prog pack allocator on RV, a stresser
> tool[4] linked below was built. This tool loads 8 BPF programs on the sys=
tem and
> triggers 5 of them in an infinite loop by doing system calls.
>
> The runner script starts 20 instances of the above which loads 8*20=3D160=
 BPF
> programs on the system, 5*20=3D100 of which are being constantly triggere=
d.
> The script is passed a command which would be run in the above environmen=
t.
>
> The script was run with following perf command:
> ./run.sh "perf stat -a \
>         -e iTLB-load-misses \
>         -e dTLB-load-misses  \
>         -e dTLB-store-misses \
>         -e instructions \
>         --timeout 60000"
>
> The output of the above command is discussed below before and after enabl=
ing the
> BPF prog pack allocator.
>
> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The ro=
otfs
> was created using Bjorn's riscv-cross-builder[5] docker container linked =
below.

Back in the saddle! Sorry for the horribly late reply...

Did you run the test_progs kselftest test, and passed w/o regressions? I
ran a test without/with your series (plus the patch from the arm64
series that you pointed out), and I'm getting regressions with this
series:

w/o Summary: 318/3114 PASSED, 27 SKIPPED, 60 FAILED
w/  Summary: 299/3026 PASSED, 33 SKIPPED, 79 FAILED

I'm did the test on commit 4c75bf7e4a0e ("Merge tag
'kbuild-fixes-v6.5-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild").

I'm re-running, and investigating now.


Bj=C3=B6rn


