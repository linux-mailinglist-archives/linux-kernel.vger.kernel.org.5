Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA77E3139
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjKFXUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjKFXTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5630E9;
        Mon,  6 Nov 2023 15:16:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4365C433C8;
        Mon,  6 Nov 2023 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312603;
        bh=0arbaNvnIAxlUW81YmPdpGIiJDwasLYkkL9kpZGsC8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ts2Z4Lu+PSkLgcRLcZFqoBNk/DOMyf4olS2F9P4VzT+ltKwePuxS7WxF2+bNXYoOh
         vRF0UXKNpa1NXumeI4FMB4Qs7bUKJUL/p48Od9zo0U5an0Ko4EX9oF/7l7gy73UBu7
         HN3/RYOxoDm3goPTW4Mt9YXjDV4blQXNERhQ2CgCnUp91rF6Z5OjL87NS4s8IXykgB
         ASRH+t21ZFSXCMOnvxGnhf0voSGvMi82hO3lZ6hc/bFHF4RoLpfzGIZNw0YzhfcY5l
         C3PCbcdPLc59RRuPSMPfx9F7kZqORqqA9BmmJRTqlYb9qdqM56dYhwB7eAqx6/6NkD
         ehKb+cvrOrjEw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 2/5] clocksource/drivers/timer-imx-gpt: Fix potential memory leak
Date:   Mon,  6 Nov 2023 18:16:33 -0500
Message-ID: <20231106231639.3735753-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231639.3735753-1-sashal@kernel.org>
References: <20231106231639.3735753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
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
index 7b2c70f2f353b..fabff69e52e58 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -454,12 +454,16 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
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
 
@@ -472,11 +476,15 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 
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

