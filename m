Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CBB7DB6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjJ3J63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjJ3J6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:58:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF0113
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:58:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507be298d2aso6127530e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659885; x=1699264685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoozIwSsZZQMROSkQSoMMLCV4qR0UyJcLqeT2lZixG0=;
        b=FtMSrn/he24gSXXOhA60xafeXf6kXkeQ1iaCOz16C/MHVEZFs3urZA/OnCq0HjSUOY
         gBZjqYt/NSTo8L1Vq17MBPVkmpNUU2I+7gnsGtf/enS4duRPWDOxm8rE7851NLazZuo+
         lb6241kDVdu56LnjlFWEpA5zgZbxshJKvfi0mUgG3lOsEwDn9BqUdMLlsDJJDDT5RRm4
         VC21sxwopXLdd2/GGtIbS6YFKbHXPC6QhNnRqYdOuxY2NEAFQzKlcQZUKkaWNTY8tWPR
         DKc4cbsSjxuc5E4Mmax3QrPrJ5/Ob4hwhDWCmchzLpxeEZ9pPrBJSnSbhyfTiwmKBYx3
         RP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659885; x=1699264685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoozIwSsZZQMROSkQSoMMLCV4qR0UyJcLqeT2lZixG0=;
        b=XQ9nRuxS1rP1rl9t5G+nWpejaizaDUJxgcXikba9RiYs647awNln7SaU2ZpCsqHA32
         rIakMAvm7XT6VmTL7aMtmqv9yVT6H+9405R8i/3eqgKgF3eaKbJtHf5gxYyN1ftiG4O5
         egP1/ke+MfSVZ5la7N97rukCCdjQV7S5Q0wMvTRpYmsF2v1lpFqdAxq72ZwhyfezFFef
         Gyv8uHPKWwy7gnyxmkYd0vzKS0wIWkVfHl0sxIhW7GdvTZZ2OBbbU+O1fLj/WaQHtT5I
         FQD48B0JDs3irPqgxh9m6cMYolTwQa8lhCIbAWbbC5VvEa1TOaPw9NHUZI1Kfi4asS2x
         co0Q==
X-Gm-Message-State: AOJu0Yx5ofJ86YiBNVq61va4kQ1KWm7T98zEJjAUIS+Hq0o+PVsppnTE
        Sy1ARxGHXi5drd3dCJ9ijSAlAQ==
X-Google-Smtp-Source: AGHT+IEtwcTuV3Of3LmxcqMYW8zrlQdmFd2Ph/0g0MkViC30XBEXuaA0/iS76ozCotLG2Q3q9h6lhw==
X-Received: by 2002:a19:7607:0:b0:508:1227:5a0f with SMTP id c7-20020a197607000000b0050812275a0fmr5882122lff.65.1698659884927;
        Mon, 30 Oct 2023 02:58:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b00402ff8d6086sm8703714wmq.18.2023.10.30.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:58:04 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 10:57:54 +0100
Subject: [PATCH v2 07/10] clk: qcom: add the SM8650 TCSR Clock Controller
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-clocks-v2-7-144333e086a2@linaro.org>
References: <20231030-topic-sm8650-upstream-clocks-v2-0-144333e086a2@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-clocks-v2-0-144333e086a2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6721;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mVxPX+9vuvokPQWTcN8mu3Uh8IkNOpdephb5MMJqylc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP34iC015cl41rvA6vboOkOkX9UB7h2Z21BnYQznT
 8jIKyNKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT9+IgAKCRB33NvayMhJ0bogD/
 9Nc3oksJr2I/jHKTy+MaF+308L1UX19ETNck2qx8862tdcHI9UmXGyiNNQiI/2i6zOMsPjWhwDk+Lx
 gjDQX4HvJecS9y0rHe6QTiTnm48qYhBUyN6zzSIFcJvJjt724WES7gB1izZ8KFD0f6t1ncy0ZM5uTX
 uzb1l4lUQwRxGlpyyzK7LYTwkVIbKV5Dy7sIMlJd/kFNfIc0KlwrCrfaehDWrP1YOydyQq3kwYoqtk
 eEvNhf7+STExLt8rX2tn4TqEZ3eqqBa1cY/tpTzxkXBGtKqkeq3JYALxE0F5yqPpc2GMp3/PThuSZh
 DcCsgEn2T7ASgkBI+xx79Ke7iT/dkBCMymlGFNHq9moIo6BqkmKNH/lTwXU7HCrNpCNVSam8qEvhKg
 EW9k/zsH9ospl4oWTmIpjx9W61DVwVDpoYOQiy/AggyedgumOC5hKFtEtqX5bDN3pReJ9Ap6c68ePU
 rnUTkabm1jRgol59KnoXD4LK7O1lmeH6zgQvH0sx6MwYzDlHIkX2wbls5K/Q1EJ0ceN4hHG92Ddql9
 1sR7ikoS06pSWqgb+4IY7nXObj7XfeBrzcrcNoYpjFUXqnjWfXufDkA8vi4pdUWANKjF5eb4oHvzbG
 Xt5+mN0cxsbkFfgFKCBg5p+vdgQA1Y8zO75HbqjG8yS3gK2FM9mJOKaNMcrw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCSR Clock Controller support for SM8650 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

