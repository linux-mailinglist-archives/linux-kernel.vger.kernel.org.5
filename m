Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77D7979C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjIGRUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243144AbjIGRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:20:30 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113DA2685
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:20:06 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-770538a2946so135159285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694107139; x=1694711939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T/WqaSkwJ/wvgxciY6xG5yXoKMXUwDNF7ZMhyjAl3dg=;
        b=sKfVXSAO8+tVFs/JKnSUF10ddieWjad38VpvF1F9+l0umnexb2P9PI2299tUhZApoV
         yks2/MthWEqtTlWWif9ApuATuYSpXAyxEPdzaDrYrB1vSl+7OEQQff04C6G+9ZHoWn0S
         sLMJ+e7uHNSnvxcis43PC8Oqs25Nef4bgRqVqZs3Hmk230FDaEy4qfulNoY5xjOtOwpW
         crx9mGCvKZTY71rc2T+xr+MENLNtXhFjj2D+WpmVO44f3AsicKwynJnoclmlrodpJZS8
         NbTVA/VtpGgKw9nNUlV1HA1FPNCdFFV8zz2TP/3jGgttDIFUFtCgP9OApe2Ds6R0mVVe
         VKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694107139; x=1694711939;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/WqaSkwJ/wvgxciY6xG5yXoKMXUwDNF7ZMhyjAl3dg=;
        b=B11l0VflIRfNbis/UzgxWa4Gh3/aM3AHoFCrYQPRWqNelqVHPqPiNdavtqTkWkJw0m
         9UU6TthJxmiTsCCC8iM+HTbcUQWlSQL8BkYMIOtL9FoOG9yLSV/VDwEZv1+NlgFI0qFO
         Unk0bBJ5P4Ktvgn40Gux/GRpNbTW20Si/QpdUZMIajhdU3zITDH7jWn/DlVRLhttDbWH
         vXrjI7IxTeAFclMZ8H1aMAEMGW3R37wLOtWMOkBzN4S0xZGnc7FGO4Z75HIhGYk9K2Y6
         /HQ+SJC2jloacxOJWMtlGQwlfZlPk7Rmmsfk/zYjTqnyA2SrTtQfKbP2yojUltVUGvLT
         44Yg==
X-Gm-Message-State: AOJu0Yz7LSp1dQLJgV+6BencW+lpvcCpJs3jLiALK4FCb85DuVHt+0AU
        /fpKgnyl1BdXMUekC0plkYqcOwSovKNEtA==
X-Google-Smtp-Source: AGHT+IE2Uit7N3S9SR5qftU0oDHFbdy+GAjL3k4RaTzFuKFUAbWpfVTvea/hgEAbk4PmwL4jjFvknP/BCQlIsg==
X-Received: from jiao.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:10f3])
 (user=jiaozhou job=sendgmr) by 2002:a81:b708:0:b0:573:8316:8d04 with SMTP id
 v8-20020a81b708000000b0057383168d04mr5076ywh.4.1694106108565; Thu, 07 Sep
 2023 10:01:48 -0700 (PDT)
Date:   Thu,  7 Sep 2023 17:01:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230907170146.1055954-1-jiaozhou@google.com>
Subject: [PATCH v5] efivarfs: Add uid/gid mount options
From:   Jiao Zhou <jiaozhou@google.com>
To:     Linux FS Development <linux-fsdevel@vger.kernel.org>
Cc:     Jiao Zhou <jiaozhou@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org,
        Matthew Garrett <mgarrett@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow UEFI variables to be modified by non-root processes
in order to run sandboxed code. This doesn't change the behavior 
of mounting efivarfs unless uid/gid are specified; 
by default both are set to root.

Signed-off-by: Jiao Zhou <jiaozhou@google.com>
Acked-by: Matthew Garrett <mgarrett@aurora.tech>
---
Changelog since v1:
- Add missing sentinel entry in fs_parameter_spec[] array.
- Fix a NULL pointer dereference.

Changelog since v2:
- Format the patch description.

