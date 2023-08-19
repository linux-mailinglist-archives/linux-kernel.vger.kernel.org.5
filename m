Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0A781BB6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjHTA3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHTA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:28:36 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F292ECBF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 15:46:11 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSv3k0N0GzFj;
        Sun, 20 Aug 2023 00:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692485170; bh=ivEhS7SaAFigkcVj/vEveFrLC/sIGv8BrZgnWeLjwMc=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=m+S9rGvEjyrtHywrt/fT7Kgn0bMSpoowE3emU/TSFq3mxeKtQO8vxq0whHJtmmiZD
         4jZyg+i0GgrcN9qBvuGzIQSw2M/8IS8JSw4dwWKwW670vZfk3pfPxCzDJKW5U+KmhB
         4Ze/3zeFRNpoIonv8Axj8HU4jkLloSf2q1VIlS43eq1wpHCwU2JaYBvTpzfMJfvPL2
         qdTlRvfAt/skwW49FR+QhNwqCOUnr5maDeEgLxsGE+90y6DWSRhaMI9LVuMjmB9sLI
         9hCqbQJw165/Eqkl84wqOO3OTdH9zbrEvOKaFoJrqAP7F2MexdZwApOSU3yX7gzSio
         lpEvp8x0goMpw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sun, 20 Aug 2023 00:46:09 +0200
Message-Id: <7d678e7b55e88e630491086f59120253fabeb386.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/6] regulator: core: simplify nested locking
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify regulator locking by removing locking around locking.
rdev->ref check when unlocking is moved inside the critical section.

This patch depends on 12235da8c80a ("kernel/locking: Add context to
ww_mutex_trylock()").

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 921c7039baa3..87e54b776a0f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -34,7 +34,6 @@
 #include "internal.h"
 
 static DEFINE_WW_CLASS(regulator_ww_class);
-static DEFINE_MUTEX(regulator_nesting_mutex);
 static DEFINE_MUTEX(regulator_list_mutex);
 static LIST_HEAD(regulator_map_list);
 static LIST_HEAD(regulator_ena_gpio_list);
@@ -143,23 +142,18 @@ static inline int regulator_lock_nested(struct regulator_dev *rdev,
 {
 	int ret = 0;
 
-	mutex_lock(&regulator_nesting_mutex);
-
 	if (!ww_mutex_trylock(&rdev->mutex, ww_ctx) &&
-	    rdev->mutex_owner != current) {
-		mutex_unlock(&regulator_nesting_mutex);
+	    READ_ONCE(rdev->mutex_owner) != current) {
 		ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
+
 		if (ret == -EDEADLK)
 			return ret;
-		mutex_lock(&regulator_nesting_mutex);
 	}
 
 	rdev->ref_cnt++;
 	rdev->mutex_owner = current;
 
-	mutex_unlock(&regulator_nesting_mutex);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -186,16 +180,13 @@ static void regulator_lock(struct regulator_dev *rdev)
  */
 static void regulator_unlock(struct regulator_dev *rdev)
 {
-	mutex_lock(&regulator_nesting_mutex);
+	if (WARN_ON_ONCE(rdev->ref_cnt <= 0))
+		return;
 
 	if (--rdev->ref_cnt == 0) {
 		rdev->mutex_owner = NULL;
 		ww_mutex_unlock(&rdev->mutex);
 	}
-
-	WARN_ON_ONCE(rdev->ref_cnt < 0);
-
-	mutex_unlock(&regulator_nesting_mutex);
 }
 
 /**
-- 
2.39.2

