Return-Path: <linux-kernel+bounces-167829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720458BAFF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FFFB21F90
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D08153BDE;
	Fri,  3 May 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVcFcUUe"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B326AF5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750488; cv=none; b=axcYz064YtDzingTuXrYe3N7oylPz5WyCFIJQOkUotOrUT/FCkq/DVBQJHyvCEFUMU6UhO/ciS/0i9ZYf28PbplX2yeg2j8V4DV5PZyO7l2xIsaRg4KUdC+wwWxlAR1yH2wh37y6INFn+L78KjoONCTvMZ+v3KSXVB8+dZgcVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750488; c=relaxed/simple;
	bh=/xSlG3SNs8+ppWCTbOL5BO1qKtZj2vhrm9qb8I7TPYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8o82w3TZWnpjt25DEiqdW0EMhd9Oz0hV+qSNsGOAfdC09BMJy3KpgO0A9MWaPj0nYBFfJCJvh/mJAJwuVghbI3yHkxzctBWHzGPy0k4T1rVozOeL4FBtvsWDs3/Sphud/TUmBNezC0M1dqrERG+ogsc0sN/Lde9DP9VzMZ8f4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YVcFcUUe; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714750484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kXyBtcH22l6DIAru77xF46RpqXHr2mETb8HciLCvN4U=;
	b=YVcFcUUeMeeSarSBoZQo+aQhE0A/dDAIhhH5fjHFo6Udy/iQUc2ZoceOWU5y+c7PN/ilWj
	E0Z+NYIkhFUYIsA149ZLACKLyu4ALg4pWBiJ7ADHYLdl5ygIRMfTVN0c/SqaDM417t5Vkr
	ho0kkCYYoo6bljeVAao6Q3fFgMMLlDA=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] arm64: zynqmp: Add coresight cpu debug support
Date: Fri,  3 May 2024 11:34:22 -0400
Message-Id: <20240503153422.1958812-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add coresight debug support to the device tree. This can be useful when
panicking, especially when a core is hung in EL3.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 16 +++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 28 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index dd4569e7bd95..60d1b1acf9a0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -70,6 +70,22 @@ &cpu0 {
 	clocks = <&zynqmp_clk ACPU>;
 };
 
+&cpu0_debug {
+	clocks = <&zynqmp_clk DBF_FPD>;
+};
+
+&cpu1_debug {
+	clocks = <&zynqmp_clk DBF_FPD>;
+};
+
+&cpu2_debug {
+	clocks = <&zynqmp_clk DBF_FPD>;
+};
+
+&cpu3_debug {
+	clocks = <&zynqmp_clk DBF_FPD>;
+};
+
 &fpd_dma_chan1 {
 	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 25d20d803230..ec8d5d19ac1c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -330,6 +330,34 @@ pmu@9000 {
 			};
 		};
 
+		cpu0_debug: debug@fec10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xfec10000 0x0 0x1000>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu0>;
+		};
+
+		cpu1_debug: debug@fed10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xfed10000 0x0 0x1000>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu1>;
+		};
+
+		cpu2_debug: debug@fee10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xfee10000 0x0 0x1000>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu2>;
+		};
+
+		cpu3_debug: debug@fef10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xfef10000 0x0 0x1000>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu3>;
+		};
+
 		/* GDMA */
 		fpd_dma_chan1: dma-controller@fd500000 {
 			status = "disabled";
-- 
2.35.1.1320.gc452695387.dirty


