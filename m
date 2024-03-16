Return-Path: <linux-kernel+bounces-105056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF8D87D8A6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60BEB21B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB525A4CC;
	Sat, 16 Mar 2024 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jhWQ52DL"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB97F9F0;
	Sat, 16 Mar 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710560161; cv=none; b=HqF4WEu5TUDsjvhVtAenKc+8lyuKcXZHyl7DDIfmtkNKyWC12xxSmlYZS6yOORFcMdc45qol09NwHG7NgM4pt+c+hoNfPS4eAYb0taReNjlOqNEhvgynb9B0ngNVgQwOibkuKLMqeQps4ZMrAoreaA+I+4PfrjlgQZz38PYJcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710560161; c=relaxed/simple;
	bh=3OU8ekwp6jhuGHYVQ4XJmza8Qqdfz17OnMQ6mj1Riv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PZtXlEBuM46R0YXkgs9lqhx/AReK3x+/JxlCmKR233M/FJr2gf/5jUUi0hHT72sCwM0hm2YHvA4S++lGlfmY4j7zSNfbX8C7O6H3i8VpslO+VSzK5+dTn9XHxWS1dqFzOxod/Q/Vdir0FUJH9jMBtzfT17YJwGAE9NAvq7Xxr9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jhWQ52DL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 045F520B74DB; Fri, 15 Mar 2024 20:35:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 045F520B74DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710560154;
	bh=MFKVCko4HrdnEalMNmfgSQAz9E0Rz7Ur/TfbW7+1dKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhWQ52DLDw2x4dsxaOH+RtS87OljtuP4D/oE8j1Bcg+SE38/+5ayTOB++0steynXx
	 8T2ZjCjbb0Px7YGWCUKOUxAw71oMX43g7QQr5GmhkmqW+9KjategeWMrboVjC/y66B
	 7Vx/mH19RXMoIWNmh38qQ0y7O0U7OcjKc3m/IzWQ=
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
Subject: [RFC PATCH v15 14/21] dm verity: consume root hash digest and signature data via LSM hook
Date: Fri, 15 Mar 2024 20:35:44 -0700
Message-Id: <1710560151-28904-15-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Deven Bowers <deven.desai@linux.microsoft.com>

dm-verity provides a strong guarantee of a block device's integrity. As
a generic way to check the integrity of a block device, it provides
those integrity guarantees to its higher layers, including the filesystem
level.

An LSM that control access to a resource on the system based on the
available integrity claims can use this transitive property of
dm-verity, by querying the underlying block_device of a particular
file.

The digest and signature information need to be stored in the block
device to fulfill the next requirement of authorization via LSM policy.
This will enable the LSM to perform revocation of devices that are still
mounted, prohibiting execution of files that are no longer authorized
by the LSM in question.

This patch adds two security hook calls in dm-verity to save the
dm-verity roothash and the roothash signature to the block device's
LSM blobs. The hook calls are depended on CONFIG_IPE_PROP_DM_VERITY,
which will be introduced in the next commit.

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
  + Use part0 for block_device, to retrieve the block_device, when
    calling security_bdev_setsecurity

v8:
  + Undo squash of 08/12, 10/12 - separating drivers/md/ from
    security/ & block/
  + Use common-audit function for dmverity_signature.
  + Change implementation for storing the dm-verity digest to use the
    newly introduced dm_verity_digest structure introduced in patch
    14/20.
  + Create new structure, dm_verity_digest, containing digest algorithm,
    size, and digest itself to pass to the LSM layer. V7 was missing the
    algorithm.
  + Create an associated public header containing this new structure and
    the key values for the LSM hook, specific to dm-verity.
  + Additional information added to commit, discussing the layering of
    the changes and how the information passed will be used.

v9:
  + No changes

v10:
  + No changes

v11:
  + Add an optional field to save signature
  + Move the security hook call to the new finalize hook

v12:
  + No changes

v13:
  + No changes

v14:
  + Correct code format
  + Remove unnecessary header and switch to dm_disk()

v15:
  + Refactor security_bdev_setsecurity() to security_bdev_setintegrity()
  + Remove unnecessary headers
---
 drivers/md/dm-verity-target.c | 73 +++++++++++++++++++++++++++++++++++
 drivers/md/dm-verity.h        |  6 +++
 include/linux/dm-verity.h     | 12 ++++++
 include/linux/security.h      |  2 +
 4 files changed, 93 insertions(+)
 create mode 100644 include/linux/dm-verity.h

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index bb5da66da4c1..e94cc6a755d5 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -22,6 +22,8 @@
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/jump_label.h>
+#include <linux/security.h>
+#include <linux/dm-verity.h>
 
 #define DM_MSG_PREFIX			"verity"
 
