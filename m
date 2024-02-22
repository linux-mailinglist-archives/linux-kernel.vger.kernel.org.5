Return-Path: <linux-kernel+bounces-76804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073F85FCD7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E691F2762C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D4155A5C;
	Thu, 22 Feb 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9h3a/Eg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E79156966;
	Thu, 22 Feb 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616511; cv=none; b=W7WYvRkYCalw2BlSROBhFS7YP8i82aNDwPLwQrXSGNAoTRsp36Rw7BpIiS3l5YX+YHehLm6kO4PwhKUbjVE6TJoCtEze6uuc9mOWck5Gs3R2MhAHkNpzldxD++HLykmSrBGFhaTZg9Fkgda/Isn/BLpRdpfK+skKKAWM/j6IyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616511; c=relaxed/simple;
	bh=9avcaQo+g1SO3OnMBO0SW08LTKb5Q/Pc21HFm51gndM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GhskCZVaa56Zz74Q0RcvxuroO9dPbkEtMgL0r32kyY+JHGOtyqcKHoG/tWBfYSHTW5q+dI1zbzbC9saNBQTXG3ctf+lj3pH/zY4U4wR4KKG0TRNvna3/hElcjM/0030v9fBw+zqqy6S3n7ETCDVgs2mVBDE7xT/qclmXfB3N6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9h3a/Eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D17C433A6;
	Thu, 22 Feb 2024 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616511;
	bh=9avcaQo+g1SO3OnMBO0SW08LTKb5Q/Pc21HFm51gndM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9h3a/EgFD0efBdf9svW4VSrGmDb6rsd2zPtk3U/b2zo/X5iMDU8AfEEL2k0d9tGW
	 Yyh37Kn8PPwqqS7Aseq8cxgUFfX7wQtEJOLjs0B8MAiQ5LNayOfTCeWgdUndvS7IdT
	 hvOR274o+TGEjGTKzdy/5EuYnO26HTEcMV1C0uvzAEZYinyEesdVnBtZ7LLclZeYSo
	 apxaQmIxZvulopyzfm/b3aYiSP7p6hvXwVclkGiwOcwQIBS4O/c1ADziRgE4nD8cn0
	 nU8xAHIhys2JpoCwhGzc7wEBdc41y3GgISPPlwxN+eqxQwzUV+qnowsbht3Uw3SX7U
	 erKvjaBM/Ad0Q==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Moudy Ho <moudy.ho@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 07/12] soc: mediatek: cmdq: Refine cmdq_pkt_create() and cmdq_pkt_destroy()
Date: Thu, 22 Feb 2024 15:41:15 +0000
Message-Id: <20240222154120.16959-8-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222154120.16959-1-chunkuang.hu@kernel.org>
References: <20240222154120.16959-1-chunkuang.hu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmdq_pkt_create() and cmdq_pkt_destroy() is not suitable for
client drivers so each client driver has implement its own
function. This refinement would pass struct cmdq_pkt pointer into
cmdq_pkt_create(). In addition, client driver has the struct
cmdq_client information, so it's not necessary to store this
information in struct cmdq_pkt. After this refinement, client
drivers could use these helper funciton instead of implementing
its own version.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 24 +++++++-----------------
 include/linux/soc/mediatek/mtk-cmdq.h  | 14 ++++++++------
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index bbe41302210a..1a1f1b260a06 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -106,22 +106,16 @@ void cmdq_mbox_destroy(struct cmdq_client *client)
 }
 EXPORT_SYMBOL(cmdq_mbox_destroy);
 
-struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
+int cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt, size_t size)
 {
-	struct cmdq_pkt *pkt;
 	struct device *dev;
 	dma_addr_t dma_addr;
 
-	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
-		return ERR_PTR(-ENOMEM);
 	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base) {
-		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!pkt->va_base)
+		return -ENOMEM;
+
 	pkt->buf_size = size;
-	pkt->cl = (void *)client;
 
 	dev = client->chan->mbox->dev;
 	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
@@ -129,24 +123,20 @@ struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
 	if (dma_mapping_error(dev, dma_addr)) {
 		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
 		kfree(pkt->va_base);
-		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
 	pkt->pa_base = dma_addr;
 
-	return pkt;
+	return 0;
 }
 EXPORT_SYMBOL(cmdq_pkt_create);
 
-void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
+void cmdq_pkt_destroy(struct cmdq_client *client, struct cmdq_pkt *pkt)
 {
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
 	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
 			 DMA_TO_DEVICE);
 	kfree(pkt->va_base);
-	kfree(pkt);
 }
 EXPORT_SYMBOL(cmdq_pkt_destroy);
 
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index f82e789550ae..d9d0ee5ecb7a 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -62,17 +62,19 @@ void cmdq_mbox_destroy(struct cmdq_client *client);
 /**
  * cmdq_pkt_create() - create a CMDQ packet
  * @client:	the CMDQ mailbox client
+ * @pkt:	the CMDQ packet
  * @size:	required CMDQ buffer size
  *
- * Return: CMDQ packet pointer
+ * Return: 0 for success; else the error code is returned
  */
-struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size);
+int cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt, size_t size);
 
 /**
  * cmdq_pkt_destroy() - destroy the CMDQ packet
+ * @client:	the CMDQ mailbox client
  * @pkt:	the CMDQ packet
  */
-void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
+void cmdq_pkt_destroy(struct cmdq_client *client, struct cmdq_pkt *pkt);
 
 /**
  * cmdq_pkt_write() - append write command to the CMDQ packet
@@ -312,12 +314,12 @@ static inline struct cmdq_client *cmdq_mbox_create(struct device *dev, int index
 
 static inline void cmdq_mbox_destroy(struct cmdq_client *client) { }
 
-static inline  struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
+static inline int cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt, size_t size)
 {
-	return ERR_PTR(-EINVAL);
+	return -EINVAL;
 }
 
-static inline void cmdq_pkt_destroy(struct cmdq_pkt *pkt) { }
+static inline void cmdq_pkt_destroy(struct cmdq_client *client, struct cmdq_pkt *pkt) { }
 
 static inline int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
 {
-- 
2.34.1


