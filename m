Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C23781BEF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHTBpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 21:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHTBpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 21:45:24 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DAD36EF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 15:46:14 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSv3l1vHczTw;
        Sun, 20 Aug 2023 00:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692485171; bh=VJNi4PYf+iiPV3elFHZZCExCQP1Fvm2zJodP+scZLEU=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=RU7ZWAZ1Y/BsnIHZDX2/YiAZyTQQ8HI88v/qdccDWK+wTRzzyDSxA4DOS5KXbK6IJ
         yM1NrNKgqOpqvctKdxJJJJKTioqtWlhw4iDD1aoIFRjyDeSpqI1T//GrwBkLITvwn0
         e6Q4TRy4S0AhXBynJ9dqJ6HxE58Qw0nz21y0bR8Lho/g26/R9mwrs/67AfSyAfcFRc
         4cCMgmuiu1HwAOp9LkDRzvEeFP9RDcvPJo4sP18yu+kGxYoy6x9waR0XRjHVqkr8zJ
         bM+kxrYCHYfYOLNEJyJAg6e54W6pWXKUc83yOAX7FChaXmxHmdvd6Mfg7UQSatrr+X
         d7RSt3FLv6oIg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sun, 20 Aug 2023 00:46:11 +0200
Message-Id: <682e260d8cb75c34f79ff7fcc3c4bb8586140cc4.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 6/6] regulator: core: simplify lock_two()
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

Make regulator_lock_two() shorter by observing that we have only two
locks and when swapped earlier the retry code becomes identical to the
normal (optimistic) path.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8c2277cea36..9736507b62ff 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -201,37 +201,29 @@ static int regulator_lock_two(struct regulator_dev *rdev1,
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
-		return 0;
-	if (WARN_ON(ret != -EDEADLOCK)) {
-		regulator_unlock(rdev1);
-		goto exit;
-	}
 
-	held = rdev1;
-	contended = rdev2;
 	while (true) {
-		regulator_unlock(held);
-
-		ww_mutex_lock_slow(&contended->mutex, ww_ctx);
-		contended->ref_cnt++;
-		contended->mutex_owner = current;
-		swap(held, contended);
-		ret = regulator_lock_nested(contended, ww_ctx);
+		ret = regulator_lock_nested(rdev2, ww_ctx);
 		if (!ret)
 			return 0;
+
+		regulator_unlock(rdev1);
+
 		if (WARN_ON(ret != -EDEADLOCK))
 			break;
+
+		swap(rdev1, rdev2);
+
+		ww_mutex_lock_slow(&rdev1->mutex, ww_ctx);
+		rdev1->ref_cnt++;
+		rdev1->mutex_owner = current;
 	}
 
 exit:
-- 
2.39.2

