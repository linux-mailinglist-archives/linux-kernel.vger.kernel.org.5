Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC98978B292
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjH1OE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjH1OEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695DBF7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2FA0648DD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47734C433C8;
        Mon, 28 Aug 2023 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693231465;
        bh=dz5WGcW0XCq5mKyveB9Rm7v1wiY2CcHMtPUPvLN0ics=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kT2hxGEFWQ4knn471dORoGRgGx7B1WliZz9InbbM6YqXTYfT+r5XfZGWbcDjrOON9
         CmsU/+aclugRcXJ6zi6FgLwZ205PSTLokiyRx/rvpcdSrOdbRraEl3OEWZdWiUjdcx
         1W+MZc04wniOfJqrqA+m90CygGjkVrLcd4uizLPv8/bqFoY9YdhdviIKY5OHwk97S8
         Dsfy3QZmALv6+0IZ7FWDNWsSVsStZcq1S6E6vC8BAscmuua1XR4DII/grLfRB89H+b
         I9f1rLeTirBXy1Q2xCqmIs1JSeJ8sQEZAKNNhvaUBJZN7b4RuinK0rDgI9urTKSh5L
         zdjVybXCZS+6g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] f2fs: compress: do sanity check on cluster when CONFIG_F2FS_CHECK_FS is on
Date:   Mon, 28 Aug 2023 22:04:16 +0800
Message-Id: <20230828140417.2951796-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828140417.2951796-1-chao@kernel.org>
References: <20230828140417.2951796-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch covers sanity check logic on cluster w/ CONFIG_F2FS_CHECK_FS,
otherwise, there will be performance regression while querying cluster
mapping info.

Callers of f2fs_is_compressed_cluster() only care about whether cluster
is compressed or not, rather than # of valid blocks in compressed cluster,
so, let's adjust f2fs_is_compressed_cluster()'s logic according to
caller's requirement.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 61 ++++++++++++++++++++++++++--------------------
 fs/f2fs/data.c     |  4 +--
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 9662d635efbe..1828239cef0a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -893,14 +893,15 @@ static bool cluster_has_invalid_data(struct compress_ctx *cc)
 
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
 {
+#ifdef CONFIG_F2FS_CHECK_FS
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	unsigned int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
-	bool compressed = dn->data_blkaddr == COMPRESS_ADDR;
 	int cluster_end = 0;
+	unsigned int count;
 	int i;
 	char *reason = "";
 
-	if (!compressed)
+	if (dn->data_blkaddr != COMPRESS_ADDR)
 		return false;
 
 	/* [..., COMPR_ADDR, ...] */
@@ -909,7 +910,7 @@ bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
 		goto out;
 	}
 
-	for (i = 1; i < cluster_size; i++) {
+	for (i = 1, count = 1; i < cluster_size; i++, count++) {
 		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
 							dn->ofs_in_node + i);
 
@@ -929,19 +930,42 @@ bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
 			goto out;
 		}
 	}
+
+	f2fs_bug_on(F2FS_I_SB(dn->inode), count != cluster_size &&
+		!is_inode_flag_set(dn->inode, FI_COMPRESS_RELEASED));
+
 	return false;
 out:
 	f2fs_warn(sbi, "access invalid cluster, ino:%lu, nid:%u, ofs_in_node:%u, reason:%s",
 			dn->inode->i_ino, dn->nid, dn->ofs_in_node, reason);
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
 	return true;
+#else
+	return false;
+#endif
+}
+
+static int __f2fs_get_cluster_blocks(struct inode *inode,
+					struct dnode_of_data *dn)
+{
+	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
+	int count, i;
+
+	for (i = 1, count = 1; i < cluster_size; i++) {
+		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
+							dn->ofs_in_node + i);
+
+		if (__is_valid_data_blkaddr(blkaddr))
+			count++;
+	}
+
+	return count;
 }
 
 static int __f2fs_cluster_blocks(struct inode *inode,
-				unsigned int cluster_idx, bool compr)
+				unsigned int cluster_idx, bool compr_blks)
 {
 	struct dnode_of_data dn;
-	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
 	unsigned int start_idx = cluster_idx <<
 				F2FS_I(inode)->i_log_cluster_size;
 	int ret;
@@ -956,31 +980,14 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 
 	if (f2fs_sanity_check_cluster(&dn)) {
 		ret = -EFSCORRUPTED;
-		f2fs_handle_error(F2FS_I_SB(inode), ERROR_CORRUPTED_CLUSTER);
 		goto fail;
 	}
 
 	if (dn.data_blkaddr == COMPRESS_ADDR) {
-		int i;
-
-		ret = 1;
-		for (i = 1; i < cluster_size; i++) {
-			block_t blkaddr;
-
-			blkaddr = data_blkaddr(dn.inode,
-					dn.node_page, dn.ofs_in_node + i);
-			if (compr) {
-				if (__is_valid_data_blkaddr(blkaddr))
-					ret++;
-			} else {
-				if (blkaddr != NULL_ADDR)
-					ret++;
-			}
-		}
-
-		f2fs_bug_on(F2FS_I_SB(inode),
-			!compr && ret != cluster_size &&
-			!is_inode_flag_set(inode, FI_COMPRESS_RELEASED));
+		if (compr_blks)
+			ret = __f2fs_get_cluster_blocks(inode, &dn);
+		else
+			ret = 1;
 	}
 fail:
 	f2fs_put_dnode(&dn);
@@ -993,7 +1000,7 @@ static int f2fs_compressed_blocks(struct compress_ctx *cc)
 	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, true);
 }
 
-/* return # of valid blocks in compressed cluster */
+/* return whether cluster is compressed one or not */
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 {
 	return __f2fs_cluster_blocks(inode,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1ac34eb49a0e..cd9cedc35d7f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1690,9 +1690,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 			map->m_flags |= F2FS_MAP_NEW;
 	} else if (is_hole) {
 		if (f2fs_compressed_file(inode) &&
-		    f2fs_sanity_check_cluster(&dn) &&
-		    (flag != F2FS_GET_BLOCK_FIEMAP ||
-		     IS_ENABLED(CONFIG_F2FS_CHECK_FS))) {
+		    f2fs_sanity_check_cluster(&dn)) {
 			err = -EFSCORRUPTED;
 			f2fs_handle_error(sbi,
 					ERROR_CORRUPTED_CLUSTER);
-- 
2.40.1

