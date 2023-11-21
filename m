Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0556F7F2559
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjKUFgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjKUFg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:36:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07832D7B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:36:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AFDC433CC;
        Tue, 21 Nov 2023 05:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700544976;
        bh=xeB5Q/0nCB1T8mGIogEvXwiHT5yYGJPGjYRZafQD3vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRqUqenpLitbMJv0BlMtg1ANbPQdVT7r8XE2BBmQvFEbs0CRkYq0X8FWuePv05Ssh
         zZMUKayZf5fuJpRq0xuuw+UDavlWbGYYMIlttP9kxAKic+0yazEGZwtIQC4U+gcS0T
         l8oA8ZFf+XFQGdlpPlkzZqZNJIT5+9eTLr9C1tKglZZTvjAgKWvxZX+8ntE2TjPc/b
         bUb3wn7Hp4IsOKdHMZ+Vd3LjLC8DARb0mZj3k0ZRWcSKzukE+8NWFlsuF8ohrLovPc
         OpMI+7hDqmDnMN9hAznF+p2jw/uQ+VdkUt4CCfUkcSlTQvS7xblyFDBVM9WX6OEQwK
         jkVNLt1do6gUA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] samples: add DAMON sample kernel modules
Date:   Tue, 21 Nov 2023 05:36:03 +0000
Message-Id: <20231121053604.60798-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121053604.60798-1-sj@kernel.org>
References: <20231121053604.60798-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sample DAMON application kernel modules that same to the example
kernel modules that presented at kernel summit 2021 with 10 minutes live
coding[1] but updated for the latest DAMON interface.

Specifically, add two sample modules, namely damon_sample_wsse and
damon_sample_prcl.  'damon_sample_wsse' receives a pid of a process to
monitor the access, monitors the access to the virtual address space of
the process, calculate estimated working set size, and repeatedly print
it on the kernel log.  'damon_sample_prcl' is similar to
'damon_sample_wsse', but find regions that not accessed and proactively
reclaim those using DAMOS.

[1] https://linuxplumbersconf.org/event/11/contributions/984/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS                       |  1 +
 samples/Kconfig                   |  2 +
 samples/Makefile                  |  2 +
 samples/damon/Kconfig             | 30 ++++++++++
 samples/damon/Makefile            |  3 +
 samples/damon/damon_sample_prcl.c | 98 +++++++++++++++++++++++++++++++
 samples/damon/damon_sample_wsse.c | 80 +++++++++++++++++++++++++
 7 files changed, 216 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/damon_sample_prcl.c
 create mode 100644 samples/damon/damon_sample_wsse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eedc85a013b..3ee99307229a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5781,6 +5781,7 @@ F:	Documentation/mm/damon/
 F:	include/linux/damon.h
 F:	include/trace/events/damon.h
 F:	mm/damon/
+F:	samples/damon/
 F:	tools/testing/selftests/damon/
 
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
diff --git a/samples/Kconfig b/samples/Kconfig
index b0ddf5f36738..1e3f1b33b3d8 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -287,6 +287,8 @@ config SAMPLE_KMEMLEAK
 
 source "samples/rust/Kconfig"
 
+source "samples/damon/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index 0a551c2b33f4..ae863e7c5250 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -38,3 +38,5 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
+obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
+obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
new file mode 100644
index 000000000000..459042ce5958
--- /dev/null
+++ b/samples/damon/Kconfig
@@ -0,0 +1,30 @@
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
+endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
new file mode 100644
index 000000000000..df102e8c2b7b
--- /dev/null
+++ b/samples/damon/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SAMPLE_DAMON_WSSE) += damon_sample_wsse.o
+obj-$(CONFIG_SAMPLE_DAMON_PRCL) += damon_sample_prcl.o
diff --git a/samples/damon/damon_sample_prcl.c b/samples/damon/damon_sample_prcl.c
new file mode 100644
index 000000000000..962b3309e490
--- /dev/null
+++ b/samples/damon/damon_sample_prcl.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
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
diff --git a/samples/damon/damon_sample_wsse.c b/samples/damon/damon_sample_wsse.c
new file mode 100644
index 000000000000..7bfbd2bf56aa
--- /dev/null
+++ b/samples/damon/damon_sample_wsse.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
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