Changelog since v3:
- Add gid and uid check to make sure that ids are valid.
- Drop the indentation for one block.
- Use sizeof(*sfi) to allocate memory to avoids future problems if sfi ever changes type.

Changelog since v4:
- Fix the use of sizeof.

---
 fs/efivarfs/inode.c    |  4 +++
 fs/efivarfs/internal.h |  9 +++++
 fs/efivarfs/super.c    | 74 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index db9231f0e77b..06dfc73fda04 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -20,9 +20,13 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 				const struct inode *dir, int mode,
 				dev_t dev, bool is_removable)
 {
+	struct efivarfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = new_inode(sb);
+	struct efivarfs_mount_opts *opts = &fsi->mount_opts;
 
 	if (inode) {
+		inode->i_uid = opts->uid;
+		inode->i_gid = opts->gid;
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
 		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 8ebf3a6a8aa2..c66647f5c0bd 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -9,6 +9,15 @@
 #include <linux/list.h>
 #include <linux/efi.h>
 
+struct efivarfs_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
+};
+
+struct efivarfs_fs_info {
+	struct efivarfs_mount_opts mount_opts;
+};
+
 struct efi_variable {
 	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
 	efi_guid_t    VendorGuid;
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..ba14736ebae0 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -8,6 +8,7 @@
 #include <linux/efi.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/ucs2_string.h>
@@ -24,6 +25,21 @@ static void efivarfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct super_block *sb = root->d_sb;
+	struct efivarfs_fs_info *sbi = sb->s_fs_info;
+	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
+
+	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+				from_kuid_munged(&init_user_ns, opts->uid));
+	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+				from_kgid_munged(&init_user_ns, opts->gid));
+	return 0;
+}
+
 static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	const u32 attr = EFI_VARIABLE_NON_VOLATILE |
@@ -64,6 +80,7 @@ static const struct super_operations efivarfs_ops = {
 	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
 	.evict_inode = efivarfs_evict_inode,
+	.show_options = efivarfs_show_options,
 };
 
 /*
@@ -225,6 +242,45 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 	return 0;
 }
 
+enum {
+	Opt_uid, Opt_gid,
+};
+
+static const struct fs_parameter_spec efivarfs_parameters[] = {
+	fsparam_u32("uid",			Opt_uid),
+	fsparam_u32("gid",			Opt_gid),
+	{},
+};
+
+static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct efivarfs_fs_info *sbi = fc->s_fs_info;
+	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, efivarfs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		opts->uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(opts->uid))
+			return -EINVAL;
+		break;
+	case Opt_gid:
+		opts->gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(opts->gid))
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode = NULL;
@@ -270,11 +326,22 @@ static int efivarfs_get_tree(struct fs_context *fc)
 }
 
 static const struct fs_context_operations efivarfs_context_ops = {
-	.get_tree	= efivarfs_get_tree,
+	.get_tree = efivarfs_get_tree,
+	.parse_param = efivarfs_parse_param,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
 {
+	struct efivarfs_fs_info *sfi;
+
+	sfi = kzalloc(sizeof(*sfi), GFP_KERNEL);
+	if (!sfi)
+		return -ENOMEM;
+
+	sfi->mount_opts.uid = GLOBAL_ROOT_UID;
+	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
+
+	fc->s_fs_info = sfi;
 	fc->ops = &efivarfs_context_ops;
 	return 0;
 }
@@ -291,10 +358,11 @@ static void efivarfs_kill_sb(struct super_block *sb)
 }
 
 static struct file_system_type efivarfs_type = {
-	.owner   = THIS_MODULE,
-	.name    = "efivarfs",
+	.owner = THIS_MODULE,
+	.name = "efivarfs",
 	.init_fs_context = efivarfs_init_fs_context,
 	.kill_sb = efivarfs_kill_sb,
+	.parameters	= efivarfs_parameters,
 };
 
 static __init int efivarfs_init(void)
-- 
2.42.0.283.g2d96d420d3-goog
