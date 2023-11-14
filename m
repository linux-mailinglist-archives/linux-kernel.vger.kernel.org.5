Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820B67EAD65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjKNJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjKNJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:52:43 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBFE1B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:52:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692c02adeefso4815960b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699955557; x=1700560357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYDsu5lJwL/Ln9te5CEC5b5SypRoh7tDXJlqgzKOaW4=;
        b=p7S5E0/xyHL560T8PZxR6GUvC5Qz6jr6VfE+oADFGKTafqZyZSB+wDhSmtQiVK54YS
         /8Jp0tcz7c7cTZlVUBAZrE5BZ8p00FRehPCsw3llPxbmFpDEtv5qRltpPPsLDLmRz4z6
         e1TPaPfs/S/X6tqDE5Rfzr65DBL2C/qbImzWoieoZFuCyvnzvng8mDx6GwUyB/KlyUUS
         8I8hWspJE6U/6mwgvJlL2BpiM+pa6zVGxkF3n/yB5/u6HOnRw8ndCNXfP3ZyRLH+iaNe
         XyXHdCL2PB94C5goY27dFizAL7sG+c2TMwBvbGYn/MaE+wkqIt3L2GlEknVUN0xTIU3N
         PQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699955557; x=1700560357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYDsu5lJwL/Ln9te5CEC5b5SypRoh7tDXJlqgzKOaW4=;
        b=q6qadnRVZv1OxIh6CSSPCuPueGi1hd2Rl23tr9tOv7GlIWciq1aYpPOwfyYLMtZh5W
         QiUJ6UmP1ank/OJMtzcpoPapoUJP0WFsQTwaJA2XaoHANeCD9YE/RInGO85L+6V6xSCm
         KKI59wZPiyqvgrYQYgEvAS02j9YC3ZWQY54pWDeKaRPbeH81n7r4LFT/kLyLSn9YGBqj
         foA1J7FmU54iIFebJHNGJroxnWDqrFsQ1pO41wSHa/ztG9BDTRTgLvveBI7LgtVgfsu4
         N5LfhM0wDOwr2BC0fSmrMdJCfPaQJ2N+U6kQTeEdxHb/LciiuMmo3//tKU87uSEUt+xJ
         GMLg==
X-Gm-Message-State: AOJu0YxTfSvChTa/o+MhhwNbEfYt7TvvaSrQT2/CXtahGCE0VR+k1iW6
        unZYA35tzlXi41dbq22gJKszYkDYWnyiN4QYHio=
X-Google-Smtp-Source: AGHT+IHeL7xoQ3PNH9+H+CYAhNwd2NEtWMMLyE8jVSEni0ZXIvgOWDmsOkvbLbFjgcdpnZScBIA3bA==
X-Received: by 2002:a05:6a20:7d81:b0:186:69ed:d9c6 with SMTP id v1-20020a056a207d8100b0018669edd9c6mr4495586pzj.48.1699955556878;
        Tue, 14 Nov 2023 01:52:36 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006c34015a8f2sm874749pfi.146.2023.11.14.01.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:52:36 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 2/2] optee: allocate shared memory with alloc_pages_exact()
Date:   Tue, 14 Nov 2023 10:52:17 +0100
Message-Id: <20231114095217.1142360-3-jens.wiklander@linaro.org>
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

Allocate memory to share with the secure using alloc_pages_exact()
instead of alloc_pages() for more efficient memory usage.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 38ea2fecfc2e..4a4b03b4fc7d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -26,10 +26,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 						   size_t num_pages,
 						   unsigned long start))
 {
-	unsigned int order = get_order(size);
-	unsigned int nr_pages = 1 << order;
+	size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
 	struct page **pages;
-	struct page *page;
 	unsigned int i;
 	int rc = 0;
 
@@ -37,13 +35,13 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 	 * Ignore alignment since this is already going to be page aligned
 	 * and there's no need for any larger alignment.
 	 */
-	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!page)
+	shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
+				       GFP_KERNEL | __GFP_ZERO);
+	if (!shm->kaddr)
 		return -ENOMEM;
 
-	shm->kaddr = page_address(page);
-	shm->paddr = page_to_phys(page);
-	shm->size = PAGE_SIZE << order;
+	shm->paddr = virt_to_phys(shm->kaddr);
+	shm->size = nr_pages * PAGE_SIZE;
 
 	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages) {
@@ -52,7 +50,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 	}
 
 	for (i = 0; i < nr_pages; i++)
-		pages[i] = page + i;
+		pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
 
 	shm->pages = pages;
 	shm->num_pages = nr_pages;
@@ -66,7 +64,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 
 	return 0;
 err:
-	free_pages((unsigned long)shm->kaddr, order);
+	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr = NULL;
 	return rc;
 }
@@ -77,7 +75,7 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 {
 	if (shm_unregister)
 		shm_unregister(shm->ctx, shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr = NULL;
 	kfree(shm->pages);
 	shm->pages = NULL;
-- 
2.34.1

