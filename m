Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFAC786BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbjHXJ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbjHXJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:27:09 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291910F9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:27:05 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37O9QTJA049400;
        Thu, 24 Aug 2023 17:26:29 +0800 (+08)
        (envelope-from zhifeng.tang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RWd1w0m3Sz2Q1xTT;
        Thu, 24 Aug 2023 17:24:04 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 24 Aug
 2023 17:26:27 +0800
From:   Zhifeng Tang <zhifeng.tang@unisoc.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Zhifeng Tang <zhifeng.tang@unisoc.com>,
        Cixi Geng <cixi.geng1@unisoc.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH V2] clk: sprd: Fix thm_parents incorrect configuration
Date:   Thu, 24 Aug 2023 17:26:24 +0800
Message-ID: <20230824092624.20020-1-zhifeng.tang@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 37O9QTJA049400
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thm*_clk have two clock sources 32k and 250k,excluding 32m.

Fixes: af3bd36573e3 ("clk: sprd: Add clocks support for UMS512")
Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
V2: add Fixes tag.
---
 drivers/clk/sprd/ums512-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/ums512-clk.c b/drivers/clk/sprd/ums512-clk.c
index fc25bdd85e4e..f43bb10bd5ae 100644
--- a/drivers/clk/sprd/ums512-clk.c
+++ b/drivers/clk/sprd/ums512-clk.c
@@ -800,7 +800,7 @@ static SPRD_MUX_CLK_DATA(uart1_clk, "uart1-clk", uart_parents,
 			 0x250, 0, 3, UMS512_MUX_FLAG);
 
 static const struct clk_parent_data thm_parents[] = {
-	{ .fw_name = "ext-32m" },
+	{ .fw_name = "ext-32k" },
 	{ .hw = &clk_250k.hw  },
 };
 static SPRD_MUX_CLK_DATA(thm0_clk, "thm0-clk", thm_parents,
-- 
2.17.1

