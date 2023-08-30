Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE01878DFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjH3T3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbjH3Rfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:35:37 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C0198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:35:34 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWfD3b6wzbv;
        Wed, 30 Aug 2023 19:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416932; bh=yfYWTZy4+QsJQZykgw/CudOAdR0bu9dW9lR7LaZnKiU=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=O6tvKnQHLzY4qcOxpg/QGuQ2ZJgasEn9jm2SSOWLR7p+w0oBFGJeVVvARTa/Efq5v
         YjU9Del7ANkyMGhmpBrKB5ChoVY3pR7gETGOFwP+uqDP0lJQE/Hwh9r4zfXqPnhQ7B
         CdmGXoGkOIHdk36acJW6hxAU9UBJ3TJ1OO0P1u7VwHcq3+gxpVG2KPSXwg6aGz3Xd1
         1gX8Nh9zmZQOddCBKJRjVP3E+zLyQ9feMsR6WXn+5AhWMgWCa+DAhxxxlG5AXzZ6aX
         djtuJNjBUxV6Xb8FbE7hEIHm1HE47UNj2BViKjhqCJcZnVe2n+Cn0PVul6UBt/7QFH
         ltE6hFO8wZJNw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:35:32 +0200
Message-Id: <3708ae89092b13b1f2598b6a3c02987d6d920e4d.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/7] regulator/core: regulator_resolve_supply: remove gotos
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 14a71d509ac8 ("Fix lockdep warning resolving supplies") the `out`
label is just `return ret;`. Inline it for easier reading.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f18e7cb88a0d..e89c12d27a9d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2039,7 +2039,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	struct regulator_dev *r;
 	struct device *dev = rdev->dev.parent;
 	struct ww_acquire_ctx ww_ctx;
-	int ret = 0;
+	int ret;
 
 	/* No supply to resolve? */
 	if (!rdev->supply_name)
@@ -2055,7 +2055,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 		/* Did the lookup explicitly defer for us? */
 		if (ret == -EPROBE_DEFER)
-			goto out;
+			return ret;
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
@@ -2063,18 +2063,15 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
 				rdev->supply_name, rdev->desc->name);
-			ret = -EPROBE_DEFER;
-			goto out;
+			return -EPROBE_DEFER;
 		}
 	}
 
 	if (r == rdev) {
 		dev_err(dev, "Supply for %s (%s) resolved to itself\n",
 			rdev->desc->name, rdev->supply_name);
-		if (!have_full_constraints()) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!have_full_constraints())
+			return -EINVAL;
 		r = dummy_regulator_rdev;
 		get_device(&r->dev);
 	}
@@ -2088,8 +2085,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (r->dev.parent && r->dev.parent != rdev->dev.parent) {
 		if (!device_is_bound(r->dev.parent)) {
 			put_device(&r->dev);
-			ret = -EPROBE_DEFER;
-			goto out;
+			return -EPROBE_DEFER;
 		}
 	}
 
@@ -2097,7 +2093,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	ret = regulator_resolve_supply(r);
 	if (ret < 0) {
 		put_device(&r->dev);
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -2111,14 +2107,14 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (rdev->supply) {
 		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
-		goto out;
+		return 0;
 	}
 
 	ret = set_supply(rdev, r);
 	if (ret < 0) {
 		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
-		goto out;
+		return ret;
 	}
 
 	regulator_unlock_two(rdev, r, &ww_ctx);
@@ -2133,12 +2129,11 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		if (ret < 0) {
 			_regulator_put(rdev->supply);
 			rdev->supply = NULL;
-			goto out;
+			return ret;
 		}
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 /* Internal regulator request function */
-- 
2.39.2

