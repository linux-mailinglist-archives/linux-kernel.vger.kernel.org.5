Return-Path: <linux-kernel+bounces-168364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E98BB79C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02A01C23198
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EBC135A69;
	Fri,  3 May 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nNTkiKtY"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA01E12BE81;
	Fri,  3 May 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775563; cv=none; b=lx9zsdw+CmFoB8bxqeuw14voO4DjunLb3BxyxAEWA3iDFdaB36PYRAjHgagdqeYvhHsY6Mdbcglx5D0fvcdU5r+kX0jpsC3L8s7wzKeNgQi9q0YekLWuhQiXrKjtWIRiq7/thKm5KOa/C7HksqJ8QATWho/7G3aeYJ0fyizhRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775563; c=relaxed/simple;
	bh=/OI7eSeUVcbG+Gz2hpWAPbES6KZD+U+tw1PnbgX+/Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d8K0MeSyszbK9+On+i97dJ79Zi2JSAWBgKukEiCKGMHLRSQbqkbjW6OfOQkBNy5JyZHjlUCnhFjfWjRVVcDg8wYHOaYC5qsh9/ORfgE8LbEI8J6S0SCuv9pW1JGDn5gOoBDk6JXdtdgYZPNQlcgxpj4QwOZF9K0qnNJ/ASNcAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nNTkiKtY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id B51FE20B2CAE; Fri,  3 May 2024 15:32:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B51FE20B2CAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714775553;
	bh=FLbQapDlk/YJZeztrrfVfh372cABlq5cNGltUhP7UTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNTkiKtY0tLyl3sqs4Bra+MB4Hpry4O06diGMpGZKLWORBhv6zkIs7Rj68NK6kc7R
	 HrWyYJkUGWduvW5TcUazX9VlVZnLBJvb/nFDgFgsS2YQutsjse/j6mlEQUJ2Mc724q
	 l0UgNBWDINXfH7gBdZejWIuV+kP9FQlPJzLuQdnI=
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
Subject: [PATCH v18 17/21] ipe: enable support for fs-verity as a trust provider
Date: Fri,  3 May 2024 15:32:27 -0700
Message-Id: <1714775551-22384-18-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable IPE policy authors to indicate trust for a singular fsverity
file, identified by the digest information, through "fsverity_digest"
and all files using valid fsverity builtin signatures via
"fsverity_signature".

This enables file-level integrity claims to be expressed in IPE,
allowing individual files to be authorized, giving some flexibility
for policy authors. Such file-level claims are important to be expressed
for enforcing the integrity of packages, as well as address some of the
scalability issues in a sole dm-verity based solution (# of loop back
devices, etc).

This solution cannot be done in userspace as the minimum threat that
IPE should mitigate is an attacker downloads malicious payload with
all required dependencies. These dependencies can lack the userspace
check, bypassing the protection entirely. A similar attack succeeds if
the userspace component is replaced with a version that does not
perform the check. As a result, this can only be done in the common
entry point - the kernel.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v1-v6:
  + Not present

v7:
  Introduced

v8:
  * Undo squash of 08/12, 10/12 - separating drivers/md/ from security/
  * Use common-audit function for fsverity_signature.
  + Change fsverity implementation to use fsverity_get_digest
  + prevent unnecessary copy of fs-verity signature data, instead
    just check for presence of signature data.
  + Remove free_inode_security hook, as the digest is now acquired
    at runtime instead of via LSM blob.

v9:
  + Adapt to the new parser

v10:
  + Update the fsverity get digest call

v11:
  + No changes

v12:
  + Fix audit format
  + Simplify property evaluation

v13:
  + Remove the CONFIG_IPE_PROP_FS_VERITY dependency inside the parser
    to make the policy grammar independent of the kernel config.

v14:
  + No changes

v15:
  + Fix on grammar issue in Kconfig
  + Switch hook to security_inode_setintegrity()

v16:
  + Rewrite fsverity signature part in Kconfig

v17:
  + Fix documentation issues
  + Use new enum name LSM_INT_FSVERITY_BUILTINSIG_VALID

