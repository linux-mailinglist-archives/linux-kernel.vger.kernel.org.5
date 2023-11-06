Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E827E2A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjKFRAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjKFRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:00:36 -0500
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD6191
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/lBnAPLXd3bmIiEmokYvLT/eas4j7AzPy7ap5uVAF/8=; b=2fBzHE6phz8gS9PkUpr2gm+AYL
        uavhFVVyTdHAH3vIIJYI0/pClS60XMYqHQShvAwvJKdxsnfMAE2sT/a0k7W+8hdo7UcFx3zTq8857
        OeyLT5rqaCXrPij8+/ePnA9sERiYhk206klNoDarjsmXJw07b22qqG90g8+UtfEHuckrnJJUALq4E
        5JGH3WCpsdkxR5if0EUwSqcTiqY9hGPBMWasnincIETNFZnpK8nIMCZ0uKx+PlT23t1MLwgacNnuZ
        wU6Ujh6C8i9wUG0gunhN8kHBCbEC6YS5heiUNdG8yti79a9YeN7j4I34ZBfK805kVYiCb4DmpFqAt
        ANG2ktVQ==;
Received: from [167.98.27.226] (helo=ct-lt-2504.guest.codethink.co.uk)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r02xf-00Fh3F-OO; Mon, 06 Nov 2023 17:00:27 +0000
From:   Ivan Orlov <ivan.orlov@codethink.co.uk>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     Ivan Orlov <ivan.orlov@codethink.co.uk>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk
Subject: [PATCH] riscv: lib: Implement optimized memchr function
Date:   Mon,  6 Nov 2023 17:00:25 +0000
Message-Id: <20231106170025.778193-1-ivan.orlov@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: ivan.orlov@codethink.co.uk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment we don't have an architecture-specific memchr
implementation for riscv in the Kernel. The generic version of this
function iterates the memory area bytewise looking for the target value,
which is not the optimal approach.

Instead of iterating the memory byte by byte, we can iterate over words
of memory. Word still takes only one cycle to be loaded, and it could be
checked for containing the target byte in just 5 operations:

1. Let's say we are looking for the byte BA. XOR the word with
0xBABA..BA
2. If we have zero byte in the result, the word contains byte BA. Let's
subtract 0x0101..01 from the xor result.
3. Calculate the ~(xor result).
4. And the results of steps 2 and 3. If in the xor result we had a zero
bit somewhere, and after subtracting the 0x0101..01 it turned to 1,
we will get 1 in the result
5. And the result of step 4 with 0x8080..80. If we had a leading zero
bit in the xor result which turned to 1 after subtracting 0x0101..01,
it was the leading bit of a zero byte. So, if result of this step != 0,
the word contains the byte we are looking for.

The same approach is used in the arm64 implementation of this function.

So, this patch introduces the riscv-specific memchr function which
accepts 3 parameters (address, target byte and count) and works in the
following way:

0. If count is smaller than 128, iterate the area byte by byte as we
would not get any performance gain here.
1. If address is not aligned, iterate SZREG - (address % SZREG) bytes
to avoid unaligned memory access.
2. If count is larger than 128, iterate words of memory until we find
the word which contains the target byte.
3. If we have found the word, iterate through it byte by byte and return
the address of the first occurrence.
4. If we have not found the word, iterate the remainder (in case if
the count was not divisible by 8).
5. If we still have not found the target byte, return 0.

Here you can see the benchmark results for "Sifive Hifive Unmatched"
board, which compares the old and new memchr implementations.

| test_count | array_size | old_mean_ktime  | new_mean_ktime  |
---------------------------------------------------------------
|      10000 |         10 |             415 |             409 |
|      10000 |        100 |             642 |             717 |
|      10000 |        128 |             714 |             775 |
|      10000 |        256 |            1031 |             611 |
|       5000 |        512 |            1686 |             769 |
|       5000 |        768 |            2320 |             925 |
|       5000 |       1024 |            2968 |            1095 |
|       5000 |       1500 |            4165 |            1383 |
|       5000 |       2048 |            5567 |            1731 |
|       3000 |       4096 |           10698 |            3028 |
|       3000 |      16384 |           41630 |           10766 |
|       1000 |     524288 |         1475454 |          498183 |
|       1000 |    1048576 |         2952080 |          997018 |
|        500 |   10485760 |        49491492 |        29335358 |
|        100 |  134217728 |       636033660 |       377157970 |
|         20 |  536870912 |      2546979300 |      1510817350 |
|         20 | 1073741824 |      5095776750 |      3019167250 |

