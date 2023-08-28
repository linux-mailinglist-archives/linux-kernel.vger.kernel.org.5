Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAFF78A63F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjH1HDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjH1HDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:03:01 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43AF9E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693206178;
        bh=v5HgZPSe5Z64SEq5cRxK1KbyvNnxfHEB4Vn6IobhnPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hy4j7EOyEj8R3SxeW5Xz4+M6kzD8BAQ5o7g0PbQKnQtcIlAGGrQuQzDGz2VS1xyNT
         5dUbip9YMsyjZXvve71U91fMuDGbdettz/WKy4BVucOKIqDOjAl0GOM408MWyRsF/7
         uWbpiJKHNiqlohLopwfWA86k0DyGzW/wQXEjSjGXkmM4mQMxKD8/kv+Rfp/YAVTNVW
         Sk2Y6kiu0CghcG11fKuI9q7FdpJ+tga7pnxNFS2ak7IaW0cOK+s3UWOVFs2IL6afDL
         1C7eeAb+TgIavHJz4Y5xhvQ+2aWyvMf9MsknkW78752iln9bup+50mM7uYYG1KvePs
         dpfeROlyJqO8w==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id C3BA424B200;
        Mon, 28 Aug 2023 14:02:54 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] tools/nolibc: i386: Fix a stack misalign bug on _start
Date:   Mon, 28 Aug 2023 14:02:40 +0700
Message-Id: <20230828070240.1691921-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828070240.1691921-1-ammarfaizi2@gnuweeb.org>
References: <20230828070240.1691921-1-ammarfaizi2@gnuweeb.org>
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

The ABI mandates that the %esp register must be a multiple of 16 when
executing a 'call' instruction.

Commit 2ab446336b17 ("tools/nolibc: i386: shrink _start with _start_c")
simplified the _start function, but it didn't take care of the %esp
alignment, causing SIGSEGV on SSE and AVX programs that use aligned move
instruction (e.g., movdqa, movaps, and vmovdqa).

The 'and $-16, %esp' aligns the %esp at a multiple of 16. Then 'push
%eax' will subtract the %esp by 4; thus, it breaks the 16-byte
alignment. Make sure the %esp is correctly aligned after the push by
subtracting 12 before the push.

Cc: Zhangjin Wu <falcon@tinylab.org>
Fixes: 2ab446336b17aad362c6decee29b4efd83a01979 ("tools/nolibc: i386: shrink _start with _start_c")
Reported-by: Nicholas Rosenberg <inori@vnlx.org>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-i386.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 64415b9fac77f996..8079974424fa18b0 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -167,7 +167,8 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
 		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
-		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned        */
+		"and  $-16, %esp\n"       /* align stack to 16 bytes                             */
+		"sub  $(16 - 4), %esp\n"  /* push %eax breaks 16-byte alignment, so sub 12 bytes */
 		"push %eax\n"             /* push arg1 on stack to support plain stack modes too */
 		"call _start_c\n"         /* transfer to c runtime                               */
 		"hlt\n"                   /* ensure it does not return                           */
-- 
Ammar Faizi

