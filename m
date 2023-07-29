Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F408C767F81
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjG2Nn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjG2Nnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:43:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4783ABF;
        Sat, 29 Jul 2023 06:43:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f94328a4so1612338b3a.0;
        Sat, 29 Jul 2023 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638227; x=1691243027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+pZDu0ZfUoQWcJ4aUyi+W5kLX2VT7frs7kndUImNys=;
        b=q0URTwFRXQgmVgZGgnWbXnG/O1IacC0WLT01OTx+SxnzI3Jq2b8onHgrIcSP4/um4I
         BmJg2yppLbgm4PXKfZH2O9xebHnSmOJ4cpOSdofCwSDtXmuQiGid3DoDZokOC9lNkn0C
         2b8qo2p0Axm2b2lR8qrT/KJ/5X84XZg6fdOwa6sL8fhUpsrmAxtGu8smwXserSpbt+5V
         +JqRtEcdRwygzuwjHOmPxMj1xuEJ6UEqyvFCB/NoU3bb44sMQ6DKQyaF6WIHUBi7DFjN
         EfxcpxxerTiJdbsNEeQ23Z1XLp/J3tAapXnOoGsjrPNfTkCU+UcRfGAwS159R83EqgNm
         qU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638227; x=1691243027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+pZDu0ZfUoQWcJ4aUyi+W5kLX2VT7frs7kndUImNys=;
        b=HMomLg2PaXenhmbLRu+uGuDcWLbC/v+jn/wXJGYVQTJsOzZjWWBs9Hc5ipTaJsTFwO
         WxNGG5pgOpZfuqt9MyjW97X2AR9itNBdCBOzmUlHPCB6r7cgHlscZvt+S/xZ6y43BcRm
         f305cdy7vtoU9EARCI2pgCR21IKfA98vHpbMCcarYq7OOtHCiPEgmr7m3wRUD3qblLHa
         L7CjPrtcHf30yQJH5OHd8GF3uhfJAIVl+bJMOVrB91AJUSduTqTqLkTcZQ7wTp2t9VpZ
         THvq0iWx7oPsp/u5owTlPDub4h+/RgLGV8teJg+KX/AZMKY14ufkq40JtTIOuI+HBQzz
         MaKA==
X-Gm-Message-State: ABy/qLbHxIOzGy8U1ntB3K6eDLAc0ffZyMGJVsTaU9FbgOnhTZQBMr70
        W/9+YAnewSAsF2qM7uVTTngfLVNj6fpFlQ==
X-Google-Smtp-Source: APBJJlH8D2XKsQZdPmU4yW8aGY0K+7deInvJsc7hLZXKENoe1MqeXfYhWbyDAmG819qGmKKYHU9iVA==
X-Received: by 2002:a05:6a20:9151:b0:123:152d:d46b with SMTP id x17-20020a056a20915100b00123152dd46bmr5948900pzc.26.1690638226959;
        Sat, 29 Jul 2023 06:43:46 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:43:46 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 03/17] MIPS: dts: Add basic DT support for Loongson-1 boards
Date:   Sat, 29 Jul 2023 21:43:04 +0800
Message-Id: <20230729134318.1694467-4-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial devicetree for Loongson-1 boards, including
LSGZ_1B_DEV and SMARTLOONG_1C board.
These basic DTs contain CPU, clock and core INTC.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/Makefile                   |  1 +
 arch/mips/boot/dts/loongson/Makefile          |  3 +
 arch/mips/boot/dts/loongson/loongson1.dtsi    | 22 ++++++
 arch/mips/boot/dts/loongson/loongson1b.dtsi   | 75 +++++++++++++++++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi   | 29 +++++++
 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   | 25 +++++++
 arch/mips/boot/dts/loongson/smartloong_1c.dts | 25 +++++++
 7 files changed, 180 insertions(+)
 create mode 100644 arch/mips/boot/dts/loongson/loongson1.dtsi
 create mode 100644 arch/mips/boot/dts/loongson/loongson1b.dtsi
 create mode 100644 arch/mips/boot/dts/loongson/loongson1c.dtsi
 create mode 100644 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
 create mode 100644 arch/mips/boot/dts/loongson/smartloong_1c.dts

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 928f38a79dff..2e040b1ba97b 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -6,6 +6,7 @@ subdir-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= img
 subdir-$(CONFIG_MACH_INGENIC)		+= ingenic
 subdir-$(CONFIG_LANTIQ)			+= lantiq
 subdir-$(CONFIG_MACH_LOONGSON64)	+= loongson
