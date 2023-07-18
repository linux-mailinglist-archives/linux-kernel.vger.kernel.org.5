Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81567585AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGRTjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGRTjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611EB198D;
        Tue, 18 Jul 2023 12:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF4E060B67;
        Tue, 18 Jul 2023 19:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A0CC433C8;
        Tue, 18 Jul 2023 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709159;
        bh=edH1Zr2qH/fjaThXqfpUXzX8pWVRCsemGBHQNSlSqok=;
        h=From:To:Cc:Subject:Date:From;
        b=o4wM9mZ0npgKSQDLKS2fgstEeuMrgo+3fH5Tzy0PRVO9VigkaLoYEADgh1spnvD6W
         jcTl86agH4tnuwVnj5WtJfPinX8GiFwlwFxVS6CzNie64Lu489E5CLIuSPfe951XHG
         BRQ9NVcb0joSQlElAqd0fQ//yM8xWZ8PGTkf5njDmln25oYfV68KnbrjBop3kQ8Yun
         TazcmaorIkqSoIdVCjWaMa4UHxHDPqmOqpzKzBtk7aFZPa8fTq2wOo5RU23yAvo8fv
         NR1WHFiu7TZuHS3FTZSK3vDiF/LrJBBKu/cbcd+YgtnMGSseQqLzOqYDlpKLiGHd3l
         8JMddIjWwdJaw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>,
        Marek Vasut <marex@denx.de>, Marc Zyngier <maz@kernel.org>,
        Dan Carpenter <error27@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: mxc: fix unused function warnings
Date:   Tue, 18 Jul 2023 21:39:08 +0200
Message-Id: <20230718193913.3578660-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new runtime PM support causes a harmless warning about
unused functions when runtime PM is disabled:

drivers/gpio/gpio-mxc.c:612:12: error: 'mxc_gpio_runtime_resume' defined but not used [-Werror=unused-function]
drivers/gpio/gpio-mxc.c:602:12: error: 'mxc_gpio_runtime_suspend' defined but not used [-Werror=unused-function]

Change the driver to use the more modern helper macros that avoid these
warnings, and remove the now unnecessary __maybe_unused annotations

Fixes: 3283d820dce64 ("gpio: mxc: add runtime pm support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-mxc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index a9fb6bd9aa6f9..e03fc8d375fe1 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -623,7 +623,7 @@ static int mxc_gpio_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
+static int mxc_gpio_noirq_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
@@ -634,7 +634,7 @@ static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
+static int mxc_gpio_noirq_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
@@ -647,8 +647,8 @@ static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops mxc_gpio_dev_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
-	SET_RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume, NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
+	RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume, NULL)
 };
 
 static int mxc_gpio_syscore_suspend(void)
-- 
2.39.2

