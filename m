Return-Path: <linux-kernel+bounces-19749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9468272D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DD61C22C83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D064CE0B;
	Mon,  8 Jan 2024 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAzeK0/I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14D4C3BB;
	Mon,  8 Jan 2024 15:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BACDC433BC;
	Mon,  8 Jan 2024 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727111;
	bh=zoRQ9dEnIT6klFY52VeEID3QXnuY6rouUe1AVTOWsOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MAzeK0/ItptvKuUhx8VpztMXWJIukyfaiIMxjYv9hInoCXNU7aRj2q1noF7WCs4cK
	 hgjhgM2W7NfWpirmd4FQ+87uNy6fLmnAv4zR9Bvi8okIuAoWjf8h0G1xBxzkaXIVsG
	 sKLJlGlyd29pdVomVqYdUiCpFEehEuRvisciOIcmmNqwzSrkQiossMjwlOVnmforu8
	 4UF2AlVhaX6vvmmG5KyjvyANAhkSmW39+55iKYQZCpI2P6fTfs2x6rhsLKyXsDk1G2
	 vI9p4hG+IvriRtzJxdN4Ssfx5hz/8UMvbm7zobelZLl7BYW2x2Av/wlW9t9A1dk7Pv
	 28TVlaQCPxTQA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:18:19 +0000
Subject: [PATCH v2 3/8] fs/9p: remove walk and inode allocation from
 symlink
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ericvh-fix-cache-dups-v2-3-a73f8822838c@kernel.org>
References: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
In-Reply-To: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=zoRQ9dEnIT6klFY52VeEID3QXnuY6rouUe1AVTOWsOw=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJDsRvZD7QYXACISbCPPvvYctu/FCJh8S1EV
 AOxVjGXNaWJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQwAKCRCI/9X7Sl//
 mBjTD/kBaCqi1EEuQRPk03r56f9Qg/8xvx0dmj57VFaJYOOJofi/FtmCfTTJMd5jtQRP8zkTC9M
 S2//Nqw+PU7Egsim4KUJu5Wy6mgpVV17bV4TG6vap6D5lz/9S88ZPQhgL8GBj3uNTBUD244jfWY
 z45cJH8GNR+XSpd1peA3AHPojxVFdWUtCsNlQplKyQeLTNTLWUvCpvuarxA0M2xUr7Jz0NyzvsV
 iDYvKSzxtyHossRaZ49RtUgni+/qW7ODLWEC6KScNkBliAr3RCfuT5Gyu4mcDXUW4gmZDp3DwGn
 y4qlYv5OYqKzgeoevAjnJQKp17/kdc3onzvtAzNsyGNgVjYPatVW5IbSeOc0T7Le3Hghn13JfbK
 7WKOesFsNKLEcgOl5gBGShc7ClUyOpnqYg9ybCNrxqbZVKyB+3OCfTyuCGxxBCX+uN85M8SSeDt
 4GKaZArZ0hXhqYrIzYCwN0bdSNzcX634luBTMmMHUbj9hLXTqbG2fBJDUpmvo8Pp1t8wdlhxCqS
 wmM8RI2vc+rFofjzXJruIkCS/VPwedPxqiAD//5gwHbEOGgLj8azaZrh6ypfjS66JJkGBTnk0SL
 4tFTMckwFKlRWuTIATpYiOs/SO6Wx8rizNur0B7tzMlSxD2KbxcedUxrsgLUdVMyoGs0IXg1BTn
 X4FSEeeS7ey0ipg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Symlink had a bunch of extra operations which essentially
end up discarded.  It was walking the fid to the new file and
creating an inode for it, but those semantics are part of
tsymlink.  This did prepopulate the cache, but that also seems
potentially unnecessary and frought with peril.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode_dotl.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 981278d0788e..ab52a89367d2 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -690,14 +690,11 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	kgid_t gid;
 	const unsigned char *name;
 	struct p9_qid qid;
-	struct inode *inode;
 	struct p9_fid *dfid;
 	struct p9_fid *fid = NULL;
-	struct v9fs_session_info *v9ses;
 
 	name = dentry->d_name.name;
 	p9_debug(P9_DEBUG_VFS, "%lu,%s,%s\n", dir->i_ino, name, symname);
-	v9ses = v9fs_inode2v9ses(dir);
 
 	dfid = v9fs_parent_fid(dentry);
 	if (IS_ERR(dfid)) {
@@ -717,36 +714,6 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	v9fs_invalidate_inode_attr(dir);
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-		/* Now walk from the parent so we can get an unopened fid. */
-		fid = p9_client_walk(dfid, 1, &name, 1);
-		if (IS_ERR(fid)) {
-			err = PTR_ERR(fid);
-			p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
-				 err);
-			goto error;
-		}
-
-		/* instantiate inode and assign the unopened fid to dentry */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
-				 err);
-			goto error;
-		}
-		v9fs_fid_add(dentry, &fid);
-		d_instantiate(dentry, inode);
-		err = 0;
-	} else {
-		/* Not in cached mode. No need to populate inode with stat */
-		inode = v9fs_get_inode(dir->i_sb, S_IFLNK, 0);
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			goto error;
-		}
-		d_instantiate(dentry, inode);
-	}
 
 error:
 	p9_fid_put(fid);

-- 
2.41.0


