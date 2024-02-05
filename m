Return-Path: <linux-kernel+bounces-53896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EFC84A7CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60BD1C27A74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD712EBE5;
	Mon,  5 Feb 2024 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="DRjiCzpX"
Received: from egress-ip12b.ess.de.barracuda.com (egress-ip12b.ess.de.barracuda.com [18.185.115.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0C12EBC2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163701; cv=none; b=tqnhEWLBKJKitS4ZSxqv8nYEXcgQ4tNt+UkPtdF1HwIXF5F19AaLVYyYZsKTy3feebya8g58mqXWbXoGdxFbsUamyXiUm7DvNPQK4W3u89IBIxjY39rxMpEC4oMia/tOnY3VvfwwRT8DuAEj521hdTJHOsEAgIKlSPcTUPfZm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163701; c=relaxed/simple;
	bh=v5QWEXnfFbNjZVL+Z6j+gkDsA0PJUzacT9xN72IKzMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7dRp91giywhKYNZQl/85E+/GOglAOeKMcduUi1IpBV0qcP1sV+ZyTlKBRgWYLDinQShkVwMPRXQclpyLksN978b/g3dN4R6tDHtTdnchEyerrQzq7NZpIbM/hqxr1Vm1IvYRNsAqRuRFriEAOFArXGYIoClF8WOLXgJcl2Gqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=DRjiCzpX; arc=none smtp.client-ip=18.185.115.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197]) by mx-outbound16-171.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 05 Feb 2024 20:08:17 +0000
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d9ce440846so5699915ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1707163696; x=1707768496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbMYquCJ21TuxOyccTY96oPdcw1GObLB4bxG4242sRo=;
        b=DRjiCzpXl/MaqgNQgyWcvfb/GYU4pWnWSiGDVTM6Ob84/HeFVxGiSM1ff/JDAaRxpP
         8M1IhNSX6RSKLOhmet2wKz2Mbtfl/Gm0OnN6uEMpcRpK1dyuuL9sQCzEvaZN9jMP/GQU
         8+VeJoxoJ74raLqLo6vXZEi7PAcP9eFPHkZ+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707163696; x=1707768496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbMYquCJ21TuxOyccTY96oPdcw1GObLB4bxG4242sRo=;
        b=qQEc7mFcrLjJM1VFHKvFkSTIvcy3FoqGIsWEH5CcgUJZGvCq1aYJci4DNJfjQ9hlx2
         JE7B3NaT3X4yz6v0679HW0f7kbJUWT3BDVKWq1o54LqPKrYkMcxCiBMUI83kiuERUFet
         NhRiLhwnY6h33wqLM4Ewp82jrDJSdDVWnh3L/IFGG6NiYryHvEsmK8+r0IdBTKai2oAU
         Q+P/tuBKA/yZ0Wo3K7J+EHP7OmkeoEG7Vub2BBEqEdw+34kbqAinwXmbsgm4x5SdAP69
         LeZp4o4etw2pn5y2hYh+4S6QLotlWTSH/ceCsmn9wPew+YAqziGgInD5mnU5Ucuas62g
         vang==
X-Gm-Message-State: AOJu0YzsOvevjNOJ+eaS+pq96BHWaAaX7EKwL1xPs9KVBgHwO4eKg9Cx
	FGhzh4OVPkrk/aQuiD2kUQ/0X5CdgRh7BZWwG/PsJW/OvsHbSSkvUA71p1a+RR5jDqQr72Ctodf
	qA0FQCMcN0OaKR9UKOcuO38FXNvX157fAseeJ5oZdX9P0GdBT8iP6YcRui/k10sulGnbDwzk8zE
	apo//x7J1GzyiOODTc58e+
X-Received: by 2002:a17:902:e74e:b0:1d9:5cfd:2bd7 with SMTP id p14-20020a170902e74e00b001d95cfd2bd7mr633248plf.5.1707163695982;
        Mon, 05 Feb 2024 12:08:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjxY2AiCSar2ap9svejpZO+j5cARILTz/QbBetpsHPWX8pey7CnWMsb82XeYhEvO/5TVXG6w==
