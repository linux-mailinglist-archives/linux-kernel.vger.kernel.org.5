Return-Path: <linux-kernel+bounces-128576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747B895C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DE51C225AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D215D5D3;
	Tue,  2 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/ssOeRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76AC15D5BE;
	Tue,  2 Apr 2024 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086328; cv=none; b=laSboVnzWfFtqOp+rSwsdYB/GA7yZDlc6UhOp7hPdttneBqZtIvMiQ41THh28onVeFzdCPqCoHXE5pmiv8LtZf4pEc5GYaT629CBn+UWPYXDRyjqES1Gp/peR2Q5a9OxVaF5dxFweenu8MafRL6Qo2U/ZpIkA3eobB+A0NyEYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086328; c=relaxed/simple;
	bh=IoXDQBtmVgaeXIlwlG+jx/SKEEu6yvyEik+151mgSHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IO0tL7fQmzRYZBuwXJnPefxRGXL+GqHYJiVhe+7GZ3MYl8hKw0pCRC8uGynRVJdx9yJwwIOwJfnYmKCOxx0S3Q44IoDj3WtkoWmFdC7FRJdMyQ+E2fr0wlbSsRwH4j6rzaT0iiKtH2McZNJ9Dkcnvk/zznJGJPIH1yhaRJJvhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/ssOeRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49B0C43609;
	Tue,  2 Apr 2024 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086328;
	bh=IoXDQBtmVgaeXIlwlG+jx/SKEEu6yvyEik+151mgSHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/ssOeRv+ftFtH8fmPSo84ZaVft9OfkwuSKXD8cXCuXcO8DpAcvpVyzjqLA6ktP5W
	 6YlIoWcQ8vml6v5OiTzw8WTvdBWDv1THhody4IteY/sG1YkP3Ki5akq9vkR+kXUV+A
	 tTSyciSNDCLkMUdR/xjdAh4Unmiq29q0TgjhlYgAFW7RAuCkYuKl58o7eCzPZp/Ahb
	 68u7zmUS6HOTOCFx5wOsbarvIAi6C4XjENV2uIkbGmd6LWrJEm+6CVkOwNJmFBbgvF
	 gRd9O9hyxGG+tmIkGIs4/itsDIx4DaRkMp7Hr/F3otshmTnx1hsd9L0MShEdiWJsM2
	 U1ozjuaBy/Cmg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/9] arm64: dts: hisilicon: hip07: move non-MMIO node out of soc
Date: Tue,  2 Apr 2024 21:31:44 +0200
Message-Id: <20240402193148.62323-5-krzk@kernel.org>
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

hi  p07.dtsi:1486.20-1493.5: Warning (unit_address_vs_reg): /soc/ethernet@4: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 72 ++++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 81d907ef43ed..9d1e86553ea8 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1013,6 +1013,42 @@ p1_its_dsa_b: msi-controller@408c6000000 {
 		};
 	};
 
+	eth0: ethernet-0 {
+		compatible = "hisilicon,hns-nic-v2";
+		ae-handle = <&dsaf0>;
+		port-idx-in-ae = <4>;
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+		dma-coherent;
+	};
+
+	eth1: ethernet-1 {
+		compatible = "hisilicon,hns-nic-v2";
+		ae-handle = <&dsaf0>;
+		port-idx-in-ae = <5>;
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+		dma-coherent;
+	};
+
+	eth2: ethernet-2 {
+		compatible = "hisilicon,hns-nic-v2";
+		ae-handle = <&dsaf0>;
+		port-idx-in-ae = <0>;
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+		dma-coherent;
+	};
+
+	eth3: ethernet-3 {
+		compatible = "hisilicon,hns-nic-v2";
+		ae-handle = <&dsaf0>;
+		port-idx-in-ae = <1>;
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+		dma-coherent;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
@@ -1483,42 +1519,6 @@ port@5 {
 			};
 		};
 
-		eth0: ethernet@4 {
-			compatible = "hisilicon,hns-nic-v2";
-			ae-handle = <&dsaf0>;
-			port-idx-in-ae = <4>;
-			local-mac-address = [00 00 00 00 00 00];
-			status = "disabled";
-			dma-coherent;
-		};
-
-		eth1: ethernet@5 {
-			compatible = "hisilicon,hns-nic-v2";
-			ae-handle = <&dsaf0>;
-			port-idx-in-ae = <5>;
-			local-mac-address = [00 00 00 00 00 00];
-			status = "disabled";
-			dma-coherent;
-		};
-
-		eth2: ethernet@0 {
-			compatible = "hisilicon,hns-nic-v2";
-			ae-handle = <&dsaf0>;
-			port-idx-in-ae = <0>;
-			local-mac-address = [00 00 00 00 00 00];
-			status = "disabled";
-			dma-coherent;
-		};
-
-		eth3: ethernet@1 {
-			compatible = "hisilicon,hns-nic-v2";
-			ae-handle = <&dsaf0>;
-			port-idx-in-ae = <1>;
-			local-mac-address = [00 00 00 00 00 00];
-			status = "disabled";
-			dma-coherent;
-		};
-
 		infiniband@c4000000 {
 			compatible = "hisilicon,hns-roce-v1";
 			reg = <0x0 0xc4000000 0x0 0x100000>;
-- 
2.34.1


