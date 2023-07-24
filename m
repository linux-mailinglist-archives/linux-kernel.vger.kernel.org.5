Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2633760024
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGXT5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGXT5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B45A6;
        Mon, 24 Jul 2023 12:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8019161362;
        Mon, 24 Jul 2023 19:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05336C433C7;
        Mon, 24 Jul 2023 19:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690228631;
        bh=4/mO24Ikk4CHlDznLLlA+DvTvlfb2sd89TKv9AA3wYI=;
        h=From:To:Cc:Subject:Date:From;
        b=AUoQC2XvXKgQjD1P9rrEu/Kn5JiiXB9Y3c14lNwXwW8M78id+LM2WIXSvx/0NR4kN
         rpkXzhemn2iR1aPhh3j5QtMk4YkB+BZsYSHUbcUN/dhzG3tCUzR+xJBPGTVIKqqC+r
         ySr9TOHnyoViYDraWSOqRfjzyq3STt68AXlSa/tsZHOa4omxhxjV/EPfXYnpMeOO6+
         Dcza/NTZjSvHS0tLJHix2T6ZCkHi/3NCPCv0FoCii98M8APB8a8VB+aPtzvb8gAIjv
         vCzrcNIkUC8Le5AjF4JTIiIwRD2+163T6KL8/D79/DqObvVQNT/3zSbc/LF+5pbFGf
         mASLsQvohf3pw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: stm32: fix incorrect optional pointers
Date:   Mon, 24 Jul 2023 21:56:49 +0200
Message-Id: <20230724195704.2432382-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing without CONFIG_OF shows that the of_match_ptr() macro
was used incorrectly here:

drivers/remoteproc/stm32_rproc.c:662:34: warning: unused variable 'stm32_rproc_match' [-Wunused-const-variable]

As in almost every driver, the solution is simply to remove the
use of this macro. The same thing happened with the deprecated
SIMPLE_DEV_PM_OPS(), but the corresponding warning was already shut
up with __maybe_unused annotations, so fix those as well by using the
correct DEFINE_SIMPLE_DEV_PM_OPS() macros and removing the extraneous
__maybe_unused modifiers. For completeness, also add a pm_ptr() to let
the PM ops be eliminated completely when CONFIG_PM is turned off.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307242300.ia82qBTp-lkp@intel.com
Fixes: 03bd158e1535e ("remoteproc: stm32: use correct format strings on 64-bit")
Fixes: 410119ee29b6c ("remoteproc: stm32: wakeup the system by wdg irq")
Fixes: 13140de09cc2d ("remoteproc: stm32: add an ST stm32_rproc driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/remoteproc/stm32_rproc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 98234b44f0389..9d9b13530f78a 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -921,7 +921,7 @@ static void stm32_rproc_remove(struct platform_device *pdev)
 	rproc_free(rproc);
 }
 
-static int __maybe_unused stm32_rproc_suspend(struct device *dev)
+static int stm32_rproc_suspend(struct device *dev)
 {
 	struct rproc *rproc = dev_get_drvdata(dev);
 	struct stm32_rproc *ddata = rproc->priv;
@@ -932,7 +932,7 @@ static int __maybe_unused stm32_rproc_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_rproc_resume(struct device *dev)
+static int stm32_rproc_resume(struct device *dev)
 {
 	struct rproc *rproc = dev_get_drvdata(dev);
 	struct stm32_rproc *ddata = rproc->priv;
@@ -943,16 +943,16 @@ static int __maybe_unused stm32_rproc_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
-			 stm32_rproc_suspend, stm32_rproc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
+				stm32_rproc_suspend, stm32_rproc_resume);
 
 static struct platform_driver stm32_rproc_driver = {
 	.probe = stm32_rproc_probe,
 	.remove_new = stm32_rproc_remove,
 	.driver = {
 		.name = "stm32-rproc",
-		.pm = &stm32_rproc_pm_ops,
-		.of_match_table = of_match_ptr(stm32_rproc_match),
+		.pm = pm_ptr(&stm32_rproc_pm_ops),
+		.of_match_table = stm32_rproc_match,
 	},
 };
 module_platform_driver(stm32_rproc_driver);
-- 
2.39.2

