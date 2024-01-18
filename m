Return-Path: <linux-kernel+bounces-30328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DC2831D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AF21F23A65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC082C183;
	Thu, 18 Jan 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="h0qzl+fo"
Received: from egress-ip12a.ess.de.barracuda.com (egress-ip12a.ess.de.barracuda.com [18.184.203.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F32941E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.184.203.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593826; cv=none; b=udT8iwtjCVSrcq+/EHErEI9eG41MuDQ+AIXy310LvUMDvTSn2OxOQJAK5QbBNCj4zpr59nVna3NS98kw4NzDWtcOadoLBQtKo/pMmBpsUZMrdmUug5yMv+ocXgvjh8fHNt7ySw+OzUQgTQjEi/X+e+DuDBRwPA9Wnf85JGek4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593826; c=relaxed/simple;
	bh=NEvsqNcy1kk1E2eUgHvNmgVuqu13eTY8fYpJTsaIAa0=;
	h=Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 Received:From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BESS-ID:X-BESS-VER:
	 X-BESS-Apparent-Source-IP:X-BESS-Parts:X-BESS-Outbound-Spam-Score:
	 X-BESS-Outbound-Spam-Report:X-BESS-Outbound-Spam-Status:
	 X-BESS-BRTS-Status; b=iItZAPr4qhl3oukp3nDHeUcMerTWza8EncfOezvqfoyOHiBq9NBGjRBT/lezYSyNex5DV7HJ6roFBy2ehTfQVNxcwTKYo/lZlHBcQhnPU7+tewuEjCE9DLZfbZP6tmK2f9t6ictxCJySP5sTPfSp2011ALXdVNdGq0k/ZPaWIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=h0qzl+fo; arc=none smtp.client-ip=18.184.203.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69]) by mx-outbound14-230.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 18 Jan 2024 16:03:42 +0000
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7d2d288e20eso181646241.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1705593821; x=1706198621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1DYWTNQzjv4vI2x8NFQ6Ufsk1e759AfKRqvQ1Oet2c=;
        b=h0qzl+fobjlW9guFi2HNJLz2jAMOh+Mi+gJnWWsnch3koQm21k29sDGGJEAYV5gWYy
         DDGUzvhtSeUje6TvwZyXUvlSHIh7ogIHsxAEPm7Fr9eAsOCGr72jRZhItn5YWem7Nu2y
         IPvMlQBOg6/abuOmTZVXVox+dhV8RKPxp4JjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593821; x=1706198621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1DYWTNQzjv4vI2x8NFQ6Ufsk1e759AfKRqvQ1Oet2c=;
        b=GHgcFvRX6l/1Fy2wS2s7/cpedteQiZ334QXraC8VWLa++u13pAkOskN23z+yOHhfh/
         rACVjJxZWta6IXgz1+y+/rMMdZQ6Q3lplS/ftaJzUNAZ/oPADGCwRUm0MoJSiFHxx5Ro
         Wo34qc8KMM21+JY3Kf6jcBNuYCA6ApOZb58UYAEvqf0SVGQX17o2mDwPEUzd6h3uuVO2
         eF05ZZQBOabUfER/a48W9/IhhvxUztbmulhB1s96n//iM+e/OsleMQhYfm/L9rOsSryJ
         CnnKwz2/B/Hgh37WiGQBS5CUWmuNd1LcbZS2KDw6WnIuquTqxZWSelD1SF9pAlSZ9+SK
         dE/A==
X-Gm-Message-State: AOJu0YwXdU3qSU/IJnQZ20qiReyMrXpYYB3XQebb7J/p9pJnBgluT9oB
	fu47GS+c+ZA2CZPo/1JslF0UoIvqBQIXiehNXUBXHh2eqZtEjgbWXUoG58vDB0fOYRqDvtM18A0
	aWxd8Uw/eNHYoObv4kh8ZbmR80eMMOqlKibx69jWOOia3TyFq5K+mdYXSxC49GlM+Nqmwb3JQrB
	1GzWnK0qZdE+C/JMXV4QmB
X-Received: by 2002:a17:902:6bca:b0:1d7:193f:3183 with SMTP id m10-20020a1709026bca00b001d7193f3183mr63970plt.49.1705592156874;
        Thu, 18 Jan 2024 07:35:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/u1sqSi9N169ypk1ps7gSSqx41OCFy/68ybbofAG5znrEfbQLEgOCzJNDfjAkobpgkuJ8/A==
X-Received: by 2002:a17:902:6bca:b0:1d7:193f:3183 with SMTP id m10-20020a1709026bca00b001d7193f3183mr63946plt.49.1705592156548;
        Thu, 18 Jan 2024 07:35:56 -0800 (PST)
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d0ca40158dsm1535207plb.280.2024.01.18.07.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:35:56 -0800 (PST)
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
Subject: [PATCH 1/2] arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
Date: Thu, 18 Jan 2024 21:05:23 +0530
Message-Id: <20240118153524.4135901-2-sabiya.d@ti.com>
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
X-BESS-ID: 1705593821-303814-12447-9389-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 209.85.222.69
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNjQ3ALIygIJGKamJliZp5g
	ZmqUapKQamiUZGJokpxslpBqnJ5iYWKUq1sQCeQUMUQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253602 [from 
	cloudscan16-108.eu-central-1b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, NO_REAL_NAME, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 SK board has several CAN bus interfaces on both MCU and MAIN domains.
This enables the CAN interfaces on MCU and MAIN domain.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 85 +++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 370980eb59b0..feb571a5a0f5 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -29,6 +29,10 @@ aliases {
 		i2c0 = &wkup_i2c0;
 		i2c3 = &main_i2c0;
 		ethernet0 = &mcu_cpsw_port1;
+		can0 = &mcu_mcan0;
+		can1 = &mcu_mcan1;
+		can2 = &main_mcan6;
+		can3 = &main_mcan7;
 	};
 
 	memory@80000000 {
@@ -321,6 +325,31 @@ tfp410_out: endpoint {
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
@@ -429,6 +458,20 @@ hdmi_hpd_pins_default: hdmi-hpd-default-pins {
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
@@ -525,6 +568,20 @@ hdmi_pdn_pins_default: hdmi-pdn-default-pins {
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
@@ -988,3 +1045,31 @@ dp0_out: endpoint {
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


