Return-Path: <linux-kernel+bounces-143482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347068A39FB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A8F1C215E2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE571B4E;
	Sat, 13 Apr 2024 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fzT59qIb"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85E18AED;
	Sat, 13 Apr 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969776; cv=none; b=W530r3UCcR9SHvt6KX8e0+JzdePM/nLaTUZKZJTADMhuFl38DQ7m77hNMdrmetxkQgMy3gq+3G/uZOIXhZ23wLR6UQ25ZVRud7gK5U8xG7gX18BsaYyIojW5v75uUGGKXCbUgKYWseByTkIHi1quSZIkx77+az8pbbFh7Gng4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969776; c=relaxed/simple;
	bh=Pa7KgSc2DGGxuA3N86+F8fQ8CJK4UEgojKkGdWTM05U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZO4I3RPAgldQLp3R7xZzuNdFZlHdHdF8bSzzvD05OFbfADSnMgBpmwfnCF9q65MHgF//MmRSnkhHDG/4+XN95pBo7KXTJEzVgflC+/cFwpUfw0a4uOaOv3ALYbUlfmgctcBVMSyhklLN7PXkFneMb+sLKNIM/khhg/xTetbmpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fzT59qIb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 496EE20FC5EE; Fri, 12 Apr 2024 17:56:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 496EE20FC5EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712969766;
	bh=BVwConVT+U5QEL/palka5IPZtAxmbk2wjprs5ZdRDTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzT59qIbSRTqTrRung91Y14FOiadnni0CpoROJldb25HgR99QrcDnqvRBbV2vK/6U
	 j8s63QsoyHVuhnfy0CqvXJMoyySaSRVlnWfMvxPu1T69P1w1iZExUPBCNFWJc9H1MF
	 q+CWeIPoJs9wQqPd/i9vJfmuZcOGrD6mDhSEN+48=
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
Subject: [PATCH v17 14/21] ipe: add support for dm-verity as a trust provider
Date: Fri, 12 Apr 2024 17:55:57 -0700
Message-Id: <1712969764-31039-15-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
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

v16:
  + Refactor for enum integrity type

v17:
  + Add years to license header
  + Fix code and documentation style issues
  + Return -EINVAL in ipe_bdev_setintegrity when passed type is not
    supported
  + Use new enum name LSM_INT_DMVERITY_SIG_VALID
---
 security/ipe/Kconfig         |  18 ++++++
 security/ipe/Makefile        |   1 +
 security/ipe/audit.c         |  29 ++++++++-
 security/ipe/digest.c        | 118 +++++++++++++++++++++++++++++++++++
 security/ipe/digest.h        |  26 ++++++++
 security/ipe/eval.c          |  91 ++++++++++++++++++++++++++-
 security/ipe/eval.h          |  10 +++
 security/ipe/hooks.c         |  78 +++++++++++++++++++++++
 security/ipe/hooks.h         |   8 +++
 security/ipe/ipe.c           |  15 +++++
 security/ipe/ipe.h           |   4 ++
 security/ipe/policy.h        |   3 +
 security/ipe/policy_parser.c |  24 ++++++-
 13 files changed, 421 insertions(+), 4 deletions(-)
 create mode 100644 security/ipe/digest.c
 create mode 100644 security/ipe/digest.h

diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index ac4d558e69d5..6179752c614f 100644
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
+	  that was mounted with a valid signed root-hash or the
+	  volume's root hash matches the supplied value in the policy.
+
+endmenu
+
+endif
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 62caccba14b4..e1019bb9f0f3 100644
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
index a416291ba477..2c98520267c1 100644
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
+ * audit_dmv_roothash() - audit the roothash of a dmverity_roothash property.
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
  * audit_rule() - audit an IPE policy rule.
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
index 000000000000..493716370570
--- /dev/null
+++ b/security/ipe/digest.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2024 Microsoft Corporation. All rights reserved.
+ */
+
+#include "digest.h"
+
+/**
+ * ipe_digest_parse() - parse a digest in IPE's policy.
+ * @valstr: Supplies the string parsed from the policy.
+ *
+ * Digests in IPE are defined in a standard way:
+ *	<alg_name>:<hex>
+ *
+ * Use this function to create a property to parse the digest
+ * consistently. The parsed digest will be saved in @value in IPE's
+ * policy.
+ *
+ * Return: The parsed digest_info structure on success. If an error occurs,
+ * the function will return the error value (via ERR_PTR).
+ */
+struct digest_info *ipe_digest_parse(const char *valstr)
+{
+	struct digest_info *info = NULL;
+	char *sep, *raw_digest;
+	size_t raw_digest_len;
+	u8 *digest = NULL;
+	char *alg = NULL;
+	int rc = 0;
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
+ * ipe_digest_eval() - evaluate an IPE digest against another digest.
+ * @expected: Supplies the policy-provided digest value.
+ * @digest: Supplies the digest to compare against the policy digest value.
+ *
+ * Return:
+ * * %true	- digests match
+ * * %false	- digests do not match
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
+ * ipe_digest_free() - free an IPE digest.
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
+ * ipe_digest_audit() - audit a digest that was sourced from IPE's policy.
+ * @ab: Supplies the audit_buffer to append the formatted result.
+ * @info: Supplies a pointer to source the audit record from.
+ *
+ * Digests in IPE are audited in this format:
+ *	<alg_name>:<hex>
+ */
+void ipe_digest_audit(struct audit_buffer *ab, const struct digest_info *info)
+{
+	audit_log_untrustedstring(ab, info->alg);
+	audit_log_format(ab, ":");
+	audit_log_n_hex(ab, info->digest, info->digest_len);
+}
diff --git a/security/ipe/digest.h b/security/ipe/digest.h
new file mode 100644
index 000000000000..52c9b3844a38
--- /dev/null
+++ b/security/ipe/digest.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2024 Microsoft Corporation. All rights reserved.
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
index dd9064974be6..477f0d0ffda8 100644
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
+ * build_ipe_bdev_ctx() - Build ipe_bdev field of an evaluation context.
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
  * ipe_build_eval_ctx() - Build an ipe evaluation context.
  * @ctx: Supplies a pointer to the context to be populated.
@@ -48,8 +67,10 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx *ctx,
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
+ * evaluate_dmv_roothash() - Evaluate @ctx against a dmv roothash property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ * @p: Supplies a pointer to the property being evaluated.
+ *
+ * Return:
+ * * %true	- The current @ctx match the @p
+ * * %false	- The current @ctx doesn't match the @p
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
+ * evaluate_dmv_sig_false() - Evaluate @ctx against a dmv sig false property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ *
+ * Return:
+ * * %true	- The current @ctx match the property
+ * * %false	- The current @ctx doesn't match the property
+ */
+static bool evaluate_dmv_sig_false(const struct ipe_eval_ctx *const ctx)
+{
+	return !ctx->ipe_bdev || (!ctx->ipe_bdev->dm_verity_signed);
+}
+
+/**
+ * evaluate_dmv_sig_true() - Evaluate @ctx against a dmv sig true property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ *
+ * Return:
+ * * %true	- The current @ctx match the property
+ * * %false	- The current @ctx doesn't match the property
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
  * evaluate_property() - Analyze @ctx against a rule property.
  * @ctx: Supplies a pointer to the context to be evaluated.
@@ -85,6 +168,12 @@ static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
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
index 80b74f55fa69..aa29e8036c48 100644
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
index b68719bf44fb..5d4a9abb9c44 100644
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
  * ipe_bprm_check_security() - ipe security hook function for bprm check.
@@ -191,3 +195,77 @@ void ipe_unpack_initramfs(void)
 {
 	ipe_sb(current->fs->root.mnt->mnt_sb)->initramfs = true;
 }
+
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+/**
+ * ipe_bdev_free_security() - Free IPE's LSM blob of block_devices.
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
+ * ipe_bdev_setintegrity() - Save integrity data from a bdev to IPE's LSM blob.
+ * @bdev: Supplies a pointer to a block_device that contains the LSM blob.
+ * @type: Supplies the integrity type.
+ * @value: Supplies the value to store.
+ * @size: The size of @value.
+ *
+ * This hook is currently used to save dm-verity's root hash or the existence
+ * of a validated signed dm-verity root hash into LSM blob.
+ *
+ * Return: %0 on success. If an error occurs, the function will return the
+ * -errno.
+ */
+int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type type,
+			  const void *value, size_t size)
+{
+	const struct dm_verity_digest *digest = NULL;
+	struct ipe_bdev *blob = ipe_bdev(bdev);
+	struct digest_info *info = NULL;
+
+	if (type == LSM_INT_DMVERITY_ROOTHASH) {
+		if (!value) {
+			ipe_digest_free(blob->root_hash);
+			blob->root_hash = NULL;
+
+			return 0;
+		}
+		digest = value;
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+
+		info->digest = kmemdup(digest->digest, digest->digest_len,
+				       GFP_KERNEL);
+		if (!info->digest)
+			goto dmv_roothash_err;
+
+		info->alg = kstrdup(digest->alg, GFP_KERNEL);
+		if (!info->alg)
+			goto dmv_roothash_err;
+
+		info->digest_len = digest->digest_len;
+
+		blob->root_hash = info;
+
+		return 0;
+dmv_roothash_err:
+		ipe_digest_free(info);
+
+		return -ENOMEM;
+	} else if (type == LSM_INT_DMVERITY_SIG_VALID) {
+		blob->dm_verity_signed = size > 0 && value;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index f4f0b544ddcc..4d585fb6ada3 100644
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
+int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type type,
+			  const void *value, size_t len);
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 53f2196b9bcc..99cb42caa63a 100644
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
index 4aa18d1d0525..01f46286e383 100644
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
index ffd60cc7fda6..26776092c710 100644
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
index 84cc688be3a2..71c84b293029 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -11,6 +11,7 @@
 
 #include "policy.h"
 #include "policy_parser.h"
+#include "digest.h"
 
 #define START_COMMENT	'#'
 #define IPE_POLICY_DELIM " \t"
@@ -221,6 +222,7 @@ static void free_rule(struct ipe_rule *r)
 
 	list_for_each_entry_safe(p, t, &r->props, next) {
 		list_del(&p->next);
+		ipe_digest_free(p->value);
 		kfree(p);
 	}
 
@@ -273,6 +275,9 @@ static enum ipe_action_type parse_action(char *t)
 static const match_table_t property_tokens = {
 	{IPE_PROP_BOOT_VERIFIED_FALSE,	"boot_verified=FALSE"},
 	{IPE_PROP_BOOT_VERIFIED_TRUE,	"boot_verified=TRUE"},
+	{IPE_PROP_DMV_ROOTHASH,		"dmverity_roothash=%s"},
+	{IPE_PROP_DMV_SIG_FALSE,	"dmverity_signature=FALSE"},
+	{IPE_PROP_DMV_SIG_TRUE,		"dmverity_signature=TRUE"},
 	{IPE_PROP_INVALID,		NULL}
 };
 
@@ -295,6 +300,7 @@ static int parse_property(char *t, struct ipe_rule *r)
 	struct ipe_prop *p = NULL;
 	int rc = 0;
 	int token;
+	char *dup = NULL;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
@@ -303,8 +309,22 @@ static int parse_property(char *t, struct ipe_rule *r)
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
@@ -315,10 +335,12 @@ static int parse_property(char *t, struct ipe_rule *r)
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


