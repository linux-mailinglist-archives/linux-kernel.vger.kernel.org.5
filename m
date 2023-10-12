Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AFD7C76E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442290AbjJLTcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442098AbjJLTci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB24E4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F03BC433C8;
        Thu, 12 Oct 2023 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139155;
        bh=d8ayu7kl8vqNo7NKawNbDKeJKZ0xNLEf2Mmx5D5tlHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7EapoPG2ZvLutGfmEetupl7EiQpZfP69OEEGMailIC9EGAyMrT7kFssMCox0ZsS1
         sJeYDQZGWF9GcId/l5GG7os0U6Z7ltz3h4Jum/C/frTSsxC+OQBIpxFALPrlMvWKeX
         EuYPNgezzcBYDKLgvBDC0UnUw5ixb2X0YST6d4ZpF5B/75zoDPFgI9YB/NCt1bBO5x
         cLsWPFgpqcaoNKbWp9kYHgWALyBIjb/8d5GkFV21/sJ4c8YkMETK9mEBY15XCkMNm8
         75iJAv7iNSn95fAix87U9E1Uu2D17FpUlfdz86uC/o/pb4qHVQQBYIZw13ObqQvIap
         W7ZhD0X/ee/kA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3D0E7CE096F; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 01/19] tools/nolibc: i386: Fix a stack misalign bug on _start
Date:   Thu, 12 Oct 2023 12:32:15 -0700
Message-Id: <20231012193233.207857-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

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
Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-i386.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 64415b9fac77..28c26a00a762 100644
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
2.40.1

