Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C671753008
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjGNDim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjGNDij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:38:39 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA526B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:38:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnK9lEl_1689305913;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnK9lEl_1689305913)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 11:38:33 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, pratikshinde320@gmail.com
Subject: [PATCH] erofs: deprecate superblock checksum feature
Date:   Fri, 14 Jul 2023 11:38:32 +0800
Message-Id: <20230714033832.111740-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later we're going to introduce fs-verity based verification for the
whole image.  Make the superblock checksum feature deprecated.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/Kconfig |  1 -
 fs/erofs/super.c | 44 +++++---------------------------------------
 2 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index f259d92c9720..ebcb1f6a426a 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -4,7 +4,6 @@ config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
 	select FS_IOMAP
-	select LIBCRC32C
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
 	  file system with modern designs (e.g. no buffer heads, inline
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9d6a3c6158bd..bb6a966ac4d4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -8,7 +8,6 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
-#include <linux/crc32c.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/dax.h>
@@ -51,33 +50,6 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
-static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
-{
-	size_t len = 1 << EROFS_SB(sb)->blkszbits;
-	struct erofs_super_block *dsb;
-	u32 expected_crc, crc;
-
-	if (len > EROFS_SUPER_OFFSET)
-		len -= EROFS_SUPER_OFFSET;
-
-	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET, len, GFP_KERNEL);
-	if (!dsb)
-		return -ENOMEM;
-
-	expected_crc = le32_to_cpu(dsb->checksum);
-	dsb->checksum = 0;
-	/* to allow for x86 boot sectors and other oddities. */
-	crc = crc32c(~0, dsb, len);
-	kfree(dsb);
-
-	if (crc != expected_crc) {
-		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
-			  crc, expected_crc);
-		return -EBADMSG;
-	}
-	return 0;
-}
-
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -113,15 +85,16 @@ static void erofs_free_inode(struct inode *inode)
 static bool check_layout_compatibility(struct super_block *sb,
 				       struct erofs_super_block *dsb)
 {
-	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	EROFS_SB(sb)->feature_incompat = feature;
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
+	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
 
 	/* check if current kernel meets all mandatory requirements */
-	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+	if (sbi->feature_incompat & (~EROFS_ALL_FEATURE_INCOMPAT)) {
 		erofs_err(sb,
 			  "unidentified incompatible feature %x, please upgrade kernel version",
-			   feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+			   sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT);
 		return false;
 	}
 	return true;
@@ -365,13 +338,6 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
-	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
-	if (erofs_sb_has_sb_chksum(sbi)) {
-		ret = erofs_superblock_csum_verify(sb, data);
-		if (ret)
-			goto out;
-	}
-
 	ret = -EINVAL;
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
-- 
2.19.1.6.gb485710b

