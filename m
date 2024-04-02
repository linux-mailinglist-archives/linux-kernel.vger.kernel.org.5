Return-Path: <linux-kernel+bounces-128572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3425895C97
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CF0B2350D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4815B972;
	Tue,  2 Apr 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZamUNrxv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1815B962;
	Tue,  2 Apr 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086318; cv=none; b=JAh01x8ju2Pg+SRGoQSLHbzh7Sy58EkJ84C3stlOtZw/GRPDsF0IgXhTHzZEKq8KnHPZFp49vXfFRtAH9P72y4qgdob02hXTRqt160rpC+ycgr0XTvmW2f5zYrOQnCUiHMQcAw7wWtH5YMOff0+Ft+26Tc3I5784TKz3hp5Xml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086318; c=relaxed/simple;
	bh=+30p+tj6kZ4YNkag5U+rmk4Pnu6774eg5NL7Lef7UXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXTELmwPmSUpIFLxMOJs/eIce/Y7/RGziBqCa4nEwsx4FW1MlzU/1b09+W+X0/wwt97akvQg3S/rwRjoqGv6KGyf27YV6SZrpT7WsLSJvVmVzp9bG7rQdTt9dgqR57DOJMv3FqLdnFLM9/WYlPtSoONOK0c6+CEXQ792C/7MZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZamUNrxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC90C433C7;
	Tue,  2 Apr 2024 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086318;
	bh=+30p+tj6kZ4YNkag5U+rmk4Pnu6774eg5NL7Lef7UXM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZamUNrxvbAYJW92Pcru2a2dmZnUyQrys/sd0OspTrY2nkLHo6NcSoNYujzH3l/zv8
	 dpHOx7BZdauHkjTgCTHmRcwaL/tGtx1XI0SaYya6bV/o/wb6mjqlxK17MB9t8WRM3V
	 KOpeOwqRfNImVDqtmkX7whnGvR3ovaBTNkuoM61n9+JmcegqQOm4/V31blN7k7j12L
	 5LBWm6RzYWoEguwrONxkI8RX/PWEr8OhlqitIomOy11oklIHgqr8r2NMO6SKaJFB/k
	 DP8qimyAVkf0U5FSCtvC6UXdXCp46q63uXF1CQkn2ryd9CIRSCgkpGmjeW/DbmWFmc
	 wgDMsQhByclew==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/9] arm64: dts: hisilicon: hip05: move non-MMIO node out of soc
Date: Tue,  2 Apr 2024 21:31:40 +0200
Message-Id: <20240402193148.62323-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-MMIO devices, which are BTW not really part of the SoC, should not
be within simple-bus, as reported by dtc W=1 warning:

  hip05.dtsi:301.30-305.5: Warning (simple_bus_reg): /soc/refclk200mhz: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 65ddc0698f82..d0912ca5f237 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -279,6 +279,12 @@ its_dsa: msi-controller@c6000000 {
 		};
 	};
 
+	refclk200mhz: refclk200mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
@@ -298,12 +304,6 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
-		refclk200mhz: refclk200mhz {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-
 		uart0: serial@80300000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x80300000 0x0 0x10000>;
-- 
2.34.1


