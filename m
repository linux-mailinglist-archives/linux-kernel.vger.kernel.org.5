Return-Path: <linux-kernel+bounces-115913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FA88989B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED9E1C31DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632AF2662C3;
	Mon, 25 Mar 2024 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3G9dm70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67991474DE;
	Sun, 24 Mar 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322100; cv=none; b=QtL3jGBZfSJ605dJUmb2UJfmvqbYWL+cV0weq8KHRC+5yRXTqQp3pgC48zhgcqRBAW8VpHRQyfPzUhd7gNce/mI+sMNOclakpEjxEbRM1b9sq9rARnRby+j96JgQYT8BF/9N/p64r5ojWKyePXxXb1mGaAeoQKUqHkX1w0HNEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322100; c=relaxed/simple;
	bh=Z4UyzSmW/8uH+6qS/EING1uxO1ywCsCPu6rZOXSGNbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McGuCyI/3PzjmdjYctxnucKBU/C0s5xRFQsqJRzjiifk36md0tWbckhTkxf9Q0KGKDqii35TZ/9872Vo6bgzPF6yo0FriY2MXGVKz0lE6QR47IcEr3uepmeLUNU6MpnUOEBCRqk5lXVl1/YfrR4XWUKJIUgNJU5JzKlHCVqBtx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3G9dm70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AC5C43394;
	Sun, 24 Mar 2024 23:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322099;
	bh=Z4UyzSmW/8uH+6qS/EING1uxO1ywCsCPu6rZOXSGNbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3G9dm70vAxB/D4sNv5K6BNtEl+ctWisXWKB3W0baENDqQAGzrDamXuQ/zXagve05
	 HG6U5bmJmuYL4L+MNavny0eauzWBl1PHdRZ58K5r35yCfVg9ZU2oEjI52cpWXkLnF/
	 RTVjqsb8AUpa+IKik0raPNno3DDCRZFABAO70lNn1LTCTxOfauwnNuf9ltuN/RKBHd
	 GXSIwKPPSqW5cy69tvQquxszskiA43qfL1rrjqH4lt/sc2q2uEnT+pu7k5VH5rUn/T
	 HZU4/H8uXzoPYwScbpWO4/KQ+Zufb6hmxzNexRKcY9a+WgsIhAoMho5IDqc56jfJNY
	 sWZnXagKAP9qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6.1 174/451] pstore: inode: Only d_invalidate() is needed
Date: Sun, 24 Mar 2024 19:07:30 -0400
Message-ID: <20240324231207.1351418-175-sashal@kernel.org>
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
index 05ddfb37b15e1..ea3f104371d62 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -306,7 +306,6 @@ int pstore_put_backend_records(struct pstore_info *psi)
 {
 	struct pstore_private *pos, *tmp;
 	struct dentry *root;
-	int rc = 0;
 
 	root = psinfo_lock_root();
 	if (!root)
@@ -316,11 +315,8 @@ int pstore_put_backend_records(struct pstore_info *psi)
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
@@ -328,7 +324,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 
 	inode_unlock(d_inode(root));
 
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.43.0


