Return-Path: <linux-kernel+bounces-115433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A71889B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEBA2A45EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C6210878;
	Mon, 25 Mar 2024 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqa0HSiX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABF1DF117;
	Sun, 24 Mar 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320746; cv=none; b=fLNl5/8enoqHes4V64B+OJzystkAKG+I8V+6jS7TQSaPNg5eDb1xbsCcKqtwG0JhpoI3oTwhZ9TtZNW1bgaC4uZkQlIlGv6N4XPmEq/7xvdfCpefBMjY92JSWZQx5CCFMVaoqBPGXvXLuDhoYuHNGqaz/Yoc1xLbSs6f3VfkWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320746; c=relaxed/simple;
	bh=Ou0E6vWtPrzFTnqADnt3d4DBQVXvW1/QfnLtXIX9/go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAgR1JU+/JmMXuw5x6W0ntZpW20qJdDx/hWZ5IsG/OJ2i08nQDtcWT78+4Jc1PJ5NMKw3w+7i7G4B5Ax3GLmLmKzRWS2/nv/aGeIxgr3euk2Isu5VhyyzEEe8BAZLfBh5Pgx9aIXvXmjatP4+V4O2Qf0AefvzRK9y9DNNc1a64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqa0HSiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E05C43390;
	Sun, 24 Mar 2024 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320745;
	bh=Ou0E6vWtPrzFTnqADnt3d4DBQVXvW1/QfnLtXIX9/go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rqa0HSiX9hdl8svdH9KLLiHfz4uOzaoUKPtTm0aQJCxjlw7Ek1bm2MTsMr0zn+VQU
	 BrsB1zz9IBsw+tskX8oVi9TtNeSYNCz+J1xGIyW7gEJZY4fmLu+2pbiCqBhnsqzEKf
	 x6/9Ms9N+d58FUCu5pN/TqCyfr2stDlxlMwccqEpQoJJeJ1Ak8MGlsVwpRIG/Wt1uZ
	 qpS82aqC1mrKEgaKp+Qj8ZBJ9kYkK3X6pyXv4qVdGj7I0JpgUYCEPxilVXyTE1OMJl
	 YJA40Q4piVYMMv4elez12arULMoy5a1wjH/DORW+EPaJQNYH3DUVs6pN8BuSeYIK12
	 Y5o7aNcCeN7Vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 309/713] pstore: inode: Convert mutex usage to guard(mutex)
Date: Sun, 24 Mar 2024 18:40:35 -0400
Message-ID: <20240324224720.1345309-310-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index d41c20d1b5e82..4b4686c593996 100644
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
@@ -396,7 +389,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	d_add(dentry, inode);
 
 	list_add(&private->list, &records_list);
-	mutex_unlock(&records_list_lock);
 
 	return 0;
 
@@ -404,8 +396,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	free_pstore_private(private);
 fail_inode:
 	iput(inode);
-fail:
-	mutex_unlock(&records_list_lock);
 	return rc;
 }
 
@@ -451,9 +441,8 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	mutex_lock(&pstore_sb_lock);
-	pstore_sb = sb;
-	mutex_unlock(&pstore_sb_lock);
+	scoped_guard(mutex, &pstore_sb_lock)
+		pstore_sb = sb;
 
 	pstore_get_records(0);
 
@@ -468,17 +457,14 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
 
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


