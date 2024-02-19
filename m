Return-Path: <linux-kernel+bounces-71985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A640385AD6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D361F23C63
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2E535D6;
	Mon, 19 Feb 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j5iAxmQE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D50482C3;
	Mon, 19 Feb 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375595; cv=none; b=nbOxQMeIodzrD/eWbtYTWMBYj9dNSI1GkLOJbEvHWrnNp3pIQ7at7djHTpmaKXZ16tnSefSbZj35NLNQC0SAWRr1KS2nbMdS8a5sLVnQYMIFoqhiQRXfhWF72B92swNbitfiMMwDjk+DzvfGEHSzhNLNS6FpM8fPAuhKk4F3BdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375595; c=relaxed/simple;
	bh=d4IYYZx35WXgEpuH5iqpmxV6a4CGdc4bKaNsMSXujIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGl9jGvdEs2PmdGR1b71f9ITM5i1mWSbMqp3jOYGgAUYWT9Nw1cPqg/ilWw2nFJpJRAlakr79HB+n8QjDxZEDH2Y/41MAVfK9CA7ZpRRLEmXeJbAl3Lu2toPfZWyln5yxI1MLr4ATGUd13Qo6JC5y1UTWAMw10VUj1OAKSTGpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j5iAxmQE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708375592;
	bh=d4IYYZx35WXgEpuH5iqpmxV6a4CGdc4bKaNsMSXujIM=;
	h=From:To:Cc:Subject:Date:From;
	b=j5iAxmQEx2EbCc4DjL8AoNWvrZUqN5Zh6n/TsbU2LDVTgiEWTq7FY4uXEyhiUWjtP
	 Xyj+dimvLZFu6QeXPel8L+KGwnjpnfbdG1Lo057aUfGWDw6LNj5v8W0zrmF0LS+2Eq
	 wm4X2dCEzXbq5ucDR2cmdn6M016ojtvTliUtbi79gecKSz30P7ZyAWSsRIwZJYGBNF
	 BkcWe71oXlcWODWlMj3rQnefbIZF+dWb4qX53TBT05KPQb1+CSt2Fb9uoyn2wWyu5+
	 /JOQY+/U2JrGhQ5g64/S8dHiopgaAw/eNx3q8QuZAo3aP3p+9hnMBfyzk9z+DyR9u5
	 oXk8NSpmG1GAw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 22DD63782080;
	Mon, 19 Feb 2024 20:46:32 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH] arm64: dts: rockchip: Add HDMI0 PHY to rk3588
Date: Mon, 19 Feb 2024 22:46:25 +0200
Message-ID: <20240219204626.284399-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT nodes for HDMI0 PHY and related syscon found on RK3588 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 36b1b7acfe6a..3a15a30543c3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -586,6 +586,11 @@ u2phy3_host: host-port {
 		};
 	};
 
+	hdptxphy0_grf: syscon@fd5e0000 {
+		compatible = "rockchip,rk3588-hdptxphy-grf", "syscon";
+		reg = <0x0 0xfd5e0000 0x0 0x100>;
+	};
+
 	ioc: syscon@fd5f0000 {
 		compatible = "rockchip,rk3588-ioc", "syscon";
 		reg = <0x0 0xfd5f0000 0x0 0x10000>;
@@ -2360,6 +2365,22 @@ dmac2: dma-controller@fed10000 {
 		#dma-cells = <1>;
 	};
 
+	hdptxphy_hdmi0: phy@fed60000 {
+		compatible = "rockchip,rk3588-hdptx-phy";
+		reg = <0x0 0xfed60000 0x0 0x2000>;
+		clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>, <&cru PCLK_HDPTX0>;
+		clock-names = "ref", "apb";
+		#phy-cells = <0>;
+		resets = <&cru SRST_HDPTX0>, <&cru SRST_P_HDPTX0>,
+			 <&cru SRST_HDPTX0_INIT>, <&cru SRST_HDPTX0_CMN>,
+			 <&cru SRST_HDPTX0_LANE>, <&cru SRST_HDPTX0_ROPLL>,
+			 <&cru SRST_HDPTX0_LCPLL>;
+		reset-names = "phy", "apb", "init", "cmn", "lane", "ropll",
+			      "lcpll";
+		rockchip,grf = <&hdptxphy0_grf>;
+		status = "disabled";
+	};
+
 	combphy0_ps: phy@fee00000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee00000 0x0 0x100>;
-- 
2.43.2


