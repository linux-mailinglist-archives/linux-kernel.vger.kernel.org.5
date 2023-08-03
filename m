Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2A76E7AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjHCMEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjHCMEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:04:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F772D73
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:04:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31781e15a0cso767010f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691064247; x=1691669047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gk5RmU5hOCjyXiNvKJrFNIn+ds+IQi4ixYNI1v40l1o=;
        b=dmbvQXzU5YOxKr/5AHsZgK20/MbMO8YTcE+nnZyWIKTL5cNu+2gejW86Lgm3eQlvhO
         XqebyzFF12aOnA4VtP1e8OwSo2A4b1oXq8VPQ7K9LY14L39vgScYUx9Q5Wsdqg8dQ74y
         otS2vIdXwUX2XVwENmpbWOXJK3rSuAJsE9DN6U9nh5cb0qbBh/LMstTukseLc9Hjq23j
         FITafRouiTvQF1pVlKNP/BUmkFUlGn0W5cS6fWhrWpQeIhfULOwWwhM+i3ynV6bfKis2
         tJUgLqmVpQv5BrTCa9wwVqu5sAsbX9HwwKy9k6AY5mAF1zVAZLPDVfTOiyuV2XiuASkN
         uenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691064247; x=1691669047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk5RmU5hOCjyXiNvKJrFNIn+ds+IQi4ixYNI1v40l1o=;
        b=PwnuJT0on6iAl7ZWmmag8Nc2Ihgxglfm9GesLJPlKVHOmdGEK+9hlZnqetSh942Q4o
         OlWQ0olBoo0Rk4wgsAPgDSMwND4FA1qfk6UetImEfXcg6xHB8rOR7xBd6c25+FJEKpgF
         szXiPxftEubuIavC+E6qNGoQEYN/9PA6bz9sfi1DST8CX/6xkL0VlNymqk7340KYq7pd
         3OUTCR7u83m0ovFpIutAw1azfhgFHWuBxawLq2Aqh/qxkhQB7lVgZVaJLJ69se7bovmz
         3Q29IacCJpmMU4vaVdwXY/qc4GgpxNxHhqcPqnwU0C0n6t1f5ttzpECvCBh/Cb9E6EYg
         FJFA==
X-Gm-Message-State: ABy/qLY/kZC7IGA+2EG+Vr2OJDJi1XYDKTxaE2hrEx+VrE9fHK0kSw48
        bEFf+FnmY9BNWWkvSAiI5jazbIQoj7xS62UpH3H6CA==
X-Google-Smtp-Source: APBJJlHAD8DUjoAlBJEb5XOFbsF/b80OtVlEc90hvF001d1wcQxVRGZIO0NkMAYWWpNGwprPfJbo3Q==
X-Received: by 2002:a5d:514e:0:b0:315:998d:6d25 with SMTP id u14-20020a5d514e000000b00315998d6d25mr6619915wrt.1.1691064246783;
        Thu, 03 Aug 2023 05:04:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b00317046f21f9sm21487465wrx.114.2023.08.03.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:04:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 03 Aug 2023 14:03:56 +0200
Subject: [PATCH v7 2/9] clk: meson: g12a: add CTS_ENCL & CTS_ENCL_SEL
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-2-762219fc5b28@linaro.org>
References: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org>
In-Reply-To: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3966;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CX3kI3o4J7x9FeIX92jRW57M0+FTSTiUyYKTnCWLyDM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBky5evEYOkI2P6cFHvisFT2Xy456x7SQeR4MphAUBO
 lqYbTCiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMuXrwAKCRB33NvayMhJ0UPvD/
 9YlSRSI3mRy+zfpQwi9BxrviwLWLuOR8NfQGEXAqxY2hMO3UCRb0sDMroYLl42SMk/ms4a5fEdKEK5
 pHEMnwJI+XNpQa2uYQQTfikYepv8qa10ubCh0IxOPfBEHKxrxzajSQehAYLYO+yXYGfc9tCJs06QBA
 TcrSpcU/GPTDgoMgLkqzaL6m006sXYzjUUGjYqRM2zAMN8COfGwpeslM8KBq4+SfHT9FvA8yxGAqSc
 /C6CObtswB9micLgi/3q2fWzojlcLrpL5O0kvEtXc+ZR41P+MAagGy5s7cqtYVLaK1w8PrWAE2455s
 GCs2PhiZJvkgzTGxnLDQRBhlIQXouJ0soQ1wVaQOWbfqrDlivaFp02m2jckHJ6JN8QAplzEcmIW0qF
 Y42E6sewLTH/nz/R5U384neUgK3Hs0BNBbk6X9ClGtYmOlT8rL5Rng5WeAEpA13DXX8RgxmXtUPv9Y
 TRhYv5DWBp0BTMNg45Mt+22pm0DUXAQIfKxgS1mLmAzWvWLVwM8d6a9vfqsdjgsFjFCQS4LYAZ5hpg
 MTnPI1DBpaMj/i0TUOxhAOqh9GHz/AQ8W0vRE1AKi6+qwF8HO52spjIwAu/tk1QdE87kA04DhxzRwf
 L0bV+gj6WJHGOqTE9GSkdbcbhZQGUiKVlvq1SkjaxRaYHGeXX+t3nzVVmfbw==
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

