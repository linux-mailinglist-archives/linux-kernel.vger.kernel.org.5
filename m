Return-Path: <linux-kernel+bounces-69022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D045B85837D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA291C2348E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC41350E7;
	Fri, 16 Feb 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gehxll/w"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10319133981;
	Fri, 16 Feb 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103125; cv=none; b=LjFpdm8yY4Tfgj2oZBqIR33kKqBub+kkDvclJZPGMhNSHeps2jQml+gxJRT+RR/dT+LuaxHZI/xjqVOwaOoHURxXkWzLHY0HjxrA7WD9dBLrdo8lbSAlq9zybwLDCpDnrzHT95RsLvHdeZr9PkQWQx0Iy5SwdRNF1SKTluLqJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103125; c=relaxed/simple;
	bh=6zOLQPXZQ2JGX+nNdATNogWmxrlrJE9gXcKsVLFpIy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmGxheuCvxQOu/Y0Y2AJM0S1jx1vJmKqkjX6OIkRJ+w3NwmYVjorpQ0pR4TB0hXc/FTOEM4PoosPgVNRiQPQfFdqBsXNYrhybWwc2wa9gIfktygZUWPpsguLYSZkWONKJ1sMglEqMWH94vgknWEcxoCt3aFIhqWozKCoDuYhYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gehxll/w; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708103117;
	bh=6zOLQPXZQ2JGX+nNdATNogWmxrlrJE9gXcKsVLFpIy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gehxll/wSV8g4gjc91Mu+SvyPw/bwR/kHkIdmzQSPJkesRQ7wq/mrBrSTphV2mwEs
	 AQ9caNixCQ9yWYTk3Gzdy+0FSU/mTwr8NzGaPej5D31Fk0jlZA8ekvPp3dxZ/yMA15
	 7+mj2kgx8vl2RR3DRuCnrlTMzwi1JxehB7BA94wbPY3N0KJ0MAKE9EUmQ3NYqmaFgc
	 3HTrhD/T9GEdPSeO7V9S/a68+x4Vk7CkOel4JO8cnbx2LzV78QvCM9om0T/9egVnOE
	 uVki/rYGyAP/L/So/Q+LfUGFDThk7TQQ2UKKuTwwcQVS8IeyFLdDfDt/fg9QvZ4SUc
	 7cOz5PfYyziUQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C0FC637820BD;
	Fri, 16 Feb 2024 17:05:17 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D8F784800D1; Fri, 16 Feb 2024 18:05:16 +0100 (CET)
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
Subject: [PATCH v3 05/10] arm64: dts: rockchip: reorder usb2phy properties for rk3588
Date: Fri, 16 Feb 2024 18:01:20 +0100
Message-ID: <20240216170514.75200-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216170514.75200-1-sebastian.reichel@collabora.com>
References: <20240216170514.75200-1-sebastian.reichel@collabora.com>
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
index 38e075b7b661..8708436dd545 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -545,13 +545,13 @@ usb2phy2_grf: syscon@fd5d8000 {
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
@@ -570,13 +570,13 @@ usb2phy3_grf: syscon@fd5dc000 {
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


