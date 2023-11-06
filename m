Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C271A7E314E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjKFXXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjKFXXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:23:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DBB4227;
        Mon,  6 Nov 2023 15:17:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA3BC116B1;
        Mon,  6 Nov 2023 23:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312637;
        bh=3mJ+LCciYrX66nE0y5ZlruxIoBmabJFJGkwf+EKV+oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hicWDTXwzcCdiFaTeXfrgExxlhatGEvLYnc+J7Aq2MrA6uqtrUg5OdMCmcgSwAV6u
         UaaM0yg3WiiKBVvFbZwhUPtr1MGE79LMdZX85VNE6lJFwRDzbyX4b2dfUpsxTm+e5s
         rBkwgtp6Admndar904u98vxgUly0UGO6rehAj76Sy2TX7ePiNq0NYjtMDBxyM0nNKl
         fLHbiB2vq1FJmE2OxuLCtyNLpZ6y17WMqsaljXt7gfIKjm1MvrF2RRW8X0roNruLbM
         cTwrp3UdHeaANgBfih8+v+DBUz5dnVWG9A5SjQJMPZ4U8zC8milXykM8LfTSwj0pIb
         RFbm4C/efoA0w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 2/5] clocksource/drivers/timer-imx-gpt: Fix potential memory leak
Date:   Mon,  6 Nov 2023 18:17:05 -0500
Message-ID: <20231106231711.3735997-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231711.3735997-1-sashal@kernel.org>
References: <20231106231711.3735997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

[ Upstream commit 8051a993ce222a5158bccc6ac22ace9253dd71cb ]

Fix coverity Issue CID 250382:  Resource leak (RESOURCE_LEAK).
Add kfree when error return.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231009083922.1942971-1-ping.bai@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-imx-gpt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 165fbbb1c9a04..0e67026d782fe 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -473,12 +473,16 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 		return -ENOMEM;
 
 	imxtm->base = of_iomap(np, 0);
-	if (!imxtm->base)
-		return -ENXIO;
+	if (!imxtm->base) {
+		ret = -ENXIO;
+		goto err_kfree;
+	}
 
 	imxtm->irq = irq_of_parse_and_map(np, 0);
-	if (imxtm->irq <= 0)
-		return -EINVAL;
+	if (imxtm->irq <= 0) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
 
 	imxtm->clk_ipg = of_clk_get_by_name(np, "ipg");
 
@@ -491,11 +495,15 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 
 	ret = _mxc_timer_init(imxtm);
 	if (ret)
-		return ret;
+		goto err_kfree;
 
 	initialized = 1;
 
 	return 0;
+
+err_kfree:
+	kfree(imxtm);
+	return ret;
 }
 
 static int __init imx1_timer_init_dt(struct device_node *np)
-- 
2.42.0

