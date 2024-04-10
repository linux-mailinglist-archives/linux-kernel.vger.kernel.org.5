Return-Path: <linux-kernel+bounces-138091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE6B89EC95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4851F22496
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C513D2A0;
	Wed, 10 Apr 2024 07:46:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43713A405
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735186; cv=none; b=tnzJSKrWIGtjdoSX1mefDwpAFxVXzWKSNBO+syFAyG0AnDjOmWwe26M0yITPr7nm451fwzkt9G8IoCPGOYDpk33h8h8aA7jRnVdKzk4IOoz1eReleELi8mPFd91F8ZRuP65DE209ZelkmueW9SSajKTb3xJFveeGRbaZPImxfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735186; c=relaxed/simple;
	bh=INjSlanK9XfjHFkoiXnaNur5yuaYf8vOZO36/sJ9GnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0j7Mjd15s4pNaJR6X37NbtSpZ9NLpsWMvFWKSLe0dpCnG6HHR4/sDjsV17jMya4alEg4oNCPHaHHTs4Adbp8Ame+GEzy9Z5K0g/JnB5qPOyT5eDwjBRuuIqk8flN2W2LYu8R93DBddCnr6g1MjVMoHKute9M869gBfrT8W/9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VDvvj5jXgz29dP9;
	Wed, 10 Apr 2024 15:43:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 90AFA18001A;
	Wed, 10 Apr 2024 15:46:21 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:19 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 3/9] Revert "ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path"
Date: Wed, 10 Apr 2024 15:37:45 +0800
Message-ID: <20240410073751.2522830-4-chengzhihao1@huawei.com>
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

This reverts commit 6379b44cdcd67f5f5d986b73953e99700591edfa. Commit
1e022216dcd2 ("ubifs: ubifs_symlink: Fix memleak of inode->i_link in
error path") is applied again in commit 6379b44cdcd6 ("ubifs:
ubifs_symlink: Fix memleak of inode->i_link in error path"), which
changed ubifs_mknod (It won't become a real problem). Just revert it.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index eac0fef801f1..551148de66cd 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1133,8 +1133,6 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	dir_ui->ui_size = dir->i_size;
 	mutex_unlock(&dir_ui->ui_mutex);
 out_inode:
-	/* Free inode->i_link before inode is marked as bad. */
-	fscrypt_free_inode(inode);
 	make_bad_inode(inode);
 	iput(inode);
 out_fname:
-- 
2.39.2


