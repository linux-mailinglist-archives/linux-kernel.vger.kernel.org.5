Return-Path: <linux-kernel+bounces-137505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A07A89E303
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E34BB23B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F1157477;
	Tue,  9 Apr 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsTsAHrC"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFF1581E9;
	Tue,  9 Apr 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689732; cv=none; b=H0snSKh8iVMGctE4/UCpEmywHjmgD9Ntyggba3+llDrY/ayqrwjtccgT7EjEi1T66E+wS9Ms08y3K1JPcQ1usZzZMzsMX5BHMEgcGIgx4vNe9ohUDrzXc7x7lEpEwRQfd8iTbl5lFdoJVKws5rO9h8JrW0HJdjCle4nnQRNoNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689732; c=relaxed/simple;
	bh=/HQoYouMyd4m4GJGvNYVAIPjvnrP+JB97VJJEEcC1X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=moJH5vOZh0yBT0xM5mh2e9tnqt2Q2bilZZ5Imsuhk+EMY6j8CinVfK5fbDy5xwaQOncGfhb9LZdkTl7de29k4H/PNz2FciNFk2+lrnOyN61+9TgdkkdymEtvWxrmn25HLI7GXaMd/F26VPFVnIEIZeENDWSjeafkW3xoHLfLDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsTsAHrC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea26393116so715836a34.0;
        Tue, 09 Apr 2024 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712689729; x=1713294529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG4gX0gqtcPyBLH5Dknw/zIzUHmrrHhMR9dznIhdZtg=;
        b=AsTsAHrC/bVVKk4GAQEH1JM5Rr02urh9xDLFgSAMD9ORc2OxZRlem1IdMcNcBM1wDM
         dKc84aJNYCAU1JE0/i0e1cZQ2w64fz0oh3Hcquz4FIttnJTEfp7hiMciXYcHdDvztHIx
         3shYMhb9VujGyrC2wm+TdAKbWglasLNW2QSq4/0Ey+uSZUPMtn1MOUg8mNqqtbcVvM1Q
         YxPVFkPARSDrcmE7iXqDmhh+xLJiRrGJkYxXs7YnqKIDDKeEtekIWhCT0oPvYbMLy3wG
         Si7YnYa3WwdY0Mwc4CHvIzeXVlJcy/OcbjeBrbyS+TEdhPUNCPwDtwcMOeO+1B7jlN1i
         Mxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689729; x=1713294529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG4gX0gqtcPyBLH5Dknw/zIzUHmrrHhMR9dznIhdZtg=;
        b=UxcpS8826jp+BLtFzvLhP2E4rSejdkjF7mjtp83g4Giz7aLLLG3Z8BcnqYW7Lmgkeg
         IsfnAjQveep7z8sj3JDilKmnfMlJmQhp0ucfIrcBe9Yg5AYn9jJ5nS/dTCLU8tRt6A6S
         R3vXEWn+ZOlDK/RnqnOkMMJRv0pxwifu3JRh/J9gonA9ISnrpKNUuMqBCprBnUAaCytC
         ScQ5woxOPjZBv+WPxAWSix4Y2v4128+QfHgBLpUpIdg+cxqgJpa5F37brUZ5LDu/k684
         xtStPZg0UDILfRlfjsMHQiNONr1vdtD1bdr8LqskGHTXrvVKyqkDgUIS66KOnWgrW/VX
         +5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVr8O8YCDsXjP5CxCBtAlNtIp8SERsGjJ9HCom216FhXHnpycvlCiE6X84y8iA2MaYQonpPw7/HDu2ifSspGi4KX2KmsPh+QJYqR6420/j83q+gQqKfZu6EPbrNiR23PDAO6PbqvPs+0d0xnBZBC7JjkgXVMR1fpJ7utLv1cMFh3i0TfSQpmlY=
X-Gm-Message-State: AOJu0YwpSEd345fB8655+zDbv5w+eqtULwP5aKtOKz6xO1qsDH9chHbF
	WZ8qCFUJKizYzkvYB/faGXwb6xZLjbOzVoWlyb2pFheeRC9vp5c7
X-Google-Smtp-Source: AGHT+IHpg3s9XTt/dwVQJebWvhrYPSQJAoRkPk1Px8mFr+MPXCTkPub7ix8hf34bwA0iRcmErWDMPQ==
X-Received: by 2002:a9d:7e92:0:b0:6ea:23af:2bcb with SMTP id m18-20020a9d7e92000000b006ea23af2bcbmr740934otp.32.1712689729588;
        Tue, 09 Apr 2024 12:08:49 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d7b4b000000b006ea1cf91a8dsm674920oto.40.2024.04.09.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:08:48 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] arm64: dts: qcom: ipq9574: add PCIe2 nodes
Date: Tue,  9 Apr 2024 14:08:33 -0500
Message-Id: <20240409190833.3485824-8-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
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
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 94 ++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..61c518f2a05a 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -300,7 +300,7 @@ gcc: clock-controller@1800000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
+				 <&pcie2_phy>,
 				 <0>,
 				 <0>;
 			#clock-cells = <1>;
@@ -745,6 +745,98 @@ frame@b128000 {
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
+
+			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,	/* I/O */
+				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;	/* MEM */
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


