Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B378DD95
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbjH3SwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbjH3GfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:35:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C7D107
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:34:57 -0700 (PDT)
X-QQ-mid: bizesmtp72t1693377284t20dyyw5
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 30 Aug 2023 14:34:42 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: I8hG9CuxGDLVX4zYenMnZzfme72U6h6VUyCmh7+o/2/nV1SicSheCqLWUS/6f
        6UBdxSE+5weyB8T4IXrP/HkOLySS94hUiIsCzTvD5UBUakxSArtJyUcT73pGsZfVR2aAx0u
        X0NTTXxVE8YaME/T4o2p69r3PUsGs8E+PX+KlZWNJ/aCopGnPy+twcWgkdCRkQpOrGtxObS
        t92LfKJyicKmsjEyxI21m68yYxHg416+39bO+IFEE4HEKtqI6EJqhBzGEPTuID98pPHXO/1
        LQFFbENG8KfWdMSZD/8Yz9zNVHUAzjpcW4PKTXPvbaQx1JrNVtCamJ1z0lr1rby48BJ9pXB
        L9dc0jYTFpe1jkv8MAvQrXdmPa4760QS2i6adCK
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10736640701935298722
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mick@ics.forth.gr, alex@ghiti.fr
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH] riscv: kexec: Cleanup riscv_kexec_relocate
Date:   Wed, 30 Aug 2023 14:34:35 +0800
Message-Id: <20230830063435.1105726-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For readability and simplicity, cleanup the riscv_kexec_relocate code:

- Re-sort the first 4 `mv` instructions against `riscv_kexec_method()`
- Eliminate registers for debugging (s9,s10,s11) and storing const-value (s5,s6)
- Replace `jalr` with `jr` for no-link jump

I tested this on Qemu virt machine and works as it was.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/kernel/kexec_relocate.S | 52 +++++++++++++-----------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index 059c5e216ae7..de0a4b35d01e 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -17,27 +17,17 @@ SYM_CODE_START(riscv_kexec_relocate)
 	 * s1: (const) Phys address to jump to after relocation
 	 * s2: (const) Phys address of the FDT image
 	 * s3: (const) The hartid of the current hart
-	 * s4: Pointer to the destination address for the relocation
-	 * s5: (const) Number of words per page
-	 * s6: (const) 1, used for subtraction
-	 * s7: (const) kernel_map.va_pa_offset, used when switching MMU off
-	 * s8: (const) Physical address of the main loop
-	 * s9: (debug) indirection page counter
-	 * s10: (debug) entry counter
-	 * s11: (debug) copied words counter
+	 * s4: (const) kernel_map.va_pa_offset, used when switching MMU off
+	 * s5: Pointer to the destination address for the relocation
+	 * s6: (const) Physical address of the main loop
 	 */
 	mv	s0, a0
 	mv	s1, a1
 	mv	s2, a2
 	mv	s3, a3
-	mv	s4, zero
-	li	s5, (PAGE_SIZE / RISCV_SZPTR)
-	li	s6, 1
-	mv	s7, a4
-	mv	s8, zero
-	mv	s9, zero
-	mv	s10, zero
-	mv	s11, zero
+	mv	s4, a4
+	mv	s5, zero
+	mv	s6, zero
 
 	/* Disable / cleanup interrupts */
 	csrw	CSR_SIE, zero
@@ -52,21 +42,27 @@ SYM_CODE_START(riscv_kexec_relocate)
 	 * the start of the loop below so that we jump there in
 	 * any case.
 	 */
-	la	s8, 1f
-	sub	s8, s8, s7
-	csrw	CSR_STVEC, s8
+	la	s6, 1f
+	sub	s6, s6, s4
+	csrw	CSR_STVEC, s6
+
+	/*
+	 * With C-extension, here we get 42 Bytes and the next
+	 * .align directive would pad zeros here up to 44 Bytes.
+	 * So manually put a nop here to avoid zeros padding.
+	*/
+	nop
 
 	/* Process entries in a loop */
 .align 2
 1:
-	addi	s10, s10, 1
 	REG_L	t0, 0(s0)		/* t0 = *image->entry */
 	addi	s0, s0, RISCV_SZPTR	/* image->entry++ */
 
 	/* IND_DESTINATION entry ? -> save destination address */
 	andi	t1, t0, 0x1
 	beqz	t1, 2f
-	andi	s4, t0, ~0x1
+	andi	s5, t0, ~0x1
 	j	1b
 
 2:
@@ -74,9 +70,8 @@ SYM_CODE_START(riscv_kexec_relocate)
 	andi	t1, t0, 0x2
 	beqz	t1, 2f
 	andi	s0, t0, ~0x2
-	addi	s9, s9, 1
 	csrw	CSR_SATP, zero
-	jalr	zero, s8, 0
+	jr	s6
 
 2:
 	/* IND_DONE entry ? -> jump to done label */
@@ -92,14 +87,13 @@ SYM_CODE_START(riscv_kexec_relocate)
 	andi	t1, t0, 0x8
 	beqz	t1, 1b		/* Unknown entry type, ignore it */
 	andi	t0, t0, ~0x8
-	mv	t3, s5		/* i = num words per page */
+	li	t3, (PAGE_SIZE / RISCV_SZPTR)	/* i = num words per page */
 3:	/* copy loop */
 	REG_L	t1, (t0)	/* t1 = *src_ptr */
-	REG_S	t1, (s4)	/* *dst_ptr = *src_ptr */
+	REG_S	t1, (s5)	/* *dst_ptr = *src_ptr */
 	addi	t0, t0, RISCV_SZPTR /* stc_ptr++ */
-	addi	s4, s4, RISCV_SZPTR /* dst_ptr++ */
-	sub	t3, t3, s6	/* i-- */
-	addi	s11, s11, 1	/* c++ */
+	addi	s5, s5, RISCV_SZPTR /* dst_ptr++ */
+	addi	t3, t3, -0x1	/* i-- */
 	beqz	t3, 1b		/* copy done ? */
 	j	3b
 
@@ -146,7 +140,7 @@ SYM_CODE_START(riscv_kexec_relocate)
 	 */
 	fence.i
 
-	jalr	zero, a2, 0
+	jr	a2
 
 SYM_CODE_END(riscv_kexec_relocate)
 riscv_kexec_relocate_end:
-- 
2.20.1

