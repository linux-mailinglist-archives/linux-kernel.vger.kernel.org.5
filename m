Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B37D93DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjJ0Jhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345629AbjJ0Jha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:37:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9FDAF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:37:26 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so24530451fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698399445; x=1699004245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qov0tCQqv9WLtyxzhfEqLbPjUez5vOCW+X4IeDwzJ+Q=;
        b=dipLsXQiW778VAOx7qXtWlA53rnFy+cjomSPU3fpAVxgnJ3T5BArbAf8YebExhQ0Kk
         WivkcD2TQgYquWmM9vBbdHiAguMay4ZzLQK0BAuw02t3kW2DSHmNP6uM8C55+vFzfbzB
         sBV5VotxdoHhVp6s0W4jy7koou6ZO+yylNAa+X2Mx/m4/5I5Wb4Vx4aodkBiOOY5a31J
         CsivYV+3GfPrnSvOJ7YczJUKFP3GtYiMIgeIZoaAmD7H7Ba/2ASNS1BxeP9xYEeI6iMr
         Rwa6oAp3/a0GdexqhUUx3ZyYKAkonGXHmh9isxMNYsEmntb+2Pb+IaaZnOxckGiu7Mcn
         yH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399445; x=1699004245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qov0tCQqv9WLtyxzhfEqLbPjUez5vOCW+X4IeDwzJ+Q=;
        b=Uk1fEbRN2+G1SowP1QqDSVDXFUT66+IXuNvr6UByP4sfTd12CHfL/O6TycHCC4kyGY
         OKF09eUf6zknMNamPXCu+YR643XQIXKmuSu89iI9SPUyEh9ocyt0JoAMqNY33Owi90V+
         EIMaHLJ3GM10Nzt5G7m48/Em3w1CpNu6YCb/0yjFdVAkhxg/BKJhgcNpm54s/CLgn4AM
         JUpm26KYVE02T73b+6KXuyI791lOIBjbpBfs6Z196QQhwtiMCFruDJvDZdpr3fgGZ8Y8
         kKk8bpb2VgM6tR44UNi7PM9ANt4YIfYlVFOFhoD3U8O3DBICx/w19zkD8ATfBQPY8y4f
         3IHQ==
X-Gm-Message-State: AOJu0Yw7iniyiLQOH/YAjFed1fhA5wpvq+7MkQnQN2rnRrh7PMPkCP5j
        zsB0y0wcyIsPvUploA+SGNjLuQ==
X-Google-Smtp-Source: AGHT+IE1TDr8ZeuiZBOVcJAtLiHzTiITSDEkqWEhU9cPtgQXP+XV9+6ZJq/AzthVGdRQZzWOpDk1wA==
X-Received: by 2002:a2e:9b0b:0:b0:2b9:36d5:729c with SMTP id u11-20020a2e9b0b000000b002b936d5729cmr1650591lji.47.1698399444820;
        Fri, 27 Oct 2023 02:37:24 -0700 (PDT)
Received: from krzk-bin.. ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id s26-20020a2e151a000000b002c12c2094e4sm223341ljd.74.2023.10.27.02.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:37:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS
Date:   Fri, 27 Oct 2023 11:36:15 +0200
Message-Id: <20231027093615.140656-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027093615.140656-1-krzysztof.kozlowski@linaro.org>
References: <20231027093615.140656-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the pin controller in Low Power Audio SubSystem (LPASS)
of Qualcomm SM8650 SoC.

Notable differences against SM8550 LPASS pin controller:
1. Additional address space for slew rate thus driver uses
   LPI_FLAG_SLEW_RATE_SAME_REG and sets slew rate via different
   register.

2. Two new pin mux functions: qca_swr_clk and qca_swr_data

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig                  |  10 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 .../pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c   | 255 ++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index f84c0d3b7951..e0f2829c15d6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -124,4 +124,14 @@ config PINCTRL_SM8550_LPASS_LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SM8550
 	  platform.
 
+config PINCTRL_SM8650_LPASS_LPI
+	tristate "Qualcomm Technologies Inc SM8550 LPASS LPI pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	depends on PINCTRL_LPASS_LPI
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
+	  (Low Power Island) found on the Qualcomm Technologies Inc SM8650
+	  platform.
+
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 5910e08c84ce..f7b410e59bf1 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -58,5 +58,6 @@ obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
 obj-$(CONFIG_PINCTRL_SM8450_LPASS_LPI) += pinctrl-sm8450-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8550) += pinctrl-sm8550.o
 obj-$(CONFIG_PINCTRL_SM8550_LPASS_LPI) += pinctrl-sm8550-lpass-lpi.o