+subdir-$(CONFIG_MACH_LOONGSON32)	+= loongson
 subdir-$(CONFIG_SOC_VCOREIII)		+= mscc
 subdir-$(CONFIG_MIPS_MALTA)		+= mti
 subdir-$(CONFIG_LEGACY_BOARD_SEAD3)	+= mti
diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/loongson/Makefile
index 5c6433e441ee..9d95f1351d5f 100644
--- a/arch/mips/boot/dts/loongson/Makefile
+++ b/arch/mips/boot/dts/loongson/Makefile
@@ -6,4 +6,7 @@ dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64c_8core_rs780e.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64g_4core_ls7a.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64v_4core_virtio.dtb
 
+dtb-$(CONFIG_LOONGSON1B_LSGZ_DEV)	+= lsgz_1b_dev.dtb
+dtb-$(CONFIG_LOONGSON1C_SMARTLOONG)	+= smartloong_1c.dtb
+
 obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boot/dts/loongson/loongson1.dtsi
new file mode 100644
index 000000000000..a2b5c828bbbd
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/clock/loongson,ls1x-clk.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpu_intc: interrupt-controller {
+		compatible = "mti,cpu-interrupt-controller";
+		#address-cells = <0>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
new file mode 100644
index 000000000000..784ae9b6572d
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+/dts-v1/;
+#include "loongson1.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			#clock-cells = <1>;
+			clocks = <&clkc LS1X_CLKID_CPU>;
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-44000000 {
+			opp-hz = /bits/ 64 <44000000>;
+		};
+		opp-47142000 {
+			opp-hz = /bits/ 64 <47142000>;
+		};
+		opp-50769000 {
+			opp-hz = /bits/ 64 <50769000>;
+		};
+		opp-55000000 {
+			opp-hz = /bits/ 64 <55000000>;
+		};
+		opp-60000000 {
+			opp-hz = /bits/ 64 <60000000>;
+		};
+		opp-66000000 {
+			opp-hz = /bits/ 64 <66000000>;
+		};
+		opp-73333000 {
+			opp-hz = /bits/ 64 <73333000>;
+		};
+		opp-82500000 {
+			opp-hz = /bits/ 64 <82500000>;
+		};
+		opp-94285000 {
+			opp-hz = /bits/ 64 <94285000>;
+		};
+		opp-110000000 {
+			opp-hz = /bits/ 64 <110000000>;
+		};
+		opp-132000000 {
+			opp-hz = /bits/ 64 <132000000>;
+		};
+		opp-165000000 {
+			opp-hz = /bits/ 64 <165000000>;
+		};
+		opp-220000000 {
+			opp-hz = /bits/ 64 <220000000>;
+		};
+	};
+
+	clkc: clock-controller@1fe78030 {
+		compatible = "loongson,ls1b-clk";
+		reg = <0x1fe78030 0x8>;
+
+		clocks = <&xtal>;
+		#clock-cells = <1>;
+	};
+};
diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
new file mode 100644
index 000000000000..d552e1668984
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+/dts-v1/;
+#include "loongson1.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			#clock-cells = <1>;
+			clocks = <&clkc LS1X_CLKID_CPU>;
+		};
+	};
+
+	clkc: clock-controller@1fe78030 {
+		compatible = "loongson,ls1c-clk";
+		reg = <0x1fe78030 0x8>;
+
+		clocks = <&xtal>;
+		#clock-cells = <1>;
+	};
+};
diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
new file mode 100644
index 000000000000..d12c723b0a2b
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "loongson1b.dtsi"
+
+/ {
+	compatible = "loongson,lsgz-1b-dev", "loongson,ls1b";
+	model = "LSGZ_1B_DEV Board";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x4000000>;
+	};
+
+	xtal: xtal {
+		compatible = "fixed-clock";
+		clock-frequency = <33000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+};
diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
new file mode 100644
index 000000000000..64e869acfd86
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "loongson1c.dtsi"
+
+/ {
+	compatible = "loongmasses,smartloong-1c", "loongson,ls1c";
+	model = "Smartloong_1C Board";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x2000000>;
+	};
+
+	xtal: xtal {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+};
-- 
2.39.2

