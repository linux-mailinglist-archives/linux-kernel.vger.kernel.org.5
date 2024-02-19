Return-Path: <linux-kernel+bounces-71177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A185A1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13321B2261D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A92C192;
	Mon, 19 Feb 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="B1sGT3CM"
Received: from egress-ip12a.ess.de.barracuda.com (egress-ip12a.ess.de.barracuda.com [18.184.203.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F423775
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.184.203.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341294; cv=none; b=VkaOjzJhrxA30aEITrOug7UFi34w7nAKbScpUY4P5t8t6cYiukPZXSLH0y+ZokEtoHc5F0TJwwW8k+vmV9H8W9Q39YBy73ExXh5K+3iQYVNpr2Y5fmUu70x3/RJp6vtUa7DStmmuaOgQ6+Rnx4vavnTFR/cj95QIE6EZoCiMJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341294; c=relaxed/simple;
	bh=O99tFj8pg2SEbucwpfZS/VZ+NyGC4GYhc3djletH83A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NdzOqAneYTuvCf4Wg/OpAXk/Cz+0Cgr1n/vROO9cbahp8nHmRCJ/yoBoBC8oUMspYNcNoco0RonwFbapeE5t4TH2mh7c9+uj82HCR+hZdyGCi2nyzhxcz8lVnr34N+jo1c8qYdE79PX/cH0o5i2E25F+Y+ltRb7ktT5phjArdgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=B1sGT3CM; arc=none smtp.client-ip=18.184.203.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70]) by mx-outbound14-174.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 19 Feb 2024 11:14:49 +0000
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2992c1d4e7fso1709435a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1708341288; x=1708946088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpdw0KJiz8mlHnSoHzcj3+lieIii8B37Aca6mVzGbBE=;
        b=B1sGT3CMh2ynAmLMU9TdWNZw4eVdxegKEjxRVjdvb4odebTaCZEjwWlE7aBM5qke0n
         vpruSUJUa3o7G40BU8ByH5awAIsazdxQ7VpC/WkEC8FqJ/IWSUJPWAPST2BGG2mW93yr
         xtnKqmQASEoQmTmGxvmQpkL/eNnuTsHiunYRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341288; x=1708946088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpdw0KJiz8mlHnSoHzcj3+lieIii8B37Aca6mVzGbBE=;
        b=hLcMMVtoiuBLyXop9JGSONMleHb+TWfa6XacvDJVfryt1S0ovCgoWg1+Nud2A5DbQE
         Jc5NFtbI38m1ucXxVD1iEHJtfyAjBjLc+eOs2IPqgGyvIsbAbVgWy7CCwbhooz/ul9qy
         ULd+cH+1l0Ri9W2fx//J3nQn0lWOsAf1NYqNxxPV+/B2uKY/NhQcwxeZCxscfi0X+db4
         5VkCQv8Dp+CN+nzCH0/+BWOAiiGL/1/DnQTXzmxIEzsrF3R6fDJY4soqY5Iu55w4bzU5
         /mmzErOTa9cHsjuzWHUjg1G8DK7KBmW9jtQiJbZD0sMCIdZokpHTeTouEJaZaNh0oiVj
         MFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAkucHa2sfHS+yeqNyCbRUauLNVec40OD2cYemyk1IaGFa/t6nNzrvtEqxwLUxDWK4g8U5SxN0AeCZsPKOZMVmmvxPzhKDw+Sk7VVM
X-Gm-Message-State: AOJu0YwWq3zCmKY0qZCg4tZh5rgc09xj22Btmbtez1TkdqnyInK98Pct
	hvKe4P9cfpLng83gR+kfL6PC1MDzm2l1b87Q1mZTB9o18QTiMdNLxmUcHcZD5W/vbjHk+VjsgI3
	nbo5ocOpyMjRwAUpyvcIKDvnoCfANnKLtL4Z6Nq/hqLSKcB41sqfpikCEqY4cowUXL8kQL0/NJA
	Bjc0vcrSC5+cBn76ftEs8i
X-Received: by 2002:a17:90a:fb51:b0:299:5ebb:1edb with SMTP id iq17-20020a17090afb5100b002995ebb1edbmr2863971pjb.26.1708341288542;
        Mon, 19 Feb 2024 03:14:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF27U5miBr3X9K67xhG+3dINjoOqRZbr2/ahKiFk3Rf4DVRe/+rTBu+GJWrEpCYtJIdo47GCg==
X-Received: by 2002:a17:90a:fb51:b0:299:5ebb:1edb with SMTP id iq17-20020a17090afb5100b002995ebb1edbmr2863953pjb.26.1708341288243;
        Mon, 19 Feb 2024 03:14:48 -0800 (PST)
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id cq15-20020a17090af98f00b00299947ed2efsm2343878pjb.2.2024.02.19.03.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:14:47 -0800 (PST)
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
Subject: [RESEND PATCH V2 2/2] arm64: dts: ti: k3-am69-sk: Add support for OSPI flash
Date: Mon, 19 Feb 2024 16:44:22 +0530
Message-Id: <20240219111422.171315-3-sabiya.d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111422.171315-1-sabiya.d@ti.com>
References: <20240219111422.171315-1-sabiya.d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1708341289-303758-12431-284-1
X-BESS-VER: 2019.1_20240214.1700
X-BESS-Apparent-Source-IP: 209.85.216.70
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIysjQxBLIygIKJKYbGFolmlk
	apSSkmhqkWFuZJFqbmiaapyZampsmpKUq1sQClBPINQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254323 [from 
	cloudscan20-10.eu-central-1b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=NO_REAL_NAME, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
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
index 0ff4d1623cf4..acda25a9e814 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -471,6 +471,25 @@ J784S4_IOPAD(0x09C, PIN_OUTPUT, 0) /* (AF35) MCAN7_TX */
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
@@ -1070,3 +1089,65 @@ &main_mcan7 {
 	pinctrl-0 = <&main_mcan7_pins_default>;
 	phys = <&transceiver4>;
 };
+
+&ospi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+
+	flash@0 {
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
+			bootph-all;
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
+				bootph-pre-ram;
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+};
-- 
2.34.1


