Return-Path: <linux-kernel+bounces-135966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D631E89CE4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777641F226A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9C1494C0;
	Mon,  8 Apr 2024 22:09:59 +0000 (UTC)
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [188.121.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606621442F3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614199; cv=none; b=WFdZwyRBeXLAk929EbADTGoIyeaJwtRSB4ke8M+nhzZhWh9K55nOFbZCT4KcdN7YZMNZQyPC0fySU7rrafFwVc/q40UA93A4Fawk4RmsDY2GTM5jyjfZSe0c6kMOP1p6E2nvG8an4I1ve6T9+sDYSyJEDgpKnWRDpj5pKPJ3i+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614199; c=relaxed/simple;
	bh=FA1l+1VWT7YtpMTlmBruM8zQe16BLG+YQjp9MvtRRjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U1rVbXfvNI2S8Y/Q0ih/dpj/1yzanXZYCkvZv63bksMRM7EXWpzrfyuyHPVnWRw046n5c6i+yeGnM76qJw7PLjap5D3u8/T7Ro6aqZ3d9ovPwKMGKtO9ScVr0KNjcg77IEAXF448Rs95i2mgHEsQeyGMTGvE/BBL8HxBbv2aeuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id tx44reUu3RNGctx4FrdXqh; Mon, 08 Apr 2024 15:02:20 -0700
X-CMAE-Analysis: v=2.4 cv=bvaHB1ai c=1 sm=1 tr=0 ts=6614696d
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=XJTnSpgKjpJfBdNX:21 a=1T6qrdwwAAAA:8 a=FXvPX3liAAAA:8 a=VwQbUJbxAAAA:8
 a=OU3_bkaUkIPW1OEudewA:9 a=pdM9UVT-CToajMN3hxJJ:22 a=UObqyxdv-6Yh2QiB9mM_:22
 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	"Ubisectech Sirius" <bugreport@ubisectech.com>
Subject: [PATCH] Squashfs: check the inode number is not the invalid value of zero
Date: Mon,  8 Apr 2024 23:02:06 +0100
Message-Id: <20240408220206.435788-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMWAN3UN0Lo1ziq/4OsLPusrCyJ5+60LKkmiy7J6Jh8MzFLtDThvtVdUr4knNCSUVIAcFcmdaK6aKbfKRK5M0CvqowHtW2HvSjF3tosQB1TzJzeS0dzj
 55S/nG0Yn5Qa0KHAH8iNoVZClKAGTgDRP4WHX4Eg862oyDx1iro4xH5A3662+seQeDjoae/kpSnnWKdbeN6YsRzvu2NYgaLN//bL6cZLSv+MOFWey1Rp+wRD
 yNNx4bg3ZxXTt+F1n1SqJ+b3FnOGf21rpPM9Euv5BckN0cmYL3jHXOi8g78/gfVxkDV+hxwou9XPvS4bqkwV0g==

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
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Closes: https://lore.kernel.org/lkml/87f5c007-b8a5-41ae-8b57-431e924c5915.bugreport@ubisectech.com/
---
 fs/squashfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index aa3411354e66..e0896d8a3cc6 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -48,6 +48,10 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	gid_t i_gid;
 	int err;
 
+	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
+	if(inode->i_ino == 0)
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


