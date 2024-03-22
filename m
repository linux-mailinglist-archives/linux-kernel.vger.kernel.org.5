Return-Path: <linux-kernel+bounces-111722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55975886FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871E71C2292C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB959163;
	Fri, 22 Mar 2024 15:48:27 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F953E2E;
	Fri, 22 Mar 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122506; cv=none; b=L82Px5+yuMqpBUvYWZYSdBUxYquSdBBortTJI9xAMSVZS2UlQmk7uFOn6YziV18QsSEWJaKzlpq0D65rkb3hAdA2O1a3bUn+2WJf8IsLhV8piw8juqYp5+orkCsF38KymgiTmMJ0K4qIo6XVHqvzA3mjzkZcHPW1JDxKm3Dp3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122506; c=relaxed/simple;
	bh=DdDcIrubg/hyr2/B2kcB4NRchW4qrW7wa41j8k7WttI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fB3ASkDWVUNVWEohxbMeKlbs8pl2mNdEjcj3WZCOts+7q9BG6o6lpy11ZmHRJrxxOECLfddvdbdtF5jtyEa3AwnQBtwdeCJvdLOlioA3/7WgruywPjX847X40kY1TH/uqxrnOybmqSpHLyJuaZWxRFE0jjZWEheMIqrz+IgLoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1RWk0GKhz1xsQj;
	Fri, 22 Mar 2024 23:46:26 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 490B81A016C;
	Fri, 22 Mar 2024 23:48:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 22 Mar
 2024 23:48:20 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>, <corbet@lwn.net>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <lizetao1@huawei.com>, <linux-mtd@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 5/5] ubifs: Introduce ACLs mount options
Date: Fri, 22 Mar 2024 23:48:12 +0800
Message-ID: <20240322154812.215369-6-lizetao1@huawei.com>
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

Implement the ability to enable or disable the ACLs feature through
mount options. "-o acl" option means enable and "-o noacl" means disable
and it is enable by default.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2:
  * Remove redundant assignments to mount.acl.
  * Added the description of acl mount options in ubifs.rst.

v1: https://lore.kernel.org/all/20240319161646.2153867-5-lizetao1@huawei.com/

 Documentation/filesystems/ubifs.rst |  4 +++
 fs/ubifs/super.c                    | 41 +++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h                    |  2 ++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/filesystems/ubifs.rst b/Documentation/filesystems/ubifs.rst
index ced2f7679ddb..f9615104d7a3 100644
--- a/Documentation/filesystems/ubifs.rst
+++ b/Documentation/filesystems/ubifs.rst
@@ -105,6 +105,10 @@ auth_key=		specify the key used for authenticating the filesystem.
 auth_hash_name=		The hash algorithm used for authentication. Used for
 			both hashing and for creating HMACs. Typical values
 			include "sha256" or "sha512"
+noacl			This option disables POSIX Access Control List support. If ACL support
+			is enabled in the kernel configuration (CONFIG_EXT4_FS_POSIX_ACL), ACL
+			is enabled by default on mount. See the acl(5) manual page for more
+			information about acl.
 ====================	=======================================================
 
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 291583005dd1..53ea58ab83f5 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -457,6 +457,13 @@ static int ubifs_show_options(struct seq_file *s, struct dentry *root)
 	seq_printf(s, ",assert=%s", ubifs_assert_action_name(c));
 	seq_printf(s, ",ubi=%d,vol=%d", c->vi.ubi_num, c->vi.vol_id);
 
+#ifdef CONFIG_UBIFS_FS_POSIX_ACL
+	if (c->mount_opts.acl == 2)
+		seq_puts(s, ",acl");
+	else if (c->mount_opts.acl == 1)
+		seq_puts(s, ",noacl");
+#endif
+
 	return 0;
 }
 
@@ -967,6 +974,8 @@ static int check_volume_empty(struct ubifs_info *c)
  * Opt_assert: set ubifs_assert() action
  * Opt_auth_key: The key name used for authentication
  * Opt_auth_hash_name: The hash type used for authentication
+ * Opt_acl: enable posix acl
+ * Opt_noacl: disable posix acl
  * Opt_err: just end of array marker
  */
 enum {
@@ -981,6 +990,8 @@ enum {
 	Opt_auth_key,
 	Opt_auth_hash_name,
 	Opt_ignore,
+	Opt_acl,
+	Opt_noacl,
 	Opt_err,
 };
 
@@ -997,6 +1008,8 @@ static const match_table_t tokens = {
 	{Opt_ignore, "ubi=%s"},
 	{Opt_ignore, "vol=%s"},
 	{Opt_assert, "assert=%s"},
+	{Opt_acl, "acl"},
+	{Opt_noacl, "noacl"},
 	{Opt_err, NULL},
 };
 
@@ -1137,6 +1150,21 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
 			break;
 		case Opt_ignore:
 			break;
+#ifdef CONFIG_UBIFS_FS_POSIX_ACL
+		case Opt_acl:
+			c->mount_opts.acl = 2;
+			break;
+		case Opt_noacl:
+			c->mount_opts.acl = 1;
+			break;
+#else
+		case Opt_acl:
+			ubifs_err(c, "acl options not supported");
+			return -EINVAL;
+		case Opt_noacl:
+			ubifs_err(c, "noacl options not supported");
+			return -EINVAL;
+#endif
 		default:
 		{
 			unsigned long flag;
@@ -2017,6 +2045,12 @@ static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
 		return err;
 	}
 
+#ifdef CONFIG_UBIFS_FS_POSIX_ACL
+	if (c->mount_opts.acl == 1)
+		c->vfs_sb->s_flags &= ~SB_POSIXACL;
+	else
+		c->vfs_sb->s_flags |= SB_POSIXACL;
+#endif
 	if (c->ro_mount && !(*flags & SB_RDONLY)) {
 		if (c->ro_error) {
 			ubifs_msg(c, "cannot re-mount R/W due to prior errors");
@@ -2199,6 +2233,13 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto out_close;
 
+#ifdef CONFIG_UBIFS_FS_POSIX_ACL
+	if (c->mount_opts.acl == 1)
+		c->vfs_sb->s_flags &= ~SB_POSIXACL;
+	else
+		c->vfs_sb->s_flags |= SB_POSIXACL;
+#endif
+
 	/*
 	 * UBIFS provides 'backing_dev_info' in order to disable read-ahead. For
 	 * UBIFS, I/O is not deferred, it is done immediately in read_folio,
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index b96c2462237a..731f433ded68 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -956,6 +956,7 @@ struct ubifs_orphan {
  *                  specified in @compr_type)
  * @compr_type: compressor type to override the superblock compressor with
  *              (%UBIFS_COMPR_NONE, etc)
+ * @acl: enable/disable posix acl (%0 default, %1 disable, %2 enable)
  */
 struct ubifs_mount_opts {
 	unsigned int unmount_mode:2;
@@ -963,6 +964,7 @@ struct ubifs_mount_opts {
 	unsigned int chk_data_crc:2;
 	unsigned int override_compr:1;
 	unsigned int compr_type:2;
+	unsigned int acl:2;
 };
 
 /**
-- 
2.34.1


