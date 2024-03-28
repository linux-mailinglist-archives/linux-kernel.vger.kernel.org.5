Return-Path: <linux-kernel+bounces-123557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B3890B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4B71F27F58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EB913E40D;
	Thu, 28 Mar 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VMYI0U14"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94E13A276;
	Thu, 28 Mar 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657054; cv=none; b=iCz7+2pY2XJUxH9j/JFExawcHZ/b31IE+D8mgkP05fZONgRPPOrWoDIdwx/wfs0u0or8N8i10pT60yS5NRhnCoRODPvKf1gPn3MokLmwE/OzxPBAd1ZtGymW0Z2r4/tjQKBhjpFIPIKjDHzgJG0NNMmLsqheKQJjhTHLLljModo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657054; c=relaxed/simple;
	bh=IJ6RY9lkZcj7kiLJ/UHfsao6ba7AOSSTuR5mppdY7Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YMxattmVB+86ZbPVRxpB10dFFsxC2w9Z6AlXPZ8/ZJPyu8DgJbgcFMYPYeO+J/LyINbIbdNVC3AqsL4jha1hGWtpg3jpiKNnej3L0U1ehh5O7oXJNoXYviqM1kcWEMHuHFWHGa0UtkUOJxwzImvduKN/EIepCrmvTBdDczI3mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VMYI0U14; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id B116F20E6F1E; Thu, 28 Mar 2024 13:17:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B116F20E6F1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711657048;
	bh=GH+6eg5onKDZLo+ketkJRI+qBbcUyUrT3uiZjqG/fK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMYI0U14aUGv5wLjD4iXqv0un8+43SbAn6Rf/U2a/vEEcrR1cz5v1qGViJ64LQ0qk
	 rup8HF+4jxdg4UTant8Q7VxCv5h9LTs4QpO4w/ZKcTiIGFmSoaXrxjmfXXrHLn5JgD
	 Kkx2MO3xnIsbgPnhYy92bsfPCy3kQj1JwNPKbi7c=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: [PATCH v16 06/20] ipe: introduce 'boot_verified' as a trust provider
Date: Thu, 28 Mar 2024 13:17:13 -0700
Message-Id: <1711657047-10526-7-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

IPE is designed to provide system level trust guarantees, this usually
implies that trust starts from bootup with a hardware root of trust,
which validates the bootloader. After this, the bootloader verifies
the kernel and the initramfs.

As there's no currently supported integrity method for initramfs, and
it's typically already verified by the bootloader. This patch introduces
a new IPE property `boot_verified` which allows author of IPE policy to
indicate trust for files from initramfs.

The implementation of this feature utilizes the newly added
`initramfs_populated` hook. This hook marks the superblock of the rootfs
after the initramfs has been unpacked into it.

