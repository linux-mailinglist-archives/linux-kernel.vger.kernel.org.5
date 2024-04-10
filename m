Return-Path: <linux-kernel+bounces-138099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E4989EC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1879B24531
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264913DDB8;
	Wed, 10 Apr 2024 07:46:30 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1A13D2AA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735189; cv=none; b=LXtDdko8sBmwR7K7Zqq+Vp5P/0I7fY5fRI+rqjlq+qpgjE84Ilz5iCu0F7h9nlXxEhjCkQYoYwTYIPZ2/uGYWz5mLZGbM9k9i+qqhmls0lMuSu7+JHXUopsO4/7R1qs/+GdvgofpjUUbYHKpGtaetmufZE80jaZoeJD33Ez6/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735189; c=relaxed/simple;
	bh=G4+x/gzMfAHDc0HnV9EsKR+APIrtrrMs/uq4LgHmv8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxwpWo6LYktVAqhBRM2yN0/yYQYVe8N7efonh11p9vM8o3lUYSNiKlNWd4ukR2qvcgWKC+2VuV3qMKLqSH1UYnhPLTnWgbDuYteEYfUZw7gOq1XMovltxL4EbnpArzt/shMTXGnlrwLr8uBzVNMSetxwn158BfXgkJOGa0vy9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VDvy13XFZz21kfS;
	Wed, 10 Apr 2024 15:45:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D729F180063;
	Wed, 10 Apr 2024 15:46:24 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:22 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 9/9] ubifs: dbg_orphan_check: Fix missed key type checking
Date: Wed, 10 Apr 2024 15:37:51 +0800
Message-ID: <20240410073751.2522830-10-chengzhihao1@huawei.com>
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

When selinux/encryption is enabled, xattr entry node is added into TNC
before host inode when creating new file. So it is possible to find
xattr entry without host inode from TNC. Orphan debug checking is called
by ubifs_orphan_end_commit(), at that time, the commit semaphore is
already unlock, so the new creation won't be blocked.

Fixes: d7f0b70d30ff ("UBIFS: Add security.* XATTR support for the UBIFS")
Fixes: d475a507457b ("ubifs: Add skeleton for fscrypto")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/orphan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 37d206097112..fb957d963ba6 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -816,8 +816,12 @@ static int dbg_orphan_check(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 
 	inum = key_inum(c, &zbr->key);
 	if (inum != ci->last_ino) {
-		/* Lowest node type is the inode node, so it comes first */
-		if (key_type(c, &zbr->key) != UBIFS_INO_KEY)
+		/*
+		 * Lowest node type is the inode node or xattr entry(when
+		 * selinux/encryption is enabled), so it comes first
+		 */
+		if (key_type(c, &zbr->key) != UBIFS_INO_KEY &&
+		    key_type(c, &zbr->key) != UBIFS_XENT_KEY)
 			ubifs_err(c, "found orphan node ino %lu, type %d",
 				  (unsigned long)inum, key_type(c, &zbr->key));
 		ci->last_ino = inum;
-- 
2.39.2


