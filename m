Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41D576B2A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjHALGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjHALF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397CB7AA9;
        Tue,  1 Aug 2023 03:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C21C361519;
        Tue,  1 Aug 2023 10:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F66C433C8;
        Tue,  1 Aug 2023 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690887578;
        bh=W6uC+hfdQjXTE0b+hUiFIq4lfhy6AJ+5JMfKAqdfPEg=;
        h=From:To:Cc:Subject:Date:From;
        b=I3i7dgT+D7pQRjctNSQCfp2q3NsGd0IjKONwgsV5qi8MuPuNxiXt3FhH/F8UHr3NJ
         H6mbydie71eLjQgprazKi0/9WCDZaQdB9CI+YGBeO4ic0O7fDcb+Wh5kSA6akqKvsM
         rYzIwsA1LuNixpwVzxZzH4m1Kffo/le6cp3BCbeKy24Iuhw24sdRfesACPcTPrQ6FY
         Fy/HTlrayvB15X/PhESYg52xrOovl+Y5/mXrdEu0Y25QGEKzqdccTzl450jNLZ3EsJ
         szRAHJrb6MjAXz7UoAIcBBCTUn7hiYskhJrEbuvUPw3QcjsUIQWe0o2lp5XtyUblRS
         Jo/W818d0jTyw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: stm32: remove incorrect #ifdef check
Date:   Tue,  1 Aug 2023 12:59:15 +0200
Message-Id: <20230801105932.3738430-1-arnd@kernel.org>
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

After a previous commit changed the driver over to
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(), the suspend/resume
functions must no longer be hidden behind an #ifdef:

In file included from include/linux/clk.h:13,
                 from drivers/rtc/rtc-stm32.c:8:
drivers/rtc/rtc-stm32.c:927:39: error: 'stm32_rtc_suspend' undeclared here (not in a function); did you mean 'stm32_rtc_probe'?
  927 |         SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_rtc_suspend, stm32_rtc_resume)
      |                                       ^~~~~~~~~~~~~~~~~
include/linux/kernel.h:58:44: note: in definition of macro 'PTR_IF'
   58 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
      |                                            ^~~
include/linux/pm.h:329:26: note: in expansion of macro 'pm_sleep_ptr'
  329 |         .suspend_noirq = pm_sleep_ptr(suspend_fn), \
      |                          ^~~~~~~~~~~~

Fixes: fb9a7e5360dc8 ("rtc: stm32: change PM callbacks to "_noirq()"")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-stm32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 85689192fa7ae..c296e7af0700c 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -890,7 +890,6 @@ static void stm32_rtc_remove(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, false);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stm32_rtc_suspend(struct device *dev)
 {
 	struct stm32_rtc *rtc = dev_get_drvdata(dev);
@@ -921,7 +920,6 @@ static int stm32_rtc_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops stm32_rtc_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_rtc_suspend, stm32_rtc_resume)
-- 
2.39.2