v18:
  + Add Kconfig IPE_PROP_FS_VERITY_BUILTIN_SIG and make both FS_VERITY
    Kconfigs auto-selected
---
 security/ipe/Kconfig         |  25 +++++++
 security/ipe/audit.c         |  17 +++++
 security/ipe/eval.c          | 123 ++++++++++++++++++++++++++++++++++-
 security/ipe/eval.h          |  12 ++++
 security/ipe/hooks.c         |  28 ++++++++
 security/ipe/hooks.h         |   6 ++
 security/ipe/ipe.c           |  13 ++++
 security/ipe/ipe.h           |   3 +
 security/ipe/policy.h        |   3 +
 security/ipe/policy_parser.c |   6 ++
 10 files changed, 235 insertions(+), 1 deletion(-)

diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index 8279dddf92ad..839d63698841 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -10,6 +10,8 @@ menuconfig SECURITY_IPE
 	select SYSTEM_DATA_VERIFICATION
 	select IPE_PROP_DM_VERITY if DM_VERITY
 	select IPE_PROP_DM_VERITY_SIGNATURE if DM_VERITY && DM_VERITY_VERIFY_ROOTHASH_SIG
+	select IPE_PROP_FS_VERITY if FS_VERITY
+	select IPE_PROP_FS_VERITY_BUILTIN_SIG if FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
 	help
 	  This option enables the Integrity Policy Enforcement LSM
 	  allowing users to define a policy to enforce a trust-based access
@@ -39,6 +41,29 @@ config IPE_PROP_DM_VERITY_SIGNATURE
 	  volume, which has been mounted with a valid signed root hash,
 	  is evaluated.
 
