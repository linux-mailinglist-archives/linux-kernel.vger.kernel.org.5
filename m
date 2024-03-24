Return-Path: <linux-kernel+bounces-113737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC457888654
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E891C2557B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4612B14C;
	Sun, 24 Mar 2024 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw/L3Nds"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E701DF116;
	Sun, 24 Mar 2024 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320746; cv=none; b=SohsFxRurIiN1LkNse/ODVNhitX9gcs228Yx2o01iz5aRl4APDGl3/2hcJGVtReLJUFqLPPWv1jMihFVnfBL+iuByD3snC93qZIcJ91vT0GDmVqGbhLO+FRyNYXvg9Ao5f07RFV3PPJC0q891OuqBKQ2a1WnwOGC+4OIz1EGslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320746; c=relaxed/simple;
	bh=7eHIBbjxTnJNAvBe7y538hijttessdfvGCLOEmFqKzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhH6wPB0ZRzOzIt0eIpL3ipgbm+OjFLjjUfgfkScGEEcuSH0/14i3FWkWaKoo8B9/hmzuq5mFrqp+ozePcDlLTlmvoroz1Xt6WtvjIWCIy/pa/g4qUUmlTHx80+G3/e8608tkFFLQuUoX/SH7JDj99/yOQUzzTKgDv+Df+M7Q50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw/L3Nds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC128C433F1;
	Sun, 24 Mar 2024 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320746;
	bh=7eHIBbjxTnJNAvBe7y538hijttessdfvGCLOEmFqKzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xw/L3NdsvnXbYLORT1fC4q2VRTKnCzw4UIAv/xTXVgw7hudzCuv5QGsGrkx3kRA9V
	 zOZkZoGbAwsuUtevdELl2IdQYCVqbETBiAqv7lb84u3OEvAHvvgQ4eFSaXKOl1b/n/
	 kkINSv/zyhtSg1KjA1M78BJiCTWXPiJOyvu8YnwdQCqesu/sLAxZfS6JBISn6fNbEi
	 2xMgVdRTg0h2wRnnbszKj4adAAW1Ml4UXEZbPYzRiohaCq2lZHXjDAD3+JrLThb9Nm
	 xlHZaCfzPCNEiJ8lhWBEM4nC3w48QFxNX9UFjGEvwlF1SG1kGxYbfuRxQ526P8NYtp
	 hu9dKZCmq+QHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6.7 310/713] pstore: inode: Only d_invalidate() is needed
Date: Sun, 24 Mar 2024 18:40:36 -0400
Message-ID: <20240324224720.1345309-311-sashal@kernel.org>
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
index 4b4686c593996..4ca72b08d919a 100644
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


