Return-Path: <linux-kernel+bounces-164909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097B8B84C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09B81C20AA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5612354FA1;
	Wed,  1 May 2024 04:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpz8SyJP"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F93FB31;
	Wed,  1 May 2024 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536513; cv=none; b=rI8wgwqcZ5jr0Jqwk9YputQmZFamkIQVosaPS6QUBE0P7L9yyVuSkiUCBoSfAXTrYrLv9SCR1uXfI5AFOeIcNJivZUqNtlQ+ACLq4kF4lEPwYdQHoDx73PC/jzwJvYVUoX9dWdx9jXHm/jzpCOyPl0D/jnrYZhjul8eGGx5buQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536513; c=relaxed/simple;
	bh=SGFo0nYVaGclh6uWy9vzUTrAnYsZxkd5dvKmm42KMDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URqNzQpKOT8bOiPKSJskdSH9jLFj3wMrtVEqoRcPBbypAPbzHCbtVNcojgcUKfDfTH+58gQkztDFNnmza+mHT1VfCh3ZKrAYvQtluFTs/bVbCb7FvzHY4a6o88sp4A6QNEtpE9POiuScQeuAehb1aqFCULfPHQQZJ0B6Y0VT8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpz8SyJP; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c75075ad30so4105028b6e.3;
        Tue, 30 Apr 2024 21:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536511; x=1715141311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS+64DkLIQ8nbNaGoMXOJ1Gbc+Q4ngs9pfz0WhHIiSc=;
        b=gpz8SyJPlJTtPlz1L4EIZCWfOdf/hjSGYrVbv8HQQh9ebwjRjoQG5tFN4HwpvmpFqh
         kz5Rk/tme8tj8nwP17tWYJk2yG2lhHCV9+akA+kJw5C18KdX8DJFpibnX1/FGsp9iENU
         +1V2YZYFmyJUv/xQTdz65GQnJSLVZa1zLD3UMFQnHpwvP1H2LZY7YBw4v8C7Vef+1AeW
         p/LcMbm3EdPRJRjeoPwPB/0hnGHyqf4hNNqkGZxcYCJVUEU+ZSxLwf8BA4uws2nmp0GX
         IhKpC0N+BpC3CLmtImHzf5c4cSZNOYK9ff5gOu0G12UhzSVbkJB3hqAxZ8qLEtS6nKL/
         HWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536511; x=1715141311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS+64DkLIQ8nbNaGoMXOJ1Gbc+Q4ngs9pfz0WhHIiSc=;
        b=AlQd4vL+Vi121EIqgl4RreaqYURuDntq+BGiamnsMkq00puqhg2LxdV3z4/obTgE/9
         EYxMSbTCPnAZIunk41SOp1/lWuV4CnGnD5u/PKSsTYzx8keXY9MzQmMun5RbMqycodTI
         khUQZeVtE7qr4ajty2fw9t/66Ixb+kN8aFeyR9l2+OHmYglYw2lPF0n+Zsu2X0f1WbaH
         y+BLQRUqd8Zh5dihRaXWh9HY7Crxj53CEjPGIGdSJ6X2+uepxG0/KQ6Lbs0H50oFRivC
         XRRippI+Lr+6/fTghdkTYBeg13qJrPER6Wh3U5i1VOqCBZ4Aq0xtWq2b6NPptVMkcz2N
         9O4g==
X-Forwarded-Encrypted: i=1; AJvYcCV32h85HHucFpo6hQti6tSrtdgbOGJyenSgDP4j3UZ4P+ztRqipwv2zseaM/4TMWaoF3/s9F//sou/3hFiK5eRjzpjpWb7xyQkl/4FoXD/URccYWiIn8vMVvjV+BDQSLi2lCEEeWIX56VY=
X-Gm-Message-State: AOJu0YyK90Qr0347Fr4vWwWrUxy/cKft9ZVDcbn9ghdwfnKETbI0GyfP
	qucStNYq8GdUDVpH4T/ej+1F++dK7inEGM5aBBRRw3FVxRoVL19D
