Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D367A9105
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjIUCoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIUCoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:44:21 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49FE102;
        Wed, 20 Sep 2023 19:44:13 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38L2hQsB025108;
        Thu, 21 Sep 2023 10:43:26 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rrfkt1GZQz2SCXQ3;
        Thu, 21 Sep 2023 10:40:06 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.70) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 21 Sep
 2023 10:43:24 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] leds: sc27xx: Add a missing mutex_destory()
Date:   Thu, 21 Sep 2023 10:43:14 +0800
Message-ID: <20230921024314.615370-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.70]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 38L2hQsB025108
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sc27xx_led_probe() there's one error branch missing mutex_destory()
after mutex_init(), it seems that we should add it since other branches
which follow it called mutex_destoy() before return failure.

Fixes: e081c49e30ec ("leds: Add Spreadtrum SC27xx breathing light controller driver")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/leds/leds-sc27xx-bltc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index e199ea15e406..122094bbf444 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -300,6 +300,7 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 	priv->base = base;
 	priv->regmap = dev_get_regmap(dev->parent, NULL);
 	if (!priv->regmap) {
+		mutex_destroy(&priv->lock);
 		err = -ENODEV;
 		dev_err(dev, "failed to get regmap: %d\n", err);
 		return err;
-- 
2.41.0

