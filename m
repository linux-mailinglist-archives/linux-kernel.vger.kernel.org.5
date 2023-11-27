Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF19F7F96F3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjK0A6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjK0A6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:58:18 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D1610F;
        Sun, 26 Nov 2023 16:58:24 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d8162ca490so580129a34.0;
        Sun, 26 Nov 2023 16:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701046704; x=1701651504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbTOdSzmzRqpZMXBrk0eC4BBVNCbaC+V93TKtigWZJM=;
        b=KQPY4AOEDNUKtfGJh33iTLDd59TamoVUjR0WZmLwc1+c9LqPnJxt0quWJtu1zAX5ml
         npnWzFlyk9s6N6SdpcTDnu9HrwjhZ8Qgn28/xQWPde1V3eUUm38vVTZsuVu5QycqVLKp
         lSFzl6/mhnxpjnw5lPJA9d59SfDEQw2Hwzx73e0rGzE0mIwKK2Q0l5z7hy4E5raIaJzY
         gT5VN9WefSvDuGIaxI/GHFJgswkaLk8IhUgG4M4/uouS0gIcMfPkjmabventtXoDLx+o
         JtN/ttpBUc+wBUpHGpe7t51WJ/lOfy1CXV3uN8S70aJEBLdx26Gx3LmZhola/f4CV8oH
         7yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701046704; x=1701651504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbTOdSzmzRqpZMXBrk0eC4BBVNCbaC+V93TKtigWZJM=;
        b=LdxL321icjTx8r0pE1C626MMOkFrIY3jYP+7em96Pg90M3iqr8WAr/ZZl7Dptn9oJ/
         nv9Ju4ft/seYw6sZ4HdFKXyLq7uzR7sZJSE8SZHIbGi94LgiFepmvXd+eVHvNTEVL+uX
         Zxl/jI30l3+2lh8omGIZQ8UqNDl14a5+eWQPBc402eay5s/UXY9xM2FPrLpOvAWJCH6l
         hhGtgBtgjraJNKM8XJEsiwlF4yiOrPHS+rwG9xeqE+1qvbPL8/NuNQuqWFmgSXplqKsl
         uEKOL5nr4zkD5AEKbA4H4PsjhIR/ZKJHXlLqwT972TWlEZgY6kiJPIjzeJPi0P8eV8Jz
         fM3Q==
X-Gm-Message-State: AOJu0YzBflDrBXd94yMuJWqyD3Bi+jr1ZFsM+mI/j+lM05XUYTs9Oeny
        kmexNooFoCrCl4Z86KUuzNc=
X-Google-Smtp-Source: AGHT+IE6q8gpQ0nSQH1XEne2jjZEFFppdDddzreDkuA9apVcP7Is/rZGJ4huSYwnR46rcnvlPNp5hA==
X-Received: by 2002:a9d:7c85:0:b0:6bd:7a0f:5c52 with SMTP id q5-20020a9d7c85000000b006bd7a0f5c52mr7240561otn.12.1701046703587;
        Sun, 26 Nov 2023 16:58:23 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id s6-20020a4a5106000000b00581e090fd1fsm1408449ooa.8.2023.11.26.16.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 16:58:23 -0800 (PST)
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
Subject: [PATCH v2 1/4] dt-bindings: clock: sophgo: Add SG2042 bindings
Date:   Mon, 27 Nov 2023 08:58:15 +0800
Message-Id: <aea19fcddcb0aec54b2779fc99b5ac6c1e465fe0.1701044106.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701044106.git.unicorn_wang@outlook.com>
References: <cover.1701044106.git.unicorn_wang@outlook.com>
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
 .../clock/sophgo/sophgo,sg2042-clkgen.yaml    |  42 +++++
 include/dt-bindings/clock/sophgo-sg2042-clk.h | 169 ++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
 create mode 100644 include/dt-bindings/clock/sophgo-sg2042-clk.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
