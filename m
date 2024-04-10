Return-Path: <linux-kernel+bounces-138095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9046E89EC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C140B1C20BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6813D8AE;
	Wed, 10 Apr 2024 07:46:29 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6E513D2A2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735188; cv=none; b=YKeQq4ejzKSrc9s2r6IPg+7d2lTDlu4uX5Eo4JUBmnkOVtP2jEbfOGCDgHVUMCJC5HPNgDaGjfzzM9Je6ww2AwYFfMg8grL8rBnOrMKKNbXWWgURdO77mTv3daz8XDI7H8KUlN3AOe1T+ZnKNtmvk43UszrnkolqO70d/A9APKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735188; c=relaxed/simple;
	bh=eVjgfv6c6w9mMdyjEREivPKWmBPpimfOyfdSSj4rIqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIn+LA8zJbz14tMmWVjEyYcV5fJ3jrGkKBLFD+MEWs//n7S5QFUvHzw8BBA8z1OL6fEdDMLDLQcJ1JiQAfFYOkzp8IF4DKzQzDDVRnNVHNP8xdZOiP59JV/9rGBaLYC7Ov7AWfmM5whZv+GskANfmcZrMKSuzrjMEBCX6tu4TUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VDvy11JTjz21kfM;
	Wed, 10 Apr 2024 15:45:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 89DDF18001A;
	Wed, 10 Apr 2024 15:46:24 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:20 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 4/9] ubifs: Remove insert_dead_orphan from replaying orphan process
Date: Wed, 10 Apr 2024 15:37:46 +0800
Message-ID: <20240410073751.2522830-5-chengzhihao1@huawei.com>
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

UBIFS will do commit at the end of mounting process(rw mode), dead
orphans(added by insert_dead_orphan in replaying orphan) are deleted
by ubifs_orphan_end_commit(). The only reason why dead orphans are
added into orphan list is that old orpans may be lost when powercut
happens in ubifs_orphan_end_commit():
ubifs_orphan_end_commit  // TNC(updated by orphans) is not written yet
 if (c->cmt_orphans != 0)
  commit_orphans
   consolidate // traverse orphan list
  write_orph_nodes // rewrite all orphans by ubifs_leb_change
  // If dead orphans are not in list, they will be lost when powercut
  // happens, then TNC won't be updated by old orphans in next mounting.
Luckily, the condition 'c->cmt_orphans != 0' will never be true in
mounting process, there can't be new orphans added into orphan list
before mounting returned, but commit will be done at the end of mounting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/orphan.c | 49 -----------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 88fbf331ad8c..6e843e8fc3db 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -513,51 +513,6 @@ int ubifs_clear_orphans(struct ubifs_info *c)
 	return 0;
 }
 
-/**
- * insert_dead_orphan - insert an orphan.
- * @c: UBIFS file-system description object
- * @inum: orphan inode number
- *
- * This function is a helper to the 'do_kill_orphans()' function. The orphan
- * must be kept until the next commit, so it is added to the rb-tree and the
- * deletion list.
- */
-static int insert_dead_orphan(struct ubifs_info *c, ino_t inum)
-{
-	struct ubifs_orphan *orphan, *o;
-	struct rb_node **p, *parent = NULL;
-
-	orphan = kzalloc(sizeof(struct ubifs_orphan), GFP_KERNEL);
-	if (!orphan)
-		return -ENOMEM;
-	orphan->inum = inum;
-
-	p = &c->orph_tree.rb_node;
-	while (*p) {
-		parent = *p;
-		o = rb_entry(parent, struct ubifs_orphan, rb);
-		if (inum < o->inum)
-			p = &(*p)->rb_left;
-		else if (inum > o->inum)
-			p = &(*p)->rb_right;
-		else {
-			/* Already added - no problem */
-			kfree(orphan);
-			return 0;
-		}
-	}
-	c->tot_orphans += 1;
-	rb_link_node(&orphan->rb, parent, p);
-	rb_insert_color(&orphan->rb, &c->orph_tree);
-	list_add_tail(&orphan->list, &c->orph_list);
-	orphan->del = 1;
-	orphan->dnext = c->orph_dnext;
-	c->orph_dnext = orphan;
-	dbg_mnt("ino %lu, new %d, tot %d", (unsigned long)inum,
-		c->new_orphans, c->tot_orphans);
-	return 0;
-}
-
 /**
  * do_kill_orphans - remove orphan inodes from the index.
  * @c: UBIFS file-system description object
@@ -655,10 +610,6 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 				if (err)
 					goto out_ro;
 			}
-
-			err = insert_dead_orphan(c, inum);
-			if (err)
-				goto out_free;
 		}
 
 		*last_cmt_no = cmt_no;
-- 
2.39.2


