Return-Path: <linux-kernel+bounces-30534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CFB831FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813991F2642A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD42E85D;
	Thu, 18 Jan 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FH5u5h5y"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1312E82F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607670; cv=none; b=YAmSgHNz2+f8WEYuplx59D6AxpJAOWAoc3kOIjjc12V+PYJpOeQru+LiATCNQRaBPwgsCzeyiYL6l7lH6pM9FpQMSyPcfsCQd0sf7BHhU27yNwKmzfpu5LaMyObGOJyARXCqG7+a0frBLxJPg/RJPOOy0YM+z8p3wagg1t+Z4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607670; c=relaxed/simple;
	bh=A8pZWk1xCi23z0QMV0IQEIUij4yapHl+cGa+pujskUE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTA906ttwe8sM+SHmB3ZEy+MZ1nuEgkccxndBymHwBY4rC8R1O4doFuQgRaxyYLHgrV6kxT1gIeHfpGRzPpC3zn89fxxC6Uh9RfaEySYCaQSUAYaPH1YcXOHZvA8qJ54lFkFSpZTRwLypg7tvub7Y94amA0howFJc6+nSYJmfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FH5u5h5y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d70b0e521eso6511565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607668; x=1706212468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hDcE9X5TULuB647AhqBvpK0WvuIC7BaHkURSvG7o60=;
        b=FH5u5h5yVr2Eq/i9SRdUGbjSRpuqHUemkkxUqFq34QVZzdXas5KTSlTOmBKziJY6zP
         Lnk4tU/yY/mo7pFlmYWYYmYbWCGO//7HcwJ4xZRKJfaBXatDTw9Kl3n2fADkL4O26JAf
         oDqz4etUFGRcQLFTCj+tt3/miYyUHIl+R0mCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607668; x=1706212468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hDcE9X5TULuB647AhqBvpK0WvuIC7BaHkURSvG7o60=;
        b=Lw2fr5fpVEMkdHRcsCdFc+AusU6/GMp33GVmrBqJeB1Wv6Kyx858jGB9Rsg6+cuo8S
         SqWwGWgcEvn5RuFoAC8plar1fMiXxYfyE72Vm5/tJYGUrMjb4RLXjSqSVljwUAIR/La1
         WXb1YM6AYTigrzUFC1YaM5EO/geRGjm4X7F8QeioEZuBLc6sD1LUvGTTKDqCHRwSCoq/
         q8n82N/tds+r0OqJIt/57j0rj4z9x3rvuFUsJrwVckurm5XjRx5kFWhSAqN4wP0InrCe
         RdDLGDhF577cZTkDQqN3JqWyXBLRXYYPgpSGYW2EZwAMSGee8aKm+ALli1hygQsNQwTt
         VIJw==
X-Gm-Message-State: AOJu0YzVZsRjy+TFcquHHGQgg9l8wjD2dQUtJACitmmG/iXHaHen4g6c
	MDKyI/L0avyYTpxS+HAOCVOo2TpXNCnNp54bJ+lobGv2iA+VgWRrZKylNbacyA==
X-Google-Smtp-Source: AGHT+IGGw4SKESvl3UhBCttzEHwT8TIeVCYclrj8MzDyiyhnEgfTOVt4tgOxdY5pwMLXEkwz/tom5g==
X-Received: by 2002:a17:902:6b01:b0:1d5:c398:efa2 with SMTP id o1-20020a1709026b0100b001d5c398efa2mr1226528plk.110.1705607667872;
        Thu, 18 Jan 2024 11:54:27 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:27 -0800 (PST)
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
Subject: [PATCH v2 03/10] arm64: dts: broadcom: bcmbca: Add NAND controller node
Date: Thu, 18 Jan 2024 11:53:49 -0800
Message-Id: <20240118195356.133391-4-dregan@broadcom.com>
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

Add support for Broadcom STB NAND controller in BCMBCA ARMv8 chip dts
files.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
---
Changes in v2:
- Add nand controller node label for 4908 so it is consistent with other
SoCs and can be referenced by board dts file
---
 .../arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi |  5 ++++-
 .../arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi | 17 +++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm63146.dtsi      | 17 +++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi      | 17 +++++++++++++++++
 .../arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi | 17 +++++++++++++++++
 .../arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi | 17 +++++++++++++++++
 .../arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi | 17 +++++++++++++++++
 .../arm64/boot/dts/broadcom/bcmbca/bcm94912.dts |  4 ++++
 .../boot/dts/broadcom/bcmbca/bcm963146.dts      |  4 ++++
 .../boot/dts/broadcom/bcmbca/bcm963158.dts      |  4 ++++
 .../arm64/boot/dts/broadcom/bcmbca/bcm96813.dts |  4 ++++
 .../arm64/boot/dts/broadcom/bcmbca/bcm96856.dts |  4 ++++
 .../arm64/boot/dts/broadcom/bcmbca/bcm96858.dts |  4 ++++
 13 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index 2f124b027bbf..03a516d02501 100644
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
@@ -597,11 +597,14 @@ nand-controller@1800 {
 			reg-names = "nand", "nand-int-base";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nand_ctlrdy";
+			brcm,nand-use-wp = <0>;
 			status = "okay";
 
 			nandcs: nand@0 {
 				compatible = "brcm,nandcs";
 				reg = <0>;
+				nand-on-flash-bbt;
+				brcm,nand-ecc-use-strap;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
index d658c81f7285..92a829542467 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
index 4f474d47022e..2283fd81ece6 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
@@ -119,6 +119,23 @@ hsspi: spi@1000 {
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
index 909f254dc47d..c70177066a15 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
@@ -137,6 +137,23 @@ hsspi: spi@1000 {
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
index 685ae32951c9..09115e3af694 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
index 820553ce541b..03ed65b35dbc 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
index 0eb93c298297..36f1fc06fcec 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
@@ -156,5 +156,22 @@ hsspi: spi@1000 {
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
index e69cd683211a..4d1ea501e384 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
index db2c82d6dfd8..810b5a23da7b 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
index 25c12bc63545..3aaae5dbb568 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
index faba21f03120..6b167cc2af76 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
index 9808331eede2..d598cd618b57 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
@@ -32,3 +32,7 @@ &uart0 {
 &hsspi {
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
index 1f561c8e13b0..e50ddbf6f58c 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
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


