Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C180E23C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbjLLCrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345785AbjLLCrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:47:39 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24DF2;
        Mon, 11 Dec 2023 18:47:42 -0800 (PST)
X-UUID: ce307df8989811eeba30773df0976c77-20231212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rtUejzwvIPotNfGLjhuGc1HEgpLh9vDQzrSPNUvf5vQ=;
        b=k0IYPNrbGrJReCD4oJFKlsjFvLywDC4MKkkfkPZXDTNjw/vAz9rwfmaKCzzzU3b8amKK3SCd1lOhAZS1dU7WKc2ns4A71uvc3Fx5eK4KwA9srsigUNJSbDqlJRE6z4FEAwhUH5Lj7Atk5edjAV8u5G2UGoo6NQE7/dGmG9zhFrI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f274b442-b30d-493c-ab24-615bd2ecfd80,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:1d5d10bd-2ac7-4da2-9f94-677a477649d9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ce307df8989811eeba30773df0976c77-20231212
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1455109051; Tue, 12 Dec 2023 10:47:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Dec 2023 10:47:34 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Dec 2023 10:47:33 +0800
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
        <kuohong.wang@mediatek.com>,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Joakim Bech <joakim.bech@linaro.org>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v3 7/7] dma_buf: heaps: secure_heap_mtk: Add a new CMA heap
Date:   Tue, 12 Dec 2023 10:46:07 +0800
Message-ID: <20231212024607.3681-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212024607.3681-1-yong.wu@mediatek.com>
References: <20231212024607.3681-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new MediaTek CMA heap from the CMA reserved buffer.

In this heap, When the first allocating buffer, use cma_alloc to prepare
whole the CMA range, then send its range to TEE to protect and manage.
For the later allocating, we just adds the cma_used_size.

When SVP done, cma_release will release the buffer, then kernel may
reuse it.

For the "CMA" secure heap, "struct cma *cma" is a common property, not just
for MediaTek, so put it into "struct secure_heap" instead of our private
data.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/dma-buf/heaps/Kconfig           |   2 +-
 drivers/dma-buf/heaps/secure_heap.h     |   4 +
 drivers/dma-buf/heaps/secure_heap_mtk.c | 119 +++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index 12962189878e..f117d91a0a9d 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -21,7 +21,7 @@ config DMABUF_HEAPS_SECURE
 
 config DMABUF_HEAPS_SECURE_MTK
 	bool "MediaTek DMA-BUF Secure Heap"
-	depends on DMABUF_HEAPS_SECURE && TEE=y
+	depends on DMABUF_HEAPS_SECURE && DMA_CMA && TEE=y
 	help
 	  Enable secure dma-buf heaps for MediaTek platform. This heap is backed by
 	  TEE client interfaces. If in doubt, say N.
diff --git a/drivers/dma-buf/heaps/secure_heap.h b/drivers/dma-buf/heaps/secure_heap.h
index 374fd276bdd7..9f80edcd3e1f 100644
--- a/drivers/dma-buf/heaps/secure_heap.h
+++ b/drivers/dma-buf/heaps/secure_heap.h
@@ -20,6 +20,10 @@ struct secure_heap {
 
 	const struct secure_heap_ops *ops;
 
+	struct cma		*cma;
+	unsigned long		cma_paddr;
+	unsigned long		cma_size;
+
 	void			*priv_data;
 };
 
diff --git a/drivers/dma-buf/heaps/secure_heap_mtk.c b/drivers/dma-buf/heaps/secure_heap_mtk.c
index 2c6aaeaf469f..58148120f4ed 100644
--- a/drivers/dma-buf/heaps/secure_heap_mtk.c
+++ b/drivers/dma-buf/heaps/secure_heap_mtk.c
@@ -4,9 +4,11 @@
  *
  * Copyright (C) 2023 MediaTek Inc.
  */
+#include <linux/cma.h>
 #include <linux/dma-buf.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uuid.h>