X-Received: by 2002:a17:902:e74e:b0:1d9:5cfd:2bd7 with SMTP id p14-20020a170902e74e00b001d95cfd2bd7mr633225plf.5.1707163695670;
        Mon, 05 Feb 2024 12:08:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2hdDQGIjxqVEu0RCu+wPxiHOkdFG7hNo5mimjUljY1E9P1wF/PVcoK5VWmgICVD4too4MvohmPqFOQ2GePThJ+/vt1dEwJyPD4s+g2nGfN+rnqkCt9K397plMLNMSo4J7mEiha33DnahqlaqC5LSwgMETpSluizqF6WaOASyReKj4UEYp15KozZP6kqCUbdoHes5FXiyxMKSVdO/1i1mtFXLH5QYtLfSjzPScVTgiiPTX28zDmzPKFIWRlH3S2A36I+7kGg7vWo43Y8UK5dDeNRrAPpAifOZqXU4A/WS7ZqCvGI3tTa9hsuw8Uz3sh31aH+P7B+o7cwha0ALX6YwSVu4=
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id t21-20020a170902dcd500b001d739667fc3sm263900pll.207.2024.02.05.12.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:08:15 -0800 (PST)
From: sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	u-kumar1@ti.com,
	sabiya.d@mistralsolutions.com,
	Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH V2 1/2] arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
Date: Tue,  6 Feb 2024 01:37:42 +0530
Message-Id: <20240205200744.216572-2-sabiya.d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205200744.216572-1-sabiya.d@ti.com>
References: <20240205200744.216572-1-sabiya.d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1707163696-304267-12419-35371-1
X-BESS-VER: 2019.1_20240201.2150
X-BESS-Apparent-Source-IP: 209.85.214.197
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIysjSxALIygIJJycaJBslmFm
	ZJyabmBqlGiSnGaUbGqQYpxommRgYWpkq1sQAPbUbmQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254009 [from 
	cloudscan20-102.eu-central-1b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO, NO_REAL_NAME
X-BESS-BRTS-Status:1

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 SK board has several CAN bus interfaces on both MCU and MAIN domains.
This enables the CAN interfaces on MCU and MAIN domain.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 81 +++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 8da591579868..64c737cc3d49 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -321,6 +321,31 @@ tfp410_out: endpoint {
 			};
 		};
 	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver3: can-phy2 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver4: can-phy3 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
 };
 
 &main_pmx0 {
@@ -429,6 +454,20 @@ hdmi_hpd_pins_default: hdmi-hpd-default-pins {
 			J784S4_IOPAD(0x000, PIN_INPUT, 7) /* (AN35) EXTINTN.GPIO0_0 */
 		>;
 	};
+
+	main_mcan6_pins_default: main-mcan6-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x098, PIN_INPUT, 0) /* (AH36) MCAN6_RX */
+			J784S4_IOPAD(0x094, PIN_OUTPUT, 0) /* (AG35) MCAN6_TX */
+		>;
+	};
+
+	main_mcan7_pins_default: main-mcan7-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0A0, PIN_INPUT, 0) /* (AD34) MCAN7_RX */
+			J784S4_IOPAD(0x09C, PIN_OUTPUT, 0) /* (AF35) MCAN7_TX */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -525,6 +564,20 @@ hdmi_pdn_pins_default: hdmi-pdn-default-pins {
 			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 7) /* (H37) WKUP_GPIO0_14 */
 		>;
 	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (F38) MCU_MCAN0_RX */
+			J784S4_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (K33) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (K36) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0)/* (H35) WKUP_GPIO0_4.MCU_MCAN1_TX */
+		>;
+	};
 };
 
 &wkup_pmx3 {
@@ -992,3 +1045,31 @@ dp0_out: endpoint {
 		};
 	};
 };
+
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan6 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan6_pins_default>;
+	phys = <&transceiver3>;
+};
+
+&main_mcan7 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan7_pins_default>;
+	phys = <&transceiver4>;
+};
-- 
2.34.1


