Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8980987C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444207AbjLHBOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjLHBOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:14:07 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67931715;
        Thu,  7 Dec 2023 17:14:12 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b9d2b8c3c6so1028298b6e.1;
        Thu, 07 Dec 2023 17:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701998052; x=1702602852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qccLWb2i68kc/cXCxeoTyRZxhRO/5hipb5+NfkBkZB0=;
        b=DhROtHtAAIeWSsSzf4kQSAGOmgAFNRC7gLKhOX3o5Wz07BXoF/yXOEoIln5x2PNwJf
         VxAt+DNeVqMsyky3hQq5GAyUT/fpTHWZ5IRj33ayp95nwoun2DB9nmQMlMH0hc9zbEe0
         bOkkMWP2cof7ZeKftObSlxW3Hf/+/TDhrJcoD1s9afO1XBXNff1p6BjJK/RXicqVcWze
         vdG2wvV1ShFXbhuTVKHkAJNdb5zB04zRaN0cGfkwLpZjWW1y/Q3CbWkRknxtU4uYipJY
         psM385jHVxaGpIVhVZ7i1IJZKqUvLAOaRyPNcEPeU4nYlnxml5tzGwdWy7sm3kshXYHS
         owkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998052; x=1702602852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qccLWb2i68kc/cXCxeoTyRZxhRO/5hipb5+NfkBkZB0=;
        b=g1PEih7cqYOiHhWMcIsiIMgcqSD5U2cVEHScGWpiUufQC7DXZCf39mtponMAQ7A5yV
         PjfOPQnZ37bPYLXCe5tO2IkKrntgcu208aS5bTmT3XPG+Sx3AhIDmgh3ddI47p++Dtdk
         WI2i9pRLMVw+4CP/hNkMOjBqq8ayjaj6Lj9rtV8wjd7f1lkI/NXcVMrGPi3vt/HCwH7U
         ab93ssSHypk++6kAFTH3WZ/uCuvwaM2lpqln9HxljNpz6UpBkNG6fBYxT28FnYrC6B38
         qq32soULePVAb6P+2U6Ehge0GdLoY4jJkeZOLJaIjoNmBhAhORO2CKbQCpMvGD6iSf9n
         HgZw==
X-Gm-Message-State: AOJu0Yx3r2l9V/pfGsDgCjAhi64jYpfjCN/+uG/XMH9MU4Vdswj4WCLc
        /zBnff6EyIVUxDMUF1CJKxw=
X-Google-Smtp-Source: AGHT+IFRI0fWqmZmhOi8iNDZzqwjUrljsTu6qvwOoh6VznQNB/80xXXy9RfZXu8Ykcg4FeKel+vPHA==
X-Received: by 2002:a05:6808:15a1:b0:3b9:dd70:766a with SMTP id t33-20020a05680815a100b003b9dd70766amr2303053oiw.14.1701998052018;
        Thu, 07 Dec 2023 17:14:12 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id r5-20020a056808210500b003b85c2b17efsm165186oiw.9.2023.12.07.17.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:14:11 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v6 2/4] dt-bindings: clock: sophgo: support SG2042
