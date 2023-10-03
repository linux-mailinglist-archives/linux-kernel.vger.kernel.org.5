Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470EB7B6880
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjJCMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjJCMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:07:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36964A6;
        Tue,  3 Oct 2023 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696334839; x=1727870839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U3EOJfwn2qZGpnaKKwcOGLnNMPKWTNMH26Wnxf9XbeQ=;
  b=a5YWEgITqTuMbOzO2A/RkwjlFyPCgdQAfPYeH4q1dPCG7mLrGdR74lvb
   57fFfiy6K//6L38kcsSVEWaFw1edFrFrKcqDewdZVQwslRH3W3rLKERCb
   hpsp5NjsK/9fzJjP3peFhKnpmG11mD6sM/5Q7lo3PFy1UxgdhGBWhP9dj
   6VkEZ6U0+DDNCBMfL/vLxPnP/avdv/tNkUbiDurmHEhjrjFIarOfARpbW
   4pXmUw1/L6yBgMI6U5P45PR/mp9vAee0KB4CU4fhSrA4gKKPVT3gbbXU9
   8KoWk3ZfpJvdx6i1ht0NTcwkT8bwk378we+CBtHEa3Ji0n6gYUYh0TXvR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="449347316"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="449347316"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081989157"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1081989157"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2023 05:07:15 -0700
From:   niravkumar.l.rabara@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
        Teh Wen Ping <wen.ping.teh@intel.com>
Subject: [PATCH v3] clk: socfpga: agilex: add support for the Intel Agilex5
Date:   Tue,  3 Oct 2023 20:04:02 +0800
Message-Id: <20231003120402.4186270-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
driver for the Agilex5 is very similar to the Agilex platform, so
it is reusing most of the Agilex clock driver code.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---

Changes in v3:
- Used different name for stratix10_clock_data pointer.
- Used a single function call, devm_platform_ioremap_resource().
- Used only .name in clk_parent_data.

Stephen suggested to use .fw_name or .index, But since the changes are on top
of existing driver and current driver code is not using clk_hw and removing
.name and using .fw_name and/or .index resulting in parent clock_rate &
recalc_rate to 0.

In order to use .index, I would need to refactor the common code that is shared
by a few Intel SoCFPGA platforms (S10, Agilex and N5x). So, if using .name for
this patch is acceptable then I will upgrade clk-agilex.c in future submission.

Changes in v2:
- Instead of creating separate clock manager driver, re-use agilex clock
  manager driver and modified it for agilex5 changes to avoid code
  duplicate.

 drivers/clk/socfpga/clk-agilex.c | 355 ++++++++++++++++++++++++++++++-
 1 file changed, 353 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 6b65a74aefa6..38ea7e7f600b 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2019, Intel Corporation
+ * Copyright (C) 2019-2023, Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 
 #include <dt-bindings/clock/agilex-clock.h>
+#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
 
 #include "stratix10-clk.h"
 
@@ -40,6 +41,44 @@ static const struct clk_parent_data mpu_free_mux[] = {
 	  .name = "f2s-free-clk", },
 };
 
