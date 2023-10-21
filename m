Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446557D1A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 04:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJUCBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 22:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjJUCBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 22:01:47 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC32D7F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 19:01:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VuYG-.I_1697853700;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VuYG-.I_1697853700)
          by smtp.aliyun-inc.com;
          Sat, 21 Oct 2023 10:01:41 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: don't warn MicroLZMA format anymore
Date:   Sat, 21 Oct 2023 10:01:37 +0800
Message-Id: <20231021020137.1646959-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LZMA algorithm support has been landed for more than one year since
Linux 5.16.  Besides, the new XZ Utils 5.4 has been available in most
Linux distributions.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig             | 7 ++-----
 fs/erofs/decompressor_lzma.c | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index f6dc961e6c2b..e540648dedc2 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -91,13 +91,10 @@ config EROFS_FS_ZIP_LZMA
 	select XZ_DEC_MICROLZMA
 	help
 	  Saying Y here includes support for reading EROFS file systems
-	  containing LZMA compressed data, specifically called microLZMA. it
-	  gives better compression ratios than the LZ4 algorithm, at the
+	  containing LZMA compressed data, specifically called microLZMA. It
+	  gives better compression ratios than the default LZ4 format, at the
 	  expense of more CPU overhead.
 
-	  LZMA support is an experimental feature for now and so most file
-	  systems will be readable without selecting this option.
-
 	  If unsure, say N.
 
 config EROFS_FS_ZIP_DEFLATE
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index ba4ec73f4aae..852dd8eac5df 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -96,8 +96,6 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 		return -EINVAL;
 	}
 
-	erofs_info(sb, "EXPERIMENTAL MicroLZMA in use. Use at your own risk!");
-
 	/* in case 2 z_erofs_load_lzma_config() race to avoid deadlock */
 	mutex_lock(&lzma_resize_mutex);
 
-- 
2.39.3

