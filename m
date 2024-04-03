Return-Path: <linux-kernel+bounces-130495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DAA8978EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8CE1F28546
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA91552FC;
	Wed,  3 Apr 2024 19:19:01 +0000 (UTC)
Received: from sxb1plsmtpa01-15.prod.sxb1.secureserver.net (sxb1plsmtpa01-15.prod.sxb1.secureserver.net [92.204.81.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3A1D54B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171941; cv=none; b=kMwwnbwShKYRVg0mBFpdMus5C+QZKHKUdW8kQtzoKlLHRbHBjneOCqpPZzX4DgMxoTFg9xIM/WO+d1+vUZBLm9ARy1Z2xMSESR2oCqRETpikN474zH+eGqqvTJyaEh3O92qkK7Vw1SDse4ZIeJmOYJmhxhgq0Sf4ox/lK4yQ+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171941; c=relaxed/simple;
	bh=NrcmZ271a8xN2jxJj5BFmWWaKucfI/V6Nb0sIwEp+oM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XVHWw38N7CQFwtmuzEV97ttuP32kmKf4C3F1PX6EsRa84tvwirHWVJlGkpWkzXDpWPJXjYw+G+qkH+AgdkCCKd1HoM6c+nfcgSsAvZGaotZ8eLidLmY6icHopbOzGTLOpLAWIdD29Dx/1oqrEUX3bNswrsdUSSh2bhiv0nDre3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id s5QureLOS8TQvs5R7rECRT; Wed, 03 Apr 2024 11:34:14 -0700
X-CMAE-Analysis: v=2.4 cv=WqXgMsfv c=1 sm=1 tr=0 ts=660da126
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=hfclLu6IeWhw0SyEGDUA:9 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: justinstitt@google.com,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH] Squashfs: remove deprecated strncpy by not copying the string
Date: Wed,  3 Apr 2024 19:33:52 +0100
Message-Id: <20240403183352.391308-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEWXQMK4iiFZ5Wdc9WmQreTGJMY+VbKNnL2L72ogZI/HQO038k8RfaYooA/XFBzNhqKPt2itSp58GH55M1zH9cHzaHDXAHb30o6YSj+LThoY44mw8qMF
 p8X6pdKENg81Koub31NmQgNmao4GSxSVv2/F4IcF+KS+dRI/AvxYHORbTbiiN4wmsDN6Gxlj+0xxdeA/CPYWl4HD95XjVUyoYeQYY/p8TUOi2dWtohq66p8B
 UDGhk/+uc70xxsQUEgl7MihyjExW/qSrF5F9A7cF5JJIm8GOuHPrFM2gPorts5BA4k4FZzA9b1tFg59g59cRbQ==

Squashfs copied the passed string (name) into a temporary buffer
to ensure it was NUL-terminated.  This however is completely
unnecessary as the string is already NUL-terminated.  So remove
the deprecated strncpy() by completely removing the string copy.

The background behind this unnecessary string copy is that it
dates back to the days when Squashfs was an out of kernel patch.
The code deliberately did not assume the string was NUL-terminated
in case in future this changed (due to kernel changes).  This
would mean the out of tree patches would be broken but still
compile OK.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/namei.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index 11e4539b9eae..65aae7e2a859 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -62,27 +62,21 @@
  */
 static int get_dir_index_using_name(struct super_block *sb,
 			u64 *next_block, int *next_offset, u64 index_start,
-			int index_offset, int i_count, const char *name,
-			int len)
+			int index_offset, int i_count, const char *name)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	int i, length = 0, err;
 	unsigned int size;
 	struct squashfs_dir_index *index;
-	char *str;
 
 	TRACE("Entered get_dir_index_using_name, i_count %d\n", i_count);
 
-	index = kmalloc(sizeof(*index) + SQUASHFS_NAME_LEN * 2 + 2, GFP_KERNEL);
+	index = kmalloc(sizeof(*index) + SQUASHFS_NAME_LEN + 1, GFP_KERNEL);
 	if (index == NULL) {
 		ERROR("Failed to allocate squashfs_dir_index\n");
 		goto out;
 	}
 
-	str = &index->name[SQUASHFS_NAME_LEN + 1];
-	strncpy(str, name, len);
-	str[len] = '\0';
-
 	for (i = 0; i < i_count; i++) {
 		err = squashfs_read_metadata(sb, index, &index_start,
 					&index_offset, sizeof(*index));
@@ -101,7 +95,7 @@ static int get_dir_index_using_name(struct super_block *sb,
 
 		index->name[size] = '\0';
 
-		if (strcmp(index->name, str) > 0)
+		if (strcmp(index->name, name) > 0)
 			break;
 
 		length = le32_to_cpu(index->index);
@@ -153,7 +147,7 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 	length = get_dir_index_using_name(dir->i_sb, &block, &offset,
 				squashfs_i(dir)->dir_idx_start,
 				squashfs_i(dir)->dir_idx_offset,
-				squashfs_i(dir)->dir_idx_cnt, name, len);
+				squashfs_i(dir)->dir_idx_cnt, name);
 
 	while (length < i_size_read(dir)) {
 		/*
-- 
2.39.2


