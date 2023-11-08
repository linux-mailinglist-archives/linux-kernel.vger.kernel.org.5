Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01C7E534F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjKHK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344118AbjKHK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:28:03 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9421BDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:28:01 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso755611866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699439279; x=1700044079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUHjwT95/qhV7lZuHewMUZiNJ+XtLQuRnKayggvsNMI=;
        b=HVngrb0rLgPRcAaPvm/qEi4yeSABChXGbViaMn2t4BZ/SulPzMiAeY5aVI/qCKc//6
         zakk+H1z7fySiQbnZ7dRjVMab/ohGoYyGyKh7RVRSUweMmpzfHuT6p4kG9Sr1yCdbbML
         Rsxdxbc2mrBJ8ntD/bPfaVVfII/M4RdUglUb8zNw6S+bQroIyN7duoDJ35QE/8MQrEou
         OlU0NvNhQrABQsMLTfr7R7bAV+u3XC2KVQvIhmTeLiTldLqDh6J0uPB1zBiFDeWjvsQI
         TZcWSbnVwCMoPIewokB1petar86niMXNAPGvzGUEpjjGhG0T1PDDqtJiBWMN639jRO2M
         Mkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439279; x=1700044079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUHjwT95/qhV7lZuHewMUZiNJ+XtLQuRnKayggvsNMI=;
        b=JwkjJQf1bHULGOgOIGBZEUn29a+y1J2215gGzffAAiOPDOTrl1FamZxG+rVOkLPeD1
         i2mcytdFO/PXA18bTPCtoSN1nvUiYvFSaMU8beqvSeeeFjZSHz34bDBr1JxeIYRQdp+W
         kEjguDHQHF+A1vgnrjZu5B9uAZcWaxFX+Lq8cGfzpuqKxajNqFpDEl9v2XW/ewbK5iE2
         u4Xu4cygETKgQ4dEPACUd3lPFlpTbe7/T0IPc4DxuGsCHu60nUqM96+M4//xHs3RFGYp
         RtEvKIqYdRqeFwx0Wm5JyfYXNHhEi6sdwHdu6CGv9cBcEX4foe1P9zQKeXEBZl4Rp/Zd
         4t4Q==
X-Gm-Message-State: AOJu0Yy4hWf/okuHgR82Wpga7vNzY9mqUT/3on0PZQjQ1cNlyej68w/f
        +0oIFomm2WV2polePdpE+rPFV7LCs4fyOC1tBng=
X-Google-Smtp-Source: AGHT+IF1CUvGBU3Xa9r5QowmRzkYAT3vd4cUz1L7GPAl5AGt4hBMf2L/T5mIY4EeQfRve46XFJyUlw==
X-Received: by 2002:a17:906:ee81:b0:9c7:5db4:c943 with SMTP id wt1-20020a170906ee8100b009c75db4c943mr979029ejb.40.1699439279411;
        Wed, 08 Nov 2023 02:27:59 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id bn22-20020a170906c0d600b009c3827134e5sm803257ejb.117.2023.11.08.02.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:27:58 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 1/2] optee: add page list to kernel private shared memory
