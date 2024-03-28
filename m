Return-Path: <linux-kernel+bounces-123564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F862890B29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B8BB2290A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98113F01E;
	Thu, 28 Mar 2024 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LrfnChzU"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3413A89A;
	Thu, 28 Mar 2024 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657058; cv=none; b=OfDm1EFUtWEF9pPKgSmNhUTGa5o15j8TIlEyLpqQYUrrTsBjGfxMi3AuLTkVwwDFRpwR9xY6kgKIMb7yr458CBs9JZdz4hURv6GxaDiJ9pkpTOd4L5AS6rC1xoQzvPefpYixb8gy6qhWx+FPpqIEYWTnY9Ew8DN9Z1Qg4y8MFt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657058; c=relaxed/simple;
	bh=q9tRkxZ9iRq2oPGxRnCgC8vawNrdvakBIuthmdAExDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=darkfMUrqVl8KdiT+EgQOhpb/B+E3A+XbFasppPfLhWsSmILc1Pyx/HCdYODmH33VVrslLBeDsTS00puI7uKOapzo/qorJUQL/XuHbzlzXHoA0+UPAdiX00SfJwYsje7GH1HEmFZ9twMI8Gwhylysm+8QUrPG7wyebgxzerFGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LrfnChzU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 06FCF20E6F3E; Thu, 28 Mar 2024 13:17:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06FCF20E6F3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711657049;
	bh=yZGrxkn+cU25usdylZ35Wq2Q4Amf947/qY8qYPcsQI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrfnChzUTVcoJReIyte1qtkKUbQW4jCaBKqpNQDG8i4Cm9dYdEdEss0UdTvjrmasM
	 ZaGMmuPRE9OpJRdOCXXysbLukp+yy04PqZ4CLQpDSN2KurnlXuVq9DHywAQD4C7VoN
	 AYvq98x1G/21af0VyYFLJjZwM4BPfcNa1s7ZTJVg=
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
Subject: [PATCH v16 11/20] block|security: add LSM blob to block_device
Date: Thu, 28 Mar 2024 13:17:18 -0700
Message-Id: <1711657047-10526-12-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Deven Bowers <deven.desai@linux.microsoft.com>

Some block devices have valuable security properties that is only
accessible during the creation time.

For example, when creating a dm-verity block device, the dm-verity's
roothash and roothash signature, which are extreme important security
metadata, are passed to the kernel. However, the roothash will be saved
privately in dm-verity, which prevents the security subsystem to easily
access that information. Worse, in the current implementation the
roothash signature will be discarded after the verification, making it
impossible to utilize the roothash signature by the security subsystem.

With this patch, an LSM blob is added to the block_device structure.
This enables the security subsystem to store security-sensitive data
related to block devices within the security blob. For example, LSM can
use the new LSM blob to save the roothash signature of a dm-verity,
and LSM can make access decision based on the data inside the signature,
like the signer certificate.

The implementation follows the same approach used for security blobs in
other structures like struct file, struct inode, and struct superblock.
The initialization of the security blob occurs after the creation of the
struct block_device, performed by the security subsystem. Similarly, the
security blob is freed by the security subsystem before the struct
block_device is deallocated or freed.

This patch also introduces a new hook to save block device's integrity
data. For example, for dm-verity, LSMs can use this hook to save
the roothash signature of a dm-verity into the security blob,
and LSMs can make access decisions based on the data inside
the signature, like the signer certificate.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v2:
  + No Changes

v3:
  + Minor style changes from checkpatch --strict

v4:
  + No Changes

v5:
  + Allow multiple callers to call security_bdev_setsecurity

v6:
  + Simplify security_bdev_setsecurity break condition

v7:
  + Squash all dm-verity related patches to two patches,
    the additions to dm-verity/fs, and the consumption of
    the additions.

v8:
  + Split dm-verity related patches squashed in v7 to 3 commits based on
    topic:
      + New LSM hook
      + Consumption of hook outside LSM
      + Consumption of hook inside LSM.

  + change return of security_bdev_alloc / security_bdev_setsecurity
    to LSM_RET_DEFAULT instead of 0.

  + Change return code to -EOPNOTSUPP, bring inline with other
    setsecurity hooks.

v9:
  + Add Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
  + Remove unlikely when calling LSM hook
  + Make the security field dependent on CONFIG_SECURITY

v10:
  + No changes

v11:
  + No changes

v12:
  + No changes

v13:
  + No changes

v14:
  + No changes

v15:
  + Drop security_bdev_setsecurity() for new hook
    security_bdev_setintegrity() in the next commit
  + Update call_int_hook() for 260017f

v16:
  + Drop Reviewed-by tag for the new changes
  + Squash the security_bdev_setintegrity() into this commit
  + Rename enum from lsm_intgr_type to lsm_integrity_type
  + Switch to use call_int_hook() for bdev_setintegrity()
  + Correct comment
  + Fix return in security_bdev_alloc()
---
 block/bdev.c                  |  7 +++
 include/linux/blk_types.h     |  3 ++
 include/linux/lsm_hook_defs.h |  5 ++
 include/linux/lsm_hooks.h     |  1 +
 include/linux/security.h      | 26 ++++++++++
 security/security.c           | 89 +++++++++++++++++++++++++++++++++++
 6 files changed, 131 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e..9e9c3cc8780b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -24,6 +24,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/uio.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/stat.h>
@@ -313,6 +314,11 @@ static struct inode *bdev_alloc_inode(struct super_block *sb)
 	if (!ei)
 		return NULL;
 	memset(&ei->bdev, 0, sizeof(ei->bdev));
