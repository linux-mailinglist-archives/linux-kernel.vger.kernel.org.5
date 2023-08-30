Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900A278DB77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjH3SjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbjH3Rfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:35:36 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4C193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:35:33 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWfC4LTSzTw;
        Wed, 30 Aug 2023 19:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416931; bh=hSMQQTeSudZxbDfDsrdeeJ4mA/Mwq7wjXr2m2bQXnP8=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=O6r6i1v+gf7ZVgP9xLvTqNPD7Wia6WA7XFHqAgNdFq+Z1JsmxbUhtMPF1vW+2q9nc
         3X8f5nrCq9PdEwADcLxP9kWVFpIcWylHLaQjgfzdug9lh2caDSF3MRuMDUIbK3z3kC
         dc15kKk1X/01vauF78ELCaixZFfYrsw14i9fJTGYgT5QEZVU77w0mZIiOZWLFE0Tg/
         0qwPjEzS2GDsrNA1FTwJoxI4ZbkGj/1Xs8e4RUqSRjrDNWekA5o96Vr0RFx+eg0HQl
         nVH0rSQ9qvG+/3/qBqE0gxmt3UHpzXc8KkaRRe1ZpmlUlyW7jq8r7EuqieYB//iSF6
         VVoXRLaIril+A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:35:31 +0200
Message-Id: <cbd7dda4bb20989ccb3facb62243ceaf1f2855a0.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/7] regulator/core: regulator_lock_nested: skip extra lock
 for -EDEADLK
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

When ww_mutex_lock() returns -EDEADLK the nesting mutex-protected
section becomes a no-op. Return early and avoid the extra lock.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 215b721e5cd4..921c7039baa3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -145,18 +145,17 @@ static inline int regulator_lock_nested(struct regulator_dev *rdev,
 
 	mutex_lock(&regulator_nesting_mutex);
 
-	if (!ww_mutex_trylock(&rdev->mutex, ww_ctx)) {
-		if (rdev->mutex_owner != current) {
-			mutex_unlock(&regulator_nesting_mutex);
-			ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
-			mutex_lock(&regulator_nesting_mutex);
-		}
+	if (!ww_mutex_trylock(&rdev->mutex, ww_ctx) &&
+	    rdev->mutex_owner != current) {
+		mutex_unlock(&regulator_nesting_mutex);
+		ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
+		if (ret == -EDEADLK)
+			return ret;
+		mutex_lock(&regulator_nesting_mutex);
 	}
 
-	if (ret != -EDEADLK) {
-		rdev->ref_cnt++;
-		rdev->mutex_owner = current;
-	}
+	rdev->ref_cnt++;
+	rdev->mutex_owner = current;
 
 	mutex_unlock(&regulator_nesting_mutex);
 
-- 
2.39.2