+	  If unsure, answer Y.
+
+config IPE_PROP_FS_VERITY
+	bool "Enable support for fs-verity based on file digest"
+	depends on FS_VERITY
+	help
+	  This option enables the 'fsverity_digest' property within IPE
+	  policies. The property evaluates to TRUE when a file is fsverity
+	  enabled and its digest matches the supplied value in the policy.
+
+	  if unsure, answer Y.
+
+config IPE_PROP_FS_VERITY_BUILTIN_SIG
+	bool "Enable support for fs-verity based on builtin signature"
+	depends on FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
+	help
+	  This option enables the 'fsverity_signature' property within IPE
+	  policies. The property evaluates to TRUE when a file is fsverity
+	  enabled and it has a valid builtin signature whose signing cert
+	  is in the .fs-verity keyring.
+
+	  if unsure, answer Y.
+
 endmenu
 
 endif
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index 2c98520267c1..bd258f887e6f 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -53,6 +53,9 @@ static const char *const audit_prop_names[__IPE_PROP_MAX] = {
 	"dmverity_roothash=",
 	"dmverity_signature=FALSE",
 	"dmverity_signature=TRUE",
+	"fsverity_digest=",
+	"fsverity_signature=FALSE",
+	"fsverity_signature=TRUE",
 };
 
 /**
@@ -66,6 +69,17 @@ static void audit_dmv_roothash(struct audit_buffer *ab, const void *rh)
 	ipe_digest_audit(ab, rh);
 }
 
+/**
+ * audit_fsv_digest() - audit the digest of a fsverity_digest property.
+ * @ab: Supplies a pointer to the audit_buffer to append to.
+ * @d: Supplies a pointer to the digest structure.
+ */
+static void audit_fsv_digest(struct audit_buffer *ab, const void *d)
+{
+	audit_log_format(ab, "%s", audit_prop_names[IPE_PROP_FSV_DIGEST]);
+	ipe_digest_audit(ab, d);
+}
+
 /**
  * audit_rule() - audit an IPE policy rule.
  * @ab: Supplies a pointer to the audit_buffer to append to.
@@ -82,6 +96,9 @@ static void audit_rule(struct audit_buffer *ab, const struct ipe_rule *r)
 		case IPE_PROP_DMV_ROOTHASH:
 			audit_dmv_roothash(ab, ptr->value);
 			break;
+		case IPE_PROP_FSV_DIGEST:
+			audit_fsv_digest(ab, ptr->value);
+			break;
 		default:
 			audit_log_format(ab, "%s", audit_prop_names[ptr->type]);
 			break;
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 8f4f63088206..dca1b1f312b4 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
+#include <linux/fsverity.h>
 
 #include "ipe.h"
 #include "eval.h"
@@ -51,6 +52,36 @@ static void build_ipe_bdev_ctx(struct ipe_eval_ctx *ctx, const struct inode *con
 }
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
 
+#ifdef CONFIG_IPE_PROP_FS_VERITY
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+static void build_ipe_inode_blob_ctx(struct ipe_eval_ctx *ctx,
+				     const struct inode *const ino)
+{
+	ctx->ipe_inode = ipe_inode(ctx->ino);
+}
+#else
+static inline void build_ipe_inode_blob_ctx(struct ipe_eval_ctx *ctx,
+					    const struct inode *const ino)
+{
+}
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+
+/**
+ * build_ipe_inode_ctx() - Build inode fields of an evaluation context.
+ * @ctx: Supplies a pointer to the context to be populated.
+ * @ino: Supplies the inode struct of the file triggered IPE event.
+ */
+static void build_ipe_inode_ctx(struct ipe_eval_ctx *ctx, const struct inode *const ino)
+{
+	ctx->ino = ino;
+	build_ipe_inode_blob_ctx(ctx, ino);
+}
+#else
+static void build_ipe_inode_ctx(struct ipe_eval_ctx *ctx, const struct inode *const ino)
+{
+}
+#endif /* CONFIG_IPE_PROP_FS_VERITY */
+
 /**
  * ipe_build_eval_ctx() - Build an ipe evaluation context.
  * @ctx: Supplies a pointer to the context to be populated.
@@ -63,13 +94,17 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx *ctx,
 			enum ipe_op_type op,
 			enum ipe_hook_type hook)
 {
+	struct inode *ino;
+
 	ctx->file = file;
 	ctx->op = op;
 	ctx->hook = hook;
 
 	if (file) {
 		build_ipe_sb_ctx(ctx, file);
-		build_ipe_bdev_ctx(ctx, d_real_inode(file->f_path.dentry));
+		ino = d_real_inode(file->f_path.dentry);
+		build_ipe_bdev_ctx(ctx, ino);
+		build_ipe_inode_ctx(ctx, ino);
 	}
 }
 
@@ -150,6 +185,86 @@ static bool evaluate_dmv_sig_true(const struct ipe_eval_ctx *const ctx)
 }
 #endif /* CONFIG_IPE_PROP_DM_VERITY_SIGNATURE */
 
