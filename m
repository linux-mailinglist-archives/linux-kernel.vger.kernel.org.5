Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA387FAEB1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjK0Xtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0Xtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:49:43 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC7187
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:49:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-285d1101868so1319034a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701128989; x=1701733789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBWO3qiHF6ynp4gh0IQevir8rNrrtCuaI4IulQnqpxU=;
        b=jWGXuJyClHrovUM/4hf7mFPd3RX//FI2/268BwbQxQXxYreokr6F1GsLWoJj5gWWgJ
         daJ0OFveHUqD+oaO0FZPJsEvO2KvAFsDXyB7SR3FeHxeLmsUB3P0qQ6L8xij9L9d+/Z7
         oxdf/ROn5yBRsVkcQnMyaprLf9+F8XdCZUakY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701128989; x=1701733789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBWO3qiHF6ynp4gh0IQevir8rNrrtCuaI4IulQnqpxU=;
        b=N+e3vDe049bUsGptf2wDOK0Vk18dUezVTymujSeK+RCqZ3juKq4+i+YS5KKUm3QEFG
         LzSUIDfM9ZVF9NAP4AMcZzp3IPXH3OiuSrZXPGpNY7YhIXe6pFomNlWwVMgj29Kf2UM/
         K97CPea22xmA5irt4t0JtSgJvCy+fscj2Df+xSC0UEi56QEZpenMyvC2OYrCPldnTNt6
         USPGXgYchEt/M11i7xZ1n+6ENgQ3ng9qqMxDP+T6c5+aiaKtNg1dhhX7LkjyWRBqRnAj
         hRfeOveD37XtRR8BGLRkJrXGmDujIsvEFqf7NMjKbl2z0wpw/ICtRxt0fh8mU4Bee8N4
         r8BQ==
X-Gm-Message-State: AOJu0YyOhlUnRnkX5vG7YYkrhPtq6C7Zxpa1Czbwdga3ww52OXkrwZin
        wN/nKQ4VCjist3FTaw+/6CkqcoCI5eVEDJv+/50=
X-Google-Smtp-Source: AGHT+IFiK1TL6iRqDxnEarhUDv5XQ6c1bUCpPYgE2MBOLdZUHwEMQYstZPZ9fZDxk9Gf4SGi+drnNQ==
X-Received: by 2002:a17:90b:3807:b0:285:e16c:fb0a with SMTP id mq7-20020a17090b380700b00285e16cfb0amr3227082pjb.4.1701128988683;
        Mon, 27 Nov 2023 15:49:48 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:6438:b5d1:198e:8bb0])
        by smtp.gmail.com with ESMTPSA id cu20-20020a17090afa9400b00282ecb631a9sm7860556pjb.25.2023.11.27.15.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:49:48 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] lkdtm: Add kfence read after free crash type
Date:   Mon, 27 Nov 2023 15:49:45 -0800
Message-ID: <20231127234946.2514120-1-swboyd@chromium.org>
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

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/misc/lkdtm/heap.c | 64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 0ce4cbf6abda..608872bcc7e0 100644
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
@@ -132,6 +133,66 @@ static void lkdtm_READ_AFTER_FREE(void)
 	kfree(val);
 }
 
+#if IS_ENABLED(CONFIG_KFENCE)
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
+#endif
+
 static void lkdtm_WRITE_BUDDY_AFTER_FREE(void)
 {
 	unsigned long p = __get_free_page(GFP_KERNEL);
@@ -327,6 +388,9 @@ static struct crashtype crashtypes[] = {
 	CRASHTYPE(VMALLOC_LINEAR_OVERFLOW),
 	CRASHTYPE(WRITE_AFTER_FREE),
 	CRASHTYPE(READ_AFTER_FREE),
+#if IS_ENABLED(CONFIG_KFENCE)
+	CRASHTYPE(KFENCE_READ_AFTER_FREE),
+#endif
 	CRASHTYPE(WRITE_BUDDY_AFTER_FREE),
 	CRASHTYPE(READ_BUDDY_AFTER_FREE),
 	CRASHTYPE(SLAB_INIT_ON_ALLOC),
-- 
https://chromeos.dev

