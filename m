Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A393F75901B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGSIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGSIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:20:40 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DACE47
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:20:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8a8154f9cso3891105ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689754838; x=1690359638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvrNL5UWN6mNIbASEilDPVqVt7thD2eE3OsIzkYxI7I=;
        b=XI5s7DfLx3eSW5nL/LUsnrEXaPE/ooxI80C4QxzkEbkWYXnfLe+BHbuhImCqOSdriQ
         l6sMdg6HHdXgBERGHW0r4bHAwFdW+0rorUhjDL4g/MZykIlIwC1YqT1FKfvu8ikADeu9
         wWPzW1bc1Hc6C0PdO2cgAqAD3923Be4yRw8w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754838; x=1690359638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvrNL5UWN6mNIbASEilDPVqVt7thD2eE3OsIzkYxI7I=;
        b=QO20sIV0GEFEJZhkX+/0Lf3VW6uqrJ74jFtStL0DP+tj7XdEyg0XEhyGDXh428gJZ8
         N1BZ3nebtuas7zTV+/e0JDioEUhbgIUOHxRmu/EsNzzSYbYK2pMZAzhdGYd3/3ZEjWJx
         i8znzxvKCaRH8nQIA2uTeXPgUm2Rvx1magAK/Mli6m5GhW0kqXCtP/zwTQuxkB5wLUni
         yMuiEantDQ/Hajqrvs51dq+YL2qNIkFA1Vp2TK6Vo51WWE03u70D7ryTZstuk2nqvl9r
         Q+Nbu5VuauiL71WWr9CtX/48pYpXT885iyKeD9HR4WVtiFhi3pEEZPg6R7Jf2yAZZ2GX
         f3Pw==
X-Gm-Message-State: ABy/qLbIMczSG4d7hIYGv7BjTEE7v3PAn1SD6QrTxpdhOS4i/4O7BR/4
        tOSqL4sMjRuD6GODG501ommb4eyNO5YCtJ0vCGI=
X-Google-Smtp-Source: APBJJlHFenf1UttaPqhLjqQ7fRZRs8ORExfgZNfRzEnJjPWhWfu4jtYvVXQo0efwFW/ayI/HdfSWkw==
X-Received: by 2002:a17:902:a515:b0:1b5:674d:2aa5 with SMTP id s21-20020a170902a51500b001b5674d2aa5mr1742930plq.13.1689754838004;
        Wed, 19 Jul 2023 01:20:38 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:dc1f:4359:d310:3643])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b001b9d8688956sm3256110pli.144.2023.07.19.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:20:37 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: Check if clock ID is larger than clk_hw_onecell_data size
Date:   Wed, 19 Jul 2023 16:20:32 +0800
Message-ID: <20230719082033.1229277-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek clock driver library's simple-probe mechanism allocates
clk_hw_onecell_data based on how many clocks are defined. If there's a
mismatch between that and the actual number of clocks defined in the DT
binding, such that a clock ID exceeds the number, then an out-of-bounds
write will occur. This silently corrupts memory, maybe causing a crash
later on that seems unrelated. KASAN can detect this if turned on.

To avoid getting into said scenario, check if the to be registered
clock's ID will fit in the allocated clk_hw_onecell_data. If not, put
out a big warning and skip the clock.

One could argue that the proper fix is to let the drivers specify the
number of clocks (based on a DT binding macro) instead. However even
the DT binding macro could be wrong. And having code to catch errors
and give out warnings is better than having silent corruption.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This one is less urgent.

