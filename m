Return-Path: <linux-kernel+bounces-36383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADA839FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B5289E66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D0C2C7;
	Wed, 24 Jan 2024 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KcT4P2zn"
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DADBA24
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065539; cv=none; b=eKIOcXCtrvaJTK4sSZC8hA9KNiXuZAIvMSiF9IQbWAVHZVQ0HPB2Lvfoqyz3DqGhnsBiOXEwHaG5WtQyqJhgfM1AyXvIodZGTvATOLtWzKME1sbNjPQiU1Q8zWJ5cxYHNltxzcBRjYEF3pfbsTM42UVKFMs13XHiZ0MXrP68BtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065539; c=relaxed/simple;
	bh=/M5B/BiWF0FZlF7E2anBHHPqiWaqdDQtOcSnRreQsV0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTVjV1qKH5h5l5rwcG2yulIb5cEPI77KjXA8yvEsuZooFos9oUQByb09S/pikbj8WpGC2UbaSBxpC0+j6BtXduKIfrdC+b0Xg9gxQ755kaM4HqiOQKjlMCQtGuuprq7Y23F+V5PNSOCgLvI69La8Acl+fdj57xkpAefARjC8lZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KcT4P2zn; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-6e0f43074edso1137977a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706065535; x=1706670335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybV7pvMIAsaJOdsmH07LWJMa7Qdpq5l3yYOSDAPUHlc=;
        b=KcT4P2znW5HZ3yE2jlCILjNs1JgIdZoleM/s3IkGLMKudL9j7N/RXCvFTNPc+5A8YJ
         wC+mP3DJYt1kMjhTOrGVaHnJc9VoDXu0PV5JHsht6aOttrCxZjJM5Q/todZJEbEgD4aZ
         ibD6cwbO9QOgEcWVajquuLr3wAJBSMHz9xwF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065535; x=1706670335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybV7pvMIAsaJOdsmH07LWJMa7Qdpq5l3yYOSDAPUHlc=;
        b=jkBMubWHUk5y8p55S6QJDK87ncilrvEp1jJGcY8pZXMMDb24wliNjyn0b5AoBTv0/h
         Pe9B4FnH2699MPaKCpmQVH6sjm4dp+Lg/4VRV/f3Xtx1cdU7UcvUNVktDIJQf4EJV/ED
         S8Q4RpPlfMnnAyRwEhieYhKz1KbNAk+6jQycLFlD5YAihkewizwMUdxh4VWCVg8ASxYq
         lHI9F8i/spG4GZ7R7GIv/2OZF2cK4RqLasLFjNa1pZSHOHRn6jK24bOyS9iyrqoi3jje
         V8rVWl0c8Aji2RM7xDYqSzIozVOP9OSD9NDfYhOD0YSljFQ1pWQgm5CmjyYV+xLGI3Yo
         r2CQ==
X-Gm-Message-State: AOJu0YyeT7BieUkh40RyqI6B0IgsXbOuYn+P7yOduTUBpPtmu8LFZBOH
	I193PoJ6CT4YuZzBhlUxQjfuwt/+h/VtC3i4I/DT87JMfUptqlDjqcp5zzGE1Kcy4bFtbk/YNd6
	KadK3/6oKRbk/+ztcF9Tc+Yxrt9QqPg==
X-Google-Smtp-Source: AGHT+IGoQ8RVNrUCpvS1OvRHL8cARfhBaG1eIuL+ifmehV1J8yNFNd1XXc87USwGwubKJuakmBu7/2+8yAAi
X-Received: by 2002:a9d:75c9:0:b0:6dd:e134:935c with SMTP id c9-20020a9d75c9000000b006dde134935cmr957278otl.28.1706065535405;
        Tue, 23 Jan 2024 19:05:35 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id c22-20020a056830349600b006dc7502beabsm455320otu.3.2024.01.23.19.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 19:05:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: David Regan <dregan@broadcom.com>
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
Subject: [PATCH v3 03/10] arm64: dts: broadcom: bcmbca: Add NAND controller node
Date: Tue, 23 Jan 2024 19:04:51 -0800
Message-Id: <20240124030458.98408-4-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240124030458.98408-1-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
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
Changes in v3: None
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


