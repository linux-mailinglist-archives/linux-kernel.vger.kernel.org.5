Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCC781B85
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjHTAKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjHTAKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:22 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EBA2C13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 13:15:44 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSqk73tQQzDP;
        Sat, 19 Aug 2023 22:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692476143; bh=YtPxaSJGaYviQtheKr8WW3ztuiAMjl4/E99vF4LFKWg=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=cyBrcl6tONyHMHe4XVqxrsMla0/aQQ7tc1uDzhc8/EPOstcGM0VJaCOvSRnaV1Ktu
         3TmHfHXP6HFh+p39fbRtP1Baptw/KvHlwujqcYgG2132t494+TCfErLfAPdR9DPaH+
         2MadHHAFouLtqyJmVg7saOMpmob9IUHKOo/6n1ilNTpN7Ysk3r/2dO7PEeBgq5C7tO
         dT/0M/4GouIryBXgWhf1OXVwFC0l6tKBZo8JEu4Z6lKAQ+JGg7MeYe1HHx+HAeDU1f
         aP7+ShOw+iksWiJR4pwHLl2DB69sSxYjifAmaanEukiZkkVdNdP2Rq5uWHaEFccvLg
         BEskEBNT6m9Ig==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 19 Aug 2023 22:15:43 +0200
Message-Id: <89a905854995cf662a122792d8d0c781e39ea7da.1692475736.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <0e37d1f09718a6ab9204b367ff528ab02df25ac7.1692475736.git.mirq-linux@rere.qmqm.pl>
References: <0e37d1f09718a6ab9204b367ff528ab02df25ac7.1692475736.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] regulator: core: skip nesting lock for -EDEADLK
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ww_mutex_lock() returns -EDEADLK the nesting mutex-protected
section becomes a no-op. Return early and avoid the extra lock.

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

