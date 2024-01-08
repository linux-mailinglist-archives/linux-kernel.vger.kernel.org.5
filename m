Return-Path: <linux-kernel+bounces-19748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CD8272D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96391B22F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C43D51026;
	Mon,  8 Jan 2024 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqXvlbXp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46385027B;
	Mon,  8 Jan 2024 15:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E90C43391;
	Mon,  8 Jan 2024 15:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727110;
	bh=6J7EZJj9VWIpSwcWubGlaBSfbZNbY5oiwi0szyHJl2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bqXvlbXpOCMmgpQ9VcsXqL7T58j6ZPvokybsOFXiGpDplJVyJNnednreBYtb/7qq0
	 50wURALuXCHxyy0J0023MhMjfg5ovZZ6YeSJ3UBxIYz/RM2g9J+fn83lBULmcQsYrs
	 BcoS3PHSse5AHLvugYHGtp2MonVUNYmCH63IQKduvfk8HxhzpZZOt+QTzoixx54htt
	 P2tuCycgC8NYXRRtOfy0e/aJiDtn9VGoQa/x0p8MWvtWrWduOKILUKYBB5LzwxBi2H
	 mB+D9WsSyedZNrYSVu6tLzFaCiekT3V7Szl3eGWpRgPzRuVbaOLjDg8uX3JEDN06cM
	 u0UUYU/anblRw==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:18:18 +0000
Subject: [PATCH v2 2/8] fs/9p: convert mkdir to use get_new_inode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ericvh-fix-cache-dups-v2-2-a73f8822838c@kernel.org>
References: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
In-Reply-To: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=6J7EZJj9VWIpSwcWubGlaBSfbZNbY5oiwi0szyHJl2k=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJDf3xA25bd6ZNge4qdcB0YfAp+Kxxh4WkRt
 9dUbSCCA9SJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQwAKCRCI/9X7Sl//
 mB2fD/0durKg/03hcGzp65W1RgAfi/Gil7/upa753Z62meQO7ZvCpmBHDKidax2iJnjAnieZfhV
 9WqnO1EQukimB1YLZW5wsJfNwNTYyWlFEczxMyG4luuRDQSksTuAoKmLqvKMFTB4GHyW1ZfH8Iw
 b5bUGesYH5SRjlCEJzxSy0cnUJPCd6YaMhEzrxIvRMUTGYirppm8N3sh/U90kkFY7DewxbSxQ4q
 Kl3X7TCBsZeIKHXSnc8zkivy8dcKVcEA2jhAMkxDNzZNE+G/6Llgs+ySxxJCOs+u6oGSGUviH1h
 qkW9PZQbEAdi8FCHvare9k8W1hYd20jQsswrpHd+34FE+ahyiqQ9RInl/Ou9Dl7oAgrML7h1fJz
 KE87trQerbk5Jj71h0K7NNASay7qA/CJaVXs1+vIovyoMpRebm+w42BkmATlonbsno3E/YXSRnk
 6fSHZWclok7TvYmZqfj4+fLsdeyj+ExlxDh0ZBUaxM0V1U46wz4sfM4lBUaO96oiOgEenMOiOzf
 WO1ZaB1V6LayV7luQdzVJ7zLAFUaKuBlASwn2FGXrBrM4TSqYDMe/2QS9VEOUIr1BilGdIwN0TO
 y2j+gtseEC+GfCLsxtWKLd2ZLyursnInarYSP+whuSxEuDgZDBYuYGsvgmR3FxgN9yGrwH3pMSa
 Nlco5bxWVzYcFXA==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

mkdir had different code paths for inode creation, cache used
the get_new_inode_from_fid helper, but non-cached used
v9fs_get_inode.  Collapsed into a single implementation across
both as there should be no difference.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode_dotl.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c7319af2f471..981278d0788e 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -401,32 +401,17 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
-				 err);
-			goto error;
-		}
-		v9fs_fid_add(dentry, &fid);
-		v9fs_set_create_acl(inode, fid, dacl, pacl);
-		d_instantiate(dentry, inode);
-		err = 0;
-	} else {
-		/*
-		 * Not in cached mode. No need to populate
-		 * inode with stat. We need to get an inode
-		 * so that we can set the acl with dentry
-		 */
-		inode = v9fs_get_inode(dir->i_sb, mode, 0);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			goto error;
-		}
-		v9fs_set_create_acl(inode, fid, dacl, pacl);
-		d_instantiate(dentry, inode);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
+			 err);
+		goto error;
 	}
+	v9fs_fid_add(dentry, &fid);
+	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	d_instantiate(dentry, inode);
+	err = 0;
 	inc_nlink(dir);
 	v9fs_invalidate_inode_attr(dir);
 error:

-- 
2.41.0


