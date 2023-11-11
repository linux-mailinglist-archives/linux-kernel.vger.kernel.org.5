Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33737E8A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjKKLRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjKKLQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:16:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B544BF;
        Sat, 11 Nov 2023 03:16:47 -0800 (PST)
X-UUID: ca80bfce808311eea33bb35ae8d461a2-20231111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VE6GZfuzzSGdF7z/E1jtU6vKI/4GFs1fIexqiuUOd+g=;
        b=Aca1ymKXmrmk3qUnJmqsdfHn0820KQjYWuioZavR8cvxjc7poUvrCV0KR7kLA3aE/PwIJhI1nFxj4cFQmvrVJG27Yr2JLUzaKfzI2fd6xeGgVCjsaxZEPtFVX6tDeBT+48Gm1RTyN1lAYDiINS8xBMWC1GviTSy7qcPJUmMKCHY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ecaffbfc-27e8-4d33-b765-a7264e9a70cd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:39174695-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ca80bfce808311eea33bb35ae8d461a2-20231111
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2039734294; Sat, 11 Nov 2023 19:16:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 11 Nov 2023 19:16:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 11 Nov 2023 19:16:39 +0800
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
Subject: [PATCH v2 2/8] dma-buf: heaps: secure_heap: Add private heap ops
Date:   Sat, 11 Nov 2023 19:15:53 +0800
Message-ID: <20231111111559.8218-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231111111559.8218-1-yong.wu@mediatek.com>
References: <20231111111559.8218-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.256700-8.000000
X-TMASE-MatchedRID: PQ2N/OmJeX7YfPOPCpnfAhlckvO1m+Jc2D/7bUIJlF05mHVw4i4YQBMG
        tPkUyFbdIV4u8YKdeKsWHIQM6TbbE40GdWKgGbBh4T0EFRcNxxTEoDEGChh7CQqiCYa6w8tveKL
        mRI5Hi0abuQcHZubU2nATsg8MODVIHxPMjOKY7A8LbigRnpKlKSBuGJWwgxArX1upngn1Gyell7
        LwyCJ0+7K63CMI769Dwsv6gGdF/4S1typ2+c7FWpwJZ1Nrcojum9GQN90avfrr6k+nXg4S3WS1e
        oi1doD5Xy/9ftq4Z/Jpp55fZDlsr34cY/B7JqXaYZ1R7NXn0MdBmmCXcKyFFJ6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.256700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 94200BC56EA00A3F690E907892C59CF2C7B8A2B0F75DB0AA7E49E585E508D63C2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the secure memory, there are two steps:
a) Allocate buffers in kernel side;
b) Secure that buffer.
Different heaps may have different buffer allocation methods and
different memory protection methods. Here abstract the memory
allocation and securing operations.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/dma-buf/heaps/secure_heap.c | 58 ++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/secure_heap.c b/drivers/dma-buf/heaps/secure_heap.c
index a634051a0a67..87ac23072e9e 100644
--- a/drivers/dma-buf/heaps/secure_heap.c
+++ b/drivers/dma-buf/heaps/secure_heap.c
@@ -24,15 +24,66 @@ struct secure_buffer {
 	size_t				size;
 };
 
+struct secure_heap;
+
+struct secure_heap_prv_data {
+	int	(*memory_alloc)(struct secure_heap *sec_heap, struct secure_buffer *sec_buf);
+	void	(*memory_free)(struct secure_heap *sec_heap, struct secure_buffer *sec_buf);
+
+	/* Protect/unprotect the memory */
+	int	(*secure_the_memory)(struct secure_heap *sec_heap, struct secure_buffer *sec_buf);
+	void	(*unsecure_the_memory)(struct secure_heap *sec_heap, struct secure_buffer *sec_buf);
+};
+
 struct secure_heap {
 	const char			*name;
 	const enum secure_memory_type	mem_type;
+
+	const struct secure_heap_prv_data *data;
 };
 
+static int secure_heap_secure_memory_allocate(struct secure_heap *sec_heap,
+					      struct secure_buffer *sec_buf)
+{
+	const struct secure_heap_prv_data *data = sec_heap->data;
+	int ret;
+
+	if (data->memory_alloc) {
+		ret = data->memory_alloc(sec_heap, sec_buf);
+		if (ret)
+			return ret;
+	}
+
+	if (data->secure_the_memory) {
+		ret = data->secure_the_memory(sec_heap, sec_buf);
+		if (ret)
+			goto sec_memory_free;
+	}
+	return 0;
+
+sec_memory_free:
+	if (data->memory_free)
+		data->memory_free(sec_heap, sec_buf);
+	return ret;
+}
+
+static void secure_heap_secure_memory_free(struct secure_heap *sec_heap,
+					   struct secure_buffer *sec_buf)
+{
+	const struct secure_heap_prv_data *data = sec_heap->data;
+
+	if (data->unsecure_the_memory)
+		data->unsecure_the_memory(sec_heap, sec_buf);
+
+	if (data->memory_free)
+		data->memory_free(sec_heap, sec_buf);
+}
+
 static struct dma_buf *
 secure_heap_allocate(struct dma_heap *heap, unsigned long size,
 		     unsigned long fd_flags, unsigned long heap_flags)
 {
+	struct secure_heap *sec_heap = dma_heap_get_drvdata(heap);
 	struct secure_buffer *sec_buf;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct dma_buf *dmabuf;
@@ -45,6 +96,9 @@ secure_heap_allocate(struct dma_heap *heap, unsigned long size,
 	sec_buf->size = ALIGN(size, PAGE_SIZE);
 	sec_buf->heap = heap;
 
+	ret = secure_heap_secure_memory_allocate(sec_heap, sec_buf);
+	if (ret)
+		goto err_free_buf;
 	exp_info.exp_name = dma_heap_get_name(heap);
 	exp_info.size = sec_buf->size;
 	exp_info.flags = fd_flags;
@@ -53,11 +107,13 @@ secure_heap_allocate(struct dma_heap *heap, unsigned long size,
 	dmabuf = dma_buf_export(&exp_info);
 	if (IS_ERR(dmabuf)) {
 		ret = PTR_ERR(dmabuf);
-		goto err_free_buf;
+		goto err_free_sec_mem;
 	}
 
 	return dmabuf;
 
+err_free_sec_mem:
+	secure_heap_secure_memory_free(sec_heap, sec_buf);
 err_free_buf:
 	kfree(sec_buf);
 	return ERR_PTR(ret);
-- 
2.25.1

