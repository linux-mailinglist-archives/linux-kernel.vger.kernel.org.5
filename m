Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176D578E55B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHaEO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbjHaEO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:14:27 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4ADCEA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:14:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vqwo882_1693455255;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vqwo882_1693455255)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 12:14:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jernej.skrabec@gmail.com, samuel@sholland.org, wens@csie.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] clocksource/drivers/sun5i: Remove surplus dev_err() when using platform_get_irq()
Date:   Thu, 31 Aug 2023 12:14:14 +0800
Message-Id: <20230831041414.66434-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

./drivers/clocksource/timer-sun5i.c:260:2-9: line 260 is redundant because platform_get_irq() already prints an error

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/clocksource/timer-sun5i.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 69fee3540d37..0d229a9058da 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -256,10 +256,8 @@ static int sun5i_timer_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Can't get IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
-- 
2.20.1.7.g153144c

