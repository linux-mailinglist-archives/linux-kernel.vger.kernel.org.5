Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483297A3DE1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbjIQVfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjIQVfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:35:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D5F1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:35:17 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rph6W0lPXzHx;
        Sun, 17 Sep 2023 23:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1694986515; bh=UIbXDMty5LFR94K/w6jaxWU7ApJpMH2RmAPQ/Wr0MaQ=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=cFvaDmHr4ZS3Nst/gI9ZxNLOkq1X7TIyx4n2b16SjWNCE5FoYzDUN49o2BMA5RvY7
         M0cvNgGrvH8Q41rAp9LWnIlAq1cM1HiU1XbROidxh/J2Tc+oaFF4y2QDhDP0iAhzjf
         0vIBUr+nvU9McUg5LxNcrp5PdBpuhBQwRfRtVgaUTzV+J5i8tIP6yhnU2KvZiRseHd
         RQhHQWOYCfWGyogNqeqv0HvjYYWloA+jAngELqGs8wFhVlKHkNO2sGDp8heAx/fp9Z
         DCoVtVhuq+aiXaWXYGlqHyrJdnh2xe1Ghe0G3pP/2iKQ6pO248GZ703l1+Rk4LQyUM
         eyIg7dxE7X/Wg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sun, 17 Sep 2023 23:35:14 +0200
Message-Id: <d7361cf5c6bfc78f519149554eadad1d5ef5e76f.1694985959.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1694985959.git.mirq-linux@rere.qmqm.pl>
References: <cover.1694985959.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] Revert "regulator: core: fix kobject release warning and
 memory leak in regulator_register()"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Zeng Heng <zengheng4@huawei.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5f4b204b6b8153923d5be8002c5f7082985d153f.

Since rdev->dev now has a release() callback, the proper way of freeing
the initialized device can be restored.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2f6ee5527cb0..0994caa5ad5c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5724,15 +5724,11 @@ regulator_register(struct device *dev,
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
-	put_device(&rdev->dev);
-	rdev = NULL;
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	if (rdev && rdev->dev.of_node)
-		of_node_put(rdev->dev.of_node);
-	kfree(rdev);
 	kfree(config);
+	put_device(&rdev->dev);
 rinse:
 	if (dangling_cfg_gpiod)
 		gpiod_put(cfg->ena_gpiod);
-- 
2.39.2

