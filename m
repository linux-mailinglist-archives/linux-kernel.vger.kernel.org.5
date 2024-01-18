Return-Path: <linux-kernel+bounces-30533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5428831FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A13288DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0512E859;
	Thu, 18 Jan 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GfOgUNRq"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21A2E651
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607669; cv=none; b=Vyb5pwOZolj1GpCqIq5+CXlTPhY3gjL7WhAkjJyn1IqstrNsryKi050vQbLLajRk5w3gVLIu5jOJLDZ8yyVTxLjX3y+y8eVWTPFYYHlug4TkcY0zcQfjojdsQsIS0iPYhSjInyehEKeYH5/YZhPrjX74JVuiSO7cCxe5UsPHo0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607669; c=relaxed/simple;
	bh=BKGUNLOlYtyDwQqPUMJqrEdssB+3ExVINieEuhTfE8A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7ItMJ6yrMwmtrHa8dr1XASvK4tJeZ4a6P2dfCtWlwi8Bji8wdmio3O2HBCUEZW00F6A4uDTUaHcmcSiIzHIJkSSLaFgNVZ+lycWD88dRY8ZxAYG1jjTKldbkGzwrMo9ipUYe5eL2l2RrSPkCujbFihm4nHbR38Ri27Sbv3J7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GfOgUNRq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2903cd158f8so69267a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607666; x=1706212466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7YdlaHtDicZ9S/nNPczTdCxtxFMN2pJg3+moTPaeDY=;
        b=GfOgUNRq2CjgjiqEEX2yTKLx5SgoTkLk5V2YGdJWmQP0SXXvjQ/ttvK3rcN+OjzI+B
         IEInXPnYe1R5mo/6JRfwxVimPWxQQZKsPklWn1ZL5rJpukWYLVfVVZfeFWmU0sbnMBXp
         72bPZslktgUQpFoxblHZFNT1TM441W4nKZs9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607666; x=1706212466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7YdlaHtDicZ9S/nNPczTdCxtxFMN2pJg3+moTPaeDY=;
        b=UfL9lf+fiH9RoFDyr5zUxDDzezhwlHGod2gwJCyMjHSoEFO4Gnw6hNnrsMa5yYHHMA
         qiWxO8tufvZszHm0rK6S7hmI5lfCnr5cM1fkkShxJXyJKEtO4eRuNqbQECIeEpYq/Bmk
         AYV7Uc7ubRssJOQZf+uq3Zqr/d7LJZCSLU1kHcu8tyPC7LPL19tHGffd2A4Tv0YPHw0L
         oFbnUj1MXHArWgN1+b4xU4lRwV8yidl/sKnxEVoVNUCVvOxusxVN3GusDtWlKoFixZ6G
         ucI3q6UhMLJ9JN0HoxKf+vcwrTrVZwOkiOCXOqsEjBi0v+F9vNnoQWO4sPJGf9ehLQrE
         JVwA==
X-Gm-Message-State: AOJu0YzD+/Um52XAQTcvBtjiLqEbOgjWLOuyjf4mQjeUj1KNjXoDOkGu
	UQK7xzhgxiwnFqnbQNAwMjzm/QJx9DT+whIWsTI5ZN/uWXCGaYb/Jeoa+Ca5EQ==
X-Google-Smtp-Source: AGHT+IEoxUIUXKVf4ieGnqL9RGAv8SCgN30MM0zhDQgEa5AiaT4yw1zAbStUyQ7x7a1Q5OBDK+J3iA==
X-Received: by 2002:a17:90a:c292:b0:28d:280a:7e4e with SMTP id f18-20020a17090ac29200b0028d280a7e4emr1045900pjt.56.1705607666218;
        Thu, 18 Jan 2024 11:54:26 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:25 -0800 (PST)
From: dregan@broadcom.com
To: dregan@broadcom.com,
	dregan@mail.com,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	computersforpeace@gmail.com,
	kdasu.kdev@gmail.com,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joel.peshkin@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	william.zhang@broadcom.com,
	anand.gore@broadcom.com,
	kursad.oney@broadcom.com,
	florian.fainelli@broadcom.com,
	rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com,
	baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org,
	dan.carpenter@linaro.org
