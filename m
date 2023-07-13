Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781DD7525F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGMPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjGMPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02EA19A6;
        Thu, 13 Jul 2023 08:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 535D661896;
        Thu, 13 Jul 2023 15:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCB8C433CC;
        Thu, 13 Jul 2023 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689260484;
        bh=itZ0gFAo0LPJQtM5BSI/nzA/wdukNr9OD7PReC0Np54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG30JVJEIUEkPn3C65YZHI39Nb4WEytx5K66voqeVZGqjDdzygPXioa/isoY4l57C
         VQui/052L5avKzgGwK1yxKAoEAMn+Q6QqtbrflKfbEqcTKOB+4QO2vjKvRIWhZVvmU
         wNB5Jg4xKXSkQ0Qm+90dGBGxSO7hN0pbnBrQZhou9fmJyrfdWyaTdoquDrePfBNbYx
         BxnHpruVNN+M+in/ThPyx6hHIu6nukrxKWjt9nUPh0HBUhJXb/MhzCNi11HKBgnAei
         qDGnwFeIrFGVJvzuN/EmF33pXpUgJFWciInL9kTHtunGKBv0aa/JdhXlsB62o1l7Oj
         SeQwiSL3no9gw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qJxor-0007vm-0j;
        Thu, 13 Jul 2023 17:01:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/3] PM / wakeirq: drop unused enable helpers
Date:   Thu, 13 Jul 2023 16:57:40 +0200
Message-ID: <20230713145741.30390-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713145741.30390-1-johan+linaro@kernel.org>
References: <20230713145741.30390-1-johan+linaro@kernel.org>
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

Drop the wake-irq enable and disable helpers which have not been used
since commit bed570307ed7 ("PM / wakeirq: Fix dedicated wakeirq for
drivers not using autosuspend").

Note that these functions are essentially just leftovers from the first
iteration of the wake-irq implementation where device drivers were
supposed to call these functions themselves instead of PM core (as
is also indicated by the bogus kernel doc comments).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/base/power/wakeirq.c | 49 ------------------------------------
 include/linux/pm_wakeirq.h   | 10 --------
 2 files changed, 59 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index afd094dec5ca..42171f766dcb 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -194,7 +194,6 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
 	return err;
 }
 
-
 /**
  * dev_pm_set_dedicated_wake_irq - Request a dedicated wake-up interrupt
  * @dev: Device entry
@@ -206,11 +205,6 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
  * Sets up a threaded interrupt handler for a device that has
  * a dedicated wake-up interrupt in addition to the device IO
  * interrupt.
- *
- * The interrupt starts disabled, and needs to be managed for
- * the device by the bus code or the device driver using
- * dev_pm_enable_wake_irq*() and dev_pm_disable_wake_irq*()
- * functions.
  */
 int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 {
@@ -232,11 +226,6 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
  * the status of WAKE_IRQ_DEDICATED_REVERSE to tell rpm_suspend()
  * to enable dedicated wake-up interrupt after running the runtime suspend
  * callback for @dev.
- *
- * The interrupt starts disabled, and needs to be managed for
- * the device by the bus code or the device driver using
- * dev_pm_enable_wake_irq*() and dev_pm_disable_wake_irq*()
- * functions.
  */
 int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
 {
@@ -244,44 +233,6 @@ int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
 
-/**
- * dev_pm_enable_wake_irq - Enable device wake-up interrupt
- * @dev: Device
- *
- * Optionally called from the bus code or the device driver for
- * runtime_resume() to override the PM runtime core managed wake-up
- * interrupt handling to enable the wake-up interrupt.
- *
- * Note that for runtime_suspend()) the wake-up interrupts
- * should be unconditionally enabled unlike for suspend()
- * that is conditional.
- */
-void dev_pm_enable_wake_irq(struct device *dev)
-{
-	struct wake_irq *wirq = dev->power.wakeirq;
-
-	if (wirq && (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED))
-		enable_irq(wirq->irq);
-}
-EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
-
-/**
- * dev_pm_disable_wake_irq - Disable device wake-up interrupt
- * @dev: Device
- *
- * Optionally called from the bus code or the device driver for
- * runtime_suspend() to override the PM runtime core managed wake-up
- * interrupt handling to disable the wake-up interrupt.
- */
-void dev_pm_disable_wake_irq(struct device *dev)
-{
-	struct wake_irq *wirq = dev->power.wakeirq;
-
-	if (wirq && (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED))
-		disable_irq_nosync(wirq->irq);
-}
-EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
-
 /**
  * dev_pm_enable_wake_irq_check - Checks and enables wake-up interrupt
  * @dev: Device
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index dd42d16945d0..d9642c6cf852 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -10,8 +10,6 @@ extern int dev_pm_set_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
-extern void dev_pm_enable_wake_irq(struct device *dev);
-extern void dev_pm_disable_wake_irq(struct device *dev);
 
 #else	/* !CONFIG_PM */
 
@@ -34,13 +32,5 @@ static inline void dev_pm_clear_wake_irq(struct device *dev)
 {
 }
 
-static inline void dev_pm_enable_wake_irq(struct device *dev)
-{
-}
-
-static inline void dev_pm_disable_wake_irq(struct device *dev)
-{
-}
-
 #endif	/* CONFIG_PM */
 #endif	/* _LINUX_PM_WAKEIRQ_H */
-- 
2.41.0

