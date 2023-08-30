Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3E78DBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbjH3Sbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbjH3Rff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:35:35 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE91F198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:35:32 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbWfC14KfzMG;
        Wed, 30 Aug 2023 19:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693416931; bh=PnYjkE6gtqAOfIRwVhLGjxruQguXRdfkE9L0v73w0Nk=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=GgzllHXWm363dOzSs4WrNZTcC8K6hBGPjynUno9kvKFwdaJkSvzJLTsap7Q+RAafv
         xyzsp7mkfmBZjcgjd3pOaIcyggzv4MzhDAzcn3Z1CAlF/bMjGn6m4KQSngoODsx0oD
         H1pCOOwPLcvv4d+h4m0/hcK2Tb0qQmlvODeHpYqngaOgt2oioFWMqbPxsUiHenOxcd
         sh/T9grNhX4EqAiAecBpppb6r0MU96bIfSuApO8v42IBq1WLoIB/GqCe1dOWl/hSZJ
         OtKFU18gYLreBuZB8OhrjrJfvqilC5fYab3aRSMKB1s1Ya7PagSI+rLnWiN/Mcihi9
         jOQhcQXqnJbnQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 19:35:30 +0200
Message-Id: <121c27939458ca3c1424b38fd6cee2d81cef831e.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/7] regulator/core: regulator_lock_nested: remove `lock`
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`lock` is only false when the `rdev` is already locked and the owner is
`current`. In this case `ret` is always zero. By removing `lock`, we
thus remove `mutex_owner` write avoidance, but make the code flow more
understandable.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e1caaf207e..215b721e5cd4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -141,27 +141,19 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
 static inline int regulator_lock_nested(struct regulator_dev *rdev,
 					struct ww_acquire_ctx *ww_ctx)
 {
-	bool lock = false;
 	int ret = 0;
 
 	mutex_lock(&regulator_nesting_mutex);
 
 	if (!ww_mutex_trylock(&rdev->mutex, ww_ctx)) {
-		if (rdev->mutex_owner == current)
-			rdev->ref_cnt++;
-		else
-			lock = true;
-
-		if (lock) {
+		if (rdev->mutex_owner != current) {
 			mutex_unlock(&regulator_nesting_mutex);
 			ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
 			mutex_lock(&regulator_nesting_mutex);
 		}
-	} else {
-		lock = true;
 	}
 
-	if (lock && ret != -EDEADLK) {
+	if (ret != -EDEADLK) {
 		rdev->ref_cnt++;
 		rdev->mutex_owner = current;
 	}
-- 
2.39.2

