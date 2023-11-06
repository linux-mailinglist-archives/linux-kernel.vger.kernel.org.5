Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C07E1C18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjKFI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjKFI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:26:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F86AD7B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:26:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40859c46447so26481425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259174; x=1699863974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEO0VgapYU9MBqkEEEkYjC/CxFTpzsKKAvZz9dJ83Vg=;
        b=oaoq7EtY/e/EIzHn6hNxkW4AEDZSwasWlYlH7UwUWX1Ak9VF0UyFJ4Tq+kgI0UbAg6
         q3l0X9FtFz/vrEz3sk1wEUqgz/6KFboeo6tmukQ/gIcjuMI3+fksFdr7BlFXCoR7lRrX
         AF5JK1xK93oD1UpDN3WDGeJpgruPUFC6XuzysC5ynp58G5FUUS9EQ0iI2f8/SZ9tbvo3
         SmUi/vVUtsRvO8p7ZH+dO1fxV7KUDw7jlFuUdwTu0VH4tR+cP/4cgu4gxQHaMI1QnlhH
         moZB/Nn+d/T/4lPELmvMle1PibQlZvT/1RbzEIwNYeEEmxw+4UnzvcbzvE/P/qtuy6h1
         gpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259174; x=1699863974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEO0VgapYU9MBqkEEEkYjC/CxFTpzsKKAvZz9dJ83Vg=;
        b=u4bnvL5eXtPVG2GX0sx9lEO/3vT4Ix87xqTufWXVDEqAleIqFzYyjeCo5wowUfLjAt
         1H7QGvM2+QK8NJA3bdgOZJanKkSgEVnbqPOXduQ2pJsZGAZlkuvNZtnpt2DLnTvrpEZ8
         /wfq60WyIKmSOPdNKDutUBXlH83cREt78+4MPlx4/yXb2kfooPZjplKvcfDT68fOR7XZ
         zUP//rPbEEVHMDe9xvVf9Y/RXXwHaAy/WBgGt/lIhQnShuA2SGFm2Rn968aeUsZTLgw/
         K3nQtiSG6hMAogzaxud7JW4FPbrgkc+2r7QlZUocnTlkNfXnLz0fv31XN39LVfJhftHP
         AfSg==
X-Gm-Message-State: AOJu0YwFTaLjwNDj7addK9Nk6/pXeOL/AhEyDU5HoRqQ6WAOR0N93nKR
        Im0KPxLLE3QQXuvdSD7Bgtxg4w==
X-Google-Smtp-Source: AGHT+IHSMZqsacgVc58+X7fI0lyr5nPFH9OrtO4Vu1oMzTetS+9UttS4rMQ53ODhA8xZNJO+Onu9DA==
X-Received: by 2002:a05:600c:1c84:b0:401:b504:b6a0 with SMTP id k4-20020a05600c1c8400b00401b504b6a0mr22188872wms.3.1699259174460;
        Mon, 06 Nov 2023 00:26:14 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b004095874f6d3sm11610663wmb.28.2023.11.06.00.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:26:14 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:26:04 +0100
Subject: [PATCH v3 11/11] clk: qcom: rpmh: add clocks for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-clocks-v3-11-761a6fadb4c0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6WZ59azmOVIohCJtoBUj6hfLckpCnFGk4WmVuUtV9B4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKMZGsOuCicXaPOYykkThJi9ga22b/FORpgZuhnh
 UHTpJWKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUijGQAKCRB33NvayMhJ0d45D/
 wJXJSMV80ToTQ9syAVxmngD1JOS9kYaHc7IcwEyONP0QdcN7pLC5jr6LtKWXb6UyiinZwZJj/jm6aR
 +v670AJ/vUgbmI1nSYj82x0zj58nd8CY0kmP2rqztD0TqcBnrs8tXggefVEW5sMiQG4w0NjJ5gyBAl
 MZjVyO2FL3hgv/w7CmDCbPtBf2V2a46WOlNSwkF6jdDWbtSV7JftZGggxPHHSVKpXdiYSahNtCBl0v
 q5GIuzbAFQmP5f7tdWY73eEzbTZL+sffgMetbFXLXaNVaXcPkb6oJ7+XMpKArYjwaPgOeKKK0PoI8c
 iiMBlNpfNha5lBlLvv9eHnSMf2mVTCHaCy3mjY3jSHY0WO0/q246HvvwV0Q5c28E28twphqrhdV0mU
 Xpc0a7A1qk0KLKGwK/WPHbwDIVB+um9rM4wxAEW07MVs1E+P4crXfySMJ5mCtpGqiPFz6aA5ozoio0
 N2bdQIPy1jpAtDXl+VglurRL9Yd51vjPo8viUq0Tve5iP80u879aCrTv8ca7ioXi4ouRTLc+Z1bxpm
 WtngFJpo9AuebmjO6cdFOSrWjwhYjdDwKRuN1roJNRaC23oNtkbUPNX7ipmgfOH8TxLqKQtAV5Q2/3
 lzx2elo7mxlpy8Bn5Ungeqb68l3BomONLl8No9PpU3nJpTlk/SzM5t9s58hA==
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

Add RPMH Clocks for the SM8650 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 5d853fd43294..bb09170600ec 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -372,6 +372,8 @@ DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
 DEFINE_CLK_RPMH_VRM(clk4, _a1, "clka4", 1);
 DEFINE_CLK_RPMH_VRM(clk5, _a1, "clka5", 1);
 
+DEFINE_CLK_RPMH_VRM(clk4, _a2, "clka4", 2);
+DEFINE_CLK_RPMH_VRM(clk5, _a2, "clka5", 2);
 DEFINE_CLK_RPMH_VRM(clk6, _a2, "clka6", 2);
 DEFINE_CLK_RPMH_VRM(clk7, _a2, "clka7", 2);
 DEFINE_CLK_RPMH_VRM(clk8, _a2, "clka8", 2);
@@ -630,6 +632,37 @@ static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
 	.num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
 };
 
+static struct clk_hw *sm8650_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
+	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
+	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
+	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &clk_rpmh_clk7_a2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_clk7_a2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
+	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
+	[RPMH_RF_CLK1]		= &clk_rpmh_clk1_a1.hw,
+	[RPMH_RF_CLK1_A]	= &clk_rpmh_clk1_a1_ao.hw,
+	[RPMH_RF_CLK2]		= &clk_rpmh_clk2_a1.hw,
+	[RPMH_RF_CLK2_A]	= &clk_rpmh_clk2_a1_ao.hw,
+	/*
+	 * The clka3 RPMh resource is missing in cmd-db
+	 * for current platforms, while the clka3 exists
+	 * on the PMK8550, the clock is unconnected and
+	 * unused.
+	 */
+	[RPMH_RF_CLK4]		= &clk_rpmh_clk4_a2.hw,
+	[RPMH_RF_CLK4_A]	= &clk_rpmh_clk4_a2_ao.hw,
+	[RPMH_RF_CLK5]		= &clk_rpmh_clk5_a2.hw,
+	[RPMH_RF_CLK5_A]	= &clk_rpmh_clk5_a2_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sm8650 = {
+	.clks = sm8650_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sm8650_rpmh_clocks),
+};
+
 static struct clk_hw *sc7280_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]      = &clk_rpmh_bi_tcxo_div4.hw,
 	[RPMH_CXO_CLK_A]    = &clk_rpmh_bi_tcxo_div4_ao.hw,
@@ -837,6 +870,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
 	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
 	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
+	{ .compatible = "qcom,sm8650-rpmh-clk", .data = &clk_rpmh_sm8650},
 	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
 	{ }
 };

-- 
2.34.1

