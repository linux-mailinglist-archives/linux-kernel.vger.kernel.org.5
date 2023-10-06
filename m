Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9540C7BBBA5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjJFPS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjJFPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:18:55 -0400
Received: from out-202.mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358D3D8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:18:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696605530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KpaY5zOxHzDnEKIsjBbAGIMHyxq37tXIib8836JShNo=;
        b=sdj54eOAoxvbDjsG1L1LrX4GPNkPYAmSqUqrEs0jwQ6Up2Z+kVeRFW4KN6fxPsOHGg6Ode
        5Mx5CSch4p7iY8TzDjBanPYp0/tbMZPIExkiILwYI/bFmaEJrBGJcxjKCCCm/iwBQn+1mb
        QLA2DRzBrErqtsGV7G6DB5s9bC3YhF4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 2/5] kasan: unify printk prefixes
Date:   Fri,  6 Oct 2023 17:18:43 +0200
Message-Id: <35589629806cf0840e5f01ec9d8011a7bad648df.1696605143.git.andreyknvl@google.com>
In-Reply-To: <cover.1696605143.git.andreyknvl@google.com>
References: <cover.1696605143.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Unify prefixes for printk messages in mm/kasan/.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan_test.c        | 2 +-
 mm/kasan/kasan_test_module.c | 2 +-
 mm/kasan/quarantine.c        | 4 +++-
 mm/kasan/report_generic.c    | 6 +++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index b61cc6a42541..c707d6c6e019 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -5,7 +5,7 @@
  * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
  */
 
-#define pr_fmt(fmt) "kasan_test: " fmt
+#define pr_fmt(fmt) "kasan: test: " fmt
 
 #include <kunit/test.h>
 #include <linux/bitops.h>
diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
index 7be7bed456ef..8b7b3ea2c74e 100644
--- a/mm/kasan/kasan_test_module.c
+++ b/mm/kasan/kasan_test_module.c
@@ -5,7 +5,7 @@
  * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
  */
 
-#define pr_fmt(fmt) "kasan test: %s " fmt, __func__
+#define pr_fmt(fmt) "kasan: test: " fmt
 
 #include <linux/mman.h>
 #include <linux/module.h>
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 152dca73f398..ca4529156735 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -8,6 +8,8 @@
  * Based on code by Dmitry Chernenkov.
  */
 
+#define pr_fmt(fmt) "kasan: " fmt
+
 #include <linux/gfp.h>
 #include <linux/hash.h>
 #include <linux/kernel.h>
@@ -414,7 +416,7 @@ static int __init kasan_cpu_quarantine_init(void)
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
 				kasan_cpu_online, kasan_cpu_offline);
 	if (ret < 0)
-		pr_err("kasan cpu quarantine register failed [%d]\n", ret);
+		pr_err("cpu quarantine register failed [%d]\n", ret);
 	return ret;
 }
 late_initcall(kasan_cpu_quarantine_init);
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 51a1e8a8877f..99cbcd73cff7 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -220,7 +220,7 @@ static bool __must_check tokenize_frame_descr(const char **frame_descr,
 		const size_t tok_len = sep - *frame_descr;
 
 		if (tok_len + 1 > max_tok_len) {
-			pr_err("KASAN internal error: frame description too long: %s\n",
+			pr_err("internal error: frame description too long: %s\n",
 			       *frame_descr);
 			return false;
 		}
@@ -233,7 +233,7 @@ static bool __must_check tokenize_frame_descr(const char **frame_descr,
 	*frame_descr = sep + 1;
 
 	if (value != NULL && kstrtoul(token, 10, value)) {
-		pr_err("KASAN internal error: not a valid number: %s\n", token);
+		pr_err("internal error: not a valid number: %s\n", token);
 		return false;
 	}
 
@@ -323,7 +323,7 @@ static bool __must_check get_address_stack_frame_info(const void *addr,
 
 	frame = (const unsigned long *)(mem_ptr + KASAN_GRANULE_SIZE);
 	if (frame[0] != KASAN_CURRENT_STACK_FRAME_MAGIC) {
-		pr_err("KASAN internal error: frame info validation failed; invalid marker: %lu\n",
+		pr_err("internal error: frame has invalid marker: %lu\n",
 		       frame[0]);
 		return false;
 	}
-- 
2.25.1

