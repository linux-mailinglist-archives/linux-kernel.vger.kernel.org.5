Return-Path: <linux-kernel+bounces-76423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8F85F72D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2CC282955
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2660F4E1AD;
	Thu, 22 Feb 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HnHxeBrR"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE494C615;
	Thu, 22 Feb 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601619; cv=none; b=GC+ik3t2K8vzNDGR3h+pVbwQsly2ieXRMmjXzT0A4r8A851D82rHaX/OhprOZ/yFcSet8AZdi8fR41Ie2riGHsrtQeJoUWENSBaQbOvSsyoKWwvjqRvLSXMWPn8uZm9s1jNQjzjGtqZ5IVMAbPhPAauiGD4QJavpDMncItLtcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601619; c=relaxed/simple;
	bh=NkuknAzJS/tKWohPGjD0ggsJ9LC//lHX1riPoRArDVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=igC8O3SHt+87TMyS7weeOsFpxp/1CqnFvmuVkQEMCkQI5XRxXh1UHc1vL9qQVSgyu3UxhF+8a1KPhFRZomjp9sIhdRIls2s9eDDoADfr3hpAitRQppHVXlIL8Zt0OQIrN0eVnZbnhA++7wqDUdOEp+pi01Ib1looqmwt4DQIQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HnHxeBrR; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXJoU027794;
	Thu, 22 Feb 2024 05:33:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601599;
	bh=hjMUTlmpymMtXih2bSHWH48S62epqs0t4UUSlAQaSfc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=HnHxeBrRL1m60sAWYTmXMZm1gU+wEB5s002vTWa5hj68MRZi38olVoRpFU4VqUwbE
	 nkxDhv5Su5+d4l6TMxDGSooU8LUErYZVN/7T1LqDhBF7in0r+0wfe/YEGDrJeADNP+
	 PSeYSo/0CKOxF7EYDuwE+MFXLQea+ssozng/Bl5A=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXJIa014107
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:19 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:19 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXI4I091205;
	Thu, 22 Feb 2024 05:33:18 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:23 +0530
Subject: [PATCH RFC 07/21] media: ti: j721e-csi2rx: allocate DMA channel
 based on context index
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-7-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=j/FVZDj0NTL0RooVFkoPWVyiLPQWJuy0qgzy23a+DCk=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDgjkgKNhaK9vvGfp6LiC19Sop3UFGjD99R6
 Vw3ghcnJV2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw4AAKCRBD3pH5JJpx
 RcBoEAC8/QUsQHYZ0+ro1rkl3HbyiG2cKH3JNb922sofqqly+8FiQQ1yGD6+QfdxUEY8Brfqd3J
 NQRl88JCwstd6E+F66sTTbFeoTHq5MtflkqdJLLzRr8kDQBhFYx+0+/P5sVqhAZtbJhJb7R4Lxi
 CmKRBz1NjPx5ATtvDK74+dEinWCx1Z9A6/YwnHF9dMdTTTlRtUIehaSVUZMCoFYfsXcw8vNEIw1
 yiC9gIXVtyJHH/EUKFLxWKGSubCqlQJMG264SLVMSimMofCIPt808tbijPrMKWUlqwU0pegbzj+
 UrNdR+rZl7yO4f/LX4GUxOLn3SyJY9vpFiIGiI6Vvxr6OXjdYoz2RSRpPnftQ1huIgrbtuU3qUD
 lH50g8AEzsC0iIkp9oPbTs2bg3mbo15/YDk8mmS79yN1ilWRmmq3fXs18fCFe1UNQkCByoxvdUG
 IQpAluicWKsyE8NmPBB2nmMCrQIMPF+7zLQLBm25dsAbtEddTzsAy/Bq8W/KgbTHHM+qy9HLmye
 UTqJaN/kuzLanNpFLYgi/cpzUT2oEIm3FLtr+myh6wDSf4MxPvrNite13goNMCN9UzcBwgbejnw
 XYKG9LPfDO6EEooK3vNXqCTRlcgBxJL5TB5+mW6xDOvgHx9HHNPyyPc0QdFN1XePE20/vssjC7K
 onTcapLpySzFOiA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Pratyush Yadav <p.yadav@ti.com>

With multiple contexts, there needs to be a different DMA channel for
each context. Earlier, the DMA channel name was hard coded to "rx0" for
the sake of simplicity. Generate the DMA channel name based on its index
and get the channel corresponding to the context.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index e42941d8c457..80d7066100bf 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -1051,6 +1051,7 @@ static int ti_csi2rx_init_dma(struct ti_csi2rx_ctx *ctx)
 	struct dma_slave_config cfg = {
 		.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES,
 	};
+	char name[32];
 	int ret;
 
 	INIT_LIST_HEAD(&ctx->dma.queue);
@@ -1059,7 +1060,8 @@ static int ti_csi2rx_init_dma(struct ti_csi2rx_ctx *ctx)
 
 	ctx->dma.state = TI_CSI2RX_DMA_STOPPED;
 
-	ctx->dma.chan = dma_request_chan(ctx->csi->dev, "rx0");
+	snprintf(name, sizeof(name), "rx%u", ctx->idx);
+	ctx->dma.chan = dma_request_chan(ctx->csi->dev, name);
 	if (IS_ERR(ctx->dma.chan))
 		return PTR_ERR(ctx->dma.chan);
 

-- 
2.43.0


