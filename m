Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65B6781C04
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjHTCdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHTCdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:33:31 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1DCD36ED
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 15:46:12 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSv3k2fFyzK2;
        Sun, 20 Aug 2023 00:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692485170; bh=DzbAdMU1wYIUdh1RzwXFx3KnrimKqCQ/g0WN0DovXFY=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=L9cAYUBDSJfCLdNseZgTZq0aRnoHObflbZSEUyJ762UQQKzOTC3UJbMbL48o89k28
         tzB4F7YA78Thz/J1pJh0gSYKRx/vhBkoPYRQIEXe/XGeiwhkEBmBXuWsAhbbWy8bUO
         SrzUDH6kIRM2OeFZmaLTWlvxmMf9/L2i99+J6Ihx5NhPY0e45UcPgWDZtVtZOXJE1m
         j86Qq1Aonff5cz4CiMkqLpp41dQSzmbIE4uiqjdzFJEL3/kQc1E0uM5BZxjw85evXX
         EvFSVS2aEYK1y5U7QpwSx/RTiEgnatVloWc2anTewStx5n3liNzmUCiB6mNunxZQJI
         T6DOfImXjiXmQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sun, 20 Aug 2023 00:46:10 +0200
Message-Id: <a50c32692cfecfa0449ef4943388e9ad9bf4615f.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/6] regulator: core: remove `goto`s from resolve_supply()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Douglas Anderson <dianders@chromium.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 14a71d509ac8 ("Fix lockdep warning resolving supplies") the `out`
label is just `return ret;`. Inline it for easier reading.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 87e54b776a0f..de434d550937 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2053,11 +2053,9 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 	r = regulator_dev_lookup(dev, rdev->supply_name);
 	if (IS_ERR(r)) {
-		ret = PTR_ERR(r);
-
 		/* Did the lookup explicitly defer for us? */
-		if (ret == -EPROBE_DEFER)
-			goto out;
+		if (PTR_ERR(r) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
@@ -2065,18 +2063,15 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
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
@@ -2090,8 +2085,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (r->dev.parent && r->dev.parent != rdev->dev.parent) {
 		if (!device_is_bound(r->dev.parent)) {
 			put_device(&r->dev);
-			ret = -EPROBE_DEFER;
-			goto out;
+			return -EPROBE_DEFER;
 		}
 	}
 
@@ -2099,7 +2093,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	ret = regulator_resolve_supply(r);
 	if (ret < 0) {
 		put_device(&r->dev);
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -2113,14 +2107,14 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
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
@@ -2135,12 +2129,11 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
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

