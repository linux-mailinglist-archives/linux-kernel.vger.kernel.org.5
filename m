Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CED781B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHTAKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjHTAKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD87EA15CA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 13:15:44 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSqk71rppz47;
        Sat, 19 Aug 2023 22:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692476143; bh=cb3x8n2KvdEKrO5gnhlOylDSeakeIsSLrBnHc0wj/Xs=;
        h=Date:Subject:From:To:Cc:From;
        b=hwLnw2u8bU2rudNOg8R+HOsSO9Bz+KPpNDlUk8fnCWHdUYTUueksZRousMeblwdkK
         CYypYq8ll7/CpHikUDohKo6jDy8VUXB+hMb4XltgNmuNDvI1Rg8K6GuJ/v8VUBd+tA
         rHwTva68Vuc47DEhXfFmVVcsbYZWGeaSBT+2vKwC1VZcvNcwjLR2e3T74OfTrZKvP0
         VM+ieunOZ+/GJyZ0jz7fKuWg3+nU57VO0c6FGwCecU5pR1Nx8tPk4SfXk4GbMUAC+P
         z2gxeZ2qZ8NWeMDvV5tCQfCBuIXxY8Jw0JtfwSIndMmdWYgSrtwhmDMyU3vk5QMHVO
         t81N3kYczbdOA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 19 Aug 2023 22:15:42 +0200
Message-Id: <0e37d1f09718a6ab9204b367ff528ab02df25ac7.1692475736.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] regulator: core: simplify regulator_lock_nested()
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

`lock` is only false when the `rdev` is already locked and the owner is
`current`. In this case `ret` is always zero. By removing `lock`, we
thus remove `mutex_owner` write avoidance, but make the code flow more
understandable.

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

