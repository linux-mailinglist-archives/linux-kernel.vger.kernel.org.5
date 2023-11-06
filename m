Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893997E1C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjKFI0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjKFI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:26:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59C4D49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:26:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so36861035e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259171; x=1699863971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQL5AgFOK7AFEwr2hYB9MjIBVXFDyPhVtPZgcgQsvu8=;
        b=igBVWZADajhUBIY56R2JKtYghk40dFp0wzcLBFh5PliZ3IsR7qMnWdjAGPcfw75un6
         fH8Z8FFBLd3KhlnsmvtQJ/EVVar41iiiFTQD7NRvbZluA6OdZoKdnGP1egxx8/FFak5T
         VmpoyhYEkz+ZwYeiOpyKePqdou0vFjLuc5xxObtma5IrPjCrNbCSWnXX0kQENIYCIMcB
         e2y0V7sB5XlGerUI3IX2UNjs4toW3bXS+VOGb6yoJFrmfmjBWFf2mEMsUX7C/9ZauRB8
         +wASzvY58X8R6VgyPoHiyFOcIe8s8DfN1ToQvvbEiiYwuc7uSuodyYltJoHgebKt1yt4
         hWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259171; x=1699863971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQL5AgFOK7AFEwr2hYB9MjIBVXFDyPhVtPZgcgQsvu8=;
        b=gavNGvyQblRX6ilGGOwN31Leh69YGHoK6BbDL/E8Cq3tTDGDZ61kbHLBVzVeTt+DCx
         acXx9SVDcXfEOLo9FzMHz2jjGh3ZCJ2NLJWOV6DuD1XY8fiW5ts5Jj6YAkI0eKsgt8+w
         mRr0SMbgbpjxzAC3gk/VigXzdb8hhDI2GtlhJDPjz58Ke+Qklra8mIilcBY5DWAtdeWP
         7gG8EtIAZVhN846ou9MuORD8bmMaf5hQ6oFzE7JJVmVikDarSR3BeuIv98d8zood89mR
         d4Aealox3UkQ8+WfHe/vPdEGpQJAXtbvCwG8rg/NRPPOsOnp4K1EfNPdCeYdiJsiTdh4
         7QOw==
X-Gm-Message-State: AOJu0YwIgnOpIoiHD0WBzAwgJbZvCm60JdBWHCkSwIeZ9un5f5nodIc7
        RPGdlFiuwChlVXpRj/13mP8eGQ==
X-Google-Smtp-Source: AGHT+IHkS3Ac97ogDPTLjNb6z0FeClYxbfUORcrrNmuct8hxdul8esHWiz2RCPDwQ7pIIZ9td+XmSg==
X-Received: by 2002:a05:600c:4f81:b0:401:23fc:1f92 with SMTP id n1-20020a05600c4f8100b0040123fc1f92mr23754398wmq.25.1699259171101;
        Mon, 06 Nov 2023 00:26:11 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b004095874f6d3sm11610663wmb.28.2023.11.06.00.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:26:10 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:26:01 +0100
Subject: [PATCH v3 08/11] clk: qcom: add the SM8650 TCSR Clock Controller
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-clocks-v3-8-761a6fadb4c0@linaro.org>
References: <20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org>
In-Reply-To: <20231106-topic-sm8650-upstream-clocks-v3-0-761a6fadb4c0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6776;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3YQ09pIyy2P5hl18WqsxGmBEHAJSVEFWp4+YaeMWbYQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKMXe4MoPlTzd+z+FjNuxGh8JXYkM715btQiE9Rh
 IXm7KY+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUijFwAKCRB33NvayMhJ0TbAEA
 CnTwkfJ0Rt1oH2iemd1zG+xiDgFJfMfmMjVYKgW2tzZprViLVRELsIZn+ikC6p0q3mBWhvq5vEvW8S
 p455luWOcGbASY1wHNIFJJvzOM3ivDU4o+JW19uZ5x++n7MFfwxblF4QtMsLTARAqKvQFLG2skVG13
 9vylq1O2vX7O5s0xubwu4ezOzNR9OfcdiO2GFB9QkuMO8DP7RMB7tY+Mro8NXfX838bqnJCOJ379So
 xkRds2v/EhvhguOMXjYeAIrRMAcx8dxGOmeorylsAni66zx6hpvHpIS4yt9/OdjLZmzBBTm6qh64nD
 H1fDpAi+P9BSFo2wGsZJGQw+lJ58kWsxE0x4I4kyAAUMZwuxtDfZYRaD+8wjii2kNXp1jWVWUdkEK5
 zjR/MKDBB8R1ZDB7Gt28IRqf9SrvIdP2cgtqoKbh3c4Q8KgXg85lAM8M80TzU/epxD7tLvlcHWWo2S
 VRpE0+74OtBZHatSLwTQurxSS5ae1hvn6vPN8XEhDnxoditD8BXyuvw6P5CWX/uoc+om5nU6ZgvLfe
 ygZGlbPRM7G5icRzIf0nJ7lEEqJ/DaTv4v4NgSySF7m76nJ6Tgc6kUqBCiJIAmlTasnYnI0Nu7d2Bd
 Sewu8HgNxJRyYRad47f9tL56IxF+/06XwAJpYh/2kvkoy7lCjNzD2pRi6Bkg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCSR Clock Controller support for SM8650 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/tcsrcc-sm8650.c | 182 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 69ac4e052ed0..13d739166c08 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1036,6 +1036,14 @@ config SM_TCSRCC_8550
 	  Support for the TCSR clock controller on SM8550 devices.
 	  Say Y if you want to use peripheral devices such as SD/UFS.
 
