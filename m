Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA178E283
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbjH3Wru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbjH3Wrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:47:49 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEACCF1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:47:41 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd341VwFzgk;
        Wed, 30 Aug 2023 23:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431536; bh=3j5YwA8sQZLPwKcy65ogiVFJLRLsV0GO/Ut6EzwlnMQ=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=BKvxto3e/ZjAZxKx4FTEFDuoMlZOIAIUrlU9OI0wCEyCgbcE9chjRj2nveFserEAo
         rm3+XV8qEhLdOTCgx4ScIXHWLL9xLoNLti0wkEni52XWYyQ8RmHk0NVoQ48n/rWfz1
         +AbnSxOnHiYJmFzpA9UoyW1nV+J+6JetCoblaboPTHtGzAparZBv2cPHCv55+VknNy
         /P4No4b4/C7a4izgDQvUJ39+n1X+Jd3NSE42h5kbq4moLjqpMZ6NSJXeAYSmo5u6IM
         Omo2lGAQA9YgnHqep1ZkNwxnk+2rNcYtxpnofc2bfANfSMn5Sk5gdOFsfsnXILeYCK
         +WilOrOpnSTsg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:56 +0200
Message-Id: <c2551b3da420ab9b69f80ec7a0d646ff69bd0a03.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/9] regulator/core: regulator_ena_gpio_ctrl: pull in ena_gpio
 state handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deduplicate `ena_gpio_state` handling by pulling it into
regulator_ena_gpio_ctrl().

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 63d16fe59e84..c8d1b12ee43b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2601,6 +2601,9 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	if (!pin)
 		return -EINVAL;
 
+	if (rdev->ena_gpio_state == enable)
+		return 0;
+
 	if (enable) {
 		/* Enable GPIO at initial use */
 		if (pin->enable_count == 0)
@@ -2608,18 +2611,14 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 
 		pin->enable_count++;
 	} else {
-		if (pin->enable_count > 1) {
-			pin->enable_count--;
-			return 0;
-		}
-
 		/* Disable GPIO if not used */
-		if (pin->enable_count <= 1) {
+		if (pin->enable_count-- <= 1) {
 			gpiod_set_value_cansleep(pin->gpiod, 0);
 			pin->enable_count = 0;
 		}
 	}
 
+	rdev->ena_gpio_state = enable;
 	return 0;
 }
 
@@ -2720,12 +2719,9 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	}
 
 	if (rdev->ena_pin) {
-		if (!rdev->ena_gpio_state) {
-			ret = regulator_ena_gpio_ctrl(rdev, true);
-			if (ret < 0)
-				return ret;
-			rdev->ena_gpio_state = 1;
-		}
+		ret = regulator_ena_gpio_ctrl(rdev, true);
+		if (ret < 0)
+			return ret;
 	} else if (rdev->desc->ops->enable) {
 		ret = rdev->desc->ops->enable(rdev);
 		if (ret < 0)
@@ -2938,13 +2934,9 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 	trace_regulator_disable(rdev_get_name(rdev));
 
 	if (rdev->ena_pin) {
-		if (rdev->ena_gpio_state) {
-			ret = regulator_ena_gpio_ctrl(rdev, false);
-			if (ret < 0)
-				return ret;
-			rdev->ena_gpio_state = 0;
-		}
-
+		ret = regulator_ena_gpio_ctrl(rdev, false);
+		if (ret < 0)
+			return ret;
 	} else if (rdev->desc->ops->disable) {
 		ret = rdev->desc->ops->disable(rdev);
 		if (ret != 0)
-- 
2.39.2

