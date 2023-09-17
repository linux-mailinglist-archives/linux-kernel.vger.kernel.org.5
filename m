Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2183C7A3DE0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjIQVfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjIQVfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:35:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A15C130
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:35:17 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rph6V5bPFzFj;
        Sun, 17 Sep 2023 23:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1694986514; bh=QVca91oFtGzpLpEdY8ScokeQXsjkCHQgGWo6EomZVKI=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=Im+RfvZrI3P2GkPmU75TmPK1tLqo9jp7LTp1JtKAqIchr/0uPXgEtPXptK5mT2VIc
         5JTK1CxP0FfUL2+KFN0aWZ/oXgBq9ygUM7yWR05JUXDpMOw4/X3HpXIkfkiGn/T0Ux
         OSql+jEQMaak/23UcD3i0ic7DyyM9DfiASF8VYSQyzAcALRwchCovuRVVKlIpjBRYY
         7rOkTxtam8FpbpUu5JAG3/5K7wjL2VY0VFt1B+/o8QuAuM1v7EJxCuYrTWWhEMO2eE
         PF6kkgg796pGpsFaJIIXBzvCu0mcnfI1WufgIZaSl3g0lx5mczZUAhocuKFVzeHvLi
         VHrEehoEP1NOg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sun, 17 Sep 2023 23:35:14 +0200
Message-Id: <811062614da5ec63ac9c975b77bdb6bf34720552.1694985959.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1694985959.git.mirq-linux@rere.qmqm.pl>
References: <cover.1694985959.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] regulator/core: regulator_register: set device->class
 earlier
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Zeng Heng <zengheng4@huawei.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_initialize() calls for the `device` struct be freed with
`put_device()`. This requires a release() callback that is provided by
the regulator_class.

Fixes: d3c731564e09 ("regulator: plug of_node leak in regulator_register()'s error path")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e1caaf207e..2f6ee5527cb0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5542,6 +5542,7 @@ regulator_register(struct device *dev,
 		goto rinse;
 	}
 	device_initialize(&rdev->dev);
+	rdev->dev.class = &regulator_class;
 	spin_lock_init(&rdev->err_lock);
 
 	/*
@@ -5603,7 +5604,6 @@ regulator_register(struct device *dev,
 		rdev->supply_name = regulator_desc->supply_name;
 
 	/* register with sysfs */
-	rdev->dev.class = &regulator_class;
 	rdev->dev.parent = config->dev;
 	dev_set_name(&rdev->dev, "regulator.%lu",
 		    (unsigned long) atomic_inc_return(&regulator_no));
-- 
2.39.2

