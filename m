Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8E7FB5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjK1Jbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjK1Jba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:31:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC1DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:31:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D9CC433C9;
        Tue, 28 Nov 2023 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701163896;
        bh=2Dql++FKHJ8HVSjhd3VZ6CSZcME1Follek+sE8aZeJw=;
        h=From:To:Cc:Subject:Date:From;
        b=uM+SHt9GX2KUqUvXgBd787svm6ARgraDkrqYaF6Egelrh2xG59GlsMUcB7PuMpCpw
         6N6MzY5q9OOYsB05ub5yHlVUthLCGmAjeYYBhQLo8bWgSgomf5/qUpyYjJCRD30das
         N3FEk2RSidtpASei6n2AU0i/C3+jf5QHGIii/tT3QBJiDoB+i3aeu13+MWd0VGgp7S
         S2tM2q5R2MNnicIEWoZfhFeh5QihqXBK/A8QNrHzd64rPxH8tifvfOy35jpC/AIqCw
         gwucsOqVaa7KilE2a0EZDW4PrF8FDCwSJAv1yFCTNiYH7md9gHQI0U3s7Dui9Ldj53
         CRgxi4y927gLg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: introduce tracepoint for f2fs_rename()
Date:   Tue, 28 Nov 2023 17:31:29 +0800
Message-Id: <20231128093130.2885216-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds tracepoints for f2fs_rename().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c             | 16 ++++++---
 include/trace/events/f2fs.h | 69 +++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a765db9e26c2..ede6afb81762 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1315,21 +1315,27 @@ static int f2fs_rename2(struct mnt_idmap *idmap,
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
+	trace_f2fs_rename_start(old_dir, old_dentry, new_dir, new_dentry,
+								flags);
+
 	err = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry,
 				     flags);
 	if (err)
 		return err;
 
-	if (flags & RENAME_EXCHANGE) {
-		return f2fs_cross_rename(old_dir, old_dentry,
-					 new_dir, new_dentry);
-	}
+	if (flags & RENAME_EXCHANGE)
+		err = f2fs_cross_rename(old_dir, old_dentry,
+					new_dir, new_dentry);
+	else
 	/*
 	 * VFS has already handled the new dentry existence case,
 	 * here, we just deal with "RENAME_NOREPLACE" as regular rename.
 	 */
-	return f2fs_rename(idmap, old_dir, old_dentry,
+		err = f2fs_rename(idmap, old_dir, old_dentry,
 					new_dir, new_dentry, flags);
+
+	trace_f2fs_rename_end(old_dentry, new_dentry, flags, err);
+	return err;
 }
 
 static const char *f2fs_encrypted_get_link(struct dentry *dentry,
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 793f82cc1515..36d9e29ca3c5 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -866,6 +866,75 @@ TRACE_EVENT(f2fs_lookup_end,
 		__entry->err)
 );
 
+TRACE_EVENT(f2fs_rename_start,
+
+	TP_PROTO(struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry,
+			unsigned int flags),
+
+	TP_ARGS(old_dir, old_dentry, new_dir, new_dentry, flags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__string(old_name,	old_dentry->d_name.name)
+		__field(ino_t,		new_pino)
+		__string(new_name,	new_dentry->d_name.name)
+		__field(unsigned int,	flags)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= old_dir->i_sb->s_dev;
+		__entry->ino		= old_dir->i_ino;
+		__assign_str(old_name, old_dentry->d_name.name);
+		__entry->new_pino	= new_dir->i_ino;
+		__assign_str(new_name, new_dentry->d_name.name);
+		__entry->flags		= flags;
+	),
+
+	TP_printk("dev = (%d,%d), old_dir = %lu, old_name: %s, "
+		"new_dir = %lu, new_name: %s, flags = %u",
+		show_dev_ino(__entry),
+		__get_str(old_name),
+		__entry->new_pino,
+		__get_str(new_name),
+		__entry->flags)
+);
+
+TRACE_EVENT(f2fs_rename_end,
+
+	TP_PROTO(struct dentry *old_dentry, struct dentry *new_dentry,
+			unsigned int flags, int ret),
+
+	TP_ARGS(old_dentry, new_dentry, flags, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__string(old_name,	old_dentry->d_name.name)
+		__string(new_name,	new_dentry->d_name.name)
+		__field(unsigned int,	flags)
+		__field(int,		ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= old_dentry->d_sb->s_dev;
+		__entry->ino		= old_dentry->d_inode->i_ino;
+		__assign_str(old_name, old_dentry->d_name.name);
+		__assign_str(new_name, new_dentry->d_name.name);
+		__entry->flags		= flags;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, old_name: %s, "
+		"new_name: %s, flags = %u, ret = %d",
+		show_dev_ino(__entry),
+		__get_str(old_name),
+		__get_str(new_name),
+		__entry->flags,
+		__entry->ret)
+);
+
 TRACE_EVENT(f2fs_readdir,
 
 	TP_PROTO(struct inode *dir, loff_t start_pos, loff_t end_pos, int err),
-- 
2.40.1

