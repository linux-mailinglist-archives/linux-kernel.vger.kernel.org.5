Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44499797846
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjIGQpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjIGQpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:45:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8321B1BFB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:44:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so12569077b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694105027; x=1694709827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dUxh38L3ayN3NN/LJvYi1H0xhcT6Df4QILSfV/pw6ZE=;
        b=JWzY8KHa4FYnYYKu2BE/wSTG6k6HBkTZREOJ7XAPx8epBIKwU/CzUDij+5LdIxNgZ/
         M62IzIzUFUHsipwDfI9PG9bYbJpLI3ESl/6V+BsDJQn/r27ABnZdhqhZmBVPniUGCIy5
         CR1q6S/SI+/COSGifJGUqgwuLGk02QaWsPK9dr0eXCmZoc/8D5nB/ln8vtvvp0E9UPn5
         D+24XKoU+bjk1cQ1GthQM3Rk7vV7TdUcqvzzc/og5hGrtrotdxcS6V09JxA4KqyFcHC5
         JCzRpRqUr8gF7Yn4P3vUlPQtPqDQ+VxRukFQJ0z2gffEbgJxhDELgYkQrKD/hGk8cKoA
         COcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694105027; x=1694709827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUxh38L3ayN3NN/LJvYi1H0xhcT6Df4QILSfV/pw6ZE=;
        b=tcTM4VzV6Fybb/kvblJMSxcpjeqK0sqpaY3qjKmaTOvZXZMe+PZ/oc4ZXEcRh8M3u9
         kkfGNbKzL99WZ7N/qdBaosZF2GXzv1jYUMnr4re47Ax9GztjS1e/1YrcfSIHo71H+yb2
         Ux/vhlieaC4GB92QDOmcKgg1rUmnGUYDpfSQSgVHBMgxpDgPUZo0pDIXLpYKiGH8bpQy
         v8MfvilwO5LSxwYectM+yjkaqAE1NCWl/dv+o9MoNJCQ9dlaeAsQqZo7YLKtwLRCLEOl
         kufmWzjWRXoqB5HWWE14qrTwWnVSQ2Y8QB8MRI5+OtBUIcCG7zZCSrU5KtRhIO6yy8i6
         pS1Q==
X-Gm-Message-State: AOJu0Yzp0uzakn+7EzVOyIWfF1WCORuX53xD9EDzx9t7Pt/3llVrKOQ0
        3UQ8Y13zKk0pvO31eYo7orUWNPt5uhQgQw==
X-Google-Smtp-Source: AGHT+IFcp+tGWlVPIKf8K18rRH9EtPFpnkl5HnM0JLtjKuzxX6WRGnUfrh6BQq0EpOEUnXJYCYRHnfDsKqDEyg==
X-Received: from jiao.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:10f3])
 (user=jiaozhou job=sendgmr) by 2002:a81:ac02:0:b0:589:a644:d328 with SMTP id
 k2-20020a81ac02000000b00589a644d328mr2946ywh.9.1694105027126; Thu, 07 Sep
 2023 09:43:47 -0700 (PDT)
Date:   Thu,  7 Sep 2023 16:43:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230907164341.1051637-1-jiaozhou@google.com>
Subject: [PATCH v4] efivarfs: Add uid/gid mount options
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
- Use sizeof(*sfi) to allocate memory to avoids future problems if sfi ever changes type.
- Add gid and uid check to make sure that ids are valid.
- Drop the indentation for one block.

 fs/efivarfs/inode.c    |  4 +++
 fs/efivarfs/internal.h |  9 +++++
 fs/efivarfs/super.c    | 75 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 85 insertions(+), 3 deletions(-)

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
index e028fafa04f3..c53cebf45ac5 100644
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
@@ -24,6 +25,22 @@ static void efivarfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
+static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct super_block *sb = root->d_sb;
+	struct efivarfs_fs_info *sbi = sb->s_fs_info;
+	struct efivarfs_mount_opts *opts = &sbi->mount_opts;
+
+	/* Show partition info */
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
@@ -64,6 +81,7 @@ static const struct super_operations efivarfs_ops = {
 	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
 	.evict_inode = efivarfs_evict_inode,
+	.show_options = efivarfs_show_options,
 };
 
 /*
@@ -225,6 +243,45 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
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
@@ -270,11 +327,22 @@ static int efivarfs_get_tree(struct fs_context *fc)
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
+	sfi = kzalloc(sizeof(struct efivarfs_fs_info), GFP_KERNEL);
+	if (!sizeof(*sfi))
+		return -ENOMEM;
+
+	sfi->mount_opts.uid = GLOBAL_ROOT_UID;
+	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
+
+	fc->s_fs_info = sfi;
 	fc->ops = &efivarfs_context_ops;
 	return 0;
 }
@@ -291,10 +359,11 @@ static void efivarfs_kill_sb(struct super_block *sb)
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