@@ -23,6 +25,13 @@ enum mtk_secure_mem_type {
 	 * management is inside the TEE.
 	 */
 	MTK_SECURE_MEMORY_TYPE_CM_TZ	= 1,
+	/*
+	 * MediaTek dynamic chunk memory carved out from CMA.
+	 * In normal case, the CMA could be used in kernel; When SVP start, we will
+	 * allocate whole this CMA and pass whole the CMA PA and size into TEE to
+	 * protect it, then the detail memory management also is inside the TEE.
+	 */
+	MTK_SECURE_MEMORY_TYPE_CM_CMA	= 2,
 };
 
 enum mtk_secure_buffer_tee_cmd {
@@ -32,6 +41,8 @@ enum mtk_secure_buffer_tee_cmd {
 	 * [in]  value[0].a: The buffer size.
 	 *       value[0].b: alignment.
 	 * [in]  value[1].a: enum mtk_secure_mem_type.
+	 * [in]  value[2].a: pa base in cma case.
+	 *       value[2].b: The buffer size in cma case.
 	 * [out] value[3].a: The secure handle.
 	 */
 	MTK_TZCMD_SECMEM_ZALLOC	= 0x10000, /* MTK TEE Command ID Base */
@@ -52,6 +63,9 @@ struct mtk_secure_heap_data {
 
 	const enum mtk_secure_mem_type mem_type;
 
+	struct page		*cma_page;
+	unsigned long		cma_used_size;
+	struct mutex		lock; /* lock for cma_used_size */
 };
 
 static int mtk_tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
@@ -126,6 +140,10 @@ static int mtk_tee_secure_memory(struct secure_heap *sec_heap, struct secure_buf
 	params[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
 	params[1].u.value.a = data->mem_type;
 	params[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	if (sec_heap->cma && data->mem_type == MTK_SECURE_MEMORY_TYPE_CM_CMA) {
+		params[2].u.value.a = sec_heap->cma_paddr;
+		params[2].u.value.b = sec_heap->cma_size;
+	}
 	params[3].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
 	ret = mtk_tee_service_call(data->tee_ctx, data->tee_session,
 				   MTK_TZCMD_SECMEM_ZALLOC, params);
@@ -162,6 +180,48 @@ static void mtk_secure_memory_free(struct secure_heap *sec_heap, struct secure_b
 {
 }
 
+static int mtk_secure_memory_cma_allocate(struct secure_heap *sec_heap,
+					  struct secure_buffer *sec_buf)
+{
+	struct mtk_secure_heap_data *data = sec_heap->priv_data;
+	int ret = 0;
+	/*
+	 * Allocate CMA only when allocating buffer for the first time, and just
+	 * increase cma_used_size at the other time, Actually the memory
+	 * allocating is within the TEE.
+	 */
+	mutex_lock(&data->lock);
+	if (!data->cma_used_size) {
+		data->cma_page = cma_alloc(sec_heap->cma, sec_heap->cma_size >> PAGE_SHIFT,
+					   get_order(PAGE_SIZE), false);
+		if (!data->cma_page) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+	} else if (data->cma_used_size + sec_buf->size > sec_heap->cma_size) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	data->cma_used_size += sec_buf->size;
+
+out_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static void mtk_secure_memory_cma_free(struct secure_heap *sec_heap,
+				       struct secure_buffer *sec_buf)
+{
+	struct mtk_secure_heap_data *data = sec_heap->priv_data;
+
+	mutex_lock(&data->lock);
+	data->cma_used_size -= sec_buf->size;
+	if (!data->cma_used_size)
+		cma_release(sec_heap->cma, data->cma_page,
+			    sec_heap->cma_size >> PAGE_SHIFT);
+	mutex_unlock(&data->lock);
+}
+
 static int mtk_secure_heap_init(struct secure_heap *sec_heap)
 {
 	struct mtk_secure_heap_data *data = sec_heap->priv_data;
@@ -183,21 +243,76 @@ static struct mtk_secure_heap_data mtk_sec_heap_data = {
 	.mem_type = MTK_SECURE_MEMORY_TYPE_CM_TZ,
 };
 
+static const struct secure_heap_ops mtk_sec_mem_ops_cma = {
+	.heap_init		= mtk_secure_heap_init,
+	.memory_alloc		= mtk_secure_memory_cma_allocate,
+	.memory_free		= mtk_secure_memory_cma_free,
+	.secure_the_memory	= mtk_tee_secure_memory,
+	.unsecure_the_memory	= mtk_tee_unsecure_memory,
+};
+
+static struct mtk_secure_heap_data mtk_sec_heap_data_cma = {
+	.mem_type = MTK_SECURE_MEMORY_TYPE_CM_CMA,
+};
+
 static struct secure_heap mtk_secure_heaps[] = {
 	{
 		.name		= "secure_mtk_cm",
 		.ops		= &mtk_sec_mem_ops,
 		.priv_data	= &mtk_sec_heap_data,
 	},
+	{
+		.name		= "secure_mtk_cma",
+		.ops		= &mtk_sec_mem_ops_cma,
+		.priv_data	= &mtk_sec_heap_data_cma,
+	},
 };
 
+static int __init mtk_secure_cma_init(struct reserved_mem *rmem)
+{
+	struct mtk_secure_heap_data *data;
+	struct secure_heap *sec_heap = mtk_secure_heaps, *sec_heap_cma = NULL;
+	struct cma *sec_cma;
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_secure_heaps); i++, sec_heap++) {
+		data = sec_heap->priv_data;
+		if (data->mem_type == MTK_SECURE_MEMORY_TYPE_CM_CMA) {
+			sec_heap_cma = sec_heap;
+			break;
+		}
+	}
+	if (!sec_heap_cma)
+		return -EINVAL;
+
+	ret = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name,
+				    &sec_cma);
+	if (ret) {
+		pr_err("%s: %s set up CMA fail\n", __func__, rmem->name);
+		return ret;
+	}
+
+	sec_heap_cma->cma = sec_cma;
+	sec_heap_cma->cma_paddr = rmem->base;
+	sec_heap_cma->cma_size = rmem->size;
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(secure_cma, "mediatek,dynamic-secure-region", mtk_secure_cma_init);
+
 static int mtk_sec_heap_init(void)
 {
 	struct secure_heap *sec_heap = mtk_secure_heaps;
+	struct mtk_secure_heap_data *data;
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(mtk_secure_heaps); i++, sec_heap++)
-		secure_heap_add(sec_heap);
+	for (i = 0; i < ARRAY_SIZE(mtk_secure_heaps); i++, sec_heap++) {
+		data = sec_heap->priv_data;
+		if (data->mem_type == MTK_SECURE_MEMORY_TYPE_CM_CMA && !sec_heap->cma)
+			continue;
+		if (!secure_heap_add(sec_heap))
+			mutex_init(&data->lock);
+	}
 	return 0;
 }
 
-- 
2.25.1

