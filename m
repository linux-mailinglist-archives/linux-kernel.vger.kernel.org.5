Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949A27F4806
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbjKVNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343990AbjKVNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:42:30 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D30D47
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:42:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5480edd7026so8895942a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700660541; x=1701265341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6mwhJa9jnygGPwNgYYVXv0NiFDAvRFSYIV1gmbnIDI=;
        b=oUlEpnlGNqBKaA4L/oDpvV8+fd10uzxrtRrc5rhHZdtsEWOfn8MwJddXG6ZmZYCq0z
         t7md5pvrjwSCQ/N2cQ/QoXbND/BMZkGB6KN+42g8Nn/lCCjcNZDYFWtVTyNTHUCo6xVM
         3hSI8ES8HdbWKHGrkdmXFFxQPk32WYgcTobImcBiOmCCTrYLR8cKP6kX3nghnNUEnTcp
         QlnQ/N0HbXbyBvd8Htazjzg1u3yfo/QLixfSCEI2PjnuooVSReoTcfsUnr5PRmOJexDe
         ohb1kNUIJHdL1m0MCCcuiy2Iq2kTspD5Pg/WfLWyEgbgbMuB7P12cKMcD0ZP4JdUtQPW
         Gr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660541; x=1701265341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6mwhJa9jnygGPwNgYYVXv0NiFDAvRFSYIV1gmbnIDI=;
        b=CODWfZDyThDvWESGR6MSKemONHku2eYcgFLnLb5aP6t8R7nRc/fH0BXbfngyIUrpqf
         4YBNK/piAxFQc+NSOFzqNCPjTZ8v1P4GOlCEyh7XUyajjaJeHoBNc5LufA1YU9XHRWfF
         jv41luhMO8nfApDazeHA+/A6vPDdIybvVfr4E3tjQS9IoAwobTBIlwqTL4l4JB9Of9Ty
         lkTz5tJYF0gfzm41ewsZ6x89X4DbViEk1jcNuUkivosnrW7wzczoGphsTLNnyisSRiur
         fPpwvkj/XwEcJOEZYkf/r4VExBHIo9f3U9g9uSx7QxxsefFNgy4yYTjCoitWw2TDap/O
         XUUw==
X-Gm-Message-State: AOJu0Yz7hnZAa2yw5BjAWmX97l0GFbIJ/dyJyMnUgb72XUlzcLZOug20
        nuk2Ah0gmFy2MC0Lia8Uw9Ox8g==
X-Google-Smtp-Source: AGHT+IEgnkNC5jhw0DnPblsGP07da0mhG0lItXM+wf1h14Vikn0FyW/oReZcikR0dE2vBMfns6hI9w==
X-Received: by 2002:a17:906:748f:b0:a04:7e4d:6c19 with SMTP id e15-20020a170906748f00b00a047e4d6c19mr1262653ejl.68.1700660541529;
        Wed, 22 Nov 2023 05:42:21 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906190100b009a19701e7b5sm6676797eje.96.2023.11.22.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:42:21 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 15:42:13 +0200
Subject: [PATCH 2/2] clk: qcom: Add TCSR clock driver for x1e80100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-x1e80100-clk-tcsrcc-v1-2-43078c6d6452@linaro.org>
References: <20231122-x1e80100-clk-tcsrcc-v1-0-43078c6d6452@linaro.org>
In-Reply-To: <20231122-x1e80100-clk-tcsrcc-v1-0-43078c6d6452@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9515; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Esmm2wUqNRcvaHakdFYdG/85Jq1N7KHQoM0n4w+Psoo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXgU4ThMIEf2RqEc32R0glteHL9NG9wjaAEF5M
 nTCWUUIzt+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV4FOAAKCRAbX0TJAJUV
 Vvm8EADNl/p9Cuhv6uozcS849Yd6Hg6d8BEGawc9l327vcppFQlrdeBoGGpYbepEZ22diIUzh/E
 hKdmfrjkieGSGyTotdXzxcFhlrYRMl645LsuWbDiHhnbOmFU1GRY4kY343RpKPe6fzT7l6awO7P
 zMJLso7XZA30rk0pA7h3nit01GF2JqUKkzan0OpSqcdJTTMfsO/hTQ2Do7XM7hy4Dyp/BmreFWP
 Y0ofgUL25SIJdAI3PCQGBToQeQ7tCAEsOOJWUJ55FXosCSSDkqNWxfRW86/87yE3PgeQ7sKnzKb
 IusBAfHs+sFLM9lcuGpcspvXBV3ZcMXL0nFCtFRv5sSAH7ujDd6YVQZuPXldqYXbXUO5oyJW3+M
 NqVDybeqtrOw9AAftSa49i/nQ84/qJNyFwwmKwhQGZxcMLbUsaEojilyylLUyiOxzFXHfah3BcU
 IbZb22VSrUET8nh7PgiXGmv7JfVnubI1EPC752P4UGobP1Fvz2s8WfnXiZAv5vRBwHVdT2DEV/2
 prlZuUmniHAzgJqwyCJqEhIb2V6gxtmnK1+YIuLMVRABj+pO+VM85I/s0b+2/oX8y7hKTQO+3ev
 dArkDP1ZEVH5nUxhDFC5Vn1dXJf4DQT+S75upcZiR9qGLpjOG30XRIZZA5gbm0bH+lfaZ7bXa7g
 m565ofnzcJohpcg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR clock controller found on X1E80100 provides refclks
