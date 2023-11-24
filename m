Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52F7F79F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjKXRBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjKXRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:00:25 -0500
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D3719BB;
        Fri, 24 Nov 2023 09:00:26 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700845224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H2EngB4IC7J9sBiro1fbNUKQKRJyLxYEzCizNHIL5o=;
        b=Vz45gGWBhO5z+XKwoOw0E6D48Hta7AOYAEttidaa3w/z4W5sITlJaeXjSXd85Nt+hl3kCU
        aTXHFwqMqwV7hj0k8jUi9LEvpxFLXXr4H0TTC/BuUMrA9KKE5gAvN0U8zPgoak0/Y9qGD0
        EHNGghNq4QYnKjn5s5T4+I7bOJV0p9k=
From:   Sergei Shtepa <sergei.shtepa@linux.dev>
To:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v6 10/11] blksnap: Kconfig and Makefile
Date:   Fri, 24 Nov 2023 17:59:32 +0100
Message-Id: <20231124165933.27580-11-sergei.shtepa@linux.dev>
In-Reply-To: <20231124165933.27580-1-sergei.shtepa@linux.dev>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtepa <sergei.shtepa@veeam.com>

Allows to build a module and add the blksnap to the kernel tree.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/Kconfig          |  2 ++
 drivers/block/Makefile         |  2 ++
 drivers/block/blksnap/Kconfig  | 31 +++++++++++++++++++++++++++++++
 drivers/block/blksnap/Makefile | 15 +++++++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 drivers/block/blksnap/Kconfig
 create mode 100644 drivers/block/blksnap/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..74d2d55526a3 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -404,4 +404,6 @@ config BLKDEV_UBLK_LEGACY_OPCODES
 
 source "drivers/block/rnbd/Kconfig"
 
+source "drivers/block/blksnap/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..9a2a9a56a247 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -40,3 +40,5 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 
 swim_mod-y	:= swim.o swim_asm.o
+
+obj-$(CONFIG_BLKSNAP) += blksnap/
diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
new file mode 100644
index 000000000000..f52272c12e1b
--- /dev/null
+++ b/drivers/block/blksnap/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Block device snapshot module configuration
+#
+
+config BLKSNAP
+	tristate "Block Devices Snapshots Module (blksnap)"
+	help
+	  Allow to create snapshots and track block changes for block devices.
+	  Designed for creating backups for block devices. Snapshots are
+	  temporary and are released when backup is completed. Change block
+	  tracking allows to create incremental or differential backups.
+
+config BLKSNAP_DIFF_BLKDEV
+	bool "Use an optimized algorithm to store difference on a block device"
+	depends on BLKSNAP
+	default y
+	help
+	  The difference storage for a snapshot can be a regular file or a
+	  block device. We can work with a block device through the interface
+	  of a regular file. However, direct management of I/O units should
+	  allow for higher performance.
+
+config BLKSNAP_CHUNK_DIFF_BIO_SYNC
+	bool "Use a synchronous I/O unit processing algorithm for the snapshot image"
+	depends on BLKSNAP
+	default n
+	help
+	  Theoretical asynchronous algorithm for processing I/O units should
+	  have higher performance. However, an attempt to confirm this on test
+	  runs did not bring any results.
diff --git a/drivers/block/blksnap/Makefile b/drivers/block/blksnap/Makefile
new file mode 100644
index 000000000000..8d528b95579a
--- /dev/null
+++ b/drivers/block/blksnap/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+blksnap-y := 		\
+	cbt_map.o	\
+	chunk.o		\
+	diff_area.o	\
+	diff_buffer.o	\
+	diff_storage.o	\
+	event_queue.o	\
+	main.o		\
+	snapimage.o	\
+	snapshot.o	\
+	tracker.o
+
+obj-$(CONFIG_BLKSNAP)	 += blksnap.o
-- 
2.20.1

