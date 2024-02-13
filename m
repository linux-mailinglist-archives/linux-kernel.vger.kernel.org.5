Return-Path: <linux-kernel+bounces-63723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F288533A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F51281C73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A25B20F;
	Tue, 13 Feb 2024 14:54:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E526AD4;
	Tue, 13 Feb 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836040; cv=none; b=tzQKlvxdyrJrOrIMrH5LekrdfJGict0+E+o0UvjbpOH2pkPqjYTmN5umTpymZuWnfMZ6LwfLS/TKQEDuHitCXDsn4uA9F3f2nuN1mErUPZuVkUzPIKZ8bPxhNJbUR7/hrJHUD8AijcLEETGtdq0kwZp18qD3k+nRiZKHpFbiM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836040; c=relaxed/simple;
	bh=9zMxIiodTzgE1GyrP2I4rb5uFKRlL7/UtTG8n78T8pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T61m1ssann9tvljO/9cXzQmkJpuvCPS+E5euQ3d4JZUkFn8ij1Mxd+59WO+VaiAy5Jl3PWEeLxBS2QSLNMje3kWkFa9RJR/uzqCYYV+GIWrQ9PQj+NKS16PlqCqNpvUiJdrw18wpQt/bWzg/Xvu/Ly5IhkqVqDMWHV5TgoUM9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E948DA7;
	Tue, 13 Feb 2024 06:54:39 -0800 (PST)
Received: from mango.localdomain (TVHN20WD9G.budapest.arm.com [10.45.25.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AD413F7B4;
	Tue, 13 Feb 2024 06:53:56 -0800 (PST)
From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: jens.wiklander@linaro.org,
	sumit.garg@linaro.org,
	corbet@lwn.net,
	balint.dobszay@arm.com,
	sudeep.holla@arm.com,
	gyorgy.szing@arm.com
Subject: [PATCH 1/3] tee: optee: Move pool_op helper functions
Date: Tue, 13 Feb 2024 15:52:37 +0100
Message-Id: <20240213145239.379875-2-balint.dobszay@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213145239.379875-1-balint.dobszay@arm.com>
References: <20240213145239.379875-1-balint.dobszay@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pool alloc and free helper functions from the OP-TEE driver to
the TEE subsystem, since these could be reused in other TEE drivers.
This patch is not supposed to change behavior, it's only reorganizing
the code.

Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---
 drivers/tee/optee/core.c          | 64 ------------------------------
 drivers/tee/optee/ffa_abi.c       |  6 +--
 drivers/tee/optee/optee_private.h | 12 ------
 drivers/tee/optee/smc_abi.c       | 10 ++---
 drivers/tee/tee_shm.c             | 65 +++++++++++++++++++++++++++++++
 include/linux/tee_drv.h           | 11 ++++++
 6 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 3aed554bc8d8..9390f21f9902 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -9,7 +9,6 @@
 #include <linux/crash_dump.h>
 #include <linux/errno.h>
 #include <linux/io.h>
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -17,69 +16,6 @@
 #include <linux/types.h>
 #include "optee_private.h"
 
-int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
-			       size_t size, size_t align,
-			       int (*shm_register)(struct tee_context *ctx,
-						   struct tee_shm *shm,
-						   struct page **pages,
-						   size_t num_pages,
-						   unsigned long start))
-{
-	size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
-	struct page **pages;
-	unsigned int i;
-	int rc = 0;
-
-	/*
-	 * Ignore alignment since this is already going to be page aligned
-	 * and there's no need for any larger alignment.
-	 */
-	shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
-				       GFP_KERNEL | __GFP_ZERO);
-	if (!shm->kaddr)
-		return -ENOMEM;
-
-	shm->paddr = virt_to_phys(shm->kaddr);
-	shm->size = nr_pages * PAGE_SIZE;
-
-	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
-	if (!pages) {
-		rc = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < nr_pages; i++)
-		pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
-
-	shm->pages = pages;
-	shm->num_pages = nr_pages;
-
-	if (shm_register) {
-		rc = shm_register(shm->ctx, shm, pages, nr_pages,
-				  (unsigned long)shm->kaddr);
-		if (rc)
-			goto err;
-	}
-
-	return 0;
-err:
-	free_pages_exact(shm->kaddr, shm->size);
-	shm->kaddr = NULL;
-	return rc;
-}
-
-void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
-			       int (*shm_unregister)(struct tee_context *ctx,
-						     struct tee_shm *shm))
-{
-	if (shm_unregister)
-		shm_unregister(shm->ctx, shm);
-	free_pages_exact(shm->kaddr, shm->size);
-	shm->kaddr = NULL;
-	kfree(shm->pages);
-	shm->pages = NULL;
-}
-
 static void optee_bus_scan(struct work_struct *work)
 {
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ecb5eb079408..ee11918a2b35 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
 			     struct tee_shm *shm, size_t size, size_t align)
 {
-	return optee_pool_op_alloc_helper(pool, shm, size, align,
-					  optee_ffa_shm_register);
+	return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
+					    optee_ffa_shm_register);
 }
 
 static void pool_ffa_op_free(struct tee_shm_pool *pool,
 			     struct tee_shm *shm)
 {
-	optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
+	tee_shm_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
 }
 
 static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 7a5243c78b55..a153285a1919 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -283,18 +283,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
 int optee_enumerate_devices(u32 func);
 void optee_unregister_devices(void);
 