for PCIE, USB and UFS. Add clock driver for it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/Kconfig           |   8 +
 drivers/clk/qcom/Makefile          |   1 +
 drivers/clk/qcom/tcsrcc-x1e80100.c | 295 +++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index ad1acd9b7426..6ed9c89d9070 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1116,4 +1116,12 @@ config SM_VIDEOCC_8450
 	  SM8450 devices.
 	  Say Y if you want to support video devices and functionality such as
 	  video encode/decode.
+
+config X1E_TCSRCC_80100
+	tristate "X1E80100 TCSR Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	select QCOM_GDSC
+	help
+	  Support for the TCSR clock controller on X1E80100 devices.
+	  Say Y if you want to use peripheral devices such as SD/UFS.
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 17edd73f9839..4931a1470137 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -140,3 +140,4 @@ obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
 obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
 obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
 obj-$(CONFIG_KRAITCC) += krait-cc.o
+obj-$(CONFIG_X1E_TCSRCC_80100) += tcsrcc-x1e80100.o
diff --git a/drivers/clk/qcom/tcsrcc-x1e80100.c b/drivers/clk/qcom/tcsrcc-x1e80100.c
new file mode 100644
index 000000000000..2ec142c3d1f9
--- /dev/null
+++ b/drivers/clk/qcom/tcsrcc-x1e80100.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,x1e80100-tcsr.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-pll.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "common.h"
+#include "reset.h"
+
+enum {
+	DT_BI_TCXO_PAD,
+};
+
+static struct clk_branch tcsr_edp_clkref_en = {
+	.halt_reg = 0x15130,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15130,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "tcsr_edp_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_2l_4_clkref_en = {
+	.halt_reg = 0x15100,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15100,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_2l_4_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_2l_5_clkref_en = {
+	.halt_reg = 0x15104,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15104,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_2l_5_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_8l_clkref_en = {
+	.halt_reg = 0x15108,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15108,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_8l_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb3_mp0_clkref_en = {
+	.halt_reg = 0x1510c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1510c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb3_mp0_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb3_mp1_clkref_en = {
+	.halt_reg = 0x15110,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15110,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb3_mp1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb2_1_clkref_en = {
+	.halt_reg = 0x15114,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15114,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb2_1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_ufs_phy_clkref_en = {
+	.halt_reg = 0x15118,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15118,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_ufs_phy_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb4_1_clkref_en = {
+	.halt_reg = 0x15120,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15120,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb4_1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb4_2_clkref_en = {
+	.halt_reg = 0x15124,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15124,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb4_2_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb2_2_clkref_en = {
+	.halt_reg = 0x15128,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x15128,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb2_2_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_4l_clkref_en = {
+	.halt_reg = 0x1512c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1512c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_4l_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *tcsr_cc_x1e80100_clocks[] = {
+	[TCSR_EDP_CLKREF_EN] = &tcsr_edp_clkref_en.clkr,
+	[TCSR_PCIE_2L_4_CLKREF_EN] = &tcsr_pcie_2l_4_clkref_en.clkr,
+	[TCSR_PCIE_2L_5_CLKREF_EN] = &tcsr_pcie_2l_5_clkref_en.clkr,
+	[TCSR_PCIE_8L_CLKREF_EN] = &tcsr_pcie_8l_clkref_en.clkr,
+	[TCSR_USB3_MP0_CLKREF_EN] = &tcsr_usb3_mp0_clkref_en.clkr,
+	[TCSR_USB3_MP1_CLKREF_EN] = &tcsr_usb3_mp1_clkref_en.clkr,
+	[TCSR_USB2_1_CLKREF_EN] = &tcsr_usb2_1_clkref_en.clkr,
+	[TCSR_UFS_PHY_CLKREF_EN] = &tcsr_ufs_phy_clkref_en.clkr,
+	[TCSR_USB4_1_CLKREF_EN] = &tcsr_usb4_1_clkref_en.clkr,
+	[TCSR_USB4_2_CLKREF_EN] = &tcsr_usb4_2_clkref_en.clkr,
+	[TCSR_USB2_2_CLKREF_EN] = &tcsr_usb2_2_clkref_en.clkr,
+	[TCSR_PCIE_4L_CLKREF_EN] = &tcsr_pcie_4l_clkref_en.clkr,
+};
+
+static const struct regmap_config tcsr_cc_x1e80100_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2f000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc tcsr_cc_x1e80100_desc = {
+	.config = &tcsr_cc_x1e80100_regmap_config,
+	.clks = tcsr_cc_x1e80100_clocks,
+	.num_clks = ARRAY_SIZE(tcsr_cc_x1e80100_clocks),
+};
+
+static const struct of_device_id tcsr_cc_x1e80100_match_table[] = {
+	{ .compatible = "qcom,x1e80100-tcsr" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tcsr_cc_x1e80100_match_table);
+
+static int tcsr_cc_x1e80100_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &tcsr_cc_x1e80100_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return qcom_cc_really_probe(pdev, &tcsr_cc_x1e80100_desc, regmap);
+}
+
+static struct platform_driver tcsr_cc_x1e80100_driver = {
+	.probe = tcsr_cc_x1e80100_probe,
+	.driver = {
+		.name = "tcsr_cc-x1e80100",
+		.of_match_table = tcsr_cc_x1e80100_match_table,
+	},
+};
+
+static int __init tcsr_cc_x1e80100_init(void)
+{
+	return platform_driver_register(&tcsr_cc_x1e80100_driver);
+}
+subsys_initcall(tcsr_cc_x1e80100_init);
+
+static void __exit tcsr_cc_x1e80100_exit(void)
+{
+	platform_driver_unregister(&tcsr_cc_x1e80100_driver);
+}
+module_exit(tcsr_cc_x1e80100_exit);
+
+MODULE_DESCRIPTION("QTI TCSRCC X1E80100 Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