@@ -1017,6 +1019,38 @@ static void verity_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	blk_limits_io_min(limits, limits->logical_block_size);
 }
 
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+
+static int verity_init_sig(struct dm_verity *v, const void *sig,
+			   size_t sig_size)
+{
+	v->sig_size = sig_size;
+	v->root_digest_sig = kmalloc(v->sig_size, GFP_KERNEL);
+	if (!v->root_digest)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void verity_free_sig(struct dm_verity *v)
+{
+	kfree(v->root_digest_sig);
+}
+
+#else
+
+static inline int verity_init_sig(struct dm_verity *v, const void *sig,
+				  size_t sig_size)
+{
+	return 0;
+}
+
+static inline void verity_free_sig(struct dm_verity *v)
+{
+}
+
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 static void verity_dtr(struct dm_target *ti)
 {
 	struct dm_verity *v = ti->private;
@@ -1035,6 +1069,7 @@ static void verity_dtr(struct dm_target *ti)
 	kfree(v->salt);
 	kfree(v->root_digest);
 	kfree(v->zero_digest);
+	verity_free_sig(v);
 
 	if (v->tfm)
 		crypto_free_ahash(v->tfm);
@@ -1434,6 +1469,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ti->error = "Root hash verification failed";
 		goto bad;
 	}
+
+	r = verity_init_sig(v, verify_args.sig, verify_args.sig_size);
+	if (r < 0) {
+		ti->error = "Cannot allocate root digest signature";
+		goto bad;
+	}
+
 	v->hash_per_block_bits =
 		__fls((1 << v->hash_dev_block_bits) / v->digest_size);
 
@@ -1584,6 +1626,34 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
 	return 0;
 }
 
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+
+static int verity_finalize(struct dm_target *ti)
+{
+	struct block_device *bdev;
+	struct dm_verity_digest root_digest;
+	struct dm_verity *v;
+	int r;
+
+	v = ti->private;
+	bdev = dm_disk(dm_table_get_md(ti->table))->part0;
+	root_digest.digest = v->root_digest;
+	root_digest.digest_len = v->digest_size;
+	root_digest.alg = v->alg_name;
+
+	r = security_bdev_setintegrity(bdev, LSM_INTGR_DMV_ROOTHASH, &root_digest,
+				       sizeof(root_digest));
+	if (r)
+		return r;
+
+	return security_bdev_setintegrity(bdev,
+					  LSM_INTGR_DMV_SIG,
+					  v->root_digest_sig,
+					  v->sig_size);
+}
+
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
+
 static struct target_type verity_target = {
 	.name		= "verity",
 	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
@@ -1596,6 +1666,9 @@ static struct target_type verity_target = {
 	.prepare_ioctl	= verity_prepare_ioctl,
 	.iterate_devices = verity_iterate_devices,
 	.io_hints	= verity_io_hints,
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+	.finalize	= verity_finalize,
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
 };
 module_dm(verity);
 
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 20b1bcf03474..6a5b8df5bafd 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -43,6 +43,9 @@ struct dm_verity {
 	u8 *root_digest;	/* digest of the root block */
 	u8 *salt;		/* salt: its size is salt_size */
 	u8 *zero_digest;	/* digest for a zero block */
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+	u8 *root_digest_sig;	/* digest signature of the root block */
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
 	unsigned int salt_size;
 	sector_t data_start;	/* data offset in 512-byte sectors */
 	sector_t hash_start;	/* hash start in blocks */
@@ -56,6 +59,9 @@ struct dm_verity {
 	bool hash_failed:1;	/* set if hash of any block failed */
 	bool use_bh_wq:1;	/* try to verify in BH wq before normal work-queue */
 	unsigned int digest_size;	/* digest size for the current hash algorithm */
+#ifdef CONFIG_IPE_PROP_DM_VERITY
+	unsigned int sig_size;	/* digest signature size */
+#endif /* CONFIG_IPE_PROP_DM_VERITY */
 	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
 	enum verity_mode mode;	/* mode for handling verification errors */
 	unsigned int corrupted_errs;/* Number of errors for corrupted blocks */
diff --git a/include/linux/dm-verity.h b/include/linux/dm-verity.h
new file mode 100644
index 000000000000..a799a8043d85
--- /dev/null
+++ b/include/linux/dm-verity.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_DM_VERITY_H
+#define _LINUX_DM_VERITY_H
+
+struct dm_verity_digest {
+	const char *alg;
+	const u8 *digest;
+	size_t digest_len;
+};
+
+#endif /* _LINUX_DM_VERITY_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index eaff8868766a..60b40b523d57 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -84,6 +84,8 @@ enum lsm_event {
 };
 
 enum lsm_intgr_type {
+	LSM_INTGR_DMV_SIG,
+	LSM_INTGR_DMV_ROOTHASH,
 	__LSM_INTGR_MAX
 };
 
-- 
2.44.0


