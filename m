Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6EB7A31A3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjIPRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjIPRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:15:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63975CE9;
        Sat, 16 Sep 2023 10:15:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31ffe67b5daso704921f8f.0;
        Sat, 16 Sep 2023 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694884500; x=1695489300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0/dU+s24A21H8KB1oHsdy9DBO1Q1Csxfdq88eybO/s=;
        b=UQyjucLSxWyp7MjuCnQBr9t7BnSbMCYitbOCvF2J8Y52OV0v+KY9dhnGbbW6HNPTP/
         Z5FxfodFGXhKHhtJesifouJIjKrDhk+pWe/TjfCJvAm2Qt+bBFfbhIPeWt5dql0uKdwm
         yZFhLvmRBuYy2SKb8j4LProqfECS/EMObgKEUaUR2o5x6Qf6Gjc5loKxvT+Md93GnXH+
         u5KodLzcEV4YsNNH16kFq7iR5YPFUTvYszgJpbCUIvP4twZQ0Yjcf7jkLDCgg7/a7pKL
         QfZUyIG5slEqSNFa3qen9E+CYr6HsrWry1N01V6+rMFPUNQy202YDAD61BUjyJzLVuTm
         BJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694884500; x=1695489300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0/dU+s24A21H8KB1oHsdy9DBO1Q1Csxfdq88eybO/s=;
        b=GPnSCS7kghNAvNn4UlIQF/iPMk5aM74NC05qQGHgYpKrIVZA7X9axlQ/k6XJC4rMUH
         ZpUyfBs9cWW0AbaEQav4YkvseWH3aXt+GByCiUEJjg1fdv0oCPAw0bJO4keCKzBzqMeQ
         nXOQZ6NQ5y6IYPw4xhC3bRo3gDrNromb7up6l7mEFEISQUe74tg2vmVYW8IP5OG23iNA
         EmRJ5iRPoCCJ+/CwM+2y0YXvnpdsMa1QlNBz0EjpPechjXLcyc7okyIo54OvfO5e23rP
         I5oPdKRXGaZFoN241vc94xOIRIYkOcF+hb/is5qtniVbfPkbAlDQdqPa3JiopKXBhiXg
         Hrmw==
X-Gm-Message-State: AOJu0Yzz944iZEMWs1VseOwIR+5wUgW2qCluEdRXtw3QkgWG2gXB2gFO
        U5mMfp9UcsDVSuTUZSnR3GU=
X-Google-Smtp-Source: AGHT+IGUMdqUPDmOKo2vF1VUL9r7QKRh6Irt+qGUl69dhqhtiX0wF0qpjc/2k7IOzsILrskI43p5+w==
X-Received: by 2002:a05:6000:1148:b0:31f:dcdd:71f with SMTP id d8-20020a056000114800b0031fdcdd071fmr3644066wrx.70.1694884499683;
        Sat, 16 Sep 2023 10:14:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id w4-20020a5d6804000000b003196e992567sm7712395wru.115.2023.09.16.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 10:14:59 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v6 3/3] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date:   Sat, 16 Sep 2023 16:00:46 +0200
Message-Id: <20230916140046.7878-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230916140046.7878-1-ansuelsmth@gmail.com>
References: <20230916140046.7878-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework nss_port5/6 to use the new multiple configuration implementation
and correctly fix the clocks for these port under some corner case.

