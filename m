Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F86B752FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjGNDK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjGNDKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:10:45 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B530E2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:10:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnJxOQD_1689304236;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnJxOQD_1689304236)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 11:10:37 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [PATCH v4 2/2] erofs: boost negative xattr lookup with bloom filter
Date:   Fri, 14 Jul 2023 11:10:34 +0800
Message-Id: <20230714031034.53210-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230714031034.53210-1-jefflexu@linux.alibaba.com>
References: <20230714031034.53210-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimise the negative xattr lookup with bloom filter.

The bit value for the bloom filter map has a reverse semantics for
compatibility.  That is, the bit value of 0 indicates existence, while
the bit value of 1 indicates the absence of corresponding xattr.

This feature is enabled only when xattr_filter_reserved is non-zero.
The on-disk format for the filter map may change in the future, in which
case the reserved flag will be set non-zero and we don't need bothering
the compatible bits again at that time.  For now disable the optimization
if this reserved flag is non-zero.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/Kconfig    |  1 +
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    |  1 +
 fs/erofs/xattr.c    | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index f259d92c9720..f49669def828 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -38,6 +38,7 @@ config EROFS_FS_DEBUG
 config EROFS_FS_XATTR
 	bool "EROFS extended attributes"
 	depends on EROFS_FS
+	select XXHASH
 	default y
 	help
 	  Extended attributes are name:value pairs associated with inodes by
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 36e32fa542f0..ebcad25e3750 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -151,6 +151,7 @@ struct erofs_sb_info {
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
+	unsigned int xattr_filter_reserved;
 #endif
 	u16 device_id_mask;	/* valid bits of device id to be used */
 
@@ -251,6 +252,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
@@ -270,6 +272,7 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	unsigned int xattr_isize;
 
+	unsigned long xattr_name_filter;
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9d6a3c6158bd..72122323300e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -388,6 +388,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
 	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
+	sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 40178b6e0688..eb1d1974d4b3 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2022, Alibaba Cloud
  */
 #include <linux/security.h>
+#include <linux/xxhash.h>
 #include "xattr.h"
 
 struct erofs_xattr_iter {
@@ -87,6 +88,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	ih = it.kaddr + erofs_blkoff(sb, it.pos);
+	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
@@ -392,7 +394,10 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 		   void *buffer, size_t buffer_size)
 {
 	int ret;
+	uint32_t bit;
 	struct erofs_xattr_iter it;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!name)
 		return -EINVAL;
@@ -401,6 +406,14 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	if (ret)
 		return ret;
 
+	/* reserved flag is non-zero if there's any change of on-disk format */
+	if (erofs_sb_has_xattr_filter(sbi) && !sbi->xattr_filter_reserved) {
+		bit = xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index);
+		bit &= EROFS_XATTR_FILTER_BITS - 1;
+		if (test_bit(bit, &vi->xattr_name_filter))
+			return -ENOATTR;
+	}
+
 	it.index = index;
 	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
 	if (it.name.len > EROFS_NAME_LEN)
-- 
2.19.1.6.gb485710b

