Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B18B75DB34
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGVIxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGVIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:53:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D806426A5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:52:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso40754821fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015976; x=1690620776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULv1gtSBz2/RqVh7g8QECl3MG95lu7C/IPGuU3tUbaY=;
        b=k1vVS21UXPGtqU4w8b4uSDZhNRoYS55f+4kCQWo9PjRTj1Dz+VVWIxsLoXunNf9M8Q
         okcq8kT/+CbV1sFSv1KatIrWc4Shkhn2F5bT11TjLJgYxmCaljv5qEVapEHICoTNfKag
         7xG3+WqK5TI7tazx/kGQ5cUYSRPjinatMUHExUnnB5fCCzgaoeY5cbOCnFyNlsJeyVSS
         pH/kLw932jHTecKkMfPqLfjo6JMFss0MQSMQi47jiUoMw5tQbgQcmg1ATTvUY+Bg+9BS
         ymyIAISc1w45lXaDOkpWplad0O+wp51zSCbBE9T4C3zdCVoCPAOkH5Oz/2z7D5s5GMGA
         6Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015976; x=1690620776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULv1gtSBz2/RqVh7g8QECl3MG95lu7C/IPGuU3tUbaY=;
        b=hA2nTRRE2Omd7nRDTSAGDsLSdq33mNPoLRvBBLZFRali32YlNUVIVHt2fbhxdhzmu1
         S//1PUeMDSDoBX7ZNBUny2Twvgpn/QOolJd354qWZCtAK9BX6y810NU9A62W4Z6+SMtf
         0295qcC4RUSy9FbPwKsDV6png/1WfvX/IEt1sURhN1/iIQnUKYTiufDt4NYSFbCiT+As
         k+vqrZyTeL1s7yKonkjo4Z2yxYfAP8dee/RV8/mXhlwuOqXfH1G2tSXb8VM5ZH67FvJ7
         KZtc9PlJqmsnI4Xo1PF5UPLjoZsg4xqJz/+XdJWCPvuFQ4LlsVL2R9PQbEIrjGyNwcft
         8mcQ==
X-Gm-Message-State: ABy/qLaAk081/l5hMl+G+nX28Y4YFJ4DZwk39RhGD3ams9xLXqO4jvrn
        uOusYFw/82KD+7PqyyDRiRqSyQ==
X-Google-Smtp-Source: APBJJlFJnEnHtLLfzuRlWHHugK/HRdGcBRcQwh/qJshebXbeoQEHIYuYEJx+jRXuC/8EblgEHi9ANg==
X-Received: by 2002:ac2:48aa:0:b0:4fd:d481:ff35 with SMTP id u10-20020ac248aa000000b004fdd481ff35mr2599347lfg.42.1690015975833;
        Sat, 22 Jul 2023 01:52:55 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id x9-20020ac259c9000000b004fbf5242e8bsm1107034lfn.231.2023.07.22.01.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:52:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 22 Jul 2023 10:52:46 +0200
Subject: [PATCH 2/3] pinctrl: qcom: Introduce SM6115 LPI pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-topic-6115_lpasstlmm-v1-2-32d1643d8774@linaro.org>
References: <20230722-topic-6115_lpasstlmm-v1-0-32d1643d8774@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v1-0-32d1643d8774@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690015971; l=8437;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dUlMVDn4FZ150DyZa1NExE/bjgAU68qgmu4DlhznUvU=;
 b=d75pp8MQv1q3z00d0F6/TjnrQmSkBQ9xWd+nml643W1bEH74VwcCLYegiefljSTAHoEmRIao7
 TA9GDkbunWuB7u0wMLxIJp4Jnh1AUHP8ThzRC9ghREd7igGtjxh0sXK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the pin controller block on SM6115's Low Power Island.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig                    |   9 ++
 drivers/pinctrl/qcom/Makefile                   |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c | 175 ++++++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 634c75336983..c6ef38032c05 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -68,6 +68,15 @@ config PINCTRL_SC7280_LPASS_LPI
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
 