Date:   Wed,  8 Nov 2023 11:27:54 +0100
Message-Id: <20231108102755.93079-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108102755.93079-1-jens.wiklander@linaro.org>
References: <20231108102755.93079-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now has kernel private shared memory allocated as dynamic shared
memory (not from the static shared memory pool) been returned without a
list of physical pages on allocations via RPC. To support allocations
larger than one page add a list of physical pages for all allocations
larger than one page.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c    | 40 +++++++++++++++++++++++++--------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..a425eca0173d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -27,6 +27,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 						   unsigned long start))
 {
 	unsigned int order = get_order(size);
+	unsigned int nr_pages = 1 << order;
 	struct page *page;
 	int rc = 0;
 
@@ -39,12 +40,24 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 		return -ENOMEM;
 
 	shm->kaddr = page_address(page);
-	shm->paddr = page_to_phys(page);
 	shm->size = PAGE_SIZE << order;
 
-	if (shm_register) {
-		unsigned int nr_pages = 1 << order, i;
+	/*
+	 * If memory is registered immediately use a temporary page list
+	 * and free it directly after the registration is completed.
+	 *
+	 * Else, if we have allocated more than one page store a page
+	 * list in the struct tee_shm.
+	 *
+	 * Else, store the physical address of the single page that was
+	 * allocated.
+	 *
+	 * optee_pool_op_free_helper() is responsible for freeing the
+	 * resourses allocated in this function.
+	 */
+	if (shm_register || nr_pages > 1) {
 		struct page **pages;
+		unsigned int i;
 
 		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 		if (!pages) {
@@ -55,17 +68,24 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 		for (i = 0; i < nr_pages; i++)
 			pages[i] = page + i;
 
-		rc = shm_register(shm->ctx, shm, pages, nr_pages,
-				  (unsigned long)shm->kaddr);
-		kfree(pages);
-		if (rc)
-			goto err;
+		if (shm_register) {
+			rc = shm_register(shm->ctx, shm, pages, nr_pages,
+					  (unsigned long)shm->kaddr);
+			kfree(pages);
+			if (rc)
+				goto err;
+		} else {
+			shm->pages = pages;
+			shm->num_pages = nr_pages;
+		}
+	} else {
+		shm->paddr = page_to_phys(page);
 	}
 
 	return 0;
-
 err:
 	free_pages((unsigned long)shm->kaddr, order);
+	shm->kaddr = NULL;
 	return rc;
 }
 
@@ -77,6 +97,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 		shm_unregister(shm->ctx, shm);
 	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
 	shm->kaddr = NULL;
+	kfree(shm->pages);
+	shm->pages = NULL;
 }
 
 static void optee_bus_scan(struct work_struct *work)
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..b69410c7cc0a 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 					  struct optee_msg_arg *arg,
 					  struct optee_call_ctx *call_ctx)
 {
-	phys_addr_t pa;
 	struct tee_shm *shm;
 	size_t sz;
 	size_t n;
+	struct page **pages;
+	size_t page_count;
 
 	arg->ret_origin = TEEC_ORIGIN_COMMS;
 
@@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		return;
 	}
 
-	if (tee_shm_get_pa(shm, 0, &pa)) {
-		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
-		goto bad;
-	}
-
-	sz = tee_shm_get_size(shm);
-
-	if (tee_shm_is_dynamic(shm)) {
-		struct page **pages;
+	/*
+	 * If there are pages it's dynamically allocated shared memory (not
+	 * from the reserved shared memory pool) and needs to be
+	 * registered.
+	 */
+	pages = tee_shm_get_pages(shm, &page_count);
+	if (pages) {
 		u64 *pages_list;
-		size_t page_num;
-
-		pages = tee_shm_get_pages(shm, &page_num);
-		if (!pages || !page_num) {
-			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
-			goto bad;
-		}
 
-		pages_list = optee_allocate_pages_list(page_num);
+		pages_list = optee_allocate_pages_list(page_count);
 		if (!pages_list) {
 			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
 			goto bad;
 		}
 
 		call_ctx->pages_list = pages_list;
-		call_ctx->num_entries = page_num;
+		call_ctx->num_entries = page_count;
 
 		arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
 				      OPTEE_MSG_ATTR_NONCONTIG;
@@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		arg->params[0].u.tmem.buf_ptr = virt_to_phys(pages_list) |
 			(tee_shm_get_page_offset(shm) &
 			 (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
-		arg->params[0].u.tmem.size = tee_shm_get_size(shm);
-		arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
 
-		optee_fill_pages_list(pages_list, pages, page_num,
+		optee_fill_pages_list(pages_list, pages, page_count,
 				      tee_shm_get_page_offset(shm));
 	} else {
+		phys_addr_t pa;
+
+		if (tee_shm_get_pa(shm, 0, &pa)) {
+			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+			goto bad;
+		}
+
 		arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
 		arg->params[0].u.tmem.buf_ptr = pa;
-		arg->params[0].u.tmem.size = sz;
-		arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
 	}
+	arg->params[0].u.tmem.size = tee_shm_get_size(shm);
+	arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
 
 	arg->ret = TEEC_SUCCESS;
 	return;
-- 
2.34.1