+config SM_TCSRCC_8650
+	tristate "SM8650 TCSR Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	select QCOM_GDSC
+	help
+	  Support for the TCSR clock controller on SM8650 devices.
+	  Say Y if you want to use peripheral devices such as SD/UFS.
+
 config SM_VIDEOCC_8150
 	tristate "SM8150 Video Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 5363ba13f89b..6ec026a137ec 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
 obj-$(CONFIG_SM_GPUCC_8450) += gpucc-sm8450.o
 obj-$(CONFIG_SM_GPUCC_8550) += gpucc-sm8550.o
 obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
+obj-$(CONFIG_SM_TCSRCC_8650) += tcsrcc-sm8650.o
 obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
 obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
 obj-$(CONFIG_SM_VIDEOCC_8350) += videocc-sm8350.o
diff --git a/drivers/clk/qcom/tcsrcc-sm8650.c b/drivers/clk/qcom/tcsrcc-sm8650.c
new file mode 100644
index 000000000000..11c7d6df48c7
--- /dev/null
+++ b/drivers/clk/qcom/tcsrcc-sm8650.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm8650-tcsr.h>
+
+#include "clk-branch.h"
+#include "clk-regmap.h"
+#include "common.h"
+#include "reset.h"
+
+enum {
+	DT_BI_TCXO_PAD,
+};
+
+static struct clk_branch tcsr_pcie_0_clkref_en = {
+	.halt_reg = 0x31100,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x31100,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_0_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_pcie_1_clkref_en = {
+	.halt_reg = 0x31114,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x31114,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_pcie_1_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_ufs_clkref_en = {
+	.halt_reg = 0x31110,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x31110,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_ufs_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_ufs_pad_clkref_en = {
+	.halt_reg = 0x31104,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x31104,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_ufs_pad_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb2_clkref_en = {
+	.halt_reg = 0x31118,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x31118,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb2_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch tcsr_usb3_clkref_en = {
+	.halt_reg = 0x31108,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x31108,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "tcsr_usb3_clkref_en",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_BI_TCXO_PAD,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *tcsr_cc_sm8650_clocks[] = {
+	[TCSR_PCIE_0_CLKREF_EN] = &tcsr_pcie_0_clkref_en.clkr,
+	[TCSR_PCIE_1_CLKREF_EN] = &tcsr_pcie_1_clkref_en.clkr,
+	[TCSR_UFS_CLKREF_EN] = &tcsr_ufs_clkref_en.clkr,
+	[TCSR_UFS_PAD_CLKREF_EN] = &tcsr_ufs_pad_clkref_en.clkr,
+	[TCSR_USB2_CLKREF_EN] = &tcsr_usb2_clkref_en.clkr,
+	[TCSR_USB3_CLKREF_EN] = &tcsr_usb3_clkref_en.clkr,
+};
+
+static const struct regmap_config tcsr_cc_sm8650_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x3b000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc tcsr_cc_sm8650_desc = {
+	.config = &tcsr_cc_sm8650_regmap_config,
+	.clks = tcsr_cc_sm8650_clocks,
+	.num_clks = ARRAY_SIZE(tcsr_cc_sm8650_clocks),
+};
+
+static const struct of_device_id tcsr_cc_sm8650_match_table[] = {
+	{ .compatible = "qcom,sm8650-tcsr" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tcsr_cc_sm8650_match_table);
+
+static int tcsr_cc_sm8650_probe(struct platform_device *pdev)
+{
+	return qcom_cc_probe(pdev, &tcsr_cc_sm8650_desc);
+}
+
+static struct platform_driver tcsr_cc_sm8650_driver = {
+	.probe = tcsr_cc_sm8650_probe,
+	.driver = {
+		.name = "tcsr_cc-sm8650",
+		.of_match_table = tcsr_cc_sm8650_match_table,
+	},
+};
+
+static int __init tcsr_cc_sm8650_init(void)
+{
+	return platform_driver_register(&tcsr_cc_sm8650_driver);
+}
+subsys_initcall(tcsr_cc_sm8650_init);
+
+static void __exit tcsr_cc_sm8650_exit(void)
+{
+	platform_driver_unregister(&tcsr_cc_sm8650_driver);
+}
+module_exit(tcsr_cc_sm8650_exit);
+
+MODULE_DESCRIPTION("QTI TCSRCC SM8650 Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

