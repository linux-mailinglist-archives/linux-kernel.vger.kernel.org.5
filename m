Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99C079A149
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjIKCbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjIKCbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:31:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECAA99;
        Sun, 10 Sep 2023 19:31:12 -0700 (PDT)
X-UUID: 42308770504b11eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BgusHZ5iW8qsY1ISxY9XJ19nbcqQfcdSh3y1ra4UH+c=;
        b=e1gMw0NKv2pj+pAcnSmgK6Ea68DMXYS/H75uuqluh9DuMkUReE5Zzo0k6fSOacK1QD4Q9atUftRbgI1lj53HI5utE2c1zcLtK73xc25a73iDe0PSJ34Of8bYFpDtEVuQBuyjuxiuDF0iREnzhH8sptDeHoCzRqxvYcy4xZFiupc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:c95da081-a2c7-4f55-9d2a-f3ff58936217,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:7482c713-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 42308770504b11eea33bb35ae8d461a2-20230911
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1711932841; Mon, 11 Sep 2023 10:31:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 10:31:04 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 10:31:03 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, <tjmercier@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jianjiao.zeng@mediatek.com>,
        <kuohong.wang@mediatek.com>
Subject: [PATCH 2/9] dma-heap: Add proper kref handling on dma-buf heaps
Date:   Mon, 11 Sep 2023 10:30:31 +0800
Message-ID: <20230911023038.30649-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911023038.30649-1-yong.wu@mediatek.com>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <jstultz@google.com>

Add proper refcounting on the dma_heap structure.
While existing heaps are built-in, we may eventually
have heaps loaded from modules, and we'll need to be
able to properly handle the references to the heaps

Also moves minor tracking into the heap structure so
we can properly free things.

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[Yong: Just add comment for "minor" and "refcount"]
---
 drivers/dma-buf/dma-heap.c | 38 ++++++++++++++++++++++++++++++++++----
 include/linux/dma-heap.h   |  6 ++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 51030f6c9d6e..dcc0e38c61fa 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -11,6 +11,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
 #include <linux/err.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
@@ -30,6 +31,8 @@
  * @heap_devt:		heap device node
  * @list:		list head connecting to list of heaps
  * @heap_cdev:		heap char device
+ * @minor:		heap device node minor number
+ * @refcount:		reference counter for this heap device
  *
  * Represents a heap of memory from which buffers can be made.
  */
@@ -40,6 +43,8 @@ struct dma_heap {
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
+	int minor;
+	struct kref refcount;
 };
 
 static LIST_HEAD(heap_list);
@@ -205,7 +210,6 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
 	struct dma_heap *heap, *h, *err_ret;
 	struct device *dev_ret;
-	unsigned int minor;
 	int ret;
 
 	if (!exp_info->name || !strcmp(exp_info->name, "")) {
@@ -222,12 +226,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	if (!heap)
 		return ERR_PTR(-ENOMEM);
 
+	kref_init(&heap->refcount);
 	heap->name = exp_info->name;
 	heap->ops = exp_info->ops;
 	heap->priv = exp_info->priv;
 
 	/* Find unused minor number */
-	ret = xa_alloc(&dma_heap_minors, &minor, heap,
+	ret = xa_alloc(&dma_heap_minors, &heap->minor, heap,
 		       XA_LIMIT(0, NUM_HEAP_MINORS - 1), GFP_KERNEL);
 	if (ret < 0) {
 		pr_err("dma_heap: Unable to get minor number for heap\n");
@@ -236,7 +241,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	}
 
 	/* Create device */
-	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), minor);
+	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
 
 	cdev_init(&heap->heap_cdev, &dma_heap_fops);
 	ret = cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
@@ -280,12 +285,37 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 err2:
 	cdev_del(&heap->heap_cdev);
 err1:
-	xa_erase(&dma_heap_minors, minor);
+	xa_erase(&dma_heap_minors, heap->minor);
 err0:
 	kfree(heap);
 	return err_ret;
 }
 
+static void dma_heap_release(struct kref *ref)
+{
+	struct dma_heap *heap = container_of(ref, struct dma_heap, refcount);
+
+	/* Note, we already holding the heap_list_lock here */
+	list_del(&heap->list);
+
+	device_destroy(dma_heap_class, heap->heap_devt);
+	cdev_del(&heap->heap_cdev);
+	xa_erase(&dma_heap_minors, heap->minor);
+
+	kfree(heap);
+}
+
+void dma_heap_put(struct dma_heap *h)
+{
+	/*
+	 * Take the heap_list_lock now to avoid racing with code
+	 * scanning the list and then taking a kref.
+	 */
+	mutex_lock(&heap_list_lock);
+	kref_put(&h->refcount, dma_heap_release);
+	mutex_unlock(&heap_list_lock);
+}
+
 static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index c7c29b724ad6..f3c678892c5c 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -64,4 +64,10 @@ const char *dma_heap_get_name(struct dma_heap *heap);
  */
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info);
 
+/**
+ * dma_heap_put - drops a reference to a dmabuf heap, potentially freeing it
+ * @heap: the heap whose reference count to decrement
+ */
+void dma_heap_put(struct dma_heap *heap);
+
 #endif /* _DMA_HEAPS_H */
-- 
2.25.1

