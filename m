Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267A7A55ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjIRWuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRWug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:50:36 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F6B8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:50:31 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RqKkq2Hzcz60;
        Tue, 19 Sep 2023 00:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1695077427; bh=m2PiVkEVguzoRtvVnE00KO+PvS14T+9ORFLSvlRgRBk=;
        h=Date:Subject:From:To:Cc:From;
        b=q0YT48w2c6csMjFD0n5S6QeHMbP8tgLH8g9I8PyzkJTNeANJw3b4D7Yt0V/7OUjtm
         h5x5gJih5GNjueB0iZ2TmK8+p2n+l4jmlmIkvFQ2TVHSfm+1hMgC6cimuLbK9ogA5w
         2RSi0wlugDx/en0AZz6Kxeiffdi9MjKNEZkXsCQOClndivlhRs1RCmPR8PSiEKogvu
         bh8igwB3/at3J6yd/HkMKIEJ38Kmnjn2NLlI6wFC6y0MAPHYzrdoazdpL17FQpZ8xX
         GjcbvKY21nfM3dmA+lNPKvUlafpRMJ4z7XiEl55BgEdTs+uNF/ql11fFsrxIM5rjw+
         kkPLoB/jtY90A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Tue, 19 Sep 2023 00:50:26 +0200
Message-Id: <b5b19cb458c40c9d02f3d5a7bd1ba7d97ba17279.1695077303.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/2] regulator/core: regulator_register: set device->class
 earlier
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fixing a memory leak in commit d3c731564e09 ("regulator: plug
of_node leak in regulator_register()'s error path") it moved the
device_initialize() call earlier, but did not move the `dev->class`
initialization.  The bug was spotted and fixed by reverting part of
the commit (in commit 5f4b204b6b81 "regulator: core: fix kobject
release warning and memory leak in regulator_register()") but
introducing a different bug: now early error paths use `kfree(dev)`
instead of `put_device()` for an already initialized `struct device`.

Move the missing assignments to just after `device_initialize()`.

Fixes: d3c731564e09 ("regulator: plug of_node leak in regulator_register()'s error path")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: move dev_set_drvdata() as it is used by regulator_dev_release()
  + move cover letter explanation to this patch
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e1caaf207e..2820badc7a12 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5542,6 +5542,8 @@ regulator_register(struct device *dev,
 		goto rinse;
 	}
 	device_initialize(&rdev->dev);
+	dev_set_drvdata(&rdev->dev, rdev);
+	rdev->dev.class = &regulator_class;
 	spin_lock_init(&rdev->err_lock);
 
 	/*
@@ -5603,11 +5605,9 @@ regulator_register(struct device *dev,
 		rdev->supply_name = regulator_desc->supply_name;
 
 	/* register with sysfs */
-	rdev->dev.class = &regulator_class;
 	rdev->dev.parent = config->dev;
 	dev_set_name(&rdev->dev, "regulator.%lu",
 		    (unsigned long) atomic_inc_return(&regulator_no));
-	dev_set_drvdata(&rdev->dev, rdev);
 
 	/* set regulator constraints */
 	if (init_data)
-- 
2.39.2

