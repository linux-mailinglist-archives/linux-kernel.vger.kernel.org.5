Return-Path: <linux-kernel+bounces-76422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC085F72C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9884E1F24AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240584E1A8;
	Thu, 22 Feb 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mLQk3L5p"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5D9482E2;
	Thu, 22 Feb 2024 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601618; cv=none; b=SKBUQBhYQv+JNH4Q3w//gIXs8WNY+P4xm4+Ll++1o+En1HpPysW/EQ+6+xhVrcuRJKEN/Y9VOzxbsbuYEHyF1I70oxOCN0plSbCtCrLw1LWaspZfHJ/q9lemy634czk7uPK86D/6YU1aEpG2E/XPbaaptmPVZOQrWq33gSRJBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601618; c=relaxed/simple;
	bh=i3XZLUwa1rEf80HvLKRoXBv74vvKRzQwjCodPjjVeY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cZSp6MZhw/j1gYwzeOZ6wfr8cCvVVFdpp+w8/Yfxx7yVVrxEHRhNbzwD/PYxVGIT75j/9Tw0Po2M5sOYcD3VHlIWn/Zl7fJDSRpW5fXW2Y/6orxlw2EIW64psacXTu22PCVOUlN/14VJVjsDgOBaFtCPjAcXQNU829LeLUroEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mLQk3L5p; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXHdu027789;
	Thu, 22 Feb 2024 05:33:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601597;
	bh=vgG8Pl1M4grO/Gh8T9ZEbDeHXu7+7KB9qSq+V1q4TSs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=mLQk3L5pPmt8OmZI+1d8AexppK3hHYKcbLchap9zrDNL5jYwX0FMmUfbW6Dv8AXBL
	 CrvLzMpSRd0JRhTeU2NvscwZYcC+OZh7bTcXk94kWEtx4gfIT8pmks2+aE/jecZAw7
	 D5JO6Vmt4oQ/aQ0tpuqhqfC5+9z3iBcx1KZcbr50=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXH7V014080
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:17 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:17 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXGTi091164;
	Thu, 22 Feb 2024 05:33:17 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:22 +0530
Subject: [PATCH RFC 06/21] media: ti: j721e-csi2rx: prepare SHIM code for
 multiple contexts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-6-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=hRPOamfPuHrERb/eWqzY/9jpUuBkempbM1uAnmFujKs=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDfNYkMPiKCTC2JPadipH7bxiCc5pmmNv4vj
 vnxTvztoxOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw3wAKCRBD3pH5JJpx
 RRpsD/4wwJTyJYUjpaEjB/52IwpCWMs9edpqHg/ZBPFc/d1o/+MmQ/Kc9mymRzwh8fHOBBi5KXL
 Ah3zSbvx1c1kV5k1gVfRNFIALl/Ldw7U4BwCDK1r44FW1cAuqBm016GDCrlKwP6ZXrUmyg7DrHM
 EG8cwJIGHdMDk8Ejc2PumjM9RRJdUl0tXWeVP1Ro3lheDS5hpxrlhcTAPiRFQ+OiMwwWnNoDElI
 vXdbk1JeIl3Zm+wULZ66BNumLPV/4T78SN8ptEhYFM4/TOpcxw2HxOKveP1ZaDUPAYRBiSB8wlI
 3KpoDpycMhZ8pnnlL1K4TG3ao1zDZG/RMmxySFkg7nvKlSeVOo3QKUol1wPcwmKJZBChL90tcQF
 QvdbJ+KDgC0gy4+OPNwBzirADwWvadUyDTbZlLi7AYaKVwFlpRY0ozkls60YsGG8Kh7Bp89nSRR
 HSizx33PukEbZuus9QQiQyLe99iRXMs+LR1W5d0klLpvxZf5WYFOHXSRyfnmcLeWJptzTROduAp
 oHEiFu4HAZzJMUuTsgViHbertPncOl3/trD3qBbmDft7wz3Jb4yBq9+qiAi3YMjNBAGr+HdTAbG
 ZwdhVHFyG52Ja5D/Cz9PdZ/lHRDPVwvirtaXR5q9Se161cPHm/yoCrbbPC5VB63NXG1yEvkc0CI
 YsM2Y3nnK00wrog==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Pratyush Yadav <p.yadav@ti.com>

Currently the SHIM code to configure the context only touches the first
context. Add support for writing to the context's registers based on the
context index.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 51fac664d01c..e42941d8c457 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -25,7 +25,7 @@
 #define SHIM_CNTL			0x10
 #define SHIM_CNTL_PIX_RST		BIT(0)
 
-#define SHIM_DMACNTX			0x20
+#define SHIM_DMACNTX(i)			(0x20 + ((i) * 0x20))
 #define SHIM_DMACNTX_EN			BIT(31)
 #define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
 #define SHIM_DMACNTX_SIZE		GENMASK(21, 20)
@@ -35,7 +35,7 @@
 #define SHIM_DMACNTX_SIZE_16		1
 #define SHIM_DMACNTX_SIZE_32		2
 
-#define SHIM_PSI_CFG0			0x24
+#define SHIM_PSI_CFG0(i)		(0x24 + ((i) * 0x20))
 #define SHIM_PSI_CFG0_SRC_TAG		GENMASK(15, 0)
 #define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 16)
 
@@ -573,11 +573,11 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 
 	reg |= FIELD_PREP(SHIM_DMACNTX_SIZE, fmt->size);
 
-	writel(reg, csi->shim + SHIM_DMACNTX);
+	writel(reg, csi->shim + SHIM_DMACNTX(ctx->idx));
 
 	reg = FIELD_PREP(SHIM_PSI_CFG0_SRC_TAG, 0) |
 	      FIELD_PREP(SHIM_PSI_CFG0_DST_TAG, 0);
-	writel(reg, csi->shim + SHIM_PSI_CFG0);
+	writel(reg, csi->shim + SHIM_PSI_CFG0(ctx->idx));
 }
 
 static void ti_csi2rx_drain_callback(void *param)
@@ -894,7 +894,7 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 err_pipeline:
 	video_device_pipeline_stop(&ctx->vdev);
 	writel(0, csi->shim + SHIM_CNTL);
-	writel(0, csi->shim + SHIM_DMACNTX);
+	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 err:
 	ti_csi2rx_cleanup_buffers(ctx, VB2_BUF_STATE_QUEUED);
 	return ret;
@@ -909,7 +909,7 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 	video_device_pipeline_stop(&ctx->vdev);
 
 	writel(0, csi->shim + SHIM_CNTL);
-	writel(0, csi->shim + SHIM_DMACNTX);
+	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 
 	ret = v4l2_subdev_call(csi->source, video, s_stream, 0);
 	if (ret)

-- 
2.43.0


