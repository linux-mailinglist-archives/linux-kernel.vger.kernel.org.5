Return-Path: <linux-kernel+bounces-76433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B085F74C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2286C282231
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C956768;
	Thu, 22 Feb 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kMqR/1EM"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395F5646A;
	Thu, 22 Feb 2024 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601638; cv=none; b=mi1Ve1womNP0/LtDzgpY36zaFLUNCIIYNpkttnSxTxLSgYAJ4HqqaqimsJCGbFpI/gAezr4pDlEuGzy2GR2DbXixu0sqhvym8uRtSBxQuNuLlXcBP4YIPNxUK/6ovL48pXCmrjXf96KBP0HLsqlC0V/YTowPwQG2TRncRKypm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601638; c=relaxed/simple;
	bh=UHhcmDEpCe+fIBZF6t/hU6vqn9E2M2zqDvurAxx6H4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZcutceKj2MWJSVaO8An4H6IykPmEZbK5yDFsAjWYN8TBh++qO7D2+yS91TFoHgwU9WocHpV70J+NILSeXEA23VQtjipdGUh+VyQGw9tzjDZ/8ihvpdw43keKmcd4mHcJP+zZtP1DZk2MKvrVS9WLHgJFw/Qp0BME4KgxVhHcAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kMqR/1EM; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXif6027847;
	Thu, 22 Feb 2024 05:33:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601624;
	bh=h4Cf3SOkx3K5Auy7bEc25EsHCsaRMY7o1BWV1atNTG4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=kMqR/1EMKXtPJF73iXF9EFR+Y8migT5oWQly0ShGGHk1tNyazg2dN9pf3i90iyyyq
	 MlNY9Nxjw8/m/6Nfw8hCpWTvBVNgdY1Dzl43o5c2/Q4ASpnH9U7E3wUdrkOPm4+hJE
	 +8Vp404BBqusysKBxjmaXPvmjJI0syFNGZby7PWU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXiVH014442
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:44 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:44 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXhGP091587;
	Thu, 22 Feb 2024 05:33:43 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:36 +0530
Subject: [PATCH RFC 20/21] SQUASH: media: ti: j721e-csi2rx: Assert pixel
 reset before stopping last stream
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-20-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=UHhcmDEpCe+fIBZF6t/hU6vqn9E2M2zqDvurAxx6H4c=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDtxulJ5vwh1hk7rUtv04y9hAoMjlAfOaM/I
 946Exq1leuJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw7QAKCRBD3pH5JJpx
 RXT2EADGCihGFKE4jnCo389SggQfrAJRxINhD00hY+I8PSgr5Q8Dphg/C/Wjb8E0bPcqoebJLhs
 EWC+WB2CDiGO/GxMyeZiMxOHqVWOJeRXDEBaZzkaOzu0wCg8tb31WopXSrBvz9e7IcsTM6ilVSV
 mp7hlpiXzCofr/F/lAY3TWkKzkzgF3Ix8j6lZiO9l4JiMzduDQT4FlRcP1sV3Ay+mq5gxsbJnjQ
 fSpo9m3cO+YgY9p4+qhhekjagSAD/NG4QZ6TTdeYCnC0CBgb/6qRaznGv0EEIhilw6MCpkqGgME
 m/oBtaHC+lEViiolUOvsTOjv4Pm5aKRNhUC7YMMyET0H00qy8lSBbnd5bvib4W6icXUJd0Lz2TX
 Vlo/d0mx7s68KFtd+0E3uN77ni1AyR+uBZzW3qTZOq2Hf4pt/s9RBKG2DS59+cI0kMHmThgbUZZ
 T7iRcIKMgAHoA38iBktZToF+UC8VmAN6pqY9qVcQWLtGVNWz0BI24ZtuVkCL2DjEzpRcNY38jmn
 l1Xp0bhXL0dEwm3RwfvQbWYxYINVSalySZt4zFTmy0eVw6kNaly2Xfdw3FF3H6GVUJ3adN8hp17
 9iFu2Z1XJgwv2Vr6xwCxqOa5T5LbU8Q37F79vnGJ/rztw/v8PbUycns2T8lQiYQm9HUYqjsjqje
 eMNosTG92fZifng==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

With multi-stream support, make sure pixel reset is only asserted when
last-stream is stopped.

We assert this before stopping the stream to prevent issues with module
unload/reload. As the device's power domain cannot be cleanly switched
off by the firmware if stale data is present on the PSI-L endpoint,
which can happen if source was streaming but we pulling data out through
DMA.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index c2d47507b3a7..0b9e0852da9f 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -560,8 +560,10 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 	fmt = find_format_by_fourcc(ctx->v_fmt.fmt.pix.pixelformat);
 
 	/* De-assert the pixel interface reset. */
-	reg = SHIM_CNTL_PIX_RST;
-	writel(reg, csi->shim + SHIM_CNTL);
+	if (!csi->enable_count) {
+		reg = SHIM_CNTL_PIX_RST;
+		writel(reg, csi->shim + SHIM_CNTL);
+	}
 
 	reg = SHIM_DMACNTX_EN;
 	reg |= FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
@@ -1008,9 +1010,11 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 	struct ti_csi2rx_dev *csi = ctx->csi;
 	int ret;
 
-	video_device_pipeline_stop(&ctx->vdev);
+	/* assert pixel reset to prevent stale data on stopping last stream */
+	if (csi->enable_count == 1)
+		writel(0, csi->shim + SHIM_CNTL);
 
-	writel(0, csi->shim + SHIM_CNTL);
+	video_device_pipeline_stop(&ctx->vdev);
 	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 
 	ret = v4l2_subdev_disable_streams(&csi->subdev,

-- 
2.43.0


