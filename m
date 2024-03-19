Return-Path: <linux-kernel+bounces-107822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305088021A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6ECC283462
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E48A83CB0;
	Tue, 19 Mar 2024 16:17:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5983A11
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865021; cv=none; b=Hf7sPowV3U6Qwa+FeuIfx+KN/QgmT/hTz0aV4IqxoWAfcVuT5OHHMDeeuwbSj4fcDEK1l3IKQfSWR17k+sZ+2XhJMtG52Ikf2+zbbxnzb68t4UaMilww2yKjJpPScTrkJpgJ0+VQzza2a7hTN8O9rrhKLQ4zftvqkaQPLSy8+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865021; c=relaxed/simple;
	bh=emJA4rgmgnd/+JcRUIlMPIJB8sezta6Apcgb/jZWgu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYKP6+mRbG6E5TEYteF9o9eaIg1B2pfSUzS0Qm/jWtFnnGFzXqZPgZdiuucGoBkZRIU1cvci9EC28Nr/FzIsTxIFrrku1oBqp51IWdJGSshEp6qetpr87adJcA8qOMjVV/c3dPzn2HGpEoWIfcDCYUkMvGggd3sXmIBZz7HJoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TzcHM5Q6dz2Bgb9;
	Wed, 20 Mar 2024 00:14:23 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D3A514013B;
	Wed, 20 Mar 2024 00:16:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 20 Mar
 2024 00:16:56 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>
CC: <lizetao1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
Subject: [RFC PATCH 4/5] ubifs: Introduce ACLs mount options
Date: Wed, 20 Mar 2024 00:16:45 +0800
Message-ID: <20240319161646.2153867-5-lizetao1@huawei.com>
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

Implement the ability to enable or disable the ACLs feature through
mount options. "-o acl" option means enable and "-o noacl" means disable
and it is enable by default.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ubifs/super.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 7f4031a15f4d..ed03bf11e51d 100644
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
 
@@ -1137,6 +1150,23 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
 			break;
 		case Opt_ignore:
 			break;
+#ifdef CONFIG_UBIFS_FS_POSIX_ACL
+		case Opt_acl:
+			c->mount_opts.acl = 2;
+			c->vfs_sb->s_flags |= SB_POSIXACL;
+			break;
+		case Opt_noacl:
+			c->mount_opts.acl = 1;
+			c->vfs_sb->s_flags &= ~SB_POSIXACL;
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
@@ -2011,12 +2041,17 @@ static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
 	sync_filesystem(sb);
 	dbg_gen("old flags %#lx, new flags %#x", sb->s_flags, *flags);
 
+	c->mount_opts.acl = 0;
 	err = ubifs_parse_options(c, data, 1);
 	if (err) {
 		ubifs_err(c, "invalid or unknown remount parameter");
 		return err;
 	}
 
+#ifdef CONFIG_UBIFS_FS_POSIX_ACL
+	if (!c->mount_opts.acl)
+		c->vfs_sb->s_flags |= SB_POSIXACL;
+#endif
 	if (c->ro_mount && !(*flags & SB_RDONLY)) {
 		if (c->ro_error) {
 			ubifs_msg(c, "cannot re-mount R/W due to prior errors");
@@ -2197,6 +2232,11 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto out_close;
 
+#ifdef CONFIG_UBIFS_FS_POSIX_ACL
+	if (!c->mount_opts.acl)
+		c->vfs_sb->s_flags |= SB_POSIXACL;
+#endif
+
 	/*
 	 * UBIFS provides 'backing_dev_info' in order to disable read-ahead. For
 	 * UBIFS, I/O is not deferred, it is done immediately in read_folio,
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index b0d3b076290d..4a6078cbb2f5 100644
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


