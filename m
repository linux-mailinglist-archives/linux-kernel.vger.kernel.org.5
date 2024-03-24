Return-Path: <linux-kernel+bounces-115910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB588989C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCB329F0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742A389182;
	Mon, 25 Mar 2024 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Noj5UU92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018EA1474D2;
	Sun, 24 Mar 2024 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322099; cv=none; b=ov7fDeB0tJSbFwJeTahu4DT3vSIQ+Qc6Rc1TrvcIgATtU8PZYeemPy6ww9dL6dco+vFIt4lJJ/R99CIMmyfsXkdnR7/ql36TCNTFbfqE9+K0lSAvQw0ShQ67XT8/6R2C39zl4cSMk8aq7rK/gD316ZPohC+AhR+FeFu/WqzmHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322099; c=relaxed/simple;
	bh=Qyuobp+byJ3Y79nA5NuOS/aQthqGT+jDXOp+vWh5wXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZQiS34/qX2jHZpllbjIZIAWz6dzhrrx7z14wyt9T1JwPc3f4co0n0rTWWnE+jYQprHzYWsyTGRT7mK5+FquhJcHQnMPrbUUswxuTFNQGrt1OaCyFeeg/mOnVK9Gb32LS1gcjoCaCWJWI5yBAYez6Dq9TnEN8n4Y2e4lgZ4BxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Noj5UU92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09433C433C7;
	Sun, 24 Mar 2024 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322098;
	bh=Qyuobp+byJ3Y79nA5NuOS/aQthqGT+jDXOp+vWh5wXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Noj5UU92HUBlm+NZqV4e7tAiwrS5si5F2Fy15NCRBGr63HNruZYp5fCIwpENPfOO/
	 lN4tK7L9bFmsT2p9KBSEJ9/vVLGG5qBgYlqgeG2m3Jms7tY10wyl1DrCgqa+I8XDMR
	 pNGZ04BL2F4bfXStGTBM2vFhOl0wv7cRFFUOnauifjv5PKigwkoBR+8f9TvJS2z+zV
	 NJLMdyIySrRfL0OIAxMcj/PKa0o6/O5/xetzBCP39T/zEGVpa1NvcZ0oYec17ciq5r
	 FJ/1GGa7IehWfF2ICbo1uTP+Ilj2Rs+zvScK6irvsX2NvyiAmlNnU8gz1dHLi9cu6w
	 Z+euXM7IOUkpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 173/451] pstore: inode: Convert mutex usage to guard(mutex)
Date: Sun, 24 Mar 2024 19:07:29 -0400
Message-ID: <20240324231207.1351418-174-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit e2eeddefb046dbc771a6fa426f7f98fb25adfe68 ]

Replace open-coded mutex handling with cleanup.h guard(mutex) and
scoped_guard(mutex, ...).

Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: <linux-hardening@vger.kernel.org>
Link: https://lore.kernel.org/r/20231205182622.1329923-2-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: a43e0fc5e913 ("pstore: inode: Only d_invalidate() is needed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/inode.c | 76 +++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 45 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index ffbadb8b3032d..05ddfb37b15e1 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -182,25 +182,21 @@ static int pstore_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct pstore_private *p = d_inode(dentry)->i_private;
 	struct pstore_record *record = p->record;
-	int rc = 0;
 
 	if (!record->psi->erase)
 		return -EPERM;
 
 	/* Make sure we can't race while removing this file. */
-	mutex_lock(&records_list_lock);
-	if (!list_empty(&p->list))
-		list_del_init(&p->list);
-	else
-		rc = -ENOENT;
-	p->dentry = NULL;
-	mutex_unlock(&records_list_lock);
-	if (rc)
-		return rc;
-
-	mutex_lock(&record->psi->read_mutex);
-	record->psi->erase(record);
-	mutex_unlock(&record->psi->read_mutex);
+	scoped_guard(mutex, &records_list_lock) {
+		if (!list_empty(&p->list))
+			list_del_init(&p->list);
+		else
+			return -ENOENT;
+		p->dentry = NULL;
+	}
+
+	scoped_guard(mutex, &record->psi->read_mutex)
+		record->psi->erase(record);
 
 	return simple_unlink(dir, dentry);
 }
