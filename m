Return-Path: <linux-kernel+bounces-105061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B087D8AB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1756B21D42
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF775BAF4;
	Sat, 16 Mar 2024 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fbxQN5Sm"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D929A0;
	Sat, 16 Mar 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710560162; cv=none; b=k3lmoBJNwkNmogDz/uqqoztIs+AInh3ApUGBJPS0r1agm+tbj8sw0MJ0JOwVEnIFCg4INQAvcUZOJsrIn3k/zBNmeoKr8kXuIxKFjGlYgUzXwxd4mPaYH2jyXP29v4KPquuUp6XUOdsJkjtBFHezJ0RhfeHA1bvdFssfM+jZYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710560162; c=relaxed/simple;
	bh=chouuRn6JlL454N/fbTP6WYuL/uNLH+Sfu2b9YmCRso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KfnZ5WbBGGSczrSuS07XEALmeY162CKJ6u3a24bwOPeM9LTe0PajyM1Hs/2VpgPmnFoqR8eOH6+qiTn6w7AENg5eHxxBDxaMbilb3QlnoVXg0I1q+9F9gg40VjWnd2xwjypYJxziI6JX4TgDSGKLu3SvpYVJVhDhfsPB39Nen8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fbxQN5Sm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 1227920B74C2; Fri, 15 Mar 2024 20:35:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1227920B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710560154;
	bh=9pxMgXN8lAVaCetpBtDzc6EwCFzyMc9KJukWvZGTJlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbxQN5SmNOzcdY4zO8cDKmuhqfMtPGxmsLtHxG+4xQkqE33BgR1k66FsB1GdA8WT3
	 +0elh81N3KL3+IKNK2EK/FI2OXJYTXW91JKAQp42IfyGLJWKgusMyVzzgZiMOAL945
	 C3vOcuMpfBLM/T2vzvUYJwRDmeWlzIAUXzuIOhJ4=
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
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [RFC PATCH v15 15/21] ipe: add support for dm-verity as a trust provider
Date: Fri, 15 Mar 2024 20:35:45 -0700
Message-Id: <1710560151-28904-16-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Deven Bowers <deven.desai@linux.microsoft.com>

Allows author of IPE policy to indicate trust for a singular dm-verity
volume, identified by roothash, through "dmverity_roothash" and all
signed dm-verity volumes, through "dmverity_signature".

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v2:
  + No Changes

v3:
  + No changes

v4:
  + No changes

v5:
  + No changes

v6:
  + Fix an improper cleanup that can result in
    a leak

v7:
  + Squash patch 08/12, 10/12 to [11/16]

v8:
  + Undo squash of 08/12, 10/12 - separating drivers/md/ from security/
    & block/
  + Use common-audit function for dmverity_signature.
  + Change implementation for storing the dm-verity digest to use the
    newly introduced dm_verity_digest structure introduced in patch
    14/20.

v9:
  + Adapt to the new parser

v10:
  + Select the Kconfig when all dependencies are enabled

v11:
  + No changes

v12:
  + Refactor to use struct digest_info* instead of void*
  + Correct audit format

v13:
  + Remove the CONFIG_IPE_PROP_DM_VERITY dependency inside the parser
    to make the policy grammar independent of the kernel config.

v14:
  + No changes

v15:
  + Fix one grammar issue in KCONFIG
  + Switch to use security_bdev_setintegrity() hook
---
 security/ipe/Kconfig         |  18 ++++++
 security/ipe/Makefile        |   1 +
 security/ipe/audit.c         |  29 ++++++++-
 security/ipe/digest.c        | 120 +++++++++++++++++++++++++++++++++++
 security/ipe/digest.h        |  26 ++++++++
 security/ipe/eval.c          |  91 +++++++++++++++++++++++++-
 security/ipe/eval.h          |  10 +++
 security/ipe/hooks.c         |  67 +++++++++++++++++++
 security/ipe/hooks.h         |   8 +++
 security/ipe/ipe.c           |  15 +++++
 security/ipe/ipe.h           |   4 ++
 security/ipe/policy.h        |   3 +
 security/ipe/policy_parser.c |  24 ++++++-
 13 files changed, 412 insertions(+), 4 deletions(-)
 create mode 100644 security/ipe/digest.c
 create mode 100644 security/ipe/digest.h

diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index ac4d558e69d5..5433ca3fc855 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -8,6 +8,7 @@ menuconfig SECURITY_IPE
 	depends on SECURITY && SECURITYFS && AUDIT && AUDITSYSCALL
 	select PKCS7_MESSAGE_PARSER
 	select SYSTEM_DATA_VERIFICATION
+	select IPE_PROP_DM_VERITY if DM_VERITY && DM_VERITY_VERIFY_ROOTHASH_SIG
 	help
 	  This option enables the Integrity Policy Enforcement LSM
 	  allowing users to define a policy to enforce a trust-based access
@@ -15,3 +16,20 @@ menuconfig SECURITY_IPE
 	  admins to reconfigure trust requirements on the fly.
 
 	  If unsure, answer N.
+
+if SECURITY_IPE
+menu "IPE Trust Providers"
+
+config IPE_PROP_DM_VERITY
+	bool "Enable support for dm-verity volumes"
+	depends on DM_VERITY && DM_VERITY_VERIFY_ROOTHASH_SIG
+	help
+	  This option enables the properties 'dmverity_signature' and
+	  'dmverity_roothash' in IPE policy. These properties evaluate
+	  to TRUE when a file is evaluated against a dm-verity volume
+	  that was mounted with a signed root-hash or the volume's
+	  root hash matches the supplied value in the policy.
+
+endmenu
+
+endif
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 2279eaa3cea3..66de53687d11 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -6,6 +6,7 @@
 #
 
 obj-$(CONFIG_SECURITY_IPE) += \
+	digest.o \
 	eval.o \
 	hooks.o \
 	fs.o \
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index a480f27278df..3acbfecc9f43 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -13,6 +13,7 @@
 #include "hooks.h"
 #include "policy.h"
 #include "audit.h"
+#include "digest.h"
 
 #define ACTSTR(x) ((x) == IPE_ACTION_ALLOW ? "ALLOW" : "DENY")
 
