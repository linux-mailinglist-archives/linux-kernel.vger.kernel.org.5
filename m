Return-Path: <linux-kernel+bounces-137619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECF89E4A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE279282C31
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225C158855;
	Tue,  9 Apr 2024 20:47:01 +0000 (UTC)
Received: from sxb1plsmtpa01-01.prod.sxb1.secureserver.net (sxb1plsmtpa01-01.prod.sxb1.secureserver.net [188.121.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCD2905
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695620; cv=none; b=Q13rE6PYqCsCXaPPZA/+JPtqeH94mpPiGzlge1eQ0/sB/p1m0kVEHq9YA5gXkoMwlPvMBK64rh7HcvSRWtpJNbubTr/d/wcsuZTxbeuv6Ij4xJR3lYc3MihR71DEYfN7f0GQrvM0tAoBUtNcRKYdMqVqIX/+4Kgkc72sE1lkeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695620; c=relaxed/simple;
	bh=QTM+LP0YD0A7dbv3jscQrPsB8DT7gPc3um5gzm+C+tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8xr7AZ2ZHZecOU1gUdp82ENhUIOoVxiePUWSDvR2i7fvx2H5/35RFX4ZnE+vbus+UD1034LtQzQaGu5mxGSYIyieAJF0B2IfA3jXJc7HTDn6elSrJQcSiDC74DZc2E7xOSd0LYBHmlyHH5zmAcWPsucA3sgyhKZ4RJpNFie30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id uIMXrvVZ9defduIMirCrSi; Tue, 09 Apr 2024 13:46:49 -0700
X-CMAE-Analysis: v=2.4 cv=GuaJ+V1C c=1 sm=1 tr=0 ts=6615a939
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=XJTnSpgKjpJfBdNX:21 a=1T6qrdwwAAAA:8 a=VwQbUJbxAAAA:8 a=FXvPX3liAAAA:8
 a=OU3_bkaUkIPW1OEudewA:9 a=pdM9UVT-CToajMN3hxJJ:22 a=AjGcO6oz07-iQ99wixmX:22
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	"Ubisectech Sirius" <bugreport@ubisectech.com>
Subject: [PATCH V2] Squashfs: check the inode number is not the invalid value of zero
Date: Tue,  9 Apr 2024 21:47:23 +0100
Message-Id: <20240409204723.446925-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL/wfjlBWDoeFH1N6AfOORQApCtH1tdsbN+46ujuZyxFfgxQ1pKDNuV9an83pXR24MCs0k4vZl6AeSdj/UQ9GIv8fb2nfc+rB1YO58nBcd2pX/0ILyBw
 wKom7pWc72NgjOKBHB49bYI8m6N4ZyRhk6IQKiAbySP06hTGkceA2D0qyKF9uGFWNl/Bt602NJNsbpEy78AjZTkeeqym4BXrVFQHH4JqbnRb5s3hDYNcSMSR
 /1esuSxj6FTtikF5dc2vfn0o7aY4FLhAVjSKfyYw/6SK/5GenX/OdRagm50twvZRpbzVwvZb5oFjSThat45jww==

Syskiller has produced an out of bounds access in fill_meta_index().

That out of bounds access is ultimately caused because the inode
has an inode number with the invalid value of zero, which was not checked.

The reason this causes the out of bounds access is due to following
sequence of events:

1. Fill_meta_index() is called to allocate (via empty_meta_index())
   and fill a metadata index.  It however suffers a data read error
   and aborts, invalidating the newly returned empty metadata index.
   It does this by setting the inode number of the index to zero,
   which means unused (zero is not a valid inode number).

2. When fill_meta_index() is subsequently called again on another
   read operation, locate_meta_index() returns the previous index
   because it matches the inode number of 0.  Because this index
   has been returned it is expected to have been filled, and because
   it hasn't been, an out of bounds access is performed.

This patch adds a sanity check which checks that the inode number
is not zero when the inode is created and returns -EINVAL if it is.

Reported-by: "Ubisectech Sirius" <bugreport@ubisectech.com>
Closes: https://lore.kernel.org/lkml/87f5c007-b8a5-41ae-8b57-431e924c5915.bugreport@ubisectech.com/
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
--
V2: add space between "if" and "(".  Move Closes: to after Reported-by:.
---
 fs/squashfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index aa3411354e66..16bd693d0b3a 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -48,6 +48,10 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	gid_t i_gid;
 	int err;
 
+	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
+	if (inode->i_ino == 0)
+		return -EINVAL;
+
 	err = squashfs_get_id(sb, le16_to_cpu(sqsh_ino->uid), &i_uid);
 	if (err)
 		return err;
@@ -58,7 +62,6 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 
 	i_uid_write(inode, i_uid);
 	i_gid_write(inode, i_gid);
-	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
 	inode_set_mtime(inode, le32_to_cpu(sqsh_ino->mtime), 0);
 	inode_set_atime(inode, inode_get_mtime_sec(inode), 0);
 	inode_set_ctime(inode, inode_get_mtime_sec(inode), 0);
-- 
2.39.2


