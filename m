Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6A78DFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbjH3TWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbjH3Rfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:35:38 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB991A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:35:35 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWfG0m3Zzkh;
        Wed, 30 Aug 2023 19:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416934; bh=HM9xVlM37R0H8C6zhS+PEHaYWeUHbqjwBKdmiA2Kahc=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=PAE0P/P65FT0kw/23b6ehZwHwq7z5Num3MBY060IIsPdX+QyQlAECOrv+1Tqk3Nw3
         d865p7Ec/t38auBAVje+bM7yl32i2CyCilg4GY//mdGec8zSRLT72epGGDFIIHYjdy
         8Qb5LPjQQSvzOswKNa+E7iFo+/PzksSUwvffmnn32qyqP5PSXj6OiLLxpAutM3hT4Z
         gykvdQUNBRijrHWp3n/Z5S7wCbfGABaDmEeft8tQ4KufSFXXOmwEAbfqQ0V7gAe1PV
         6K1nt7pEk1QZGh60lF+O1RI7WVZJbRp7Cmm1NBazGlzHECLuOTF/zaaqFpwqubAg2M
         tBcWq6YJxgLvw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:35:33 +0200
Message-Id: <711d447ac7160ca275975f6aba51e19bfcb4f742.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 7/7] regulator/core: regulator_lock_two: remove duplicate
 locking code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make regulator_lock_two() shorter by observing that we have only two
locks and when swapped earlier the retry code becomes identical to the
normal (optimistic) path.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 30 +++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3f9621621da9..36cec3fbcdea 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -216,37 +216,29 @@ static int regulator_lock_two(struct regulator_dev *rdev1,
 			      struct regulator_dev *rdev2,
 			      struct ww_acquire_ctx *ww_ctx)
 {
-	struct regulator_dev *held, *contended;
 	int ret;
 
 	ww_acquire_init(ww_ctx, &regulator_ww_class);
 
-	/* Try to just grab both of them */
 	ret = regulator_lock_nested(rdev1, ww_ctx);
 	if (WARN_ON(ret))
 		goto exit;
-	ret = regulator_lock_nested(rdev2, ww_ctx);
-	if (!ret)
-		goto exit;
-	if (WARN_ON(ret != -EDEADLOCK)) {
-		regulator_unlock(rdev1);
-		goto exit;
-	}
 
-	held = rdev1;
-	contended = rdev2;
 	while (true) {
-		regulator_unlock(held);
+		ret = regulator_lock_nested(rdev2, ww_ctx);
+		if (!ret)
+			break;
 
-		regulator_lock_contended(contended, ww_ctx);
-		swap(held, contended);
-		ret = regulator_lock_nested(contended, ww_ctx);
+		regulator_unlock(rdev1);
 
-		if (ret != -EDEADLOCK) {
-			if (WARN_ON(ret))
-				regulator_unlock(held);
+		if (WARN_ON(ret != -EDEADLOCK))
 			break;
-		}
+
+		/* Swap the locking order and retry. */
+
+		swap(rdev1, rdev2);
+
+		regulator_lock_contended(rdev1, ww_ctx);
 	}
 
 exit:
-- 
2.39.2

