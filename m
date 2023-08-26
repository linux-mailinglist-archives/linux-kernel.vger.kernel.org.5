Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441F97897B3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjHZPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHZPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:21:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FFA172D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:20:59 -0700 (PDT)
X-QQ-mid: bizesmtp86t1693063226ta4guxg2
Received: from linux-lab-host.localdomain ( [116.30.128.222])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 26 Aug 2023 23:20:25 +0800 (CST)
X-QQ-SSF: 00200000000000E0Y000000A0000000
X-QQ-FEAT: oGOjGSUjcuC5m3wZxsbknP3cgP4dvdVHpGKzXVES4LPegOSXcM753UhCzlDVp
        mLG/LNKRU5YXB0XGQon33cMg56DWeXktWnwyhMAU1TTHQFRYRV7SStalgnEhsJJN1a7vd/j
        tuPDeq/BpugjRK8S69RyTmzPc5xgpYFJ9Lzu8hEQY64uNh0CVTkoYefU7HnP8yHc5iGfARy
        6EsWuSIoVS4nCDFyycEiU6zfwYmLQ2MZ1LZbQXbefE8BJ1kYK629EKQy8pUn7CC6Mi70CRi
        rpNfACseCU2KFuzp/Az8ZYfpEvJ3CTgPG7Ib1uDxB9fyn1u/AQaKNewSAC1HggesTjPtKpz
        NIVAWbth+ufEQtTMOlVwchWZAPUyzOrzRIq8Tcb5wROtiHeXkdOanM4BEYjRFY+ja8ekDam
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10831681492975296225
From:   Zhangjin Wu <falcon@tinylab.org>
To:     ammarfaizi2@gnuweeb.org
Cc:     falcon@tinylab.org, gwml@vger.gnuweeb.org, inori@vnlx.org,
        linux-kernel@vger.kernel.org, linux@weissschuh.net,
        moe@gnuweeb.org, w@1wt.eu
Subject: Re: [PATCH v1 0/1] Fix a stack misalign bug on _start
Date:   Sat, 26 Aug 2023 23:20:24 +0800
Message-Id: <20230826152024.7773-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230826141632.1488740-1-ammarfaizi2@gnuweeb.org>
References: <20230826141632.1488740-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ammar

> Hi Willy,
> 
> Just a single quick fix.
> 
> The ABI mandates that the %esp register must be a multiple of 16 when
> executing a call instruction.
>
> Commit 2ab446336b17 simplified the _start function, but it didn't take
> care of the %esp alignment, causing SIGSEGV on SSE and AVX programs that
> use aligned move instruction (e.g., movdqa, movaps, and vmovdqa).
>

Yeah, I have learned carefully about the old 'sub $4, %esp' instruction
for the old 3 'push' instructions, but at last forgot to add a new
instruction for the new single 'push' instruction to reserve the
16-byte alignment, very sorry for this bad regression. 

>   $eax   : 0x56559000  →  0x00003f90
>   $ebx   : 0x56559000  →  0x00003f90
>   $ecx   : 0x1
>   $edx   : 0xf7fcaaa0  →   endbr32 
>   $esp   : 0xffffcdbc  →  0x00000001
>   $ebp   : 0x0
>   $esi   : 0xffffce7c  →  0xffffd096
>   $edi   : 0x56556060  →  <_start+0> xor %ebp, %ebp
>   $eip   : 0x56556489  →  <sse_pq_add+25> movaps %xmm0, 0x30(%esp)
> 
>     <sse_pq_add+11>  pop    %eax
>     <sse_pq_add+12>  add    $0x2b85, %eax
>     <sse_pq_add+18>  movups -0x1fd0(%eax), %xmm0
>   → <sse_pq_add+25>  movaps %xmm0, 0x30(%esp)     <== trapping instruction
>     <sse_pq_add+30>  movups -0x1fe0(%eax), %xmm1
>     <sse_pq_add+37>  movaps %xmm1, 0x20(%esp)
>     <sse_pq_add+42>  movups -0x1ff0(%eax), %xmm2
>     <sse_pq_add+49>  movaps %xmm2, 0x10(%esp)
>     <sse_pq_add+54>  movups -0x2000(%eax), %xmm3
> 
>   [#0] Id 1, Name: "test", stopped 0x56556489 in sse_pq_add (), reason: SIGSEGV
> 
>   (gdb)  bt
>   #0  0x56556489 in sse_pq_add ()
>   #1  0x5655608e in main ()
>

Since we have a new 'startup' test group, do you have a short function
to trigger this error?

Perhaps it is time for us to add a new 'stack alignment' test case for
all of the architectures.

Thanks,
Zhangjin

> Ensure the %esp is a multiple of 16 when executing the call instruction.
> 
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
> Ammar Faizi (1):
>   tools/nolibc: i386: Fix a stack misalign bug on _start
> 
>  tools/include/nolibc/arch-i386.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 6269320850097903b30be8f07a5c61d9f7592393
> -- 
> Ammar Faizi
