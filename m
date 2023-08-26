Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4A78973F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjHZORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjHZOQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:16:55 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C1173F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693059411;
        bh=jG4wfsNEpwe3we+Lpb64W15qznopGnPznQ18oTfIcV8=;
        h=From:To:Cc:Subject:Date;
        b=CYflKv9p31Oesd2yyBQjJw5VisVsqEiG2hUs8osfJopCG+4LUnkw7br314qqssdha
         pHskgP2Z5/Lgw3hgLFs4qCyDr24lB3ts8Tn32IrxPAU7yCEmCeYi9UFDOIk0jvIWI0
         eUjGQe/CYn2hAgQqeY4ZYPpcTm88W2TEEf1vC14FuP8Z6IzxzE2yAuHcO4pwlk2o78
         RtlAqKnjM4deMDyAidU5qVll5UQAJMUshb9j09m+KuQpmy+jTA57Qbyf+Od9T88mTZ
         l3NGswBa3ZbDx3zznULq/itDG+Sl9NQXDGY8RhX4Kqkx/z5Rn6IcUofXZk2ATL36Z3
         GErk3quI8NVUQ==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 2196B24B1BC;
        Sat, 26 Aug 2023 21:16:47 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/1] Fix a stack misalign bug on _start
Date:   Sat, 26 Aug 2023 21:16:31 +0700
Message-Id: <20230826141632.1488740-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Just a single quick fix.

The ABI mandates that the %esp register must be a multiple of 16 when
executing a call instruction.

Commit 2ab446336b17 simplified the _start function, but it didn't take
care of the %esp alignment, causing SIGSEGV on SSE and AVX programs that
use aligned move instruction (e.g., movdqa, movaps, and vmovdqa).

  $eax   : 0x56559000  →  0x00003f90
  $ebx   : 0x56559000  →  0x00003f90
  $ecx   : 0x1
  $edx   : 0xf7fcaaa0  →   endbr32 
  $esp   : 0xffffcdbc  →  0x00000001
  $ebp   : 0x0
  $esi   : 0xffffce7c  →  0xffffd096
  $edi   : 0x56556060  →  <_start+0> xor %ebp, %ebp
  $eip   : 0x56556489  →  <sse_pq_add+25> movaps %xmm0, 0x30(%esp)

    <sse_pq_add+11>  pop    %eax
    <sse_pq_add+12>  add    $0x2b85, %eax
    <sse_pq_add+18>  movups -0x1fd0(%eax), %xmm0
  → <sse_pq_add+25>  movaps %xmm0, 0x30(%esp)     <== trapping instruction
    <sse_pq_add+30>  movups -0x1fe0(%eax), %xmm1
    <sse_pq_add+37>  movaps %xmm1, 0x20(%esp)
    <sse_pq_add+42>  movups -0x1ff0(%eax), %xmm2
    <sse_pq_add+49>  movaps %xmm2, 0x10(%esp)
    <sse_pq_add+54>  movups -0x2000(%eax), %xmm3

  [#0] Id 1, Name: "test", stopped 0x56556489 in sse_pq_add (), reason: SIGSEGV

  (gdb)  bt
  #0  0x56556489 in sse_pq_add ()
  #1  0x5655608e in main ()

Ensure the %esp is a multiple of 16 when executing the call instruction.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
Ammar Faizi (1):
  tools/nolibc: i386: Fix a stack misalign bug on _start

 tools/include/nolibc/arch-i386.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 6269320850097903b30be8f07a5c61d9f7592393
-- 
Ammar Faizi

