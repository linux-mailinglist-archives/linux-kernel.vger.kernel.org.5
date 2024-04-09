Return-Path: <linux-kernel+bounces-136763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27289D7E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDAA3B2569D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDD1304AA;
	Tue,  9 Apr 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rAFjy8Df"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31C1272CA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662236; cv=none; b=u0WYyIPRGR12w7s7WqMN26+bRdyjyzpkgtgVQQfrvDcOZajd24+cCtBJLf+3+/vAhBikwODKK2pyf9k83e1IADAt+m/rbgs3R3QyqYeZOQOam1sRC3rQkJr2stWZqoyHGFx7jC4lnHyOx8u3wVXXM8oPq1pIw7l7o/s4UEOUap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662236; c=relaxed/simple;
	bh=1JnlwwUF2e2TkxUPAjgF0lmvZxEqpr6aRqa0G8jxZLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PdxqKL/2yhqkEqOXrNvTA5l4ZH55ANER/qLOVNO9cgRJ7r2t5JpX8hzrhptSRJ7A14hTP2mi+qe7jgqQcOfkOEtM8oooKE5a0Uug68b8QIsoaEoeoq9hTB7BIRB1VJEt6OonUF0jK9danCHdRfTHGiaauArSR9qYT03FzkEXbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rAFjy8Df; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712662225; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=C0zysPX1OGYstO665h3gZ/2br098P35fTMAWwjzjT0Y=;
	b=rAFjy8DfXUnt5fKOnJFE1BQpuRrbw672SRvqyWEpig8xXKGJmzTBI+ViCN7lKeh1qmNFmF/lQVG6oigOE6HfBTP95v05MNpXLaIRk1dNo8chEgg59LZpt9BXp4a1/eFuvWoAPOFKTLy5xMi0QiJJu2t3Hc9TBQQ5m0QJ0zkAs5o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4EQnaa_1712662224;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W4EQnaa_1712662224)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 19:30:25 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: derive fsid from on-disk UUID for .statfs() if possible
Date: Tue,  9 Apr 2024 19:30:22 +0800
Message-Id: <20240409113022.74720-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the superblock's UUID to generate the fsid when it's non-null.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: update the conversion of UUID to fsid, which looks
	cleaner.
v1: https://lore.kernel.org/all/20240409081135.6102-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/super.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c0eb139adb07..58e41dc201fc 100644
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
+		buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
 	return 0;
 }
 
-- 
2.37.1


