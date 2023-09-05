Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009FF792A86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbjIEQir convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 12:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354528AbjIEMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:21:17 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828F1B3;
        Tue,  5 Sep 2023 05:21:11 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4A0A124E17F;
        Tue,  5 Sep 2023 20:21:07 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 5 Sep
 2023 20:21:07 +0800
Received: from ubuntu.localdomain (113.72.144.73) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 5 Sep
 2023 20:21:06 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas Schwab <schwab@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] pinctrl: starfive: jh7110: Fix failure to set irq after CONFIG_PM is enabled
Date:   Tue, 5 Sep 2023 20:21:04 +0800
Message-ID: <20230905122105.117000-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230905122105.117000-1-hal.feng@starfivetech.com>
References: <20230905122105.117000-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.73]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue was found when we enabled CONFIG_PM and tested edge events using
libgpiod.

> # gpiomon -r gpiochip0 55
> gpiomon: error waiting for events: Permission denied

`gpiomon` will call irq_chip_pm_get() and then call pm_runtime_resume_and_get()
if (IS_ENABLED(CONFIG_PM) && sfp->gc.irq.domain->pm_dev).
pm_runtime_resume_and_get() will fail if the runtime pm of pinctrl device
is disabled.

As we expect the pinctrl driver can be always working and never suspend
during runtime, unset sfp->gc.irq.domain->pm_dev to make sure
pm_runtime_resume_and_get() won't be called when setting irq.

Fixes: 447976ab62c5 ("pinctrl: starfive: Add StarFive JH7110 sys controller driver")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 5fe729b4a03d..72747ad497b5 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -968,8 +968,6 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not register gpiochip\n");
 
-	irq_domain_set_pm_device(sfp->gc.irq.domain, dev);
-
 	dev_info(dev, "StarFive GPIO chip registered %d GPIOs\n", sfp->gc.ngpio);
 
 	return pinctrl_enable(sfp->pctl);
-- 
2.38.1

