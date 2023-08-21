Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ADC782D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjHUPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjHUPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60397E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2EEE61861
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A864C433C7;
        Mon, 21 Aug 2023 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692631353;
        bh=UKJouoh35D1ljmwVw1T+lc1Ww6sUl1JIQ3DRiiX56nE=;
        h=From:To:Cc:Subject:Date:From;
        b=ERtRk+K/S1T+lRj2R+Ow5dux1h/He9Cp611H84buS7tp+NfH0i5Mp471gQaLJsEWQ
         n+SviJ/Pnog9M+tHGU3sZkf2GqzUZem0eawP0md50cd54uoKo5hTvlYSV8GVFsaTyx
         rrRbLOmsbytYn0+Rav3D9LfCsaRrPErSt42LBZhrHWPJyE6E3FQpKZcb8wnlDGWVO2
         +o7awUAxU3GQ5i+X1sRSTxnQRmRhMTSWfNEJyYbn4g8p27fbM+1qdyfJiqfYVizGox
         dJl1UTTpM7MWuXEX0+YxQ5dfutvSUlGqIVuNQtFav6cMZ8aMK8cwbfNhtQtZyog2xh
         JusvYz1pHMTEw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: clean up error handling in sanity_check_{compress_,}inode()
Date:   Mon, 21 Aug 2023 23:22:23 +0800
Message-Id: <20230821152225.4086924-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sanity_check_{compress_,}inode(), it doesn't need to set SBI_NEED_FSCK
in each error case, instead, we can set the flag in do_read_inode() only
once when sanity_check_inode() fails.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e81725c922cd..8ed5406ea204 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -214,7 +214,7 @@ static bool sanity_check_compress_inode(struct inode *inode,
 		f2fs_warn(sbi,
 			"%s: inode (ino=%lx) has unsupported compress algorithm: %u, run fsck to fix",
 			__func__, inode->i_ino, ri->i_compress_algorithm);
-		goto err;
+		return false;
 	}
 	if (le64_to_cpu(ri->i_compr_blocks) >
 			SECTOR_TO_BLOCK(inode->i_blocks)) {
@@ -222,14 +222,14 @@ static bool sanity_check_compress_inode(struct inode *inode,
 			"%s: inode (ino=%lx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
 			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
 			SECTOR_TO_BLOCK(inode->i_blocks));
-		goto err;
+		return false;
 	}
 	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
 		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
 		f2fs_warn(sbi,
 			"%s: inode (ino=%lx) has unsupported log cluster size: %u, run fsck to fix",
 			__func__, inode->i_ino, ri->i_log_cluster_size);
-		goto err;
+		return false;
 	}
 
 	clevel = le16_to_cpu(ri->i_compress_flag) >>
@@ -273,8 +273,6 @@ static bool sanity_check_compress_inode(struct inode *inode,
 err_level:
 	f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported compress level: %u, run fsck to fix",
 		  __func__, inode->i_ino, clevel);
-err:
-	set_sbi_flag(sbi, SBI_NEED_FSCK);
 	return false;
 }
 
@@ -287,14 +285,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 
 	iblocks = le64_to_cpu(F2FS_INODE(node_page)->i_blocks);
 	if (!iblocks) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%lx iblocks=%llu, run fsck to fix.",
 			  __func__, inode->i_ino, iblocks);
 		return false;
 	}
 
 	if (ino_of_node(node_page) != nid_of_node(node_page)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%lx, ino,nid: [%u, %u] run fsck to fix.",
 			  __func__, inode->i_ino,
 			  ino_of_node(node_page), nid_of_node(node_page));
@@ -303,7 +299,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 
 	if (f2fs_has_extra_attr(inode)) {
 		if (!f2fs_sb_has_extra_attr(sbi)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
 				  __func__, inode->i_ino);
 			return false;
@@ -311,7 +306,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize < F2FS_MIN_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize % sizeof(__le32)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
 				  __func__, inode->i_ino, fi->i_extra_isize,
 				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
@@ -321,7 +315,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 			f2fs_has_inline_xattr(inode) &&
 			(!fi->i_inline_xattr_size ||
 			fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
 				  __func__, inode->i_ino, fi->i_inline_xattr_size,
 				  MAX_INLINE_XATTR_SIZE);
@@ -335,7 +328,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 				return false;
 		}
 	} else if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
 			  __func__, inode->i_ino);
 		return false;
@@ -343,31 +335,26 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 
 	if (!f2fs_sb_has_extra_attr(sbi)) {
 		if (f2fs_sb_has_project_quota(sbi)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_PRJQUOTA);
 			return false;
 		}
 		if (f2fs_sb_has_inode_chksum(sbi)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CHKSUM);
 			return false;
 		}
 		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
 			return false;
 		}
 		if (f2fs_sb_has_inode_crtime(sbi)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CRTIME);
 			return false;
 		}
 		if (f2fs_sb_has_compression(sbi)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_COMPRESSION);
 			return false;
@@ -375,21 +362,18 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 	}
 
 	if (f2fs_sanity_check_inline_data(inode)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
 			  __func__, inode->i_ino, inode->i_mode);
 		return false;
 	}
 
 	if (f2fs_has_inline_dentry(inode) && !S_ISDIR(inode->i_mode)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_dentry, run fsck to fix",
 			  __func__, inode->i_ino, inode->i_mode);
 		return false;
 	}
 
 	if ((fi->i_flags & F2FS_CASEFOLD_FL) && !f2fs_sb_has_casefold(sbi)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: inode (ino=%lx) has casefold flag, but casefold feature is off",
 			  __func__, inode->i_ino);
 		return false;
@@ -477,6 +461,7 @@ static int do_read_inode(struct inode *inode)
 
 	if (!sanity_check_inode(inode, node_page)) {
 		f2fs_put_page(node_page, 1);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
 		return -EFSCORRUPTED;
 	}
-- 
2.40.1

