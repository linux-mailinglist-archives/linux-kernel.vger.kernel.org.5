Return-Path: <linux-kernel+bounces-143469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459388A39EC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AB41F22D32
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4805F5732C;
	Sat, 13 Apr 2024 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="llav8iRd"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B96AB8;
	Sat, 13 Apr 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969770; cv=none; b=J0/UFtLP1Iy/YwNYv+sOhgUgDvNhmGYo6yi9E578HJkePDQivAK6DCzgWlOW6bOT0HhJTDUQs7+iTaOZxuENY8baAX6dDZ/IK/naKquAHhKJTBPHbW14oAefhoYHweoAORpcr5Uh/dmme8Rx/6CIwSH5z+XwibeOCzs88e5JJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969770; c=relaxed/simple;
	bh=Io2WEspxVty11zpFHyd/0BCy4zW7Qvl3GkFBZqOj6Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e2siewpim8XBbOx52O6nr7yBFC0PGn/XtaQBbBaYgoPGR1Mlidc0qnoY9P/GOeeqAfe6sT49WdLe8N1rEuHnNuIe3yp2BCJlmmmnvVAcn/cluHScl1Cy+ZGtGS7ag6iBS2cP6HGLcQTfUX4cRkNqBp2s8NugdZuoCItIAhHOcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=llav8iRd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id CB66F20F32D0; Fri, 12 Apr 2024 17:56:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB66F20F32D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712969765;
	bh=q173TCl1Vcwqj++F3yBWtpd85+CMzkLbR4IY2NEcab8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llav8iRdtzvj1nSF/aLooaPlmRc02hEbipCjudsFKBJEMBtBJCP5+4h+0Se8+6Y3H
	 ihRaYmwNBLPOqrBy3Zasq/QpgGTkWBA+EXrF4ElMXNHyp+LQEHK7GawkEVfmQgnFJy
	 iTAGb2chW2ZmcLraphSIcC9QOLLS8uRuD9x9gt1s=
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
Subject: [PATCH v17 06/21] ipe: introduce 'boot_verified' as a trust provider
Date: Fri, 12 Apr 2024 17:55:49 -0700
Message-Id: <1712969764-31039-7-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
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

v17:
  + Fix code and documentation style issues
---
 security/ipe/eval.c          | 41 +++++++++++++++++++++++++++++++++---
 security/ipe/eval.h          |  5 +++++
 security/ipe/hooks.c         |  9 ++++++++
 security/ipe/hooks.h         |  2 ++
 security/ipe/ipe.c           |  8 +++++++
 security/ipe/ipe.h           |  1 +
 security/ipe/policy.h        |  2 ++
 security/ipe/policy_parser.c | 39 +++++++++++++++++++++++++++++++---
 8 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index cc3b3f6583ad..28b3bded06c2 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -16,6 +16,18 @@
 
 struct ipe_policy __rcu *ipe_active_policy;
 
+#define FILE_SUPERBLOCK(f) ((f)->f_path.mnt->mnt_sb)
+
+/**
+ * build_ipe_sb_ctx() - Build initramfs field of an ipe evaluation context.
+ * @ctx: Supplies a pointer to the context to be populated.
+ * @file: Supplies the file struct of the file triggered IPE event.
+ */
+static void build_ipe_sb_ctx(struct ipe_eval_ctx *ctx, const struct file *const file)
+{
+	ctx->initramfs = ipe_sb(FILE_SUPERBLOCK(file))->initramfs;
+}
+
 /**
  * ipe_build_eval_ctx() - Build an ipe evaluation context.
  * @ctx: Supplies a pointer to the context to be populated.
@@ -28,6 +40,22 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx *ctx,
 {
 	ctx->file = file;
 	ctx->op = op;
+
+	if (file)
+		build_ipe_sb_ctx(ctx, file);
+}
+
+/**
+ * evaluate_boot_verified() - Evaluate @ctx for the boot verified property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ *
+ * Return:
+ * * %true	- The current @ctx match the @p
+ * * %false	- The current @ctx doesn't match the @p
+ */
+static bool evaluate_boot_verified(const struct ipe_eval_ctx *const ctx)
+{
+	return ctx->initramfs;
 }
 
 /**
@@ -35,8 +63,8 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx *ctx,
  * @ctx: Supplies a pointer to the context to be evaluated.
  * @p: Supplies a pointer to the property to be evaluated.
  *
- * This is a placeholder. The actual function will be introduced in the
- * latter commits.
+ * This function Determines whether the specified @ctx
+ * matches the conditions defined by a rule property @p.
  *
  * Return:
  * * %true	- The current @ctx match the @p
@@ -45,7 +73,14 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx *ctx,
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
index 00ed8ceca10e..0fa6492354dd 100644
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
 
 void ipe_build_eval_ctx(struct ipe_eval_ctx *ctx,
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index f2aaa749dd7b..76370919aac0 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/types.h>
 #include <linux/binfmts.h>
 #include <linux/mman.h>
@@ -182,3 +183,11 @@ int ipe_kernel_load_data(enum kernel_load_data_id id, bool contents)
 	ipe_build_eval_ctx(&ctx, NULL, op);
 	return ipe_evaluate_event(&ctx);
 }
+
+/**
+ * ipe_unpack_initramfs() - Mark the current rootfs as initramfs.
+ */
+void ipe_unpack_initramfs(void)
+{
+	ipe_sb(current->fs->root.mnt->mnt_sb)->initramfs = true;
+}
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index c22c3336d27c..4de5fabebd54 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -22,4 +22,6 @@ int ipe_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 
 int ipe_kernel_load_data(enum kernel_load_data_id id, bool contents);
 
+void ipe_unpack_initramfs(void);
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 729334812636..28555eadb7f3 100644
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
index adc3c45e9f53..7f1c818193a0 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -12,5 +12,6 @@
 #define pr_fmt(fmt) "ipe: " fmt
 
 #include <linux/lsm_hooks.h>
+struct ipe_superblock *ipe_sb(const struct super_block *sb);
 
 #endif /* _IPE_H */
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index 8292ffaaff12..69ca8cdecd64 100644
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
index 32064262348a..84cc688be3a2 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -270,13 +270,19 @@ static enum ipe_action_type parse_action(char *t)
 	return match_token(t, action_tokens, args);
 }
 
+static const match_table_t property_tokens = {
+	{IPE_PROP_BOOT_VERIFIED_FALSE,	"boot_verified=FALSE"},
+	{IPE_PROP_BOOT_VERIFIED_TRUE,	"boot_verified=TRUE"},
+	{IPE_PROP_INVALID,		NULL}
+};
+
 /**
  * parse_property() - Parse a rule property given a token string.
  * @t: Supplies the token string to be parsed.
  * @r: Supplies the ipe_rule the parsed property will be associated with.
  *
- * This is a placeholder. The actual function will be introduced in the
- * latter commits.
+ * This function parses and associates a property with an IPE rule based
+ * on a token string.
  *
  * Return:
  * * %0		- Success
@@ -285,7 +291,34 @@ static enum ipe_action_type parse_action(char *t)
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


