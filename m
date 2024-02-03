Return-Path: <linux-kernel+bounces-50779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0245E847DD1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBAC1C23D4A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD3010FA;
	Sat,  3 Feb 2024 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c+3Bfgxf"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FE79F9;
	Sat,  3 Feb 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920166; cv=none; b=K135qPHGapEMCkxT6e3Y7EsONzkJEbmQcGcHJQwSr2RfTPd+fNPVfZxeI/lzDJKZH1qh19xwO6F+lJD2sMVLTFINjoo2UYCFQryOjtyioP/8iR+C114gXOWicPDv8/9n5JuaO9scD54OYaoV4f9gUfo7yLxdvydHDX5z0k67DTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920166; c=relaxed/simple;
	bh=KJqZP1iSgrlN4wC7toektFTN5utdpEAvhiz0Odr8fQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fklegDeSaxd6HjN+y+slFUSUXYtRM37gfywgn8PrLASs/epul+bGXLtu6tIxKeHP5HYtpRhzbCSXgcSG5UKesWMbs2FMhrqle3MBI307mdj67a8EdiGZAxbLKQRqaluNDCdHtvBYMU/z6M0vUopXvziPIrpNELf7r/swtWbaBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c+3Bfgxf; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id DF3DDC0029C3;
	Fri,  2 Feb 2024 16:29:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com DF3DDC0029C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706920163;
	bh=KJqZP1iSgrlN4wC7toektFTN5utdpEAvhiz0Odr8fQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+3Bfgxf2/1sIZJt/JmdXwglWAQ8lIYQbDpSj8LqF14MjlLXqkSUtjYf16Bvnj9fr
	 jL8fI90aeO8JiyXTtdhwzpDhVrklqY0zntKFYVr2d+mmPX+mPqezmkGe4oJLNfYLQF
	 c4wXJYnpxNoPM1DwQyFPn0mwrDsvGLAm2hQs13dc=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 7E30B18041CAC4;
	Fri,  2 Feb 2024 16:29:22 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	David Regan <dregan@broadcom.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 04/12] ARM: dts: broadcom: bcmbca: Add NAND controller node
Date: Fri,  2 Feb 2024 16:28:25 -0800
Message-Id: <20240203002834.171462-5-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240203002834.171462-1-william.zhang@broadcom.com>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Broadcom STB NAND controller in BCMBCA ARMv7 chip dts
files.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>

---

Changes in v4:
- Move the board related dts setting from SoC dtsi to board dts

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/broadcom/bcm47622.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/broadcom/bcm63138.dtsi    |  7 ++++++-
 arch/arm/boot/dts/broadcom/bcm63148.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/broadcom/bcm63178.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/broadcom/bcm6756.dtsi     | 14 ++++++++++++++
 arch/arm/boot/dts/broadcom/bcm6846.dtsi     | 14 ++++++++++++++
 arch/arm/boot/dts/broadcom/bcm6855.dtsi     | 14 ++++++++++++++
 arch/arm/boot/dts/broadcom/bcm6878.dtsi     | 14 ++++++++++++++
 arch/arm/boot/dts/broadcom/bcm947622.dts    | 10 ++++++++++
 arch/arm/boot/dts/broadcom/bcm963138.dts    | 10 ++++++++++
 arch/arm/boot/dts/broadcom/bcm963138dvt.dts | 14 +++++++-------
 arch/arm/boot/dts/broadcom/bcm963148.dts    | 10 ++++++++++
 arch/arm/boot/dts/broadcom/bcm963178.dts    | 10 ++++++++++
 arch/arm/boot/dts/broadcom/bcm96756.dts     | 10 ++++++++++
 arch/arm/boot/dts/broadcom/bcm96846.dts     | 10 ++++++++++
 arch/arm/boot/dts/broadcom/bcm96855.dts     | 10 ++++++++++
 arch/arm/boot/dts/broadcom/bcm96878.dts     | 10 ++++++++++
 17 files changed, 191 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47622.dtsi b/arch/arm/boot/dts/broadcom/bcm47622.dtsi