+config PINCTRL_SM6115_LPASS_LPI
+	tristate "Qualcomm Technologies Inc SM6115 LPASS LPI pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	depends on PINCTRL_LPASS_LPI
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
+	  (Low Power Island) found on the Qualcomm Technologies Inc SM6115 platform.
+
 config PINCTRL_SM8250_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 426ddbf35f32..d1179d8b2c42 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_PINCTRL_SDX55) += pinctrl-sdx55.o
 obj-$(CONFIG_PINCTRL_SDX65) += pinctrl-sdx65.o
 obj-$(CONFIG_PINCTRL_SDX75) += pinctrl-sdx75.o
 obj-$(CONFIG_PINCTRL_SM6115) += pinctrl-sm6115.o
+obj-$(CONFIG_PINCTRL_SM6115_LPASS_LPI) += pinctrl-sm6115-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM6125) += pinctrl-sm6125.o
 obj-$(CONFIG_PINCTRL_SM6350) += pinctrl-sm6350.o
 obj-$(CONFIG_PINCTRL_SM6375) += pinctrl-sm6375.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
new file mode 100644
index 000000000000..2b09bf171a2c
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020, 2023 Linaro Ltd.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-lpass-lpi.h"
+
+enum lpass_lpi_functions {
+	LPI_MUX_dmic01_clk,
+	LPI_MUX_dmic01_data,
+	LPI_MUX_dmic23_clk,
+	LPI_MUX_dmic23_data,
+	LPI_MUX_i2s1_clk,
+	LPI_MUX_i2s1_data,
+	LPI_MUX_i2s1_ws,
+	LPI_MUX_i2s2_clk,
+	LPI_MUX_i2s2_data,
+	LPI_MUX_i2s2_ws,
+	LPI_MUX_i2s3_clk,
+	LPI_MUX_i2s3_data,
+	LPI_MUX_i2s3_ws,
+	LPI_MUX_qua_mi2s_data,
+	LPI_MUX_qua_mi2s_sclk,
+	LPI_MUX_qua_mi2s_ws,
+	LPI_MUX_swr_rx_clk,
+	LPI_MUX_swr_rx_data,
+	LPI_MUX_swr_tx_clk,
+	LPI_MUX_swr_tx_data,
+	LPI_MUX_wsa_mclk,
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
+
+static const struct pinctrl_pin_desc sm6115_lpi_pins[] = {
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
+};
+
+static const char * const dmic01_clk_groups[] = { "gpio6" };
+static const char * const dmic01_data_groups[] = { "gpio7" };
+static const char * const dmic23_clk_groups[] = { "gpio8" };
+static const char * const dmic23_data_groups[] = { "gpio9" };
+static const char * const i2s1_clk_groups[] = { "gpio6" };
+static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
+static const char * const i2s1_ws_groups[] = { "gpio7" };
+static const char * const i2s2_clk_groups[] = { "gpio10" };
+static const char * const i2s2_data_groups[] = { "gpio12", "gpio13" };
+static const char * const i2s2_ws_groups[] = { "gpio11" };
+static const char * const i2s3_clk_groups[] = { "gpio14" };
+static const char * const i2s3_data_groups[] = { "gpio16", "gpio17" };
+static const char * const i2s3_ws_groups[] = { "gpio15" };
+static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4", "gpio5" };
+static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
+static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
+static const char * const swr_rx_clk_groups[] = { "gpio3" };
+static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
+static const char * const swr_tx_clk_groups[] = { "gpio0" };
+static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2" };
+static const char * const wsa_mclk_groups[] = { "gpio18" };
+
+static const struct lpi_pingroup sm6115_groups[] = {
+	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
+	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
+	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
+	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
+	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
+	LPI_PINGROUP(5, 12, swr_rx_data, _, qua_mi2s_data, _),
+	LPI_PINGROUP(6, LPI_NO_SLEW, dmic01_clk, i2s1_clk, _, _),
+	LPI_PINGROUP(7, LPI_NO_SLEW, dmic01_data, i2s1_ws, _, _),
+	LPI_PINGROUP(8, LPI_NO_SLEW, dmic23_clk, i2s1_data, _, _),
+	LPI_PINGROUP(9, LPI_NO_SLEW, dmic23_data, i2s1_data, _, _),
+	LPI_PINGROUP(10, LPI_NO_SLEW, i2s2_clk, _, _, _),
+	LPI_PINGROUP(11, LPI_NO_SLEW, i2s2_ws, _, _, _),
+	LPI_PINGROUP(12, LPI_NO_SLEW, _, i2s2_data, _, _),
+	LPI_PINGROUP(13, LPI_NO_SLEW, _, i2s2_data, _, _),
+	LPI_PINGROUP(14, LPI_NO_SLEW, i2s3_clk, _, _, _),
+	LPI_PINGROUP(15, LPI_NO_SLEW, i2s3_ws, _, _, _),
+	LPI_PINGROUP(16, LPI_NO_SLEW, i2s3_data, _, _, _),
+	LPI_PINGROUP(17, LPI_NO_SLEW, i2s3_data, _, _, _),
+	LPI_PINGROUP(18, 14, wsa_mclk, _, _, _),
+};
+
+static const struct lpi_function sm6115_functions[] = {
+	LPI_FUNCTION(dmic01_clk),
+	LPI_FUNCTION(dmic01_data),
+	LPI_FUNCTION(dmic23_clk),
+	LPI_FUNCTION(dmic23_data),
+	LPI_FUNCTION(i2s1_clk),
+	LPI_FUNCTION(i2s1_data),
+	LPI_FUNCTION(i2s1_ws),
+	LPI_FUNCTION(i2s2_clk),
+	LPI_FUNCTION(i2s2_data),
+	LPI_FUNCTION(i2s2_ws),
+	LPI_FUNCTION(i2s3_clk),
+	LPI_FUNCTION(i2s3_data),
+	LPI_FUNCTION(i2s3_ws),
+	LPI_FUNCTION(qua_mi2s_data),
+	LPI_FUNCTION(qua_mi2s_sclk),
+	LPI_FUNCTION(qua_mi2s_ws),
+	LPI_FUNCTION(swr_rx_clk),
+	LPI_FUNCTION(swr_rx_data),
+	LPI_FUNCTION(swr_tx_clk),
+	LPI_FUNCTION(swr_tx_data),
+	LPI_FUNCTION(wsa_mclk),
+};
+
+static const struct lpi_pinctrl_variant_data sm6115_lpi_data = {
+	.pins = sm6115_lpi_pins,
+	.npins = ARRAY_SIZE(sm6115_lpi_pins),
+	.groups = sm6115_groups,
+	.ngroups = ARRAY_SIZE(sm6115_groups),
+	.functions = sm6115_functions,
+	.nfunctions = ARRAY_SIZE(sm6115_functions),
+};
+
+static const struct of_device_id lpi_pinctrl_of_match[] = {
+	{ .compatible = "qcom,sm6115-lpass-lpi-pinctrl", .data = &sm6115_lpi_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
+
+static struct platform_driver lpi_pinctrl_driver = {
+	.driver = {
+		.name = "qcom-sm6115-lpass-lpi-pinctrl",
+		.of_match_table = lpi_pinctrl_of_match,
+	},
+	.probe = lpi_pinctrl_probe,
+	.remove = lpi_pinctrl_remove,
+};
+
+module_platform_driver(lpi_pinctrl_driver);
+MODULE_DESCRIPTION("QTI SM6115 LPI GPIO pin control driver");
+MODULE_LICENSE("GPL");

-- 
2.41.0

