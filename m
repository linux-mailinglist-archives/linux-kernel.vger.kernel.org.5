Return-Path: <linux-kernel+bounces-19750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D21A8272D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09AA2847A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE15102B;
	Mon,  8 Jan 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aol7eVIA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781A4C3C9;
	Mon,  8 Jan 2024 15:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573BBC433AB;
	Mon,  8 Jan 2024 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727111;
	bh=l92SouosFIYw3ff8gW2JhMxPJjTF6VFrybmBKncrwgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aol7eVIAnyTNYboF/ohW1jfHZDTOd9STxJLPiwjIjJEpPo4VinW3ryQKGuVdJE6tM
	 2gr0q/px+RYehtHqMmXHU75K0Ku4Fjy1lXvQWMyQZNpBQsRXR0Rt8hZd5jXKMNR8cM
	 7Spb402LZn7tocwTT7e48TmRg72ptEMqAzvS1bV947DwK+PNcw7Ga8bvJUbCH8OU7e
	 MsqE1zEbCvqjIFHuRoUtOORTDfbcBspBKh4SY2x6EEQI62+23FmTOSJ6M5wYl50VgS
	 U7QntVXKqF40hzWyIXEFVcdefAnw38G0DnpYEFeRdvQqyj9FK2ZZVt5Ihfw2fsz8Xj
	 cSOkGW72/jh2A==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:18:20 +0000
Subject: [PATCH v2 4/8] fs/9p: Eliminate redundant non-cache path in mknod
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ericvh-fix-cache-dups-v2-4-a73f8822838c@kernel.org>
References: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
In-Reply-To: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=l92SouosFIYw3ff8gW2JhMxPJjTF6VFrybmBKncrwgQ=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJDpbZXDyczF1cb1zBNOFrwcPuSureTfMT7v
 XZUgTbbY02JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQwAKCRCI/9X7Sl//
 mKI2D/4sZz4CoiiiUdppH9yfbfYSY/u9yUtOsTs9F2fT5Z9ADtCL69wGzIDl/aEcNgH3UYGYDoM
 I4qmTjN0rUKE+o6qYu1QCt3cQgPMoYXe8716+ja2Pgm0kGxzQG2zXVye1ZZiDT1IdagSmeJVszg
 ymazH85rjcU9wiDAZWHf5RGEnBv+ZNaqubksmvw8zKlDDlgR3aNAQRORoV6Bx3yKjBYpoXdqOFy
 /HqwMtcsxnxlh0aU3XX3weV+QM1cpHHvocVqCsODPOJNYdWOqKRwvGLWd9V/YPDThkganKoA+Sz
 F/e30eU1vljldM5T4iX9kUGQYQGNqVTAqFLtJxUmErl2RbBeSp0NukRwkDeHffQFqmm+u0rUwlx
 kVSDC5pUllsRuUdtUfRvD0WUfovp+jpUmc0QWbWobrGUNnvxdo7AkXOePVdi6w0F1xfCXdUkW7y
 4n3pbzoQxDK/aITQIo9j/2q2JQ5ZzA0ng2VsZQXZUkelo9TwpDVc69Ujhdi1mOjoXKou0VkAu6c
 lEby/x+9T54f5zWxHw2ws7XUoY/Kmf7E90jKRUC8jJISgZTyR2XIZszeMZIhL8d1EoP8uq13lyv
 NiWPWj+jF2qmvI3urIruhunul5eor+uTMMgxIXkkGiEs1tWnrve1tjEVuL6tRIYVNExHBUgu+EI
 6G3u/3Hy/vASWzA==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Like symlink, mknod had a seperate path with different inode
allocation -- but this seems unnecessary, so eliminating this path.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode_dotl.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ab52a89367d2..ddc3cfdcc13b 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -836,33 +836,17 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 			 err);
 		goto error;
 	}
-
-	/* instantiate inode and assign the unopened fid to the dentry */
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
-				 err);
-			goto error;
-		}
-		v9fs_set_create_acl(inode, fid, dacl, pacl);
-		v9fs_fid_add(dentry, &fid);
-		d_instantiate(dentry, inode);
-		err = 0;
-	} else {
-		/*
-		 * Not in cached mode. No need to populate inode with stat.
-		 * socket syscall returns a fd, so we need instantiate
-		 */
-		inode = v9fs_get_inode(dir->i_sb, mode, rdev);
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
+	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	v9fs_fid_add(dentry, &fid);
+	d_instantiate(dentry, inode);
+	err = 0;
 error:
 	p9_fid_put(fid);
 	v9fs_put_acl(dacl, pacl);

-- 
2.41.0


