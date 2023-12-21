Return-Path: <linux-kernel+bounces-8112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362381B24A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186BE1F251F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ABE41740;
	Thu, 21 Dec 2023 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iE8aT0QJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F640C1E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so237538a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703150603; x=1703755403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZlHGzvCeyHzNr9SWDCy3oc9Vlh9aPeReD6PrS2OHo0=;
        b=iE8aT0QJf95Xjm5HcQeUS1QubIoa57gaRnyRRJYcIaf6kYioB9EuR0DTMJEnxMrJSJ
         XR2+EC1iNmKOFglQGdcWfdCBB/i5lOoo4UDBJSPe1bJeDTs/ztvh2M+hCWWLFJtxlfjM
         RDxoHkiyLwwFqfKuwdkxuvJJg4xfFsPOH4JI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150603; x=1703755403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZlHGzvCeyHzNr9SWDCy3oc9Vlh9aPeReD6PrS2OHo0=;
        b=XK7iO9I+JwGjOVr9XQGa17SpsaTFmv8ITk2f742YMj8+VYIC+rpRJTi9MTbzBWzZH4
         MqOfj4varTfelc6AzNcJngASpQ0zqHKkZPlL+pPaU2hBVu83gdOia+dbXgyDORwbtGuF
         kG0szue6XHdoH32ZwmobNr/MY+yPRj2zKY6/vzZ3hNhOjPM9tItWKS2ici6e+SafzTcO
         RMKNxPOsl8vW85PPzqQnP3blEaDXrOBhjvXcr7mDVP7G5qjvx2uwhqt5aWRGItqBi9Of
         +N9/Wlch/AM/oTGzy8K3npfsGsBMUU5S+wGE4DSkos3+RGF2qkLvIwVZBLuT4vgEaPrO
         lqIw==
X-Gm-Message-State: AOJu0Yyq7yV8OqwaYrMnYp9lndcEytdilro6R5cFiKsX5do0tF5fqTox
	bSUgPBPEYC/HjQScXXf+TNFkaA==
X-Google-Smtp-Source: AGHT+IEZGq7W1pkg/Rs+wEssdN9+RLN+vhyRsmtLnYaT0dUaoqH0eBHPkdGBNx3aVos33wTulXxRXQ==
X-Received: by 2002:a05:6a20:8c84:b0:18f:97c:5ba2 with SMTP id k4-20020a056a208c8400b0018f097c5ba2mr518290pzh.112.1703150603432;
        Thu, 21 Dec 2023 01:23:23 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:5d8a:fab1:933a:9ae9])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090add8600b00274b035246esm1001915pjv.1.2023.12.21.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:23:22 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/4] media: mediatek: vcodec: Drop unnecessary variable
Date: Thu, 21 Dec 2023 17:17:44 +0800
Message-ID: <20231221092226.1395427-2-fshao@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231221092226.1395427-1-fshao@chromium.org>
References: <20231221092226.1395427-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mtk_vcodec_mem_alloc() and mtk_vcodec_mem_free(), the value of
mem->size is not expected to change before and when using the DMA APIs
and debug print, so there's no point in keeping local copies of it.

Drop the local variable "size" in the mentioned functions, and update
printk format identifiers accordingly.

This makes the code slightly more visually consistent, and retrieve a
small amount of memory that is used for no real purpose.

Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v2:
- revise commit message for clearer intention and rationale

 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index ea8c35c0e667..23bea2702c9a 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -49,7 +49,6 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 {
 	enum mtk_instance_type inst_type = *((unsigned int *)priv);
 	struct platform_device *plat_dev;
-	unsigned long size = mem->size;
 	int id;
 
 	if (inst_type == MTK_INST_ENCODER) {
@@ -64,15 +63,15 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 		id = dec_ctx->id;
 	}
 
-	mem->va = dma_alloc_coherent(&plat_dev->dev, size, &mem->dma_addr, GFP_KERNEL);
+	mem->va = dma_alloc_coherent(&plat_dev->dev, mem->size, &mem->dma_addr, GFP_KERNEL);
 	if (!mem->va) {
-		mtk_v4l2_err(plat_dev, "%s dma_alloc size=%ld failed!",
-			     __func__, size);
+		mtk_v4l2_err(plat_dev, "%s dma_alloc size=0x%zx failed!",
+			     __func__, mem->size);
 		return -ENOMEM;
 	}
 
-	mtk_v4l2_debug(plat_dev, 3, "[%d] - va = %p dma = 0x%lx size = 0x%lx", id, mem->va,
-		       (unsigned long)mem->dma_addr, size);
+	mtk_v4l2_debug(plat_dev, 3, "[%d] - va = %p dma = 0x%lx size = 0x%zx", id, mem->va,
+		       (unsigned long)mem->dma_addr, mem->size);
 
 	return 0;
 }
@@ -82,7 +81,6 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 {
 	enum mtk_instance_type inst_type = *((unsigned int *)priv);
 	struct platform_device *plat_dev;
-	unsigned long size = mem->size;
 	int id;
 
 	if (inst_type == MTK_INST_ENCODER) {
@@ -98,15 +96,15 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 	}
 
 	if (!mem->va) {
-		mtk_v4l2_err(plat_dev, "%s dma_free size=%ld failed!",
-			     __func__, size);
+		mtk_v4l2_err(plat_dev, "%s dma_free size=0x%zx failed!",
+			     __func__, mem->size);
 		return;
 	}
 
-	mtk_v4l2_debug(plat_dev, 3, "[%d] - va = %p dma = 0x%lx size = 0x%lx", id, mem->va,
-		       (unsigned long)mem->dma_addr, size);
+	mtk_v4l2_debug(plat_dev, 3, "[%d] - va = %p dma = 0x%lx size = 0x%zx", id, mem->va,
+		       (unsigned long)mem->dma_addr, mem->size);
 
-	dma_free_coherent(&plat_dev->dev, size, mem->va, mem->dma_addr);
+	dma_free_coherent(&plat_dev->dev, mem->size, mem->va, mem->dma_addr);
 	mem->va = NULL;
 	mem->dma_addr = 0;
 	mem->size = 0;
-- 
2.43.0.472.g3155946c3a-goog