The target symbol was always placed at the last index of the array, and
the mean time of function execution was measured using the ktime_get
function.

As you can see, the new function shows much better results even for
the small arrays of 256 elements, therefore I believe it could be a
useful addition to the existing riscv-specific string functions.

Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
---
 arch/riscv/include/asm/string.h |  2 +
 arch/riscv/kernel/riscv_ksyms.c |  1 +
 arch/riscv/lib/Makefile         |  1 +
 arch/riscv/lib/memchr.S         | 98 +++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 arch/riscv/lib/memchr.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index a96b1fea24fe..ec1a643cb625 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -18,6 +18,8 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
 #define __HAVE_ARCH_MEMMOVE
 extern asmlinkage void *memmove(void *, const void *, size_t);
 extern asmlinkage void *__memmove(void *, const void *, size_t);
+#define __HAVE_ARCH_MEMCHR
+extern asmlinkage void *memchr(const void *, int, size_t);
 
 #define __HAVE_ARCH_STRCMP
 extern asmlinkage int strcmp(const char *cs, const char *ct);
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index a72879b4249a..08c0d846366b 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -9,6 +9,7 @@
 /*
  * Assembly functions that may be used (directly or indirectly) by modules
  */
+EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 26cb2502ecf8..0a8b64f8ca88 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+lib-y			+= memchr.o
 lib-y			+= delay.o
 lib-y			+= memcpy.o
 lib-y			+= memset.o
diff --git a/arch/riscv/lib/memchr.S b/arch/riscv/lib/memchr.S
new file mode 100644
index 000000000000..d48e0fa3cd84
--- /dev/null
+++ b/arch/riscv/lib/memchr.S
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Codethink Ltd.
+ * Author: Ivan Orlov <ivan.orlov@codethink.co.uk>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+#define REP_01 __REG_SEL(0x0101010101010101, 0x01010101)
+#define REP_80 __REG_SEL(0x8080808080808080, 0x80808080)
+
+#define MIN_BORDER 128
+
+SYM_FUNC_START(memchr)
+	andi a1, a1, 0xFF
+
+	// use byte-wide iteration for small numbers
+	add t1, x0, a2
+	sltiu t2, a2, MIN_BORDER
+	bnez t2, 6f
+
+	// get the number of bytes we should iterate before alignment
+	andi t0, a0, SZREG - 1
+	beqz t0, 4f
+
+	# get the SZREG - t0
+	xor t0, t0, SZREG - 1
+	addi t0, t0, 1
+
+	sub a2, a2, t0
+	// iterate before alignment
+1:
+	beq t0, x0, 4f
+	lbu t2, 0(a0)
+	beq t2, a1, 3f
+	addi t0, t0, -1
+	addi a0, a0, 1
+	j 1b
+
+2:
+	// found a word. Iterate it until we find the target byte
+	li t1, SZREG
+	j 6f
+3:
+	ret
+
+4:
+	// get the count remainder
+	andi t1, a2, SZREG - 1
+
+	// align the count
+	sub a2, a2, t1
+
+	// if we have no words to iterate, iterate the remainder
+	beqz a2, 6f
+
+	// from 0xBA we will get 0xBABABABABABABABA
+	li t3, REP_01
+	mul t3, t3, a1
+
+	add a2, a2, a0
+
+	li t4, REP_01
+	li t5, REP_80
+
+5:
+	REG_L t2, 0(a0)
+
+	// after this xor we will get one zero byte in the word if it contains the target byte
+	xor t2, t2, t3
+
+	// word v contains the target byte if (v - 0x01010101) & (~v) & 0x80808080 is positive
+	sub t0, t2, t4
+
+	not t2, t2
+
+	and t0, t0, t2
+	and t0, t0, t5
+
+	bnez t0, 2b
+	addi a0, a0, SZREG
+	bne a0, a2, 5b
+
+6:
+	// iterate the remainder
+	beq t1, x0, 7f
+	lbu t4, 0(a0)
+	beq t4, a1, 3b
+	addi a0, a0, 1
+	addi t1, t1, -1
+	j 6b
+
+7:
+	addi a0, x0, 0
+	ret
+SYM_FUNC_END(memchr)
+SYM_FUNC_ALIAS(__pi_memchr, memchr)
-- 
2.34.1

