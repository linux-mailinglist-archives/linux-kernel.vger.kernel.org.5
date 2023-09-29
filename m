Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6DD7B3262
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjI2MW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjI2MWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:22:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3CDB;
        Fri, 29 Sep 2023 05:22:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C77C433C7;
        Fri, 29 Sep 2023 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695990142;
        bh=onr4E2zy8QxxECg2mmeEJTSq+uZ+1e4V0MgwLNWcHJs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JdiLzkcwIC51Bph4LmLr+WWa03JuKQK75w7VlBv3VXi6/PfPN1i+7els4lWOuPrtA
         Zok+pelr/yOooYK2rGKEBRpMdRt/YfYeLt2TdwqL1Y05znS/y2drW6JFOrM+1+0kGU
         N0c/xtd/5ZJZorJ4hD6pd14WWAmMzyIOPEd9+XM0tNAUzIZaD9KCkgrIiUBB37KO4o
         fgFnPBwh6yFraGRclOty/tzyC/7kve9gNbdVdSnGN30r1tT8DMJ9InYqtH6MtVoAvK
         HyTopM9tm18c1Ci6DHdIB2giv9KjDshKyyjO7AB3mK7j9MGn4l81XWB8N/3XHAhKam
         +51FVexN+6/fA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 14:22:00 +0200
Subject: [PATCH 2/5] clk: si5341: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-si-v1-2-e26cfcaf27bd@kernel.org>
References: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
In-Reply-To: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=broonie@kernel.org;
 h=from:subject:message-id; bh=onr4E2zy8QxxECg2mmeEJTSq+uZ+1e4V0MgwLNWcHJs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFsF2bGoaSBH7Gym6qj1TRlnzpmwPi1Q6+wqZ2
 SxShjFgPI6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbBdgAKCRAk1otyXVSH
 0HOKB/9Xpfpp0NXygXuNyeLnctDPY3e/Uyo183sMLbVmnLp6h4ZK9/yljjDueMY0hsmQLI51CXD
 XshkPCOOAv/ulaaSBgOSnzSpkBs4e/o5SaRUiUPoXwUHlmhPsgKLnhMnZ/SMEEi9XMRWMS3eiCo
 XetjC1rcDdZv/pHU4zI1/YxalJ7MA3PQU8cdOQYpD6Dv+A5AMt0BCjursR9X/FH53CpSIfuAGYG
 lsmONzufGfM9MgsZ8clHuojDq9jV5TLDm8jd5rSvicIhjGBfIGLW0hz8PUEBNaySSUfJoFTX1+s
 a8g3EJVN8iFbvBV50mKcPdKIEYsywsgPP2zNH63UbZ4Ywyx/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/clk/clk-si5341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 9599857842c7..845b451511d2 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1260,7 +1260,7 @@ static int si5341_wait_device_ready(struct i2c_client *client)
 static const struct regmap_config si5341_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.ranges = si5341_regmap_ranges,
 	.num_ranges = ARRAY_SIZE(si5341_regmap_ranges),
 	.max_register = SI5341_REGISTER_MAX,

-- 
2.39.2