-int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
-			       size_t size, size_t align,
-			       int (*shm_register)(struct tee_context *ctx,
-						   struct tee_shm *shm,
-						   struct page **pages,
-						   size_t num_pages,
-						   unsigned long start));
-void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
-			       int (*shm_unregister)(struct tee_context *ctx,
-						     struct tee_shm *shm));
-
-
 void optee_remove_common(struct optee *optee);
 int optee_open(struct tee_context *ctx, bool cap_memref_null);
 void optee_release(struct tee_context *ctx);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a37f87087e5c..78f4c8c43790 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -592,19 +592,19 @@ static int pool_op_alloc(struct tee_shm_pool *pool,
 	 * to be registered with OP-TEE.
 	 */
 	if (shm->flags & TEE_SHM_PRIV)
-		return optee_pool_op_alloc_helper(pool, shm, size, align, NULL);
+		return tee_shm_pool_op_alloc_helper(pool, shm, size, align, NULL);
 
-	return optee_pool_op_alloc_helper(pool, shm, size, align,
-					  optee_shm_register);
+	return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
+					    optee_shm_register);
 }
 
 static void pool_op_free(struct tee_shm_pool *pool,
 			 struct tee_shm *shm)
 {
 	if (!(shm->flags & TEE_SHM_PRIV))
-		optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
+		tee_shm_pool_op_free_helper(pool, shm, optee_shm_unregister);
 	else
-		optee_pool_op_free_helper(pool, shm, NULL);
+		tee_shm_pool_op_free_helper(pool, shm, NULL);
 }
 
 static void pool_op_destroy_pool(struct tee_shm_pool *pool)
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 731d9028b67f..641aad92ffe2 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -202,6 +202,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
 
+int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
+				 size_t size, size_t align,
+				 int (*shm_register)(struct tee_context *ctx,
+						     struct tee_shm *shm,
+						     struct page **pages,
+						     size_t num_pages,
+						     unsigned long start))
+{
+	size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
+	struct page **pages;
+	unsigned int i;
+	int rc = 0;
+
+	/*
+	 * Ignore alignment since this is already going to be page aligned
+	 * and there's no need for any larger alignment.
+	 */
+	shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
+				       GFP_KERNEL | __GFP_ZERO);
+	if (!shm->kaddr)
+		return -ENOMEM;
+
+	shm->paddr = virt_to_phys(shm->kaddr);
+	shm->size = nr_pages * PAGE_SIZE;
+
+	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
+
+	shm->pages = pages;
+	shm->num_pages = nr_pages;
+
+	if (shm_register) {
+		rc = shm_register(shm->ctx, shm, pages, nr_pages,
+				  (unsigned long)shm->kaddr);
+		if (rc)
+			goto err;
+	}
+
+	return 0;
+err:
+	free_pages_exact(shm->kaddr, shm->size);
+	shm->kaddr = NULL;
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tee_shm_pool_op_alloc_helper);
+
+void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
+				 int (*shm_unregister)(struct tee_context *ctx,
+						       struct tee_shm *shm))
+{
+	if (shm_unregister)
+		shm_unregister(shm->ctx, shm);
+	free_pages_exact(shm->kaddr, shm->size);
+	shm->kaddr = NULL;
+	kfree(shm->pages);
+	shm->pages = NULL;
+}
+EXPORT_SYMBOL_GPL(tee_shm_pool_op_free_helper);
+
 static struct tee_shm *
 register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 		    int id)
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 911ddf92dcee..4cf402424e71 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
 
+int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
+				 size_t size, size_t align,
+				 int (*shm_register)(struct tee_context *ctx,
+						     struct tee_shm *shm,
+						     struct page **pages,
+						     size_t num_pages,
+						     unsigned long start));
+void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
+				 int (*shm_unregister)(struct tee_context *ctx,
+						       struct tee_shm *shm));
+
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length);
 
-- 
2.34.1


