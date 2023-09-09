Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553B97997BF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjIILzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345422AbjIILzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:55:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F06E57
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:55:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A6C433C8;
        Sat,  9 Sep 2023 11:55:10 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Cc:     loongarch@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] LoongArch: Don't inline kasan_mem_to_shadow()/kasan_shadow_to_mem()
Date:   Sat,  9 Sep 2023 19:54:49 +0800
Message-Id: <20230909115450.1903218-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230909115450.1903218-1-chenhuacai@loongson.cn>
References: <20230909115450.1903218-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Linus suggested, kasan_mem_to_shadow()/kasan_shadow_to_mem() are not
performance-critical and too big to inline. This is simply wrong so just
define them out-of-line.

If they really need to be inlined in future, such as the objtool / SMAP
issue for X86, we should mark them __always_inline.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/kasan.h | 59 +++---------------------------
 arch/loongarch/mm/kasan_init.c     | 51 ++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index a12ecab37da7..cd6084f4e153 100644
--- a/arch/loongarch/include/asm/kasan.h
+++ b/arch/loongarch/include/asm/kasan.h
@@ -60,63 +60,16 @@
 extern bool kasan_early_stage;
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 
-#define kasan_arch_is_ready kasan_arch_is_ready
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	return !kasan_early_stage;
-}
-
 #define kasan_mem_to_shadow kasan_mem_to_shadow
-static inline void *kasan_mem_to_shadow(const void *addr)
-{
-	if (!kasan_arch_is_ready()) {
-		return (void *)(kasan_early_shadow_page);
-	} else {
-		unsigned long maddr = (unsigned long)addr;
-		unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
-		unsigned long offset = 0;
-
-		maddr &= XRANGE_SHADOW_MASK;
-		switch (xrange) {
-		case XKPRANGE_CC_SEG:
-			offset = XKPRANGE_CC_SHADOW_OFFSET;
-			break;
-		case XKPRANGE_UC_SEG:
-			offset = XKPRANGE_UC_SHADOW_OFFSET;
-			break;
-		case XKVRANGE_VC_SEG:
-			offset = XKVRANGE_VC_SHADOW_OFFSET;
-			break;
-		default:
-			WARN_ON(1);
-			return NULL;
-		}
-
-		return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
-	}
-}
+void *kasan_mem_to_shadow(const void *addr);
 
 #define kasan_shadow_to_mem kasan_shadow_to_mem
-static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
+const void *kasan_shadow_to_mem(const void *shadow_addr);
+
+#define kasan_arch_is_ready kasan_arch_is_ready
+static __always_inline bool kasan_arch_is_ready(void)
 {
-	unsigned long addr = (unsigned long)shadow_addr;
-
-	if (unlikely(addr > KASAN_SHADOW_END) ||
-		unlikely(addr < KASAN_SHADOW_START)) {
-		WARN_ON(1);
-		return NULL;
-	}
-
-	if (addr >= XKVRANGE_VC_SHADOW_OFFSET)
-		return (void *)(((addr - XKVRANGE_VC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKVRANGE_VC_START);
-	else if (addr >= XKPRANGE_UC_SHADOW_OFFSET)
-		return (void *)(((addr - XKPRANGE_UC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKPRANGE_UC_START);
-	else if (addr >= XKPRANGE_CC_SHADOW_OFFSET)
-		return (void *)(((addr - XKPRANGE_CC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKPRANGE_CC_START);
-	else {
-		WARN_ON(1);
-		return NULL;
-	}
+	return !kasan_early_stage;
 }
 
 #define addr_has_metadata addr_has_metadata
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index da68bc1a4643..cc3e81fe0186 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -35,6 +35,57 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 
 bool kasan_early_stage = true;
 
+void *kasan_mem_to_shadow(const void *addr)
+{
+	if (!kasan_arch_is_ready()) {
+		return (void *)(kasan_early_shadow_page);
+	} else {
+		unsigned long maddr = (unsigned long)addr;
+		unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
+		unsigned long offset = 0;
+
+		maddr &= XRANGE_SHADOW_MASK;
+		switch (xrange) {
+		case XKPRANGE_CC_SEG:
+			offset = XKPRANGE_CC_SHADOW_OFFSET;
+			break;
+		case XKPRANGE_UC_SEG:
+			offset = XKPRANGE_UC_SHADOW_OFFSET;
+			break;
+		case XKVRANGE_VC_SEG:
+			offset = XKVRANGE_VC_SHADOW_OFFSET;
+			break;
+		default:
+			WARN_ON(1);
+			return NULL;
+		}
+
+		return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
+	}
+}
+
+const void *kasan_shadow_to_mem(const void *shadow_addr)
+{
+	unsigned long addr = (unsigned long)shadow_addr;
+
+	if (unlikely(addr > KASAN_SHADOW_END) ||
+		unlikely(addr < KASAN_SHADOW_START)) {
+		WARN_ON(1);
+		return NULL;
+	}
+
+	if (addr >= XKVRANGE_VC_SHADOW_OFFSET)
+		return (void *)(((addr - XKVRANGE_VC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKVRANGE_VC_START);
+	else if (addr >= XKPRANGE_UC_SHADOW_OFFSET)
+		return (void *)(((addr - XKPRANGE_UC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKPRANGE_UC_START);
+	else if (addr >= XKPRANGE_CC_SHADOW_OFFSET)
+		return (void *)(((addr - XKPRANGE_CC_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT) + XKPRANGE_CC_START);
+	else {
+		WARN_ON(1);
+		return NULL;
+	}
+}
+
 /*
  * Alloc memory for shadow memory page table.
  */
-- 
2.39.3

