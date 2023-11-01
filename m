Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012077DDB6A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjKADRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjKADRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:17:06 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EAAB8B4;
        Tue, 31 Oct 2023 20:17:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 2C6C06051EAB4;
        Wed,  1 Nov 2023 11:16:59 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     mike.looijmans@topic.nl, mturquette@baylibre.com, sboyd@kernel.org
Cc:     Su Hui <suhui@nfschina.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] clk: si5341: fix an error code problem in si5341_output_clk_set_rate
Date:   Wed,  1 Nov 2023 11:16:36 +0800
Message-Id: <20231101031633.996124-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_bulk_write() return zero or negative error code, return the value
of regmap_bulk_write() rather than '0'.

Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
Acked-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/clk/clk-si5341.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 9599857842c7..2920fe2e5e8b 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -895,10 +895,8 @@ static int si5341_output_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	r[0] = r_div ? (r_div & 0xff) : 1;
 	r[1] = (r_div >> 8) & 0xff;
 	r[2] = (r_div >> 16) & 0xff;
-	err = regmap_bulk_write(output->data->regmap,
+	return regmap_bulk_write(output->data->regmap,
 			SI5341_OUT_R_REG(output), r, 3);
-
-	return 0;
 }
 
 static int si5341_output_reparent(struct clk_si5341_output *output, u8 index)
-- 
2.30.2