Subject: [PATCH v2 02/10] ARM: dts: broadcom: bcmbca: Add NAND controller node
Date: Thu, 18 Jan 2024 11:53:48 -0800
Message-Id: <20240118195356.133391-3-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240118195356.133391-1-dregan@broadcom.com>
References: <20240118195356.133391-1-dregan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Zhang <william.zhang@broadcom.com>

Add support for Broadcom STB NAND controller in BCMBCA ARMv7 chip dts
files.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
---
Changes in v2: None
---
 arch/arm/boot/dts/broadcom/bcm47622.dtsi    | 17 +++++++++++++++++
 arch/arm/boot/dts/broadcom/bcm63138.dtsi    | 10 +++++++++-
 arch/arm/boot/dts/broadcom/bcm63148.dtsi    | 17 +++++++++++++++++
 arch/arm/boot/dts/broadcom/bcm63178.dtsi    | 17 +++++++++++++++++
 arch/arm/boot/dts/broadcom/bcm6756.dtsi     | 17 +++++++++++++++++
 arch/arm/boot/dts/broadcom/bcm6846.dtsi     | 17 +++++++++++++++++
 arch/arm/boot/dts/broadcom/bcm6855.dtsi     | 17 +++++++++++++++++
 arch/arm/boot/dts/broadcom/bcm6878.dtsi     | 17 +++++++++++++++++
 arch/arm/boot/dts/broadcom/bcm947622.dts    |  4 ++++
 arch/arm/boot/dts/broadcom/bcm963138.dts    |  4 ++++
 arch/arm/boot/dts/broadcom/bcm963138dvt.dts | 12 +++++-------
 arch/arm/boot/dts/broadcom/bcm963148.dts    |  4 ++++
 arch/arm/boot/dts/broadcom/bcm963178.dts    |  4 ++++
 arch/arm/boot/dts/broadcom/bcm96756.dts     |  4 ++++
 arch/arm/boot/dts/broadcom/bcm96846.dts     |  4 ++++
 arch/arm/boot/dts/broadcom/bcm96855.dts     |  4 ++++
 arch/arm/boot/dts/broadcom/bcm96878.dts     |  4 ++++
 17 files changed, 165 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47622.dtsi b/arch/arm/boot/dts/broadcom/bcm47622.dtsi
