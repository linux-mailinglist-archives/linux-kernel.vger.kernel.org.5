Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF677E5350
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbjKHK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbjKHK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:28:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F50C1BDA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:28:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9df8d0c556eso524845166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699439280; x=1700044080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzMT8h5BYxkotAzYPp9Npys6bmDV+d4FCgdKvO3GgjE=;
        b=cYmFxkftgJPpWiKhboH1C4EqeUolJw1Ui4+eAslWs2Hutmja8/xffMcEab6lGBspRq
         rFh3SjX30ztOWwtLurX7kSNfzROKhPubx9GogRTdrNVOuLMJBeiDPqgVLVQBo5iZiucX
         PJYBlYP9Kea/+dPROgCIBpx1fVp39Tg3JwLHbKRoFfOn9Nfoj5JAf/q8ppd8HYBoAqy/
         4F4sjDXPG0h+RwfNVFdnvS9BBw7mtrNdPxXyWhUoa8j1/MaTnY5Yf5A2keV6GC0m7Hh+
         rcxxlbwCMki8cdyCq9ohFSiv4RopuYYS5ALd8VPsa1CJPktJZiWjiYOznB9Kh7wNQ15Z
         ow2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439280; x=1700044080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzMT8h5BYxkotAzYPp9Npys6bmDV+d4FCgdKvO3GgjE=;
        b=YSYv0TsAGyDEIjvc8n36GlH3cd55z2NWhf5WmLQlUE9Qf+5RWogUkaFh/fNjNeK7nR
         x99AFUY9PlHo6QlFEh0qgXpoM6CviXUb1xutMXj9LCKj0Su9IygaEeMxJtXZPmvpCahx
         EejO++ckv4fU4Mr3804+zHt6oeU7+Xs4peW3VZcDXPurb3fBUQk9Nk9nYn9sJBNFKesz
         ggdY6sx9WtEJZl6xwywYOqs35E0kIySLiolpmwrF0OmQ7Qeyc/d+9uG3pTUzRiRNdGwp
         pGpfiVGuQK72yEhI6R9rfFV9Pyx647l6NciDCzNEWw5ygwop8RORk719mHJdFw6jYcht
         mgEA==
X-Gm-Message-State: AOJu0Yy6zMjSfgOUAeBvAAq6wO3sb+8kJBPkWJAWjY8Q/N0iGQ8bYq0R
        xS/jFaCfIU6vXiPeLyLMZk25mQVMjiv6VS4BUpQ=
X-Google-Smtp-Source: AGHT+IHByWl9iLECFcMG0cyvjcAklVQVRyi165D6TlG4KsAbBV7SEdCDIm5T2fXSyab853Wg/fH4WQ==
X-Received: by 2002:a17:907:804:b0:9ae:4776:5a3a with SMTP id wv4-20020a170907080400b009ae47765a3amr976552ejb.39.1699439280538;
        Wed, 08 Nov 2023 02:28:00 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id bn22-20020a170906c0d600b009c3827134e5sm803257ejb.117.2023.11.08.02.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:27:59 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 2/2] optee: allocate shared memory with alloc_pages_exact()
Date:   Wed,  8 Nov 2023 11:27:55 +0100
Message-Id: <20231108102755.93079-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108102755.93079-1-jens.wiklander@linaro.org>
References: <20231108102755.93079-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate memory to share with the secure using alloc_pages_exact()
instead of alloc_pages() for more efficient memory usage.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a425eca0173d..6303085a1b49 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -26,21 +26,19 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 						   size_t num_pages,
 						   unsigned long start))
 {
-	unsigned int order = get_order(size);
-	unsigned int nr_pages = 1 << order;
-	struct page *page;
+	size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
 	int rc = 0;
 
 	/*
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
-	shm->size = PAGE_SIZE << order;
+	shm->size = nr_pages * PAGE_SIZE;
 
 	/*
 	 * If memory is registered immediately use a temporary page list
@@ -66,7 +64,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 		}
 
 		for (i = 0; i < nr_pages; i++)
-			pages[i] = page + i;
+			pages[i] = virt_to_page((u8 *)shm->kaddr +
+						i * PAGE_SIZE);
 
 		if (shm_register) {
 			rc = shm_register(shm->ctx, shm, pages, nr_pages,
@@ -79,12 +78,12 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 			shm->num_pages = nr_pages;
 		}
 	} else {
-		shm->paddr = page_to_phys(page);
+		shm->paddr = virt_to_phys(shm->kaddr);
 	}
 
 	return 0;
 err:
-	free_pages((unsigned long)shm->kaddr, order);
+	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr = NULL;
 	return rc;
 }
@@ -95,7 +94,7 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
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