@@ -49,8 +50,22 @@ static const char *const audit_hook_names[__IPE_HOOK_MAX] = {
 static const char *const audit_prop_names[__IPE_PROP_MAX] = {
 	"boot_verified=FALSE",
 	"boot_verified=TRUE",
+	"dmverity_roothash=",
+	"dmverity_signature=FALSE",
+	"dmverity_signature=TRUE",
 };
 
+/**
+ * audit_dmv_roothash - audit the roothash of a dmverity_roothash property.
+ * @ab: Supplies a pointer to the audit_buffer to append to.
+ * @rh: Supplies a pointer to the digest structure.
+ */
+static void audit_dmv_roothash(struct audit_buffer *ab, const void *rh)
+{
+	audit_log_format(ab, "%s", audit_prop_names[IPE_PROP_DMV_ROOTHASH]);
+	ipe_digest_audit(ab, rh);
+}
+
 /**
  * audit_rule - audit an IPE policy rule approximation.
  * @ab: Supplies a pointer to the audit_buffer to append to.
@@ -62,8 +77,18 @@ static void audit_rule(struct audit_buffer *ab, const struct ipe_rule *r)
 
 	audit_log_format(ab, " rule=\"%s ", audit_op_names[r->op]);
 
-	list_for_each_entry(ptr, &r->props, next)
-		audit_log_format(ab, "%s ", audit_prop_names[ptr->type]);
+	list_for_each_entry(ptr, &r->props, next) {
+		switch (ptr->type) {
+		case IPE_PROP_DMV_ROOTHASH:
+			audit_dmv_roothash(ab, ptr->value);
+			break;
+		default:
+			audit_log_format(ab, "%s", audit_prop_names[ptr->type]);
+			break;
+		}
+
+		audit_log_format(ab, " ");
+	}
 
 	audit_log_format(ab, "action=%s\"", ACTSTR(r->action));
 }
diff --git a/security/ipe/digest.c b/security/ipe/digest.c
new file mode 100644
index 000000000000..f6fde0b1fe74
--- /dev/null
+++ b/security/ipe/digest.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "digest.h"
+
+/**
+ * ipe_digest_parse - parse a digest in IPE's policy.
+ * @valstr: Supplies the string parsed from the policy.
+ *
+ * Digests in IPE are defined in a standard way:
+ *	<alg_name>:<hex>
+ *
+ * Use this function to create a property to parse the digest
+ * consistently. The parsed digest will be saved in @value in IPE's
+ * policy.
+ *
+ * Return: The parsed digest_info structure.
+ */
+struct digest_info *ipe_digest_parse(const char *valstr)
+{
+	char *sep, *raw_digest;
+	size_t raw_digest_len;
+	int rc = 0;
+	char *alg = NULL;
+	u8 *digest = NULL;
+	struct digest_info *info = NULL;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	sep = strchr(valstr, ':');
+	if (!sep) {
+		rc = -EBADMSG;
+		goto err;
+	}
+
+	alg = kstrndup(valstr, sep - valstr, GFP_KERNEL);
+	if (!alg) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	raw_digest = sep + 1;
+	raw_digest_len = strlen(raw_digest);
+
+	info->digest_len = (raw_digest_len + 1) / 2;
+	digest = kzalloc(info->digest_len, GFP_KERNEL);
+	if (!digest) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	rc = hex2bin(digest, raw_digest, info->digest_len);
+	if (rc < 0) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	info->alg = alg;
+	info->digest = digest;
+	return info;
+
+err:
+	kfree(alg);
+	kfree(digest);
+	kfree(info);
+	return ERR_PTR(rc);
+}
+
+/**
+ * ipe_digest_eval - evaluate an IPE digest against another digest.
+ * @expected: Supplies the policy-provided digest value.
+ * @digest: Supplies the digest to compare against the policy digest value.
+ *
+ * Return:
+ * * true	- digests match
+ * * false	- digests do not match
+ */
+bool ipe_digest_eval(const struct digest_info *expected,
+		     const struct digest_info *digest)
+{
+	return (expected->digest_len == digest->digest_len) &&
+	       (!strcmp(expected->alg, digest->alg)) &&
+	       (!memcmp(expected->digest, digest->digest, expected->digest_len));
+}
+
+/**
+ * ipe_digest_free - free an IPE digest.
+ * @info: Supplies a pointer the policy-provided digest to free.
+ */
+void ipe_digest_free(struct digest_info *info)
+{
+	if (IS_ERR_OR_NULL(info))
+		return;
+
+	kfree(info->alg);
+	kfree(info->digest);
+	kfree(info);
+}
+
+/**
+ * ipe_digest_audit - audit a digest that was sourced from IPE's policy.
+ * @ab: Supplies the audit_buffer to append the formatted result.
+ * @info: Supplies a pointer to source the audit record from.
+ *
+ * Digests in IPE are defined in a standard way:
+ *	<alg_name>:<hex>
+ *
+ * Use this function to create a property to audit the digest
+ * consistently.
+ */
+void ipe_digest_audit(struct audit_buffer *ab, const struct digest_info *info)
+{
+	audit_log_untrustedstring(ab, info->alg);
+	audit_log_format(ab, ":");
+	audit_log_n_hex(ab, info->digest, info->digest_len);
+}
diff --git a/security/ipe/digest.h b/security/ipe/digest.h
new file mode 100644
index 000000000000..13fa67071805
--- /dev/null
+++ b/security/ipe/digest.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#ifndef _IPE_DIGEST_H
+#define _IPE_DIGEST_H
+
+#include <linux/types.h>
+#include <linux/audit.h>
+
+#include "policy.h"
+
+struct digest_info {
+	const char *alg;
+	const u8 *digest;
+	size_t digest_len;
+};
+
+struct digest_info *ipe_digest_parse(const char *valstr);
+void ipe_digest_free(struct digest_info *digest_info);
+void ipe_digest_audit(struct audit_buffer *ab, const struct digest_info *val);
+bool ipe_digest_eval(const struct digest_info *expected,
+		     const struct digest_info *digest);
+
+#endif /* _IPE_DIGEST_H */
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 3f3125478dd0..8dcf7809c9fc 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -15,10 +15,12 @@
 #include "eval.h"
 #include "policy.h"
 #include "audit.h"
+#include "digest.h"
 
 struct ipe_policy __rcu *ipe_active_policy;
 bool success_audit;
 bool enforce = true;
+#define INO_BLOCK_DEV(ino) ((ino)->i_sb->s_bdev)
 
 #define FILE_SUPERBLOCK(f) ((f)->f_path.mnt->mnt_sb)
 
@@ -32,6 +34,23 @@ static void build_ipe_sb_ctx(struct ipe_eval_ctx *ctx, const struct file *const
 	ctx->initramfs = ipe_sb(FILE_SUPERBLOCK(file))->initramfs;
 }
 
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+/**
+ * build_ipe_bdev_ctx - Build ipe_bdev field of an evaluation context.
+ * @ctx: Supplies a pointer to the context to be populated.
+ * @ino: Supplies the inode struct of the file triggered IPE event.
+ */
+static void build_ipe_bdev_ctx(struct ipe_eval_ctx *ctx, const struct inode *const ino)
+{
+	if (INO_BLOCK_DEV(ino))
+		ctx->ipe_bdev = ipe_bdev(INO_BLOCK_DEV(ino));
+}
+#else
+static void build_ipe_bdev_ctx(struct ipe_eval_ctx *ctx, const struct inode *const ino)
+{
+}
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 /**
  * build_eval_ctx - Build an evaluation context.
  * @ctx: Supplies a pointer to the context to be populated.
@@ -48,8 +67,10 @@ void build_eval_ctx(struct ipe_eval_ctx *ctx,
 	ctx->op = op;
 	ctx->hook = hook;
 
-	if (file)
+	if (file) {
 		build_ipe_sb_ctx(ctx, file);
+		build_ipe_bdev_ctx(ctx, d_real_inode(file->f_path.dentry));
+	}
 }
 
 /**
@@ -65,6 +86,68 @@ static bool evaluate_boot_verified(const struct ipe_eval_ctx *const ctx)
 	return ctx->initramfs;
 }
 
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+/**
+ * evaluate_dmv_roothash - Evaluate @ctx against a dmv roothash property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ * @p: Supplies a pointer to the property being evaluated.
+ *
+ * Return:
+ * * true	- The current @ctx match the @p
+ * * false	- The current @ctx doesn't match the @p
+ */
+static bool evaluate_dmv_roothash(const struct ipe_eval_ctx *const ctx,
+				  struct ipe_prop *p)
+{
+	return !!ctx->ipe_bdev &&
+	       !!ctx->ipe_bdev->root_hash &&
+	       ipe_digest_eval(p->value,
+			       ctx->ipe_bdev->root_hash);
+}
+
+/**
+ * evaluate_dmv_sig_false: Analyze @ctx against a dmv sig false property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ *
+ * Return:
+ * * true	- The current @ctx match the property
+ * * false	- The current @ctx doesn't match the property
+ */
+static bool evaluate_dmv_sig_false(const struct ipe_eval_ctx *const ctx)
+{
+	return !ctx->ipe_bdev || (!ctx->ipe_bdev->dm_verity_signed);
+}
+
+/**
+ * evaluate_dmv_sig_true: Analyze @ctx against a dmv sig true property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ *
+ * Return:
+ * * true	- The current @ctx match the property
+ * * false	- The current @ctx doesn't match the property
+ */
+static bool evaluate_dmv_sig_true(const struct ipe_eval_ctx *const ctx)
+{
+	return !evaluate_dmv_sig_false(ctx);
+}
+#else
+static bool evaluate_dmv_roothash(const struct ipe_eval_ctx *const ctx,
+				  struct ipe_prop *p)
+{
+	return false;
+}
+
+static bool evaluate_dmv_sig_false(const struct ipe_eval_ctx *const ctx)
+{
+	return false;
+}
+
+static bool evaluate_dmv_sig_true(const struct ipe_eval_ctx *const ctx)
+{
+	return false;
+}
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 /**
  * evaluate_property - Analyze @ctx against a property.
  * @ctx: Supplies a pointer to the context to be evaluated.
@@ -82,6 +165,12 @@ static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
 		return !evaluate_boot_verified(ctx);
 	case IPE_PROP_BOOT_VERIFIED_TRUE:
 		return evaluate_boot_verified(ctx);
+	case IPE_PROP_DMV_ROOTHASH:
+		return evaluate_dmv_roothash(ctx, p);
+	case IPE_PROP_DMV_SIG_FALSE:
+		return evaluate_dmv_sig_false(ctx);
+	case IPE_PROP_DMV_SIG_TRUE:
+		return evaluate_dmv_sig_true(ctx);
 	default:
 		return false;
 	}
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index 0b50302611a4..494c0754f512 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -22,12 +22,22 @@ struct ipe_superblock {
 	bool initramfs;
 };
 
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+struct ipe_bdev {
+	bool dm_verity_signed;
+	struct digest_info *root_hash;
+};
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 struct ipe_eval_ctx {
 	enum ipe_op_type op;
 	enum ipe_hook_type hook;
 
 	const struct file *file;
 	bool initramfs;
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+	const struct ipe_bdev *ipe_bdev;
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
 };
 
 enum ipe_match {
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index 6bcc7908ed13..1abddd6e1e7f 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -8,10 +8,14 @@
 #include <linux/types.h>
 #include <linux/binfmts.h>
 #include <linux/mman.h>
+#include <linux/blk_types.h>
+#include <linux/dm-verity.h>
+#include <crypto/hash_info.h>
 
 #include "ipe.h"
 #include "hooks.h"
 #include "eval.h"
+#include "digest.h"
 
 /**
  * ipe_bprm_check_security - ipe security hook function for bprm check.
@@ -187,3 +191,66 @@ void ipe_unpack_initramfs(void)
 {
 	ipe_sb(current->fs->root.mnt->mnt_sb)->initramfs = true;
 }
+
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+/**
+ * ipe_bdev_free_security - free IPE's LSM blob of block_devices.
+ * @bdev: Supplies a pointer to a block_device that contains the structure
+ *	  to free.
+ */
+void ipe_bdev_free_security(struct block_device *bdev)
+{
+	struct ipe_bdev *blob = ipe_bdev(bdev);
+
+	ipe_digest_free(blob->root_hash);
+}
+
+/**
+ * ipe_bdev_setintegrity - save integrity data from a bdev to IPE's LSM blob.
+ * @bdev: Supplies a pointer to a block_device that contains the LSM blob.
+ * @type: Supplies the integrity type.
+ * @value: Supplies the value to store.
+ * @len: The length of @value.
+ */
+int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_intgr_type type,
+			  const void *value, size_t len)
+{
+	struct ipe_bdev *blob = ipe_bdev(bdev);
+
+	if (type == LSM_INTGR_DMV_ROOTHASH) {
+		const struct dm_verity_digest *digest = value;
+		struct digest_info *info = NULL;
+		u8 *raw_digest = NULL;
+		char *alg = NULL;
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+
+		raw_digest = kmemdup(digest->digest, digest->digest_len,
+				     GFP_KERNEL);
+		if (!raw_digest)
+			goto err;
+
+		alg = kstrdup(digest->alg, GFP_KERNEL);
+		if (!alg)
+			goto err;
+
+		info->alg = alg;
+		info->digest = raw_digest;
+		info->digest_len = digest->digest_len;
+		blob->root_hash = info;
+		return 0;
+err:
+		kfree(info);
+		kfree(raw_digest);
+		kfree(alg);
+		return -ENOMEM;
+	} else if (type == LSM_INTGR_DMV_SIG) {
+		blob->dm_verity_signed = true;
+		return 0;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index b92c1d78e253..6b735aac4028 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/binfmts.h>
 #include <linux/security.h>
+#include <linux/blk_types.h>
 
 enum ipe_hook_type {
 	IPE_HOOK_BPRM_CHECK = 0,
@@ -35,4 +36,11 @@ int ipe_kernel_load_data(enum kernel_load_data_id id, bool contents);
 
 void ipe_unpack_initramfs(void);
 
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+void ipe_bdev_free_security(struct block_device *bdev);
+
+int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_intgr_type type,
+			  const void *value, size_t len);
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 53820ca6d5b7..3d63e9672f12 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -7,11 +7,15 @@
 #include "ipe.h"
 #include "eval.h"
 #include "hooks.h"
+#include "eval.h"
 
 bool ipe_enabled;
 
 static struct lsm_blob_sizes ipe_blobs __ro_after_init = {
 	.lbs_superblock = sizeof(struct ipe_superblock),
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+	.lbs_bdev = sizeof(struct ipe_bdev),
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
 };
 
 static const struct lsm_id ipe_lsmid = {
@@ -24,6 +28,13 @@ struct ipe_superblock *ipe_sb(const struct super_block *sb)
 	return sb->s_security + ipe_blobs.lbs_superblock;
 }
 
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+struct ipe_bdev *ipe_bdev(struct block_device *b)
+{
+	return b->security + ipe_blobs.lbs_bdev;
+}
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 static struct security_hook_list ipe_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ipe_bprm_check_security),
 	LSM_HOOK_INIT(mmap_file, ipe_mmap_file),
@@ -31,6 +42,10 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(kernel_read_file, ipe_kernel_read_file),
 	LSM_HOOK_INIT(kernel_load_data, ipe_kernel_load_data),
 	LSM_HOOK_INIT(initramfs_populated, ipe_unpack_initramfs),
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+	LSM_HOOK_INIT(bdev_free_security, ipe_bdev_free_security),
+	LSM_HOOK_INIT(bdev_setintegrity, ipe_bdev_setintegrity),
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
 };
 
 /**
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index 86c2b8394d93..64626702b689 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -16,4 +16,8 @@ struct ipe_superblock *ipe_sb(const struct super_block *sb);
 
 extern bool ipe_enabled;
 
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+struct ipe_bdev *ipe_bdev(struct block_device *b);
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 #endif /* _IPE_H */
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index dba5e71e089e..35629e9699f7 100644
--- a/security/ipe/policy.h
+++ b/security/ipe/policy.h
@@ -33,6 +33,9 @@ enum ipe_action_type {
 enum ipe_prop_type {
 	IPE_PROP_BOOT_VERIFIED_FALSE,
 	IPE_PROP_BOOT_VERIFIED_TRUE,
+	IPE_PROP_DMV_ROOTHASH,
+	IPE_PROP_DMV_SIG_FALSE,
+	IPE_PROP_DMV_SIG_TRUE,
 	__IPE_PROP_MAX
 };
 
diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 3fc8fea55b95..802e31f14b22 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -11,6 +11,7 @@
 
 #include "policy.h"
 #include "policy_parser.h"
+#include "digest.h"
 
 #define START_COMMENT	'#'
 #define IPE_POLICY_DELIM " \t"
@@ -216,6 +217,7 @@ static void free_rule(struct ipe_rule *r)
 
 	list_for_each_entry_safe(p, t, &r->props, next) {
 		list_del(&p->next);
+		ipe_digest_free(p->value);
 		kfree(p);
 	}
 
@@ -268,6 +270,9 @@ static enum ipe_action_type parse_action(char *t)
 static const match_table_t property_tokens = {
 	{IPE_PROP_BOOT_VERIFIED_FALSE,	"boot_verified=FALSE"},
 	{IPE_PROP_BOOT_VERIFIED_TRUE,	"boot_verified=TRUE"},
+	{IPE_PROP_DMV_ROOTHASH,		"dmverity_roothash=%s"},
+	{IPE_PROP_DMV_SIG_FALSE,	"dmverity_signature=FALSE"},
+	{IPE_PROP_DMV_SIG_TRUE,		"dmverity_signature=TRUE"},
 	{IPE_PROP_INVALID,		NULL}
 };
 
@@ -287,6 +292,7 @@ static int parse_property(char *t, struct ipe_rule *r)
 	struct ipe_prop *p = NULL;
 	int rc = 0;
 	int token;
+	char *dup = NULL;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
@@ -295,8 +301,22 @@ static int parse_property(char *t, struct ipe_rule *r)
 	token = match_token(t, property_tokens, args);
 
 	switch (token) {
+	case IPE_PROP_DMV_ROOTHASH:
+		dup = match_strdup(&args[0]);
+		if (!dup) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		p->value = ipe_digest_parse(dup);
+		if (IS_ERR(p->value)) {
+			rc = PTR_ERR(p->value);
+			goto err;
+		}
+		fallthrough;
 	case IPE_PROP_BOOT_VERIFIED_FALSE:
 	case IPE_PROP_BOOT_VERIFIED_TRUE:
+	case IPE_PROP_DMV_SIG_FALSE:
+	case IPE_PROP_DMV_SIG_TRUE:
 		p->type = token;
 		break;
 	default:
@@ -307,10 +327,12 @@ static int parse_property(char *t, struct ipe_rule *r)
 		goto err;
 	list_add_tail(&p->next, &r->props);
 
+out:
+	kfree(dup);
 	return rc;
 err:
 	kfree(p);
-	return rc;
+	goto out;
 }
 
 /**
-- 
2.44.0


