Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933B68044E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376368AbjLEC37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346419AbjLEC3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:29:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2C127
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:29:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7EEC433C7;
        Tue,  5 Dec 2023 02:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701743347;
        bh=ZeGpXOS+wd63sq2lkChRaopNGfsPvBCMhfOksZfRY9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOwMnIXZYJDQI1HCnzULsLA0qvMK46eLCyBuzxRAQ6Eg5fnT+Bu5C5oDT7TdjE7y5
         YaJTK/X0+IlM557gdEGgjHVbmFQeG31hFfb5Xgq3bWipkdAyprSD3cg8KC4ExBtIm9
         67SJizuZmmS5SZSAqzTXjHvccTBV0FMQ3Kmf5OaV4cLgHq3axODascmXu22QuKfjb+
         MHja/A2oBVUWaxLthN3+mn1B184NYu0+zaQ7PKXl9ofdxY+74fph6BlZIxV7AwG2vp
         IKWJ1HTJtl+Up9qgi4EhVkOAeMreCh0DBnL41QsKvj/A43N/nyjM64YhDuZ4q75Zvv
         U4i5KBTX3I5sw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] samples: add working set size estimation DAMON sample module
Date:   Tue,  5 Dec 2023 02:28:57 +0000
Message-Id: <20231205022858.1540-3-sj@kernel.org>
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

Add a sample DAMON application kernel module, namely damon_sample_wsse.
It is same to the one of the example kernel modules that presented at
kernel summit 2021 with 10 minutes live coding[1] but updated for the
latest DAMON interface.

The sample module receives a pid of a process to monitor the access,
monitors the access to the virtual address space of the process,
calculate estimated working set size, and repeatedly print it on the
kernel log.

[1] https://linuxplumbersconf.org/event/11/contributions/984/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS                       |  1 +
 samples/Kconfig                   |  2 +
 samples/Makefile                  |  2 +
 samples/damon/Kconfig             | 17 +++++++
 samples/damon/Makefile            |  2 +
 samples/damon/damon_sample_wsse.c | 85 +++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/damon_sample_wsse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d1fcae09c910..5a44258810ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5764,6 +5764,7 @@ F:	Documentation/mm/damon/
 F:	include/linux/damon.h
 F:	include/trace/events/damon.h
 F:	mm/damon/
+F:	samples/damon/
 F:	tools/testing/selftests/damon/
 
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..8d5a36f0e5d6 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -293,6 +293,8 @@ config SAMPLE_CGROUP
 
 source "samples/rust/Kconfig"
 
+source "samples/damon/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..5af6bb8afb07 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -39,3 +39,5 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
+obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
+obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
new file mode 100644
index 000000000000..f8b9a73717f9
--- /dev/null
+++ b/samples/damon/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "DAMON Samples"
+
+config SAMPLE_DAMON_WSSE
+	tristate "DAMON sameple module for working set size estimation"
+	depends on DAMON && DAMON_VADDR
+	help
+	  This builds DAMON sample module for working set size estimation.
+
+	  The module receives pid of a process, monitor access to the virtual
+	  address space of the process, calculate the estimated working set
+	  size of the process, and repeatedly print the size on the kernel log.
+
+	  If unsure, say N.
+
+endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
new file mode 100644
index 000000000000..1ace3ad4aff0
--- /dev/null
+++ b/samples/damon/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SAMPLE_DAMON_WSSE) += damon_sample_wsse.o
diff --git a/samples/damon/damon_sample_wsse.c b/samples/damon/damon_sample_wsse.c
new file mode 100644
index 000000000000..897e6b136a1a
--- /dev/null
+++ b/samples/damon/damon_sample_wsse.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * working set size estimation: monitor access pattern of given process and
+ * print estimated working set size (total size of regions that showing some
+ * access).
+ */
+
+#define pr_fmt(fmt) "damon_sample_wsse: " fmt
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
+static int damon_sample_wsse_after_aggregate(struct damon_ctx *c)
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
+static int __init damon_sample_wsse_init(void)
+{
+	struct damon_target *target;
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
+	ctx->callback.after_aggregation = damon_sample_wsse_after_aggregate;
+	return damon_start(&ctx, 1, true);
+}
+
+static void __exit damon_sample_wsse_exit(void)
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
+module_init(damon_sample_wsse_init);
+module_exit(damon_sample_wsse_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("SeongJae Park");
+MODULE_DESCRIPTION("DAMON sample module for working set size estimation");
-- 
2.34.1

