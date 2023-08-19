Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F3781BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjHTA1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjHTA0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:26:45 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10076D36EE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 15:46:14 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSv3k6ZV8zSq;
        Sun, 20 Aug 2023 00:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692485171; bh=vEG9KhS3zmUQyp3NQVv+xM+Ir0WQfV5ZhZ+DMgQzlEA=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=EM8Q2qh6Hp30VRCk4Po7ZQhtezB5k/zj8sMNsDUCqja59Wg9Vl5nmWD6Kv8cxe1q5
         w9vgnpjfxfkvMDxn6GFX0XTYUDushkkm84dE5O8RcgapOjVlZs01sHjW+Pmsdwdj9G
         ECZH4/w/W1gb/LaN3BTwhIne5N76K23xm0hr34D8vx5HnVK2d100n+6Zy3ai3MTr2g
         uAge2reQNMyr636kaz1UgtatPrnMIXHs6n9X8/EYXpbZlKqnINf5/vlK8WrZzDISOM
         GeLNRn+e6MBwR4O9+Dgl8AkHbgyjtdSBwerR4fW3oAb0GWmcEj3DHPRqtLAxTE5tPd
         vvCBiuoTeswiA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sun, 20 Aug 2023 00:46:10 +0200
Message-Id: <b6fa0cfae0072c2fbc0591d619f328324bfbe1ad.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/6] regulator: core: propagate error out ouf
 regulator_lock_two()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/regulator/core.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index de434d550937..d8c2277cea36 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -197,9 +197,9 @@ static void regulator_unlock(struct regulator_dev *rdev)
  *
  * Locks both rdevs using the regulator_ww_class.
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
@@ -208,10 +208,13 @@ static void regulator_lock_two(struct regulator_dev *rdev1,
 
 	/* Try to just grab both of them */
 	ret = regulator_lock_nested(rdev1, ww_ctx);
-	WARN_ON(ret);
+	if (WARN_ON(ret))
+		goto exit;
 	ret = regulator_lock_nested(rdev2, ww_ctx);
-	if (ret != -EDEADLOCK) {
-		WARN_ON(ret);
+	if (!ret)
+		return 0;
+	if (WARN_ON(ret != -EDEADLOCK)) {
+		regulator_unlock(rdev1);
 		goto exit;
 	}
 
@@ -225,15 +228,15 @@ static void regulator_lock_two(struct regulator_dev *rdev1,
 		contended->mutex_owner = current;
 		swap(held, contended);
 		ret = regulator_lock_nested(contended, ww_ctx);
-
-		if (ret != -EDEADLOCK) {
-			WARN_ON(ret);
+		if (!ret)
+			return 0;
+		if (WARN_ON(ret != -EDEADLOCK))
 			break;
-		}
 	}
 
 exit:
 	ww_acquire_done(ww_ctx);
+	return ret;
 }
 
 /**
@@ -2101,7 +2104,11 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
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

