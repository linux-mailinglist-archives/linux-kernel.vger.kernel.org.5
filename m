Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD077E07C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244625AbjHPLeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244683AbjHPLeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:34:11 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA7826A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:33:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by xavier.telenet-ops.be with bizsmtp
        id aBZT2A00445ualL01BZTFl; Wed, 16 Aug 2023 13:33:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWEm8-000p1Y-GO;
        Wed, 16 Aug 2023 13:33:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWEmE-006A0c-RE;
        Wed, 16 Aug 2023 13:33:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Valentin Caron <valentin.caron@foss.st.com>
Cc:     linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] rtc: stm32: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Date:   Wed, 16 Aug 2023 13:33:26 +0200
Message-Id: <20230816113326.1468435-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM_SLEEP=n (e.g. m68k/allmodconfig):

    drivers/rtc/rtc-stm32.c:904:12: error: ‘stm32_rtc_resume’ defined but not used [-Werror=unused-function]
      904 | static int stm32_rtc_resume(struct device *dev)
	  |            ^~~~~~~~~~~~~~~~
    drivers/rtc/rtc-stm32.c:894:12: error: ‘stm32_rtc_suspend’ defined but not used [-Werror=unused-function]
      894 | static int stm32_rtc_suspend(struct device *dev)
	  |            ^~~~~~~~~~~~~~~~~

Indeed, the previous change mixed up the semantics between
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() and NOIRQ_SYSTEM_SLEEP_PM_OPS().
Fix this by using the modern NOIRQ_SYSTEM_SLEEP_PM_OPS() instead.

Reported-by: noreply@ellerman.id.au
Fixes: a69c610e13e2b2de ("rtc: stm32: remove incorrect #ifdef check")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/rtc/rtc-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 3ce4b3d08155b48d..76753c71d92eef3e 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -923,7 +923,7 @@ static int stm32_rtc_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops stm32_rtc_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_rtc_suspend, stm32_rtc_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_rtc_suspend, stm32_rtc_resume)
 };
 
 static struct platform_driver stm32_rtc_driver = {
-- 
2.34.1

