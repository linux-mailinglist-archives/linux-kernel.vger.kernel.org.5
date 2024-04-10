Return-Path: <linux-kernel+bounces-138090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1B89EC96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90B5B23054
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D613D297;
	Wed, 10 Apr 2024 07:46:26 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02513D269
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735185; cv=none; b=bVlVtHLZywqU02HWHuPGbcI9BWkvCBSEinBd24rlxcSDlpMAXFstC7nJU4PzNn6YMhwzHR8o/EaItcmloikqxbv4zWaQ3TY9aKxGvW1yUbi0SaMSvfuBKH2yu+8+AbIFD7ag2IjJI1rZD+BubaqXLSUUo/0Lzev8Tp0mTC1iPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735185; c=relaxed/simple;
	bh=wTq3HYhinE4OWJZe3eZJodnF0j/EUVlXkR3PNU1l3dE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9GbV2x2JuTsVKK6acMVbdUrrh3Cuipz3HZPlJd5CrozKfmg5iE75sUBVGyV90WdPdc+kv80p9uZK65UEEBSllj7p+jhL2TC+rEMQasTFC8RLAUCaLTDzrqiW836pRMUXbFDMpSj2X2wYyuFJG2g3FhQovcI0SLXgrGTDQhWm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VDvvj2SvQz1RC5R;
	Wed, 10 Apr 2024 15:43:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 72E8818001A;
	Wed, 10 Apr 2024 15:46:21 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:18 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 1/9] ubifs: Fix unattached xattr inode if powercut happens after deleting
Date: Wed, 10 Apr 2024 15:37:43 +0800
Message-ID: <20240410073751.2522830-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410073751.2522830-1-chengzhihao1@huawei.com>
References: <20240410073751.2522830-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

When powercut happens after deleting file, the xattr inode could be
alone existing in TNC but its' xattr entry cannot be found in TNC.
File inode and xattr inode are added into orphan list after deleting
file, file inode's nlink is 0 but xattr inode's nlink is not 0 (PS:
zero nlink xattr inode is written on disk in evicting process by
ubifs_jnl_write_inode). So, following process could happen:
 1. touch file
 2. setxattr(file)
 3. unlink file
    // inode(nlink=0), xattr inode(nlink=1) are added into orphan list
 4. commit
    // write inode inum and xattr inum into orphan area
 5. powercut
 6. mount
    do_kill_orphans
     // inode(nlink=0) is deleted from TNC by ubifs_tnc_remove_range,
     // xattr entry is deleted too.
     // xattr inode(nlink=1) is not deleted from TNC
Finally we could see following error while debugging UBIFS:
 UBIFS error (ubi0:0 pid 1093): dbg_check_filesystem [ubifs]: inode 66
 nlink is 1, but calculated nlink is 0
 UBIFS (ubi0:0): dump of the inode 66 sitting in LEB 12:2128
   node_type      0 (inode node)
   group_type     1 (in node group)
   len            197
   key            (66, inode)
   size           37
   nlink          1
   flags          0x20
   xattr_cnt      0
   xattr_size     0
   xattr_names    0
   data len       37

Fix it by removing entire inode with it's xattrs while replaying orphan,
just replace function ubifs_tnc_remove_range by ubifs_tnc_remove_ino.

Fixes: ee1438ce5dc4 ("ubifs: Check link count of inodes when killing orphans.")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218661
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/orphan.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 4909321d84cf..ddeb125e6930 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -691,12 +691,12 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 
 		n = (le32_to_cpu(orph->ch.len) - UBIFS_ORPH_NODE_SZ) >> 3;
 		for (i = 0; i < n; i++) {
-			union ubifs_key key1, key2;
+			union ubifs_key key;
 
 			inum = le64_to_cpu(orph->inos[i]);
 
-			ino_key_init(c, &key1, inum);
-			err = ubifs_tnc_lookup(c, &key1, ino);
+			ino_key_init(c, &key, inum);
+			err = ubifs_tnc_lookup(c, &key, ino);
 			if (err && err != -ENOENT)
 				goto out_free;
 
@@ -708,10 +708,7 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 				dbg_rcvry("deleting orphaned inode %lu",
 					  (unsigned long)inum);
 
-				lowest_ino_key(c, &key1, inum);
-				highest_ino_key(c, &key2, inum);
-
-				err = ubifs_tnc_remove_range(c, &key1, &key2);
+				err = ubifs_tnc_remove_ino(c, inum);
 				if (err)
 					goto out_ro;
 			}
-- 
2.39.2


