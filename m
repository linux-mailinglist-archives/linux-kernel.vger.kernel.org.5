Return-Path: <linux-kernel+bounces-124665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B7891B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC6C1C2639D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546BE16F0F5;
	Fri, 29 Mar 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I39JAF9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F91411FB;
	Fri, 29 Mar 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715659; cv=none; b=rp4rq1aMouNHUR/5hCfAU8FpvmVPrAzQe1HFLvR3A1rd3ayzMnHs2mC9DOJmXLiKUmIdC5mbNbFxTcQ+y/MWoCUy1t02t4ud7q/rxpOlAjnrf9aWuWPJaXJLlMkoZVxZ5/w74GcxFOIaK9bkribyVztPrPhf0bA0kEkXEKz/dpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715659; c=relaxed/simple;
	bh=mnvBdOWr2dTaO6J2yotkR/heUcAFjGhxaYEUT9or5M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsyKzlYqFZ7Fku7MweAQQrXhEBGL90mSXrHZPHgINUhvsdCQLcWG9yFGvejCKBGDTLeI9tG1WLK1DZGhSQTL8qsTU3dyDtcZ/K4HLk0BTbFw1EJFSs4PcanCKfb2vdOEmjYt7VFmv9KZ4IQRlJFnlZ3Vd9bB6HBZQSTWCN471Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I39JAF9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803BDC43399;
	Fri, 29 Mar 2024 12:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715659;
	bh=mnvBdOWr2dTaO6J2yotkR/heUcAFjGhxaYEUT9or5M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I39JAF9G6ibyD6+BycrgzDFzfO7tkW1FA/wByUo+qkz0iR8HnzeFBsHTmwz5s5Zht
	 8vi4zpazSC6k1YqyVKphxhREIe8kWQDuUYUpqgwpG5X5aBf+k+QoorvmocWF/aRrRg
	 wyPdhf77jYd/VMxsj9GGCfWgBJiUfuESZf22/nzHW39gt3EIgfAPRRz3eSYRz6hoH3
	 9UDM97as58J0XzWCV+asOlQyKjEEYyIksxC0C5EbZm3Exthle2GYALfrYCk8zwbv0b
	 cSrxqyEfr484QJelNoBRxQfka9EGn5wT6vzZviHIEERLo44u1opB/mgZMoiX8WWSb3
	 Nz+rLSluMNk/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dsimic@manjaro.org,
	quentin.schulz@theobroma-systems.com,
	jonas@kwiboo.se,
	lukasz.luba@arm.com,
	rick.wertenbroek@gmail.com,
	s.hauer@pengutronix.de,
	chris.obbard@collabora.com,
	knaerzche@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 07/17] arm64: dts: rockchip: fix rk3399 hdmi ports node
Date: Fri, 29 Mar 2024 08:33:46 -0400
Message-ID: <20240329123405.3086155-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit f051b6ace7ffcc48d6d1017191f167c0a85799f6 ]

Fix rk3399 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/a6ab6f75-3b80-40b1-bd30-3113e14becdd@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3180f576ed02e..e2515218ff734 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1769,6 +1769,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1777,13 +1778,16 @@ hdmi: hdmi@ff940000 {
 			 <&cru PLL_VPLL>;
 		clock-names = "iahb", "isfr", "cec", "grf", "vpll";
 		power-domains = <&power RK3399_PD_HDCP>;
-		reg-io-width = <4>;
 		rockchip,grf = <&grf>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1796,6 +1800,10 @@ hdmi_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-- 
2.43.0