+static const struct clk_parent_data core0_free_mux[] = {
+	{ .name = "main_pll_c1" },
+	{ .name = "peri_pll_c0" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data core1_free_mux[] = {
+	{ .name = "main_pll_c1" },
+	{ .name = "peri_pll_c0" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data core2_free_mux[] = {
+	{ .name = "main_pll_c0" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data core3_free_mux[] = {
+	{ .name = "main_pll_c0" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data dsu_free_mux[] = {
+	{ .name = "main_pll_c2" },
+	{ .name = "peri_pll_c0" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
 static const struct clk_parent_data noc_free_mux[] = {
 	{ .fw_name = "main_pll_c1",
 	  .name = "main_pll_c1", },
@@ -52,7 +91,6 @@ static const struct clk_parent_data noc_free_mux[] = {
 	{ .fw_name = "f2s-free-clk",
 	  .name = "f2s-free-clk", },
 };
-
 static const struct clk_parent_data emaca_free_mux[] = {
 	{ .fw_name = "main_pll_c2",
 	  .name = "main_pll_c2", },
@@ -157,6 +195,70 @@ static const struct clk_parent_data s2f_usr1_free_mux[] = {
 	  .name = "f2s-free-clk", },
 };
 
+static const struct clk_parent_data agilex5_emaca_free_mux[] = {
+	{ .name = "main_pll_c1" },
+	{ .name = "peri_pll_c3" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data agilex5_emacb_free_mux[] = {
+	{ .name = "main_pll_c1" },
+	{ .name = "peri_pll_c3" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data agilex5_emac_ptp_free_mux[] = {
+	{ .name = "main_pll_c1" },
+	{ .name = "peri_pll_c3" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data agilex5_gpio_db_free_mux[] = {
+	{ .name = "main_pll_c3" },
+	{ .name = "peri_pll_c1" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data agilex5_psi_ref_free_mux[] = {
+	{ .name = "main_pll_c1" },
+	{ .name = "peri_pll_c3" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data agilex5_usb31_free_mux[] = {
+	{ .name = "main_pll_c3" },
+	{ .name = "peri_pll_c2" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data agilex5_s2f_usr0_free_mux[] = {
+	{ .name = "main_pll_c1" },
+	{ .name = "peri_pll_c3" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data agilex5_s2f_usr1_free_mux[] = {
+	{ .name = "main_pll_c1" },
+	{ .name = "peri_pll_c3" },
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
 static const struct clk_parent_data mpu_mux[] = {
 	{ .fw_name = "mpu_free_clk",
 	  .name = "mpu_free_clk", },
@@ -164,6 +266,31 @@ static const struct clk_parent_data mpu_mux[] = {
 	  .name = "boot_clk", },
 };
 
+static const struct clk_parent_data core0_mux[] = {
+	{ .name = "core0_free_clk" },
+	{ .name = "boot_clk" },
+};
+
+static const struct clk_parent_data core1_mux[] = {
+	{ .name = "core1_free_clk" },
+	{ .name = "boot_clk" },
+};
+
+static const struct clk_parent_data core2_mux[] = {
+	{ .name = "core2_free_clk" },
+	{ .name = "boot_clk" },
+};
+
+static const struct clk_parent_data core3_mux[] = {
+	{ .name = "core3_free_clk" },
+	{ .name = "boot_clk" },
+};
+
+static const struct clk_parent_data dsu_mux[] = {
+	{ .name = "dsu_free_clk" },
+	{ .name = "boot_clk" },
+};
+
 static const struct clk_parent_data emac_mux[] = {
 	{ .fw_name = "emaca_free_clk",
 	  .name = "emaca_free_clk", },
@@ -222,6 +349,11 @@ static const struct clk_parent_data emac_ptp_mux[] = {
 	  .name = "boot_clk", },
 };
 
+static const struct clk_parent_data usb31_mux[] = {
+	{ .name = "usb31_free_clk" },
+	{ .name = "boot_clk" },
+};
+
 /* clocks in AO (always on) controller */
 static const struct stratix10_pll_clock agilex_pll_clks[] = {
 	{ AGILEX_BOOT_CLK, "boot_clk", boot_mux, ARRAY_SIZE(boot_mux), 0,
@@ -254,6 +386,25 @@ static const struct stratix10_perip_c_clock agilex_main_perip_c_clks[] = {
 	{ AGILEX_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0, 0xBC},
 };
 
+static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
+	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
+	  0x5C },
+	{ AGILEX5_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0,
+	  0x60 },
+	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
+	  0x64 },
+	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
+	  0x68 },
+	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
+	  0xB0 },
+	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
+	  0xB4 },
+	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
+	  0xB8 },
+	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
+	  0xBC },
+};
+
 static const struct stratix10_perip_cnt_clock agilex_main_perip_cnt_clks[] = {
 	{ AGILEX_MPU_FREE_CLK, "mpu_free_clk", NULL, mpu_free_mux, ARRAY_SIZE(mpu_free_mux),
 	   0, 0x3C, 0, 0, 0},
@@ -279,6 +430,46 @@ static const struct stratix10_perip_cnt_clock agilex_main_perip_cnt_clks[] = {
 	  ARRAY_SIZE(psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6},
 };
 
+/* Non-SW clock-gated enabled clocks */
+static const struct stratix10_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
+	{ AGILEX5_CORE0_FREE_CLK, "core0_free_clk", NULL, core0_free_mux,
+	  ARRAY_SIZE(core0_free_mux), 0, 0x0104, 0, 0, 0 },
+	{ AGILEX5_CORE1_FREE_CLK, "core1_free_clk", NULL, core1_free_mux,
+	  ARRAY_SIZE(core1_free_mux), 0, 0x0104, 0, 0, 0 },
+	{ AGILEX5_CORE2_FREE_CLK, "core2_free_clk", NULL, core2_free_mux,
+	  ARRAY_SIZE(core2_free_mux), 0, 0x010C, 0, 0, 0 },
+	{ AGILEX5_CORE3_FREE_CLK, "core3_free_clk", NULL, core3_free_mux,
+	  ARRAY_SIZE(core3_free_mux), 0, 0x0110, 0, 0, 0 },
+	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", NULL, dsu_free_mux,
+	  ARRAY_SIZE(dsu_free_mux), 0, 0x0100, 0, 0, 0 },
+	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux,
+	  ARRAY_SIZE(noc_free_mux), 0, 0x40, 0, 0, 0 },
+	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", NULL,
+	  agilex5_emaca_free_mux, ARRAY_SIZE(agilex5_emaca_free_mux), 0, 0xD4,
+	  0, 0x88, 0 },
+	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", NULL,
+	  agilex5_emacb_free_mux, ARRAY_SIZE(agilex5_emacb_free_mux), 0, 0xD8,
+	  0, 0x88, 1 },
+	{ AGILEX5_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL,
+	  agilex5_emac_ptp_free_mux, ARRAY_SIZE(agilex5_emac_ptp_free_mux), 0,
+	  0xDC, 0, 0x88, 2 },
+	{ AGILEX5_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL,
+	  agilex5_gpio_db_free_mux, ARRAY_SIZE(agilex5_gpio_db_free_mux), 0,
+	  0xE0, 0, 0x88, 3 },
+	{ AGILEX5_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL,
+	  agilex5_s2f_usr0_free_mux, ARRAY_SIZE(agilex5_s2f_usr0_free_mux), 0,
+	  0xE8, 0, 0x30, 2 },
+	{ AGILEX5_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL,
+	  agilex5_s2f_usr1_free_mux, ARRAY_SIZE(agilex5_s2f_usr1_free_mux), 0,
+	  0xEC, 0, 0x88, 5 },
+	{ AGILEX5_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL,
+	  agilex5_psi_ref_free_mux, ARRAY_SIZE(agilex5_psi_ref_free_mux), 0,
+	  0xF0, 0, 0x88, 6 },
+	{ AGILEX5_USB31_FREE_CLK, "usb31_free_clk", NULL,
+	  agilex5_usb31_free_mux, ARRAY_SIZE(agilex5_usb31_free_mux), 0, 0xF8,
+	  0, 0x88, 7 },
+};
+
 static const struct stratix10_gate_clock agilex_gate_clks[] = {
 	{ AGILEX_MPU_CLK, "mpu_clk", NULL, mpu_mux, ARRAY_SIZE(mpu_mux), 0, 0x24,
 	  0, 0, 0, 0, 0x30, 0, 0},
@@ -334,6 +525,122 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
 	  10, 0, 0, 0, 0, 0, 4},
 };
 
+/* SW Clock gate enabled clocks */
+static const struct stratix10_gate_clock agilex5_gate_clks[] = {
+	/* Main PLL0 Begin */
+	/* MPU clocks */
+	{ AGILEX5_CORE0_CLK, "core0_clk", NULL, core0_mux,
+	  ARRAY_SIZE(core0_mux), 0, 0x24, 8, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE1_CLK, "core1_clk", NULL, core1_mux,
+	  ARRAY_SIZE(core1_mux), 0, 0x24, 9, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE2_CLK, "core2_clk", NULL, core2_mux,
+	  ARRAY_SIZE(core2_mux), 0, 0x24, 10, 0, 0, 0, 0x30, 6, 0 },
+	{ AGILEX5_CORE3_CLK, "core3_clk", NULL, core3_mux,
+	  ARRAY_SIZE(core3_mux), 0, 0x24, 11, 0, 0, 0, 0x30, 7, 0 },
+	{ AGILEX5_MPU_CLK, "dsu_clk", NULL, dsu_mux, ARRAY_SIZE(dsu_mux), 0, 0,
+	  0, 0, 0, 0, 0x34, 4, 0 },
+	{ AGILEX5_MPU_PERIPH_CLK, "mpu_periph_clk", NULL, dsu_mux,
+	  ARRAY_SIZE(dsu_mux), 0, 0, 0, 0x44, 20, 2, 0x34, 4, 0 },
+	{ AGILEX5_MPU_CCU_CLK, "mpu_ccu_clk", NULL, dsu_mux,
+	  ARRAY_SIZE(dsu_mux), 0, 0, 0, 0x44, 18, 2, 0x34, 4, 0 },
+	{ AGILEX5_L4_MAIN_CLK, "l4_main_clk", NULL, noc_mux,
+	  ARRAY_SIZE(noc_mux), 0, 0x24, 1, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_L4_MP_CLK, "l4_mp_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0,
+	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", NULL, noc_mux,
+	  ARRAY_SIZE(noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux),
+	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
+
+	/* Core sight clocks*/
+	{ AGILEX5_CS_AT_CLK, "cs_at_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0,
+	  0x24, 4, 0x44, 24, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_TRACE_CLK, "cs_trace_clk", NULL, noc_mux,
+	  ARRAY_SIZE(noc_mux), 0, 0x24, 4, 0x44, 26, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x24, 4,
+	  0x44, 28, 1, 0, 0, 0 },
+	/* Main PLL0 End */
+
+	/* Main Peripheral PLL1 Begin */
+	{ AGILEX5_EMAC0_CLK, "emac0_clk", NULL, emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 0, 0, 0, 0, 0x94, 26, 0 },
+	{ AGILEX5_EMAC1_CLK, "emac1_clk", NULL, emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 1, 0, 0, 0, 0x94, 27, 0 },
+	{ AGILEX5_EMAC2_CLK, "emac2_clk", NULL, emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 2, 0, 0, 0, 0x94, 28, 0 },
+	{ AGILEX5_EMAC_PTP_CLK, "emac_ptp_clk", NULL, emac_ptp_mux,
+	  ARRAY_SIZE(emac_ptp_mux), 0, 0x7C, 3, 0, 0, 0, 0x88, 2, 0 },
+	{ AGILEX5_GPIO_DB_CLK, "gpio_db_clk", NULL, gpio_db_mux,
+	  ARRAY_SIZE(gpio_db_mux), 0, 0x7C, 4, 0x98, 0, 16, 0x88, 3, 1 },
+	  /* Main Peripheral PLL1 End */
+
+	  /* Peripheral clocks  */
+	{ AGILEX5_S2F_USER0_CLK, "s2f_user0_clk", NULL, s2f_user0_mux,
+	  ARRAY_SIZE(s2f_user0_mux), 0, 0x24, 6, 0, 0, 0, 0x30, 2, 0 },
+	{ AGILEX5_S2F_USER1_CLK, "s2f_user1_clk", NULL, s2f_user1_mux,
+	  ARRAY_SIZE(s2f_user1_mux), 0, 0x7C, 6, 0, 0, 0, 0x88, 5, 0 },
+	{ AGILEX5_PSI_REF_CLK, "psi_ref_clk", NULL, psi_mux,
+	  ARRAY_SIZE(psi_mux), 0, 0x7C, 7, 0, 0, 0, 0x88, 6, 0 },
+	{ AGILEX5_USB31_SUSPEND_CLK, "usb31_suspend_clk", NULL, usb31_mux,
+	  ARRAY_SIZE(usb31_mux), 0, 0x7C, 25, 0, 0, 0, 0x88, 7, 0 },
+	{ AGILEX5_USB31_BUS_CLK_EARLY, "usb31_bus_clk_early", "l4_main_clk",
+	  NULL, 1, 0, 0x7C, 25, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_USB2OTG_HCLK, "usb2otg_hclk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  8, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_0_CLK, "spim_0_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 9,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_1_CLK, "spim_1_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 11,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_0_CLK, "spis_0_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 12,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_1_CLK, "spis_1_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 13,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_CORE_CLK, "dma_core_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  14, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_HS_CLK, "dma_hs_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 14,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_0_CORE_CLK, "i3c_0_core_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 18, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_1_CORE_CLK, "i3c_1_core_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 19, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_0_PCLK, "i2c_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 15,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_1_PCLK, "i2c_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 16,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC0_PCLK, "i2c_emac0_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 17, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC1_PCLK, "i2c_emac1_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 22, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC2_PCLK, "i2c_emac2_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 27, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_0_PCLK, "uart_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 20,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_1_PCLK, "uart_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 21,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_0_PCLK, "sptimer_0_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 23, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_1_PCLK, "sptimer_1_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 24, 0, 0, 0, 0, 0, 0 },
+
+	/* NAND, SD/MMC and SoftPHY overall clocking */
+	{ AGILEX5_DFI_CLK, "dfi_clk", "l4_mp_clk", NULL, 1, 0, 0, 0, 0x44, 16,
+	  2, 0, 0, 0 },
+	{ AGILEX5_NAND_NF_CLK, "nand_nf_clk", "dfi_clk", NULL, 1, 0, 0x7C, 10,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_NAND_BCH_CLK, "nand_bch_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  10, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMMC_SDPHY_REG_CLK, "sdmmc_sdphy_reg_clk", "l4_mp_clk", NULL,
+	  1, 0, 0x7C, 5, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMCLK, "sdmclk", "dfi_clk", NULL, 1, 0, 0x7C, 5, 0, 0, 0, 0,
+	  0, 0 },
+	{ AGILEX5_SOFTPHY_REG_PCLK, "softphy_reg_pclk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_PHY_CLK, "softphy_phy_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 26, 0x44, 16, 2, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_CTRL_CLK, "softphy_ctrl_clk", "dfi_clk", NULL, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+};
+
 static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
 				       int nums, struct stratix10_clock_data *data)
 {
@@ -532,6 +839,48 @@ static int n5x_clkmgr_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int agilex5_clkmgr_init(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stratix10_clock_data *stratix_data;
+	void __iomem *base;
+	int i, num_clks;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	num_clks = AGILEX5_NUM_CLKS;
+
+	stratix_data = devm_kzalloc(dev, struct_size(stratix_data, clk_data.hws
+						 , num_clks), GFP_KERNEL);
+	if (!stratix_data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clks; i++)
+		stratix_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	stratix_data->base = base;
+	stratix_data->clk_data.num = num_clks;
+
+	agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks),
+				stratix_data);
+
+	agilex_clk_register_c_perip(agilex5_main_perip_c_clks,
+				    ARRAY_SIZE(agilex5_main_perip_c_clks),
+				    stratix_data);
+
+	agilex_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
+				      ARRAY_SIZE(agilex5_main_perip_cnt_clks),
+				      stratix_data);
+
+	agilex_clk_register_gate(agilex5_gate_clks,
+				 ARRAY_SIZE(agilex5_gate_clks), stratix_data);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   &stratix_data->clk_data);
+}
+
 static int agilex_clkmgr_probe(struct platform_device *pdev)
 {
 	int (*probe_func)(struct platform_device *init_func);
@@ -547,6 +896,8 @@ static const struct of_device_id agilex_clkmgr_match_table[] = {
 	  .data = agilex_clkmgr_init },
 	{ .compatible = "intel,easic-n5x-clkmgr",
 	  .data = n5x_clkmgr_init },
+	{ .compatible = "intel,agilex5-clkmgr",
+	  .data = agilex5_clkmgr_init },
 	{ }
 };
 
-- 
2.25.1

