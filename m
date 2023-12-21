Return-Path: <linux-kernel+bounces-8111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DB81B247
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEBD288839
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9B3AC25;
	Thu, 21 Dec 2023 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="axiHFoLp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B62CCD5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cd84c5442cso1241407a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703150600; x=1703755400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lCEYEMR3ZdMjHY32Gwj2vmlAOglAWDLVN2PPmHFWNo=;
        b=axiHFoLpP1uLHeHBt18NeiX+NxeOrqpvOQjypTCJ3vbwl5A4kZh1wEnlSS6jCQfLw3
         WEhy8ewogCyZPXuzrrTfcjCNJ2e4MdTqD0cy5b32YIV/6gZpzj3eSfkyQn4xJ61LRa/v
         uA52QVlADhODyDe9VMH3a2nc27W4HQsh8QDh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150600; x=1703755400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lCEYEMR3ZdMjHY32Gwj2vmlAOglAWDLVN2PPmHFWNo=;
        b=VI/QISMJdt8/d4lN3E/ADLh+CqNR7KQI9A4oBaBzOHbf9EuIt3bUhOdy0WmVujgb3h
         IfZT6yXZ51q+Ug9J8KJ1fBA3+EJtT6qNnqQ4zOtLRcA/9hkdaIFZwfBhCqnHUrx052t5
         qNJwK0z6mq+7cg/E/NhTfWxFLHdzLfmQaZyjmqOWzKwevS3nEVYKwiYJRjNvKehL+W0e
         Qv0DAdZT7U3nSKmGE63jsIlAuB2CblqSQAiqdcltRCnqblCwWPbwQm3DzKFXQQWdi/z8
         xN0UPaz8E8PD5o9N6poysS25281wl04Xa8iSWKf+KWAO0HfCrH9EMWsOc3sQIsY1Ns+h
         ylVA==
X-Gm-Message-State: AOJu0YzoHm6V6GLXc5tnbVx7yWcYykibCI+xT7eqNHpnoSI/Lup+/jtA
	elZaWvqkeg9O1d30NE5zxuq5rQ==
X-Google-Smtp-Source: AGHT+IGJaFa3W8ttJ0cxva573B0FW+Tv1L0wT9eD1Gl2S44RAoKQalXdgX9vfptXkKSVuDVY4wht4g==
X-Received: by 2002:a17:90a:fa96:b0:28b:e0cd:64a3 with SMTP id cu22-20020a17090afa9600b0028be0cd64a3mr481792pjb.26.1703150600225;
        Thu, 21 Dec 2023 01:23:20 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:5d8a:fab1:933a:9ae9])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090add8600b00274b035246esm1001915pjv.1.2023.12.21.01.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:23:19 -0800 (PST)
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
Subject: [PATCH v2 1/4] media: mediatek: vcodec: Replace dev_name in error string
Date: Thu, 21 Dec 2023 17:17:43 +0800
Message-ID: <20231221171727.v2.1.I69223f1e438b93fe02f12ab9ef0a26f8c21f6ae7@changeid>
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

mtk_v4l2_err() already uses dev_err(), so don't print the device name
again. Print function name instead.

Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v2:
- rebased on top of next-20231219

 .../media/platform/mediatek/vcodec/common/mtk_vcodec_util.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index 9ce34a3b5ee6..ea8c35c0e667 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -67,7 +67,7 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 	mem->va = dma_alloc_coherent(&plat_dev->dev, size, &mem->dma_addr, GFP_KERNEL);
 	if (!mem->va) {
 		mtk_v4l2_err(plat_dev, "%s dma_alloc size=%ld failed!",
-			     dev_name(&plat_dev->dev), size);
+			     __func__, size);
 		return -ENOMEM;
 	}
 
@@ -99,7 +99,7 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 
 	if (!mem->va) {
 		mtk_v4l2_err(plat_dev, "%s dma_free size=%ld failed!",
-			     dev_name(&plat_dev->dev), size);
+			     __func__, size);
 		return;
 	}
 
-- 
2.43.0.472.g3155946c3a-goog


