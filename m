Return-Path: <linux-kernel+bounces-57016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32B84D2E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F99628BF2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB24127B68;
	Wed,  7 Feb 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="rKdojV2/"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1D12AACD;
	Wed,  7 Feb 2024 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337426; cv=none; b=ZiPbJZyWGT+xQMJN8g/FuTiu962KzuaSlCIuLsFOnQe9fnoeXP5A7fJOZPdWw/dyvXrLDU5YAFYy9T694kvu0lpV+uuJ1nVJYQooRyfimgxo/Rm99Re3kZAVNb+aF3/nz/Tq6nffuaePycdhb6cDTgSgE/SPsW8Nm1z9g7oeYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337426; c=relaxed/simple;
	bh=yA5EW467l5W4K1izc5KPjWHrjNf/HNEsP8kshSDOM1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0cmhW6HmxAwlbbmig2/tBf/0QybGW3ltkapGMXAAohhXqV05cu55ZIzR7qx56TV4uhqgdxa49ESsPNvMmNcUtwStPCNdrajo0GEesjs4RaK0rHVKyg8b5byEE0F0zyEzoMfeePxnWGubortQc21d1Z9NK6+YZ+w3k2PYF+18HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=rKdojV2/; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2203AC0000DB;
	Wed,  7 Feb 2024 12:23:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2203AC0000DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707337424;
	bh=yA5EW467l5W4K1izc5KPjWHrjNf/HNEsP8kshSDOM1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKdojV2/lo+qlrEWr/RJenKStmRM3zYRFa/86QiFs4K9RpDw/k/qXj5FXju19AFtk
	 9yfbfmndNoDkUQZkk4SWfzZEPqgN0eedOLYKOzCPNC2MDgHaS+K9N4T/UEFlhUDX4r
	 XLUTwNYIbIpV61X0GW8wRvgyY2q1n5yxUqN8hWRQ=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id ADD1218041CAC4;
	Wed,  7 Feb 2024 12:23:42 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v5 05/12] arm64: dts: broadcom: bcmbca: Add NAND controller node
Date: Wed,  7 Feb 2024 12:22:50 -0800
Message-Id: <20240207202257.271784-6-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240207202257.271784-1-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Broadcom STB NAND controller in BCMBCA ARMv8 chip dts
files.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>

---

Changes in v5: None
Changes in v4:
- Move the board related dts setting from SoC dtsi to board dts

Changes in v3: None
Changes in v2:
- Add nand controller node label for 4908 so it is consistent with other
SoCs and can be referenced by board dts file

 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi  |  4 ++--
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi  | 14 ++++++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi  | 14 ++++++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi  | 14 ++++++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi  | 14 ++++++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts  | 10 ++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts  | 10 ++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts | 10 ++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts | 10 ++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts  | 10 ++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts  | 10 ++++++++++
 arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts  | 10 ++++++++++
 14 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index 2f124b027bbf..336016e334d9 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -589,7 +589,7 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
-		nand-controller@1800 {
+		nand_controller: nand-controller@1800 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
@@ -597,7 +597,7 @@ nand-controller@1800 {
 			reg-names = "nand", "nand-int-base";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nand_ctlrdy";
-			status = "okay";
+			status = "disabled";
 
 			nandcs: nand@0 {
 				compatible = "brcm,nandcs";
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
index d658c81f7285..14b2adfb817c 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
index 4f474d47022e..589b8a1efc72 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
@@ -119,6 +119,20 @@ hsspi: spi@1000 {
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
index 909f254dc47d..48d618e75866 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
@@ -137,6 +137,20 @@ hsspi: spi@1000 {
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
index 685ae32951c9..1d1303cf90f3 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
index 820553ce541b..00c62c1e5df0 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
index 0eb93c298297..caeaf428dc15 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
@@ -156,5 +156,19 @@ hsspi: spi@1000 {
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts
index c4e6e71f6310..030ffa5364fb 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
index e69cd683211a..4b779e6c22e1 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
index db2c82d6dfd8..2851e8e41bf4 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
index 25c12bc63545..17dc594fe83f 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
index faba21f03120..34832a734734 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
index 9808331eede2..e1396b5544b7 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
index 1f561c8e13b0..30bbf6f2917e 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
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