@@ -292,19 +288,16 @@ static struct dentry *psinfo_lock_root(void)
 {
 	struct dentry *root;
 
-	mutex_lock(&pstore_sb_lock);
+	guard(mutex)(&pstore_sb_lock);
 	/*
 	 * Having no backend is fine -- no records appear.
 	 * Not being mounted is fine -- nothing to do.
 	 */
-	if (!psinfo || !pstore_sb) {
-		mutex_unlock(&pstore_sb_lock);
+	if (!psinfo || !pstore_sb)
 		return NULL;
-	}
 
 	root = pstore_sb->s_root;
 	inode_lock(d_inode(root));
-	mutex_unlock(&pstore_sb_lock);
 
 	return root;
 }
@@ -319,19 +312,19 @@ int pstore_put_backend_records(struct pstore_info *psi)
 	if (!root)
 		return 0;
 
-	mutex_lock(&records_list_lock);
-	list_for_each_entry_safe(pos, tmp, &records_list, list) {
-		if (pos->record->psi == psi) {
-			list_del_init(&pos->list);
-			rc = simple_unlink(d_inode(root), pos->dentry);
-			if (WARN_ON(rc))
-				break;
-			d_drop(pos->dentry);
-			dput(pos->dentry);
-			pos->dentry = NULL;
+	scoped_guard(mutex, &records_list_lock) {
+		list_for_each_entry_safe(pos, tmp, &records_list, list) {
+			if (pos->record->psi == psi) {
+				list_del_init(&pos->list);
+				rc = simple_unlink(d_inode(root), pos->dentry);
+				if (WARN_ON(rc))
+					break;
+				d_drop(pos->dentry);
+				dput(pos->dentry);
+				pos->dentry = NULL;
+			}
 		}
 	}
-	mutex_unlock(&records_list_lock);
 
 	inode_unlock(d_inode(root));
 
@@ -355,20 +348,20 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	if (WARN_ON(!inode_is_locked(d_inode(root))))
 		return -EINVAL;
 
-	rc = -EEXIST;
+	guard(mutex)(&records_list_lock);
+
 	/* Skip records that are already present in the filesystem. */
-	mutex_lock(&records_list_lock);
 	list_for_each_entry(pos, &records_list, list) {
 		if (pos->record->type == record->type &&
 		    pos->record->id == record->id &&
 		    pos->record->psi == record->psi)
-			goto fail;
+			return -EEXIST;
 	}
 
 	rc = -ENOMEM;
 	inode = pstore_get_inode(root->d_sb);
 	if (!inode)
-		goto fail;
+		return -ENOMEM;
 	inode->i_mode = S_IFREG | 0444;
 	inode->i_fop = &pstore_file_operations;
 	scnprintf(name, sizeof(name), "%s-%s-%llu%s",
@@ -395,7 +388,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	d_add(dentry, inode);
 
 	list_add(&private->list, &records_list);
-	mutex_unlock(&records_list_lock);
 
 	return 0;
 
@@ -403,8 +395,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	free_pstore_private(private);
 fail_inode:
 	iput(inode);
-fail:
-	mutex_unlock(&records_list_lock);
 	return rc;
 }
 
@@ -450,9 +440,8 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	mutex_lock(&pstore_sb_lock);
-	pstore_sb = sb;
-	mutex_unlock(&pstore_sb_lock);
+	scoped_guard(mutex, &pstore_sb_lock)
+		pstore_sb = sb;
 
 	pstore_get_records(0);
 
@@ -467,17 +456,14 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
 
 static void pstore_kill_sb(struct super_block *sb)
 {
-	mutex_lock(&pstore_sb_lock);
+	guard(mutex)(&pstore_sb_lock);
 	WARN_ON(pstore_sb && pstore_sb != sb);
 
 	kill_litter_super(sb);
 	pstore_sb = NULL;
 
-	mutex_lock(&records_list_lock);
+	guard(mutex)(&records_list_lock);
 	INIT_LIST_HEAD(&records_list);
-	mutex_unlock(&records_list_lock);
-
-	mutex_unlock(&pstore_sb_lock);
 }
 
 static struct file_system_type pstore_fs_type = {
-- 
2.43.0


