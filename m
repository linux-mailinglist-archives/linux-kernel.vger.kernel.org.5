Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0380BA04
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjLJJ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjLJJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:20:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C6107
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 01:20:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F537C433C7;
        Sun, 10 Dec 2023 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702200051;
        bh=yOuZPXBjKzvohX2oVWWx3dWTtZRRyOJHZm+idQtSj7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUBmEZdRC92b5ppU7KkbM5o9GKhtV4T8mxVcHNQtSFi1TWK6ZZgU3pNRQTsxnksO0
         ZlH8O0D2n8ptGIZWKr9/wPIxREIvk+1tYykw+G94KFEcNueKjxl5VYj5ZnC3QhkWE1
         AwAqrNKyEEnOfv65Ie/zTHzBLa1mLP9gr5cEzhC0gzJBjD6fyC74o3hHyVARIDzbU5
         0jrHRuA9IjLXVS6b/2b7luEVW8xRiQIUf034T31RDcpG97OKjnQfZrEwy4KVTRFSk2
         V72N3Y3At8ehn+q19DYpuIycqo12FdUX8K8R0QVuQIu+tGdB5aQrD3PrrHsL6tHVVf
         +r+g/piIZcT3g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 3/6] f2fs: introduce get_dnode_addr() to clean up codes
Date:   Sun, 10 Dec 2023 17:20:37 +0800
Message-Id: <20231210092040.3374741-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210092040.3374741-1-chao@kernel.org>
References: <20231210092040.3374741-1-chao@kernel.org>
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

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c  | 11 ++---------
 fs/f2fs/f2fs.h  | 18 +++++++++++++++---
 fs/f2fs/file.c  |  8 +-------
 fs/f2fs/inode.c | 32 ++++++++++++++------------------
 4 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7a81ff3c385a..ae46c4841ca9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1181,16 +1181,9 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 
 static void __set_data_blkaddr(struct dnode_of_data *dn)
 {
-	struct f2fs_node *rn = F2FS_NODE(dn->node_page);
-	__le32 *addr_array;
-	int base = 0;
+	__le32 *addr = get_dnode_addr(dn->inode, dn->node_page);
 
-	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
-		base = get_extra_isize(dn->inode);
-
-	/* Get physical address of data block */
-	addr_array = blkaddr_in_node(rn);
-	addr_array[base + dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
+	addr[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2f1d76088953..a06b8aad5117 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3277,12 +3277,13 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
+static inline __le32 *get_dnode_addr(struct inode *inode,
+					struct page *node_page);
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
-	struct f2fs_inode *ri = F2FS_INODE(page);
-	int extra_size = get_extra_isize(inode);
+	__le32 *addr = get_dnode_addr(inode, page);
 
-	return (void *)&(ri->i_addr[extra_size + DEF_INLINE_RESERVED_SIZE]);
+	return (void *)(addr + DEF_INLINE_RESERVED_SIZE);
 }
 
 static inline int f2fs_has_inline_dentry(struct inode *inode)
@@ -3427,6 +3428,17 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	return F2FS_I(inode)->i_inline_xattr_size;
 }
 
+static inline __le32 *get_dnode_addr(struct inode *inode,
+					struct page *node_page)
+{
+	int base = 0;
+
+	if (IS_INODE(node_page) && f2fs_has_extra_attr(inode))
+		base = get_extra_isize(inode);
+
+	return blkaddr_in_node(F2FS_NODE(node_page)) + base;
+}
+
 #define f2fs_get_inode_mode(i) \
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5025abf2d995..d0e7894e42d4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -557,20 +557,14 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct f2fs_node *raw_node;
 	int nr_free = 0, ofs = dn->ofs_in_node, len = count;
 	__le32 *addr;
-	int base = 0;
 	bool compressed_cluster = false;
 	int cluster_index = 0, valid_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	bool released = !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks);
 
-	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
-		base = get_extra_isize(dn->inode);
-
-	raw_node = F2FS_NODE(dn->node_page);
-	addr = blkaddr_in_node(raw_node) + base + ofs;
+	addr = get_dnode_addr(dn->inode, dn->node_page) + ofs;
 
 	/* Assumption: truncation starts with cluster */
 	for (; count > 0; count--, addr++, dn->ofs_in_node++, cluster_index++) {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 108e3d00028a..b31410c4afbc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -61,35 +61,31 @@ void f2fs_set_inode_flags(struct inode *inode)
 			S_ENCRYPTED|S_VERITY|S_CASEFOLD);
 }
 
-static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
+static void __get_inode_rdev(struct inode *inode, struct page *node_page)
 {
-	int extra_size = get_extra_isize(inode);
+	__le32 *addr = get_dnode_addr(inode, node_page);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
-		if (ri->i_addr[extra_size])
-			inode->i_rdev = old_decode_dev(
-				le32_to_cpu(ri->i_addr[extra_size]));
+		if (addr[0])
+			inode->i_rdev = old_decode_dev(le32_to_cpu(addr[0]));
 		else
-			inode->i_rdev = new_decode_dev(
-				le32_to_cpu(ri->i_addr[extra_size + 1]));
+			inode->i_rdev = new_decode_dev(le32_to_cpu(addr[1]));
 	}
 }
 
-static void __set_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
+static void __set_inode_rdev(struct inode *inode, struct page *node_page)
 {
-	int extra_size = get_extra_isize(inode);
+	__le32 *addr = get_dnode_addr(inode, node_page);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		if (old_valid_dev(inode->i_rdev)) {
-			ri->i_addr[extra_size] =
-				cpu_to_le32(old_encode_dev(inode->i_rdev));
-			ri->i_addr[extra_size + 1] = 0;
+			addr[0] = cpu_to_le32(old_encode_dev(inode->i_rdev));
+			addr[1] = 0;
 		} else {
-			ri->i_addr[extra_size] = 0;
-			ri->i_addr[extra_size + 1] =
-				cpu_to_le32(new_encode_dev(inode->i_rdev));
-			ri->i_addr[extra_size + 2] = 0;
+			addr[0] = 0;
+			addr[1] = cpu_to_le32(new_encode_dev(inode->i_rdev));
+			addr[2] = 0;
 		}
 	}
 }
@@ -463,7 +459,7 @@ static int do_read_inode(struct inode *inode)
 	}
 
 	/* get rdev by using inline_info */
-	__get_inode_rdev(inode, ri);
+	__get_inode_rdev(inode, node_page);
 
 	if (!f2fs_need_inode_block_update(sbi, inode->i_ino))
 		fi->last_disk_size = inode->i_size;
@@ -736,7 +732,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
-	__set_inode_rdev(inode, ri);
+	__set_inode_rdev(inode, node_page);
 
 	/* deleted inode */
 	if (inode->i_nlink == 0)
-- 
2.40.1

