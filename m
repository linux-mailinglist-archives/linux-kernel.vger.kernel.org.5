Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8FD7FA7C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjK0RM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjK0RM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:12:27 -0500
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEECA5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:12:24 -0800 (PST)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ARDiDTb019822;
        Mon, 27 Nov 2023 18:12:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=3rQUjhT
        +AfG8UO1cbyIJMxJrIwkZH4cYCzvy484HdE4=; b=19wUlMChMKMIjJFa+Apb4Xw
        WeoBzfTyGJO6FfPXRNFBXWqp7j2vVIV6gxzWJv+CIr4umSh8NM1YhaqE/b2cys0W
        JG0jBfJyh5GtKAU+xc5LjuLSrytGyWyjyf4ovnG5eVl74MBs5aEu7xkin5hrzxcZ
        +uiBfTxJtR6mlGvuquS4lJrytWP9/xkkF2uZZignyfLcxEFUc1sACUAlF+TPyRaT
        2lxr+lvCc9cTs2ujFuEoazTx1FT4jj06bGuWzEei7//FEFfk2WQttadkUBYLJFAh
        G+qwNgDxyIxmtM2RunYcVcvfAnwyKA1VeggwaJ+VFtMeHmHw4lLnkHNTdjVUvcA=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ukvrp5vmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 18:12:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 075C210004B;
        Mon, 27 Nov 2023 18:12:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EFA2D24B8AF;
        Mon, 27 Nov 2023 18:12:14 +0100 (CET)
Received: from localhost (10.201.20.163) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 27 Nov
 2023 18:12:14 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tee: Use iov_iter to better support shared buffer registration
Date:   Mon, 27 Nov 2023 18:12:07 +0100
Message-ID: <20231127171207.285554-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.163]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to register buffers allocated with vmalloc.
Use iov_iter and associated helper functions to manage the page
registration for all type of memories.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---

update from V1 to V2:
- replace ITER_SOURCE by ITER_DEST flag in tee_shm_register_user_buf(),
- replace IS_ERR_OR NULL(shm) by IS_ERR(shm) in tee_shm_register_user_buf().

V1:
The support of buffer registration allocated with vmalloc is no more
available since c83900393aa1 ("tee: Remove vmalloc page support").

This patch is an alternative to a revert and resulted from a discussion
with Christopher Hellwig [1].

This patch has been tested using xtest tool in optee qemu environment [2]
and using the series related to the remoteproc tee that should be
proposed soon [3].

References:
[1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
[2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#build-instructions
[3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
---
 drivers/tee/tee_shm.c | 72 +++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 673cf0359494..4a24b9942938 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -22,23 +22,13 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
 		put_page(pages[n]);
 }
 
-static int shm_get_kernel_pages(unsigned long start, size_t page_count,
-				struct page **pages)
+static void shm_get_kernel_pages(struct page **pages, size_t page_count)
 {
-	struct page *page;
 	size_t n;
 
-	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
-			 is_kmap_addr((void *)start)))
-		return -EINVAL;
-
-	page = virt_to_page((void *)start);
-	for (n = 0; n < page_count; n++) {
-		pages[n] = page + n;
+	/* iov_iter_extract_kvec_pages does not get reference on the pages, get a pin on them. */
+	for (n = 0; n < page_count; n++)
 		get_page(pages[n]);
-	}
-
-	return page_count;
 }
 
 static void release_registered_pages(struct tee_shm *shm)
@@ -214,13 +204,12 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
 
 static struct tee_shm *
-register_shm_helper(struct tee_context *ctx, unsigned long addr,
-		    size_t length, u32 flags, int id)
+register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags, int id)
 {
 	struct tee_device *teedev = ctx->teedev;
 	struct tee_shm *shm;
-	unsigned long start;
-	size_t num_pages;
+	unsigned long start, addr;
+	size_t num_pages, length, len, off;
 	void *ret;
 	int rc;
 
@@ -245,31 +234,31 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
 	shm->flags = flags;
 	shm->ctx = ctx;
 	shm->id = id;
-	addr = untagged_addr(addr);
+	addr = (unsigned long)iter_iov_addr(iter);
+	length = iter_iov_len(iter);
 	start = rounddown(addr, PAGE_SIZE);
-	shm->offset = addr - start;
-	shm->size = length;
-	num_pages = (roundup(addr + length, PAGE_SIZE) - start) / PAGE_SIZE;
+	num_pages = iov_iter_npages(iter, INT_MAX);
+	if (!num_pages) {
+		ret = ERR_PTR(-ENOMEM);
+		goto err_ctx_put;
+	}
+
 	shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
 	if (!shm->pages) {
 		ret = ERR_PTR(-ENOMEM);
 		goto err_free_shm;
 	}
 
-	if (flags & TEE_SHM_USER_MAPPED)
-		rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
-					 shm->pages);
-	else
-		rc = shm_get_kernel_pages(start, num_pages, shm->pages);
-	if (rc > 0)
-		shm->num_pages = rc;
-	if (rc != num_pages) {
-		if (rc >= 0)
-			rc = -ENOMEM;
-		ret = ERR_PTR(rc);
+	len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0, &off);
+	if (len != length) {
+		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_put_shm_pages;
 	}
 
+	shm->offset = off;
+	shm->size = len;
+	shm->num_pages = num_pages;
+
 	rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
 					     shm->num_pages, start);
 	if (rc) {
@@ -307,6 +296,8 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 	u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
 	struct tee_device *teedev = ctx->teedev;
 	struct tee_shm *shm;
+	struct iovec iov;
+	struct iov_iter iter;
 	void *ret;
 	int id;
 
@@ -319,7 +310,10 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 	if (id < 0)
 		return ERR_PTR(id);
 
-	shm = register_shm_helper(ctx, addr, length, flags, id);
+	iov.iov_base = (void __user *)addr;
+	iov.iov_len = length;
+	iov_iter_init(&iter, ITER_DEST, &iov, 1, length);
+	shm = register_shm_helper(ctx, &iter, flags, id);
 	if (IS_ERR(shm)) {
 		mutex_lock(&teedev->mutex);
 		idr_remove(&teedev->idr, id);
@@ -351,9 +345,19 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length)
 {
+	struct tee_shm *shm;
 	u32 flags = TEE_SHM_DYNAMIC;
+	struct kvec kvec;
+	struct iov_iter iter;
 
-	return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
+	kvec.iov_base = addr;
+	kvec.iov_len = length;
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
+	shm = register_shm_helper(ctx, &iter, flags, -1);
+	if (!IS_ERR(shm))
+		shm_get_kernel_pages(shm->pages, shm->num_pages);
+
+	return shm;
 }
 EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
 
-- 
2.25.1

