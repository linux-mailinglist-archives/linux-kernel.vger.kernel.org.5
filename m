Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7757B7D45FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjJXDbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjJXDbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:31:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561619F;
        Mon, 23 Oct 2023 20:31:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3BDC433C8;
        Tue, 24 Oct 2023 03:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698118306;
        bh=FyxQRoyABjxA1s7iHpRFuk9i7fK0p0gpD74X0piO/30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d482tgTROHc0UMrauf8piBvV2BSYBoHJ0ugOhrKRpW1Of5vRvcg0pzmix8Q/ZBDOc
         QWyI9Mn6a5reMdqwe9nNeP4idQCzHA5A3d6wj33RpX4NwgaQ3tvsoV4Y6HkK5TsFFQ
         2by2MIY/eqUf/sIueq0RapD6WenpkWr3g+qMFQRyzjXthUhYo32KqLXH5wT62XfbqC
         NJXQMNKBALEq3O24J/q92RKxOxO1olS1Nhb7RhSUhvXf14XJofMOCz+Qn+guhABU2F
         PsJwMMEjwY0GmRCfTkbiL7hcXR03hAcLxfRAhLK56UcOXtUnFY09xSSr40gAvRjjSW
         nKKTKhlCHEpLQ==
Date:   Mon, 23 Oct 2023 21:31:42 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 2/2][next] clk: socfpga: agilex: Add bounds-checking
 coverage for struct stratix10_clock_data
Message-ID: <385c516c498e07eb9a521107e16a7efd26e86ea5.1698117815.git.gustavoars@kernel.org>
References: <cover.1698117815.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698117815.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to gain the bounds-checking coverage that __counted_by provides
to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
we must make sure that the counter member, in this case `num`, is updated
before the first access to the flex-array member, in this case array `hws`.

commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
__counted_by") introduced `__counted_by` for `struct clk_hw_onecell_data`
together with changes to relocate some of assignments of counter `num`
before `hws` is accessed:

include/linux/clk-provider.h:
1380 struct clk_hw_onecell_data {
1381         unsigned int num;
1382         struct clk_hw *hws[] __counted_by(num);
1383 };

However, this structure is used as a member in other structs, in this
case in `struct sstratix10_clock_data`:

drivers/clk/socfpga/stratix10-clk.h:
  9 struct stratix10_clock_data {
 10         void __iomem            *base;
 11
 12         /* Must be last */
 13         struct clk_hw_onecell_data      clk_data;
 14 };

Hence, we need to move the assignments to `clk_data->clk_data.num` after
allocations for `struct stratix10_clock_data` and before accessing the
flexible array `clk_data->clk_data.hws`. And, as assignments for both
`clk_data->clk_data.num` and `clk_data->base` are originally adjacent to
each other, relocate both assignments together.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - None, really. Just Cc linux-clk@vger.kernel.org this time.

Changes in v2:
 - None.
 - Link: https://lore.kernel.org/linux-hardening/f531ae35ef434b62f48534c67ad3b1013bff0536.1697493574.git.gustavoars@kernel.org/

v1:
 - Link: https://lore.kernel.org/linux-hardening/fd4cd8503316d536e1a84fa2ae5bdefdd4b24afe.1697059539.git.gustavoars@kernel.org/

 drivers/clk/socfpga/clk-agilex.c | 12 ++++++------
 drivers/clk/socfpga/clk-s10.c    |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 6b65a74aefa6..8dd94f64756b 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -471,12 +471,12 @@ static int agilex_clkmgr_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
+	clk_data->clk_data.num = num_clks;
+	clk_data->base = base;
+
 	for (i = 0; i < num_clks; i++)
 		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
-	clk_data->base = base;
-	clk_data->clk_data.num = num_clks;
-
 	agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
 
 	agilex_clk_register_c_perip(agilex_main_perip_c_clks,
@@ -511,12 +511,12 @@ static int n5x_clkmgr_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	for (i = 0; i < num_clks; i++)
-		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
 	clk_data->base = base;
 	clk_data->clk_data.num = num_clks;
 
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
 	n5x_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
 
 	n5x_clk_register_c_perip(n5x_main_perip_c_clks,
diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index 3752bd9c103c..b4bf4e2d38e1 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -402,12 +402,12 @@ static int s10_clkmgr_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	for (i = 0; i < num_clks; i++)
-		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
 	clk_data->base = base;
 	clk_data->clk_data.num = num_clks;
 
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
 	s10_clk_register_pll(s10_pll_clks, ARRAY_SIZE(s10_pll_clks), clk_data);
 
 	s10_clk_register_c_perip(s10_main_perip_c_clks,
-- 
2.34.1

