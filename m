Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DB077FE30
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352463AbjHQSxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353215AbjHQSxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:53:15 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7CF3A92
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:52:45 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RRYyY62kJzB0;
        Thu, 17 Aug 2023 20:52:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692298326; bh=oF4SDyLQCNEvmUrp0ziWUwj9ohsjmTlqT7xMlNSZOCc=;
        h=Date:Subject:From:To:Cc:From;
        b=oFpfgAEWpkNMztpS3MdnshRpOoSejsDY5Gt079nr3P3Zf0uP55A85GFT3+QTe2cme
         jYxq4W/OYx4i8Oy6l2aHsnCf/xDmTLIv4lqaBPbsW9Cwho66sAvoT+6CDeNVhDQ1Hp
         40AAn7rG2Pea/wIidv1+BnwvNJWTtlriu7ayItE1bFlfXtU1jeBADDfLt8LsyRxFsL
         WsPBb1DI18x4EU4cFPXb1uQUqqxtrCSZoiQar3dgyFWEoBSlBv0IB9UClWFZonO6pV
         e1n/GW6Zj6nuIky+8YzHT8hEDIj4u171rh5ayey5h/PprFY+bKuSbYnQ0PzcOIZRSe
         aG0mBtMZGD/iA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Thu, 17 Aug 2023 20:52:05 +0200
Message-Id: <30323316714bfa0b8f8d4b82b438a579b418b904.1692298249.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regulator: simplify nested locking
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify regulator locking by removing locking around locking. rdev->ref
is now accessed only when the lock is taken.

This patch depends on 12235da8c80a ("kernel/locking: Add context to
ww_mutex_trylock()").

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c         | 40 +++++---------------------------
 include/linux/regulator/driver.h |  1 -
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e1caaf207e..0e3fba9eb5d4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -34,7 +34,6 @@
 #include "internal.h"
 
 static DEFINE_WW_CLASS(regulator_ww_class);
-static DEFINE_MUTEX(regulator_nesting_mutex);
 static DEFINE_MUTEX(regulator_list_mutex);
 static LIST_HEAD(regulator_map_list);
 static LIST_HEAD(regulator_ena_gpio_list);
@@ -141,32 +140,13 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
 static inline int regulator_lock_nested(struct regulator_dev *rdev,
 					struct ww_acquire_ctx *ww_ctx)
 {
-	bool lock = false;
 	int ret = 0;
 
-	mutex_lock(&regulator_nesting_mutex);
+	if (!ww_mutex_trylock(&rdev->mutex, ww_ctx))
+		ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
 
-	if (!ww_mutex_trylock(&rdev->mutex, ww_ctx)) {
-		if (rdev->mutex_owner == current)
-			rdev->ref_cnt++;
-		else
-			lock = true;
-
-		if (lock) {
-			mutex_unlock(&regulator_nesting_mutex);
-			ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
-			mutex_lock(&regulator_nesting_mutex);
-		}
-	} else {
-		lock = true;
-	}
-
-	if (lock && ret != -EDEADLK) {
+	if (ret != -EDEADLK)
 		rdev->ref_cnt++;
-		rdev->mutex_owner = current;
-	}
-
-	mutex_unlock(&regulator_nesting_mutex);
 
 	return ret;
 }
@@ -195,16 +175,11 @@ static void regulator_lock(struct regulator_dev *rdev)
  */
 static void regulator_unlock(struct regulator_dev *rdev)
 {
-	mutex_lock(&regulator_nesting_mutex);
+	if (WARN_ON_ONCE(rdev->ref_cnt <= 0))
+		return;
 
-	if (--rdev->ref_cnt == 0) {
-		rdev->mutex_owner = NULL;
+	if (--rdev->ref_cnt == 0)
 		ww_mutex_unlock(&rdev->mutex);
-	}
-
-	WARN_ON_ONCE(rdev->ref_cnt < 0);
-
-	mutex_unlock(&regulator_nesting_mutex);
 }
 
 /**
@@ -240,7 +215,6 @@ static void regulator_lock_two(struct regulator_dev *rdev1,
 
 		ww_mutex_lock_slow(&contended->mutex, ww_ctx);
 		contended->ref_cnt++;
-		contended->mutex_owner = current;
 		swap(held, contended);
 		ret = regulator_lock_nested(contended, ww_ctx);
 
@@ -399,7 +373,6 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
-			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_lock_recursive(rdev,
@@ -6113,7 +6086,6 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
-			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_summary_lock_all(ww_ctx,
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index c6ef7d68eb9a..3ed9fa385593 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -625,7 +625,6 @@ struct regulator_dev {
 
 	struct blocking_notifier_head notifier;
 	struct ww_mutex mutex; /* consumer lock */
-	struct task_struct *mutex_owner;
 	int ref_cnt;
 	struct module *owner;
 	struct device dev;
-- 
2.39.2

