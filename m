Return-Path: <linux-kernel+bounces-30291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADEB831CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2601F21B41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187224A10;
	Thu, 18 Jan 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="JBqc4zqY"
Received: from egress-ip12a.ess.de.barracuda.com (egress-ip12a.ess.de.barracuda.com [18.184.203.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377A1E520
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.184.203.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592167; cv=none; b=CpdZ3zB1EeV5XtD0w8Z++P5JFo2dlfCLa5eAaPXUloeQbXLJerlxaXRvA1Xz/R57m2vR0FtnnUDhP/jnsF8nMqC3yU790ktWaUwoWUu92TYek9aUEJEELRDk0LtNVSCdpBroHy4tuODxqcRTki1nfI1/5iZW2iAYl7BSy1mnY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592167; c=relaxed/simple;
	bh=Ifr8E2oufJGKchMykBY9+g7aZvjezVWdwiSM4W1xHbk=;
	h=Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 Received:From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BESS-ID:X-BESS-VER:
	 X-BESS-Apparent-Source-IP:X-BESS-Parts:X-BESS-Outbound-Spam-Score:
	 X-BESS-Outbound-Spam-Report:X-BESS-Outbound-Spam-Status:
	 X-BESS-BRTS-Status; b=FdOGkPoPc8bBdGileJumM6N8Rc+Ooijk1nfJJDLNgiUdvh0frrCpwZMypqd4Yc5b66fJurz5HrcEfIjz+g+Aq2EYkBlTYbbAS39SaQjVcC9Uz11BFYhZwuYh6y9I6dO7spZwGgIz6mwpBaPN0tppMsQ9hTGWJz1voi0rMX89tt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=JBqc4zqY; arc=none smtp.client-ip=18.184.203.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200]) by mx-outbound40-32.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 18 Jan 2024 15:36:02 +0000
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d6f0b3de01so13990325ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1705592161; x=1706196961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsidD247MlOveZe6z0oTPZMJTm+NPsyrRqiMMm2tdIU=;
        b=JBqc4zqYB3RvKb7WBcF3ElknzDG1PZ5UNR8UwPQU0KBZIcne32Xh7pyRZWUJtk7K/O
         3TepBW5EzLCvtnUnXq8qOrgjIqgngXBWuqzIZ4z7tpa6eQIRj5SbbtkIhT94wBbooRoZ
         /ppB2fIihDfvHtQkhAmi8ix33ba8S90oiv648=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705592161; x=1706196961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsidD247MlOveZe6z0oTPZMJTm+NPsyrRqiMMm2tdIU=;
        b=gGRJMeRuWRoRd+M6HLH0vJWCtVmhAaRHkJ4TSJho2cGwNT+uPvx5h5LEx1egDXh4/w
         pUKVbdsHh7+qksD1moVIVFD8l2sZT3ShH5kObpo/w0KeOX5TPbswATpG760y7NOKKXn4
         S3DCSQBI5c2eA5kgNdf+wGg5DXEIku4APmftUKEZNo7FxF/4sgQblvJeRQ641C1rmMTT
         3/HG1tXVFvNowI2s46egaNm21TbnIP4b61/8nYFgF1BHjiSA+zyH4rPWn8tfOsR61YJ0
         2IatqX/4doVhscTFCA2lDtQwM9KSghGi2L7mn0dhUsl5YAj1K9y2GFo0GCDS7iysKEfd
         DucQ==
X-Gm-Message-State: AOJu0YzKfLPLO2mqwKZ33WEXJ/Ehrqje2k2hc5RUUHZ50XopgRWio0Gh
	x/3WiI0RVB3T5c/Q5hw2csH5M+YXQUky7PSICv1NekEHdzdvzrm30us2txNs1KhHxIZzceTi5e8
	O6DB3FK85m2O/Sm5yYLkLqm92CfGhzlFAr3Fp3feWVxw3Qs1iBBeBug5xGm4c14xWcfnY2jBJJc
	Qx51LYzpKQxKSAZVtODYCz
X-Received: by 2002:a17:902:8c8a:b0:1d6:f1cb:7a95 with SMTP id t10-20020a1709028c8a00b001d6f1cb7a95mr996806plo.57.1705592161032;
        Thu, 18 Jan 2024 07:36:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1N6+Ujn+w8UVBkZ1EV2KSVM8fQeMcOeMJJDl5KrOUVoSdclCmcI0wvbfECLkpcqTISVUZdQ==
X-Received: by 2002:a17:902:8c8a:b0:1d6:f1cb:7a95 with SMTP id t10-20020a1709028c8a00b001d6f1cb7a95mr996792plo.57.1705592160742;
        Thu, 18 Jan 2024 07:36:00 -0800 (PST)
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d0ca40158dsm1535207plb.280.2024.01.18.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:36:00 -0800 (PST)
From: sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-kumar1@ti.com,
	sabiya.d@mistralsolutions.com,
	Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am69-sk: Add support for OSPI flash
Date: Thu, 18 Jan 2024 21:05:24 +0530
Message-Id: <20240118153524.4135901-3-sabiya.d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118153524.4135901-1-sabiya.d@ti.com>
References: <20240118153524.4135901-1-sabiya.d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1705592161-310272-12402-6103-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 209.85.214.200
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIysjQ2BrIygIIphskWlmmJ5o
	mmlqmJFqkWqUZGiYlJ5gbm5ilpFqmWlkq1sQAb1Lx9QQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253601 [from 
	cloudscan10-163.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, NO_REAL_NAME, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 SK has S28HS512T OSPI flash connected to MCU OSPI0.
Enable support for the same. Also describe the partition
information according to the offsets in the bootloader.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 81 +++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index feb571a5a0f5..f368105942eb 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -474,6 +474,25 @@ J784S4_IOPAD(0x09C, PIN_OUTPUT, 0) /* (AF35) MCAN7_TX */
 	};
 };
 
+&wkup_pmx0 {
+	bootph-all;
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
+			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B33) MCU_OSPI0_D0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B32) MCU_OSPI0_D1 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (C33) MCU_OSPI0_D2 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (C35) MCU_OSPI0_D3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D33) MCU_OSPI0_D4 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
+			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
+		>;
+	};
+};
+
 &wkup_pmx2 {
 	bootph-all;
 	pmic_irq_pins_default: pmic-irq-default-pins {
@@ -1073,3 +1092,65 @@ &main_mcan7 {
 	pinctrl-0 = <&main_mcan7_pins_default>;
 	phys = <&transceiver4>;
 };
+
+&ospi0 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+
+	flash@0 {
+		bootph-all;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+};
-- 
2.34.1