+obj-$(CONFIG_PINCTRL_SM8650_LPASS_LPI) += pinctrl-sm8650-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SC8280XP_LPASS_LPI) += pinctrl-sc8280xp-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c
new file mode 100644
index 000000000000..6e4be91ff085
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Linaro Ltd.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-lpass-lpi.h"
+
+enum lpass_lpi_functions {
+	LPI_MUX_dmic1_clk,
+	LPI_MUX_dmic1_data,
+	LPI_MUX_dmic2_clk,
+	LPI_MUX_dmic2_data,
+	LPI_MUX_dmic3_clk,
+	LPI_MUX_dmic3_data,
+	LPI_MUX_dmic4_clk,
+	LPI_MUX_dmic4_data,
+	LPI_MUX_i2s0_clk,
+	LPI_MUX_i2s0_data,
+	LPI_MUX_i2s0_ws,
+	LPI_MUX_i2s1_clk,
+	LPI_MUX_i2s1_data,
+	LPI_MUX_i2s1_ws,
+	LPI_MUX_i2s2_clk,
+	LPI_MUX_i2s2_data,
+	LPI_MUX_i2s2_ws,
+	LPI_MUX_i2s3_clk,
+	LPI_MUX_i2s3_data,
+	LPI_MUX_i2s3_ws,
+	LPI_MUX_i2s4_clk,
+	LPI_MUX_i2s4_data,
+	LPI_MUX_i2s4_ws,
+	LPI_MUX_qca_swr_clk,
+	LPI_MUX_qca_swr_data,
+	LPI_MUX_slimbus_clk,
+	LPI_MUX_slimbus_data,
+	LPI_MUX_swr_rx_clk,
+	LPI_MUX_swr_rx_data,
+	LPI_MUX_swr_tx_clk,
+	LPI_MUX_swr_tx_data,
+	LPI_MUX_wsa_swr_clk,
+	LPI_MUX_wsa_swr_data,
+	LPI_MUX_wsa2_swr_clk,
+	LPI_MUX_wsa2_swr_data,
+	LPI_MUX_ext_mclk1_a,
+	LPI_MUX_ext_mclk1_b,
+	LPI_MUX_ext_mclk1_c,
+	LPI_MUX_ext_mclk1_d,
+	LPI_MUX_ext_mclk1_e,
+	LPI_MUX_gpio,
+	LPI_MUX__,
+};
+
+static int gpio0_pins[] = { 0 };
+static int gpio1_pins[] = { 1 };
+static int gpio2_pins[] = { 2 };
+static int gpio3_pins[] = { 3 };
+static int gpio4_pins[] = { 4 };
+static int gpio5_pins[] = { 5 };
+static int gpio6_pins[] = { 6 };
+static int gpio7_pins[] = { 7 };
+static int gpio8_pins[] = { 8 };
+static int gpio9_pins[] = { 9 };
+static int gpio10_pins[] = { 10 };
+static int gpio11_pins[] = { 11 };
+static int gpio12_pins[] = { 12 };
+static int gpio13_pins[] = { 13 };
+static int gpio14_pins[] = { 14 };
+static int gpio15_pins[] = { 15 };
+static int gpio16_pins[] = { 16 };
+static int gpio17_pins[] = { 17 };
+static int gpio18_pins[] = { 18 };
+static int gpio19_pins[] = { 19 };
+static int gpio20_pins[] = { 20 };
+static int gpio21_pins[] = { 21 };
+static int gpio22_pins[] = { 22 };
+
+static const struct pinctrl_pin_desc sm8650_lpi_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "gpio12"),
+	PINCTRL_PIN(13, "gpio13"),
+	PINCTRL_PIN(14, "gpio14"),
+	PINCTRL_PIN(15, "gpio15"),
+	PINCTRL_PIN(16, "gpio16"),
+	PINCTRL_PIN(17, "gpio17"),
+	PINCTRL_PIN(18, "gpio18"),
+	PINCTRL_PIN(19, "gpio19"),
+	PINCTRL_PIN(20, "gpio20"),
+	PINCTRL_PIN(21, "gpio21"),
+	PINCTRL_PIN(22, "gpio22"),
+};
+
+static const char * const gpio_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
+	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
+	"gpio22",
+};
+
+static const char * const dmic1_clk_groups[] = { "gpio6" };
+static const char * const dmic1_data_groups[] = { "gpio7" };
+static const char * const dmic2_clk_groups[] = { "gpio8" };
+static const char * const dmic2_data_groups[] = { "gpio9" };
+static const char * const dmic3_clk_groups[] = { "gpio12" };
+static const char * const dmic3_data_groups[] = { "gpio13" };
+static const char * const dmic4_clk_groups[] = { "gpio17" };
+static const char * const dmic4_data_groups[] = { "gpio18" };
+static const char * const i2s0_clk_groups[] = { "gpio0" };
+static const char * const i2s0_ws_groups[] = { "gpio1" };
+static const char * const i2s0_data_groups[] = { "gpio2", "gpio3", "gpio4", "gpio5" };
+static const char * const i2s1_clk_groups[] = { "gpio6" };
+static const char * const i2s1_ws_groups[] = { "gpio7" };
+static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
+static const char * const i2s2_clk_groups[] = { "gpio10" };
+static const char * const i2s2_ws_groups[] = { "gpio11" };
+static const char * const i2s2_data_groups[] = { "gpio15", "gpio16" };
+static const char * const i2s3_clk_groups[] = { "gpio12" };
+static const char * const i2s3_ws_groups[] = { "gpio13" };
+static const char * const i2s3_data_groups[] = { "gpio17", "gpio18" };
+static const char * const i2s4_clk_groups[] = { "gpio19"};
+static const char * const i2s4_ws_groups[] = { "gpio20"};
+static const char * const i2s4_data_groups[] = { "gpio21", "gpio22"};
+static const char * const qca_swr_clk_groups[] = { "gpio19" };
+static const char * const qca_swr_data_groups[] = { "gpio20" };
+static const char * const slimbus_clk_groups[] = { "gpio19"};
+static const char * const slimbus_data_groups[] = { "gpio20"};
+static const char * const swr_tx_clk_groups[] = { "gpio0" };
+static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio14" };
+static const char * const swr_rx_clk_groups[] = { "gpio3" };
+static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5", "gpio15" };
+static const char * const wsa_swr_clk_groups[] = { "gpio10" };
+static const char * const wsa_swr_data_groups[] = { "gpio11" };
+static const char * const wsa2_swr_clk_groups[] = { "gpio15" };
+static const char * const wsa2_swr_data_groups[] = { "gpio16" };
+static const char * const ext_mclk1_c_groups[] = { "gpio5" };
+static const char * const ext_mclk1_b_groups[] = { "gpio9" };
+static const char * const ext_mclk1_a_groups[] = { "gpio13" };
+static const char * const ext_mclk1_d_groups[] = { "gpio14" };
+static const char * const ext_mclk1_e_groups[] = { "gpio22" };
+
+static const struct lpi_pingroup sm8650_groups[] = {
+	LPI_PINGROUP(0, 11, swr_tx_clk, i2s0_clk, _, _),
+	LPI_PINGROUP(1, 11, swr_tx_data, i2s0_ws, _, _),
+	LPI_PINGROUP(2, 11, swr_tx_data, i2s0_data, _, _),
+	LPI_PINGROUP(3, 11, swr_rx_clk, i2s0_data, _, _),
+	LPI_PINGROUP(4, 11, swr_rx_data, i2s0_data, _, _),
+	LPI_PINGROUP(5, 11, swr_rx_data, ext_mclk1_c, i2s0_data, _),
+	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
+	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
+	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
+	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, ext_mclk1_b, _),
+	LPI_PINGROUP(10, 11, i2s2_clk, wsa_swr_clk, _, _),
+	LPI_PINGROUP(11, 11, i2s2_ws, wsa_swr_data, _, _),
+	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s3_clk, _, _),
+	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s3_ws, ext_mclk1_a, _),
+	LPI_PINGROUP(14, 11, swr_tx_data, ext_mclk1_d, _, _),
+	LPI_PINGROUP(15, 11, i2s2_data, wsa2_swr_clk, _, _),
+	LPI_PINGROUP(16, 11, i2s2_data, wsa2_swr_data, _, _),
+	LPI_PINGROUP(17, LPI_NO_SLEW, dmic4_clk, i2s3_data, _, _),
+	LPI_PINGROUP(18, LPI_NO_SLEW, dmic4_data, i2s3_data, _, _),
+	LPI_PINGROUP(19, 11, i2s4_clk, slimbus_clk, qca_swr_clk, _),
+	LPI_PINGROUP(20, 11, i2s4_ws, slimbus_data, qca_swr_data, _),
+	LPI_PINGROUP(21, LPI_NO_SLEW, i2s4_data, _, _, _),
+	LPI_PINGROUP(22, LPI_NO_SLEW, i2s4_data, ext_mclk1_e, _, _),
+};
+
+static const struct lpi_function sm8650_functions[] = {
+	LPI_FUNCTION(gpio),
+	LPI_FUNCTION(dmic1_clk),
+	LPI_FUNCTION(dmic1_data),
+	LPI_FUNCTION(dmic2_clk),
+	LPI_FUNCTION(dmic2_data),
+	LPI_FUNCTION(dmic3_clk),
+	LPI_FUNCTION(dmic3_data),
+	LPI_FUNCTION(dmic4_clk),
+	LPI_FUNCTION(dmic4_data),
+	LPI_FUNCTION(i2s0_clk),
+	LPI_FUNCTION(i2s0_data),
+	LPI_FUNCTION(i2s0_ws),
+	LPI_FUNCTION(i2s1_clk),
+	LPI_FUNCTION(i2s1_data),
+	LPI_FUNCTION(i2s1_ws),
+	LPI_FUNCTION(i2s2_clk),
+	LPI_FUNCTION(i2s2_data),
+	LPI_FUNCTION(i2s2_ws),
+	LPI_FUNCTION(i2s3_clk),
+	LPI_FUNCTION(i2s3_data),
+	LPI_FUNCTION(i2s3_ws),
+	LPI_FUNCTION(i2s4_clk),
+	LPI_FUNCTION(i2s4_data),
+	LPI_FUNCTION(i2s4_ws),
+	LPI_FUNCTION(qca_swr_clk),
+	LPI_FUNCTION(qca_swr_data),
+	LPI_FUNCTION(slimbus_clk),
+	LPI_FUNCTION(slimbus_data),
+	LPI_FUNCTION(swr_rx_clk),
+	LPI_FUNCTION(swr_rx_data),
+	LPI_FUNCTION(swr_tx_clk),
+	LPI_FUNCTION(swr_tx_data),
+	LPI_FUNCTION(wsa_swr_clk),
+	LPI_FUNCTION(wsa_swr_data),
+	LPI_FUNCTION(wsa2_swr_clk),
+	LPI_FUNCTION(wsa2_swr_data),
+	LPI_FUNCTION(ext_mclk1_a),
+	LPI_FUNCTION(ext_mclk1_b),
+	LPI_FUNCTION(ext_mclk1_c),
+	LPI_FUNCTION(ext_mclk1_d),
+	LPI_FUNCTION(ext_mclk1_e),
+};
+
+static const struct lpi_pinctrl_variant_data sm8650_lpi_data = {
+	.pins = sm8650_lpi_pins,
+	.npins = ARRAY_SIZE(sm8650_lpi_pins),
+	.groups = sm8650_groups,
+	.ngroups = ARRAY_SIZE(sm8650_groups),
+	.functions = sm8650_functions,
+	.nfunctions = ARRAY_SIZE(sm8650_functions),
+	.flags = LPI_FLAG_SLEW_RATE_SAME_REG,
+};
+
+static const struct of_device_id lpi_pinctrl_of_match[] = {
+	{
+	       .compatible = "qcom,sm8650-lpass-lpi-pinctrl",
+	       .data = &sm8650_lpi_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
+
+static struct platform_driver lpi_pinctrl_driver = {
+	.driver = {
+		   .name = "qcom-sm8650-lpass-lpi-pinctrl",
+		   .of_match_table = lpi_pinctrl_of_match,
+	},
+	.probe = lpi_pinctrl_probe,
+	.remove_new = lpi_pinctrl_remove,
+};
+
+module_platform_driver(lpi_pinctrl_driver);
+MODULE_DESCRIPTION("Qualcomm SM8650 LPI GPIO pin control driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