new file mode 100644
index 000000000000..6c0d0461e489
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo/sophgo,sg2042-clkgen.yaml#
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
+  clocks:
+    items:
+      - description: Clock Generation IC (25 MHz)
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo-sg2042-clk.h> for valid indices.
+
+  assigned-clocks: true
+
+  assigned-clock-rates: true
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+            compatible = "sophgo,sg2042-clkgen";
+            clocks = <&cgi>;
+            #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo-sg2042-clk.h b/include/dt-bindings/clock/sophgo-sg2042-clk.h
new file mode 100644
index 000000000000..a8e05c00c3bf
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo-sg2042-clk.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
+#define __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__
+
+/* Divider clocks */
+#define DIV_CLK_MPLL_RP_CPU_NORMAL_0 0
+#define DIV_CLK_MPLL_AXI_DDR_0 1
+#define DIV_CLK_FPLL_DDR01_1 2
+#define DIV_CLK_FPLL_DDR23_1 3
+#define DIV_CLK_FPLL_RP_CPU_NORMAL_1 4
+#define DIV_CLK_FPLL_50M_A53 5
+#define DIV_CLK_FPLL_TOP_RP_CMN_DIV2 6
+#define DIV_CLK_FPLL_UART_500M 7
+#define DIV_CLK_FPLL_AHB_LPC 8
+#define DIV_CLK_FPLL_EFUSE 9
+#define DIV_CLK_FPLL_TX_ETH0 10
+#define DIV_CLK_FPLL_PTP_REF_I_ETH0 11
+#define DIV_CLK_FPLL_REF_ETH0 12
+#define DIV_CLK_FPLL_EMMC 13
+#define DIV_CLK_FPLL_SD 14
+#define DIV_CLK_FPLL_TOP_AXI0 15
+#define DIV_CLK_FPLL_TOP_AXI_HSPERI 16
+#define DIV_CLK_FPLL_AXI_DDR_1 17
+#define DIV_CLK_FPLL_DIV_TIMER1 18
+#define DIV_CLK_FPLL_DIV_TIMER2 19
+#define DIV_CLK_FPLL_DIV_TIMER3 20
+#define DIV_CLK_FPLL_DIV_TIMER4 21
+#define DIV_CLK_FPLL_DIV_TIMER5 22
+#define DIV_CLK_FPLL_DIV_TIMER6 23
+#define DIV_CLK_FPLL_DIV_TIMER7 24
+#define DIV_CLK_FPLL_DIV_TIMER8 25
+#define DIV_CLK_FPLL_100K_EMMC 26
+#define DIV_CLK_FPLL_100K_SD 27
+#define DIV_CLK_FPLL_GPIO_DB 28
+#define DIV_CLK_DPLL0_DDR01_0 29
+#define DIV_CLK_DPLL1_DDR23_0 30
+
+/* Gate clocks */
+#define GATE_CLK_RP_CPU_NORMAL_DIV0 31
+#define GATE_CLK_AXI_DDR_DIV0 32
+
+#define GATE_CLK_RP_CPU_NORMAL_DIV1 33
+#define GATE_CLK_A53_50M 34
+#define GATE_CLK_TOP_RP_CMN_DIV2 35
+#define GATE_CLK_HSDMA 36
+#define GATE_CLK_EMMC_100M 37
+#define GATE_CLK_SD_100M 38
+#define GATE_CLK_TX_ETH0 39
+#define GATE_CLK_PTP_REF_I_ETH0 40
+#define GATE_CLK_REF_ETH0 41
+#define GATE_CLK_UART_500M 42
+#define GATE_CLK_EFUSE 43
+
+#define GATE_CLK_AHB_LPC 44
+#define GATE_CLK_AHB_ROM 45
+#define GATE_CLK_AHB_SF 46
+
+#define GATE_CLK_APB_UART 47
+#define GATE_CLK_APB_TIMER 48
+#define GATE_CLK_APB_EFUSE 49
+#define GATE_CLK_APB_GPIO 50
+#define GATE_CLK_APB_GPIO_INTR 51
+#define GATE_CLK_APB_SPI 52
+#define GATE_CLK_APB_I2C 53
+#define GATE_CLK_APB_WDT 54
+#define GATE_CLK_APB_PWM 55
+#define GATE_CLK_APB_RTC 56
+
+#define GATE_CLK_AXI_PCIE0 57
+#define GATE_CLK_AXI_PCIE1 58
+#define GATE_CLK_SYSDMA_AXI 59
+#define GATE_CLK_AXI_DBG_I2C 60
+#define GATE_CLK_AXI_SRAM 61
+#define GATE_CLK_AXI_ETH0 62
+#define GATE_CLK_AXI_EMMC 63
+#define GATE_CLK_AXI_SD 64
+#define GATE_CLK_TOP_AXI0 65
+#define GATE_CLK_TOP_AXI_HSPERI 66
+
+#define GATE_CLK_TIMER1 67
+#define GATE_CLK_TIMER2 68
+#define GATE_CLK_TIMER3 69
+#define GATE_CLK_TIMER4 70
+#define GATE_CLK_TIMER5 71
+#define GATE_CLK_TIMER6 72
+#define GATE_CLK_TIMER7 73
+#define GATE_CLK_TIMER8 74
+#define GATE_CLK_100K_EMMC 75
+#define GATE_CLK_100K_SD 76
+#define GATE_CLK_GPIO_DB 77
+
+#define GATE_CLK_AXI_DDR_DIV1 78
+#define GATE_CLK_DDR01_DIV1 79
+#define GATE_CLK_DDR23_DIV1 80
+/* DPLL0 */
+#define GATE_CLK_DDR01_DIV0 81
+/* DPLL1 */
+#define GATE_CLK_DDR23_DIV0 82
+
+#define GATE_CLK_DDR01 83
+#define GATE_CLK_DDR23 84
+#define GATE_CLK_RP_CPU_NORMAL 85
+#define GATE_CLK_AXI_DDR 86
+#define GATE_CLK_RXU0 87
+#define GATE_CLK_RXU1 88
+#define GATE_CLK_RXU2 89
+#define GATE_CLK_RXU3 90
+#define GATE_CLK_RXU4 91
+#define GATE_CLK_RXU5 92
+#define GATE_CLK_RXU6 93
+#define GATE_CLK_RXU7 94
+#define GATE_CLK_RXU8 95
+#define GATE_CLK_RXU9 96
+#define GATE_CLK_RXU10 97
+#define GATE_CLK_RXU11 98
+#define GATE_CLK_RXU12 99
+#define GATE_CLK_RXU13 100
+#define GATE_CLK_RXU14 101
+#define GATE_CLK_RXU15 102
+#define GATE_CLK_RXU16 103
+#define GATE_CLK_RXU17 104
+#define GATE_CLK_RXU18 105
+#define GATE_CLK_RXU19 106
+#define GATE_CLK_RXU20 107
+#define GATE_CLK_RXU21 108
+#define GATE_CLK_RXU22 109
+#define GATE_CLK_RXU23 110
+#define GATE_CLK_RXU24 111
+#define GATE_CLK_RXU25 112
+#define GATE_CLK_RXU26 113
+#define GATE_CLK_RXU27 114
+#define GATE_CLK_RXU28 115
+#define GATE_CLK_RXU29 116
+#define GATE_CLK_RXU30 117
+#define GATE_CLK_RXU31 118
+#define GATE_CLK_MP0 119
+#define GATE_CLK_MP1 120
+#define GATE_CLK_MP2 121
+#define GATE_CLK_MP3 122
+#define GATE_CLK_MP4 123
+#define GATE_CLK_MP5 124
+#define GATE_CLK_MP6 125
+#define GATE_CLK_MP7 126
+#define GATE_CLK_MP8 127
+#define GATE_CLK_MP9 128
+#define GATE_CLK_MP10 129
+#define GATE_CLK_MP11 130
+#define GATE_CLK_MP12 131
+#define GATE_CLK_MP13 132
+#define GATE_CLK_MP14 133
+#define GATE_CLK_MP15 134
+
+/* MUX clocks */
+#define MUX_CLK_DDR01 135
+#define MUX_CLK_DDR23 136
+#define MUX_CLK_RP_CPU_NORMAL 137
+#define MUX_CLK_AXI_DDR 138
+
+/* PLL clocks */
+#define MPLL_CLK	139
+#define FPLL_CLK	140
+#define DPLL0_CLK	141
+#define DPLL1_CLK	142
+
+#endif /* __DT_BINDINGS_CLOCK_SOPHGO_SG2042_H__ */
-- 
2.25.1

