Return-Path: <linux-kernel+bounces-107845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B16880269
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809381F24BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B3849C;
	Tue, 19 Mar 2024 16:34:59 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD970111A1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866099; cv=none; b=jwNXvcJzyLx+5ClCXL9P2ifV3nivl+FOm8E3l0DEmMVU52fteqnyVOl5hgVzp068L6mcDkvtnw73/ClzLtJe1e4jd1xja8Bek/CBTxtT/xvkYVkjVNIV1RWRDGd/6zDE/xcA9O7hcQGvxEGqZOJbbEuGAcSp0zZX9xYl6dt66G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866099; c=relaxed/simple;
	bh=0/4QRrWBcVmnwDDUbZA1MxL5kl40PY4/kO7kvJvx2JE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlHPJgw4YE7VkQE63KBJsbvASgIU/k49jhMfm3/+OoDpY3QIoeOHqSmBmmhIGvgEhmvTnCl9iY/H9gSRMYicKhS4dVscermz63fyEcOOYGbMLz1XFKXLVKcvIOGOBb5n6dMgNJplHR1lbNL7uiY0o0jtnPIeF5rHOTDO8nr8Fpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TzcHj1RB5z1Q9nB;
	Wed, 20 Mar 2024 00:14:41 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AC8A14040D;
	Wed, 20 Mar 2024 00:16:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 20 Mar
 2024 00:16:55 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>
CC: <lizetao1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
Subject: [RFC PATCH 3/5] ubifs: Support accessing ACLs through inode_operations
Date: Wed, 20 Mar 2024 00:16:44 +0800
Message-ID: <20240319161646.2153867-4-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319161646.2153867-1-lizetao1@huawei.com>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Register the get/set interfaces to the inode operations whilch
allows access to the ACL through the vfs layer.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ubifs/dir.c  | 2 ++
 fs/ubifs/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index dfb6823cc953..59784349ba21 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1724,6 +1724,8 @@ const struct inode_operations ubifs_dir_inode_operations = {
 	.setattr     = ubifs_setattr,
 	.getattr     = ubifs_getattr,
 	.listxattr   = ubifs_listxattr,
+	.get_inode_acl = ubifs_get_inode_acl,
+	.set_acl     = ubifs_set_acl,
 	.update_time = ubifs_update_time,
 	.tmpfile     = ubifs_tmpfile,
 	.fileattr_get = ubifs_fileattr_get,
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 8f964f8b0f96..80def8734b13 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1665,6 +1665,8 @@ const struct inode_operations ubifs_file_inode_operations = {
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


