Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6349176D705
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHBSnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHBSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:43:35 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B71BC1;
        Wed,  2 Aug 2023 11:43:34 -0700 (PDT)
Received: from dslb-094-219-037-101.094.219.pools.vodafone-ip.de ([94.219.37.101] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qRGoj-0003Eh-48; Wed, 02 Aug 2023 20:43:29 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v7 2/2] clk: imx25: make __mx25_clocks_init return void
Date:   Wed,  2 Aug 2023 20:40:46 +0200
Message-Id: <20230802184046.153394-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802184046.153394-1-martin@kaiser.cx>
References: <20230802184046.153394-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __mx25_clocks_init function always returns 0 and its only
caller does not check the return value. Let's remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/imx/clk-imx25.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index bee3da2e21e1..c566be848c2d 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -74,7 +74,7 @@ enum mx25_clks {
 
 static struct clk *clk[clk_max];
 
-static int __init __mx25_clocks_init(void __iomem *ccm_base)
+static void __init __mx25_clocks_init(void __iomem *ccm_base)
 {
 	BUG_ON(!ccm_base);
 
@@ -222,8 +222,6 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
 	imx_register_uart_clocks();
 
 	imx_print_silicon_rev("i.MX25", mx25_revision());
-
-	return 0;
 }
 
 static void __init mx25_clocks_init_dt(struct device_node *np)
-- 
2.39.2

