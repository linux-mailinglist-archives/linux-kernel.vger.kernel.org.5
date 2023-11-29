Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F87FE234
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjK2VoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjK2VoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:44:10 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6598
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:44:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so2603505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701294256; x=1701899056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaAuMlegGKyvqGQjlfSP0WNWjaMX9AyKOGu0wZi1ey8=;
        b=ZRHaUQr/OhRa+Y5Hr5/7hMYyVwTM82fLJ0KJiosAIrE+f5IQBzNQgt3nUELS7wzfod
         WWofr8vljKqCXoSyNuKpcACSpslBxcXU8JW9vaOfyEomESIVNnR7K1U5dmHTXRcunsIk
         jhBdhh4OFYvcKpw5NTyjQrlEyaa73k1PaQbvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294256; x=1701899056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaAuMlegGKyvqGQjlfSP0WNWjaMX9AyKOGu0wZi1ey8=;
        b=e85bdIj7LCzNJDpgWvQSpHqUat1IiNUngS6TiHZ7whi9s2msNK0AOhkecKMS523pqC
         ugnyxueETp/Shk59v/B44RU+u3ZVB62NcmWPG1kR7qerq6lHZtsBBV7ZlFK3hiIqDm2i
         o1F9g+gZjEw8emvq5Qj24pXrIDisL7t8nMqdyQkc5fPKtK9SjKDZN+4tNgEC5EMRkIU9
         4sAILBwWNgh4bDnO5qgT+M+f4/VFJjT7fgyhvmsSaIyFDt8E26PdIH8Pah19WXvLCPpZ
         YCNt85kyUMUHGa3tD9r5o3uelXo5C+w6HFHHYsZW/IJvl9OPUyhe294+opsbaH47YKWg
         E6UA==
X-Gm-Message-State: AOJu0YyGl0ii5pCMgMC9OPADaukJ4HRBIQd9PnzW8iIsIyfSuryUnTkB
        25ZHc2lMN4h4aTd/vgAr95Xmgg==
X-Google-Smtp-Source: AGHT+IGw9mcglXCfEIiIcMH/2PCnFrfP/7r764D4go315sp7mNqaJGFq+jVTw5facnm9yzjHe+0sZA==
X-Received: by 2002:a17:903:249:b0:1ce:64fb:e507 with SMTP id j9-20020a170903024900b001ce64fbe507mr23901888plh.27.1701294255812;
        Wed, 29 Nov 2023 13:44:15 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:d538:51cb:f23a:b78c])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b001cfcbeceacesm6793162plc.117.2023.11.29.13.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:44:15 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com
Subject: [PATCH v2] lkdtm: Add kfence read after free crash type
Date:   Wed, 29 Nov 2023 13:44:04 -0800
Message-ID: <20231129214413.3156334-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to allocate memory from kfence and trigger a read after
free on that memory to validate that kfence is working properly. This is
used by ChromeOS integration tests to validate that kfence errors can be
collected on user devices and parsed properly.

Cc: Alexander Potapenko <glider@google.com>
Acked-by: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <kasan-dev@googlegroups.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20231127234946.2514120-1-swboyd@chromium.org):
 * Removed ifdefs so code is always available but fails without kfence

 drivers/misc/lkdtm/heap.c | 60 +++++++++++++++++++++++++++++++++++++++
 include/linux/kfence.h    |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 0ce4cbf6abda..4f467d3972a6 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -4,6 +4,7 @@
  * page allocation and slab allocations.
  */
 #include "lkdtm.h"
+#include <linux/kfence.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
@@ -132,6 +133,64 @@ static void lkdtm_READ_AFTER_FREE(void)
 	kfree(val);
 }
 
+static void lkdtm_KFENCE_READ_AFTER_FREE(void)
+{
+	int *base, val, saw;
+	unsigned long timeout, resched_after;
+	size_t len = 1024;
+	/*
+	 * The slub allocator will use the either the first word or
+	 * the middle of the allocation to store the free pointer,
+	 * depending on configurations. Store in the second word to
+	 * avoid running into the freelist.
+	 */
+	size_t offset = sizeof(*base);
+
+	/*
+	 * 100x the sample interval should be more than enough to ensure we get
+	 * a KFENCE allocation eventually.
+	 */
+	timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
+	/*
+	 * Especially for non-preemption kernels, ensure the allocation-gate
+	 * timer can catch up: after @resched_after, every failed allocation
+	 * attempt yields, to ensure the allocation-gate timer is scheduled.
+	 */
+	resched_after = jiffies + msecs_to_jiffies(kfence_sample_interval);
+	do {
+		base = kmalloc(len, GFP_KERNEL);
+		if (!base) {
+			pr_err("FAIL: Unable to allocate kfence memory!\n");
+			return;
+		}
+
+		if (is_kfence_address(base)) {
+			val = 0x12345678;
+			base[offset] = val;
+			pr_info("Value in memory before free: %x\n", base[offset]);
+
+			kfree(base);
+
+			pr_info("Attempting bad read from freed memory\n");
+			saw = base[offset];
+			if (saw != val) {
+				/* Good! Poisoning happened, so declare a win. */
+				pr_info("Memory correctly poisoned (%x)\n", saw);
+			} else {
+				pr_err("FAIL: Memory was not poisoned!\n");
+				pr_expected_config_param(CONFIG_INIT_ON_FREE_DEFAULT_ON, "init_on_free");
+			}
+			return;
+		}
+
+		kfree(base);
+		if (time_after(jiffies, resched_after))
+			cond_resched();
+	} while (time_before(jiffies, timeout));
+
+	pr_err("FAIL: kfence memory never allocated!\n");
+}
+
 static void lkdtm_WRITE_BUDDY_AFTER_FREE(void)
 {
 	unsigned long p = __get_free_page(GFP_KERNEL);
@@ -327,6 +386,7 @@ static struct crashtype crashtypes[] = {
 	CRASHTYPE(VMALLOC_LINEAR_OVERFLOW),
 	CRASHTYPE(WRITE_AFTER_FREE),
 	CRASHTYPE(READ_AFTER_FREE),
+	CRASHTYPE(KFENCE_READ_AFTER_FREE),
 	CRASHTYPE(WRITE_BUDDY_AFTER_FREE),
 	CRASHTYPE(READ_BUDDY_AFTER_FREE),
 	CRASHTYPE(SLAB_INIT_ON_ALLOC),
diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 401af4757514..88100cc9caba 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -223,6 +223,8 @@ bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *sla
 
 #else /* CONFIG_KFENCE */
 
+#define kfence_sample_interval	(0)
+
 static inline bool is_kfence_address(const void *addr) { return false; }
 static inline void kfence_alloc_pool_and_metadata(void) { }
 static inline void kfence_init(void) { }

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
https://chromeos.dev

