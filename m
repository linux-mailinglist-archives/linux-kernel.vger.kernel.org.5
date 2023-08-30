Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77678DE58
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbjH3TBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbjH3Rfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:35:37 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9551D1A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:35:34 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWfF1KmZzgk;
        Wed, 30 Aug 2023 19:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416933; bh=FBO3C/ZT0gXV582lOwqaqYNAxfqDw70mVXC++i5rfZQ=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=V0rJTCM40625GgmDxlSvUOLWaZOLLW+/FF4+z4VjKTlAulr35h8dJbrJr5VbfoQn2
         SLoU4Qsmqt8wWw/svk6m6PpYOepC8Eesrt9aHTJRPWJ7FM9YyyaQbLyF3vknwuGEyG
         8/ex66OV96WAAsHj2PYDAE+NlFUXnc5LVNjFMtjh0TF5tPHtiVcnGBRQbL7utEB1rF
         Ly1Hv3S5evsQJWGbkTDjDwjHZJT+TPnxW5ceLDrFdJU5PcXjJRAAsaCJyYh9UjiCR9
         MxUF5FQEMTmZVLIbS6sXAt2PDa2x5Jw1T8+sABN0kFdLvwm0lFSP+uqgDZmq3SVcCJ
         6EojIry0utvsg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:35:32 +0200
Message-Id: <85bcd0af56521209f40e76e0cac626c4f02b7df5.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 5/7] regulator/core: regulator_lock_contended: wrap
 ww_mutex lock sequence restart
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

Wrap locking a regulator after a failed ww_mutex locking sequence with a
new function.  This is to deduplicate occurrences of the pattern and make
it self-documenting.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e89c12d27a9d..7201927c5d5b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -154,6 +154,22 @@ static inline int regulator_lock_nested(struct regulator_dev *rdev,
 	return 0;
 }
 
+/**
+ * regulator_lock_contended - retry locking a regulator
+ * @rdev:		regulator source
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * Locks a regulator after a failed locking sequence (aborted
+ * with -EDEADLK).
+ */
+static inline void regulator_lock_contended(struct regulator_dev *rdev,
+					    struct ww_acquire_ctx *ww_ctx)
+{
+	ww_mutex_lock_slow(&rdev->mutex, ww_ctx);
+	rdev->ref_cnt++;
+	rdev->mutex_owner = current;
+}
+
 /**
  * regulator_lock - lock a single regulator
  * @rdev:		regulator source
@@ -218,9 +234,7 @@ static void regulator_lock_two(struct regulator_dev *rdev1,
 	while (true) {
 		regulator_unlock(held);
 
-		ww_mutex_lock_slow(&contended->mutex, ww_ctx);
-		contended->ref_cnt++;
-		contended->mutex_owner = current;
+		regulator_lock_contended(contended, ww_ctx);
 		swap(held, contended);
 		ret = regulator_lock_nested(contended, ww_ctx);
 
@@ -376,10 +390,8 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
 
 	do {
 		if (new_contended_rdev) {
-			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
+			regulator_lock_contended(new_contended_rdev, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
-			old_contended_rdev->ref_cnt++;
-			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_lock_recursive(rdev,
@@ -6085,10 +6097,8 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 
 	do {
 		if (new_contended_rdev) {
-			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
+			regulator_lock_contended(new_contended_rdev, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
-			old_contended_rdev->ref_cnt++;
-			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_summary_lock_all(ww_ctx,
-- 
2.39.2

