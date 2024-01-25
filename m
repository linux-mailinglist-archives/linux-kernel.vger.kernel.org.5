Return-Path: <linux-kernel+bounces-39302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D96983CE72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38E0B224C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2931713A24B;
	Thu, 25 Jan 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pwbVxcKY"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFFB13AA26;
	Thu, 25 Jan 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217819; cv=none; b=CHPMwKuZmUIFuL+GBfBdMIbiS8sajaw0eBqy2mDbNAK6PprZG564XYUhT//A0R8kB0QWnCG0Wu/cqJpDF4toqswgEO5L//hRehwDpO/ZCxo0i8ayrlHUPixnC3aWW8ZLtZtdLx6ntFrrr1X8rUSpS6Dt8i532O8Uz5EgyM02ZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217819; c=relaxed/simple;
	bh=aRAXf+IeYD+Tdyt68ZJozjh+W+lDD+N+tKEHF+GTkcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqMrnR9j5VxUrVMc3DHyBMSd750rVwBMkqGh3zGY5Ga112eHC2xEd8y8JqqT0fBMI4XkMh5OtzQhQSWxOcVZnbnO5wGB6l471L1kHl8CCzNBvQjNS1nySpdyBf5D43pMTuO5ubtX6gRHqVI6doiPCUneZi/yheChWbe0PSCv7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pwbVxcKY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PKTjl9018053;
	Thu, 25 Jan 2024 21:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=v/KudgoWCYrNVYB+9HAHhiD4XQgHnakFo3ATOQ1n6Bg=;
 b=pwbVxcKYCtaHE0KrVLAOvlxR9puLiq1JzhkKemm74tMhCRIelecVjaDgzI+0jC+ThT8I
 kKOEmsY0xpPI684X1G+f2thZDrFa2DKVHCSJOvBiuj6GT3osJ41ARH4D1e53xtYH7aUG
 KljhW3e3572/xpULgDWxp4UM1MYylYkPbk8v7tdJLlKYAi65CT5VejJeYVgHk/3ozSuJ
 XjgSjdjuTDcnyxPg2xAcw2sxYato+Awhko4Q32n9oppZFSVxAhXvYID5VXe3fDf/yGn1
 /WQWUVNKpe2AAspLIJ8Qy7b0CbpwFAYQicDhS9rnSgLTWL0DA4GjbuuO6Hx0o0/R9jRi CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuvv0v86f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:22:21 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PLMKT7027264;
	Thu, 25 Jan 2024 21:22:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuvv0v81k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:22:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40PKe4u6026485;
	Thu, 25 Jan 2024 21:22:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtq1n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:22:04 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PLM3iP49545684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 21:22:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7A765805F;
	Thu, 25 Jan 2024 21:22:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F6005805D;
	Thu, 25 Jan 2024 21:22:01 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 21:22:01 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, ninad@linux.ibm.com,
        johannes.holland@infineon.com, linux@roeck-us.net, broonie@kernel.org,
        andre.werner@systec-electronic.com
Cc: Andrew Geissler <geissonator@yahoo.com>, patrick.rudolph@9elements.com,
        vincent@vtremblay.dev, peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geert+renesas@glider.be, luca.ceresoli@bootlin.com
Subject: [PATCH v5 2/2] ARM: dts: aspeed: System1: IBM system1 BMC board
Date: Thu, 25 Jan 2024 15:21:54 -0600
Message-Id: <20240125212154.4028640-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125212154.4028640-1-ninad@linux.ibm.com>
References: <20240125212154.4028640-1-ninad@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7ek1kikcRXxF4R-H7RGW_LFjwL9i4Fwt
X-Proofpoint-GUID: 06qH0txRtRhxznRwIC9G6C5T8w18WwX8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250154

From: Andrew Geissler <geissonator@yahoo.com>

Added a device tree for IBM system1 BMC board. It uses AST2600 SOC.
- Added base board
- Added i2c devices and muxes.
- Added different voltage regulators.
- Added GPIO pin assignements, GPIO expansion devices
- Added LED blinker devices
- Added fan controllers
- Added EEPROM/VPD
- Added power supplies
- Added humidity, pressure and temperature sensors.
- Added Trusted Platform Module (TPM) chip.