index 7cd38de118c3..55ff18043d96 100644
--- a/arch/arm/boot/dts/broadcom/bcm47622.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm47622.dtsi
@@ -138,6 +138,23 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			brcm,nand-use-wp = <0>;
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm63138.dtsi b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
index 4ef02283612b..3aaee1c6994e 100644
--- a/arch/arm/boot/dts/broadcom/bcm63138.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm63138.dtsi
@@ -229,7 +229,15 @@ nand_controller: nand-controller@2000 {
 			reg-names = "nand", "nand-int-base";
 			status = "disabled";
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "nand";
+			interrupt-names = "nand_ctlrdy";
+			brcm,nand-use-wp = <0>;
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
+			};
 		};
 
 		serial@4400 {
diff --git a/arch/arm/boot/dts/broadcom/bcm63148.dtsi b/arch/arm/boot/dts/broadcom/bcm63148.dtsi
index 24431de1810e..6ecd530a7225 100644
--- a/arch/arm/boot/dts/broadcom/bcm63148.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm63148.dtsi
@@ -119,5 +119,22 @@ hsspi: spi@1000 {
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
+			brcm,nand-use-wp = <0>;
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm63178.dtsi b/arch/arm/boot/dts/broadcom/bcm63178.dtsi
index 3f9aed96babf..742991fc7544 100644
--- a/arch/arm/boot/dts/broadcom/bcm63178.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm63178.dtsi
@@ -129,6 +129,23 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			brcm,nand-use-wp = <0>;
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm6756.dtsi b/arch/arm/boot/dts/broadcom/bcm6756.dtsi
index 1d8d957d65dd..0f08b99d93c2 100644
--- a/arch/arm/boot/dts/broadcom/bcm6756.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm6756.dtsi
@@ -139,6 +139,23 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			brcm,nand-use-wp = <0>;
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm6846.dtsi b/arch/arm/boot/dts/broadcom/bcm6846.dtsi
index cf92cf8c4693..856fd2352cca 100644
--- a/arch/arm/boot/dts/broadcom/bcm6846.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm6846.dtsi
@@ -119,5 +119,22 @@ hsspi: spi@1000 {
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
+			brcm,nand-use-wp = <0>;
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm6855.dtsi b/arch/arm/boot/dts/broadcom/bcm6855.dtsi
index 52d6bc89f9f8..ad6f63a92c3a 100644
--- a/arch/arm/boot/dts/broadcom/bcm6855.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm6855.dtsi
@@ -129,6 +129,23 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			brcm,nand-use-wp = <0>;
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm6878.dtsi b/arch/arm/boot/dts/broadcom/bcm6878.dtsi
index 2c5d706bac7e..540aac1b82f9 100644
--- a/arch/arm/boot/dts/broadcom/bcm6878.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm6878.dtsi
@@ -120,6 +120,23 @@ hsspi: spi@1000 {
 			status = "disabled";
 		};
 
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			brcm,nand-use-wp = <0>;
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
+			};
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/broadcom/bcm947622.dts b/arch/arm/boot/dts/broadcom/bcm947622.dts
index 93b8ce22678d..22e3c4508e1a 100644
--- a/arch/arm/boot/dts/broadcom/bcm947622.dts
+++ b/arch/arm/boot/dts/broadcom/bcm947622.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm963138.dts b/arch/arm/boot/dts/broadcom/bcm963138.dts
index 1b405c249213..450289d47dc7 100644
--- a/arch/arm/boot/dts/broadcom/bcm963138.dts
+++ b/arch/arm/boot/dts/broadcom/bcm963138.dts
@@ -29,3 +29,7 @@ &serial0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm963138dvt.dts b/arch/arm/boot/dts/broadcom/bcm963138dvt.dts
index b5af61853a07..22107d14a120 100644
--- a/arch/arm/boot/dts/broadcom/bcm963138dvt.dts
+++ b/arch/arm/boot/dts/broadcom/bcm963138dvt.dts
@@ -33,14 +33,12 @@ &serial1 {
 
 &nand_controller {
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
 };
 
 &ahci {
diff --git a/arch/arm/boot/dts/broadcom/bcm963148.dts b/arch/arm/boot/dts/broadcom/bcm963148.dts
index 1f5d6d783f09..aa08b473c7cd 100644
--- a/arch/arm/boot/dts/broadcom/bcm963148.dts
+++ b/arch/arm/boot/dts/broadcom/bcm963148.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm963178.dts b/arch/arm/boot/dts/broadcom/bcm963178.dts
index d036e99dd8d1..c0f504ac43a4 100644
--- a/arch/arm/boot/dts/broadcom/bcm963178.dts
+++ b/arch/arm/boot/dts/broadcom/bcm963178.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm96756.dts b/arch/arm/boot/dts/broadcom/bcm96756.dts
index 8b104f3fb14a..2ce998f2b84f 100644
--- a/arch/arm/boot/dts/broadcom/bcm96756.dts
+++ b/arch/arm/boot/dts/broadcom/bcm96756.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm96846.dts b/arch/arm/boot/dts/broadcom/bcm96846.dts
index 55852c229608..f4b9a07370ee 100644
--- a/arch/arm/boot/dts/broadcom/bcm96846.dts
+++ b/arch/arm/boot/dts/broadcom/bcm96846.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm96855.dts b/arch/arm/boot/dts/broadcom/bcm96855.dts
index 2ad880af2104..5c94063bceaf 100644
--- a/arch/arm/boot/dts/broadcom/bcm96855.dts
+++ b/arch/arm/boot/dts/broadcom/bcm96855.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm96878.dts b/arch/arm/boot/dts/broadcom/bcm96878.dts
index b7af8ade7a9d..910f7e125bad 100644
--- a/arch/arm/boot/dts/broadcom/bcm96878.dts
+++ b/arch/arm/boot/dts/broadcom/bcm96878.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
-- 
2.37.3


