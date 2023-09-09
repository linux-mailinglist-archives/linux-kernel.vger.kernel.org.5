Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39671799301
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbjIIAHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjIIAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:07:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0BD133;
        Fri,  8 Sep 2023 17:07:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83797C433C7;
        Sat,  9 Sep 2023 00:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694218024;
        bh=8bKjNMrsD+rzvcII29VJTnYW3CdOpmYhoTwkp4WQ0LU=;
        h=From:To:Cc:Subject:Date:From;
        b=lV2bPGPP14MM8bMUL8ehuFIGK1u464H5Yj6Wx/jqafWe0x5DKwCrl/zRUeYa8IkV2
         dXmGgMOcQ8/PIa5ElPTPWOjbDZEChv8DAHOk/KzhM6Aqo0tZd7GHSuRDMPqOdp3jhT
         C818kJXLGyj9gIDd9X5DQ3GxA4r7sBM+dee4IHUD7ZdpNX8ANawU5L6g/9R+jqYh6F
         ZxRAqoWppHALHpmw1Vtoh5VLg/TpGXqoJ9MxbAastt16gYgs6j4Qo+95qvL6hULdqT
         wYMnsmI4aWrUVuuxCqKxcOO/7ZZQt5JDDm7cOBZPdtXQGgbjqIz4ZdULT1CpbbpUd+
         ZpJGrXKuApsnA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: asm9620: Remove 'hw' local variable that isn't checked
Date:   Fri,  8 Sep 2023 17:07:02 -0700
Message-ID: <20230909000703.3478902-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'hw' pointer local variable in this function became unused after
commit f5290d8e4f0c ("clk: asm9260: use parent index to link the
reference clock"). Remove it to silence an unused but set variable
warning.

 drivers/clk/clk-asm9260.c:258:17: warning: variable 'hw' set but not used [-Wunused-but-set-variable]
           struct clk_hw *hw, *pll_hw;
                          ^
   1 warning generated.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: f5290d8e4f0c ("clk: asm9260: use parent index to link the reference clock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309042014.IWERPl09-lkp@intel.com/
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-asm9260.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index 8b3c059e19a1..3432c801f1bd 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -255,7 +255,7 @@ static struct asm9260_mux_clock asm9260_mux_clks[] __initdata = {
 
 static void __init asm9260_acc_init(struct device_node *np)
 {
-	struct clk_hw *hw, *pll_hw;
+	struct clk_hw *pll_hw;
 	struct clk_hw **hws;
 	const char *pll_clk = "pll";
 	struct clk_parent_data pll_parent_data = { .index = 0 };
@@ -283,7 +283,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 	for (n = 0; n < ARRAY_SIZE(asm9260_mux_clks); n++) {
 		const struct asm9260_mux_clock *mc = &asm9260_mux_clks[n];
 
-		hw = clk_hw_register_mux_table_parent_data(NULL, mc->name, mc->parent_data,
+		clk_hw_register_mux_table_parent_data(NULL, mc->name, mc->parent_data,
 				mc->num_parents, mc->flags, base + mc->offset,
 				0, mc->mask, 0, mc->table, &asm9260_clk_lock);
 	}
@@ -292,7 +292,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 	for (n = 0; n < ARRAY_SIZE(asm9260_mux_gates); n++) {
 		const struct asm9260_gate_data *gd = &asm9260_mux_gates[n];
 
-		hw = clk_hw_register_gate(NULL, gd->name,
+		clk_hw_register_gate(NULL, gd->name,
 			gd->parent_name, gd->flags | CLK_SET_RATE_PARENT,
 			base + gd->reg, gd->bit_idx, 0, &asm9260_clk_lock);
 	}

base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

