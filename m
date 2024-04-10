Return-Path: <linux-kernel+bounces-138097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4402089EC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC128321E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212E13DBA0;
	Wed, 10 Apr 2024 07:46:29 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979413D29B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735189; cv=none; b=VGWrEJEXx0k3O2aee7BI1oqTU2buN+l1wDhHrtzlhq2b1O9Wd8F+iKrFbFUxtmg7KS1q8bDW6iFLswlaZWJwJOSrglmZEbAGyphtuF+6NsMU27+DLYObsEzFnwKMKMKYYHMbZao5EhSATt3+BsEFVLNaP3p/FUy/u+cvbY34Hqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735189; c=relaxed/simple;
	bh=9H9RAnJRufVKhGP+qju09AIocKKgwC7G55YIhfd+DRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChUc+ujAEG7WApapNiwSBQ1oTdlLky2EHeee/VdDwHJFwOeTsRw3jYz32lFWDXAKEUdaZXJfprRTdHZNL1+qf9XhO1pujUQUc+i/8x/E5QJEnhB6Dm4WvMeu2O058ObJdiWlgBAbrLbrM3Nq4GHNpBghJnmgH0nXjT+Anro4vwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VDvvm5zVGz29khB;
	Wed, 10 Apr 2024 15:43:32 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 99225180064;
	Wed, 10 Apr 2024 15:46:24 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:20 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 5/9] ubifs: Fix adding orphan entry twice for the same inode
Date: Wed, 10 Apr 2024 15:37:47 +0800
Message-ID: <20240410073751.2522830-6-chengzhihao1@huawei.com>
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

The tmpfile could be added into orphan list twice, first time is
creation, the second time is removing after it is linked. The orphan
entry could be added twice for tmpfile if following sequence is
satisfied:

ubifs_tmpfile
 ubifs_jnl_update
  ubifs_add_orphan // first time to add orphan entry

    P1                        P2
ubifs_link                 do_commit
                            ubifs_orphan_start_commit
			     orphan->cmt = 1
 ubifs_delete_orphan
  orphan_delete
   if (orph->cmt)
    orph->del = 1; // orphan entry is not deleted from tree
    return
ubifs_unlink
 ubifs_jnl_update
  ubifs_add_orphan
   orphan_add // found old orphan entry, second time to add orphan entry
    ubifs_err(c, "orphaned twice")
    return -EINVAL // unlink failed!
                            ubifs_orphan_end_commit
			     erase_deleted // delete old orphan entry
			      rb_erase(&orphan->rb, &c->orph_tree)

Fix it by removing orphan entry from orphan tree in advance, rather than
remove it from orphan tree in committing process.

Fixes: 32fe905c17f0 ("ubifs: Fix O_TMPFILE corner case in ubifs_link()")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218672
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/orphan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 6e843e8fc3db..37d206097112 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -136,6 +136,7 @@ static void orphan_delete(struct ubifs_info *c, struct ubifs_orphan *orph)
 
 	if (orph->cmt) {
 		orph->del = 1;
+		rb_erase(&orph->rb, &c->orph_tree);
 		orph->dnext = c->orph_dnext;
 		c->orph_dnext = orph;
 		dbg_gen("delete later ino %lu", (unsigned long)orph->inum);
@@ -461,7 +462,6 @@ static void erase_deleted(struct ubifs_info *c)
 		dnext = orphan->dnext;
 		ubifs_assert(c, !orphan->new);
 		ubifs_assert(c, orphan->del);
-		rb_erase(&orphan->rb, &c->orph_tree);
 		list_del(&orphan->list);
 		c->tot_orphans -= 1;
 		dbg_gen("deleting orphan ino %lu", (unsigned long)orphan->inum);
-- 
2.39.2


