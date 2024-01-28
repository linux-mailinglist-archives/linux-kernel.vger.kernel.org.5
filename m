Return-Path: <linux-kernel+bounces-41596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158283F51D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0272A1F21D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8076722323;
	Sun, 28 Jan 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf1+V7HY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83020DC1
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706440987; cv=none; b=hSr2bOEgGYaIQFV4aFX27ya+S/q0WiOkYZ0oN423RoAF9WukCDnMbJzMZ1RbkxZ9c7nDPEkSIJUFQpi8ycU7S8JZiRkOgr2pA3tzWOfrNYPb7ggLzYVRULhF2IqSGmAG4BlTDA3/r1gtVPvjb2C0Fq8mQ5jxtYYN+V9SYwhs7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706440987; c=relaxed/simple;
	bh=/od1c7MyoQNpI2RDNFAjU9gX1pL9wSnySvV0sadsH0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJV0D+XBIdw7Zu8Vyg2YyHhjs9s9BCR1mREzkFVEXA3lpBPjfEPosQP3h0ZJZvpNmsEnuc47vsD+SRAgx+jRfZtDGArUapBf+6FmyhWXVR6+AFT2peRkooEB0oyNSkMeCfJWEKnLi9i6el3GJQrmrZWf2VQTuPVr4wYm+sSeqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf1+V7HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71445C433B2;
	Sun, 28 Jan 2024 11:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706440986;
	bh=/od1c7MyoQNpI2RDNFAjU9gX1pL9wSnySvV0sadsH0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kf1+V7HY4GYXLpeGiqpvV0SN8/z9kSnocTgUcsX85JaCdLjsfHuJ2CxlOgVtGXU26
	 0GOR0OqSoCpgZrUSNJ0S1x3yyEArR//TihcKOEaWRJxvCsArknqUQYXicE0+k0s6nS
	 hu9CDu4nyLMcNG3BihjTgFi/B2iZFyGzyFqqMAPaKfkW6tUEr6gyKyaYUUCM5SV8vL
	 utU2gvuaVoEmx0LA3l0JEFI7T4UKVMcI5WLfxdlBLO3Ewo3tw8nXuW09m4q3TyAU6w
	 pd5XLTnk9vYDrD6Y1M02n3tB+lk329yUZqNttz9i0q6cySadWLGPKL/LtkxfRKXZtD
	 +l4+FOE2d54aQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Matteo Croce <mcroce@microsoft.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] riscv: optimized memmove
Date: Sun, 28 Jan 2024 19:10:12 +0800
Message-ID: <20240128111013.2450-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128111013.2450-1-jszhang@kernel.org>
References: <20240128111013.2450-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <mcroce@microsoft.com>

When the destination buffer is before the source one, or when the
buffers doesn't overlap, it's safe to use memcpy() instead, which is
optimized to use a bigger data size possible.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/string.h |   4 +-
 arch/riscv/kernel/riscv_ksyms.c |   2 -
 arch/riscv/lib/Makefile         |   1 -
 arch/riscv/lib/memmove.S        | 317 --------------------------------
 arch/riscv/lib/string.c         |  25 +++
 5 files changed, 27 insertions(+), 322 deletions(-)
 delete mode 100644 arch/riscv/lib/memmove.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index edf1d56e4f13..17c3b40382e1 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -18,8 +18,8 @@ extern void *memcpy(void *dest, const void *src, size_t count);
 extern void *__memcpy(void *dest, const void *src, size_t count);
 
 #define __HAVE_ARCH_MEMMOVE
-extern asmlinkage void *memmove(void *, const void *, size_t);
-extern asmlinkage void *__memmove(void *, const void *, size_t);
+extern void *memmove(void *dest, const void *src, size_t count);
+extern void *__memmove(void *dest, const void *src, size_t count);
 
 #define __HAVE_ARCH_STRCMP
 extern asmlinkage int strcmp(const char *cs, const char *ct);
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index c69dc74e0a27..76849d0906ef 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -10,9 +10,7 @@
  * Assembly functions that may be used (directly or indirectly) by modules
  */
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(__memmove);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 5f2f94f6db17..5fa88c5a601c 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 lib-y			+= delay.o
 lib-y			+= memset.o
-lib-y			+= memmove.o
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
 lib-y			+= string.o
diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
deleted file mode 100644
index cb3e2e7ef0ba..000000000000
--- a/arch/riscv/lib/memmove.S
+++ /dev/null
@@ -1,317 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2022 Michael T. Kloos <michael@michaelkloos.com>
- */
-
-#include <linux/linkage.h>
-#include <asm/asm.h>
-
-SYM_FUNC_START(__memmove)
-	/*
-	 * Returns
-	 *   a0 - dest
-	 *
-	 * Parameters
-	 *   a0 - Inclusive first byte of dest
-	 *   a1 - Inclusive first byte of src
-	 *   a2 - Length of copy n
-	 *
-	 * Because the return matches the parameter register a0,
-	 * we will not clobber or modify that register.
-	 *
-	 * Note: This currently only works on little-endian.
-	 * To port to big-endian, reverse the direction of shifts
-	 * in the 2 misaligned fixup copy loops.
-	 */
-
-	/* Return if nothing to do */
-	beq a0, a1, .Lreturn_from_memmove
-	beqz a2, .Lreturn_from_memmove
-
-	/*
-	 * Register Uses
-	 *      Forward Copy: a1 - Index counter of src
-	 *      Reverse Copy: a4 - Index counter of src
-	 *      Forward Copy: t3 - Index counter of dest
-	 *      Reverse Copy: t4 - Index counter of dest
-	 *   Both Copy Modes: t5 - Inclusive first multibyte/aligned of dest
-	 *   Both Copy Modes: t6 - Non-Inclusive last multibyte/aligned of dest
-	 *   Both Copy Modes: t0 - Link / Temporary for load-store
-	 *   Both Copy Modes: t1 - Temporary for load-store
-	 *   Both Copy Modes: t2 - Temporary for load-store
-	 *   Both Copy Modes: a5 - dest to src alignment offset
-	 *   Both Copy Modes: a6 - Shift ammount
-	 *   Both Copy Modes: a7 - Inverse Shift ammount
-	 *   Both Copy Modes: a2 - Alternate breakpoint for unrolled loops
-	 */
-
-	/*
-	 * Solve for some register values now.
-	 * Byte copy does not need t5 or t6.
-	 */
-	mv   t3, a0
-	add  t4, a0, a2
-	add  a4, a1, a2
-
-	/*
-	 * Byte copy if copying less than (2 * SZREG) bytes. This can
-	 * cause problems with the bulk copy implementation and is
-	 * small enough not to bother.
-	 */
-	andi t0, a2, -(2 * SZREG)
-	beqz t0, .Lbyte_copy
-
-	/*
-	 * Now solve for t5 and t6.
-	 */
-	andi t5, t3, -SZREG
-	andi t6, t4, -SZREG
-	/*
-	 * If dest(Register t3) rounded down to the nearest naturally
-	 * aligned SZREG address, does not equal dest, then add SZREG
-	 * to find the low-bound of SZREG alignment in the dest memory
-	 * region.  Note that this could overshoot the dest memory
-	 * region if n is less than SZREG.  This is one reason why
-	 * we always byte copy if n is less than SZREG.
-	 * Otherwise, dest is already naturally aligned to SZREG.
-	 */
-	beq  t5, t3, 1f
-		addi t5, t5, SZREG
-	1:
-
-	/*
-	 * If the dest and src are co-aligned to SZREG, then there is
-	 * no need for the full rigmarole of a full misaligned fixup copy.
-	 * Instead, do a simpler co-aligned copy.
-	 */
-	xor  t0, a0, a1
-	andi t1, t0, (SZREG - 1)
-	beqz t1, .Lcoaligned_copy
-	/* Fall through to misaligned fixup copy */
-
-.Lmisaligned_fixup_copy:
-	bltu a1, a0, .Lmisaligned_fixup_copy_reverse
-
-.Lmisaligned_fixup_copy_forward:
-	jal  t0, .Lbyte_copy_until_aligned_forward
-
-	andi a5, a1, (SZREG - 1) /* Find the alignment offset of src (a1) */
-	slli a6, a5, 3 /* Multiply by 8 to convert that to bits to shift */
-	sub  a5, a1, t3 /* Find the difference between src and dest */
-	andi a1, a1, -SZREG /* Align the src pointer */
-	addi a2, t6, SZREG /* The other breakpoint for the unrolled loop*/
-
-	/*
-	 * Compute The Inverse Shift
-	 * a7 = XLEN - a6 = XLEN + -a6
-	 * 2s complement negation to find the negative: -a6 = ~a6 + 1
-	 * Add that to XLEN.  XLEN = SZREG * 8.
-	 */
-	not  a7, a6
-	addi a7, a7, (SZREG * 8 + 1)
-
-	/*
-	 * Fix Misalignment Copy Loop - Forward
-	 * load_val0 = load_ptr[0];
-	 * do {
-	 * 	load_val1 = load_ptr[1];
-	 * 	store_ptr += 2;
-	 * 	store_ptr[0 - 2] = (load_val0 >> {a6}) | (load_val1 << {a7});
-	 *
-	 * 	if (store_ptr == {a2})
-	 * 		break;
-	 *
-	 * 	load_val0 = load_ptr[2];
-	 * 	load_ptr += 2;
-	 * 	store_ptr[1 - 2] = (load_val1 >> {a6}) | (load_val0 << {a7});
-	 *
-	 * } while (store_ptr != store_ptr_end);
-	 * store_ptr = store_ptr_end;
-	 */
-
-	REG_L t0, (0 * SZREG)(a1)
-	1:
-	REG_L t1, (1 * SZREG)(a1)
-	addi  t3, t3, (2 * SZREG)
-	srl   t0, t0, a6
-	sll   t2, t1, a7
-	or    t2, t0, t2
-	REG_S t2, ((0 * SZREG) - (2 * SZREG))(t3)
-
-	beq   t3, a2, 2f
-
-	REG_L t0, (2 * SZREG)(a1)
-	addi  a1, a1, (2 * SZREG)
-	srl   t1, t1, a6
-	sll   t2, t0, a7
-	or    t2, t1, t2
-	REG_S t2, ((1 * SZREG) - (2 * SZREG))(t3)
-
-	bne   t3, t6, 1b
-	2:
-	mv    t3, t6 /* Fix the dest pointer in case the loop was broken */
-
-	add  a1, t3, a5 /* Restore the src pointer */
-	j .Lbyte_copy_forward /* Copy any remaining bytes */
-
-.Lmisaligned_fixup_copy_reverse:
-	jal  t0, .Lbyte_copy_until_aligned_reverse
-
-	andi a5, a4, (SZREG - 1) /* Find the alignment offset of src (a4) */
-	slli a6, a5, 3 /* Multiply by 8 to convert that to bits to shift */
-	sub  a5, a4, t4 /* Find the difference between src and dest */
-	andi a4, a4, -SZREG /* Align the src pointer */
-	addi a2, t5, -SZREG /* The other breakpoint for the unrolled loop*/
-
-	/*
-	 * Compute The Inverse Shift
-	 * a7 = XLEN - a6 = XLEN + -a6
-	 * 2s complement negation to find the negative: -a6 = ~a6 + 1
-	 * Add that to XLEN.  XLEN = SZREG * 8.
-	 */
-	not  a7, a6
-	addi a7, a7, (SZREG * 8 + 1)
-
-	/*
-	 * Fix Misalignment Copy Loop - Reverse
-	 * load_val1 = load_ptr[0];
-	 * do {
-	 * 	load_val0 = load_ptr[-1];
-	 * 	store_ptr -= 2;
-	 * 	store_ptr[1] = (load_val0 >> {a6}) | (load_val1 << {a7});
-	 *
-	 * 	if (store_ptr == {a2})
-	 * 		break;
-	 *
-	 * 	load_val1 = load_ptr[-2];
-	 * 	load_ptr -= 2;
-	 * 	store_ptr[0] = (load_val1 >> {a6}) | (load_val0 << {a7});
-	 *
-	 * } while (store_ptr != store_ptr_end);
-	 * store_ptr = store_ptr_end;
-	 */
-
-	REG_L t1, ( 0 * SZREG)(a4)
-	1:
-	REG_L t0, (-1 * SZREG)(a4)
-	addi  t4, t4, (-2 * SZREG)
-	sll   t1, t1, a7
-	srl   t2, t0, a6
-	or    t2, t1, t2
-	REG_S t2, ( 1 * SZREG)(t4)
-
-	beq   t4, a2, 2f
-
-	REG_L t1, (-2 * SZREG)(a4)
-	addi  a4, a4, (-2 * SZREG)
-	sll   t0, t0, a7
-	srl   t2, t1, a6
-	or    t2, t0, t2
-	REG_S t2, ( 0 * SZREG)(t4)
-
-	bne   t4, t5, 1b
-	2:
-	mv    t4, t5 /* Fix the dest pointer in case the loop was broken */
-
-	add  a4, t4, a5 /* Restore the src pointer */
-	j .Lbyte_copy_reverse /* Copy any remaining bytes */
-
-/*
- * Simple copy loops for SZREG co-aligned memory locations.
- * These also make calls to do byte copies for any unaligned
- * data at their terminations.
- */
-.Lcoaligned_copy:
-	bltu a1, a0, .Lcoaligned_copy_reverse
-
-.Lcoaligned_copy_forward:
-	jal t0, .Lbyte_copy_until_aligned_forward
-
-	1:
-	REG_L t1, ( 0 * SZREG)(a1)
-	addi  a1, a1, SZREG
-	addi  t3, t3, SZREG
-	REG_S t1, (-1 * SZREG)(t3)
-	bne   t3, t6, 1b
-
-	j .Lbyte_copy_forward /* Copy any remaining bytes */
-
-.Lcoaligned_copy_reverse:
-	jal t0, .Lbyte_copy_until_aligned_reverse
-
-	1:
-	REG_L t1, (-1 * SZREG)(a4)
-	addi  a4, a4, -SZREG
-	addi  t4, t4, -SZREG
-	REG_S t1, ( 0 * SZREG)(t4)
-	bne   t4, t5, 1b
-
-	j .Lbyte_copy_reverse /* Copy any remaining bytes */
-
-/*
- * These are basically sub-functions within the function.  They
- * are used to byte copy until the dest pointer is in alignment.
- * At which point, a bulk copy method can be used by the
- * calling code.  These work on the same registers as the bulk
- * copy loops.  Therefore, the register values can be picked
- * up from where they were left and we avoid code duplication
- * without any overhead except the call in and return jumps.
- */
-.Lbyte_copy_until_aligned_forward:
-	beq  t3, t5, 2f
-	1:
-	lb   t1,  0(a1)
-	addi a1, a1, 1
-	addi t3, t3, 1
-	sb   t1, -1(t3)
-	bne  t3, t5, 1b
-	2:
-	jalr zero, 0x0(t0) /* Return to multibyte copy loop */
-
-.Lbyte_copy_until_aligned_reverse:
-	beq  t4, t6, 2f
-	1:
-	lb   t1, -1(a4)
-	addi a4, a4, -1
-	addi t4, t4, -1
-	sb   t1,  0(t4)
-	bne  t4, t6, 1b
-	2:
-	jalr zero, 0x0(t0) /* Return to multibyte copy loop */
-
-/*
- * Simple byte copy loops.
- * These will byte copy until they reach the end of data to copy.
- * At that point, they will call to return from memmove.
- */
-.Lbyte_copy:
-	bltu a1, a0, .Lbyte_copy_reverse
-
-.Lbyte_copy_forward:
-	beq  t3, t4, 2f
-	1:
-	lb   t1,  0(a1)
-	addi a1, a1, 1
-	addi t3, t3, 1
-	sb   t1, -1(t3)
-	bne  t3, t4, 1b
-	2:
-	ret
-
-.Lbyte_copy_reverse:
-	beq  t4, t3, 2f
-	1:
-	lb   t1, -1(a4)
-	addi a4, a4, -1
-	addi t4, t4, -1
-	sb   t1,  0(t4)
-	bne  t4, t3, 1b
-	2:
-
-.Lreturn_from_memmove:
-	ret
-
-SYM_FUNC_END(__memmove)
-SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
-SYM_FUNC_ALIAS(__pi_memmove, __memmove)
-SYM_FUNC_ALIAS(__pi___memmove, __memmove)
diff --git a/arch/riscv/lib/string.c b/arch/riscv/lib/string.c
index 5f9c83ec548d..20677c8067da 100644
--- a/arch/riscv/lib/string.c
+++ b/arch/riscv/lib/string.c
@@ -119,3 +119,28 @@ void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy)
 EXPORT_SYMBOL(memcpy);
 void *__pi_memcpy(void *dest, const void *src, size_t count) __alias(__memcpy);
 void *__pi___memcpy(void *dest, const void *src, size_t count) __alias(__memcpy);
+
+/*
+ * Simply check if the buffer overlaps an call memcpy() in case,
+ * otherwise do a simple one byte at time backward copy.
+ */
+void *__memmove(void *dest, const void *src, size_t count)
+{
+	if (dest < src || src + count <= dest)
+		return __memcpy(dest, src, count);
+
+	if (dest > src) {
+		const char *s = src + count;
+		char *tmp = dest + count;
+
+		while (count--)
+			*--tmp = *--s;
+	}
+	return dest;
+}
+EXPORT_SYMBOL(__memmove);
+
+void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmove);
+EXPORT_SYMBOL(memmove);
+void *__pi_memmove(void *dest, const void *src, size_t count) __alias(__memmove);
+void *__pi___memmove(void *dest, const void *src, size_t count) __alias(__memmove);
-- 
2.43.0


