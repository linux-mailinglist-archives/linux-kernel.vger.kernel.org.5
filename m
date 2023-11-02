Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2727DEF0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjKBJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbjKBJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:38:06 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46DE123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:38:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SLdkQ4QT7z9y19H;
        Thu,  2 Nov 2023 17:24:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.131.78])
        by APP2 (Coremail) with SMTP id GxC2BwDnibXJbUNl0QNYAw--.58857S3;
        Thu, 02 Nov 2023 10:37:38 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list), patchwork@huawei.com
Cc:     Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Petr Tesarik <petrtesarik@huaweicloud.com>,
        miaoxie@huawei.com, weiyongjun1@huawei.com, guohanjun@huawei.com,
        huawei.libin@huawei.com, yuehaibing@huawei.com,
        johnny.chenyi@huawei.com, leijitang@huawei.com, ming.fu@huawei.com,
        zhujianwei7@huawei.com, linuxarm@huawei.com,
        stable@vger.kernel.org, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 1/1] swiotlb: do not free decrypted pages if dynamic
Date:   Thu,  2 Nov 2023 10:36:49 +0100
Message-Id: <20231102071821.431-2-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071821.431-1-petrtesarik@huaweicloud.com>
References: <20231102071821.431-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnibXJbUNl0QNYAw--.58857S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1xAw1Uury3ur47tw15CFg_yoW5CF1xpF
        4fCr1Sgr98tFy7CrWfAF4kCF9xGws5urWUCFW3Xw1rZwn8WryIkr9rCw18uayfJF4kua17
        JrW0v3WayrsrZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
        vjDU0xZFpf9x0JU7pnQUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix these two error paths:

1. When set_memory_decrypted() fails, pages may be left fully or partially
   decrypted.

2. Decrypted pages may be freed if swiotlb_alloc_tlb() determines that the
   physical address is too high.

To fix the first issue, call set_memory_encrypted() on the allocated region
after a failed decryption attempt. If that also fails, leak the pages.

To fix the second issue, check that the TLB physical address is below the
requested limit before decrypting.

Let the caller differentiate between unsuitable physical address (=> retry
from a lower zone) and allocation failures (=> no point in retrying).

Cc: stable@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/dma/swiotlb.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dff067bd56b1..0e1632f75421 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -558,29 +558,40 @@ void __init swiotlb_exit(void)
  * alloc_dma_pages() - allocate pages to be used for DMA
  * @gfp:	GFP flags for the allocation.
  * @bytes:	Size of the buffer.
+ * @phys_limit:	Maximum allowed physical address of the buffer.
  *
  * Allocate pages from the buddy allocator. If successful, make the allocated
  * pages decrypted that they can be used for DMA.
  *
- * Return: Decrypted pages, or %NULL on failure.
+ * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EAGAIN)
+ * if the allocated physical address was above @phys_limit.
  */
-static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes)
+static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
 {
 	unsigned int order = get_order(bytes);
 	struct page *page;
+	phys_addr_t paddr;
 	void *vaddr;
 
 	page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
 
-	vaddr = page_address(page);
+	paddr = page_to_phys(page);
+	if (paddr + bytes - 1 > phys_limit) {
+		__free_pages(page, order);
+		return ERR_PTR(-EAGAIN);
+	}
+
+	vaddr = phys_to_virt(paddr);
 	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		goto error;
 	return page;
 
 error:
-	__free_pages(page, order);
+	/* Intentional leak if pages cannot be encrypted again. */
+	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
+		__free_pages(page, order);
 	return NULL;
 }
 
@@ -618,11 +629,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
 
-	while ((page = alloc_dma_pages(gfp, bytes)) &&
-	       page_to_phys(page) + bytes - 1 > phys_limit) {
-		/* allocated, but too high */
-		__free_pages(page, get_order(bytes));
-
+	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
 		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
-- 
2.34.1

