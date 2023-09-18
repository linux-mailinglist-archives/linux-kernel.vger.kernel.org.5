Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155997A55EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjIRWui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjIRWug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:50:36 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2F491
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:50:31 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RqKkq5vPwzMG;
        Tue, 19 Sep 2023 00:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1695077427; bh=IhP3GWRGjyGl/XiVtu7/EHAPbVQwMJ4tvGHH3lP7MPM=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=ZF4O5EQFp1osSqdFmFFop9x4dFOaNyxpUobc/Lnmr9pO7Ptqz9CUUydNontsijbBE
         mtUzxd5r8uRdGTmbUlFHIn9x93nl7CnNJW/tbVxOu54NVZZw5LeYI71Yq5lrhyS7az
         wN9C+FmYYO4jMmvqpzElgkIHxuHv5/UkfVBTxWTGG53LwKVcMnajmdajZDk6OFxwgt
         XEbo7XrADhVqUGEljIo42Q5i/nJvrzDoapcuXEbsFcJWcBYcRRVsix0mvgLuOvPZhZ
         cQnrBfeOJF0CVznGdH/R7qOz9Y2seIWndGwIAkMcOpTylKuQSv9ZrEV/w/ckQ1d9ru
         K5Tx4s1ZxKifg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Tue, 19 Sep 2023 00:50:27 +0200
Message-Id: <d7f469f3f7b1f0e1d52f9a7ede3f3c5703382090.1695077303.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <b5b19cb458c40c9d02f3d5a7bd1ba7d97ba17279.1695077303.git.mirq-linux@rere.qmqm.pl>
References: <b5b19cb458c40c9d02f3d5a7bd1ba7d97ba17279.1695077303.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/2] regulator/core: Revert "fix kobject release warning
 and memory leak in regulator_register()"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 2820badc7a12..3137e40fcd3e 100644
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

