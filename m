Return-Path: <linux-kernel+bounces-1635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23311815142
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0701F23815
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B6553813;
	Fri, 15 Dec 2023 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EgsyMNOB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843F47F7E;
	Fri, 15 Dec 2023 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702672856;
	bh=Vg9eOkXgIK+AIHRQMZH4JRNU3xI0PgpdMH0mHhrT3k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgsyMNOBj40rLHtoIwhBXC5x46aJYzoFJHiCxG5+OBrIuhWpdC186xMmn1zCpVnNT
	 LETBTl7jofG/eyE21OEFsODjDmnF1wsqJuZpWLJ4mwKO+ssqGJdMvwKzezU6UROixN
	 eYvlt4+skrXBYGbJYXYYN3VwxWuKdlBJN4DdT2KqIQc/kb68G/x1UlII7KSQ2R/AYi
	 c2sAj+6m2Pk/6Vq8xN5OieUTdXUyvqbiLLwwQQkjd0OWKSZsZlDuwyksbNlvqs2Bpl
	 5VsoAS3bxHdXxTvTqYousBMh2XADVRbzi3I91+TW2Y0AqNye5NM37YvlhwPg86GPVg
	 mV1/f4rluntDw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 505D93781FEF;
	Fri, 15 Dec 2023 20:40:56 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v3 4/9] riscv: dts: starfive: jh7100: Add sysmain and gmac DT nodes
Date: Fri, 15 Dec 2023 22:40:43 +0200
Message-ID: <20231215204050.2296404-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the sysmain and gmac DT nodes supporting the DWMAC found on the
StarFive JH7100 SoC.

Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index c216aaecac53..985383745e77 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -204,6 +204,38 @@ sdio1: mmc@10010000 {
 			status = "disabled";
 		};
 
+		gmac: ethernet@10020000 {
+			compatible = "starfive,jh7100-dwmac", "snps,dwmac";
+			reg = <0x0 0x10020000 0x0 0x10000>;
+			clocks = <&clkgen JH7100_CLK_GMAC_ROOT_DIV>,
+				 <&clkgen JH7100_CLK_GMAC_AHB>,
+				 <&clkgen JH7100_CLK_GMAC_PTP_REF>,
+				 <&clkgen JH7100_CLK_GMAC_TX_INV>,
+				 <&clkgen JH7100_CLK_GMAC_GTX>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "gtx";
+			resets = <&rstgen JH7100_RSTN_GMAC_AHB>;
+			reset-names = "ahb";
+			interrupts = <6>, <7>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			max-frame-size = <9000>;
+			snps,multicast-filter-bins = <32>;
+			snps,perfect-filter-entries = <128>;
+			starfive,syscon = <&sysmain 0x70 0>;
+			rx-fifo-depth = <32768>;
+			tx-fifo-depth = <16384>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,fixed-burst;
+			snps,force_thresh_dma_mode;
+			snps,no-pbl-x8;
+			status = "disabled";
+
+			stmmac_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <16>;
+				snps,rd_osr_lmt = <16>;
+				snps,blen = <256 128 64 32 0 0 0>;
+			};
+		};
+
 		clkgen: clock-controller@11800000 {
 			compatible = "starfive,jh7100-clkgen";
 			reg = <0x0 0x11800000 0x0 0x10000>;
@@ -218,6 +250,11 @@ rstgen: reset-controller@11840000 {
 			#reset-cells = <1>;
 		};
 
+		sysmain: syscon@11850000 {
+			compatible = "starfive,jh7100-sysmain", "syscon";
+			reg = <0x0 0x11850000 0x0 0x10000>;
+		};
+
 		i2c0: i2c@118b0000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x0 0x118b0000 0x0 0x10000>;
-- 
2.43.0


