Return-Path: <linux-kernel+bounces-160804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE758B4310
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE671C22A2C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEE48BFD;
	Sat, 27 Apr 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="P9yapMlU"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C265244
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176658; cv=none; b=SX3pEHbxD9VTZ0d5ao6MjycNLd93qxGvsdymJ6Jn3U53cmAZ6DynWg1Ofg/J3ugFmPL1Py82pdqBMdV+9MnHoddBmeHXpahNPBME6l4uwrv94R85xIxpdakw7sUKcwnVzjboxL8uovfAxKyoYp6YcBnRoeAAZ8+IW6BeYAo8cYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176658; c=relaxed/simple;
	bh=sMOxHU5KMFZs4iNqEZa826xHNb+O2YxTHVtzCtgnVzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAPdjrs9G6wRhPxpZfQdzAr+xNUqoipJHQnM+IQRnziAfEL3iRNseRFvX4A0YduXb8rt832WLv47vGexwdb9q4yHBf9Rx/oaZhVQm7orOlU2wPgKdBpPKeLnEVuJzH3bs7a3YtNpu/EuYgKZkkdDH3Ybwh286LC/IQaENXbNkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=P9yapMlU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecff9df447so2725273b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1714176656; x=1714781456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrlLXZWpuiMESLDTJ+xPjDizCDXOjxRIPese3PIiRKI=;
        b=P9yapMlU/vmmA8qrU/kXs2pRtDicT8td5khYvzL6snQRqrn11Tgv6Fs1ZHGcd83IUZ
         XZbxVxb+CC0TS+C7wVmC5NRULsjfS/q9iPNAlyQQZJaAVvGxNHSPJPfdHgV95F5ut/Q8
         jJO8J71EUL1nyNwHLI1IT2rVErS6zXAlrUk8Br71a7evWzs95LG1988/kTkULzmcVp0x
         zgRGisUmtuMQoHEWAnqd89kStOUXeejg83le+qYEUgHHqZYOMs4vt5cyqsgNyj3OZSLF
         2hFczK1NCYRcNCE9eSk0xanENlwjsoKikXN+XBCx1Q2NZHY0jD77N3bA1zWW8V1w3i6V
         6dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176656; x=1714781456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrlLXZWpuiMESLDTJ+xPjDizCDXOjxRIPese3PIiRKI=;
        b=NMGMuApFXmzNWivscWXUNJo4MPAkmqEGCSU0limmTF6huM4xO7mo59YZ0dWWU2c5JD
         iKAOUBeFL2V/vvcy2W72pmBBhQf4O9E3aBhDg2EH+5g56eK09Q1kPw3HCcDbASBCwwY5
         CiomL5GD54oCIb+mAUPzLF0gW3O3SOu3VYnQsNXM5aKGIJ9Ku2z9ep6h9xH47kUJh+Pk
         hur0S/hpzJzmvFboHKvxiiyzpk3etZnom6O/RPjAwskcVvN8jGQECeXcZt/ZXd1Qj04o
         9O9HByPdIkKCRWP/vpZjmnlUW22u/EGyzy2X1lYcFagsddZBdUtVuNna+b3+QUgi5GRH
         u0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVNsBQUfhmzkH9emA09RAkE4c8r+coop5UgJDXJl8oje8F8QclO1GVV4T697WS7XkKyr2ocrBxyJY1Ngv5OyPFbq5XomjS7uB3IJafp
X-Gm-Message-State: AOJu0YxgHlNuL/8Hrkwsm+hnoV5v0hwGMAQWi9ZgrTOpsLkDA30bXQ9t
	a8iz7gtmUT9DzD5IZvYDNbGIPMmyH3tuKHXwYBWDkkwyC4/Xd6evZcLeQ4aTcOY=
X-Google-Smtp-Source: AGHT+IG4wumPhODLqSYj/1OQ3+tavjARweTZgxxYtKaCTo8UfjzaeyAZVKJnT0PLnRQ0o9FND8xXBQ==
X-Received: by 2002:a05:6a20:5505:b0:1a3:bfce:ec9e with SMTP id ko5-20020a056a20550500b001a3bfceec9emr4300497pzb.18.1714176656588;
        Fri, 26 Apr 2024 17:10:56 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:3569:7ce4:94b8:1691])
        by smtp.gmail.com with ESMTPSA id w1-20020a6556c1000000b005f3d54c0a57sm6061883pgs.49.2024.04.26.17.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:10:56 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Fri, 26 Apr 2024 17:10:34 -0700
Subject: [PATCH RFC v2 1/4] dt-bindings: clock: Document T-Head TH1520
 AP_SUBSYS controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-th1520-clk-v2-v2-1-96b829e6fcee@tenstorrent.com>
References: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
In-Reply-To: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714176654; l=5695;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=sMOxHU5KMFZs4iNqEZa826xHNb+O2YxTHVtzCtgnVzE=;
 b=yvQQ3If1wAxIon7Fk0UROAd49XxIxfJCQ1waX2ubKqW+XZg2OJGEHSUO0CK7CZVaWTYdk77zD
 KqBVDOt7pUhDdW/UHKYTS2TimfCRaDsO5xworU7nT8iGulWCpyWS+ze
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Document bindings for the T-Head TH1520 AP sub-system clock controller.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../bindings/clock/thead,th1520-clk-ap.yaml        | 65 +++++++++++++++
 MAINTAINERS                                        |  2 +
 include/dt-bindings/clock/thead,th1520-clk-ap.h    | 96 ++++++++++++++++++++++
 3 files changed, 163 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
