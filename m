Return-Path: <linux-kernel+bounces-138094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CEE89EC99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116A81C210EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8DA13D622;
	Wed, 10 Apr 2024 07:46:28 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975B13D299
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735188; cv=none; b=m0dJaSoCZmq+IBqhlRzAkCLQe5f/xyR0uzd38R2igCVqBz3VceSIk8sTu9hr4mrVSmCikFLsFs+fBvvWwee42XOq39omkfuwVNOZXTSZpq0muzDuQCj5XAnQ026YrbdKw4i6cmdHkOTf76aNHpfvkh1myF0G4eI49NOt9YjL59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735188; c=relaxed/simple;
	bh=6enRpkCtRRhSMRNuro77x5hwv78gHH59C5x6cX07ujA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWYYScdF0/ll7luBjMkwko1Gsf0nM0l8Ybje3yH08c4s/EdoaYcINgLTcsmRuz41xedM4gplP++2GV8qUk/yPHc1GNouBAiZIe7RZV9BUsoqxKUZ0/bFN5ATt8qSCTWNtoaHiHFaTFQ7ML5kWprbg7PP9fHQcpJFQSEAcO947nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VDvvm6Jn4z29lMv;
	Wed, 10 Apr 2024 15:43:32 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A876218001A;
	Wed, 10 Apr 2024 15:46:24 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:21 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 6/9] ubifs: Move ui->data initialization after initializing security
Date: Wed, 10 Apr 2024 15:37:48 +0800
Message-ID: <20240410073751.2522830-7-chengzhihao1@huawei.com>
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

Host inode and its' xattr will be written on disk after initializing
security when creating symlink or dev, then the host inode and its
dentry will be written again in ubifs_jnl_update.
There is no need to write inode data in the security initialization
pass, just move the ui->data initialization after initializing
security.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/dir.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 551148de66cd..848988f2b7dc 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1102,16 +1102,18 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_fname;
 	}
 
+	err = ubifs_init_security(dir, inode, &dentry->d_name);
+	if (err) {
+		kfree(dev);
+		goto out_inode;
+	}
+
 	init_special_inode(inode, inode->i_mode, rdev);
 	inode->i_size = ubifs_inode(inode)->ui_size = devlen;
 	ui = ubifs_inode(inode);
 	ui->data = dev;
 	ui->data_len = devlen;
 
-	err = ubifs_init_security(dir, inode, &dentry->d_name);
-	if (err)
-		goto out_inode;
-
 	mutex_lock(&dir_ui->ui_mutex);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
@@ -1184,6 +1186,10 @@ static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_fname;
 	}
 
+	err = ubifs_init_security(dir, inode, &dentry->d_name);
+	if (err)
+		goto out_inode;
+
 	ui = ubifs_inode(inode);
 	ui->data = kmalloc(disk_link.len, GFP_NOFS);
 	if (!ui->data) {
@@ -1209,10 +1215,6 @@ static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	ui->data_len = disk_link.len - 1;
 	inode->i_size = ubifs_inode(inode)->ui_size = disk_link.len - 1;
 
-	err = ubifs_init_security(dir, inode, &dentry->d_name);
-	if (err)
-		goto out_inode;
-
 	mutex_lock(&dir_ui->ui_mutex);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-- 
2.39.2


