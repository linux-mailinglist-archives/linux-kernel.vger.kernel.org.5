Return-Path: <linux-kernel+bounces-145049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECBA8A4EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB211F23924
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E176CDCE;
	Mon, 15 Apr 2024 12:17:29 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C56A008
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183447; cv=none; b=MTSp0wLrr5pI9KnQDQVsmi4RlQEc0p9EU+Ak3AnSy7q2gH7DyG6iUwJJt1zH/8XZm0N7S7Q8eWFuWU3Mpmme5N2BYas5XpEQP2ac3nj47fA5xpz4Uw1SIlpU9qJWj4CVv7/We4cyPRD+IYB5cb9QBLB+eUBCFYf8toptBJvZAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183447; c=relaxed/simple;
	bh=/jiMPAHA4Hgspd0jVoWNzbBi1puMkRRhwQ82n/Bi23Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X0TpAJI6rVDZU9gjQ5cIr/4ouMmJm84v8RwcbU2BCxX80+n5VitgIUys/eWHOOXcV0+sM/CC2mvgYDPtHA15Vs9zxDntk5ZDSFmrW7FuMkckluoijEL2UexuNwQkTGM/pdyqBZtQMHrG+RXoePm8Ia1VgP289dFUfpRXc7BAkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VJ5gr4LxTz1hwSk;
	Mon, 15 Apr 2024 20:14:16 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id C694014011F;
	Mon, 15 Apr 2024 20:17:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Apr
 2024 20:17:12 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Date: Mon, 15 Apr 2024 20:17:46 +0800
Message-ID: <20240415121746.1207242-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)

When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
be mistaken for fscache mode, and then attempt to free an anon_dev that has
never been allocated, triggering the following warning:

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

To avoid this problem, add SB_NODEV to fc->sb_flags after successfully
parsing the fsid, and then the superblock inherits this flag when it is
allocated, so that the sb_flags can be used to distinguish whether it is
in block dev based mode when calling erofs_kill_sb().

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/erofs/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b21bd8f78dc1..7539ce7d64bc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -520,6 +520,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
 		if (!ctx->fsid)
 			return -ENOMEM;
+		fc->sb_flags |= SB_NODEV;
 		break;
 	case Opt_domain_id:
 		kfree(ctx->domain_id);
@@ -706,9 +707,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
-
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
+	if (fc->sb_flags & SB_NODEV)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
 	return get_tree_bdev(fc, erofs_fc_fill_super);
@@ -801,7 +800,7 @@ static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 
-	if (erofs_is_fscache_mode(sb))
+	if (sb->s_flags & SB_NODEV)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
-- 
2.31.1


