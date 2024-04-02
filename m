Return-Path: <linux-kernel+bounces-128565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F4895C83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A081C237FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646C15A4BF;
	Tue,  2 Apr 2024 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIdXGCQK"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4B15D5D7;
	Tue,  2 Apr 2024 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085972; cv=none; b=chfkIEhQrDCQ87oHuZCEQOeHaNZjzsIWCSwUTj2IobHvdIXY3VoR+JqUrLIiA39FPDTJ7bjc0xpFMVWXC6nl0hPvzN0eij+lYWroC+1cAJa5u8JaRHq3XqaNlQyBPLjUTNZdXIs1KisfyiemDHVqL7zHY64EOJIW6K911T8+IXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085972; c=relaxed/simple;
	bh=/VSl3wZKyIwuEwY7TgsCPPeb3wNORKpIKGdAAYrcDYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKuos/t9p10o6Ijv065QULEQPUy2StXFA3C5fr+KV0aJIbCSnBCh7Prkjuxpqev1lf53mp2lR8G+fQ6adEkq2iUAohecNeRB1MdDkg7bPCKrWdo8mAS0wW17ZZzEIDMYbealvJE4p3/GgRb9oc30HGLPk3M+LCcsy3bJfLZvt14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIdXGCQK; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-229a90b7aa9so3121560fac.1;
        Tue, 02 Apr 2024 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712085969; x=1712690769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeP+ZiPVK2O/B/xHr47tR3SibDp7prxbvZDTXMdKMlc=;
        b=mIdXGCQKbH+LMwPbi5guwxKuQRMhKS5vUv+wHvfJY3ZqD2VByL7HVjcC6HLa5zX1/L
         xky7WNrqbJdUYNAGctjIyGnsx9QvPnrGj/bmCCHufMggqEXR+05wiSD8kCe0pAlUJBuV
         GiIqiertIsTjMkTIvLsi1M+px+4h+dgvlsHnZO5kWBZeUrIayDfGtGjQ9P1gu1qAQHER
         8s4WlL0YGUGq+grM6goieQ95Z0H/7+/wC+V8JrSh2gywPCkgYBSIkRo7X8/Jge7qZYOT
         +hEGY9mgyJ2VCYt2fA8+P5axcDCAhzmKOicfYZPimMTqBnc71qVZTuj2Kr+hwP1D+AaM
         Fw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712085969; x=1712690769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeP+ZiPVK2O/B/xHr47tR3SibDp7prxbvZDTXMdKMlc=;
        b=iHizMeyryQ95kGKug2AoBp3NPbTfmadRmFZl2ase7eWescByOPp2AG1MIXxR1wZeZP
         tFIh22Q5OVRoPuM1ONs3df513i6FlNwETtzgjHuxT7vRn+NR+mLI/qk8rehbrwHJg44D
         K3le4sM3aOG+9pYg0TOIZ0p7DXtqt3sxr6A+itk1P+xX9lDe64+4INDhQs+1Plf/qTpq
         IkUcrN4GPTVc6A27OsoL+aenopcMfYID1hzd/4Ouiyjw7VwOrW4z3HFqfkVgKa0LG0xM
         wqUA4udQ2wKJ6N7QXFPuIk7ALXSc4849rqjhi3sOWXDDiX1NT4qu97zf6tKfoUTPamFq
         YsHg==
X-Forwarded-Encrypted: i=1; AJvYcCUvDEo0fM+dlnnp66nT1zwOGXf/Ug61Fjvmh7aUJfb8H3gtOpHFLZ0EoWBPSxJPFIKbnnaJQEXi4Fo5o0bW4taMFF/3hFSJoA6M0nmtoP5FKZcoJamPD45ysWF9Dw24Kg9jxaViWlX5953sLhJ7AAKeEWsfNAkiZRpci6aBEoFUGmRRsEZfkl8=
X-Gm-Message-State: AOJu0YzPJc29L1RTrmAMfFgl5/AgHAgLIIZBCctpBh03Gp0GUy1DKMN5
	oXbx9YeqvCPHMLmAtlN8j6plXvYApSG4osGmij+5Q4189I7km9F9fuqfcxhj19QxXQ==
X-Google-Smtp-Source: AGHT+IFa4mE5kxX2rXYN7XcRV4dgfkxt8MAA+EuMndpCe65Wpc1gLseE1+DBs9qgMTbW+D25156b4g==
X-Received: by 2002:a05:6871:7981:b0:221:bd93:2940 with SMTP id pb1-20020a056871798100b00221bd932940mr13675521oac.27.1712085969453;
        Tue, 02 Apr 2024 12:26:09 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id ld22-20020a0568702b1600b0022e8f9fa89bsm75622oab.57.2024.04.02.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:26:08 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: ansuelsmth@gmail.com,
	robimarko@gmail.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: qcom: ipq9574: add PCIe2 nodes
Date: Tue,  2 Apr 2024 14:25:55 -0500
Message-Id: <20240402192555.1955204-7-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ipq9574, there are 4 PCIe controllers. Describe the pcie2 node, and
its PHY in devicetree.

Only pcie2 is described, because only hardware using that controller
was available for testing.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 93 ++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..626d6359d750 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -300,7 +300,7 @@ gcc: clock-controller@1800000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
+				 <&pcie2_qmp_phy>,
 				 <0>,
 				 <0>;
 			#clock-cells = <1>;
@@ -745,6 +745,97 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		pcie2_qmp_phy: phy@8c000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x0008c000 0x14f4>;
+
+			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
+				 <&gcc GCC_PCIE2_AHB_CLK>,
+				 <&gcc GCC_PCIE2_PIPE_CLK>,
+				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "pipe",
+				      "anoc",
+				      "snoc";
+
+			clock-output-names = "pcie_phy2_pipe_clk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			resets = <&gcc GCC_PCIE2_PHY_BCR>,
+				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+			status = "disabled";
+		};
+
+		pcie2: pcie@20000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg = <0x20000000 0xf1d>,
+			      <0x20000f20 0xa8>,
+			      <0x20001000 0x1000>,
+			      <0x00088000 0x4000>,
+			      <0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			max-link-speed = <3>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie2_qmp_phy>;
+			phy-names = "pciephy";
+
+			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,	/* I/O */
+				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;	/* MEM */
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			msi-parent = <&v2m0>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 164
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 165
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 186
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 187
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE2_RCHNG_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
+
+			resets = <&gcc GCC_PCIE2_PIPE_ARES>,
+				 <&gcc GCC_PCIE2_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_S_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_ARES>,
+				 <&gcc GCC_PCIE2_AUX_ARES>,
+				 <&gcc GCC_PCIE2_AHB_ARES>;
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "aux",
+				      "ahb";
+			status = "disabled";
+		};
 	};
 
 	thermal-zones {
-- 
2.40.1


