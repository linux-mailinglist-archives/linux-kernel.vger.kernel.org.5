Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA19D80E243
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345749AbjLLCrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbjLLCrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:47:15 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3F1EE;
        Mon, 11 Dec 2023 18:47:20 -0800 (PST)
X-UUID: c26da6ee989811eeba30773df0976c77-20231212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2xDnkMnS/gVeWB6IKVWql10EZCtv+Nhi5DPLdCwJNmk=;
        b=sh2bXTBOzWpdQf/6rG8aWnNLyL3IplnD3RSZhYRyi2HJU07IHOBBLK3WXqIcmUWS848+N/3ekpxdQvgqCi+VTvCIotsh9IDPLZzSSsgfwJpFNwYpAW8hHEjrbwjDOccA9DXR0CxwEnjJ5vUjwKXw8IctwgbrCxPzG0PM4a2UnlE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:27501b68-6419-4ee9-ac3d-7649c1d23de6,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:af87ad73-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c26da6ee989811eeba30773df0976c77-20231212
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1043107234; Tue, 12 Dec 2023 10:47:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Dec 2023 10:47:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Dec 2023 10:47:13 +0800
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
Subject: [PATCH v3 5/7] dma-buf: heaps: secure_heap: Add MediaTek secure heap and heap_init
Date:   Tue, 12 Dec 2023 10:46:05 +0800
Message-ID: <20231212024607.3681-6-yong.wu@mediatek.com>
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

Add a Mediatek secure heap which uses TEE service call to protect
buffer. Currently this secure heap is NULL, Prepare for the later patch.
Mainly there are two changes:
a) Add a heap_init ops since TEE probe late than secure heap, thus
   initialize the heap when we require the buffer the first time.
b) Add a priv_data for each heap, like the special data used by MTK
   (such as "TEE session") can be placed in priv_data.

Currently our heap depends on CMA which could only be bool, thus
depend on "TEE=y".

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/dma-buf/heaps/Kconfig           |   7 ++
 drivers/dma-buf/heaps/Makefile          |   1 +
 drivers/dma-buf/heaps/secure_heap.c     |  11 +++
 drivers/dma-buf/heaps/secure_heap.h     |   4 +
 drivers/dma-buf/heaps/secure_heap_mtk.c | 114 ++++++++++++++++++++++++
 5 files changed, 137 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/secure_heap_mtk.c

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index 3a9943e94200..12962189878e 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -18,3 +18,10 @@ config DMABUF_HEAPS_SECURE
 	depends on DMABUF_HEAPS
 	help
 	  Choose this option to enable dma-buf secure heap. If in doubt, say N.
+
+config DMABUF_HEAPS_SECURE_MTK
+	bool "MediaTek DMA-BUF Secure Heap"
+	depends on DMABUF_HEAPS_SECURE && TEE=y
+	help
+	  Enable secure dma-buf heaps for MediaTek platform. This heap is backed by
+	  TEE client interfaces. If in doubt, say N.
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
index b1ad9d1f2fbe..9751dea345df 100644
--- a/drivers/dma-buf/heaps/Makefile
+++ b/drivers/dma-buf/heaps/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMABUF_HEAPS_SECURE)	+= secure_heap.o
+obj-$(CONFIG_DMABUF_HEAPS_SECURE_MTK)	+= secure_heap_mtk.o
 obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
 obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
