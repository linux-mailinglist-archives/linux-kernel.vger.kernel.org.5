Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4831378E0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjH3UqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbjH3Upy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:45:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF5C1BC7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:44:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c3ec0578bso67002b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1693428221; x=1694033021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMBkhczQH1qmGcrJTMkEc78ZsB3x427DIZD5leKmdCs=;
        b=Bysea2dZME0GSzAnJGX5XHzKnPgGsTUDAnT3oDW4erSh0T35yEz9d1ReanXQQ4b7xk
         orjVudn+EtybJrYWE2jRTV7fRWBAYXZFCfgsrfIhDc6R+h8Pn60gpv6nliU1t9vJ5+d5
         rGmMoedAHiqVCC4X4uyXf+3QAWCh6smpXLwZcdLG+XgWPxoRgqlQPzgqtz5nQ+jVU3cR
         PuD53EL93WJDjKGky8AfAicpu/VQ+cgdO2VIzYSNGYdJHho96QVftFb5xn7lyr2Fn7zZ
         LOF1Aq7ftagmios8GdbFwXsDXP6yrWmLTEjUSxXVOVUGz0H0351tCerpzBNgfKVgvvFX
         6Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428221; x=1694033021;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMBkhczQH1qmGcrJTMkEc78ZsB3x427DIZD5leKmdCs=;
        b=MlXYwvgdTZqhMTeLqu3CLmB6WcoDee9N1gJWtR5o3yA3ErdKr5aoVI3xCnyrGLGnRW
         tQUNdsIb/B3KV3qwOvG8LBbc5IDPd6+MPdxHZi9ZJ9iBY+CfKbB5xnBgrIUXkzo2i5kz
         NEPqTtb937ClE5vKq8bUc6ymi6oH4fCJsnRgRZXbjMtr0DkCxFoa3xz2M9gmnJdacbm6
         CH4JCgvBGvmRZ93o2VQKMwJLmeX/dX3Z7w1wuxD4Qz3oCH/3K2z4XAq2Xba3Xwpl1zTB
         xXfxfNv0DM8TQfQTOhOwMrJw9HZddawQDT++xFVu10cHnPxbCuFLhwFiN71IIJ695d+4
         KKoA==
X-Gm-Message-State: AOJu0YxzTljZkn5w9UzeOH2Liz6PHBDiKYHFLS40R0nn30v6KbPrEmVo
        2Y+OcrpibDTjb9bmed4D/Nnpfw==
X-Google-Smtp-Source: AGHT+IEXJX5INKmx+JVIrSQXkkSDnbAq3tdEyiKPwQyI3es3qg1UtsgXXDAUGGMz8iwGEvAWuKz1kg==
X-Received: by 2002:a05:6a20:5498:b0:14c:c9f6:d657 with SMTP id i24-20020a056a20549800b0014cc9f6d657mr3916796pzk.22.1693428221194;
        Wed, 30 Aug 2023 13:43:41 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090311ca00b001bdcc3a09c3sm11466390plh.256.2023.08.30.13.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:43:40 -0700 (PDT)
Date:   Wed, 30 Aug 2023 13:43:40 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Aug 2023 13:43:37 PDT (-0700)
Subject:     Re: [PATCH bpf-next v3 0/3] bpf, riscv: use BPF prog pack allocator in BPF JIT
In-Reply-To: <87fs40k4we.fsf@all.your.base.are.belong.to.us>
CC:     daniel@iogearbox.net, puranjay12@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, pulehui@huawei.com,
        Conor Dooley <conor.dooley@microchip.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bjorn@kernel.org
