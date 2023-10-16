Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6437CB3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjJPUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:09:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8643C83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:09:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8126CC433C8;
        Mon, 16 Oct 2023 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697486973;
        bh=RpFwpEjjw4hJ7B1Z4cK20onhtIjTiNBnDbHOS4Sy1JE=;
        h=From:To:Cc:Subject:Date:From;
        b=oWcP2frNFRtqkU/QYvUgGpWLjWYPq0lsoHhihsZ1pOUX6Cr16FU6g+uKDzgIlYX3V
         09KzDJxwrhdlo3/I/9/JJJIiWp0XKjlIhY5auTT7g4PeKHjIZLAdhk51KN/1cvECG1
         9iYjs4hxQCqNFZuAexRg/8dZHQEC1kJb+dDsLu2SYNTDOFjrQL+Sb+HkL4aHhv1+nG
         0zvLGTIQ/Vi/PTqJ+C3tQzPlkxibOk9++gXWlCDt0wwFPau/aKF8SoZADD44RmQJBY
         QuvTAn1Lk9lns/PNLOnjMDvakyGN4CebvOPL50wFy2Lx+6TeJ7LYRMAhJTK6f3G6yQ
         H9Nj7nV8TJSAg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Haibo Li <haibo.li@mediatek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] kasan: disable kasan_non_canonical_hook() for HW tags
Date:   Mon, 16 Oct 2023 22:08:38 +0200
Message-Id: <20231016200925.984439-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

On arm64, building with CONFIG_KASAN_HW_TAGS now causes a compile-time
error:

mm/kasan/report.c: In function 'kasan_non_canonical_hook':
mm/kasan/report.c:637:20: error: 'KASAN_SHADOW_OFFSET' undeclared (first use in this function)
  637 |         if (addr < KASAN_SHADOW_OFFSET)
      |                    ^~~~~~~~~~~~~~~~~~~
mm/kasan/report.c:637:20: note: each undeclared identifier is reported only once for each function it appears in
mm/kasan/report.c:640:77: error: expected expression before ';' token
  640 |         orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;

This was caused by removing the dependency on CONFIG_KASAN_INLINE that
used to prevent this from happening. Use the more specific dependency
on KASAN_SW_TAGS || KASAN_GENERIC to only ignore the function for hwasan
mode.

Fixes: 12ec6a919b0f ("kasan: print the original fault addr when access invalid shadow")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It looks like the comment above the function needs to be adjusted
as well, and it's possible we should still provide it even for
hwasan but fix it in a different way.

I saw this a few days ago but didn't actually send the patch right away, so there
is a good chance that someone has already produced a better patch, just ignore
my report in that case.
---
 include/linux/kasan.h | 6 +++---
 mm/kasan/report.c     | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 485452e8cc0dc..72cb693b075b7 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -468,10 +468,10 @@ static inline void kasan_free_module_shadow(const struct vm_struct *vm) {}
 
 #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 void kasan_non_canonical_hook(unsigned long addr);
-#else /* CONFIG_KASAN */
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 static inline void kasan_non_canonical_hook(unsigned long addr) { }
-#endif /* CONFIG_KASAN */
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b738be3b6e5cc..e77facb629007 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -621,8 +621,9 @@ void kasan_report_async(void)
 }
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 /*
- * With CONFIG_KASAN, accesses to bogus pointers (outside the high
+ * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
  * before the actual access. For addresses in the low canonical half of the
  * address space, as well as most non-canonical addresses, that out-of-bounds
@@ -658,3 +659,4 @@ void kasan_non_canonical_hook(unsigned long addr)
 	pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
 		 orig_addr, orig_addr + KASAN_GRANULE_SIZE - 1);
 }
+#endif
-- 
2.39.2

