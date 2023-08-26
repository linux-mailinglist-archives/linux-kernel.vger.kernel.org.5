Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF9789740
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjHZORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHZOQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:16:59 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3A9173F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693059416;
        bh=dPamwUBc+z+tBAXiBOm78IrnJCSPaF4PwyrRVe5qC4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZjW68c+GQFGwXHFpOgBYZFx6FXP02h5dTBkP4tUffItep+8DIUfmutcz01lrBDakF
         2/yfnemkSwJ/Srl5zEUswvDHnQiWqMvmfk+z80zYekOajDDE5ePAyQs85OkY5UbUn9
         4uq+osPhV96uCFZPY1LJLFmvSnb9iMnz3UNO7tBRk2UUwHl2B3nseNN928mXTEPpyP
         9cGLYEFzXKojzj8+Suwo3pX4RlUGfpjIcy3em0ERDOzKrdGEQGdInV/X/DPNbtAMkp
         5LjSd4gWpsemQy350lSoo7zKFb33FGLMgLiLOpGBu5PRVV0RbUuBJsJ3ojmEd2cnw6
         Q8MXrgU0E3E6w==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 6E0D824B1BD;
        Sat, 26 Aug 2023 21:16:52 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] tools/nolibc: i386: Fix a stack misalign bug on _start
Date:   Sat, 26 Aug 2023 21:16:32 +0700
Message-Id: <20230826141632.1488740-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826141632.1488740-1-ammarfaizi2@gnuweeb.org>
References: <20230826141632.1488740-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
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
executing a call instruction.

Commit 2ab446336b17 simplified the _start function, but it didn't take
care of the %esp alignment, causing SIGSEGV on SSE and AVX programs that
use aligned move instruction (e.g., movdqa, movaps, and vmovdqa).

Ensure the %esp is a multiple of 16 when executing the call instruction.

Cc: Zhangjin Wu <falcon@tinylab.org>
Fixes: 2ab446336b17aad362c6decee29b4efd83a01979 ("tools/nolibc: i386: shrink _start with _start_c")
Reported-by: Nicholas Rosenberg <inori@vnlx.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-i386.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 64415b9fac77f996..4edf238eeac67aa2 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -167,7 +167,8 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
 		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
-		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned        */
+		"and  $-16, %esp\n"       /* align stack to 16 bytes                             */
+		"sub  $12, %esp\n"        /* last pushed argument must be 16-byte aligned        */
 		"push %eax\n"             /* push arg1 on stack to support plain stack modes too */
 		"call _start_c\n"         /* transfer to c runtime                               */
 		"hlt\n"                   /* ensure it does not return                           */
-- 
Ammar Faizi