Message-ID: <mhng-fc3daeee-958b-4851-85e4-b949a2419d57@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 06:59:13 PDT (-0700), bjorn@kernel.org wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
>
>> On 8/29/23 12:06 PM, Björn Töpel wrote:
>>> Puranjay Mohan <puranjay12@gmail.com> writes:
>>> 
>>>> Changes in v2 -> v3:
>>>> 1. Fix maximum width of code in patches from 80 to 100. [All patches]
>>>> 2. Add checks for ctx->ro_insns == NULL. [Patch 3]
>>>> 3. Fix check for edge condition where amount of text to set > 2 * pagesize
>>>>     [Patch 1 and 2]
>>>> 4. Add reviewed-by in patches.
>>>> 5. Adding results of selftest here:
>>>>     Using the command: ./test_progs on qemu
>>>>     Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>>>     With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>>>
>>>> Changes in v1 -> v2:
>>>> 1. Implement a new function patch_text_set_nosync() to be used in bpf_arch_text_invalidate().
>>>>     The implementation in v1 called patch_text_nosync() in a loop and it was bad as it would
>>>>     call flush_icache_range() for every word making it really slow. This was found by running
>>>>     the test_tag selftest which would take forever to complete.
>>>>
>>>> Here is some data to prove the V2 fixes the problem:
>>>>
>>>> Without this series:
>>>> root@rv-selftester:~/src/kselftest/bpf# time ./test_tag
>>>> test_tag: OK (40945 tests)
>>>>
>>>> real    7m47.562s
>>>> user    0m24.145s
>>>> sys     6m37.064s
>>>>
>>>> With this series applied:
>>>> root@rv-selftester:~/src/selftest/bpf# time ./test_tag
>>>> test_tag: OK (40945 tests)
>>>>
>>>> real    7m29.472s
>>>> user    0m25.865s
>>>> sys     6m18.401s
>>>>
>>>> BPF programs currently consume a page each on RISCV. For systems with many BPF
>>>> programs, this adds significant pressure to instruction TLB. High iTLB pressure
>>>> usually causes slow down for the whole system.
>>>>
>>>> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
>>>> It packs multiple BPF programs into a single huge page. It is currently only
>>>> enabled for the x86_64 BPF JIT.
>>>>
>>>> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed now.
>>>>
>>>> This patch series enables the BPF prog pack allocator for the RISCV BPF JIT.
>>>> This series needs a patch[3] from the ARM64 series to work.
>>>>
>>>> ======================================================
>>>> Performance Analysis of prog pack allocator on RISCV64
>>>> ======================================================
>>>>
>>>> Test setup:
>>>> ===========
>>>>
>>>> Host machine: Debian GNU/Linux 11 (bullseye)
>>>> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
>>>> u-boot-qemu Version: 2023.07+dfsg-1
>>>> opensbi Version: 1.3-1
>>>>
>>>> To test the performance of the BPF prog pack allocator on RV, a stresser
>>>> tool[4] linked below was built. This tool loads 8 BPF programs on the system and
>>>> triggers 5 of them in an infinite loop by doing system calls.
>>>>
>>>> The runner script starts 20 instances of the above which loads 8*20=160 BPF
>>>> programs on the system, 5*20=100 of which are being constantly triggered.
>>>> The script is passed a command which would be run in the above environment.
>>>>
>>>> The script was run with following perf command:
>>>> ./run.sh "perf stat -a \
>>>>          -e iTLB-load-misses \
>>>>          -e dTLB-load-misses  \
>>>>          -e dTLB-store-misses \
>>>>          -e instructions \
>>>>          --timeout 60000"
>>>>
>>>> The output of the above command is discussed below before and after enabling the
>>>> BPF prog pack allocator.
>>>>
>>>> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The rootfs
>>>> was created using Bjorn's riscv-cross-builder[5] docker container linked below.
>>>>
>>>> Results
>>>> =======
>>>>
>>>> Before enabling prog pack allocator:
>>>> ------------------------------------
>>>>
>>>> Performance counter stats for 'system wide':
>>>>
>>>>             4939048      iTLB-load-misses
>>>>             5468689      dTLB-load-misses
>>>>              465234      dTLB-store-misses
>>>>       1441082097998      instructions
>>>>
>>>>        60.045791200 seconds time elapsed
>>>>
>>>> After enabling prog pack allocator:
>>>> -----------------------------------
>>>>
>>>> Performance counter stats for 'system wide':
>>>>
>>>>             3430035      iTLB-load-misses
>>>>             5008745      dTLB-load-misses
>>>>              409944      dTLB-store-misses
>>>>       1441535637988      instructions
>>>>
>>>>        60.046296600 seconds time elapsed
>>>>
>>>> Improvements in metrics
>>>> =======================
>>>>
>>>> It was expected that the iTLB-load-misses would decrease as now a single huge
>>>> page is used to keep all the BPF programs compared to a single page for each
>>>> program earlier.
>>>>
>>>> --------------------------------------------
>>>> The improvement in iTLB-load-misses: -30.5 %
>>>> --------------------------------------------
>>>>
>>>> I repeated this expriment more than 100 times in different setups and the
>>>> improvement was always greater than 30%.
>>>>
>>>> This patch series is boot tested on the Starfive VisionFive 2 board[6].
>>>> The performance analysis was not done on the board because it doesn't
>>>> expose iTLB-load-misses, etc. The stresser program was run on the board to test
>>>> the loading and unloading of BPF programs
>>>>
>>>> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
>>>> [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gmail.com/
>>>> [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gmail.com/
>>>> [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
>>>> [5] https://github.com/bjoto/riscv-cross-builder
>>>> [6] https://www.starfivetech.com/en/site/boards
>>>>
>>>> Puranjay Mohan (3):
>>>>    riscv: extend patch_text_nosync() for multiple pages
>>>>    riscv: implement a memset like function for text
>>>>    bpf, riscv: use prog pack allocator in the BPF JIT
>>> 
>>> Thank you! For the series:
>>> 
>>> Acked-by: Björn Töpel <bjorn@kernel.org>
>>> Tested-by: Björn Töpel <bjorn@rivosinc.com>
>>> 
>>> @Alexei @Daniel This series depends on a core BPF patch from the Arm
>>>                  series [3].
>
> [snip]
>> If not yet, perhaps you could ship this series along with your PR to Linus
>> during this merge window given the big net PR (incl. bpf) was already merged
>> yesterday. So from our side only fixes ship to Linus.
>
> Are you OK with this patch going thru the riscv tree as well?

I'm generally fine taking almost anything, as long as whomever usually 
takes them acks it.
