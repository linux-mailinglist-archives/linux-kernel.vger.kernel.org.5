Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF37EAD64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjKNJwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKNJwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:52:36 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D37191
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:52:32 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c115026985so5570288b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699955552; x=1700560352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLRgBSnIsahghCgCHXz9rGutSrnAaUdwkEkt9d4hS6A=;
        b=cKr0w1GaXhCXLGiy4d9VuzTCICQlUl6+Gzg1WfkR7HaCBFBjA1NgEZVPWWIjc2UyGl
         5n1jqmPi5yih+aPlXVMK76SF0DKwu9RXulOsw+mBt5Tt/PX+S70xZJu7vLg/6S7yAtiH
         1HmeapNBl5h6TcDOZMD20lfQ4sYPQEXrCbIfXOJf2vBKIlI5tiHp77a0qwV557fFgINN
         rOJxsJnwz8uxoamYEKzMA4tpurUienvc4cIyNZ4wUwFsrWiUEe7TuAtC/VaLNso1JYpW
         yxQWkJaretPt7jpheMRPcHsQZgw6sElCkWGmDzc+4V1v5rD1MZ+d4gukWOUTs2hvyzc2
         bnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699955552; x=1700560352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLRgBSnIsahghCgCHXz9rGutSrnAaUdwkEkt9d4hS6A=;
        b=o1dAGDEiR1FXAf5iOWKZ22KtsyQwFvHb7j53q3U5iopXogjYXN9+KbOmJWm5NiFqbF
         PeBa1TN4AyyPusScPdWZcEXNyWGqOUgrSRCoF1gmRzRxOVV6K+2ljxsvzaUu1TYgxQAI
         koHXICuhxcnkm6Q4Obwmj3/8PJRtjUEF6W1L4ATKTe0kLxySU5HXfi19Bf6uHS7PGkh0
         Y32Kuh4yfvGU3+bTodief6lkWrvZb2l9i0+BNxHKKC95GhyjY3OToWfwE1HsgRrHDAWt
         Pwnl5DlMctdi3mimc3IM0GDVOFNuInGFtvpdYQzhCxtFc8OH6VPxhMBZzcqDwny/zGzG
         AQtA==
X-Gm-Message-State: AOJu0YzWAvQnM4TpAY/taWuWkolsuOFltNlJiU9Z9ddONE5117Hr/5GW
        i+FhIAPZgomaqs/pHyQI91C5Y3XbD2InGTessf8=
X-Google-Smtp-Source: AGHT+IGQ1QeE48zETjHJDQ7bwmHdWJonhyiYXYYQDJBcxEUPplWmhhBGFbDTLIUn7Vfcm4UNvtos6w==
X-Received: by 2002:a05:6a20:1447:b0:15d:b243:6131 with SMTP id a7-20020a056a20144700b0015db2436131mr11396876pzi.44.1699955551955;
        Tue, 14 Nov 2023 01:52:31 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006c34015a8f2sm874749pfi.146.2023.11.14.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:52:31 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 1/2] optee: add page list to kernel private shared memory
Date:   Tue, 14 Nov 2023 10:52:16 +0100
Message-Id: <20231114095217.1142360-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114095217.1142360-1-jens.wiklander@linaro.org>
References: <20231114095217.1142360-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now has kernel private shared memory allocated as dynamic shared
memory (not from the static shared memory pool) been returned without a
list of physical pages on allocations via RPC. To support allocations
larger than one page add a list of physical pages.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c    | 28 +++++++++++++----------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..38ea2fecfc2e 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -27,7 +27,10 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 						   unsigned long start))
 {
 	unsigned int order = get_order(size);
+	unsigned int nr_pages = 1 << order;
+	struct page **pages;
 	struct page *page;
+	unsigned int i;
 	int rc = 0;
 
 	/*
@@ -42,30 +45,29 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 	shm->paddr = page_to_phys(page);
 	shm->size = PAGE_SIZE << order;
 
-	if (shm_register) {
-		unsigned int nr_pages = 1 << order, i;
-		struct page **pages;
+	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		rc = -ENOMEM;
+		goto err;
+	}
 
-		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
-		if (!pages) {
-			rc = -ENOMEM;
-			goto err;
-		}
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = page + i;
 
-		for (i = 0; i < nr_pages; i++)
-			pages[i] = page + i;
+	shm->pages = pages;
+	shm->num_pages = nr_pages;
 
+	if (shm_register) {
 		rc = shm_register(shm->ctx, shm, pages, nr_pages,
 				  (unsigned long)shm->kaddr);
-		kfree(pages);
 		if (rc)
 			goto err;
 	}
 
 	return 0;
-
 err:
 	free_pages((unsigned long)shm->kaddr, order);
+	shm->kaddr = NULL;
 	return rc;
 }
 
@@ -77,6 +79,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
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

