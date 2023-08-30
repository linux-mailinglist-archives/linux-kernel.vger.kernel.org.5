Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0978DD61
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbjH3StK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjH3Rfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:35:36 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AEE1A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:35:33 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWfD1bCTzVr;
        Wed, 30 Aug 2023 19:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416932; bh=d/uWZtIzyiyl8negxdWeJKWCN/bjWfnYvB5RCFJNH3Q=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=JTFHfML1EUtRxjdnL38X/yCPC/OfDVdKOiz7ON0u3Fdeu8GBs563VHAafNI1CYCLP
         CBUCp5neaGYtus2Wgf7mOmxWUoZyXJfNBB5C8nvTV4/LJmNGx5XQrZr3onS93a8Ccq
         NrHMCiPpp6/I7FzVu1cXkftiiS8Wcehr9RGSZfQvhi+UfykuXlNc4t7HvKxBj8qLJR
         2ZjEV6ra98CTCJoPlreIonp/rB1sNYlRhbTzDqMcfW2fiL6/kjxkd0ruHkPx5nOLoK
         vJCf7F2XxjfTpB+sJUugvWKJuzSfXBKX0nKkgH+q/55NLdH4+6sFfoUmx/N8eyeZ1A
         TLgy4/T8guf8g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:35:31 +0200
Message-Id: <56ae0bf828d942c92ca867afb3aae95fcabd5498.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/7] regulator/core: regulator_lock_nested: simplify nested
 locking
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

Simplify regulator locking by removing locking around locking.
rdev->ref check when unlocking is moved inside the critical section.

This patch depends on commit 12235da8c80a ("kernel/locking: Add context
to ww_mutex_trylock()").

Note: return -EALREADY is removed as no caller depends on it and in that
case the lock count is incremented anyway.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 921c7039baa3..f18e7cb88a0d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -34,7 +34,6 @@
 #include "internal.h"
 
 static DEFINE_WW_CLASS(regulator_ww_class);
-static DEFINE_MUTEX(regulator_nesting_mutex);
 static DEFINE_MUTEX(regulator_list_mutex);
 static LIST_HEAD(regulator_map_list);
 static LIST_HEAD(regulator_ena_gpio_list);
@@ -141,25 +140,18 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
 static inline int regulator_lock_nested(struct regulator_dev *rdev,
 					struct ww_acquire_ctx *ww_ctx)
 {
-	int ret = 0;
-
-	mutex_lock(&regulator_nesting_mutex);
-
 	if (!ww_mutex_trylock(&rdev->mutex, ww_ctx) &&
-	    rdev->mutex_owner != current) {
-		mutex_unlock(&regulator_nesting_mutex);
-		ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
+	    READ_ONCE(rdev->mutex_owner) != current) {
+		int ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
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
@@ -186,16 +178,13 @@ static void regulator_lock(struct regulator_dev *rdev)
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

