Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC91B7D7ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZCQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjJZCQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:16:48 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3CA18A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:16:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vuw8irE_1698286599;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0Vuw8irE_1698286599)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 10:16:43 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: tidy up redundant includes
Date:   Thu, 26 Oct 2023 10:16:27 +0800
Message-Id: <20231026021627.23284-2-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20231026021627.23284-1-mengferry@linux.alibaba.com>
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove unused includes like <linux/parser.h> and <linux/prefetch.h>;

- Move common includes into "internal.h".

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/data.c                 | 2 --
 fs/erofs/decompressor.c         | 1 -
 fs/erofs/decompressor_deflate.c | 1 -
 fs/erofs/decompressor_lzma.c    | 1 -
 fs/erofs/internal.h             | 2 ++
 fs/erofs/super.c                | 3 ---
 6 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0c2c99c58b5e..ceb6c248bf40 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,9 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "internal.h"
-#include <linux/prefetch.h>
 #include <linux/sched/mm.h>
-#include <linux/dax.h>
 #include <trace/events/erofs.h>
 
 void erofs_unmap_metabuf(struct erofs_buf *buf)
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 332ec5f74002..29d539481a2b 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -4,7 +4,6 @@
  *             https://www.huawei.com/
  */
 #include "compress.h"
-#include <linux/module.h>
 #include <linux/lz4.h>
 
 #ifndef LZ4_DISTANCE_MAX	/* history window size */
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 19e5bdeb30b6..c15ce24d51df 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-#include <linux/module.h>
 #include <linux/zlib.h>
 #include "compress.h"
 
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index dee10d22ada9..72a202740cdb 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <linux/xz.h>
-#include <linux/module.h>
 #include "compress.h"
 
 struct z_erofs_lzma {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ca7d85958450..3551a5734e89 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -8,8 +8,10 @@
 #define __EROFS_INTERNAL_H
 
 #include <linux/fs.h>
+#include <linux/dax.h>
 #include <linux/dcache.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/magic.h>
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 019229eb2ef6..f38ff2d63364 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -4,14 +4,11 @@
  *             https://www.huawei.com/
  * Copyright (C) 2021, Alibaba Cloud
  */
-#include <linux/module.h>
 #include <linux/statfs.h>
-#include <linux/parser.h>
 #include <linux/seq_file.h>
 #include <linux/crc32c.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
-#include <linux/dax.h>
 #include <linux/exportfs.h>
 #include "xattr.h"
 
-- 
2.19.1.6.gb485710b

