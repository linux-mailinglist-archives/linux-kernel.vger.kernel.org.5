Return-Path: <linux-kernel+bounces-22019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D82E829803
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643521C21CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB547F52;
	Wed, 10 Jan 2024 10:49:53 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084047A6F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp72t1704883746tldabub3
Received: from ubuntu1.. ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jan 2024 18:49:04 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: U4uNK7LTfdqXYB2ToMtJLJ8+FJ8X+0ubq/JvtvJPoyrv7YmBWN6qqiKxSdBXd
	IT2aGPQ5BL4kdR8KXdvkjNASv50uYGfhnhM/7oqOondEo7XPMWdwg2Arx3WCFheQWfv+RUA
	y+mFM28hPPNoDB/Y4OB8TpJ8Es6huXwhlG+IxT0TSgfzYDx9fzfX5j3JI3Kq61XeAKkfKDb
	ND4xTPAfCuZWEjwYSJmUdz8v8pszn2pq9u96/8z+qIk47qwZ2nhcOPMpDgfnFA8ebQCQO0E
	AUIYbkNQNeYgslkv7qTDVR7DSAb+G+9ct9w4lUAdASph8Y+tYisM2O0LwONCX3MHaItcRmT
	wuCyFd5h26gwQADdgjob610BDTWBjQzTh6PNbEM
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13203849688828320885
From: Song Shuai <songshuaishuai@tinylab.org>
To: peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	songshuaishuai@tinylab.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] static_call: make selftest available for out-of-line SC
Date: Wed, 10 Jan 2024 18:48:54 +0800
Message-Id: <20240110104854.292752-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-2

Static call selftest should be built once HAVE_STATIC_CALL is configured.
but it's now bonded with HAVE_STATIC_CALL_INLINE.

Move selftest to static_call.c making it available for out-of-line SC.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kernel/static_call.c        | 44 +++++++++++++++++++++++++++++++++++++
 kernel/static_call_inline.c | 42 -----------------------------------
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index e9c3e69f3837..b1e1b4573201 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -1,8 +1,52 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/static_call.h>
+#include <linux/init.h>
 
 long __static_call_return0(void)
 {
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__static_call_return0);
+
+#ifdef CONFIG_STATIC_CALL_SELFTEST
+
+static int func_a(int x)
+{
+	return x+1;
+}
+
+static int func_b(int x)
+{
+	return x+2;
+}
+
+DEFINE_STATIC_CALL(sc_selftest, func_a);
+
+static struct static_call_data {
+      int (*func)(int);
+      int val;
+      int expect;
+} static_call_data [] __initdata = {
+      { NULL,   2, 3 },
+      { func_b, 2, 4 },
+      { func_a, 2, 3 }
+};
+
+static int __init test_static_call_init(void)
+{
+      int i;
+
+      for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
+	      struct static_call_data *scd = &static_call_data[i];
+
+              if (scd->func)
+                      static_call_update(sc_selftest, scd->func);
+
+              WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
+      }
+
+      return 0;
+}
+early_initcall(test_static_call_init);
+
+#endif /* CONFIG_STATIC_CALL_SELFTEST */
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 639397b5491c..3e65bfafe559 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -512,45 +512,3 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
-#ifdef CONFIG_STATIC_CALL_SELFTEST
-
-static int func_a(int x)
-{
-	return x+1;
-}
-
-static int func_b(int x)
-{
-	return x+2;
-}
-
-DEFINE_STATIC_CALL(sc_selftest, func_a);
-
-static struct static_call_data {
-      int (*func)(int);
-      int val;
-      int expect;
-} static_call_data [] __initdata = {
-      { NULL,   2, 3 },
-      { func_b, 2, 4 },
-      { func_a, 2, 3 }
-};
-
-static int __init test_static_call_init(void)
-{
-      int i;
-
-      for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
-	      struct static_call_data *scd = &static_call_data[i];
-
-              if (scd->func)
-                      static_call_update(sc_selftest, scd->func);
-
-              WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
-      }
-
-      return 0;
-}
-early_initcall(test_static_call_init);
-
-#endif /* CONFIG_STATIC_CALL_SELFTEST */
-- 
2.39.2


