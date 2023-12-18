Return-Path: <linux-kernel+bounces-3875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F781748D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B0F1C221DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828123A1C0;
	Mon, 18 Dec 2023 15:00:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6937874;
	Mon, 18 Dec 2023 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.189.58])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 68C108001A7;
	Mon, 18 Dec 2023 23:00:12 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 1/1] arm64: dts: qcom: ipq8074: add MicroSD node
Date: Mon, 18 Dec 2023 23:00:09 +0800
Message-Id: <20231218150009.1227848-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB0dVk1JGBhJHR1PGhpPQ1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkNCVU5DWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
X-HM-Tid: 0a8c7d711708b03akuuu68c108001a7
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ME06Mzo*ATw6QihLAj4LLx81
	FDIaFClVSlVKTEtJQkpKTUpITklNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkNCVU5DWVdZCAFZQUlOTkk3Bg++

Enable MicroSD card found on ipq8074 devices.
Tested fine when SD card IO voltage is 3.3v.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
Changes in v2:
* add dedicated qcom,ipq8074-sdhci compatible

 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index a4f7ae35be27..4f23c4459112 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -422,6 +422,26 @@ sdhc_1: mmc@7824900 {
 			status = "disabled";
 		};
 
+		sdhc_2: mmc@7864900 {
+			compatible = "qcom,ipq8074-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0x7864900 0x500>, <0x7864000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&xo>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
+			max-frequency = <192000000>;
+			bus-width = <4>;
+
+			status = "disabled";
+		};
+
 		blsp_dma: dma-controller@7884000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x07884000 0x2b000>;
-- 
2.25.1


