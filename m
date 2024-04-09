Return-Path: <linux-kernel+bounces-136419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900B89D3E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8488B20C97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AF7F7D0;
	Tue,  9 Apr 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hbG4V3kt"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC37F7F4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650305; cv=none; b=EmDysqJ0AhFS+qsK7PZ6XrtCjts86HmmQCYb37MLBnI26Hrd94W/l5i6M7BANMhoY77g7MOJTMJpeyouXpVdjHCQhmQZBF1/ua7Jfe5sXXP2r+nmWceWVvWfw3I+CYJy6VL6AV7akBgzKYNQ2wMfSriwykuNFKiaOsbmtAHdJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650305; c=relaxed/simple;
	bh=+aw7U+mPGyyIrnXa9PNm0Q0W2Q65jpN/hN/rR612pPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QpUCABUHgb5yntK+RcSqbq+g5H6VtMPtoHodmgSnbJbt+CLA1RyCrOAnVomiyUL38yQZTKwHB2Bq8Q6hY/bPwgA9RLtcCCcFP+T80sDYm6XovmDmHjSnsuKqJUiFrhj4HGZKC5IVcRZbhnX89mbmuTOzVKIsVYRyeHH9atL8rNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hbG4V3kt; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712650299; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=89xpcFLgtVH4lcATuVDEdqCce7EFZbuNNRadjDj3dIM=;
	b=hbG4V3kt6TWsMygWs75e+enp+t8m/Q9aXrOoZK8+ykchB7WEZYrzzZgMaS1Od5DoKZZmR5NytJZTPlkKr6LSvPmvtUheUfQz0FJy8Rwz/uD7DU7ScuJHuq2i6fAOHC9nC7TnT64iP37+P+RMhTN4o9MHQo9kRffe9OZL9FoT2tM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4DtF.b_1712650297;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W4DtF.b_1712650297)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 16:11:38 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH] erofs: derive fsid from on-disk UUID for .statfs() if possible
Date: Tue,  9 Apr 2024 16:11:35 +0800
Message-Id: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the superblock's UUID to generate the fsid when it's non-null.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/super.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c0eb139adb07..83bd8ee3b5ba 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -923,22 +923,20 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	u64 id = 0;
-
-	if (!erofs_is_fscache_mode(sb))
-		id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = sbi->total_blocks;
 	buf->f_bfree = buf->f_bavail = 0;
-
 	buf->f_files = ULLONG_MAX;
 	buf->f_ffree = ULLONG_MAX - sbi->inos;
-
 	buf->f_namelen = EROFS_NAME_LEN;
 
-	buf->f_fsid    = u64_to_fsid(id);
+	if (uuid_is_null(&sb->s_uuid))
+		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
+				huge_encode_dev(sb->s_bdev->bd_dev));
+	else
+		buf->f_fsid = uuid_to_fsid((__u8 *)&sb->s_uuid);
 	return 0;
 }
 
-- 
2.37.1


