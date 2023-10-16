Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2677CA004
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjJPG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPG6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:58:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649DB97;
        Sun, 15 Oct 2023 23:58:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03FAFC433C8;
        Mon, 16 Oct 2023 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697439490;
        bh=FHQfrAU/xjJpgKY08sCcFZAYGfGwFAR9AtGWyzajUJ8=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=DLLcfRYm2nzzK/Cwn+yscomAdyf1xnIIAKpRPA+rKP113kNuZ0A/qTkrX0k+GnWDz
         YaOHdFmqZNmYARTRlF+DlcejcAYSTtVBR8nyWsB8d7pfm+aXBAvI057LMya1tznLdD
         Fy2VRh6/7sHE1bUeqM5rgDBHwt68ywgMzypj83ywc52+I+xZNgIriHvn3C/GAlgOpR
         Z/bA2Rww9sd2xxN1bHSZc8swL47trqGRqbwazmpiRXH0FcU8wxWNIoO18Pif0Fz6oU
         lLX5DgHSbtmAyvqTUWmEahHQ2R9865gL+ZZx6Ud21j1V5voUWJ5VrVeWIY1bXI7zz1
         ViljCIEqLuxfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E2588CDB465;
        Mon, 16 Oct 2023 06:58:09 +0000 (UTC)
From:   Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date:   Mon, 16 Oct 2023 08:58:01 +0200
Subject: [PATCH v2] watchdog: apple: Deactivate on suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-apple-watchdog-suspend-v2-1-7ffff8042dbc@jannau.net>
X-B4-Tracking: v=1; b=H4sIAPneLGUC/4WNQQ6DIBREr2L+ur8BWShd9R6NC4SP0DRIALWN8
 e6lXqCZ1Ztk3uyQKXnKcGt2SLT67OdQob00oJ0KE6E3laFlrWBSMFQxvgg3VbQz84R5yZGCwc5
 2ohecC2ZHqOOYyPr3KX4MlZ3PZU6f82flv/avcuVYI2Wv2UjSmu7+VCGo5RqowHAcxxdCaA19v
 QAAAA==
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=j@jannau.net;
 h=from:subject:message-id; bh=qR9R65p5QA5TUKQf3OVfeiREsktHYZDElKSYt9mdCaI=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhlSd+wx/NBy7ua6cvxDYVJ11IvDv3N0fMlL+PeG4sD5p7
 wrx1fNlO0pZGMQ4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEyk7jAjw+9qGZ/YyzM3vGxZ
 ph2y4NYj3sZ/wvf+q2w6eS+uyCMg6Rcjw2KGzTM/HKwSb0xVqO013fhUyrBh44fI2hccKvsZhPt
 ZeAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: <j@jannau.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
- use DEFINE_SIMPLE_DEV_PM_OPS
- Link to v1: https://lore.kernel.org/r/20230930-apple-watchdog-suspend-v1-1-1998c0be9fd7@jannau.net
---
 drivers/watchdog/apple_wdt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
index eddeb0fede89..d4f739932f0b 100644
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
 
+static int apple_wdt_resume(struct device *dev)
+{
+	struct apple_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
+		apple_wdt_start(&wdt->wdd);
+
+	return 0;
+}
+
+static int apple_wdt_suspend(struct device *dev)
+{
+	struct apple_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
+		apple_wdt_stop(&wdt->wdd);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
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