Add new CTS_ENCL & CTS_ENCL_SEL clocks for the G12A compatible
SoCs, they are used to feed the VPU LCD Pixel encoder used for
DSI display purposes.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/g12a.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index ceabd5f4b2ac..5d62134335c1 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -3549,6 +3549,22 @@ static struct clk_regmap g12a_cts_encp_sel = {
 	},
 };
 
+static struct clk_regmap g12a_cts_encl_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 12,
+		.table = mux_table_cts_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encl_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = g12a_cts_parent_hws,
+		.num_parents = ARRAY_SIZE(g12a_cts_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
 static struct clk_regmap g12a_cts_vdac_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_VIID_CLK_DIV,
@@ -3628,6 +3644,22 @@ static struct clk_regmap g12a_cts_encp = {
 	},
 };
 
+static struct clk_regmap g12a_cts_encl = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_encl",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_cts_encl_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
 static struct clk_regmap g12a_cts_vdac = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = HHI_VID_CLK_CNTL2,
@@ -4407,10 +4439,12 @@ static struct clk_hw *g12a_hw_clks[] = {
 	[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
 	[CLKID_CTS_ENCI_SEL]		= &g12a_cts_enci_sel.hw,
 	[CLKID_CTS_ENCP_SEL]		= &g12a_cts_encp_sel.hw,
+	[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
 	[CLKID_CTS_VDAC_SEL]		= &g12a_cts_vdac_sel.hw,
 	[CLKID_HDMI_TX_SEL]		= &g12a_hdmi_tx_sel.hw,
 	[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
 	[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
+	[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
 	[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
 	[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
 	[CLKID_HDMI_SEL]		= &g12a_hdmi_sel.hw,
@@ -4632,10 +4666,12 @@ static struct clk_hw *g12b_hw_clks[] = {
 	[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
 	[CLKID_CTS_ENCI_SEL]		= &g12a_cts_enci_sel.hw,
 	[CLKID_CTS_ENCP_SEL]		= &g12a_cts_encp_sel.hw,
+	[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
 	[CLKID_CTS_VDAC_SEL]		= &g12a_cts_vdac_sel.hw,
 	[CLKID_HDMI_TX_SEL]		= &g12a_hdmi_tx_sel.hw,
 	[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
 	[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
+	[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
 	[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
 	[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
 	[CLKID_HDMI_SEL]		= &g12a_hdmi_sel.hw,
@@ -4892,10 +4928,12 @@ static struct clk_hw *sm1_hw_clks[] = {
 	[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
 	[CLKID_CTS_ENCI_SEL]		= &g12a_cts_enci_sel.hw,
 	[CLKID_CTS_ENCP_SEL]		= &g12a_cts_encp_sel.hw,
+	[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
 	[CLKID_CTS_VDAC_SEL]		= &g12a_cts_vdac_sel.hw,
 	[CLKID_HDMI_TX_SEL]		= &g12a_hdmi_tx_sel.hw,
 	[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
 	[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
+	[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
 	[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
 	[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
 	[CLKID_HDMI_SEL]		= &g12a_hdmi_sel.hw,
@@ -5123,10 +5161,12 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_vclk2_div12_en,
 	&g12a_cts_enci_sel,
 	&g12a_cts_encp_sel,
+	&g12a_cts_encl_sel,
 	&g12a_cts_vdac_sel,
 	&g12a_hdmi_tx_sel,
 	&g12a_cts_enci,
 	&g12a_cts_encp,
+	&g12a_cts_encl,
 	&g12a_cts_vdac,
 	&g12a_hdmi_tx,
 	&g12a_hdmi_sel,

-- 
2.34.1

