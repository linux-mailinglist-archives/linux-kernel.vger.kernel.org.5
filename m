Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD878E27A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjH3Wnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbjH3Wnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:43:32 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E009CF4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:43:09 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd324qxyzMG;
        Wed, 30 Aug 2023 23:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431534; bh=hUkNLtMYrhMoAqr2vDdOq6o7qYhnoFkBKelx/varQcs=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=Lz6i3AeoqQZg02m5C9/bBSS1UCL3wLwsUk57j7sZ8UtFeVfUiHI+D+zXcIsjzowv5
         fE+wSEaXQmX6FyFOwX5uhWqm6ZNIf9D+Tl1Lqf5iukQkYRRdA2jkCAIHEACxFnxLzi
         WgRth3bJFj+Hr2aRbcMrGYbLRb6VBidgm1cyfIVzJaJolKIbZjSHYgjvmseyj3ADBH
         X6hLcdC7DDcOK9dMGYiW9A+QpR3tAOW7jE2PX9mnwqlL13l78ySEWl9wixi3ICM9N5
         pQDouJnrgQ3px8LULtXIXZnKwgScLRwUo8bULy/9GyZQjBzihGfsDfJ7KR+0JT9nRC
         0NTwlJQFzBbkg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:54 +0200
Message-Id: <f1068e9a05352c0aa08fb0ff4eca31fffa8c621c.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/9] regulator/core: _regulator_get: simplify error returns
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

Remove unnecessary stores to `regulator`.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 662711063433..d440cd137c38 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2209,15 +2209,13 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	}
 
 	if (rdev->exclusive) {
-		regulator = ERR_PTR(-EPERM);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-EPERM);
 	}
 
 	if (get_type == EXCLUSIVE_GET && rdev->open_count) {
-		regulator = ERR_PTR(-EBUSY);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-EBUSY);
 	}
 
 	mutex_lock(&regulator_list_mutex);
@@ -2225,32 +2223,28 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	mutex_unlock(&regulator_list_mutex);
 
 	if (ret != 0) {
-		regulator = ERR_PTR(-EPROBE_DEFER);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	ret = regulator_resolve_supply(rdev);
 	if (ret < 0) {
-		regulator = ERR_PTR(ret);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(ret);
 	}
 
 	if (!try_module_get(rdev->owner)) {
-		regulator = ERR_PTR(-EPROBE_DEFER);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	regulator_lock(rdev);
 	regulator = create_regulator(rdev, dev, id);
 	regulator_unlock(rdev);
 	if (regulator == NULL) {
-		regulator = ERR_PTR(-ENOMEM);
 		module_put(rdev->owner);
 		put_device(&rdev->dev);
-		return regulator;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	rdev->open_count++;
-- 
2.39.2

