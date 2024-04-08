Return-Path: <linux-kernel+bounces-135989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA19189CE9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778D91F2377F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FBA14D29D;
	Mon,  8 Apr 2024 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AdnYUIiI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02461149DF1;
	Mon,  8 Apr 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616677; cv=none; b=BpX7VrulMGBaXHTYE96spwul6IdKecfoCX1XEahmM8jQPgz1trDmE6RMR2zZ5DP2H+3aIiehxdKOChNtOSZIWdT1bveBDWbydVcVespGNU2P884zcgaGtnDL76oSHgGqZ/rNdFOIiIC/Uk7mfKQgyerdDHHJQCTN75YAX1QJotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616677; c=relaxed/simple;
	bh=t+Zps2/0vSceUv6LE6EZiuGiX/pPNy+d+dQxryQePbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI605ArLXbRkQU+eJb9XRZKcs5cW71pwMYndOsmia4jNjsF3Qrq0Ey1N9AOkRAGc4zJegox1654XAcFPb3rDeXO0aW+HMOMnsa8uj42cqaga+NmchHM5SdW4G5gLlLzqEVHhCRmUUzi+mEc+H4NE3QdDE4hbBKaRfLCbIEGTGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AdnYUIiI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712616671;
	bh=t+Zps2/0vSceUv6LE6EZiuGiX/pPNy+d+dQxryQePbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdnYUIiIwrFjQk/eDnCGN2QxRXAWvmB3n1Fy4JwLAQnR5RrIOLYtF8YdTmFHm7jot
	 Q2SDAYtIqpr/otygM3lr+1iF28lYHeVKkOMc+rzrYV+wtoLtOhVBdaVpeGofCoMRMV
	 Szt/aeWY0IpbnivCyh/VKrWu0LJGWMhIePOryQKfFZjkG3VlIEYW1zSy7ieIovOFXf
	 e1HwYeQi4dRZm7gbCU/OzLF1bxvOT9DVc//X/QlFAuiNctXevlUo/M4pCqkgCoqH+o
	 oVUakNn6lNxPGeUidStr4fQEmDPXoNfTLutSBtM/CWq9cijGUhGUbPZI1jizcS9dtX
	 UM0QXFq9qU5Ug==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2348A37820E2;
	Mon,  8 Apr 2024 22:51:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 436164800D2; Tue,  9 Apr 2024 00:51:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v5 05/10] arm64: dts: rockchip: reorder usb2phy properties for rk3588
Date: Tue,  9 Apr 2024 00:50:32 +0200
Message-ID: <20240408225109.128953-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408225109.128953-1-sebastian.reichel@collabora.com>
References: <20240408225109.128953-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder common DT properties alphabetically for usb2phy, according
to latest DT style rules.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 5ed0d8c95427..36e0f198f6bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -546,13 +546,13 @@ usb2phy2_grf: syscon@fd5d8000 {
 		u2phy2: usb2phy@8000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0x8000 0x10>;
-			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
-			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
-			reset-names = "phy", "apb";
+			#clock-cells = <0>;
 			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy2";
-			#clock-cells = <0>;
+			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
+			reset-names = "phy", "apb";
 			status = "disabled";
 
 			u2phy2_host: host-port {
@@ -571,13 +571,13 @@ usb2phy3_grf: syscon@fd5dc000 {
 		u2phy3: usb2phy@c000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0xc000 0x10>;
-			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
-			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
-			reset-names = "phy", "apb";
+			#clock-cells = <0>;
 			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy3";
-			#clock-cells = <0>;
+			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
+			reset-names = "phy", "apb";
 			status = "disabled";
 
 			u2phy3_host: host-port {
-- 
2.43.0