+
+	if (security_bdev_alloc(&ei->bdev)) {
+		kmem_cache_free(bdev_cachep, ei);
+		return NULL;
+	}
 	return &ei->vfs_inode;
 }
 
@@ -322,6 +328,7 @@ static void bdev_free_inode(struct inode *inode)
 
 	free_percpu(bdev->bd_stats);
 	kfree(bdev->bd_meta_info);
+	security_bdev_free(bdev);
 
 	if (!bdev_is_partition(bdev)) {
 		if (bdev->bd_disk && bdev->bd_disk->bdi)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cb1526ec44b5..effe3c4e6b35 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -70,6 +70,9 @@ struct block_device {
 #endif
 	bool			bd_ro_warned;
 	int			bd_writers;
+#ifdef CONFIG_SECURITY
+	void			*security;
+#endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7db99ae75651..b391a7f13053 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -452,3 +452,8 @@ LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
 
 LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)
+
+LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
+LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
+LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
+	 enum lsm_integrity_type type, const void *value, size_t size)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a2ade0ffe9e7..f1692179aa56 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -78,6 +78,7 @@ struct lsm_blob_sizes {
 	int	lbs_msg_msg;
 	int	lbs_task;
 	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
+	int	lbs_bdev;
 };
 
 /**
diff --git a/include/linux/security.h b/include/linux/security.h
index f35af7b6cfba..8e646189740e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -83,6 +83,10 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+enum lsm_integrity_type {
+	__LSM_INT_MAX
+};
+
 /*
  * These are reasons that can be passed to the security_locked_down()
  * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
@@ -509,6 +513,11 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
+int security_bdev_alloc(struct block_device *bdev);
+void security_bdev_free(struct block_device *bdev);
+int security_bdev_setintegrity(struct block_device *bdev,
+			       enum lsm_integrity_type type, const void *value,
+			       size_t size);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1483,6 +1492,23 @@ static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int security_bdev_alloc(struct block_device *bdev)
+{
+	return 0;
+}
+
+static inline void security_bdev_free(struct block_device *bdev)
+{
+}
+
+static inline int security_bdev_setintegrity(struct block_device *bdev,
+					     enum lsm_integrity_type, type,
+					     const void *value, size_t size)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index b10230c51c0b..8f462d82bd8b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/msg.h>
 #include <linux/overflow.h>
 #include <net/flow.h>
+#include <linux/fs.h>
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
@@ -232,6 +233,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 	lsm_set_blob_size(&needed->lbs_xattr_count,
 			  &blob_sizes.lbs_xattr_count);
+	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
 }
 
 /* Prepare LSM for initialization. */
@@ -405,6 +407,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
+	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -737,6 +740,28 @@ static int lsm_msg_msg_alloc(struct msg_msg *mp)
 	return 0;
 }
 
+/**
+ * lsm_bdev_alloc - allocate a composite block_device blob
+ * @bdev: the block_device that needs a blob
+ *
+ * Allocate the block_device blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_bdev_alloc(struct block_device *bdev)
+{
+	if (blob_sizes.lbs_bdev == 0) {
+		bdev->security = NULL;
+		return 0;
+	}
+
+	bdev->security = kzalloc(blob_sizes.lbs_bdev, GFP_KERNEL);
+	if (!bdev->security)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /**
  * lsm_early_task - during initialization allocate a composite task blob
  * @task: the task that needs a blob
@@ -5568,6 +5593,70 @@ int security_locked_down(enum lockdown_reason what)
 }
 EXPORT_SYMBOL(security_locked_down);
 
+/**
+ * security_bdev_alloc() - Allocate a block device LSM blob
+ * @bdev: block device
+ *
+ * Allocate and attach a security structure to @bdev->security.  The
+ * security field is initialized to NULL when the bdev structure is
+ * allocated.
+ *
+ * Return: Return 0 if operation was successful.
+ */
+int security_bdev_alloc(struct block_device *bdev)
+{
+	int rc = 0;
+
+	rc = lsm_bdev_alloc(bdev);
+	if (unlikely(rc))
+		return rc;
+
+	rc = call_int_hook(bdev_alloc_security, bdev);
+	if (unlikely(rc))
+		security_bdev_free(bdev);
+
+	return rc;
+}
+EXPORT_SYMBOL(security_bdev_alloc);
+
+/**
+ * security_bdev_free() - Free a block device's LSM blob
+ * @bdev: block device
+ *
+ * Deallocate the bdev security structure and set @bdev->security to NULL.
+ */
+void security_bdev_free(struct block_device *bdev)
+{
+	if (!bdev->security)
+		return;
+
+	call_void_hook(bdev_free_security, bdev);
+
+	kfree(bdev->security);
+	bdev->security = NULL;
+}
+EXPORT_SYMBOL(security_bdev_free);
+
+/**
+ * security_bdev_setintegrity() - Set the device's integrity data
+ * @bdev: block device
+ * @type: type of integrity, e.g. hash digest, signature, etc
+ * @value: the integrity value
+ * @size: size of the integrity value
+ *
+ * Register a verified integrity measurement of a bdev with LSMs.
+ * LSMs should free the previously saved data if @value is NULL.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
+int security_bdev_setintegrity(struct block_device *bdev,
+			       enum lsm_integrity_type type, const void *value,
+			       size_t size)
+{
+	return call_int_hook(bdev_setintegrity, bdev, type, value, size);
+}
+EXPORT_SYMBOL(security_bdev_setintegrity);
+
 #ifdef CONFIG_PERF_EVENTS
 /**
  * security_perf_event_open() - Check if a perf event open is allowed
-- 
2.44.0


