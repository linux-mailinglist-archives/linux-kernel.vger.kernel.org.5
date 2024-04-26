Return-Path: <linux-kernel+bounces-159632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB0D8B3157
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3688B224EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446E313C3D1;
	Fri, 26 Apr 2024 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vVEXqZHW"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696C13BC2B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116648; cv=none; b=dJ2UmpTvTSceJ/prlE+LR4MVXRdC7q+harS4kdjMqZDsRak4RNMrIPT19PFEk2rOKZQWMA59L8mgfjKm+px26rNJ73+nAznV6iCJkvWf7zq/voWyVoj7+UL3yTZMC56eyhmIuiOwsZy+DEvfedI/u8KwNjZ7R431qACXFKs0Nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116648; c=relaxed/simple;
	bh=l5QiBjcOva5LgsCUWVhPHkGb5Db5ByV+PGZtR5LTWAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C4N864gqs7395QZQkQMtrUPk1Xbk4JaLDwl13QSDFpb/7r0ughkxG72d78yWhaysoU+lga6TzeDcHK/7/3tNjInXD72/fT23+85CSGWQrpg/vtb21jLuU3MgdNX1MpNfud1FVK0DJQWcnQ4CwuWtJHWICFqJYBNcFz3rDDZaaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vVEXqZHW; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714116642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DQ6r3w+I+fAoQSvNF+oOUgR+CEx6NZvzg3R1b8bRtHg=;
	b=vVEXqZHWZBWkca8nXxKhI3kfdyqVrZe51H0CXsqaXqAu2wrZY8E2oprdFcwXAYmPksFtrN
	3fGrsh5ssjLG70trE6v4YTYCDZYN89NJoas3PIKu6wlhcKn/4S4gHp23HN69VxE1ozI7j6
	KXUq2H24ndtdadz5t3yMi3SguONGZvk=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: Change destroy_inode to free_inode
Date: Fri, 26 Apr 2024 15:29:56 +0800
Message-Id: <20240426072956.7727-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

The vfs[1] documentation describes free_inode as follows:
```
free_inode
    this method is called from RCU callback. If you use call_rcu()
    in ->destroy_inode to free ‘struct inode’ memory, then it’s
    better to release memory in this method.
```

free_inode will be called by the RCU callback, so it might be better
to move the inode free operation to destroy_inode.

Similar to commit ae6b47b5653e ("fs/ntfs3: Change destroy_inode to
free_inode").

Link:
[1]: https://www.kernel.org/doc/html/latest/filesystems/vfs.html

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index afb57ea99431..c82ee192a2e2 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1511,17 +1511,9 @@ static void bch2_vfs_inode_init(struct btree_trans *trans, subvol_inum inum,
 	mapping_set_large_folios(inode->v.i_mapping);
 }
 
-static void bch2_i_callback(struct rcu_head *head)
+static void bch2_free_inode(struct inode *vinode)
 {
-	struct inode *vinode = container_of(head, struct inode, i_rcu);
-	struct bch_inode_info *inode = to_bch_ei(vinode);
-
-	kmem_cache_free(bch2_inode_cache, inode);
-}
-
-static void bch2_destroy_inode(struct inode *vinode)
-{
-	call_rcu(&vinode->i_rcu, bch2_i_callback);
+	kmem_cache_free(bch2_inode_cache, to_bch_ei(vinode));
 }
 
 static int inode_update_times_fn(struct btree_trans *trans,
@@ -1829,7 +1821,7 @@ static int bch2_unfreeze(struct super_block *sb)
 
 static const struct super_operations bch_super_operations = {
 	.alloc_inode	= bch2_alloc_inode,
-	.destroy_inode	= bch2_destroy_inode,
+	.free_inode	= bch2_free_inode,
 	.write_inode	= bch2_vfs_write_inode,
 	.evict_inode	= bch2_evict_inode,
 	.sync_fs	= bch2_sync_fs,
-- 
2.34.1


