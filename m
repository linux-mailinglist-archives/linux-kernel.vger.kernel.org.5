Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2061781C14
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHTCgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHTCfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20760F82
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 16:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403EE61248
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 23:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F30C433C7;
        Sat, 19 Aug 2023 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692486896;
        bh=xoj6//WgtuRUNa87T+0xdfrV1t/TqnoJvx9xOiITXH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+BGzpFcpaGX98iGU0J31/kA59dqS8Ycfy3MXyRd5l32K67APSk9lQ4wLPdsuGdja
         iFFdi6ZoX+9t71i1tRTaJWlazDvaobhfcMqYHw8MkZRWaXBlSI2/o7eXK8wjv3J43w
         yWvAwLxaMLvUkJC0nKiXyRh/9q0rAWZ7gy+vm+9GuqyYUJUw445G26SNIqsd9fSwxj
         IwBcCJgPL6QcEsG+rCF1YA85IBXExdt9QZfdro/r17GM2lg4QK0AuGxrUIo8Cn44rA
         R9CK+63hTluOjJJv8M8GDuH9TVlKZBrFeYR7HkFI5me+FWSSM7EpAiUB0MT1bpr3aJ
         G1q8Sq3KHkmOw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Pavel.Kozlov@synopsys.com, Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 16/20] ARC: entry: Add more common chores to EXCEPTION_PROLOGUE
Date:   Sat, 19 Aug 2023 16:14:54 -0700
Message-Id: <20230819231454.692518-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818125652.3981-1-kozlov@synopsys.com>
References: <20230818125652.3981-1-kozlov@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THe high level structure of most ARC exception handlers is
 1. save regfile with EXCEPTION_PROLOGUE
 2. setup r0: EFA (not part of pt_regs)
 3. setup r1: pointer to pt_regs (SP)
 4. drop down to pure kernel mode (from exception)
 5. call the Linux "C" handler

Remove the boiler plate code by moving #2, #3, #4 into #1.

The exceptions to most exceptions are syscall Trap and Machine check
which don't do some of above for various reasons, so call a newly
introduced variant EXCEPTION_PROLOGUE_KEEP_AE (same as original
EXCEPTION_PROLOGUE)

Tested-by: Pavel Kozlov <Pavel.Kozlov@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/entry-arcv2.h   | 12 +++++++++++-
 arch/arc/include/asm/entry-compact.h | 12 +++++++++++-
 arch/arc/kernel/entry-arcv2.S        | 15 ---------------
 arch/arc/kernel/entry-compact.S      | 13 -------------
 arch/arc/kernel/entry.S              | 19 ++-----------------
 5 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index a38ed505b3de..11b48ab39154 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -75,7 +75,7 @@
 .endm
 
 /*------------------------------------------------------------------------*/
-.macro EXCEPTION_PROLOGUE
+.macro EXCEPTION_PROLOGUE_KEEP_AE
 
 	; Before jumping to Exception Vector, hardware micro-ops did following:
 	;   1. SP auto-switched to kernel mode stack
@@ -104,6 +104,16 @@
 	; OUTPUT: r10 has ECR expected by EV_Trap
 .endm
 
+.macro EXCEPTION_PROLOGUE
+
+	EXCEPTION_PROLOGUE_KEEP_AE	; return ECR in r10
+
+	lr  r0, [efa]
+	mov r1, sp
+
+	FAKE_RET_FROM_EXCPN		; clobbers r9
+.endm
+
 /*------------------------------------------------------------------------
  * This macro saves the registers manually which would normally be autosaved
  * by hardware on taken interrupts. It is used by
diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 4e2ae82779ed..a0e760eb35a8 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -140,7 +140,7 @@
  *
  * After this it is safe to call the "C" handlers
  *-------------------------------------------------------------*/
-.macro EXCEPTION_PROLOGUE
+.macro EXCEPTION_PROLOGUE_KEEP_AE
 
 	/* Need at least 1 reg to code the early exception prologue */
 	PROLOG_FREEUP_REG r9, @ex_saved_reg1
@@ -179,6 +179,16 @@
 	; OUTPUT: r10 has ECR expected by EV_Trap
 .endm
 
