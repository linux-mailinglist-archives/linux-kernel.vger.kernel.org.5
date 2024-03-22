Return-Path: <linux-kernel+bounces-111724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98814887000
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389831F22799
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675505D749;
	Fri, 22 Mar 2024 15:48:28 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065C53E35;
	Fri, 22 Mar 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122508; cv=none; b=m+UMU7n1SLHgYKIS0tsTZqznQI4y/aEQ95Hre66DHCS231sxDaMENAxyGesabGWG7p27850BOzyYwLXc31FIQriicxmT4XV1bcJXj8wXl37ERtenfoA06F+LaU5gKF4oitGO5rlIHizmRo23b77iXulXNbRlgdHYkwXvVsKugHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122508; c=relaxed/simple;
	bh=jAV3wG65mVIM9sN+DM5zCoOHpnvAHQ0i29dSaE4H518=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKcZ578kJKVxOHkjETjniWDvtbHODZw/mNGqc8uIEuep0VT0Jez7hcK5J9j9HjGnvtjg3swBXHDBvmbA/Y4AVqyNgNFSSy0rvfSWR93g+FqmlMgvb5/SEEHfvF9BfrPaOzmQV7AlilOrXcHDhoA8LJ171VPnA3JoA4qhb9V/YEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V1RYR1YfSz1GClV;
	Fri, 22 Mar 2024 23:47:55 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id D7F271400CF;
	Fri, 22 Mar 2024 23:48:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 22 Mar
 2024 23:48:20 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>, <corbet@lwn.net>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <lizetao1@huawei.com>, <linux-mtd@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 4/5] ubifs: Support accessing ACLs through inode_operations
Date: Fri, 22 Mar 2024 23:48:11 +0800
Message-ID: <20240322154812.215369-5-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322154812.215369-1-lizetao1@huawei.com>
References: <20240322154812.215369-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Register the get/set interfaces to the inode operations whilch
allows access to the ACL through the vfs layer.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: There are no changes to this patch.
v1: https://lore.kernel.org/all/20240319161646.2153867-4-lizetao1@huawei.com/

 fs/ubifs/dir.c  | 2 ++
 fs/ubifs/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 243dfb478984..145ada316a46 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1730,6 +1730,8 @@ const struct inode_operations ubifs_dir_inode_operations = {
 	.setattr     = ubifs_setattr,
 	.getattr     = ubifs_getattr,
 	.listxattr   = ubifs_listxattr,
+	.get_inode_acl = ubifs_get_inode_acl,
+	.set_acl     = ubifs_set_acl,
 	.update_time = ubifs_update_time,
 	.tmpfile     = ubifs_tmpfile,
 	.fileattr_get = ubifs_fileattr_get,
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 808a2ded4f8c..ba428af0a235 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1664,6 +1664,8 @@ const struct inode_operations ubifs_file_inode_operations = {
 	.setattr     = ubifs_setattr,
 	.getattr     = ubifs_getattr,
 	.listxattr   = ubifs_listxattr,
+	.get_inode_acl = ubifs_get_inode_acl,
+	.set_acl      = ubifs_set_acl,
 	.update_time = ubifs_update_time,
 	.fileattr_get = ubifs_fileattr_get,
 	.fileattr_set = ubifs_fileattr_set,
-- 
2.34.1


