Return-Path: <linux-kernel+bounces-128574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450AE895C9B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F4D1C21456
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3515CD68;
	Tue,  2 Apr 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvxRnSf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49515B96C;
	Tue,  2 Apr 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086323; cv=none; b=pf2FTVq2JvdihgqFNpjAO9sYmaIQEWt0J/r4qlJCpIKYLNzh6GAeV4wFxL5K+6CyuRjR//wSFJ1xO4/J2Z/YuLc8cysm5C0T8OnzjFnTuXCsOteLc8DVHkjOREKOwsNWEeZ3M3tYiw8yd+/1VxJ303zXwHWQ640Ub5AFYTOMfwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086323; c=relaxed/simple;
	bh=wG11ncl3WgULZllIP/mSrmwpOObY8MxFmus9ByKXpDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHw23wdZ9HAFQAlu3SPd7UoLI9i+vO/1z5ROhqlM6aEziI+Nnb7pp1fTorU5h0k35JAaeE9LykcDKUhxcXi1RZTDdeTzurVFs1i2E9bmp/ICPQcAL4xK11VP7zkvE3yDaUjssgHkiyNLGHbRX54VApcCtHPwBQZPpR8UoaV+Zuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvxRnSf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB63C43609;
	Tue,  2 Apr 2024 19:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086323;
	bh=wG11ncl3WgULZllIP/mSrmwpOObY8MxFmus9ByKXpDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvxRnSf/H3oGFer9vqb0DeEp42erbKInddEUSf/qIuCOTzuoT3iXoGOfGcu7UcERo
	 R8Ty85QtK5DJAEBOziczewKdaTf+MDrmw6vC9pxXNzLqYnbTz9j+PAZG6MI17fiqMF
	 Sil6PFYUl+LoNWHsvCQk5D+zUamtJEYDxxDT+aK0W5Wt2HUDlEHOHZn2iG0xpGHtzO
	 TgBUsQHYzb4z6/xuv+tK9M1N3cAKm18apaqkkqKmnv+zGj7imyNmT/LPV04pVuuD6j
	 eOY3BsTytCkRP9SLklwlyNwxC1mqA7jwZaGAYbh6fNp9OMjOOW5eR1bCEuB3RxcKBz
	 67jFxXZE1qdvg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/9] arm64: dts: hisilicon: hip06: move non-MMIO node out of soc
Date: Tue,  2 Apr 2024 21:31:42 +0200
Message-Id: <20240402193148.62323-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402193148.62323-1-krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-MMIO devices, which are BTW not really part of the SoC, should not
be within simple-bus, as reported by dtc W=1 warning:

  hip06.dtsi:377.18-381.5: Warning (simple_bus_reg): /soc/refclk: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 84 ++++++++++++------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index f46c33d10750..249ca3b4b703 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -258,6 +258,48 @@ its_dsa: msi-controller@c6000000 {
 		};
 	};
 
+	eth2: ethernet-0 {
+		compatible = "hisilicon,hns-nic-v2";
+		ae-handle = <&dsaf0>;
+		port-idx-in-ae = <0>;
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+		dma-coherent;
+	};
+
+	eth3: ethernet-1 {
+		compatible = "hisilicon,hns-nic-v2";
+		ae-handle = <&dsaf0>;
+		port-idx-in-ae = <1>;
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+		dma-coherent;
+	};
+
+	eth0: ethernet-4 {
+		compatible = "hisilicon,hns-nic-v2";
+		ae-handle = <&dsaf0>;
+		port-idx-in-ae = <4>;
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+		dma-coherent;
+	};
+
+	eth1: ethernet-5 {
+		compatible = "hisilicon,hns-nic-v2";
+		ae-handle = <&dsaf0>;
+		port-idx-in-ae = <5>;
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+		dma-coherent;
+	};
+
+	refclk: refclk {
+		compatible = "fixed-clock";
+		clock-frequency = <50000000>;
+		#clock-cells = <0>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
@@ -374,12 +416,6 @@ uart0: serial@2f8 {
 			};
 		};
 
-		refclk: refclk {
-			compatible = "fixed-clock";
-			clock-frequency = <50000000>;
-			#clock-cells = <0>;
-		};
-
 		usb_ohci: usb@a7030000 {
 			compatible = "generic-ohci";
 			reg = <0x0 0xa7030000 0x0 0x10000>;
@@ -570,42 +606,6 @@ port@5 {
 			};
 		};
 
-		eth0: ethernet-4 {
-			compatible = "hisilicon,hns-nic-v2";
-			ae-handle = <&dsaf0>;
-			port-idx-in-ae = <4>;
-			local-mac-address = [00 00 00 00 00 00];
-			status = "disabled";
-			dma-coherent;
-		};
-
-		eth1: ethernet-5 {
-			compatible = "hisilicon,hns-nic-v2";
-			ae-handle = <&dsaf0>;
-			port-idx-in-ae = <5>;
-			local-mac-address = [00 00 00 00 00 00];
-			status = "disabled";
-			dma-coherent;
-		};
-
-		eth2: ethernet-0 {
-			compatible = "hisilicon,hns-nic-v2";
-			ae-handle = <&dsaf0>;
-			port-idx-in-ae = <0>;
-			local-mac-address = [00 00 00 00 00 00];
-			status = "disabled";
-			dma-coherent;
-		};
-
-		eth3: ethernet-1 {
-			compatible = "hisilicon,hns-nic-v2";
-			ae-handle = <&dsaf0>;
-			port-idx-in-ae = <1>;
-			local-mac-address = [00 00 00 00 00 00];
-			status = "disabled";
-			dma-coherent;
-		};
-
 		sas0: sas@c3000000 {
 			compatible = "hisilicon,hip06-sas-v2";
 			reg = <0 0xc3000000 0 0x10000>;
-- 
2.34.1


