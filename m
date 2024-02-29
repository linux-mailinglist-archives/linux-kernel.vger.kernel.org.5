Return-Path: <linux-kernel+bounces-87454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87186D49E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1151F21E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A61552F0;
	Thu, 29 Feb 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPqekOKW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE06154EAB;
	Thu, 29 Feb 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239104; cv=none; b=SIHBpM+O3WdZgelBI3Mj3ZWdSaWRiW3ZJ7qt2720HfOWjisE5Kt7WYCKk9WuXFbgKnYt8QywkFURCI4kV8+6ZC6LOcDOHNJ6rNqfmaMNGoc1ivMChH3PsDjTMVswqjdZQ+kqDHwUJQBVtCC1rPz6IrX8OYm8hbAe4COkIIpg+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239104; c=relaxed/simple;
	bh=00qCi/EnUJckOaChnHXcooFvowMzbyuYGrV7xG0Hu8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXCh0lGdsmucB9fS/+r8OggsazIAq5XpysDn/TjhVfdC2lodkslqEuGd6/h5pdtH0XQDEXRasxiyYm3nCLoesTG5yV7tjGR/3FvoGHAi4goyfKWqGOiBtzUBwI+cx2I42jvnBUkqlxFHaV2X35T9Z2u01yZMhA7vP7LjFLgirf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPqekOKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5712AC433C7;
	Thu, 29 Feb 2024 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239104;
	bh=00qCi/EnUJckOaChnHXcooFvowMzbyuYGrV7xG0Hu8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPqekOKW+ssDLdr0FE1v7sqULVjgFlW9R0pnclFJERA1IOZLLyX4NPf/ZjtblUFYp
	 4Kavyw/+nv1Y9rat8Bua4JCRkgej9ik5yxNusIEV9RyTFXO2glOoUQuDFLTwLdFslq
	 n3UmbSFCDVDyU2Rv111xPnC+Czto3QT5/+/EJ2UtCAEBIOFXvVaXxEQGcPino+C6fC
	 lyzowFfTYUZTe4GES/xQtRFoUWyc5sA8bI3I1fwkmsVy6LhZV9i6mUrTzPC+zydPWl
	 Cz8ybxtoEdtiFQzR6t8aNFWFguQXt41eM/ZGsoJyUxXHtyik4l86Dnr7SBWUYhTmEN
	 3hqT4b0mYvoaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	linusw@kernel.org,
	kaloz@openwrt.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 21/24] arm: dts: Fix dtc interrupt_map warnings
Date: Thu, 29 Feb 2024 15:37:01 -0500
Message-ID: <20240229203729.2860356-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

[ Upstream commit f02b0f0dc26fbb77fe47b6e47cc5c211f0432c37 ]

The dtc interrupt_map warning is off because its dependency,
interrupt_provider, is off by default. Fix all the warnings so it can be
enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20240213-arm-dt-cleanups-v1-4-f2dee1292525@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts | 2 ++
 .../boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts  | 2 ++
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi                    | 8 ++++----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
index 4d70f6afd13ab..6d5e69035f94d 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
@@ -60,6 +60,8 @@ pci@c0000000 {
 			 * We have slots (IDSEL) 1 and 2 with one assigned IRQ
 			 * each handling all IRQs.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 11 */
diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
index 9ec0169bacf8c..5f4c849915db7 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
@@ -89,6 +89,8 @@ pci@c0000000 {
 			 * The slots have Ethernet, Ethernet, NEC and MPCI.
 			 * The IDSELs are 11, 12, 13, 14.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 11 - Ethernet A */
 			<0x5800 0 0 1 &gpio0 4 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 11 is irq 4 */
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index a976370264fcf..fb6764b2dcde8 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -345,10 +345,10 @@ pcie_rc: pcie@1c00000 {
 					  "msi8";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 0 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 0 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 0 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 0 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_PCIE_PIPE_CLK>,
 				 <&gcc GCC_PCIE_AUX_CLK>,
-- 
2.43.0


