Return-Path: <linux-kernel+bounces-151416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585808AAE94
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A49F1C20F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869288565D;
	Fri, 19 Apr 2024 12:35:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50AE823AF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530148; cv=none; b=UDlp8MKHyH0fBH+aN7jQcOHAeIslU2gphdYshQxKI3SKtSq/egkx68S66UZWw/vKmc5j5ZPnXDA3de3/YoKHbEQLyw9ebaPIGKCuHrAucXBliK3bOycd7TRP9BgJCmnDnTzEJQtVz7lLg8qGIIzE7n/u8P+6Vb2c75j4ci0mR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530148; c=relaxed/simple;
	bh=GnFVX9OIGwg6H0/EoZIvZ3A0jnPTJa9SSJChzId3NUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbYz3uCdLISo0J41WfG74ngOhf4bdW+JxnjVdKPBON+klSS8/R36W3rni6pK0LCgMC1WgQ2gEO/EzXGWFperI1231C3+5llmZM+4ZCni3vg6I5L5M4LzjHPjQR/sUVt96OcRsWjNMl3olbmDnzQo4ixEn+sY1wrbHGW7v6wYKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VLYv64GCmzwT1V;
	Fri, 19 Apr 2024 20:32:34 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id F41A218007D;
	Fri, 19 Apr 2024 20:35:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 20:35:39 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH -next v3 2/2] erofs: reliably distinguish block based and fscache mode
Date: Fri, 19 Apr 2024 20:36:11 +0800
Message-ID: <20240419123611.947084-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240419123611.947084-1-libaokun1@huawei.com>
References: <20240419123611.947084-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

From: Christian Brauner <brauner@kernel.org>

When erofs_kill_sb() is called in block dev based mode, s_bdev may not
have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
it will be mistaken for fscache mode, and then attempt to free an anon_dev
that has never been allocated, triggering the following warning:

============================================
ida_free called for id=0 which is not allocated.
WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
Modules linked in:
CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
RIP: 0010:ida_free+0x134/0x140
Call Trace:
 <TASK>
 erofs_kill_sb+0x81/0x90
 deactivate_locked_super+0x35/0x80
 get_tree_bdev+0x136/0x1e0
 vfs_get_tree+0x2c/0xf0
 do_new_mount+0x190/0x2f0
 [...]
============================================

Now when erofs_kill_sb() is called, erofs_sb_info must have been
initialised, so use sbi->fsid to distinguish between the two modes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/erofs/super.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 21faa49bc970..30b49b2eee53 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -789,17 +789,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
 
 static void erofs_kill_sb(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fscache_mode(sb))
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-	sbi = EROFS_SB(sb);
-	if (!sbi)
-		return;
-
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-- 
2.31.1


