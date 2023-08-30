Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6778D9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjH3Sen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343955AbjH3Rfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:35:37 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A0193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:35:35 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWfF3GB8zjJ;
        Wed, 30 Aug 2023 19:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416933; bh=dWJXSE23EEsNF2ABidxY7QtS4t5FWf+OeZGytVGqGR8=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=l9cjpoKiexV48zwpCG2Zkfb3Ds0UQvudFGggvDKy4nEvJnJMQBvenJi1vwuBxS96N
         D5461n2lcq8l1JOa/IgGertHluRUaVh+mGso9Ievi3EtvlmMhDZUjeChOY0GVM4Dmr
         dWqAsta0V4sMW0uMJ1nnCnS7Puj9T1yUlXDVGeLdFuAp0sz8nOb2xakrra6toLK6hz
         POEtdbL8/Yxby/kDtDdSGg2anisNlvqDEKuoUu6sfg1ci5VEo/LSssrsMF/1SprnhS
         AJbxVGrvqK81qANtOK9bP/CvEE6XwUJ7ydC2IYslNIl1cZyG6BCXn0LtzJW5JDAk0P
         pHeuKbujphmfA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:35:33 +0200
Message-Id: <3240d792149f32fb4164ad7042091daf9f59f9a3.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 6/7] regulator/core: regulator_lock_two: propagate error up
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

Fix up error paths from regulator_lock_two(): although it should not
fail, returning with half-locked state after issuing a WARN() asks
for even more trouble.

Fixes: cba6cfdc7c3f ("regulator: core: Avoid lockdep reports when resolving supplies")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2:
  - updated kerneldoc
  - call ww_acquire_done() on all exits
---
 drivers/regulator/core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7201927c5d5b..3f9621621da9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -209,11 +209,12 @@ static void regulator_unlock(struct regulator_dev *rdev)
  * @rdev2:		second regulator
  * @ww_ctx:		w/w mutex acquire context
  *
- * Locks both rdevs using the regulator_ww_class.
+ * Locks both rdevs using the regulator_ww_class. Returns error if an
+ * unexpected error has been detected during a locking sequence.
  */
-static void regulator_lock_two(struct regulator_dev *rdev1,
-			       struct regulator_dev *rdev2,
-			       struct ww_acquire_ctx *ww_ctx)
+static int regulator_lock_two(struct regulator_dev *rdev1,
+			      struct regulator_dev *rdev2,
+			      struct ww_acquire_ctx *ww_ctx)
 {
 	struct regulator_dev *held, *contended;
 	int ret;
@@ -222,10 +223,13 @@ static void regulator_lock_two(struct regulator_dev *rdev1,
 
 	/* Try to just grab both of them */
 	ret = regulator_lock_nested(rdev1, ww_ctx);
-	WARN_ON(ret);
+	if (WARN_ON(ret))
+		goto exit;
 	ret = regulator_lock_nested(rdev2, ww_ctx);
-	if (ret != -EDEADLOCK) {
-		WARN_ON(ret);
+	if (!ret)
+		goto exit;
+	if (WARN_ON(ret != -EDEADLOCK)) {
+		regulator_unlock(rdev1);
 		goto exit;
 	}
 
@@ -239,13 +243,15 @@ static void regulator_lock_two(struct regulator_dev *rdev1,
 		ret = regulator_lock_nested(contended, ww_ctx);
 
 		if (ret != -EDEADLOCK) {
-			WARN_ON(ret);
+			if (WARN_ON(ret))
+				regulator_unlock(held);
 			break;
 		}
 	}
 
 exit:
 	ww_acquire_done(ww_ctx);
+	return ret;
 }
 
 /**
@@ -2113,7 +2119,11 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	 * between rdev->supply null check and setting rdev->supply in
 	 * set_supply() from concurrent tasks.
 	 */
-	regulator_lock_two(rdev, r, &ww_ctx);
+	ret = regulator_lock_two(rdev, r, &ww_ctx);
+	if (ret < 0) {
+		put_device(&r->dev);
+		return ret;
+	}
 
 	/* Supply just resolved by a concurrent task? */
 	if (rdev->supply) {
-- 
2.39.2

