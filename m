Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A75478D185
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbjH3BDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbjH3BCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:02:43 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F81B0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693357360;
        bh=K/VHveZ7OtIcrGkkd/zHQRJC+BT4E8xTNNy3oVBaQgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oxruvBn7tPDzRVVRKRx5oR15fc8TyYjrhC0MGx/E4HNA/2n97dhLtmuZpzAYcKz8x
         74wrb/g8B0xhH5lxjTbB3lOoPue4Y74QJByVRz1aU6hdrHE5MYr5+rV4atOirziV+x
         sh9AC4pvK99OHyme8BnN7sMPkJq3D/eLeZT8hQSyUvzH9EVGru48W1UCKaO2l5KhWH
         eK56DzEnAyEfQgeIIvZmGhL2VAoZi59V+/NSCkmfVldyqHWFt1bQXya9ZkBSimdQ95
         lhug/QubAZPign0vFN9JYwKpmvX/jVrZ9SzfjwLbMGnb/zYV5vrtdH8elvIDpQfJ6u
         E1V9X25HKFJhA==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 19BC624B29A;
        Wed, 30 Aug 2023 08:02:36 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/1] tools/nolibc: i386: Fix a stack misalign bug on _start
Date:   Wed, 30 Aug 2023 08:02:23 +0700
Message-Id: <20230830010223.1875339-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830010223.1875339-1-ammarfaizi2@gnuweeb.org>
References: <20230830010223.1875339-1-ammarfaizi2@gnuweeb.org>
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

Extra:
Add 'add $12, %esp' before the 'and $-16, %esp' to avoid over-estimating
for particular cases as suggested by Willy.

A test program to validate the %esp alignment on _start can be found at:

   https://lore.kernel.org/lkml/ZOoindMFj1UKqo+s@biznet-home.integral.gnuweeb.org

Cc: Zhangjin Wu <falcon@tinylab.org>
Fixes: 2ab446336b17aad362c6decee29b4efd83a01979 ("tools/nolibc: i386: shrink _start with _start_c")
Reported-by: Nicholas Rosenberg <inori@vnlx.org>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-i386.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 64415b9fac77f996..28c26a00a7625f55 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -167,7 +167,9 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
 		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
-		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned        */
+		"add  $12, %esp\n"        /* avoid over-estimating after the 'and' & 'sub' below */
+		"and  $-16, %esp\n"       /* the %esp must be 16-byte aligned on 'call'          */
+		"sub  $12, %esp\n"        /* sub 12 to keep it aligned after the push %eax       */
 		"push %eax\n"             /* push arg1 on stack to support plain stack modes too */
 		"call _start_c\n"         /* transfer to c runtime                               */
 		"hlt\n"                   /* ensure it does not return                           */
-- 
Ammar Faizi

