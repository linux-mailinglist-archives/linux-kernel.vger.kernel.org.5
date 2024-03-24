Return-Path: <linux-kernel+bounces-114040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFA88880B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E631F23B86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A722D895;
	Sun, 24 Mar 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovboVuUy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABB12FF60;
	Sun, 24 Mar 2024 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321318; cv=none; b=WZaIN5jD6bIJt5AZFPqYHzNRAlFmcd7G89UlCybf3G4jlXZuJWz8sIEM6r1d54kqgJymr+qVEMvn19S+Uo87Z3lzh+n1H1m98b/vADAT4whBDEPAO86ptmk0DvXu6Fi8l8pJlDXDO7Wgq1J7CvDcGy9CNCFD4tTWexEbN6jg6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321318; c=relaxed/simple;
	bh=eBUzn36vqZymU/CNWaaNunB4aUI45530KBqfOLornhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvHu1wJf+YqpU9WKS/iRlm3ejsalmh1zed8D1sp+rguFUWlSPhttV/3OQ8xcPl+USzMxBLDE+FuucnV1lsOfZPZK6W5Ghc7re2yLlSZJANaTE0DocPJVBh2LSYNsj+Zr7P7NSegLWdr2j3yeU4Z84q3SiTl27BDSCNMvK7jtdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovboVuUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC58C43394;
	Sun, 24 Mar 2024 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321317;
	bh=eBUzn36vqZymU/CNWaaNunB4aUI45530KBqfOLornhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovboVuUyBRBCLoM0YGhcHV36BGPmPE774MHIJB8YeU8LRxcUHTS7jDD1z6pcw1W2R
	 /hRqjBWGElo6k+zeIOObC6FxN74XwS1e1RU+rjI1W8qyiMbeWPCCu48eDkobCgXtLV
	 ViAUTFfpnJt0mg/XEcn5iQCkEbzlxJ42NOhPkpagHDaC3aFItsBAQsnwUg7Nw5xcEn
	 MBYgF+XUMHnO2+dq4NNk+mrqhUT5EauXcjFlnr6z+PTJ/hc2wKA8G18cYDMgf7GkGF
	 c7kBAWlnNQ6+892Xyd0IU5vAPXivKfswiwkJTTJov4GZvw4c1xHNT4zJaCqPzSSH06
	 MrasnsefAn2ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 039/638] arm: dts: Fix dtc interrupt_map warnings
Date: Sun, 24 Mar 2024 18:51:16 -0400
Message-ID: <20240324230116.1348576-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 5b86b4de1a1bd..f9ad5abfbd28b 100644
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


