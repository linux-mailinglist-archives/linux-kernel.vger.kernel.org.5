Return-Path: <linux-kernel+bounces-168362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDDF8BB796
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F140B24D13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB151353F5;
	Fri,  3 May 2024 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mWX3+I3b"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A8B126F11;
	Fri,  3 May 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775563; cv=none; b=WNbXFV7KFQbVnhXpxvfBJZ8hD6w6Vpe/N3cb23bvVXuu4xp6mB0g6LIzDQPcrH45czS8C3wss3o1E0gOyCBh6b0aM1F0+3AwJzHnDZ6f0jfA+GEtw+TH88FVcPpigoaBHJd9NgxJpa1WbY45MKBwqngPrLvIlONkMyCankyyjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775563; c=relaxed/simple;
	bh=b6MiEio0sQJm7VZsnRzRs4hzjrP0lxhooeQb584KDVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RzOdmiylF1dPbEZFSX+1MT4BNNjEuqTs9/wA3UQw0JRTOC5VPBm0hHhdSfEEUEtQDqHzrnq7rcrLjnLUCLrAgkbuAW8NXDQ9f1bApP00FZ4tZJEFF+zzNJ2XlV48XfNc7gXdMXbLBfXizq5RPfkaL/LfvzUmlvJlSU755dkLbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mWX3+I3b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 7D96F20B2CA4; Fri,  3 May 2024 15:32:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D96F20B2CA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714775553;
	bh=c/WBIGqjDdjjbD7V0/6dIrKLI9DJn2HJSyWwXfBb9fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWX3+I3bib2mbQSwto5sKbjTntujQwCQ1IfARjxANlJEHofuuGE6FVxrNAsXR0t0l
	 M73Thh8bIzQHGQLawe6xv+LRcV3TmJOqu7aPFGDAVBKM7L2j+5sIJlrGeftsDv1CA+
	 0r/QkdjNF7PzDkCU/M+TSrznd9fdY73dn2zGj4V0=
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
Subject: [PATCH v18 13/21] dm verity: expose root hash digest and signature data to LSMs
Date: Fri,  3 May 2024 15:32:23 -0700
Message-Id: <1714775551-22384-14-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
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

This patch adds two security hook calls in dm-verity to expose the
dm-verity roothash and the roothash signature to LSMs. The hook calls
are depended on CONFIG_SECURITY.

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

v16:
  + Use kmemdup to duplicate signature
  + Clean up lsm blob data in error case

v17:
  + Switch to depend on CONFIG_SECURITY
  + Use new enum name LSM_INT_DMVERITY_SIG_VALID

v18:
  + Amend commit title
  + Fix incorrect error handling
  + Make signature exposure depends on CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
  + Fix inaccurate comment
  + Remove include/linux/dm-verity.h
  + use crypto_ahash_alg_name(v->tfm) instead of v->alg_name
---
 drivers/md/dm-verity-target.c | 100 ++++++++++++++++++++++++++++++++++
 drivers/md/dm-verity.h        |   6 ++
 include/linux/security.h      |   9 ++-
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index bb5da66da4c1..3afab8f2c509 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/jump_label.h>
+#include <linux/security.h>
 
 #define DM_MSG_PREFIX			"verity"
 
@@ -1017,6 +1018,38 @@ static void verity_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	blk_limits_io_min(limits, limits->logical_block_size);
 }
 
+#ifdef CONFIG_SECURITY
+
+static int verity_init_sig(struct dm_verity *v, const void *sig,
+			   size_t sig_size)
+{
+	v->sig_size = sig_size;
+	v->root_digest_sig = kmemdup(sig, v->sig_size, GFP_KERNEL);
+	if (!v->root_digest_sig)
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
+#endif /* CONFIG_SECURITY */
+
 static void verity_dtr(struct dm_target *ti)
 {
 	struct dm_verity *v = ti->private;
@@ -1035,6 +1068,7 @@ static void verity_dtr(struct dm_target *ti)
 	kfree(v->salt);
 	kfree(v->root_digest);
 	kfree(v->zero_digest);
+	verity_free_sig(v);
 
 	if (v->tfm)
 		crypto_free_ahash(v->tfm);
@@ -1434,6 +1468,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
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
 
@@ -1584,6 +1625,62 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY
+
+#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
+
+static int verity_security_set_signature(struct block_device *bdev,
+					 struct dm_verity *v)
+{
+	return security_bdev_setintegrity(bdev,
+					  LSM_INT_DMVERITY_SIG_VALID,
+					  v->root_digest_sig,
+					  v->sig_size);
+}
+
+#else
+
+static inline int verity_security_set_signature(struct block_device *bdev,
+						struct dm_verity *v)
+{
+	return 0;
+}
+
+#endif /* CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG */
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
+	root_digest.alg = crypto_ahash_alg_name(v->tfm);
+
+	r = security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, &root_digest,
+				       sizeof(root_digest));
+	if (r)
+		return r;
+
+	r =  verity_security_set_signature(bdev, v);
+	if (r)
+		goto bad;
+
+	return 0;
+
+bad:
+
+	security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, NULL, 0);
+
+	return r;
+}
+
+#endif /* CONFIG_SECURITY */
+
 static struct target_type verity_target = {
 	.name		= "verity",
 	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
@@ -1596,6 +1693,9 @@ static struct target_type verity_target = {
 	.prepare_ioctl	= verity_prepare_ioctl,
 	.iterate_devices = verity_iterate_devices,
 	.io_hints	= verity_io_hints,
+#ifdef CONFIG_SECURITY
+	.finalize	= verity_finalize,
+#endif /* CONFIG_SECURITY */
 };
 module_dm(verity);
 
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 20b1bcf03474..2de89e0d555b 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -43,6 +43,9 @@ struct dm_verity {
 	u8 *root_digest;	/* digest of the root block */
 	u8 *salt;		/* salt: its size is salt_size */
 	u8 *zero_digest;	/* digest for a zero block */
+#ifdef CONFIG_SECURITY
+	u8 *root_digest_sig;	/* signature of the root digest */
+#endif /* CONFIG_SECURITY */
 	unsigned int salt_size;
 	sector_t data_start;	/* data offset in 512-byte sectors */
 	sector_t hash_start;	/* hash start in blocks */
@@ -56,6 +59,9 @@ struct dm_verity {
 	bool hash_failed:1;	/* set if hash of any block failed */
 	bool use_bh_wq:1;	/* try to verify in BH wq before normal work-queue */
 	unsigned int digest_size;	/* digest size for the current hash algorithm */
+#ifdef CONFIG_SECURITY
+	unsigned int sig_size;	/* root digest signature size */
+#endif /* CONFIG_SECURITY */
 	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
 	enum verity_mode mode;	/* mode for handling verification errors */
 	unsigned int corrupted_errs;/* Number of errors for corrupted blocks */
diff --git a/include/linux/security.h b/include/linux/security.h
index ac0985641611..d2ddd7c63b62 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -83,8 +83,15 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+struct dm_verity_digest {
+	const char *alg;
+	const u8 *digest;
+	size_t digest_len;
+};
+
 enum lsm_integrity_type {
-	__LSM_INT_MAX
+	LSM_INT_DMVERITY_SIG_VALID,
+	LSM_INT_DMVERITY_ROOTHASH,
 };
 
 /*
-- 
2.44.0


