Return-Path: <linux-kernel+bounces-41119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E34083EC1C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256BA28539A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4931EB4B;
	Sat, 27 Jan 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jhdzCCB6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5131EB27;
	Sat, 27 Jan 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344999; cv=none; b=dSck9VxvdEugNlTIqH0puJiVZzcUnvMA2gr9l34PSPA0H87684Er4AWB8n3mat/dZd5K/+Cnl2ZxOr5sIRnh+0lgbr1x5xmgZVGe6nXW0JmBolVoEP5QtscPstz23SF6qq2a2KYICiy/pqM6rNauXayaL2EWo+Ijt1ZIenQc7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344999; c=relaxed/simple;
	bh=07xcUH8OHSW5OZIQWcfHGaB4HnUsF8P7eoz3RDNWnsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2MECam+2XK0KzDwh9ACjWa67S3fk5uphvTv2xYla5VRZ3dyyNvRiMSf2FXXEFlT9s4tGh7mHnelhz1VDHFdiRTEjyMcVeygfZEdOPQPjQoPDXAJoDPLYd9O/sc1YUUW1Q8cLNpg1uHTYCRVFj660llBNlCJY6jSQ5evdnZD1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jhdzCCB6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706344996;
	bh=07xcUH8OHSW5OZIQWcfHGaB4HnUsF8P7eoz3RDNWnsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhdzCCB6dWkYf16x02RpByVo2pRxTLEDOCzwi5myjAdhAGpb8Hdx064xNB1xHCpAE
	 qRcHRg0SIbFfJkSetykel64k1IMfuQOaRF/NyBhhFK9O/e10ALnA16gcrOuLB7aa3W
	 KQ7t//hZKG3J+uTaBRkZpndTldWCDAujqhmReFzspa4vjblZzoU4cc0wVBDftvB1jo
	 sV84XAFSrJjSH/QXqijL0MMF0z/kkahn1EcFs0rwDG3LooXpphWPuELwPYrW7mAZZH
	 ueHN9badGgAp/h4ySefqCLf9F8vRvrGo8c1aQwud2iOy6Y0CPF7XZsTzrnv6RtwvSu
	 Qlha2JgoLr5lQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 526CD378107C;
	Sat, 27 Jan 2024 08:43:12 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	bin.liu@mediatek.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	matthias.bgg@gmail.com,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Max Staudt <mstaudt@chromium.org>,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
Date: Sat, 27 Jan 2024 10:42:58 +0200
Message-Id: <20240127084258.68302-2-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127084258.68302-1-eugen.hristev@collabora.com>
References: <20240127084258.68302-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Add JPEG encoder node.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Max Staudt <mstaudt@chromium.org>
Tested-by: Max Staudt <mstaudt@chromium.org>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
[eugen.hristev@collabora.com: minor cleanup]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v3:
-none

Changes in v2:
- renamed node
- reordered props

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 37a84d88036a..c93a8b82db76 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -2054,6 +2054,19 @@ venc: video-encoder@17020000 {
 			mediatek,scp = <&scp>;
 		};
 
+		jpgenc: jpeg-encoder@17030000 {
+			compatible = "mediatek,mt8186-jpgenc", "mediatek,mtk-jpgenc";
+			reg = <0 0x17030000 0 0x10000>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vencsys CLK_VENC_CKE2_JPGENC>;
+			clock-names = "jpgenc";
+			iommus = <&iommu_mm IOMMU_PORT_L7_JPGENC_Y_RDMA>,
+				 <&iommu_mm IOMMU_PORT_L7_JPGENC_C_RDMA>,
+				 <&iommu_mm IOMMU_PORT_L7_JPGENC_Q_TABLE>,
+				 <&iommu_mm IOMMU_PORT_L7_JPGENC_BSDMA>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_VENC>;
+		};
+
 		camsys: clock-controller@1a000000 {
 			compatible = "mediatek,mt8186-camsys";
 			reg = <0 0x1a000000 0 0x1000>;
-- 
2.34.1


