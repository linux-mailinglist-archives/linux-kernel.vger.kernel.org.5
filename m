Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62947C99FC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJOQVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjJOQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:21:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D8AD;
        Sun, 15 Oct 2023 09:21:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso14816a12.0;
        Sun, 15 Oct 2023 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697386877; x=1697991677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VVvP6gIzo5NMsNtQkyvSKq66SlaBegSVzjmTq/QrGEI=;
        b=gIiY7Wy0MHHbOnMFrtsxiwrR585CQ2bL5j+QTv0YkgJIivQJtP6Cr6+HtW9nA5QuVE
         NuvysFk1NJJIgJXd2ZNVy3KH31Z+KUz+7djQRVXteEjViRw1yS2/oCNHSdKXYRrCpcz3
         ZFNNrDoG27uSt/xuJrAdEh1XV0LDETnUbp6o3ZIQqAjCEWDfMJHD6pQVWHyLmWdHp8D4
         8loTqmWcBf5MDwCvFv3eoZxuR12t/8CCIhFGaDXL+tU13MG7eqFA69yj8oYDC9EpnMlr
         5Bgwm6Xm8+qHTR53bqSB2cF3s3AybSCdZj309G7XP1FJqCzvcx8OmkQpg5Lx2xcmi4Ih
         lb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697386877; x=1697991677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVvP6gIzo5NMsNtQkyvSKq66SlaBegSVzjmTq/QrGEI=;
        b=Kox1+gn6BG1B2p15NkVqfhx3mYzBHywonTG6U8P8bZ1wEF1pk0rlkQm204zSr8AtNW
         xxl0DyDoSSE2iqUzz/zqAFnfWf8I92MydhqYPOIIZrzIQhadz5WCEhZ408QcTt4vexoP
         wVgcce5aBQh2ruEqg3I5iKo3vP107yS37H2/Zs/VZ3girKIXbTb92yyTplkFLkWQ4rvs
         4zmmagRCL+bUrS+QlLG4OBztZYTe3ygkBMm3XAWH6uzQUtXr1hqgo7GWaBAmo7aEIYWQ
         Pq/sYjMJsINeBdKcoRVYpWj5OvhJpgFvvrIXk1NWroTos+HqzzTtts/Pls1xmz/4BdNK
         gXZg==
X-Gm-Message-State: AOJu0YxMCtuOKpeysjN+9m8GWG6Cy4cp5uju/w0KMuUqSohsAuiHbPFi
        FuuVHjLzvsPZCY7fUOSyBiQ=
X-Google-Smtp-Source: AGHT+IEpPki57B1BRR5L7Qj22LeLgFCGJRoYRGdy39/Py6az4VE4U0VYk7EF43oDwQqGJ0x5ZpOuPQ==
X-Received: by 2002:a50:d709:0:b0:53e:9387:40fc with SMTP id t9-20020a50d709000000b0053e938740fcmr1995732edi.26.1697386876914;
        Sun, 15 Oct 2023 09:21:16 -0700 (PDT)
Received: from fedora.. ([213.149.38.35])
        by smtp.googlemail.com with ESMTPSA id a26-20020a50e71a000000b00537963f692esm14202024edn.0.2023.10.15.09.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 09:21:16 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
Date:   Sun, 15 Oct 2023 18:20:40 +0200
Message-ID: <20231015162114.976202-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUP6 I2C clock is listed in the dt bindings but it was never included in
the GCC driver.
So lets add support for it, its intentionally marked to never be disabled
as its somehow affecting DVFS and if disabled it sometimes crashes the
board.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq6018.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 31eef38c5864c..126d87df80c5b 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -2125,6 +2125,22 @@ static struct clk_branch gcc_blsp1_qup5_spi_apps_clk = {
 	},
 };
 
+static struct clk_branch gcc_blsp1_qup6_i2c_apps_clk = {
+	.halt_reg = 0x07010,
+	.clkr = {
+		.enable_reg = 0x07010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup6_i2c_apps_clk",
+			.parent_hws = (const struct clk_hw *[]){
+					&blsp1_qup6_i2c_apps_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_blsp1_qup6_spi_apps_clk = {
 	.halt_reg = 0x0700c,
 	.clkr = {
@@ -4281,6 +4297,7 @@ static struct clk_regmap *gcc_ipq6018_clks[] = {
 	[GCC_BLSP1_QUP4_SPI_APPS_CLK] = &gcc_blsp1_qup4_spi_apps_clk.clkr,
 	[GCC_BLSP1_QUP5_I2C_APPS_CLK] = &gcc_blsp1_qup5_i2c_apps_clk.clkr,
 	[GCC_BLSP1_QUP5_SPI_APPS_CLK] = &gcc_blsp1_qup5_spi_apps_clk.clkr,
+	[GCC_BLSP1_QUP6_I2C_APPS_CLK] = &gcc_blsp1_qup6_i2c_apps_clk.clkr,
 	[GCC_BLSP1_QUP6_SPI_APPS_CLK] = &gcc_blsp1_qup6_spi_apps_clk.clkr,
 	[GCC_BLSP1_UART1_APPS_CLK] = &gcc_blsp1_uart1_apps_clk.clkr,
 	[GCC_BLSP1_UART2_APPS_CLK] = &gcc_blsp1_uart2_apps_clk.clkr,
-- 
2.41.0