Before mounting the real rootfs on top of the initramfs, initramfs
script will recursively remove all files and directories on the
initramfs. This is typically implemented by using switch_root(8)
(https://man7.org/linux/man-pages/man8/switch_root.8.html).
Therefore the initramfs will be empty and not accessible after the real
rootfs takes over. It is advised to switch to a different policy
that doesn't rely on the `boot_verified` property after this point.
This ensures that the trust policies remain relevant and effective
throughout the system's operation.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v2:
  +No Changes

v3:
  + Remove useless caching system
  + Move ipe_load_properties to this match
  + Minor changes from checkpatch --strict warnings

v4:
  + Remove comments from headers that was missed previously.
  + Grammatical corrections.

v5:
  + No significant changes

v6:
  + No changes

v7:
  + Reword and refactor patch 04/12 to [09/16], based on changes in
the underlying system.
  + Add common audit function for boolean values
  + Use common audit function as implementation.

v8:
  + No changes

v9:
  + No changes

v10:
  + Replace struct file with struct super_block

v11:
  + Fix code style issues

v12:
  + Switch to use unpack_initramfs hook and security blob

v13:
  + Update the hook name
  + Rename the security blob field to initramfs
  + Remove the dependency on CONFIG_BLK_DEV_INITRD

v14:
  + No changes

v15:
  + No changes

v16:
  + No changes
---
 security/ipe/eval.c          | 37 +++++++++++++++++++++++++++++++++++-
 security/ipe/eval.h          |  5 +++++
 security/ipe/hooks.c         |  6 ++++++
 security/ipe/hooks.h         |  2 ++
 security/ipe/ipe.c           |  8 ++++++++
 security/ipe/ipe.h           |  1 +
 security/ipe/policy.h        |  2 ++
 security/ipe/policy_parser.c | 35 +++++++++++++++++++++++++++++++++-
 8 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 4f425afffcad..bef204decbbf 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -16,6 +16,18 @@
 
 struct ipe_policy __rcu *ipe_active_policy;
 
+#define FILE_SUPERBLOCK(f) ((f)->f_path.mnt->mnt_sb)
+
+/**
+ * build_ipe_sb_ctx - Build initramfs field of an evaluation context.
+ * @ctx: Supplies a pointer to the context to be populated.
+ * @file: Supplies the file struct of the file triggered IPE event.
+ */
+static void build_ipe_sb_ctx(struct ipe_eval_ctx *ctx, const struct file *const file)
+{
+	ctx->initramfs = ipe_sb(FILE_SUPERBLOCK(file))->initramfs;
+}
+
 /**
  * build_eval_ctx - Build an evaluation context.
  * @ctx: Supplies a pointer to the context to be populated.
@@ -28,6 +40,22 @@ void build_eval_ctx(struct ipe_eval_ctx *ctx,
 {
 	ctx->file = file;
 	ctx->op = op;
+
+	if (file)
+		build_ipe_sb_ctx(ctx, file);
+}
+
+/**
+ * evaluate_boot_verified - Evaluate @ctx for the boot verified property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ *
+ * Return:
+ * * true	- The current @ctx match the @p
+ * * false	- The current @ctx doesn't match the @p
+ */
+static bool evaluate_boot_verified(const struct ipe_eval_ctx *const ctx)
+{
+	return ctx->initramfs;
 }
 
 /**
@@ -42,7 +70,14 @@ void build_eval_ctx(struct ipe_eval_ctx *ctx,
 static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
 			      struct ipe_prop *p)
 {
-	return false;
+	switch (p->type) {
+	case IPE_PROP_BOOT_VERIFIED_FALSE:
+		return !evaluate_boot_verified(ctx);
+	case IPE_PROP_BOOT_VERIFIED_TRUE:
+		return evaluate_boot_verified(ctx);
+	default:
+		return false;
+	}
 }
 
 /**
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index cfdf3c8dfe8a..884821494525 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -15,10 +15,15 @@
 
 extern struct ipe_policy __rcu *ipe_active_policy;
 
+struct ipe_superblock {
+	bool initramfs;
+};
+
 struct ipe_eval_ctx {
 	enum ipe_op_type op;
 
 	const struct file *file;
+	bool initramfs;
 };
 
 void build_eval_ctx(struct ipe_eval_ctx *ctx, const struct file *file, enum ipe_op_type op);
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index 3aec88c074e1..23cf070438fa 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/types.h>
 #include <linux/binfmts.h>
 #include <linux/mman.h>
@@ -181,3 +182,8 @@ int ipe_kernel_load_data(enum kernel_load_data_id id, bool contents)
 	build_eval_ctx(&ctx, NULL, op);
 	return ipe_evaluate_event(&ctx);
 }
+
+void ipe_unpack_initramfs(void)
+{
+	ipe_sb(current->fs->root.mnt->mnt_sb)->initramfs = true;
+}
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 23205452f758..21f49cdc2fcd 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -22,4 +22,6 @@ int ipe_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 
 int ipe_kernel_load_data(enum kernel_load_data_id id, bool contents);
 
+void ipe_unpack_initramfs(void);
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 22bd95116087..3bf7c1331d5e 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -5,9 +5,11 @@
 #include <uapi/linux/lsm.h>
 
 #include "ipe.h"
+#include "eval.h"
 #include "hooks.h"
 
 static struct lsm_blob_sizes ipe_blobs __ro_after_init = {
+	.lbs_superblock = sizeof(struct ipe_superblock),
 };
 
 static const struct lsm_id ipe_lsmid = {
@@ -15,12 +17,18 @@ static const struct lsm_id ipe_lsmid = {
 	.id = LSM_ID_IPE,
 };
 
+struct ipe_superblock *ipe_sb(const struct super_block *sb)
+{
+	return sb->s_security + ipe_blobs.lbs_superblock;
+}
+
 static struct security_hook_list ipe_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ipe_bprm_check_security),
 	LSM_HOOK_INIT(mmap_file, ipe_mmap_file),
 	LSM_HOOK_INIT(file_mprotect, ipe_file_mprotect),
 	LSM_HOOK_INIT(kernel_read_file, ipe_kernel_read_file),
 	LSM_HOOK_INIT(kernel_load_data, ipe_kernel_load_data),
+	LSM_HOOK_INIT(initramfs_populated, ipe_unpack_initramfs),
 };
 
 /**
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index a1c68d0fc2e0..fb8f0ad168b3 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -12,5 +12,6 @@
 #define pr_fmt(fmt) "IPE: " fmt
 
 #include <linux/lsm_hooks.h>
+struct ipe_superblock *ipe_sb(const struct super_block *sb);
 
 #endif /* _IPE_H */
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index fb906f41522b..fb48024bb63e 100644
--- a/security/ipe/policy.h
+++ b/security/ipe/policy.h
@@ -30,6 +30,8 @@ enum ipe_action_type {
 #define IPE_ACTION_INVALID __IPE_ACTION_MAX
 
 enum ipe_prop_type {
+	IPE_PROP_BOOT_VERIFIED_FALSE,
+	IPE_PROP_BOOT_VERIFIED_TRUE,
 	__IPE_PROP_MAX
 };
 
diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 612839b405f4..3fc8fea55b95 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -265,6 +265,12 @@ static enum ipe_action_type parse_action(char *t)
 	return match_token(t, action_tokens, args);
 }
 
+static const match_table_t property_tokens = {
+	{IPE_PROP_BOOT_VERIFIED_FALSE,	"boot_verified=FALSE"},
+	{IPE_PROP_BOOT_VERIFIED_TRUE,	"boot_verified=TRUE"},
+	{IPE_PROP_INVALID,		NULL}
+};
+
 /**
  * parse_property - Parse the property type given a token string.
  * @t: Supplies the token string to be parsed.
@@ -277,7 +283,34 @@ static enum ipe_action_type parse_action(char *t)
  */
 static int parse_property(char *t, struct ipe_rule *r)
 {
-	return -EBADMSG;
+	substring_t args[MAX_OPT_ARGS];
+	struct ipe_prop *p = NULL;
+	int rc = 0;
+	int token;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	token = match_token(t, property_tokens, args);
+
+	switch (token) {
+	case IPE_PROP_BOOT_VERIFIED_FALSE:
+	case IPE_PROP_BOOT_VERIFIED_TRUE:
+		p->type = token;
+		break;
+	default:
+		rc = -EBADMSG;
+		break;
+	}
+	if (rc)
+		goto err;
+	list_add_tail(&p->next, &r->props);
+
+	return rc;
+err:
+	kfree(p);
+	return rc;
 }
 
 /**
-- 
2.44.0


