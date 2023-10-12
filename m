Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A17C62A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376637AbjJLCTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjJLCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:18:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6949FB6;
        Wed, 11 Oct 2023 19:18:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BE0C433C8;
        Thu, 12 Oct 2023 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697077129;
        bh=NePGQwBKuxNkoa39buLkrVoRes9zHH25Dkf23OgpCjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVhiz6z/97OOSugRxlauh+TMHfJufV+mWRoRMD2YXt8tyY1UPkDiYTakb/Bx/GamR
         MigEfZyD9OMed1dDbdfM87yNyzEAliLbMH98/oI6B1+taXYd2rbvFvrdy9xWhe2+A+
         SIGWUgGYJx7/XsjBDTpzj3OY2ODYJ1iPYFsHmZjRTqM+78PHUrfH2QcgRaxU/dKcv0
         vpsC8wp2NPgL8NzJigOm+oTjYH/L459BACaMAgKkPqX6tj7kiFvdTzQ+ckpjSM53O8
         kzGsqRjWfpOSEngRJbl4wenw7qBM6A3F+VxRRGTuEJr+f7faCg2DKIFtiR+ZnyPFff
         ysV2ArQKTDviA==
Date:   Wed, 11 Oct 2023 20:18:45 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2][next] clk: visconti: Add bounds-checking coverage for
 struct visconti_pll_provider
Message-ID: <675633f7ae9893371d35b238f06fd02a3acffebb.1697076650.git.gustavoars@kernel.org>
References: <cover.1697076650.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697076650.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to gain the bounds-checking coverage that __counted_by provides
to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
we must make sure that the counter member, in this particular case `num`,
is updated before the first access to the flex-array member, in this
particular case array `hws`. See below:

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
case in `struct visconti_pll_provider`:

drivers/clk/visconti/pll.h:
 16 struct visconti_pll_provider {
 17         void __iomem *reg_base;
 18         struct device_node *node;
 19 
 20         /* Must be last */
 21         struct clk_hw_onecell_data clk_data;
 22 };

Hence, we need to move the assignments to `ctx->clk_data.num` after
allocation for `struct visconti_pll_provider` and before accessing the
flexible array `ctx->clk_data.hws`. And, as assignments for all members
in `struct visconti_pll_provider` are originally adjacent to each other,
relocate all assignments together, so we don't split up
`ctx->clk_data.hws = nr_plls` from the rest. :)

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/clk/visconti/pll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index 1f3234f22667..e9cd80e085dc 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -329,12 +329,12 @@ struct visconti_pll_provider * __init visconti_init_pll(struct device_node *np,
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < nr_plls; ++i)
-		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
 	ctx->node = np;
 	ctx->reg_base = base;
 	ctx->clk_data.num = nr_plls;
 
+	for (i = 0; i < nr_plls; ++i)
+		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
 	return ctx;
 }
-- 
2.34.1

