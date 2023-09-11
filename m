Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7350C79A15F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjIKCcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjIKCcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:32:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9656CF3;
        Sun, 10 Sep 2023 19:32:10 -0700 (PDT)
X-UUID: 5c982c6c504b11eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=39hq2JQ9Bk1iNY8+HqzlPlrfG4UkI1hzWFrtdQcPBtk=;
        b=B7Tp4T9yld+gJdHBdP0ercG89KYUNLAvSjF4UXgWMi+By/DyC5GAQB2W7gkORtxlGPvVojD5Ixw+6Q5mspcpzV32/P/6SsDIMMfsJzw9X6+uj3sF6X0LB6W5YqsOpFlY2qOtCeRG6G7iqBnMtstS2CpPhTZTzJR2prJrzizJZSs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:87da238f-9593-4e40-8d78-ec5ff6694d2e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:2685c713-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5c982c6c504b11eea33bb35ae8d461a2-20230911
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1891629504; Mon, 11 Sep 2023 10:31:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 10:31:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 10:31:47 +0800
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
        <kuohong.wang@mediatek.com>, Anan Sun <anan.sun@mediatek.com>
Subject: [PATCH 7/9] dma-buf: heaps: mtk_sec_heap: Add dma_ops
Date:   Mon, 11 Sep 2023 10:30:36 +0800
Message-ID: <20230911023038.30649-8-yong.wu@mediatek.com>
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

Add the dma_ops for this secure heap.
a) For secure buffer, cache_ops/mmap are not allowed, thus return
EPERM for them.
b) The secure buffer can't be accessed in kernel, thus it doesn't
have va/dma_address for it. Use the dma_address property to save the
"secure handle".

Signed-off-by: Anan Sun <anan.sun@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/dma-buf/heaps/mtk_secure_heap.c | 116 ++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/dma-buf/heaps/mtk_secure_heap.c b/drivers/dma-buf/heaps/mtk_secure_heap.c
index 14c2a16a7164..daf6cf2121a1 100644
--- a/drivers/dma-buf/heaps/mtk_secure_heap.c
+++ b/drivers/dma-buf/heaps/mtk_secure_heap.c
@@ -9,6 +9,7 @@
 #include <linux/dma-heap.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uuid.h>
@@ -43,6 +44,10 @@ struct mtk_secure_heap {
 	struct tee_context	*tee_ctx;
 };
 
+struct mtk_secure_heap_attachment {
+	struct sg_table		*table;
+};
+
 static int mtk_optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 {
 	return ver->impl_id == TEE_IMPL_ID_OPTEE;
@@ -142,6 +147,116 @@ static void mtk_sec_mem_release(struct mtk_secure_heap *sec_heap,
 				     TZCMD_MEM_SECURECM_UNREF, params);
 }
 
+static int mtk_sec_heap_attach(struct dma_buf *dmabuf, struct dma_buf_attachment *attachment)
+{
+	struct mtk_secure_heap_buffer *sec_buf = dmabuf->priv;
+	struct mtk_secure_heap_attachment *a;
+	struct sg_table *table;
+	int ret = 0;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	table = kzalloc(sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		ret = -ENOMEM;
+		goto err_free_attach;
+	}
+
+	ret = sg_alloc_table(table, 1, GFP_KERNEL);
+	if (ret)
+		goto err_free_sgt;
+	sg_set_page(table->sgl, 0, sec_buf->size, 0);
+
+	a->table = table;
+	attachment->priv = a;
+
+	return 0;
+
+err_free_sgt:
+	kfree(table);
+err_free_attach:
+	kfree(a);
+	return ret;
+}
+
+static void mtk_sec_heap_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attachment)
+{
+	struct mtk_secure_heap_attachment *a = attachment->priv;
+
+	sg_free_table(a->table);
+	kfree(a->table);
+	kfree(a);
+}
+
+static struct sg_table *
+mtk_sec_heap_map_dma_buf(struct dma_buf_attachment *attachment, enum dma_data_direction direction)
+{
+	struct mtk_secure_heap_attachment *a = attachment->priv;
+	struct dma_buf *dmabuf = attachment->dmabuf;
+	struct mtk_secure_heap_buffer *sec_buf = dmabuf->priv;
+	struct sg_table *table = a->table;
+
+	/*
+	 * Technically dma_address refers to the address used by HW, But for secure buffer
+	 * we don't know its dma_address in kernel, Instead, we only know its "secure handle".
+	 * Thus use this property to save the "secure handle", and the user will use it to
+	 * obtain the real address in secure world.
+	 */
+	sg_dma_address(table->sgl) = sec_buf->sec_handle;
+	sg_dma_len(table->sgl) = sec_buf->size;
+
+	return table;
+}
+
+static void
+mtk_sec_heap_unmap_dma_buf(struct dma_buf_attachment *attachment, struct sg_table *table,
+			   enum dma_data_direction direction)
+{
+	struct mtk_secure_heap_attachment *a = attachment->priv;
+
+	WARN_ON(a->table != table);
+	sg_dma_address(table->sgl) = 0;
+}
+
+static int
+mtk_sec_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf, enum dma_data_direction direction)
+{
+	return -EPERM;
+}
+
+static int
+mtk_sec_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf, enum dma_data_direction direction)
+{
+	return -EPERM;
+}
+
+static int mtk_sec_heap_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	return -EPERM;
+}
+
+static void mtk_sec_heap_free(struct dma_buf *dmabuf)
+{
+	struct mtk_secure_heap_buffer *sec_buf = dmabuf->priv;
+	struct mtk_secure_heap *sec_heap = dma_heap_get_drvdata(sec_buf->heap);
+
+	mtk_sec_mem_release(sec_heap, sec_buf);
+	kfree(sec_buf);
+}
+
+static const struct dma_buf_ops mtk_sec_heap_buf_ops = {
+	.attach		= mtk_sec_heap_attach,
+	.detach		= mtk_sec_heap_detach,
+	.map_dma_buf	= mtk_sec_heap_map_dma_buf,
+	.unmap_dma_buf	= mtk_sec_heap_unmap_dma_buf,
+	.begin_cpu_access = mtk_sec_heap_dma_buf_begin_cpu_access,
+	.end_cpu_access	= mtk_sec_heap_dma_buf_end_cpu_access,
+	.mmap		= mtk_sec_heap_dma_buf_mmap,
+	.release	= mtk_sec_heap_free,
+};
+
 static struct dma_buf *
 mtk_sec_heap_allocate(struct dma_heap *heap, size_t size,
 		      unsigned long fd_flags, unsigned long heap_flags)
@@ -173,6 +288,7 @@ mtk_sec_heap_allocate(struct dma_heap *heap, size_t size,
 	if (ret)
 		goto err_free_buf;
 	exp_info.exp_name = dma_heap_get_name(heap);
+	exp_info.ops = &mtk_sec_heap_buf_ops;
 	exp_info.size = sec_buf->size;
 	exp_info.flags = fd_flags;
 	exp_info.priv = sec_buf;
-- 
2.25.1

