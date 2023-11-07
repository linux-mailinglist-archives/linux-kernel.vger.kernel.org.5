Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D527E440D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjKGPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344355AbjKGPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:48:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA6172E;
        Tue,  7 Nov 2023 07:48:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD46FC43395;
        Tue,  7 Nov 2023 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372091;
        bh=e2g1cm73BA0QuVK/DjHwiUHrDI1ogHHAgRgbLkkoHOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxlUZsps4YLPCr7zsSIKJlXC6TRM/d0NOGU2ExVxfcR2mx06+caEEQpZ+0NWM7uqD
         /mdQO3NOKHhpdkWzh4rVeJyZUWqW6PHgLXTygl25vjb/yl4eNLAwbhvg9Jrcqf7KUA
         q4jW9vMsr50HRep6G46z9UHw9QNZ+6mUo4PIpXOhbnSblFQZebK4GYIKS3BgxeAT2e
         U+RlXONu7BSzy6YEZZeDKqsWO8fiZVV1xHiCAmgKwC1Hzr35kT8SkWTxe9F91d1R8k
         cgEP6I2G5Imp3zG8fK0jWGhYWpVOfMfSmkkRYSZKNUKDI4d2/StgBFv2/7CzEADHrc
         2VWFSt7OKgEDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuezhang Mo <Yuezhang.Mo@sony.com>, Andy Wu <Andy.Wu@sony.com>,
        Aoyama Wataru <wataru.aoyama@sony.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sasha Levin <sashal@kernel.org>, sj1557.seo@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 35/36] exfat: support handle zero-size directory
Date:   Tue,  7 Nov 2023 10:46:17 -0500
Message-ID: <20231107154654.3765336-35-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index 1b9f587f6cca5..95c51b025b917 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -351,14 +351,20 @@ static int exfat_find_empty_entry(struct inode *inode,
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
@@ -368,6 +374,11 @@ static int exfat_find_empty_entry(struct inode *inode,
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
@@ -645,7 +656,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->type = exfat_get_entry_type(ep);
 	info->attr = le16_to_cpu(ep->dentry.file.attr);
 	info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
-	if ((info->type == TYPE_FILE) && (info->size == 0)) {
+	if (info->size == 0) {
 		info->flags = ALLOC_NO_FAT_CHAIN;
 		info->start_clu = EXFAT_EOF_CLUSTER;
 	} else {
@@ -888,6 +899,9 @@ static int exfat_check_dir_empty(struct super_block *sb,
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
+	if (p_dir->dir == EXFAT_EOF_CLUSTER)
+		return 0;
+
 	exfat_chain_dup(&clu, p_dir);
 
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
@@ -1255,7 +1269,8 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		}
 
 		/* Free the clusters if new_inode is a dir(as if exfat_rmdir) */
-		if (new_entry_type == TYPE_DIR) {
+		if (new_entry_type == TYPE_DIR &&
+		    new_ei->start_clu != EXFAT_EOF_CLUSTER) {
 			/* new_ei, new_clu_to_free */
 			struct exfat_chain new_clu_to_free;
 
-- 
2.42.0