index 7cd38de118c3..485863f9c420 100644
--- a/arch/arm/boot/dts/broadcom/bcm47622.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm47622.dtsi
@@ -138,6 +138,20 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm63138.dtsi b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
index 4ef02283612b..e74ba6bf370d 100644
--- a/arch/arm/boot/dts/broadcom/bcm63138.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
@@ -229,7 +229,12 @@ nand_controller: nand-controller@2000 {
 			reg-names = "nand", "nand-int-base";
 			status = "disabled";
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "nand";
+			interrupt-names = "nand_ctlrdy";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
 		};
 
 		serial@4400 {
diff --git a/arch/arm/boot/dts/broadcom/bcm63148.dtsi b/arch/arm/boot/dts/broadcom/bcm63148.dtsi
index 24431de1810e..53703827ee3f 100644
--- a/arch/arm/boot/dts/broadcom/bcm63148.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm63148.dtsi
@@ -119,5 +119,19 @@ hsspi: spi@1000 {
 			num-cs = <8>;
 			status = "disabled";
 		};
+
+		nand_controller: nand-controller@2000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x2000 0x600>, <0xf0 0x10>;
+			reg-names = "nand", "nand-int-base";
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm63178.dtsi b/arch/arm/boot/dts/broadcom/bcm63178.dtsi
index 3f9aed96babf..6d8d33498983 100644
--- a/arch/arm/boot/dts/broadcom/bcm63178.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm63178.dtsi
@@ -129,6 +129,20 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm6756.dtsi b/arch/arm/boot/dts/broadcom/bcm6756.dtsi
index 1d8d957d65dd..6433f8fa5eff 100644
--- a/arch/arm/boot/dts/broadcom/bcm6756.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm6756.dtsi
@@ -139,6 +139,20 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm6846.dtsi b/arch/arm/boot/dts/broadcom/bcm6846.dtsi
index cf92cf8c4693..ee361cb00b7c 100644
--- a/arch/arm/boot/dts/broadcom/bcm6846.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm6846.dtsi
@@ -119,5 +119,19 @@ hsspi: spi@1000 {
 			num-cs = <8>;
 			status = "disabled";
 		};
+
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm6855.dtsi b/arch/arm/boot/dts/broadcom/bcm6855.dtsi
index 52d6bc89f9f8..52915ec6f339 100644
--- a/arch/arm/boot/dts/broadcom/bcm6855.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm6855.dtsi
@@ -129,6 +129,20 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm6878.dtsi b/arch/arm/boot/dts/broadcom/bcm6878.dtsi
index 2c5d706bac7e..70cf23a65fdb 100644
--- a/arch/arm/boot/dts/broadcom/bcm6878.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm6878.dtsi
@@ -120,6 +120,20 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm947622.dts b/arch/arm/boot/dts/broadcom/bcm947622.dts
index 93b8ce22678d..6241485408d3 100644
--- a/arch/arm/boot/dts/broadcom/bcm947622.dts
+++ b/arch/arm/boot/dts/broadcom/bcm947622.dts
@@ -32,3 +32,13 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm963138.dts b/arch/arm/boot/dts/broadcom/bcm963138.dts
index 1b405c249213..7fd87e05ec20 100644
--- a/arch/arm/boot/dts/broadcom/bcm963138.dts
+++ b/arch/arm/boot/dts/broadcom/bcm963138.dts
@@ -29,3 +29,13 @@ &serial0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm963138dvt.dts b/arch/arm/boot/dts/broadcom/bcm963138dvt.dts
index b5af61853a07..f60d09908ab9 100644
--- a/arch/arm/boot/dts/broadcom/bcm963138dvt.dts
+++ b/arch/arm/boot/dts/broadcom/bcm963138dvt.dts
@@ -32,15 +32,15 @@ &serial1 {
 };
 
 &nand_controller {
+	brcm,wp-not-connected;
 	status = "okay";
+};
 
-	nand@0 {
-		compatible = "brcm,nandcs";
-		reg = <0>;
-		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
-		brcm,nand-oob-sectors-size = <16>;
-	};
+&nandcs {
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	brcm,nand-oob-sector-size = <16>;
+	nand-on-flash-bbt;
 };
 
 &ahci {
diff --git a/arch/arm/boot/dts/broadcom/bcm963148.dts b/arch/arm/boot/dts/broadcom/bcm963148.dts
index 1f5d6d783f09..44bca063a327 100644
--- a/arch/arm/boot/dts/broadcom/bcm963148.dts
+++ b/arch/arm/boot/dts/broadcom/bcm963148.dts
@@ -32,3 +32,13 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm963178.dts b/arch/arm/boot/dts/broadcom/bcm963178.dts
index d036e99dd8d1..098a222cd71a 100644
--- a/arch/arm/boot/dts/broadcom/bcm963178.dts
+++ b/arch/arm/boot/dts/broadcom/bcm963178.dts
@@ -32,3 +32,13 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm96756.dts b/arch/arm/boot/dts/broadcom/bcm96756.dts
index 8b104f3fb14a..402038d3cd0c 100644
--- a/arch/arm/boot/dts/broadcom/bcm96756.dts
+++ b/arch/arm/boot/dts/broadcom/bcm96756.dts
@@ -32,3 +32,13 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm96846.dts b/arch/arm/boot/dts/broadcom/bcm96846.dts
index 55852c229608..943896afb7cc 100644
--- a/arch/arm/boot/dts/broadcom/bcm96846.dts
+++ b/arch/arm/boot/dts/broadcom/bcm96846.dts
@@ -32,3 +32,13 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm96855.dts b/arch/arm/boot/dts/broadcom/bcm96855.dts
index 2ad880af2104..571663d9a1ea 100644
--- a/arch/arm/boot/dts/broadcom/bcm96855.dts
+++ b/arch/arm/boot/dts/broadcom/bcm96855.dts
@@ -32,3 +32,13 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm96878.dts b/arch/arm/boot/dts/broadcom/bcm96878.dts
index b7af8ade7a9d..8d6eddd54c6e 100644
--- a/arch/arm/boot/dts/broadcom/bcm96878.dts
+++ b/arch/arm/boot/dts/broadcom/bcm96878.dts
@@ -32,3 +32,13 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};
-- 
2.37.3