Tested:
    This board is tested using the simics simulator.

Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
The compatibility string and schema for tpm device is documented in the
following patch series:
-https://lore.kernel.org/all/77fe0ccd-53ff-4773-9787-0d038434297f@linux.ibm.com/
-https://lore.kernel.org/all/3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de/

v5:
  - Corrected typos in the commit message. Review comments by Bjorn.
v4:
  - Removed the compatibility string "nuvoton,npct75x" from tpm node as
    per the Conor's review comment.
v3:
  - Fixed the voltage-regulator names.
v2:
  - Incorporated review comments from Conor Dooley, Jarkko Sakkinen,
    Guenter Roeck, Rob Herring, Krzysztof Kozlowski
    - Merge all patches into single patch.
    - Split the trivial device patch.
    - Cleanup commit messages.
    - Fixed bootargs string.
    - Fixed node names.
    - Dropped tpm schema patch as it is covered by Lukas's patch.
    - Dropped "tpm: tis-i2c: Add more compatible strings" patch and
      send it as a separate patch.
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 1623 +++++++++++++++++
 2 files changed, 1624 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 23cbc7203a8e..d551aed79286 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ibm-rainier.dtb \
 	aspeed-bmc-ibm-rainier-1s4u.dtb \
 	aspeed-bmc-ibm-rainier-4u.dtb \
+	aspeed-bmc-ibm-system1.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
 	aspeed-bmc-inspur-nf5280m6.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
