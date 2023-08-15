Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0B77C4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjHOAtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjHOAs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A21173B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4330A64872
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26A6C433CA;
        Tue, 15 Aug 2023 00:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060506;
        bh=1BADrAn43TtzTGU0kqF+Zvl5nVwUsJU38y9W7psm8MY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLNu23dD5QSdJObrGEnxdpemvcC+18UMeZE6hXgAPhHQsgLsKHCJpbuYRTXrmFiOV
         XwNeEPKWd4f4HEWCq8BmFzCLDFiq7h0eql8936uifKcufKQoRj7R3wP0JVBwCE/QPj
         +JfIgxZz9hNn/d/JRuVUApX33VjifohyA6IoCcpwoNfNKVt4Mth3WBgVRFQ6cpCFlw
         r+9GpehN5tWaVb+hponcVkSEs9p6BhGrX350OkycjBIlbxbNvd+KaodssBjtGJ3Ffa
         5oq7iSd1G97VRfO4d2gQ8Y/hIZOhWB6lPdfCPecRf+CIANaA011C5RtKQydctsFS0F
         +pB5GqP/WaecA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 19/20] ARCv2: entry: rearrange pt_regs slightly
Date:   Mon, 14 Aug 2023 17:48:12 -0700
Message-Id: <20230815004813.555115-20-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of r26,fp,sp,r12,r30 order as fp,r30,r12,r26,sp

 - keeps SP at well known position (right abive hardware autosave)
 - r26,r12 saved specifically for ARCv2 (and not in ARCv3) kept
   closer for easy ifdef'ry later

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/entry-arcv2.h | 12 ++++++------
 arch/arc/include/asm/ptrace.h      |  9 +++++----
 arch/arc/kernel/asm-offsets.c      |  7 ++++---
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index a030eae93d35..4d13320e0c1b 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -149,10 +149,10 @@
  */
 .macro __SAVE_REGFILE_SOFT
 
-	ST2	gp, fp, PT_r26		; gp (r26), fp (r27)
-
-	st	r12, [sp, PT_r12]
+	st	fp,  [sp, PT_fp]	; r27
 	st	r30, [sp, PT_r30]
+	st	r12, [sp, PT_r12]
+	st	r26, [sp, PT_r26]	; gp
 
 	; Saving pt_regs->sp correctly requires some extra work due to the way
 	; Auto stack switch works
@@ -187,10 +187,10 @@
 /*------------------------------------------------------------------------*/
 .macro __RESTORE_REGFILE_SOFT
 
-	LD2	gp, fp, PT_r26		; gp (r26), fp (r27)
-
-	ld	r12, [sp, PT_r12]
+	ld	fp,  [sp, PT_fp]
 	ld	r30, [sp, PT_r30]
+	ld	r12, [sp, PT_r12]
+	ld	r26, [sp, PT_r26]
 
 	; Restore SP (into AUX_USER_SP) only if returning to U mode
 	;  - for K mode, it will be implicitly restored as stack is unwound
diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 2bf8ea96ea21..3a054b695f28 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -77,11 +77,10 @@ struct pt_regs {
 
 	unsigned long bta;	/* erbta */
 
-	unsigned long r26;	/* gp */
 	unsigned long fp;
-	unsigned long sp;	/* user/kernel sp depending on where we came from  */
-
-	unsigned long r12, r30;
+	unsigned long r30;
+	unsigned long r12;
+	unsigned long r26;	/* gp */
 
 #ifdef CONFIG_ARC_HAS_ACCL_REGS
 	unsigned long r58, r59;	/* ACCL/ACCH used by FPU / DSP MPY */
@@ -90,6 +89,8 @@ struct pt_regs {
 	unsigned long DSP_CTRL;
 #endif
 
+	unsigned long sp;	/* user/kernel sp depending on entry  */
+
 	/*------- Below list auto saved by h/w -----------*/
 	unsigned long r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11;
 
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index e46688975868..478768c88f46 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -62,11 +62,9 @@ int main(void)
 	DEFINE(PT_r26, offsetof(struct pt_regs, r26));
 	DEFINE(PT_ret, offsetof(struct pt_regs, ret));
 	DEFINE(PT_blink, offsetof(struct pt_regs, blink));
+	OFFSET(PT_fp, pt_regs, fp);
 	DEFINE(PT_lpe, offsetof(struct pt_regs, lp_end));
 	DEFINE(PT_lpc, offsetof(struct pt_regs, lp_count));
-	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
-	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
-
 #ifdef CONFIG_ISA_ARCV2
 	OFFSET(PT_r12, pt_regs, r12);
 	OFFSET(PT_r30, pt_regs, r30);
@@ -79,5 +77,8 @@ int main(void)
 	OFFSET(PT_DSP_CTRL, pt_regs, DSP_CTRL);
 #endif
 
+	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
+	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
+
 	return 0;
 }
-- 
2.34.1