This is particularly relevant for device that have 2.5G or 10G port
connected to port5 or port 6 on ipq8074. As the parent are shared
across multiple port it may be required to select the correct
configuration to accomplish the desired clock. Without this patch such
port doesn't work in some specific ethernet speed as the clock will be
set to the wrong frequency as we just select the first configuration for
the related frequency instead of selecting the best one.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 120 +++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 63ac2ced76bb..595cb7bd4834 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -1681,15 +1681,23 @@ static struct clk_regmap_div nss_port4_tx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port5_rx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY1_RX, 12.5, 0, 0),
-	F(25000000, P_UNIPHY0_RX, 5, 0, 0),
-	F(78125000, P_UNIPHY1_RX, 4, 0, 0),
-	F(125000000, P_UNIPHY1_RX, 2.5, 0, 0),
-	F(125000000, P_UNIPHY0_RX, 1, 0, 0),
-	F(156250000, P_UNIPHY1_RX, 2, 0, 0),
-	F(312500000, P_UNIPHY1_RX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port5_rx_clk_src_25[] = {
+	C(P_UNIPHY1_RX, 12.5, 0, 0),
+	C(P_UNIPHY0_RX, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port5_rx_clk_src_125[] = {
+	C(P_UNIPHY1_RX, 2.5, 0, 0),
+	C(P_UNIPHY0_RX, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port5_rx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port5_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port5_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1716,14 +1724,14 @@ gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port5_rx_clk_src = {
 	.cmd_rcgr = 0x68060,
-	.freq_tbl = ftbl_nss_port5_rx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port5_rx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port5_rx_clk_src",
 		.parent_data = gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1743,15 +1751,23 @@ static struct clk_regmap_div nss_port5_rx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port5_tx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY1_TX, 12.5, 0, 0),
-	F(25000000, P_UNIPHY0_TX, 5, 0, 0),
-	F(78125000, P_UNIPHY1_TX, 4, 0, 0),
-	F(125000000, P_UNIPHY1_TX, 2.5, 0, 0),
-	F(125000000, P_UNIPHY0_TX, 1, 0, 0),
-	F(156250000, P_UNIPHY1_TX, 2, 0, 0),
-	F(312500000, P_UNIPHY1_TX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port5_tx_clk_src_25[] = {
+	C(P_UNIPHY1_TX, 12.5, 0, 0),
+	C(P_UNIPHY0_TX, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port5_tx_clk_src_125[] = {
+	C(P_UNIPHY1_TX, 2.5, 0, 0),
+	C(P_UNIPHY0_TX, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port5_tx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port5_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_TX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port5_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_TX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_TX, 1, 0, 0),
 	{ }
 };
 
@@ -1778,14 +1794,14 @@ gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port5_tx_clk_src = {
 	.cmd_rcgr = 0x68068,
-	.freq_tbl = ftbl_nss_port5_tx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port5_tx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port5_tx_clk_src",
 		.parent_data = gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1805,15 +1821,23 @@ static struct clk_regmap_div nss_port5_tx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port6_rx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY2_RX, 5, 0, 0),
-	F(25000000, P_UNIPHY2_RX, 12.5, 0, 0),
-	F(78125000, P_UNIPHY2_RX, 4, 0, 0),
-	F(125000000, P_UNIPHY2_RX, 1, 0, 0),
-	F(125000000, P_UNIPHY2_RX, 2.5, 0, 0),
-	F(156250000, P_UNIPHY2_RX, 2, 0, 0),
-	F(312500000, P_UNIPHY2_RX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port6_rx_clk_src_25[] = {
+	C(P_UNIPHY2_RX, 5, 0, 0),
+	C(P_UNIPHY2_RX, 12.5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port6_rx_clk_src_125[] = {
+	C(P_UNIPHY2_RX, 1, 0, 0),
+	C(P_UNIPHY2_RX, 2.5, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port6_rx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port6_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY2_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port6_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY2_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY2_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1835,14 +1859,14 @@ static const struct parent_map gcc_xo_uniphy2_rx_tx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port6_rx_clk_src = {
 	.cmd_rcgr = 0x68070,
-	.freq_tbl = ftbl_nss_port6_rx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port6_rx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy2_rx_tx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port6_rx_clk_src",
 		.parent_data = gcc_xo_uniphy2_rx_tx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy2_rx_tx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1862,15 +1886,23 @@ static struct clk_regmap_div nss_port6_rx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port6_tx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY2_TX, 5, 0, 0),
-	F(25000000, P_UNIPHY2_TX, 12.5, 0, 0),
-	F(78125000, P_UNIPHY2_TX, 4, 0, 0),
-	F(125000000, P_UNIPHY2_TX, 1, 0, 0),
-	F(125000000, P_UNIPHY2_TX, 2.5, 0, 0),
-	F(156250000, P_UNIPHY2_TX, 2, 0, 0),
-	F(312500000, P_UNIPHY2_TX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port6_tx_clk_src_25[] = {
+	C(P_UNIPHY2_TX, 5, 0, 0),
+	C(P_UNIPHY2_TX, 12.5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port6_tx_clk_src_125[] = {
+	C(P_UNIPHY2_TX, 1, 0, 0),
+	C(P_UNIPHY2_TX, 2.5, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port6_tx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port6_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port6_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1892,14 +1924,14 @@ static const struct parent_map gcc_xo_uniphy2_tx_rx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port6_tx_clk_src = {
 	.cmd_rcgr = 0x68078,
-	.freq_tbl = ftbl_nss_port6_tx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port6_tx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy2_tx_rx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port6_tx_clk_src",
 		.parent_data = gcc_xo_uniphy2_tx_rx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy2_tx_rx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
-- 
2.40.1

