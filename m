Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E37B3F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjI3ITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjI3ITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:19:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A09195;
        Sat, 30 Sep 2023 01:19:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE15DC433C8;
        Sat, 30 Sep 2023 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696061971;
        bh=M7ntc2U7ytqmb0p5ElJpWPn5HTPfSg5aIA/l+S9kpQ8=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=SEDL+KoMw9E7kNJD/VeOA3pa/RrO8yjgMVLtc4FcwU/P8j7SxJmH5O8LgW8ovA841
         trFmNvwKI3YoEyjjUJyNq0HFbw6bgLuU3dSE4KBoyd/7lpS4eMdjQLPgTCYb76pkw8
         mQDZjp0sbwAL/W6v4cKujSuZUpDTyHmhWj1jyeFDW8mdhPHRPhbKQopOZ+qx3XmeQe
         x0akqlxGRqF4DY7hxxM7wa5R6DQFZjorw+Y6yV/H2gZ+/r0+MyybDAFI0jTQ6dI3ZW
         oyt3A4yFEbcnbXbI6zIJaUeT1vY6MVJyVi/1rOmiqvBFR3DSQnlGwym7LM7Y+cGTao
         ACE2onYm4fmEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id CF554E77362;
        Sat, 30 Sep 2023 08:19:30 +0000 (UTC)
From:   Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date:   Sat, 30 Sep 2023 10:19:26 +0200
Subject: [PATCH] watchdog: apple: Deactivate on suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230930-apple-watchdog-suspend-v1-1-1998c0be9fd7@jannau.net>
X-B4-Tracking: v=1; b=H4sIAA3aF2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS2MD3cSCgpxU3fLEkuSMlPx03eLS4oLUvBRd8zRzYwtjQ0Njg7QkJaD
 mgqLUtMwKsMHRsbW1AAVOok1oAAAA
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=j@jannau.net;
 h=from:subject:message-id; bh=+tQiILihRq5o4N62Yd4BUwts5HYkI5tfzlOjXU3MCSQ=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhlTxW4KTvB7z2UddmJ6rPD/L5aGfgFxyUCR/5qFClbwo+
 YLZpqs7SlkYxDgYZMUUWZK0X3YwrK5RjKl9EAYzh5UJZAgDF6cATOSVPMP/iL75jLdTnDPNFrpY
 iG5aWeomdapyIjufzK5Fr/ZXdZgFMTK89XdY5lUubBX3a7fkvQOJl6cKsiydf2zdvNr8X7cCY1o
 ZAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: <j@jannau.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janne Grunau <j@jannau.net>

The watchdog remains active after putting the system into suspend. Add
PM callbacks to deactivate the watchdog on suspend an re-activate it on
resume.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/watchdog/apple_wdt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
index eddeb0fede89..2167e0ba705e 100644
--- a/drivers/watchdog/apple_wdt.c
+++ b/drivers/watchdog/apple_wdt.c
@@ -173,6 +173,8 @@ static int apple_wdt_probe(struct platform_device *pdev)
 	if (!wdt->clk_rate)
 		return -EINVAL;
 
+	platform_set_drvdata(pdev, wdt);
+
 	wdt->wdd.ops = &apple_wdt_ops;
 	wdt->wdd.info = &apple_wdt_info;
 	wdt->wdd.max_timeout = U32_MAX / wdt->clk_rate;
@@ -190,6 +192,28 @@ static int apple_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &wdt->wdd);
 }
 
+static int __maybe_unused apple_wdt_resume(struct device *dev)
+{
+	struct apple_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
+		apple_wdt_start(&wdt->wdd);
+
+	return 0;
+}
+
+static int __maybe_unused apple_wdt_suspend(struct device *dev)
+{
+	struct apple_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
+		apple_wdt_stop(&wdt->wdd);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
+
 static const struct of_device_id apple_wdt_of_match[] = {
 	{ .compatible = "apple,wdt" },
 	{},
@@ -200,6 +224,7 @@ static struct platform_driver apple_wdt_driver = {
 	.driver = {
 		.name = "apple-watchdog",
 		.of_match_table = apple_wdt_of_match,
+		.pm = pm_sleep_ptr(&apple_wdt_pm_ops),
 	},
 	.probe = apple_wdt_probe,
 };

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230930-apple-watchdog-suspend-7f73831130fb

Best regards,
-- 
Janne Grunau <j@jannau.net>

