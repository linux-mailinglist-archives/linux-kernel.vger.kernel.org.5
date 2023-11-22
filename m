Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4C7F547B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbjKVXZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbjKVXZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:25:35 -0500
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6286419D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:25:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhFyhh1rGVdN8KU7zA1YO/xWC9r61TLiUr+vYD/9YWg=;
        b=BHd1Y+nn87jfgs0JPV5W9mQnj/jbSljivlaWBWB01hjhj/kWczcqBvz5Z6L0HpvjZCtsmd
        /dVQdVskpae/TXe1lhJkyqwhQBEja9RxyeQj/qFWuwDRlz1zUC1oNymeFeLzQPPjOqHaw5
        +p/p0qYljzIyMnmljGtQZZIcQd8+3JE=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 5/7] mm: shrinker: Add shrinker_to_text() to debugfs interface
Date:   Wed, 22 Nov 2023 18:25:10 -0500
Message-ID: <20231122232515.177833-6-kent.overstreet@linux.dev>
In-Reply-To: <20231122232515.177833-1-kent.overstreet@linux.dev>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we added shrinker_to_text() and hooked it up to the OOM
report - now, the same report is available via debugfs.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/shrinker.h |  1 +
 mm/shrinker_debug.c      | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 497a7e8e348c..b8e57afabbcc 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -143,6 +143,7 @@ __printf(2, 3)
 struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
 void shrinker_register(struct shrinker *shrinker);
 void shrinker_free(struct shrinker *shrinker);
+void shrinker_to_text(struct seq_buf *, struct shrinker *);
 void shrinkers_to_text(struct seq_buf *);
 
 static inline bool shrinker_try_get(struct shrinker *shrinker)
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 12ea5486a3e9..39342aa9f4ca 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -2,6 +2,7 @@
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
+#include <linux/seq_buf.h>
 #include <linux/seq_file.h>
 #include <linux/shrinker.h>
 #include <linux/memcontrol.h>
@@ -159,6 +160,21 @@ static const struct file_operations shrinker_debugfs_scan_fops = {
 	.write	 = shrinker_debugfs_scan_write,
 };
 
+static int shrinker_debugfs_report_show(struct seq_file *m, void *v)
+{
+	struct shrinker *shrinker = m->private;
+	char *bufp;
+	size_t buflen = seq_get_buf(m, &bufp);
+	struct seq_buf out;
+
+	seq_buf_init(&out, bufp, buflen);
+	shrinker_to_text(&out, shrinker);
+	seq_commit(m, seq_buf_used(&out));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_report);
+
 int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	struct dentry *entry;
@@ -190,6 +206,8 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 			    &shrinker_debugfs_count_fops);
 	debugfs_create_file("scan", 0220, entry, shrinker,
 			    &shrinker_debugfs_scan_fops);
+	debugfs_create_file("report", 0440, entry, shrinker,
+			    &shrinker_debugfs_report_fops);
 	return 0;
 }
 
-- 
2.42.0

