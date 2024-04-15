Return-Path: <linux-kernel+bounces-144662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571C8A48EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673DE1C22E06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E02224CF;
	Mon, 15 Apr 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgX/Vu/Y"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC81E504;
	Mon, 15 Apr 2024 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165794; cv=none; b=RXpLijae4R1TfHkbsYT3R/BAdQndtKTP0QWBcoo0IE1Q9WAH8qWZt0AhWG0W027kZ2ujK+MPzKbimhpKcfeEsRf2ZFblIHWrWlTzWyL44grxUajGmqx153/PqxrixHddJwmbPHQ+x2P1nEd/phYwNG7cOep5zQYEf1gYirelczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165794; c=relaxed/simple;
	bh=p1DMI/r2cpeir1sctnhIdWVZSjEW/EJombAHWt9fUP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJJUf76uRzfDZEIz+End402GKG3uoeAZ7tcXKf0fAHp91tsEfoXRvSakaDQRU0FLEFE3/rrwVl3pBWeBsOAhJqI/QHi0GS5ciqVX/xDmicS3K+JTB7CCz76fSK2gIiTwJcBxu9ffNk5JXi144ltWT5gIEwYvWG5ky9wTlBUmPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgX/Vu/Y; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa691c2349so2018355eaf.1;
        Mon, 15 Apr 2024 00:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713165792; x=1713770592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkJXNBJTmby2h3ZHeW5LvDqnR7RXSun3VQ0kpcOw0aw=;
        b=MgX/Vu/YHEP9O8VNXD2RTHnxibTQH1om/GSm798CJqD2FCpQ0nfLfAbALlpgNTxh62
         SoOF4Z/vVPPGQOhBjCTQU1x1ze0zdFKDNoLqFlP6D/2PjjVwnqDz2gJ0IJ1gVqIb87is
         bSXHILe5o+mvshhldwLZWwgE77QlBxE3iqHIFbZ4b0jf05N4k+LVvWNZYVf1YoTR5e2g
         oXQ2+xaGmK7VRS6zRPYXJyr8HPqXfH7bw7b8gT5Zr9a2HVLwrvm/DojMQ/AxCsz1ze+W
         5/gdIxwLhDKjT4kfD+HLpPqx1XLcgJfDnM2Y6HfkgtBZj3yVyp9jLgtdKCoaIXsOmRvO
         Z0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165792; x=1713770592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkJXNBJTmby2h3ZHeW5LvDqnR7RXSun3VQ0kpcOw0aw=;
        b=E0yWq9ueKHbkYMWXeDuTa5N6g4B8iwV+fJmzNS1GWMYrV38+yPEFfxpyPAJzVuDbKb
         eM5WTgD2EbZecLEBJNY12YWcT/yjtMWyyPAasQhaLDuVtouu3KChyEDkuy2rfqpCO0Nt
         ESvDUMKPE+dqK3I9gNfiGypJ2S3pGHPBxCBYW4QyXvN7UenvrhqwYUR2hKfXkljaBE1U
         aCuKxWCC5bFDb4yuO0ZexRFcDW7TzCfwEDsvdTT4n5TdKR1ImLNSKMhejLuJ/YfKqjVW
         mQ6HaaZU2Wuvt1qw85NuOveiLUX9EAbzewyrIrausun9xmbvgjddyylvIBhKYA2rT8se
         cCQw==
X-Forwarded-Encrypted: i=1; AJvYcCVyOMrpSrlPkJMmDzy0rjkDrrTGW6hoCN8Y8DzsaFbFaM5GqGrLX3qIC+HEZCYON8KgqNCx1eck1Qyo0kLk90bQWUhVwoQOJJee6UQhcguD8Dm+uvbPeZoRpVZas3aXq2AZZfaVSyHAzcIFuRvQQx+MApgQwvDHi8qVaP9C4x57qMNIeg==
X-Gm-Message-State: AOJu0YxrJN9Kzyy5Z1mLbrbPJ2F+EFU/4y1y2e3EY9EmyasqhJWexrg7
	rshL3lk+ypRT+dJwNMDQppRr+MZhE9JpAcNmutpvwq/a9ttP06/s
X-Google-Smtp-Source: AGHT+IF45qC2Luf6ddj/QsNRCEFdZomI6TvFUTAqCvGlUjwNJVzwxRb3L44fwmoaEtWwAteqqvLo8g==
X-Received: by 2002:a4a:4e81:0:b0:5ac:9f86:cc0d with SMTP id r123-20020a4a4e81000000b005ac9f86cc0dmr2428652ooa.6.1713165792014;
        Mon, 15 Apr 2024 00:23:12 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id ch7-20020a0568200a0700b005a9ceae0611sm1977688oob.17.2024.04.15.00.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:23:11 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v14 3/5] dt-bindings: clock: sophgo: add clkgen for SG2042
Date: Mon, 15 Apr 2024 15:23:04 +0800
Message-Id: <40b2de0d57faf2d3cc4f40fe4898556a1d96200c.1713164546.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713164546.git.unicorn_wang@outlook.com>
References: <cover.1713164546.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the clock generator of divider/mux and gates working
for other subsystem than RP subsystem for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  49 ++++++++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 111 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
new file mode 100644
index 000000000000..e31dece67215
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-clkgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Clock Generator for divider/mux/gate
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
+  clocks:
+    items:
+      - description: Main PLL
+      - description: Fixed PLL
+      - description: DDR PLL 0
+      - description: DDR PLL 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-clkgen.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@30012000 {
+      compatible = "sophgo,sg2042-clkgen";
+      reg = <0x30012000 0x1000>;
+      clocks = <&pllclk 0>,
+               <&pllclk 1>,
+               <&pllclk 2>,
+               <&pllclk 3>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-clkgen.h b/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
new file mode 100644
index 000000000000..84f7857317a2
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-clkgen.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_CLKGEN_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_CLKGEN_H__
+
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
+
+#define GATE_CLK_DDR01_DIV0		81
+#define GATE_CLK_DDR23_DIV0		82
+
+#define GATE_CLK_DDR01			83
+#define GATE_CLK_DDR23			84
+#define GATE_CLK_RP_CPU_NORMAL		85
+#define GATE_CLK_AXI_DDR		86
+
+#define MUX_CLK_DDR01			87
+#define MUX_CLK_DDR23			88
+#define MUX_CLK_RP_CPU_NORMAL		89
+#define MUX_CLK_AXI_DDR			90
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_CLKGEN_H__ */
-- 
2.25.1


