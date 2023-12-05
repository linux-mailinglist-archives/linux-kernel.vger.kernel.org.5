Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96F804511
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376431AbjLECiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346389AbjLECiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:38:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621F184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:29:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF36C433C7;
        Tue,  5 Dec 2023 02:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701743348;
        bh=E477KEEpVfXYBLYCDBbDHRJITkivLWed5UVr6LwW/WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jngeDOXKER4A8iR1WtRk2Q+VSSXWfsEjUkLKHDo5gl9pr5B546BF+p4Ih9ogHv/gd
         3j69ZEx7YNQra9zB8utvELkTvedAI3ffNHroQG1gcpuQah3zv+sddfG/nNHJn9ou6S
         V0w2KF3S6nz+YbsqEFzG+OzOZhS4KVVv6Kn1osxhYFIOLBAbQcEh2xNbZeBSZMHLjN
         rmFPkmKu5dKkqh+PyAVPcNDF0TKhEyCuWIYnRSxwIjfg2tI9e/JnNNypV5nyWeHzks
         t4LyV4p1qOS8rNrGRHVZ64HFNT8LC3wuXLEBuNYV8ZZfKVtkbe2iA31eO8zza3RRqJ
         mwHIOcSmOtT0Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] samples: add proactive reclamation DAMON sample module
Date:   Tue,  5 Dec 2023 02:28:58 +0000
Message-Id: <20231205022858.1540-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205022858.1540-1-sj@kernel.org>
References: <20231205022858.1540-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sample DAMON application kernel module, namely damon_sample_prcl.
It is same to the one of the example kernel modules that presented at
kernel summit 2021 with 10 minutes live coding[1] but updated for the
latest DAMON interface.

The sample module receives a pid of a process to monitor the access,
monitors the access to the virtual address space of the process, find
regions that not accessed and proactively reclaim those using DAMOS.

[1] https://linuxplumbersconf.org/event/11/contributions/984/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/Kconfig             |  13 ++++
 samples/damon/Makefile            |   1 +
 samples/damon/damon_sample_prcl.c | 102 ++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 samples/damon/damon_sample_prcl.c

diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index f8b9a73717f9..459042ce5958 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -14,4 +14,17 @@ config SAMPLE_DAMON_WSSE
 
 	  If unsure, say N.
 
+config SAMPLE_DAMON_PRCL
+	tristate "DAMON sameple module for access-aware proactive reclamation"
+	depends on DAMON && DAMON_VADDR
+	help
+	  This builds DAMON sample module for access-aware proactive
+	  reclamation.
+
+	  The module receives pid of a process, monitor access to the virtual
+	  address space of the process, find memory regions that not accessed,
+	  and proactively reclaim the regions.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
index 1ace3ad4aff0..509f6a619dc4 100644
--- a/samples/damon/Makefile
+++ b/samples/damon/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SAMPLE_DAMON_WSSE) += damon_sample_wsse.o
+obj-$(CONFIG_SAMPLE_DAMON_PRCL) += damon_sample_prcl.o
diff --git a/samples/damon/damon_sample_prcl.c b/samples/damon/damon_sample_prcl.c
new file mode 100644
index 000000000000..487196f18864
--- /dev/null
+++ b/samples/damon/damon_sample_prcl.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * proactive reclamation: monitor access pattern of a given process, find
+ * regiosn that seems not accessed, and proactively page out the regions.
+ */
+
+#define pr_fmt(fmt) "damon_sample_prcl: " fmt
+
+#include <linux/damon.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static int target_pid __read_mostly;
+module_param(target_pid, int, 0600);
+
+static struct damon_ctx *ctx;
+static struct pid *target_pidp;
+
+static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+		unsigned long wss = 0;
+
+		damon_for_each_region(r, t) {
+			if (r->nr_accesses > 0)
+				wss += r->ar.end - r->ar.start;
+		}
+		pr_info("wss: %lu\n", wss);
+	}
+	return 0;
+}
+
+static int __init damon_sample_prcl_init(void)
+{
+	struct damon_target *target;
+	struct damos *scheme;
+
+	pr_info("Hello\n");
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return -ENOMEM;
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+
+	target = damon_new_target();
+	if (!target) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_add_target(ctx, target);
+	target_pidp = find_get_pid(target_pid);
+	if (!target_pidp) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+	target->pid = target_pidp;
+
+	ctx->callback.after_aggregation = damon_sample_prcl_after_aggregate;
+
+	scheme = damon_new_scheme(
+			&(struct damos_access_pattern) {
+			.min_sz_region = PAGE_SIZE,
+			.max_sz_region = ULONG_MAX,
+			.min_nr_accesses = 0,
+			.max_nr_accesses = 0},
+			DAMOS_PAGEOUT,
+			0,
+			&(struct damos_quota){},
+			&(struct damos_watermarks){});
+	if (!scheme) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_set_schemes(ctx, &scheme, 1);
+
+	return damon_start(&ctx, 1, true);
+}
+
+static void __exit damon_sample_prcl_exit(void)
+{
+	pr_info("Goodbye\n");
+	if (ctx) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	if (target_pidp)
+		put_pid(target_pidp);
+}
+
+module_init(damon_sample_prcl_init);
+module_exit(damon_sample_prcl_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("SeongJae Park");
+MODULE_DESCRIPTION("DAMON sample module for proactive reclamation");
-- 
2.34.1

