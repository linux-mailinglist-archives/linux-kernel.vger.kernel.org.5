Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003B37890E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjHYVzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjHYVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:54:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAAD26AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:54:48 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a76d882052so993640b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693000488; x=1693605288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUB0c4DZYSd7UHceLzlYwxM/QQKvpF3crbJF9Mw+h+4=;
        b=Bp1JMR3nDBXAuSdiGS/TTvtwjpmApNJ5gBzyXM2ziSpIGezW9zX0vSjd/CBtlI83AP
         NvO/Z7swz7c4yTJZs2K143fw+1Odzrk9eGZBcKNfXz2ntov8ZvMj53M7MQdXKedie3Yj
         YD88TA4xGYzSaq7rJJC5gnAJG19881oUiNJRWnaV8Wf5xB6t8difUAGSeOiGrPyzQwyO
         GQOgvXB0BDB2eICErJqP1DmJMpr5XUxrzZtAFZYawNtsjM7uoa6QufH3cim71I7MX16h
         SDE2CsCsEirON5bZeUf2uJUJ4KKNqKJp6/cftpIq3T/weqXOUfySW5bT6f/+Uzy4LOPK
         Gt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000488; x=1693605288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUB0c4DZYSd7UHceLzlYwxM/QQKvpF3crbJF9Mw+h+4=;
        b=MmjKuFBGPgiXAcq1ByhuG1il7Mw6Fevy4n4jO0Kb2j9Nkb1ytl9HWHAr3SwOuiwdjF
         RJ/boAQq58UGVjSf2eJikzRWZpqjtKQg1os7XbmcXr14WEBtaCmz2NMlS1hEaUCfmvts
         nrjjRZUMiFFip4k/JRXhbBVwHPB2DnkBMNV80mIBd3wYxqd62SZ72yiqUAkYjiQVrm0l
         grPdIzlQgP1s8m5XDMCCZVaFTfn4Icn4WA+1gJZbM7uumh1kqrkP9wpWIHdRZ4jfmeiH
         wYsI24uRK8jXdTUVz8Ld67MesXZfou83CV86gCPNc1L2u4glzDiTC0Nx29TPqAVSpbYS
         KEBg==
X-Gm-Message-State: AOJu0YyxRoFllfWr+Bs1bpJIIiHXV/BWVExJ2gfV7BgnsCWa+z+Z0DSH
        SzXMGrpI9+4GdWCB8UXBtB8NHg==
X-Google-Smtp-Source: AGHT+IFCzTAp+l4L9lrapiEro99Zwxcom5GGO8P4cVIZvvSLm/6u3PAR9sRa7TC9syvDW3BDOcLGbA==
X-Received: by 2002:a05:6808:1a92:b0:3a7:2690:94d5 with SMTP id bm18-20020a0568081a9200b003a7269094d5mr3592060oib.8.1693000488295;
        Fri, 25 Aug 2023 14:54:48 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id x11-20020a056808144b00b003a1ec14d8c6sm1191645oiv.23.2023.08.25.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:54:47 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: exynos: Enable USB support on E850-96 board
Date:   Fri, 25 Aug 2023 16:54:45 -0500
Message-Id: <20230825215445.28309-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825215445.28309-1-semen.protsenko@linaro.org>
References: <20230825215445.28309-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The E850-96 board has a micro-USB socket and two USB 2.0 host sockets.
The USB role (host or peripheral) is selected automatically depending on
micro-USB cable attachment state:
  - micro-USB cable is attached: USB device role
  - micro-USB cable is detached: USB host role

USB can't act simultaneously as a device and a host, because Exynos850
SoC has only one USB controller and there are no external USB
controllers on the E850-96 board. So the USB switch chip (specifically
TS3USB221A) connects SoC USB lines either to micro-USB connector or to
USB hub chip (LAN9514), w.r.t. micro-USB cable attachment state.

When USB works in the host role, Ethernet capability becomes available
too, as the LAN9514 chip (providing USB hub) also enables Ethernet PHY
and Ethernet MAC.

Dynamic role switching is done in gpio-usb-b-connector, using current
micro-USB VBUS line level as a trigger:
  - VBUS=high: SoC USB lines are wired to micro-USB socket
  - VBUS=low: SoC USB lines are wired to USB hub chip

In order to make USB host functional when the board was booted with
micro-USB cable disconnected, role-switch-default-mode = "host" is used.

One can use E850-96 board schematics [1] to figure out how exactly all
related USB hardware connections and lines reflect into corresponding
device tree definitions.

As PMIC regulators are not implemented yet, we rely on USB LDOs being
already enabled in the bootloader. A dummy regulator is provided to
"usbdrd" vdd nodes for now.

[1] https://www.96boards.org/documentation/consumer/e850-96b/hardware-docs/

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - none

 .../boot/dts/exynos/exynos850-e850-96.dts     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index 6ed38912507f..8d733361ef82 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -29,6 +29,22 @@ chosen {
 		stdout-path = &serial_0;
 	};
 
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+		vbus-supply = <&reg_usb_host_vbus>;
+		id-gpios = <&gpa0 0 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&micro_usb_det_pins>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb1_drd_sw>;
+			};
+		};
+	};
+
 	/*
 	 * RAM: 4 GiB (eMCP):
 	 *   - 2 GiB at 0x80000000
@@ -111,6 +127,20 @@ bt_active_led: led-5 {
 		};
 	};
 
+	/* TODO: Remove this once PMIC is implemented  */
+	reg_dummy: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "dummy_reg";
+	};
+
+	reg_usb_host_vbus: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_host_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpa3 5 GPIO_ACTIVE_LOW>;
+	};
+
 	/*
 	 * RTC clock (XrtcXTI); external, must be 32.768 kHz.
 	 *
@@ -172,6 +202,12 @@ key_volup_pins: key-volup-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
+
+	micro_usb_det_pins: micro-usb-det-pins {
+		samsung,pins = "gpa0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
 };
 
 &rtc {
@@ -186,6 +222,28 @@ &serial_0 {
 	pinctrl-0 = <&uart1_pins>;
 };
 
+&usbdrd {
+	status = "okay";
+	vdd10-supply = <&reg_dummy>;
+	vdd33-supply = <&reg_dummy>;
+};
+
+&usbdrd_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	role-switch-default-mode = "host";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
+};
+
+&usbdrd_phy {
+	status = "okay";
+};
+
 &usi_uart {
 	samsung,clkreq-on; /* needed for UART mode */
 	status = "okay";
-- 
2.39.2

