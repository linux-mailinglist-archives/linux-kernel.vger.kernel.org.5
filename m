Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF2178A28E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjH0WRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjH0WRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:17:02 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EB128;
        Sun, 27 Aug 2023 15:16:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C05FE1C0004;
        Sun, 27 Aug 2023 22:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693174618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GONRYTr9Cqo/Rszgxee03LICOiSqOFkzcMKhwAqHUr0=;
        b=QCDXqVPr7aRXJMthNS6xde+4JhARkW4SnrprCBQdhgV/O2SLu5tx7I/KZ3znG77nS+/JZV
        GShFIV4y/OwrBofs4kX5l1MX5gvGc9AgGx8rxBnRD0yycyGqrdJyJp7CQr1kaLoc+wvtsj
        Ic8nabuGCGVQLnK3njoW6TC0orbdlIqkZPRbVvgK/eFWtRXepIvR0U7/zGyjUw0EYVP/Pp
        BOsMsgSVs/RRAmjVVvsP3INBOkuXfKhBdJ+2tArFAJm5yEtymO6WhyzJHBT3wH9DhnFeDh
        oHLPXXeCNhcMOYbBcu/9jMxnsH1MEUmlUgQjLhK2oT0Q/UIP9bh0LGgovO+XEA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     patches@opensource.cirrus.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] rtc: wm8350: remove unnecessary messages
Date:   Mon, 28 Aug 2023 00:16:42 +0200
Message-ID: <20230827221643.544259-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
References: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The RTC core already prints a message when the RTC is registered and when
registering fails, it is not necessary to have more in the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-wm8350.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-wm8350.c b/drivers/rtc/rtc-wm8350.c
index 947f8071803f..3c773cff2b39 100644
--- a/drivers/rtc/rtc-wm8350.c
+++ b/drivers/rtc/rtc-wm8350.c
@@ -386,8 +386,6 @@ static int wm8350_rtc_probe(struct platform_device *pdev)
 	/* enable the RTC if it's not already enabled */
 	power5 = wm8350_reg_read(wm8350, WM8350_POWER_MGMT_5);
 	if (!(power5 &  WM8350_RTC_TICK_ENA)) {
-		dev_info(wm8350->dev, "Starting RTC\n");
-
 		wm8350_reg_unlock(wm8350);
 
 		ret = wm8350_set_bits(wm8350, WM8350_POWER_MGMT_5,
@@ -426,11 +424,8 @@ static int wm8350_rtc_probe(struct platform_device *pdev)
 
 	wm_rtc->rtc = devm_rtc_device_register(&pdev->dev, "wm8350",
 					&wm8350_rtc_ops, THIS_MODULE);
-	if (IS_ERR(wm_rtc->rtc)) {
-		ret = PTR_ERR(wm_rtc->rtc);
-		dev_err(&pdev->dev, "failed to register RTC: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(wm_rtc->rtc))
+		return PTR_ERR(wm_rtc->rtc);
 
 	ret = wm8350_register_irq(wm8350, WM8350_IRQ_RTC_SEC,
 			    wm8350_rtc_update_handler, 0,
-- 
2.41.0