new file mode 100644
index 000000000000..dcbc16308ab5
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -0,0 +1,1623 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2023 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+
+/ {
+	model = "System1";
+	compatible = "ibm,system1-bmc", "aspeed,ast2600";
+
+	aliases {
+		i2c16 = &i2c8mux1chn0;
+		i2c17 = &i2c8mux1chn1;
+		i2c18 = &i2c8mux1chn2;
+		i2c19 = &i2c8mux1chn3;
+		i2c20 = &i2c8mux1chn4;
+		i2c21 = &i2c8mux1chn5;
+		i2c22 = &i2c8mux1chn6;
+		i2c23 = &i2c8mux1chn7;
+		i2c24 = &i2c3mux0chn0;
+		i2c25 = &i2c3mux0chn1;
+		i2c26 = &i2c3mux0chn2;
+		i2c27 = &i2c3mux0chn3;
+		i2c28 = &i2c3mux0chn4;
+		i2c29 = &i2c3mux0chn5;
+		i2c30 = &i2c3mux0chn6;
+		i2c31 = &i2c3mux0chn7;
+		i2c32 = &i2c6mux0chn0;
+		i2c33 = &i2c6mux0chn1;
+		i2c34 = &i2c6mux0chn2;
+		i2c35 = &i2c6mux0chn3;
+		i2c36 = &i2c6mux0chn4;
+		i2c37 = &i2c6mux0chn5;
+		i2c38 = &i2c6mux0chn6;
+		i2c39 = &i2c6mux0chn7;
+		i2c40 = &i2c7mux0chn0;
+		i2c41 = &i2c7mux0chn1;
+		i2c42 = &i2c7mux0chn2;
+		i2c43 = &i2c7mux0chn3;
+		i2c44 = &i2c7mux0chn4;
+		i2c45 = &i2c7mux0chn5;
+		i2c46 = &i2c7mux0chn6;
+		i2c47 = &i2c7mux0chn7;
+		i2c48 = &i2c8mux0chn0;
+		i2c49 = &i2c8mux0chn1;
+		i2c50 = &i2c8mux0chn2;
+		i2c51 = &i2c8mux0chn3;
+		i2c52 = &i2c8mux0chn4;
+		i2c53 = &i2c8mux0chn5;
+		i2c54 = &i2c8mux0chn6;
+		i2c55 = &i2c8mux0chn7;
+		i2c56 = &i2c14mux0chn0;
+		i2c57 = &i2c14mux0chn1;
+		i2c58 = &i2c14mux0chn2;
+		i2c59 = &i2c14mux0chn3;
+		i2c60 = &i2c14mux0chn4;
+		i2c61 = &i2c14mux0chn5;
+		i2c62 = &i2c14mux0chn6;
+		i2c63 = &i2c14mux0chn7;
+		i2c64 = &i2c15mux0chn0;
+		i2c65 = &i2c15mux0chn1;
+		i2c66 = &i2c15mux0chn2;
+		i2c67 = &i2c15mux0chn3;
+		i2c68 = &i2c15mux0chn4;
+		i2c69 = &i2c15mux0chn5;
+		i2c70 = &i2c15mux0chn6;
+		i2c71 = &i2c15mux0chn7;
+	};
+
+	chosen {
+		stdout-path = "uart5:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		eventlog: tcg-event-log@b3d00000 {
+			no-map;
+			reg = <0xb3d00000 0x100000>;
+		};
+
+		ramoops@b3e00000 {
+			compatible = "ramoops";
+			reg = <0xb3e00000 0x200000>; /* 16 * (4 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
+		/* LPC FW cycle bridge region requires natural alignment */
+		flash_memory: region@b4000000 {
+			no-map;
+			reg = <0xb4000000 0x04000000>; /* 64M */
+		};
+
+		/* VGA region is dictated by hardware strapping */
+		vga_memory: region@bf000000 {
+			no-map;
+			compatible = "shared-dma-pool";
+			reg = <0xbf000000 0x01000000>;  /* 16M */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			gpios = <&gpio0 ASPEED_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			gpios = <&gpio0 ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-3 {
+			gpios = <&gpio0 ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-4 {
+			gpios = <&pca3 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			gpios = <&pca3 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-6 {
+			gpios = <&pca3 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-7 {
+			gpios = <&pca3 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-8 {
+			gpios = <&pca3 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-9 {
+			gpios = <&pca3 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-a {
+			gpios = <&pca3 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-b {
+			gpios = <&pca4 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-c {
+			gpios = <&pca4 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-d {
+			gpios = <&pca4 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-e {
+			gpios = <&pca4 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <1000>;
+
+		event-nvme0-presence {
+			label = "nvme0-presence";
+			gpios = <&pca4 0 GPIO_ACTIVE_LOW>;
+			linux,code = <0>;
+		};
+
+		event-nvme1-presence {
+			label = "nvme1-presence";
+			gpios = <&pca4 1 GPIO_ACTIVE_LOW>;
+			linux,code = <1>;
+		};
+
+		event-nvme2-presence {
+			label = "nvme2-presence";
+			gpios = <&pca4 2 GPIO_ACTIVE_LOW>;
+			linux,code = <2>;
+		};
+
+		event-nvme3-presence {
+			label = "nvme3-presence";
+			gpios = <&pca4 3 GPIO_ACTIVE_LOW>;
+			linux,code = <3>;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>,
+			<&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
+			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>,
+			<&adc1 4>, <&adc0 2>, <&adc1 0>,
+			<&p2v5_aux_vd 0>, <&adc1 7>;
+	};
+
+	p12v_vd: voltage-divider1 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 3>;
+		#io-channel-cells = <1>;
+
+		/*
+		 * Scale the system voltage by 1127/127 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <15>;
+		full-ohms = <133>;
+	};
+
+	p5v_aux_vd: voltage-divider2 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 5>;
+		#io-channel-cells = <1>;
+
+		/*
+		 * Scale the system voltage by 1365/365 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <50>;
+		full-ohms = <187>;
+	};
+
+	p5v_bmc_aux_vd: voltage-divider3 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 3>;
+		#io-channel-cells = <1>;
+
+		/*
+		 * Scale the system voltage by 1365/365 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <50>;
+		full-ohms = <187>;
+	};
+
+	p3v3_aux_vd: voltage-divider4 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 2>;
+		#io-channel-cells = <1>;
+
+		/*
+		 * Scale the system voltage by 1698/698 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <14>;
+		full-ohms = <34>;
+	};
+
+	p3v3_bmc_aux_vd: voltage-divider5 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 7>;
+		#io-channel-cells = <1>;
+
+		/*
+		 * Scale the system voltage by 1698/698 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <14>;
+		full-ohms = <34>;
+	};
+
+	p1v8_bmc_aux_vd: voltage-divider6 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 6>;
+		#io-channel-cells = <1>;
+
+		/*
+		 * Scale the system voltage by 4000/3000 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <3>;
+		full-ohms = <4>;
+	};
+
+	p2v5_aux_vd: voltage-divider7 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 1>;
+		#io-channel-cells = <1>;
+
+		/*
+		 * Scale the system voltage by 2100/1100 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <11>;
+		full-ohms = <21>;
+	};
+
+	p1v8_bmc_aux: fixedregulator-p1v8-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p1v8_bmc_aux";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+};
+
+&adc0 {
+	status = "okay";
+	vref-supply = <&p1v8_bmc_aux>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+		&pinctrl_adc1_default
+		&pinctrl_adc2_default
+		&pinctrl_adc3_default
+		&pinctrl_adc4_default
+		&pinctrl_adc5_default
+		&pinctrl_adc6_default
+		&pinctrl_adc7_default>;
+};
+
+&adc1 {
+	status = "okay";
+	vref-supply = <&p1v8_bmc_aux>;
+	aspeed,battery-sensing;
+
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default
+		&pinctrl_adc9_default
+		&pinctrl_adc10_default
+		&pinctrl_adc11_default
+		&pinctrl_adc12_default
+		&pinctrl_adc13_default
+		&pinctrl_adc14_default
+		&pinctrl_adc15_default>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","bmc-tpm-reset","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","bmc-ready",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","bmc-hb",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","rear-enc-fault0","rear-enc-id0",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","rtc-battery-voltage-read-enable","","power-chassis-control","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","power-chassis-good","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&pinctrl_emmc_default {
+	bias-disable;
+};
+
+&emmc {
+	status = "okay";
+	clk-phase-mmc-hs200 = <180>, <180>;
+};
+
+&ibt {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+};
+
+&vuart2 {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
+		 <&syscon ASPEED_CLK_MAC3RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>,
+		 <&syscon ASPEED_CLK_MAC4RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
+&wdt1 {
+	aspeed,reset-type = "none";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca8 0xcac>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	regulator@60 {
+		compatible = "maxim,max8952";
+		reg = <0x60>;
+
+		max8952,default-mode = <0>;
+		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
+						<1050000>, <950000>;
+		max8952,sync-freq = <0>;
+		max8952,ramp-speed = <0>;
+
+		regulator-name = "VR_v77_1v4";
+		regulator-min-microvolt = <770000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	regulator@42 {
+		compatible = "infineon,ir38263";
+		reg = <0x42>;
+	};
+
+	led-controller@60 {
+		compatible = "nxp,pca9552";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led@0 {
+			label = "nic1-perst";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@1 {
+			label = "bmc-perst";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@2 {
+			label = "reset-M2-SSD1-2-perst";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@3 {
+			label = "pcie-perst1";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@4 {
+			label = "pcie-perst2";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@5 {
+			label = "pcie-perst3";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@6 {
+			label = "pcie-perst4";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@7 {
+			label = "pcie-perst5";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@8 {
+			label = "pcie-perst6";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@9 {
+			label = "pcie-perst7";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@10 {
+			label = "pcie-perst8";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@11 {
+			label = "PV-cp0-sw1stk4-perst";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@12 {
+			label = "PV-cp0-sw1stk5-perst";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@13 {
+			label = "pe-cp-drv0-perst";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@14 {
+			label = "pe-cp-drv1-perst";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@15 {
+			label = "lom-perst";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	gpio@74 {
+		compatible = "nxp,pca9539";
+		reg = <0x74>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"PLUG_DETECT_PCIE_J101_N",
+			"PLUG_DETECT_PCIE_J102_N",
+			"PLUG_DETECT_PCIE_J103_N",
+			"PLUG_DETECT_PCIE_J104_N",
+			"PLUG_DETECT_PCIE_J105_N",
+			"PLUG_DETECT_PCIE_J106_N",
+			"PLUG_DETECT_PCIE_J107_N",
+			"PLUG_DETECT_PCIE_J108_N",
+			"PLUG_DETECT_M2_SSD1_N",
+			"PLUG_DETECT_NIC1_N",
+			"SEL_SMB_DIMM_CPU0",
+			"presence-ps2",
+			"presence-ps3",
+			"", "",
+			"PWRBRD_PLUG_DETECT2_N";
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	power-supply@58 {
+		compatible = "ibm,cffps";
+		reg = <0x58>;
+	};
+
+	power-supply@59 {
+		compatible = "ibm,cffps";
+		reg = <0x59>;
+	};
+
+	power-supply@5a {
+		compatible = "ibm,cffps";
+		reg = <0x5a>;
+	};
+
+	power-supply@5b {
+		compatible = "ibm,cffps";
+		reg = <0x5b>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c3mux0chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c3mux0chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c3mux0chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c3mux0chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c3mux0chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c3mux0chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c3mux0chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c3mux0chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+
+	regulator@42 {
+		compatible = "infineon,ir38263";
+		reg = <0x42>;
+	};
+
+	regulator@43 {
+		compatible = "infineon,ir38060";
+		reg = <0x43>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	fan-controller@52 {
+		compatible = "maxim,max31785a";
+		reg = <0x52>;
+	};
+
+	fan-controller@54 {
+		compatible = "maxim,max31785a";
+		reg = <0x54>;
+	};
+
+	eeprom@55 {
+		compatible = "atmel,24c64";
+		reg = <0x55>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c6mux0chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c6mux0chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c6mux0chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c6mux0chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c6mux0chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			humidity-sensor@40 {
+				compatible = "ti,hdc1080";
+				reg = <0x40>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp275";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+
+			led-controller@60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led@0 {
+					label = "enclosure-id-led";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led@1 {
+					label = "attention-led";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led@2 {
+					label = "enclosure-fault-rollup-led";
+					reg = <2>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led@3 {
+					label = "power-on-led";
+					reg = <3>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+
+			temperature-sensor@76 {
+				compatible = "infineon,dps310";
+				reg = <0x76>;
+			};
+		};
+
+		i2c6mux0chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c6mux0chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c6mux0chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+
+	pca3: gpio@74 {
+		compatible = "nxp,pca9539";
+		reg = <0x74>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca4: gpio@77 {
+		compatible = "nxp,pca9539";
+		reg = <0x77>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"PE_NVMED0_EXP_PRSNT_N",
+			"PE_NVMED1_EXP_PRSNT_N",
+			"PE_NVMED2_EXP_PRSNT_N",
+			"PE_NVMED3_EXP_PRSNT_N",
+			"LED_FAULT_NVMED0",
+			"LED_FAULT_NVMED1",
+			"LED_FAULT_NVMED2",
+			"LED_FAULT_NVMED3",
+			"FAN0_PRESENCE_R_N",
+			"FAN1_PRESENCE_R_N",
+			"FAN2_PRESENCE_R_N",
+			"FAN3_PRESENCE_R_N",
+			"FAN4_PRESENCE_R_N",
+			"FAN5_PRESENCE_N",
+			"FAN6_PRESENCE_N",
+			"";
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c7mux0chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c7mux0chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c7mux0chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c7mux0chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			regulator@58 {
+				compatible = "mps,mp2973";
+				reg = <0x58>;
+			};
+		};
+
+		i2c7mux0chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c7mux0chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			regulator@40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
+		};
+
+		i2c7mux0chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c7mux0chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c8mux0chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			regulator@58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
+		};
+
+		i2c8mux0chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			regulator@40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
+
+			regulator@41 {
+				compatible = "infineon,tda38640";
+				reg = <0x41>;
+			};
+
+			regulator@58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
+
+			regulator@5b {
+				compatible = "mps,mp2971";
+				reg = <0x5b>;
+			};
+		};
+
+		i2c8mux0chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c8mux0chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c8mux0chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			i2c-mux@70 {
+				compatible = "nxp,pca9548";
+				reg = <0x70>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c8mux1chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c8mux1chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c8mux1chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c8mux1chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				i2c8mux1chn4: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				i2c8mux1chn5: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				i2c8mux1chn6: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				i2c8mux1chn7: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
+		};
+
+		i2c8mux0chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c8mux0chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			temperature-sensor@4c {
+				compatible = "ti,tmp423";
+				reg = <0x4c>;
+			};
+		};
+
+		i2c8mux0chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			regulator@40 {
+				compatible = "infineon,ir38060";
+				reg = <0x40>;
+			};
+		};
+	};
+};
+
+&i2c9 {
+	status = "okay";
+
+	regulator@40 {
+		compatible = "infineon,ir38263";
+		reg = <0x40>;
+	};
+
+	regulator@41 {
+		compatible = "infineon,ir38263";
+		reg = <0x41>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	regulator@60 {
+		compatible = "maxim,max8952";
+		reg = <0x60>;
+
+		max8952,default-mode = <0>;
+		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
+						<1050000>, <950000>;
+		max8952,sync-freq = <0>;
+		max8952,ramp-speed = <0>;
+
+		regulator-name = "VR_v77_1v4";
+		regulator-min-microvolt = <770000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	tpm@2e {
+		compatible = "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+		memory-region = <&eventlog>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+
+	regulator@41 {
+		compatible = "infineon,ir38263";
+		reg = <0x41>;
+	};
+
+	led-controller@61 {
+		compatible = "nxp,pca9552";
+		reg = <0x61>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led@0 {
+			label = "efuse-12v-slots";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@1 {
+			label = "efuse-3p3v-slot";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@3 {
+			label = "nic2-pert";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@4 {
+			label = "pcie-perst9";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@5 {
+			label = "pcie-perst10";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@6 {
+			label = "pcie-perst11";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@7 {
+			label = "pcie-perst12";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@8 {
+			label = "pcie-perst13";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@9 {
+			label = "pcie-perst14";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@10 {
+			label = "pcie-perst15";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@11 {
+			label = "pcie-perst16";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@12 {
+			label = "PV-cp1-sw1stk4-perst";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@13 {
+			label = "PV-cp1-sw1stk5-perst";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@14 {
+			label = "pe-cp-drv2-perst";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@15 {
+			label = "pe-cp-drv3-perst";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	gpio@75 {
+		compatible = "nxp,pca9539";
+		reg = <0x75>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"PLUG_DETECT_PCIE_J109_N",
+			"PLUG_DETECT_PCIE_J110_N",
+			"PLUG_DETECT_PCIE_J111_N",
+			"PLUG_DETECT_PCIE_J112_N",
+			"PLUG_DETECT_PCIE_J113_N",
+			"PLUG_DETECT_PCIE_J114_N",
+			"PLUG_DETECT_PCIE_J115_N",
+			"PLUG_DETECT_PCIE_J116_N",
+			"PLUG_DETECT_M2_SSD2_N",
+			"PLUG_DETECT_NIC2_N",
+			"SEL_SMB_DIMM_CPU1",
+			"presence-ps0",
+			"presence-ps1",
+			"", "",
+			"PWRBRD_PLUG_DETECT1_N";
+	};
+
+	gpio@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"SW1_BOOTRCVRYB1_N",
+			"SW1_BOOTRCVRYB0_N",
+			"SW2_BOOTRCVRYB1_N",
+			"SW2_BOOTRCVRYB0_N",
+			"SW3_4_BOOTRCVRYB1_N",
+			"SW3_4_BOOTRCVRYB0_N",
+			"SW5_BOOTRCVRYB1_N",
+			"SW5_BOOTRCVRYB0_N",
+			"SW6_BOOTRCVRYB1_N",
+			"SW6_BOOTRCVRYB0_N",
+			"SW1_RESET_N",
+			"SW3_RESET_N",
+			"SW4_RESET_N",
+			"SW2_RESET_N",
+			"SW5_RESET_N",
+			"SW6_RESET_N";
+	};
+};
+
+&i2c14 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c14mux0chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c14mux0chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c14mux0chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c14mux0chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			regulator@58 {
+				compatible = "mps,mp2973";
+				reg = <0x58>;
+			};
+		};
+
+		i2c14mux0chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c14mux0chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			regulator@40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
+		};
+
+		i2c14mux0chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c14mux0chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c15 {
+	status = "okay";
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c15mux0chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			regulator@58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
+		};
+
+		i2c15mux0chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			regulator@40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
+
+			regulator@41 {
+				compatible = "infineon,tda38640";
+				reg = <0x41>;
+			};
+
+			regulator@58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
+
+			regulator@5b {
+				compatible = "mps,mp2971";
+				reg = <0x5b>;
+			};
+		};
+
+		i2c15mux0chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c15mux0chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c15mux0chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			i2c-mux@70 {
+				compatible = "nxp,pca9548";
+				reg = <0x70>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c15mux1chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c15mux1chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c15mux1chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c15mux1chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				i2c15mux1chn4: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				i2c15mux1chn5: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				i2c15mux1chn6: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				i2c15mux1chn7: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
+		};
+
+		i2c15mux0chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c15mux0chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			temperature-sensor@4c {
+				compatible = "ti,tmp423";
+				reg = <0x4c>;
+			};
+		};
+
+		i2c15mux0chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			regulator@40 {
+				compatible = "infineon,ir38060";
+				reg = <0x40>;
+			};
+
+			temperature-sensor@4c {
+				compatible = "ti,tmp423";
+				reg = <0x4c>;
+			};
+		};
+	};
+};
-- 
2.39.2


