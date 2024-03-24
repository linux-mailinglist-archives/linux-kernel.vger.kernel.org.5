Return-Path: <linux-kernel+bounces-113153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B28881E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A575B1F2166C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F0F171E64;
	Sun, 24 Mar 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoQXtTrs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9A171E43;
	Sun, 24 Mar 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319956; cv=none; b=VtQPyyHXcaJopMxSkcUasQ7f12li3ABdJ4GTo2CgkgOnLT/d3ggsVYqDLTTCRmvUrPF84eBFBsFXAixoDtKq3zM7Lm0F7jQLsWNJQ5gG1krCZCWXGe2IjzpdxHy/hUoIpWjtMkA8KiCggFdG0iwy7igNM7avR28+PtpZGcWs7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319956; c=relaxed/simple;
	bh=3ROeb6f/oWDvJLS5zUVN+VKwhzwBKnpR4YsCgI+SwU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNM1vWECROnQqx4uCbCKjr+NvWKSOA3D3eC8ZPw0YVRijxkrE8bV9wpo1IQgib17wk+xrOc7YwnZRrYBYBeFKdYiCjNQY3Upq/iORFy+Dg5GLaiDBVoNRzwghxD5jhzswsPPDWYF3Sg5lpbIZNiLwlVRvkMgxZzGgHuVS10h6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoQXtTrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34226C43394;
	Sun, 24 Mar 2024 22:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319955;
	bh=3ROeb6f/oWDvJLS5zUVN+VKwhzwBKnpR4YsCgI+SwU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QoQXtTrsagw2AfgSnoN6aZIhyWYS3P04nASwrZXpJhpQkquhQMMFusnaujJFRj10x
	 6ed1a3/g93OaBO4I23OokJRGoTXrCG/IW0/9Hzm3U3ujmMz/JROQHCLRVgUTQSltf/
	 A1+ss5Qo2LfMsZJ8OUdBKaAv+IV8ZK6e7TcT2BFt33b1vOTjULwba9ZLv5ZJM9pcHi
	 7Rezr0kNnnaXtbz+kmfdczdvdFtNnKKst1TQpJCEfWK/QSiJxbJuP7Ph+Se/gWm65/
	 iutAMB/PlR/eVF6BI+D1l3kM359ryfKg4kp6G3Mrbz5DhO2HbLK4fnXF5yB94umihC
	 +9/DTl6cWbBLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6.8 262/715] pstore: inode: Only d_invalidate() is needed
Date: Sun, 24 Mar 2024 18:27:21 -0400
Message-ID: <20240324223455.1342824-263-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit a43e0fc5e9134a46515de2f2f8d4100b74e50de3 ]

Unloading a modular pstore backend with records in pstorefs would
trigger the dput() double-drop warning:

  WARNING: CPU: 0 PID: 2569 at fs/dcache.c:762 dput.part.0+0x3f3/0x410

Using the combo of d_drop()/dput() (as mentioned in
Documentation/filesystems/vfs.rst) isn't the right approach here, and
leads to the reference counting problem seen above. Use d_invalidate()
and update the code to not bother checking for error codes that can
never happen.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Fixes: 609e28bb139e ("pstore: Remove filesystem records when backend is unregistered")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index d0d9bfdad30cc..56815799ce798 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -307,7 +307,6 @@ int pstore_put_backend_records(struct pstore_info *psi)
 {
 	struct pstore_private *pos, *tmp;
 	struct dentry *root;
-	int rc = 0;
 
 	root = psinfo_lock_root();
 	if (!root)
@@ -317,11 +316,8 @@ int pstore_put_backend_records(struct pstore_info *psi)
 		list_for_each_entry_safe(pos, tmp, &records_list, list) {
 			if (pos->record->psi == psi) {
 				list_del_init(&pos->list);
-				rc = simple_unlink(d_inode(root), pos->dentry);
-				if (WARN_ON(rc))
-					break;
-				d_drop(pos->dentry);
-				dput(pos->dentry);
+				d_invalidate(pos->dentry);
+				simple_unlink(d_inode(root), pos->dentry);
 				pos->dentry = NULL;
 			}
 		}
@@ -329,7 +325,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 
 	inode_unlock(d_inode(root));
 
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.43.0


