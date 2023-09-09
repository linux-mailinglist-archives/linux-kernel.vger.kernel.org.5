Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324687997BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345417AbjIILzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjIILzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:55:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3BE46
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:55:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83BFC433C8;
        Sat,  9 Sep 2023 11:54:59 +0000 (UTC)
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
Subject: [PATCH 1/2] kasan: Cleanup the __HAVE_ARCH_SHADOW_MAP usage
Date:   Sat,  9 Sep 2023 19:54:48 +0800
Message-Id: <20230909115450.1903218-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
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

As Linus suggested, __HAVE_ARCH_XYZ is stupid and only for historical
uses. So cleanup the __HAVE_ARCH_SHADOW_MAP usage and use self-defined
macros instead.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/kasan.h | 10 ++++++++--
 include/linux/kasan.h              |  2 +-
 mm/kasan/kasan.h                   |  8 +++-----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index deeff8158f45..a12ecab37da7 100644
--- a/arch/loongarch/include/asm/kasan.h
+++ b/arch/loongarch/include/asm/kasan.h
@@ -10,8 +10,6 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 
-#define __HAVE_ARCH_SHADOW_MAP
-
 #define KASAN_SHADOW_SCALE_SHIFT 3
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 
@@ -68,6 +66,7 @@ static __always_inline bool kasan_arch_is_ready(void)
 	return !kasan_early_stage;
 }
 
+#define kasan_mem_to_shadow kasan_mem_to_shadow
 static inline void *kasan_mem_to_shadow(const void *addr)
 {
 	if (!kasan_arch_is_ready()) {
@@ -97,6 +96,7 @@ static inline void *kasan_mem_to_shadow(const void *addr)
 	}
 }
 
+#define kasan_shadow_to_mem kasan_shadow_to_mem
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 {
 	unsigned long addr = (unsigned long)shadow_addr;
@@ -119,6 +119,12 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 	}
 }
 
+#define addr_has_metadata addr_has_metadata
+static __always_inline bool addr_has_metadata(const void *addr)
+{
+	return (kasan_mem_to_shadow((void *)addr) != NULL);
+}
+
 void kasan_init(void);
 asmlinkage void kasan_early_init(void);
 
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 3df5499f7936..842623d708c2 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -54,7 +54,7 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 int kasan_populate_early_shadow(const void *shadow_start,
 				const void *shadow_end);
 
-#ifndef __HAVE_ARCH_SHADOW_MAP
+#ifndef kasan_mem_to_shadow
 static inline void *kasan_mem_to_shadow(const void *addr)
 {
 	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index f70e3d7a602e..d37831b8511c 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -291,7 +291,7 @@ struct kasan_stack_ring {
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
-#ifndef __HAVE_ARCH_SHADOW_MAP
+#ifndef kasan_shadow_to_mem
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 {
 	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
@@ -299,15 +299,13 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 }
 #endif
 
+#ifndef addr_has_metadata
 static __always_inline bool addr_has_metadata(const void *addr)
 {
-#ifdef __HAVE_ARCH_SHADOW_MAP
-	return (kasan_mem_to_shadow((void *)addr) != NULL);
-#else
 	return (kasan_reset_tag(addr) >=
 		kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
-#endif
 }
+#endif
 
 /**
  * kasan_check_range - Check memory region, and report if invalid access.
-- 
2.39.3