new file mode 100644
index 000000000000..611edc90f7b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/thead,th1520-clk-ap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 AP sub-system clock controller
+
+description: |
+  The T-HEAD TH1520 AP sub-system clock controller configures the
+  CPU, DPU, GMAC and TEE PLLs.
+
+  SoC reference manual
+  https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+  - Wei Fu <wefu@redhat.com>
+  - Drew Fustini <dfustini@tenstorrent.com>
+
+properties:
+  compatible:
+    const: thead,th1520-clk-ap
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: main oscillator (24MHz)
+
+  clock-names:
+    items:
+      - const: osc
+
+  "#clock-cells":
+    const: 1
+    description:
+      See <dt-bindings/clock/thead,th1520-clk-ap.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    soc {
+
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      clk: clock-controller@ffef010000 {
+        compatible = "thead,th1520-clk-ap";
+        reg = <0xff 0xef010000 0x0 0x1000>;
+        clocks = <&osc>;
+        clock-names = "osc";
+        #clock-cells = <1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..51d550cb1329 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19023,7 +19023,9 @@ M:	Guo Ren <guoren@kernel.org>
 M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	arch/riscv/boot/dts/thead/
+F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
diff --git a/include/dt-bindings/clock/thead,th1520-clk-ap.h b/include/dt-bindings/clock/thead,th1520-clk-ap.h
new file mode 100644
index 000000000000..d0d1ab1e672a
--- /dev/null
+++ b/include/dt-bindings/clock/thead,th1520-clk-ap.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
+ * Authors: Yangtao Li <frank.li@vivo.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_TH1520_H_
+#define _DT_BINDINGS_CLK_TH1520_H_
+
+#define CLK_CPU_PLL0		0
+#define CLK_CPU_PLL1		1
+#define CLK_GMAC_PLL		2
+#define CLK_VIDEO_PLL		3
+#define CLK_DPU0_PLL		4
+#define CLK_DPU1_PLL		5
+#define CLK_TEE_PLL		6
+#define CLK_C910_I0		7
+#define CLK_C910		8
+#define CLK_BROM		9
+#define CLK_BMU			10
+#define CLK_AHB2_CPUSYS_HCLK	11
+#define CLK_APB3_CPUSYS_PCLK	12
+#define CLK_AXI4_CPUSYS2_ACLK	13
+#define CLK_AON2CPU_A2X		14
+#define CLK_X2X_CPUSYS		15
+#define CLK_AXI_ACLK		16
+#define CLK_CPU2AON_X2H		17
+#define CLK_PERI_AHB_HCLK	18
+#define CLK_CPU2PERI_X2H	19
+#define CLK_PERI_APB_PCLK	20
+#define CLK_PERI2APB_PCLK	21
+#define CLK_PERI_APB1_HCLK	22
+#define CLK_PERI_APB2_HCLK	23
+#define CLK_PERI_APB3_HCLK	24
+#define CLK_PERI_APB4_HCLK	25
+#define CLK_OSC12M		26
+#define CLK_OUT1		27
+#define CLK_OUT2		28
+#define CLK_OUT3		29
+#define CLK_OUT4		30
+#define CLK_APB_PCLK		31
+#define CLK_NPU			32
+#define CLK_NPU_AXI		33
+#define CLK_VI			34
+#define CLK_VI_AHB		35
+#define CLK_VO_AXI		36
+#define CLK_VP_APB		37
+#define CLK_VP_AXI		38
+#define CLK_CPU2VP		39
+#define CLK_VENC		40
+#define CLK_DPU0		41
+#define CLK_DPU1		42
+#define CLK_EMMC_SDIO		43
+#define CLK_GMAC1		44
+#define CLK_PADCTRL1		45
+#define CLK_DSMART		46
+#define CLK_PADCTRL0		47
+#define CLK_GMAC_AXI		48
+#define CLK_GPIO3		49
+#define CLK_GMAC0		50
+#define CLK_PWM			51
+#define CLK_QSPI0		52
+#define CLK_QSPI1		53
+#define CLK_SPI			54
+#define CLK_UART0_PCLK		55
+#define CLK_UART1_PCLK		56
+#define CLK_UART2_PCLK		57
+#define CLK_UART3_PCLK		58
+#define CLK_UART4_PCLK		59
+#define CLK_UART5_PCLK		60
+#define CLK_GPIO0		61
+#define CLK_GPIO1		62
+#define CLK_GPIO2		63
+#define CLK_I2C0		64
+#define CLK_I2C1		65
+#define CLK_I2C2		66
+#define CLK_I2C3		67
+#define CLK_I2C4		68
+#define CLK_I2C5		69
+#define CLK_SPINLOCK		70
+#define CLK_DMA			71
+#define CLK_MBOX0		72
+#define CLK_MBOX1		73
+#define CLK_MBOX2		74
+#define CLK_MBOX3		75
+#define CLK_WDT0		76
+#define CLK_WDT1		77
+#define CLK_TIMER0		78
+#define CLK_TIMER1		79
+#define CLK_SRAM0		80
+#define CLK_SRAM1		81
+#define CLK_SRAM2		82
+#define CLK_SRAM3		83
+#define CLK_PLL_GMAC_100M	84
+#define CLK_UART_SCLK		85
+#endif

-- 
2.34.1


