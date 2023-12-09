Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C5980B109
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574929AbjLIAdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574918AbjLIAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:33:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F71987
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:33:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE1C433CC;
        Sat,  9 Dec 2023 00:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702081993;
        bh=HfN4FCjlth7Vk9IubBls0IpglFtSjvL1qN+UsAj39lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anZz7v2hpfNbkyFSUJMCZ9FQGWFTnfWc/NUD1PgvM8wwk1PI/vjkEP3/iyiqn/8Cb
         3SwUGEYxfCmexYTN+sFB+Nsc5z9vzHiBuDebTKouuDHEskxBM5Yl+A8ssymxrS6ohZ
         jwT67C+f1hIJ22+AvDneiRdA3hTwVpYWQrUsydZiwWnz3+zUaWqLiS69PF6Anix2el
         VjxcOKGtGAziY/iI+w0QlDjHKAyRS0XQfpjY01+eHTsmePwnj+u6sXb/aCys1oEWOU
         dVoigS4NK8WqK14xQjSppIVjm5X+NR1PuM+lpwz5MbXJsadYTHmW3zRLayoe6qle9N
         J52WRAPLyiNCg==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Pavel.Kozlov@synopsys.com,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 2/5] ARC: entry: move ARCompact specific bits out of entry.h
Date:   Fri,  8 Dec 2023 16:33:04 -0800
Message-Id: <20231209003307.480051-3-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209003307.480051-1-vgupta@kernel.org>
References: <20231209003307.480051-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - PUSHAUX/POPAUX helpers to ARCompact entry
 - use gas provided "push"/pop pseudo instructions

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/entry-compact.h | 55 ++++++++++++++++++++++-
 arch/arc/include/asm/entry.h         | 66 ----------------------------
 2 files changed, 54 insertions(+), 67 deletions(-)

diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 9841f1186417..92c3e9f13252 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -33,6 +33,59 @@
 #include <asm/irqflags-compact.h>
 #include <asm/thread_info.h>	/* For THREAD_SIZE */
 
+/* Note on the LD/ST addr modes with addr reg wback
+ *
+ * LD.a same as LD.aw
+ *
+ * LD.a    reg1, [reg2, x]  => Pre Incr
+ *      Eff Addr for load = [reg2 + x]
+ *
+ * LD.ab   reg1, [reg2, x]  => Post Incr
+ *      Eff Addr for load = [reg2]
+ */
+
+.macro PUSHAX aux
+	lr	r9, [\aux]
+	push	r9
+.endm
+
+.macro POPAX aux
+	pop	r9
+	sr	r9, [\aux]
+.endm
+
+.macro  SAVE_R0_TO_R12
+	push	r0
+	push	r1
+	push	r2
+	push	r3
+	push	r4
+	push	r5
+	push	r6
+	push	r7
+	push	r8
+	push	r9
+	push	r10
+	push	r11
+	push	r12
+.endm
+
+.macro RESTORE_R12_TO_R0
+	pop	r12
+	pop	r11
+	pop	r10
+	pop	r9
+	pop	r8
+	pop	r7
+	pop	r6
+	pop	r5
+	pop	r4
+	pop	r3
+	pop	r2
+	pop	r1
+	pop	r0
+.endm
+
 .macro SAVE_ABI_CALLEE_REGS
 	push	r13
 	push	r14
@@ -267,7 +320,7 @@
 	SWITCH_TO_KERNEL_STK
 
 
-	PUSH	0x003\LVL\()abcd    /* Dummy ECR */
+	st.a	0x003\LVL\()abcd, [sp, -4]	/* Dummy ECR */
 	sub	sp, sp, 8	    /* skip orig_r0 (not needed)
 				       skip pt_regs->sp, already saved above */
 
diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index 8e4e40d2d54a..cf1ba376e992 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -21,72 +21,6 @@
 #include <asm/entry-arcv2.h>
 #endif
 
-/* Note on the LD/ST addr modes with addr reg wback
- *
- * LD.a same as LD.aw
- *
- * LD.a    reg1, [reg2, x]  => Pre Incr
- *      Eff Addr for load = [reg2 + x]
- *
- * LD.ab   reg1, [reg2, x]  => Post Incr
- *      Eff Addr for load = [reg2]
- */
-
-.macro PUSH reg
-	st.a	\reg, [sp, -4]
-.endm
-
-.macro PUSHAX aux
-	lr	r9, [\aux]
-	PUSH	r9
-.endm
-
-.macro POP reg
-	ld.ab	\reg, [sp, 4]
-.endm
-
-.macro POPAX aux
-	POP	r9
-	sr	r9, [\aux]
-.endm
-
-/*--------------------------------------------------------------
- * Helpers to save/restore Scratch Regs:
- * used by Interrupt/Exception Prologue/Epilogue
- *-------------------------------------------------------------*/
-.macro  SAVE_R0_TO_R12
-	PUSH	r0
-	PUSH	r1
-	PUSH	r2
-	PUSH	r3
-	PUSH	r4
-	PUSH	r5
-	PUSH	r6
-	PUSH	r7
-	PUSH	r8
-	PUSH	r9
-	PUSH	r10
-	PUSH	r11
-	PUSH	r12
-.endm
-
-.macro RESTORE_R12_TO_R0
-	POP	r12
-	POP	r11
-	POP	r10
-	POP	r9
-	POP	r8
-	POP	r7
-	POP	r6
-	POP	r5
-	POP	r4
-	POP	r3
-	POP	r2
-	POP	r1
-	POP	r0
-
-.endm
-
 /*
  * save user mode callee regs as struct callee_regs
  *  - needed by fork/do_signal/unaligned-access-emulation.
-- 
2.34.1

