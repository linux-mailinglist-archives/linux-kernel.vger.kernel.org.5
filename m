Return-Path: <linux-kernel+bounces-117337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91ED88AA27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53208304680
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192B4F890;
	Mon, 25 Mar 2024 15:12:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1793DAC11;
	Mon, 25 Mar 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379519; cv=none; b=MAAwU8jdKM2y7zTTDZNN9qnXrDD0cNiXYTboDRSZ5uuX5435eMCTdeNv+o8Vm1LQ2IWqQCidQiHiau0dTD6ZpGVCgweQaCdJGEZQJESPi7gVKoBEXGKecC69S8273SiZXwzI6OVftUaa/brGMcY1VeCx3gar/0c3Q/ZvdHg7HxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379519; c=relaxed/simple;
	bh=b/fEWS5R/gx3wNoown5qr0JNRYLoZPphEPsSgCObNLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gB4mE8hbK2KX+fgMyiA1kdhaDLxyp71pRlAmDBi6MM8+J/XQ+vIE38ydu93NMK5V+nN2wHJa3DxQmn1wWEe1gGE6/a/j8EtegoAyA6W6zG2m5FsW01orPqvRxF3Y5nwsfiKX+FF0GnhRPBVD9RA4KNcgxeiNSusckXwmvV6DZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8029339;
	Mon, 25 Mar 2024 08:12:30 -0700 (PDT)
Received: from mango.localdomain (unknown [10.57.15.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC2273F64C;
	Mon, 25 Mar 2024 08:11:54 -0700 (PDT)
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
	rdunlap@infradead.org,
	krzk@kernel.org,
	gyorgy.szing@arm.com
Subject: [PATCH v4 2/5] tee: optee: Move pool_op helper functions
Date: Mon, 25 Mar 2024 16:11:02 +0100
Message-Id: <20240325151105.135667-3-balint.dobszay@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325151105.135667-1-balint.dobszay@arm.com>
References: <20240325151105.135667-1-balint.dobszay@arm.com>
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---
 drivers/tee/optee/core.c          | 64 -------------------------------
 drivers/tee/optee/ffa_abi.c       |  6 +--
 drivers/tee/optee/optee_private.h | 12 ------
 drivers/tee/optee/smc_abi.c       |  9 ++---
 drivers/tee/tee_shm.c             | 64 +++++++++++++++++++++++++++++++
 include/linux/tee_core.h          | 10 +++++
 6 files changed, 81 insertions(+), 84 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index f762e3a25119..39e688d4e974 100644
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
index cee8ccb84cb8..3235e1c719e8 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
 			     struct tee_shm *shm, size_t size, size_t align)
 {
-	return optee_pool_op_alloc_helper(pool, shm, size, align,
-					  optee_ffa_shm_register);
+	return tee_dyn_shm_alloc_helper(shm, size, align,
+					optee_ffa_shm_register);
 }
 
 static void pool_ffa_op_free(struct tee_shm_pool *pool,
 			     struct tee_shm *shm)
 {
-	optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
+	tee_dyn_shm_free_helper(shm, optee_ffa_shm_unregister);
 }
 
 static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index a0698ac18993..429cc20be5cc 100644
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
index 9c296b887dc1..734c484ed0f6 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -592,19 +592,18 @@ static int pool_op_alloc(struct tee_shm_pool *pool,
 	 * to be registered with OP-TEE.
 	 */
 	if (shm->flags & TEE_SHM_PRIV)
-		return optee_pool_op_alloc_helper(pool, shm, size, align, NULL);
+		return tee_dyn_shm_alloc_helper(shm, size, align, NULL);
 
-	return optee_pool_op_alloc_helper(pool, shm, size, align,
-					  optee_shm_register);
+	return tee_dyn_shm_alloc_helper(shm, size, align, optee_shm_register);
 }
 
 static void pool_op_free(struct tee_shm_pool *pool,
 			 struct tee_shm *shm)
 {
 	if (!(shm->flags & TEE_SHM_PRIV))
-		optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
+		tee_dyn_shm_free_helper(shm, optee_shm_unregister);
 	else
-		optee_pool_op_free_helper(pool, shm, NULL);
+		tee_dyn_shm_free_helper(shm, NULL);
 }
 
 static void pool_op_destroy_pool(struct tee_shm_pool *pool)
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 96a45c817427..5bf76c35cd9e 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -202,6 +202,70 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
 
+int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
+			     int (*shm_register)(struct tee_context *ctx,
+						 struct tee_shm *shm,
+						 struct page **pages,
+						 size_t num_pages,
+						 unsigned long start))
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
+EXPORT_SYMBOL_GPL(tee_dyn_shm_alloc_helper);
+
+void tee_dyn_shm_free_helper(struct tee_shm *shm,
+			     int (*shm_unregister)(struct tee_context *ctx,
+						   struct tee_shm *shm))
+{
+	if (shm_unregister)
+		shm_unregister(shm->ctx, shm);
+	free_pages_exact(shm->kaddr, shm->size);
+	shm->kaddr = NULL;
+	kfree(shm->pages);
+	shm->pages = NULL;
+}
+EXPORT_SYMBOL_GPL(tee_dyn_shm_free_helper);
+
 static struct tee_shm *
 register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 		    int id)
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index d9b3ba8e8fa9..efd16ed52315 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -232,6 +232,16 @@ void *tee_get_drvdata(struct tee_device *teedev);
  */
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 
+int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
+			     int (*shm_register)(struct tee_context *ctx,
+						 struct tee_shm *shm,
+						 struct page **pages,
+						 size_t num_pages,
+						 unsigned long start));
+void tee_dyn_shm_free_helper(struct tee_shm *shm,
+			     int (*shm_unregister)(struct tee_context *ctx,
+						   struct tee_shm *shm));
+
 /**
  * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic kind
  * @shm:	Shared memory handle
-- 
2.34.1