diff --git a/drivers/dma-buf/heaps/secure_heap.c b/drivers/dma-buf/heaps/secure_heap.c
index 7cb4db3e55c2..ca4b433fb3f1 100644
--- a/drivers/dma-buf/heaps/secure_heap.c
+++ b/drivers/dma-buf/heaps/secure_heap.c
@@ -150,11 +150,22 @@ secure_heap_allocate(struct dma_heap *heap, unsigned long size,
 		     unsigned long fd_flags, unsigned long heap_flags)
 {
 	struct secure_heap *sec_heap = dma_heap_get_drvdata(heap);
+	const struct secure_heap_ops *ops = sec_heap->ops;
 	struct secure_buffer *sec_buf;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct dma_buf *dmabuf;
 	int ret;
 
+	/*
+	 * In some implements, TEE is required to protect buffer. However TEE probe
+	 * may be late, Thus heap_init is performed when the first buffer is requested.
+	 */
+	if (ops->heap_init) {
+		ret = ops->heap_init(sec_heap);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	sec_buf = kzalloc(sizeof(*sec_buf), GFP_KERNEL);
 	if (!sec_buf)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/dma-buf/heaps/secure_heap.h b/drivers/dma-buf/heaps/secure_heap.h
index ec5349cd28d0..1ce9c431d989 100644
--- a/drivers/dma-buf/heaps/secure_heap.h
+++ b/drivers/dma-buf/heaps/secure_heap.h
@@ -17,9 +17,13 @@ struct secure_heap {
 	const char		*name;
 
 	const struct secure_heap_ops *ops;
+
+	void			*priv_data;
 };
 
 struct secure_heap_ops {
+	int	(*heap_init)(struct secure_heap *sec_heap);
+
 	int	(*memory_alloc)(struct secure_heap *sec_heap, struct secure_buffer *sec_buf);
 	void	(*memory_free)(struct secure_heap *sec_heap, struct secure_buffer *sec_buf);
 
diff --git a/drivers/dma-buf/heaps/secure_heap_mtk.c b/drivers/dma-buf/heaps/secure_heap_mtk.c
new file mode 100644
index 000000000000..c7e609dd7bd3
--- /dev/null
+++ b/drivers/dma-buf/heaps/secure_heap_mtk.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMABUF MediaTek secure heap exporter
+ *
+ * Copyright (C) 2023 MediaTek Inc.
+ */
+#include <linux/dma-buf.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+
+#include "secure_heap.h"
+
+#define TZ_TA_MEM_UUID_MTK		"4477588a-8476-11e2-ad15-e41f1390d676"
+
+#define TEE_PARAM_NUM			4
+
+enum mtk_secure_mem_type {
+	/*
+	 * MediaTek static chunk memory carved out for TrustZone. The memory
+	 * management is inside the TEE.
+	 */
+	MTK_SECURE_MEMORY_TYPE_CM_TZ	= 1,
+};
+
+struct mtk_secure_heap_data {
+	struct tee_context	*tee_ctx;
+	u32			tee_session;
+
+	const enum mtk_secure_mem_type mem_type;
+
+};
+
+static int mtk_tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	return ver->impl_id == TEE_IMPL_ID_OPTEE;
+}
+
+static int mtk_tee_session_init(struct mtk_secure_heap_data *data)
+{
+	struct tee_param t_param[TEE_PARAM_NUM] = {0};
+	struct tee_ioctl_open_session_arg arg = {0};
+	uuid_t ta_mem_uuid;
+	int ret;
+
+	data->tee_ctx = tee_client_open_context(NULL, mtk_tee_ctx_match, NULL, NULL);
+	if (IS_ERR(data->tee_ctx)) {
+		pr_err_once("%s: open context failed, ret=%ld\n", __func__,
+			    PTR_ERR(data->tee_ctx));
+		return -ENODEV;
+	}
+
+	arg.num_params = TEE_PARAM_NUM;
+	arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
+	ret = uuid_parse(TZ_TA_MEM_UUID_MTK, &ta_mem_uuid);
+	if (ret)
+		goto close_context;
+	memcpy(&arg.uuid, &ta_mem_uuid.b, sizeof(ta_mem_uuid));
+
+	ret = tee_client_open_session(data->tee_ctx, &arg, t_param);
+	if (ret < 0 || arg.ret) {
+		pr_err_once("%s: open session failed, ret=%d:%d\n",
+			    __func__, ret, arg.ret);
+		ret = -EINVAL;
+		goto close_context;
+	}
+	data->tee_session = arg.session;
+	return 0;
+
+close_context:
+	tee_client_close_context(data->tee_ctx);
+	return ret;
+}
+
+static int mtk_secure_heap_init(struct secure_heap *sec_heap)
+{
+	struct mtk_secure_heap_data *data = sec_heap->priv_data;
+
+	if (!data->tee_ctx)
+		return mtk_tee_session_init(data);
+	return 0;
+}
+
+static const struct secure_heap_ops mtk_sec_mem_ops = {
+	.heap_init		= mtk_secure_heap_init,
+};
+
+static struct mtk_secure_heap_data mtk_sec_heap_data = {
+	.mem_type = MTK_SECURE_MEMORY_TYPE_CM_TZ,
+};
+
+static struct secure_heap mtk_secure_heaps[] = {
+	{
+		.name		= "secure_mtk_cm",
+		.ops		= &mtk_sec_mem_ops,
+		.priv_data	= &mtk_sec_heap_data,
+	},
+};
+
+static int mtk_sec_heap_init(void)
+{
+	struct secure_heap *sec_heap = mtk_secure_heaps;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_secure_heaps); i++, sec_heap++)
+		secure_heap_add(sec_heap);
+	return 0;
+}
+
+module_init(mtk_sec_heap_init);
+MODULE_DESCRIPTION("MediaTek Secure Heap Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