+#ifdef CONFIG_IPE_PROP_FS_VERITY
+/**
+ * evaluate_fsv_digest() - Evaluate @ctx against a fsv digest property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ * @p: Supplies a pointer to the property being evaluated.
+ *
+ * Return:
+ * * %true	- The current @ctx match the @p
+ * * %false	- The current @ctx doesn't match the @p
+ */
+static bool evaluate_fsv_digest(const struct ipe_eval_ctx *const ctx,
+				struct ipe_prop *p)
+{
+	enum hash_algo alg;
+	u8 digest[FS_VERITY_MAX_DIGEST_SIZE];
+	struct digest_info info;
+
+	if (!ctx->ino)
+		return false;
+	if (!fsverity_get_digest((struct inode *)ctx->ino,
+				 digest,
+				 NULL,
+				 &alg))
+		return false;
+
+	info.alg = hash_algo_name[alg];
+	info.digest = digest;
+	info.digest_len = hash_digest_size[alg];
+
+	return ipe_digest_eval(p->value, &info);
+}
+#else
+static bool evaluate_fsv_digest(const struct ipe_eval_ctx *const ctx,
+				struct ipe_prop *p)
+{
+	return false;
+}
+#endif /* CONFIG_IPE_PROP_FS_VERITY */
+
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+/**
+ * evaluate_fsv_sig_false() - Evaluate @ctx against a fsv sig false property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ *
+ * Return:
+ * * %true	- The current @ctx match the property
+ * * %false	- The current @ctx doesn't match the property
+ */
+static bool evaluate_fsv_sig_false(const struct ipe_eval_ctx *const ctx)
+{
+	return !ctx->ino ||
+	       !IS_VERITY(ctx->ino) ||
+	       !ctx->ipe_inode ||
+	       !ctx->ipe_inode->fs_verity_signed;
+}
+
+/**
+ * evaluate_fsv_sig_true() - Evaluate @ctx against a fsv sig true property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ *
+ * Return:
+ * * %true - The current @ctx match the property
+ * * %false - The current @ctx doesn't match the property
+ */
+static bool evaluate_fsv_sig_true(const struct ipe_eval_ctx *const ctx)
+{
+	return !evaluate_fsv_sig_false(ctx);
+}
+#else
+static bool evaluate_fsv_sig_false(const struct ipe_eval_ctx *const ctx)
+{
+	return false;
+}
+
+static bool evaluate_fsv_sig_true(const struct ipe_eval_ctx *const ctx)
+{
+	return false;
+}
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+
 /**
  * evaluate_property() - Analyze @ctx against a rule property.
  * @ctx: Supplies a pointer to the context to be evaluated.
@@ -176,6 +291,12 @@ static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
 		return evaluate_dmv_sig_false(ctx);
 	case IPE_PROP_DMV_SIG_TRUE:
 		return evaluate_dmv_sig_true(ctx);
+	case IPE_PROP_FSV_DIGEST:
+		return evaluate_fsv_digest(ctx, p);
+	case IPE_PROP_FSV_SIG_FALSE:
+		return evaluate_fsv_sig_false(ctx);
+	case IPE_PROP_FSV_SIG_TRUE:
+		return evaluate_fsv_sig_true(ctx);
 	default:
 		return false;
 	}
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index 4901df0e1369..fef65a36468c 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -31,6 +31,12 @@ struct ipe_bdev {
 };
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
 
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+struct ipe_inode {
+	bool fs_verity_signed;
+};
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+
 struct ipe_eval_ctx {
 	enum ipe_op_type op;
 	enum ipe_hook_type hook;
@@ -40,6 +46,12 @@ struct ipe_eval_ctx {
 #ifdef CONFIG_IPE_PROP_DM_VERITY
 	const struct ipe_bdev *ipe_bdev;
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
+#ifdef CONFIG_IPE_PROP_FS_VERITY
+	const struct inode *ino;
+#endif /* CONFIG_IPE_PROP_FS_VERITY */
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+	const struct ipe_inode *ipe_inode;
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 };
 
 enum ipe_match {
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index bc0a7268179d..df5057b8670f 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -282,3 +282,31 @@ int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type typ
 	return -EINVAL;
 }
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
+
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+/**
+ * ipe_inode_setintegrity() - save integrity data from a inode to IPE's LSM blob.
+ * @inode: The inode to source the security blob from.
+ * @type: Supplies the integrity type.
+ * @value: The value to be stored.
+ * @size: The size of @value.
+ *
+ * This hook is currently used to save the existence of a validated fs-verity
+ * builtin signature into LSM blob.
+ *
+ * Return: %0 on success. If an error occurs, the function will return the
+ * -errno.
+ */
+int ipe_inode_setintegrity(struct inode *inode, enum lsm_integrity_type type,
+			   const void *value, size_t size)
+{
+	struct ipe_inode *inode_sec = ipe_inode(inode);
+
+	if (type == LSM_INT_FSVERITY_BUILTINSIG_VALID) {
+		inode_sec->fs_verity_signed = size > 0 && value;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+#endif /* CONFIG_CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 4d585fb6ada3..b45c0243107b 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -9,6 +9,7 @@
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/blk_types.h>
+#include <linux/fsverity.h>
 
 enum ipe_hook_type {
 	IPE_HOOK_BPRM_CHECK = 0,
@@ -43,4 +44,9 @@ int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type typ
 			  const void *value, size_t len);
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
 
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+int ipe_inode_setintegrity(struct inode *inode, enum lsm_integrity_type type,
+			   const void *value, size_t size);
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 99cb42caa63a..da79f66b0010 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -16,6 +16,9 @@ static struct lsm_blob_sizes ipe_blobs __ro_after_init = {
 #ifdef CONFIG_IPE_PROP_DM_VERITY
 	.lbs_bdev = sizeof(struct ipe_bdev),
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+	.lbs_inode = sizeof(struct ipe_inode),
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 };
 
 static const struct lsm_id ipe_lsmid = {
@@ -35,6 +38,13 @@ struct ipe_bdev *ipe_bdev(struct block_device *b)
 }
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
 
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+struct ipe_inode *ipe_inode(const struct inode *inode)
+{
+	return inode->i_security + ipe_blobs.lbs_inode;
+}
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+
 static struct security_hook_list ipe_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ipe_bprm_check_security),
 	LSM_HOOK_INIT(mmap_file, ipe_mmap_file),
@@ -46,6 +56,9 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bdev_free_security, ipe_bdev_free_security),
 	LSM_HOOK_INIT(bdev_setintegrity, ipe_bdev_setintegrity),
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+	LSM_HOOK_INIT(inode_setintegrity, ipe_inode_setintegrity),
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 };
 
 /**
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index 01f46286e383..fb37513812dd 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -19,5 +19,8 @@ extern bool ipe_enabled;
 #ifdef CONFIG_IPE_PROP_DM_VERITY
 struct ipe_bdev *ipe_bdev(struct block_device *b);
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+struct ipe_inode *ipe_inode(const struct inode *inode);
+#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
 #endif /* _IPE_H */
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index 26776092c710..5bfbdbddeef8 100644
--- a/security/ipe/policy.h
+++ b/security/ipe/policy.h
@@ -36,6 +36,9 @@ enum ipe_prop_type {
 	IPE_PROP_DMV_ROOTHASH,
 	IPE_PROP_DMV_SIG_FALSE,
 	IPE_PROP_DMV_SIG_TRUE,
+	IPE_PROP_FSV_DIGEST,
+	IPE_PROP_FSV_SIG_FALSE,
+	IPE_PROP_FSV_SIG_TRUE,
 	__IPE_PROP_MAX
 };
 
diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 71c84b293029..5a182c006b0e 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -278,6 +278,9 @@ static const match_table_t property_tokens = {
 	{IPE_PROP_DMV_ROOTHASH,		"dmverity_roothash=%s"},
 	{IPE_PROP_DMV_SIG_FALSE,	"dmverity_signature=FALSE"},
 	{IPE_PROP_DMV_SIG_TRUE,		"dmverity_signature=TRUE"},
+	{IPE_PROP_FSV_DIGEST,		"fsverity_digest=%s"},
+	{IPE_PROP_FSV_SIG_FALSE,	"fsverity_signature=FALSE"},
+	{IPE_PROP_FSV_SIG_TRUE,		"fsverity_signature=TRUE"},
 	{IPE_PROP_INVALID,		NULL}
 };
 
@@ -310,6 +313,7 @@ static int parse_property(char *t, struct ipe_rule *r)
 
 	switch (token) {
 	case IPE_PROP_DMV_ROOTHASH:
+	case IPE_PROP_FSV_DIGEST:
 		dup = match_strdup(&args[0]);
 		if (!dup) {
 			rc = -ENOMEM;
@@ -325,6 +329,8 @@ static int parse_property(char *t, struct ipe_rule *r)
 	case IPE_PROP_BOOT_VERIFIED_TRUE:
 	case IPE_PROP_DMV_SIG_FALSE:
 	case IPE_PROP_DMV_SIG_TRUE:
+	case IPE_PROP_FSV_SIG_FALSE:
+	case IPE_PROP_FSV_SIG_TRUE:
 		p->type = token;
 		break;
 	default:
-- 
2.44.0


