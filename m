Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77E17E45B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbjKGQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343924AbjKGQRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:17:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8F2137;
        Tue,  7 Nov 2023 07:52:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600A4C433C7;
        Tue,  7 Nov 2023 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372354;
        bh=TNpmrZSK9554Iry28Fguo9FF8hXEOjC7aB0QMR68kTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdMHrRbC2k0uRjWewj0pR8XeiSkCtRW0LY/mt4E/fUl0/g6+5LIBf9/+kD/TkDpc1
         k2mdda+/WBGR3VZAD2rllJNdUGPLvM8lAa1HwRgCbcZI6AVWfyOkfqp7NyPPNv+8vj
         wlxh2k+GNfnoWjCRsVCeNvAZVepNoMxOtYMcJQTEDb7cBk3TXFIrgJlUtGj+ZP4733
         9h1ZkLQY8d92zdw2YS63/Dh6NCFZEA1Qp4P94g96Y3fyfR3mTxe5q8yx6T5Np+Cngq
         jqypUDTtsc4tdzFl8oQ0TY4aWW/bL7Vb0niyyVWtBD84F7lhBMuJlOdvR97EK9rJxC
         vHlkntm4QtcYQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuezhang Mo <Yuezhang.Mo@sony.com>, Andy Wu <Andy.Wu@sony.com>,
        Aoyama Wataru <wataru.aoyama@sony.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sasha Levin <sashal@kernel.org>, sj1557.seo@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 22/22] exfat: support handle zero-size directory
Date:   Tue,  7 Nov 2023 10:51:31 -0500
Message-ID: <20231107155146.3767610-22-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit dab48b8f2fe7264d51ec9eed0adea0fe3c78830a ]

After repairing a corrupted file system with exfatprogs' fsck.exfat,
zero-size directories may result. It is also possible to create
zero-size directories in other exFAT implementation, such as Paragon
ufsd dirver.

As described in the specification, the lower directory size limits
is 0 bytes.

Without this commit, sub-directories and files cannot be created
under a zero-size directory, and it cannot be removed.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/namei.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index b22d6c984f8c7..cfa46d8cf5b39 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -330,14 +330,20 @@ static int exfat_find_empty_entry(struct inode *inode,
 		if (exfat_check_max_dentries(inode))
 			return -ENOSPC;
 
-		/* we trust p_dir->size regardless of FAT type */
-		if (exfat_find_last_cluster(sb, p_dir, &last_clu))
-			return -EIO;
-
 		/*
 		 * Allocate new cluster to this directory
 		 */
-		exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+		if (ei->start_clu != EXFAT_EOF_CLUSTER) {
+			/* we trust p_dir->size regardless of FAT type */
+			if (exfat_find_last_cluster(sb, p_dir, &last_clu))
+				return -EIO;
+
+			exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
+		} else {
+			/* This directory is empty */
+			exfat_chain_set(&clu, EXFAT_EOF_CLUSTER, 0,
+					ALLOC_NO_FAT_CHAIN);
+		}
 
 		/* allocate a cluster */
 		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode));
@@ -347,6 +353,11 @@ static int exfat_find_empty_entry(struct inode *inode,
 		if (exfat_zeroed_cluster(inode, clu.dir))
 			return -EIO;
 
+		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
+			ei->start_clu = clu.dir;
+			p_dir->dir = clu.dir;
+		}
+
 		/* append to the FAT chain */
 		if (clu.flags != p_dir->flags) {
 			/* no-fat-chain bit is disabled,
@@ -644,7 +655,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->type = exfat_get_entry_type(ep);
 	info->attr = le16_to_cpu(ep->dentry.file.attr);
 	info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
-	if ((info->type == TYPE_FILE) && (info->size == 0)) {
+	if (info->size == 0) {
 		info->flags = ALLOC_NO_FAT_CHAIN;
 		info->start_clu = EXFAT_EOF_CLUSTER;
 	} else {
@@ -891,6 +902,9 @@ static int exfat_check_dir_empty(struct super_block *sb,
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
+	if (p_dir->dir == EXFAT_EOF_CLUSTER)
+		return 0;
+
 	exfat_chain_dup(&clu, p_dir);
 
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
@@ -1274,7 +1288,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		}
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
-		if (new_entry_type == TYPE_DIR) {
+		if (new_entry_type == TYPE_DIR &&
+		    new_ei->start_clu != EXFAT_EOF_CLUSTER) {
 			/* new_ei, new_clu_to_free */
 			struct exfat_chain new_clu_to_free;
 
-- 
2.42.0