+.macro EXCEPTION_PROLOGUE
+
+	EXCEPTION_PROLOGUE_KEEP_AE	; return ECR in r10
+
+	lr  r0, [efa]
+	mov r1, sp
+
+	FAKE_RET_FROM_EXCPN		; clobbers r9
+.endm
+
 /*--------------------------------------------------------------
  * Restore all registers used by system call or Exceptions
  * SP should always be pointing to the next free stack element
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index a7e6a2174187..2e49c81c8086 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -125,11 +125,6 @@ ENTRY(mem_service)
 
 	EXCEPTION_PROLOGUE
 
-	lr  r0, [efa]
-	mov r1, sp
-
-	FAKE_RET_FROM_EXCPN
-
 	bl  do_memory_error
 	b   ret_from_exception
 END(mem_service)
@@ -138,11 +133,6 @@ ENTRY(EV_Misaligned)
 
 	EXCEPTION_PROLOGUE
 
-	lr  r0, [efa]	; Faulting Data address
-	mov r1, sp
-
-	FAKE_RET_FROM_EXCPN
-
 	SAVE_CALLEE_SAVED_USER
 	mov r2, sp              ; callee_regs
 
@@ -163,11 +153,6 @@ ENTRY(EV_TLBProtV)
 
 	EXCEPTION_PROLOGUE
 
-	lr  r0, [efa]	; Faulting Data address
-	mov r1, sp	; pt_regs
-
-	FAKE_RET_FROM_EXCPN
-
 	mov blink, ret_from_exception
 	b   do_page_fault
 
diff --git a/arch/arc/kernel/entry-compact.S b/arch/arc/kernel/entry-compact.S
index 77f0090554c5..774c03cc1d1a 100644
--- a/arch/arc/kernel/entry-compact.S
+++ b/arch/arc/kernel/entry-compact.S
@@ -256,16 +256,6 @@ ENTRY(EV_TLBProtV)
 
 	EXCEPTION_PROLOGUE	; ECR returned in r10
 
-	lr  r0, [efa]	; Faulting Data address (not part of pt_regs saved above)
-
-	; Exception auto-disables further Intr/exceptions.
-	; Re-enable them by pretending to return from exception
-	; (so rest of handler executes in pure K mode)
-
-	FAKE_RET_FROM_EXCPN
-
-	mov   r1, sp	; Handle to pt_regs
-
 	;------ (5) Type of Protection Violation? ----------
 	;
 	; ProtV Hardware Exception is triggered for Access Faults of 2 types
@@ -301,9 +291,6 @@ END(EV_TLBProtV)
 ENTRY(call_do_page_fault)
 
 	EXCEPTION_PROLOGUE
-	lr  r0, [efa]	; Faulting Data address
-	mov   r1, sp
-	FAKE_RET_FROM_EXCPN
 
 	mov blink, ret_from_exception
 	b  do_page_fault
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 46582fbebcf2..089f6680518f 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -80,11 +80,6 @@ ENTRY(instr_service)
 
 	EXCEPTION_PROLOGUE
 
-	lr  r0, [efa]
-	mov r1, sp
-
-	FAKE_RET_FROM_EXCPN
-
 	bl  do_insterror_or_kprobe
 	b   ret_from_exception
 END(instr_service)
@@ -95,7 +90,7 @@ END(instr_service)
 
 ENTRY(EV_MachineCheck)
 
-	EXCEPTION_PROLOGUE	; ECR returned in r10
+	EXCEPTION_PROLOGUE_KEEP_AE	; ECR returned in r10
 
 	lr  r0, [efa]
 	mov r1, sp
@@ -128,11 +123,6 @@ ENTRY(EV_PrivilegeV)
 
 	EXCEPTION_PROLOGUE
 
-	lr  r0, [efa]
-	mov r1, sp
-
-	FAKE_RET_FROM_EXCPN
-
 	bl  do_privilege_fault
 	b   ret_from_exception
 END(EV_PrivilegeV)
@@ -144,11 +134,6 @@ ENTRY(EV_Extension)
 
 	EXCEPTION_PROLOGUE
 
-	lr  r0, [efa]
-	mov r1, sp
-
-	FAKE_RET_FROM_EXCPN
-
 	bl  do_extension_fault
 	b   ret_from_exception
 END(EV_Extension)
@@ -229,7 +214,7 @@ trap_with_param:
 
 ENTRY(EV_Trap)
 
-	EXCEPTION_PROLOGUE
+	EXCEPTION_PROLOGUE_KEEP_AE
 
 	lr  r12, [efa]
 
-- 
2.34.1

