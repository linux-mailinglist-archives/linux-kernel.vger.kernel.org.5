Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47988781885
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHSIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHSIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:53:12 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C30F1DDE;
        Sat, 19 Aug 2023 01:48:35 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <othacehe@gnu.org>)
        id 1qXHd2-0001kJ-8j; Sat, 19 Aug 2023 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
        references; bh=C+Jcu5bdm+iP02HYx68cgDC8fIORgJcECFprqrGAkIs=; b=PFRUC1cL0PO/hF
        M+H0QR58LezzbxnW346SGQY2DIwQ19k6nQAkzOjKrAPqEF52mY7Lz6yHcMoDQMsmy48QdGDGXxww9
        arRXJKc5csOOJ3JlVMF3wNY/Xz6G3NULXMUp+mxeIHzcSf4tSZ/+j7JH44lfDmvwblxIvrs8IYD3y
        LKzbAAz2glvza134oJrX0wKaJESoN6tR7kSKtZtpPTkZcB4keAL+QPhJ6YvgB6tCiCf19gmCHcm/l
        ctaf7HH9SuiOV5aU73n7/taRvQZ9bbalbkBmUZaU/s1ylTHtMjMkjJzS4yUcPZWng+qmjJn+cwjgE
        jmrGecyuP4CU/ANhD8AQ==;
From:   Mathieu Othacehe <othacehe@gnu.org>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH] watchdog: sama5d4: readout initial state
Date:   Sat, 19 Aug 2023 10:47:26 +0200
Message-ID: <20230819084726.11037-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Readout the AT91_WDT_MR bit at probe so that it becomes possible to get the
pre-userspace handler working.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 drivers/watchdog/sama5d4_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index aeee934ca51b..7d31bb6f6204 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -255,6 +255,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	struct sama5d4_wdt *wdt;
 	void __iomem *regs;
 	u32 irq = 0;
+	u32 reg;
 	int ret;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
@@ -305,6 +306,12 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(wdd, wdt_timeout, dev);
 
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	if (!(reg & AT91_WDT_WDDIS)) {
+		wdt->mr &= ~AT91_WDT_WDDIS;
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	}
+
 	ret = sama5d4_wdt_init(wdt);
 	if (ret)
 		return ret;
-- 
2.41.0