Date:   Fri,  8 Dec 2023 09:14:02 +0800
Message-Id: <6f456da5355f451309de0b1b420433ed65dab3c3.1701997033.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701997033.git.unicorn_wang@outlook.com>
References: <cover.1701997033.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the clock generator on the SG2042 RISC-V SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  53 ++++++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 169 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
new file mode 100644
index 000000000000..f9935e66fc95
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-clkgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Clock Generator
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-clkgen
+
+  reg:
+    maxItems: 1
+
+  sophgo,system-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to SG2042 System Controller node. On SG2042, part of control
+      registers of Clock Controller are defined in System controller. Clock
+      driver will use this phandle to get the register map base to plus the
+      offset of the registers to access them.
+
+  clocks:
+    items:
+      - description: Clock Generation IC (25 MHz)
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-clkgen.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - sophgo,system-ctrl
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@30012000 {
+        compatible = "sophgo,sg2042-clkgen";
+        reg = <0x30012000 0x1000>;
+        sophgo,system-ctrl = <&sys_ctrl>;
+        clocks = <&cgi>;
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-clkgen.h b/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
new file mode 100644
index 000000000000..78cd3c3efdb6
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
+#define __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
+
+/* Divider clocks */
+#define DIV_CLK_MPLL_RP_CPU_NORMAL_0	0
+#define DIV_CLK_MPLL_AXI_DDR_0		1
+#define DIV_CLK_FPLL_DDR01_1		2
+#define DIV_CLK_FPLL_DDR23_1		3
+#define DIV_CLK_FPLL_RP_CPU_NORMAL_1	4
+#define DIV_CLK_FPLL_50M_A53		5
+#define DIV_CLK_FPLL_TOP_RP_CMN_DIV2	6
+#define DIV_CLK_FPLL_UART_500M		7
+#define DIV_CLK_FPLL_AHB_LPC		8
+#define DIV_CLK_FPLL_EFUSE		9
+#define DIV_CLK_FPLL_TX_ETH0		10
+#define DIV_CLK_FPLL_PTP_REF_I_ETH0	11
+#define DIV_CLK_FPLL_REF_ETH0		12
+#define DIV_CLK_FPLL_EMMC		13
+#define DIV_CLK_FPLL_SD			14
+#define DIV_CLK_FPLL_TOP_AXI0		15
+#define DIV_CLK_FPLL_TOP_AXI_HSPERI	16
+#define DIV_CLK_FPLL_AXI_DDR_1		17
+#define DIV_CLK_FPLL_DIV_TIMER1		18
+#define DIV_CLK_FPLL_DIV_TIMER2		19
+#define DIV_CLK_FPLL_DIV_TIMER3		20
+#define DIV_CLK_FPLL_DIV_TIMER4		21
+#define DIV_CLK_FPLL_DIV_TIMER5		22
+#define DIV_CLK_FPLL_DIV_TIMER6		23
+#define DIV_CLK_FPLL_DIV_TIMER7		24
+#define DIV_CLK_FPLL_DIV_TIMER8		25
+#define DIV_CLK_FPLL_100K_EMMC		26
+#define DIV_CLK_FPLL_100K_SD		27
+#define DIV_CLK_FPLL_GPIO_DB		28
+#define DIV_CLK_DPLL0_DDR01_0		29
+#define DIV_CLK_DPLL1_DDR23_0		30
+
+/* Gate clocks */
+#define GATE_CLK_RP_CPU_NORMAL_DIV0	31
+#define GATE_CLK_AXI_DDR_DIV0		32
+
+#define GATE_CLK_RP_CPU_NORMAL_DIV1	33
+#define GATE_CLK_A53_50M		34
+#define GATE_CLK_TOP_RP_CMN_DIV2	35
+#define GATE_CLK_HSDMA			36
+#define GATE_CLK_EMMC_100M		37
+#define GATE_CLK_SD_100M		38
+#define GATE_CLK_TX_ETH0		39
+#define GATE_CLK_PTP_REF_I_ETH0		40
+#define GATE_CLK_REF_ETH0		41
+#define GATE_CLK_UART_500M		42
+#define GATE_CLK_EFUSE			43
+
+#define GATE_CLK_AHB_LPC		44
+#define GATE_CLK_AHB_ROM		45
+#define GATE_CLK_AHB_SF			46
+
+#define GATE_CLK_APB_UART		47
+#define GATE_CLK_APB_TIMER		48
+#define GATE_CLK_APB_EFUSE		49
+#define GATE_CLK_APB_GPIO		50
+#define GATE_CLK_APB_GPIO_INTR		51
+#define GATE_CLK_APB_SPI		52
+#define GATE_CLK_APB_I2C		53
+#define GATE_CLK_APB_WDT		54
+#define GATE_CLK_APB_PWM		55
+#define GATE_CLK_APB_RTC		56
+
+#define GATE_CLK_AXI_PCIE0		57
+#define GATE_CLK_AXI_PCIE1		58
+#define GATE_CLK_SYSDMA_AXI		59
+#define GATE_CLK_AXI_DBG_I2C		60
+#define GATE_CLK_AXI_SRAM		61
+#define GATE_CLK_AXI_ETH0		62
+#define GATE_CLK_AXI_EMMC		63
+#define GATE_CLK_AXI_SD			64
+#define GATE_CLK_TOP_AXI0		65
+#define GATE_CLK_TOP_AXI_HSPERI		66
+
+#define GATE_CLK_TIMER1			67
+#define GATE_CLK_TIMER2			68
+#define GATE_CLK_TIMER3			69
+#define GATE_CLK_TIMER4			70
+#define GATE_CLK_TIMER5			71
+#define GATE_CLK_TIMER6			72
+#define GATE_CLK_TIMER7			73
+#define GATE_CLK_TIMER8			74
+#define GATE_CLK_100K_EMMC		75
+#define GATE_CLK_100K_SD		76
+#define GATE_CLK_GPIO_DB		77
+
+#define GATE_CLK_AXI_DDR_DIV1		78
+#define GATE_CLK_DDR01_DIV1		79
+#define GATE_CLK_DDR23_DIV1		80
+/* DPLL0 */
+#define GATE_CLK_DDR01_DIV0		81
+/* DPLL1 */
+#define GATE_CLK_DDR23_DIV0		82
+
+#define GATE_CLK_DDR01			83
+#define GATE_CLK_DDR23			84
+#define GATE_CLK_RP_CPU_NORMAL		85
+#define GATE_CLK_AXI_DDR		86
+#define GATE_CLK_RXU0			87
+#define GATE_CLK_RXU1			88
+#define GATE_CLK_RXU2			89
+#define GATE_CLK_RXU3			90
+#define GATE_CLK_RXU4			91
+#define GATE_CLK_RXU5			92
+#define GATE_CLK_RXU6			93
+#define GATE_CLK_RXU7			94
+#define GATE_CLK_RXU8			95
+#define GATE_CLK_RXU9			96
+#define GATE_CLK_RXU10			97
+#define GATE_CLK_RXU11			98
+#define GATE_CLK_RXU12			99
+#define GATE_CLK_RXU13			100
+#define GATE_CLK_RXU14			101
+#define GATE_CLK_RXU15			102
+#define GATE_CLK_RXU16			103
+#define GATE_CLK_RXU17			104
+#define GATE_CLK_RXU18			105
+#define GATE_CLK_RXU19			106
+#define GATE_CLK_RXU20			107
+#define GATE_CLK_RXU21			108
+#define GATE_CLK_RXU22			109
+#define GATE_CLK_RXU23			110
+#define GATE_CLK_RXU24			111
+#define GATE_CLK_RXU25			112
+#define GATE_CLK_RXU26			113
+#define GATE_CLK_RXU27			114
+#define GATE_CLK_RXU28			115
+#define GATE_CLK_RXU29			116
+#define GATE_CLK_RXU30			117
+#define GATE_CLK_RXU31			118
+#define GATE_CLK_MP0			119
+#define GATE_CLK_MP1			120
+#define GATE_CLK_MP2			121
+#define GATE_CLK_MP3			122
+#define GATE_CLK_MP4			123
+#define GATE_CLK_MP5			124
+#define GATE_CLK_MP6			125
+#define GATE_CLK_MP7			126
+#define GATE_CLK_MP8			127
+#define GATE_CLK_MP9			128
+#define GATE_CLK_MP10			129
+#define GATE_CLK_MP11			130
+#define GATE_CLK_MP12			131
+#define GATE_CLK_MP13			132
+#define GATE_CLK_MP14			133
+#define GATE_CLK_MP15			134
+
+/* MUX clocks */
+#define MUX_CLK_DDR01			135
+#define MUX_CLK_DDR23			136
+#define MUX_CLK_RP_CPU_NORMAL		137
+#define MUX_CLK_AXI_DDR			138
+
+/* PLL clocks */
+#define MPLL_CLK			139
+#define FPLL_CLK			140
+#define DPLL0_CLK			141
+#define DPLL1_CLK			142
+
+#endif /* __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__ */
-- 
2.25.1

