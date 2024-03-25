Return-Path: <linux-kernel+bounces-117225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BB088B4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B61C463C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15491BC4C;
	Mon, 25 Mar 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="meineDDs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819B13A86D;
	Mon, 25 Mar 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376224; cv=none; b=tPzwTDor4qL/pvjvAuAr23WJ3nyu7jThzqnE1VN3fuRgiykFTSffqPVwYMf5EN6zqXBaeefDyDyNPvsv+CjrWYOU4yHNIgxC/2Rs108/7t1SMUChmfN/Q4uDQCBog4Y8SQ2kzNDNAWAg82uTTWVm1qOS0fYc5uzAOfKY5/MFcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376224; c=relaxed/simple;
	bh=t+Zps2/0vSceUv6LE6EZiuGiX/pPNy+d+dQxryQePbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/ag8E4nJof5j648mZyEYmmbNtgPkurgkU+FmZ6LWlBVD32Q1xdj/AK7rX8wszPkwJfCBEMOoG8NcpBsrsrRDaYFQn/Xe9srJa/NpLDPHOMC9cNk5Pyc0nQZcPDIlZRNoe2yTaWPB92/5oVcQOBxqlMCfufhWOpxfvY3ajpUEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=meineDDs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711376217;
	bh=t+Zps2/0vSceUv6LE6EZiuGiX/pPNy+d+dQxryQePbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meineDDs5MI7/8coW/a3dmwgW3+GUOjJPoX+rLMX2qHVRlZZyPWjlgTcNlJ8BqJa3
	 ikPPzSFS8iaxhEd8+Lxoari9LzQKAFwNDTAzdf6ZzFl2tVpi5I5P1bVz921a8Prhlf
	 jWww6zvHSq7s8zRYqsj9igU4+rqem3c0DD5w1qnCMAuQCL9LVNz59d2qEvTNvAKuHD
	 E405+QFe89olteyMwlHQkucKdz43OxqKJC9Hy4YPkGvJJ51cpsTBq7zj4SF2B+LXJK
	 J4n0wYmfwyxzSuSjzJU2anmXu1w+JhsuGNO6xx0EV1ps8KkZF4ApRNZvX0O3Zviytm
	 m/oIt61lqB6OQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B12D37820D9;
	Mon, 25 Mar 2024 14:16:57 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9A8704800D2; Mon, 25 Mar 2024 15:16:56 +0100 (CET)
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
Subject: [PATCH v4 05/10] arm64: dts: rockchip: reorder usb2phy properties for rk3588
Date: Mon, 25 Mar 2024 15:15:35 +0100
Message-ID: <20240325141653.84910-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325141653.84910-1-sebastian.reichel@collabora.com>
References: <20240325141653.84910-1-sebastian.reichel@collabora.com>
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


