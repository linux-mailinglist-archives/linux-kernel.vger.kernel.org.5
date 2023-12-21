Return-Path: <linux-kernel+bounces-9019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA981BF56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D84A1F24F12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504A745DA;
	Thu, 21 Dec 2023 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ca6Xr6Os"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9373191
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hJyqXb/2fG9kaa/Bl39ZO/TtJVAZ8OgDJUIBMdnwuM=;
	b=ca6Xr6Os/Z3oFun+6KyDxiIacA2tRaVxTTFDHDXDXQXtiQWsYC5+HPech6L4MV3aDTlI07
	j3QG0NjRC9B+YgnnxEmb3EgpisveCkpCHQQWA6eNmn+8rbL4RjMp1UGbU7g5fyeyc5HMZ8
	qEqcpGuZ87c1j2vSIZxFI6Ddhg+Wa5s=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 01/11] kasan/arm64: improve comments for KASAN_SHADOW_START/END
Date: Thu, 21 Dec 2023 21:04:43 +0100
Message-Id: <140108ca0b164648c395a41fbeecb0601b1ae9e1.1703188911.git.andreyknvl@google.com>
In-Reply-To: <cover.1703188911.git.andreyknvl@google.com>
References: <cover.1703188911.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Unify and improve the comments for KASAN_SHADOW_START/END definitions
from include/asm/kasan.h and include/asm/memory.h.

Also put both definitions together in include/asm/memory.h.

Also clarify the related BUILD_BUG_ON checks in mm/kasan_init.c.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kasan.h  | 22 +------------------
 arch/arm64/include/asm/memory.h | 38 +++++++++++++++++++++++++++------
 arch/arm64/mm/kasan_init.c      |  5 +++++
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index 12d5f47f7dbe..7eefc525a9df 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -15,29 +15,9 @@
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
+asmlinkage void kasan_early_init(void);
 void kasan_init(void);
-
-/*
- * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
- * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresses,
- * where N = (1 << KASAN_SHADOW_SCALE_SHIFT).
- *
- * KASAN_SHADOW_OFFSET:
- * This value is used to map an address to the corresponding shadow
- * address by the following formula:
- *     shadow_addr = (address >> KASAN_SHADOW_SCALE_SHIFT) + KASAN_SHADOW_OFFSET
- *
- * (1 << (64 - KASAN_SHADOW_SCALE_SHIFT)) shadow addresses that lie in range
- * [KASAN_SHADOW_OFFSET, KASAN_SHADOW_END) cover all 64-bits of virtual
- * addresses. So KASAN_SHADOW_OFFSET should satisfy the following equation:
- *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END -
- *				(1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT))
- */
-#define _KASAN_SHADOW_START(va)	(KASAN_SHADOW_END - (1UL << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
-#define KASAN_SHADOW_START      _KASAN_SHADOW_START(vabits_actual)
-
 void kasan_copy_shadow(pgd_t *pgdir);
-asmlinkage void kasan_early_init(void);
 
 #else
 static inline void kasan_init(void) { }
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index fde4186cc387..0f139cb4467b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -65,15 +65,41 @@
 #define KERNEL_END		_end
 
 /*
- * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
- * address space for the shadow region respectively. They can bloat the stack
- * significantly, so double the (minimum) stack size when they are in use.
+ * Generic and Software Tag-Based KASAN modes require 1/8th and 1/16th of the
+ * kernel virtual address space for storing the shadow memory respectively.
+ *
+ * The mapping between a virtual memory address and its corresponding shadow
+ * memory address is defined based on the formula:
+ *
+ *     shadow_addr = (addr >> KASAN_SHADOW_SCALE_SHIFT) + KASAN_SHADOW_OFFSET
+ *
+ * where KASAN_SHADOW_SCALE_SHIFT is the order of the number of bits that map
+ * to a single shadow byte and KASAN_SHADOW_OFFSET is a constant that offsets
+ * the mapping. Note that KASAN_SHADOW_OFFSET does not point to the start of
+ * the shadow memory region.
+ *
+ * Based on this mapping, we define two constants:
+ *
+ *     KASAN_SHADOW_START: the start of the shadow memory region;
+ *     KASAN_SHADOW_END: the end of the shadow memory region.
+ *
+ * KASAN_SHADOW_END is defined first as the shadow address that corresponds to
+ * the upper bound of possible virtual kernel memory addresses UL(1) << 64
+ * according to the mapping formula.
+ *
+ * KASAN_SHADOW_START is defined second based on KASAN_SHADOW_END. The shadow
+ * memory start must map to the lowest possible kernel virtual memory address
+ * and thus it depends on the actual bitness of the address space.
+ *
+ * As KASAN inserts redzones between stack variables, this increases the stack
+ * memory usage significantly. Thus, we double the (minimum) stack size.
  */
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
-#define KASAN_SHADOW_END	((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) \
-					+ KASAN_SHADOW_OFFSET)
-#define PAGE_END		(KASAN_SHADOW_END - (1UL << (vabits_actual - KASAN_SHADOW_SCALE_SHIFT)))
+#define KASAN_SHADOW_END	((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) + KASAN_SHADOW_OFFSET)
+#define _KASAN_SHADOW_START(va)	(KASAN_SHADOW_END - (UL(1) << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
+#define KASAN_SHADOW_START	_KASAN_SHADOW_START(vabits_actual)
+#define PAGE_END		KASAN_SHADOW_START
 #define KASAN_THREAD_SHIFT	1
 #else
 #define KASAN_THREAD_SHIFT	0
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 555285ebd5af..4c7ad574b946 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -170,6 +170,11 @@ asmlinkage void __init kasan_early_init(void)
 {
 	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
 		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
+	/*
+	 * We cannot check the actual value of KASAN_SHADOW_START during build,
+	 * as it depends on vabits_actual. As a best-effort approach, check
+	 * potential values calculated based on VA_BITS and VA_BITS_MIN.
+	 */
 	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS), PGDIR_SIZE));
 	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS_MIN), PGDIR_SIZE));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
-- 
2.25.1