Angelo, do you think we should add a field to struct mtk_clk_desc and
assign CLK_XXX_NR_CLK to it?

 drivers/clk/mediatek/clk-gate.c | 11 +++++++++
 drivers/clk/mediatek/clk-mtk.c  | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 67d9e741c5e7..bb7c536ef60f 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -222,6 +222,11 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 	for (i = 0; i < num; i++) {
 		const struct mtk_gate *gate = &clks[i];
 
+		if (WARN(gate->id >= clk_data->num,
+			 "%pOF: gateclock ID (%d)larger than expected (%d)\n",
+			 node, gate->id, clk_data->num))
+			continue;
+
 		if (!IS_ERR_OR_NULL(clk_data->hws[gate->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, gate->id);
@@ -251,6 +256,9 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 	while (--i >= 0) {
 		const struct mtk_gate *gate = &clks[i];
 
+		if (gate->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
 			continue;
 
@@ -273,6 +281,9 @@ void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_gate *gate = &clks[i - 1];
 
+		if (gate->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
 			continue;
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 2e55368dc4d8..09d50a15db77 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -94,6 +94,10 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	for (i = 0; i < num; i++) {
 		const struct mtk_fixed_clk *rc = &clks[i];
 
+		if (WARN(rc->id >= clk_data->num,
+			 "Fixed clock ID (%d) larger than expected (%d)\n", rc->id, clk_data->num))
+			continue;
+
 		if (!IS_ERR_OR_NULL(clk_data->hws[rc->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n", rc->id);
 			continue;
@@ -117,6 +121,9 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	while (--i >= 0) {
 		const struct mtk_fixed_clk *rc = &clks[i];
 
+		if (rc->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
 			continue;
 
@@ -139,6 +146,9 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_fixed_clk *rc = &clks[i - 1];
 
+		if (rc->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
 			continue;
 
@@ -160,6 +170,11 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 	for (i = 0; i < num; i++) {
 		const struct mtk_fixed_factor *ff = &clks[i];
 
+		if (WARN(ff->id >= clk_data->num,
+			 "Fixed factor clock ID (%d) larger than expected (%d)\n",
+			 ff->id, clk_data->num))
+			continue;
+
 		if (!IS_ERR_OR_NULL(clk_data->hws[ff->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n", ff->id);
 			continue;
@@ -183,6 +198,9 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 	while (--i >= 0) {
 		const struct mtk_fixed_factor *ff = &clks[i];
 
+		if (ff->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
 			continue;
 
@@ -205,6 +223,9 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_fixed_factor *ff = &clks[i - 1];
 
+		if (ff->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
 			continue;
 
@@ -339,6 +360,11 @@ int mtk_clk_register_composites(struct device *dev,
 	for (i = 0; i < num; i++) {
 		const struct mtk_composite *mc = &mcs[i];
 
+		if (WARN(mc->id >= clk_data->num,
+			 "Composite clock ID (%d) larger than expected (%d)\n",
+			 mc->id, clk_data->num))
+			continue;
+
 		if (!IS_ERR_OR_NULL(clk_data->hws[mc->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n",
 				mc->id);
@@ -362,6 +388,9 @@ int mtk_clk_register_composites(struct device *dev,
 	while (--i >= 0) {
 		const struct mtk_composite *mc = &mcs[i];
 
+		if (mc->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
 			continue;
 
@@ -384,6 +413,9 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_composite *mc = &mcs[i - 1];
 
+		if (mc->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
 			continue;
 
@@ -407,6 +439,11 @@ int mtk_clk_register_dividers(struct device *dev,
 	for (i = 0; i <  num; i++) {
 		const struct mtk_clk_divider *mcd = &mcds[i];
 
+		if (WARN(mcd->id >= clk_data->num,
+			 "Divider clock ID (%d) larger than expected (%d)\n",
+			 mcd->id, clk_data->num))
+			continue;
+
 		if (!IS_ERR_OR_NULL(clk_data->hws[mcd->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n",
 				mcd->id);
@@ -432,6 +469,9 @@ int mtk_clk_register_dividers(struct device *dev,
 	while (--i >= 0) {
 		const struct mtk_clk_divider *mcd = &mcds[i];
 
+		if (mcd->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
@@ -454,6 +494,9 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_clk_divider *mcd = &mcds[i - 1];
 
+		if (mcd->id >= clk_data->num)
+			continue;
+
 		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
-- 
2.41.0.455.g037347b96a-goog