X-Google-Smtp-Source: AGHT+IEwyz8lehoGeAsE6hFLpaSrCSuUMeCz9VLkrWAexPhM0Qmg55YlRsjFunIz2NmRv9Gd12LkrQ==
X-Received: by 2002:a05:6808:4394:b0:3c8:4948:ee2b with SMTP id dz20-20020a056808439400b003c84948ee2bmr1721107oib.5.1714536510824;
        Tue, 30 Apr 2024 21:08:30 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:30 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 8/8] arm64: dts: qcom: ipq9574: add PCIe2 and PCIe3 nodes
Date: Tue, 30 Apr 2024 23:07:59 -0500
Message-Id: <20240501040800.1542805-18-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ipq9574, there are 4 PCIe controllers. Describe the pcie2 and pcie3
nodes, and their PHYs in devicetree.

The pcie0 and pcie1 controllers use a gen3x1 PHY, which is not
currently supported. Hence, only pcie2 and pcie3 are described. Only
pcie2 was tested because my devboard only has conenctions to pcie2.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 178 +++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..c391886cf9ab 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -300,8 +300,8 @@ gcc: clock-controller@1800000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
-				 <0>,
+				 <&pcie2_phy>,
+				 <&pcie3_phy>,
 				 <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -745,6 +745,180 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		pcie2_phy: phy@8c000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x0008c000 0x14f4>;
+
+			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
+				 <&gcc GCC_PCIE2_AHB_CLK>,
+				 <&gcc GCC_PCIE2_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "pipe";
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
+		pcie3_phy: phy@f4000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x000f4000 0x14f4>;
+
+			clocks = <&gcc GCC_PCIE3_AUX_CLK>,
+				 <&gcc GCC_PCIE3_AHB_CLK>,
+				 <&gcc GCC_PCIE3_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "pipe";
+
+			clock-output-names = "pcie_phy3_pipe_clk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			resets = <&gcc GCC_PCIE3_PHY_BCR>,
+				 <&gcc GCC_PCIE3PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+			status = "disabled";
+		};
+
+		/* TODO: Populate pcie0/pcie1 when gen3x1 phy support is added. */
+
+		pcie2: pcie@20000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg = <0x20000000 0xf1d>,
+			      <0x20000f20 0xa8>,
+			      <0x20001000 0x1000>,
+			      <0x00088000 0x4000>,
+			      <0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+
+			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;
+
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			max-link-speed = <3>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie2_phy>;
+			phy-names = "pciephy";
+
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 164 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 165 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 186 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 187 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>,
+				 <&gcc GCC_PCIE2_RCHNG_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
+
+			resets = <&gcc GCC_PCIE2_PIPE_ARES>,
+				 <&gcc GCC_PCIE2_AUX_ARES>,
+				 <&gcc GCC_PCIE2_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_ARES>,
+				 <&gcc GCC_PCIE2_AXI_S_ARES>,
+				 <&gcc GCC_PCIE2_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AHB_ARES>;
+			reset-names = "pipe",
+				      "aux",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "axi_s_sticky",
+				      "axi_m_sticky",
+				      "ahb";
+			status = "disabled";
+		};
+
+		pcie3: pcie@18000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg = <0x18000000 0xf1d>,
+			      <0x18000f20 0xa8>,
+			      <0x18001000 0x1000>,
+			      <0x000f0000 0x4000>,
+			      <0x18100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+
+			ranges = <0x81000000 0x0 0x18200000 0x18200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x18300000 0x18300000 0x0 0x07d00000>;
+
+			device_type = "pci";
+			linux,pci-domain = <4>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			max-link-speed = <3>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie3_phy>;
+			phy-names = "pciephy";
+
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 189 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 190 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 192 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 192 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE3_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>,
+				 <&gcc GCC_PCIE3_RCHNG_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "anoc",
+				      "snoc",
+				      "rchng";
+
+			resets = <&gcc GCC_PCIE3_PIPE_ARES>,
+				 <&gcc GCC_PCIE3_AUX_ARES>,
+				 <&gcc GCC_PCIE3_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AXI_M_ARES>,
+				 <&gcc GCC_PCIE3_AXI_S_ARES>,
+				 <&gcc GCC_PCIE3_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AHB_ARES>;
+			reset-names = "pipe",
+				      "aux",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "axi_s_sticky",
+				      "axi_m_sticky",
+				      "ahb";
+			status = "disabled";
+		};
 	};
 
 	thermal-zones {
-- 
2.40.1


