Return-Path: <linux-kernel+bounces-138590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6719289F42C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421FFB2C585
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9E16DEB1;
	Wed, 10 Apr 2024 13:20:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DF15ECC9;
	Wed, 10 Apr 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755255; cv=none; b=VpuAZCN5+TPSuTbvXE4Qm2CJiq2kJEkYbJrOvkV7xjGTYmM6iJ9hqSpFCxcDoswKDHyCK6+STeGMAId73NViGOcoKBdkz/DIVGwSqM/2L3rtPYyxxIFDTxPKWEwqNkfU5+WC3qgP+IFwW6Wx049taXjv7YOn1TO24/WOOWq27iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755255; c=relaxed/simple;
	bh=XdUx7RDx6vXYIKWpZxhjafmpFso0gKwfxPR5Ji+BkUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYFWvZVcwW4oyq/3nTOnMkzozORQtYYswVA2i0UFVnTW/icYKtN1sV4+km4hxB5dYlLVjH762wEZOwMOoYVsRtAaXb83k76DJPfdMOAc4Hw70S++c5rqnFpQYkbD0c3FbMRZkhQ/nR7hjfNwmItl/3Ef2McOnXpFntL+N/SAkl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C9FC433F1;
	Wed, 10 Apr 2024 13:20:52 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 4/4] LoongArch: Update dts for Loongson-2K2000 to support GMAC/GNET
Date: Wed, 10 Apr 2024 21:18:04 +0800
Message-ID: <20240410131804.2165848-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410131804.2165848-1-chenhuacai@loongson.cn>
References: <20240410131804.2165848-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current dts file for Loongson-2K2000's GMAC/GNET is incomplete, both irq
and phy descriptions are missing. Add them to make GMAC/GNET work.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../boot/dts/loongson-2k2000-ref.dts          | 33 +++++++++++++++++++
 arch/loongarch/boot/dts/loongson-2k2000.dtsi  | 12 +++++--
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k2000-ref.dts b/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
index dca91caf895e..74b99bd234cc 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
@@ -61,12 +61,45 @@ &xhci1 {
 
 &gmac0 {
 	status = "okay";
+
+	phy-mode = "gmii";
+	phy-handle = <&phy0>;
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@0 {
+			reg = <2>;
+		};
+	};
 };
 
 &gmac1 {
 	status = "okay";
+
+	phy-mode = "gmii";
+	phy-handle = <&phy1>;
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy1: ethernet-phy@1 {
+			reg = <2>;
+		};
+	};
 };
 
 &gmac2 {
 	status = "okay";
+
+	phy-mode = "rgmii";
+	phy-handle = <&phy2>;
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy2: ethernet-phy@2 {
+			reg = <0>;
+		};
+	};
 };
diff --git a/arch/loongarch/boot/dts/loongson-2k2000.dtsi b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
index 481c6c869a8b..9eab2d02cbe8 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
@@ -156,21 +156,27 @@ pcie@1a000000 {
 
 			gmac0: ethernet@3,0 {
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
-				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+					     <13 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&pic>;
 				status = "disabled";
 			};
 
 			gmac1: ethernet@3,1 {
 				reg = <0x1900 0x0 0x0 0x0 0x0>;
-				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+					     <15 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&pic>;
 				status = "disabled";
 			};
 
 			gmac2: ethernet@3,2 {
 				reg = <0x1a00 0x0 0x0 0x0 0x0>;
-				interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH>,
+					     <18 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&pic>;
 				status = "disabled";
 			};
-- 
2.43.0


