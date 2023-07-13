Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1D7525F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjGMPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjGMPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B0919B4;
        Thu, 13 Jul 2023 08:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41415617F1;
        Thu, 13 Jul 2023 15:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B0FC433C8;
        Thu, 13 Jul 2023 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689260484;
        bh=TXCscstt8foR9MlhQdbRGwgR6LOhBKjV5Dq6e0YdGzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtPSscpQZY5IXoful4VY2d0tMiTOAdnUh594RSMwcMQ8Xsy+TMfdvVkKZLYCUWuOd
         JJho1LWExjZmgiUZ445ECHLsDA5u+ULXOwfGmF3zn9xSrawoNYCZFw17+yPj7ups/V
         Fe0GxB2XF9dMAo/SvBFYCWr2IOxtgqZTuEREVZQdXxZHdBoAkHmqY6lAmlKPGVUefI
         yzfHdBjAEngDnlofRbx2+tTnVwQ0zRIJBZ6FSSUt6UgD17ccpfve6nD9PvxS1qNIhx
         1PXq9oDDeU02eHj0wQ9YRjBmglrGcmpvAOFc7j3a4Rc59IkOoyL40EMyG+qg+kS0yd
         jMtx2sWBvqZeg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qJxor-0007vk-0R;
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
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/3] PM / wakeirq: fix wake irq arming
Date:   Thu, 13 Jul 2023 16:57:39 +0200
Message-ID: <20230713145741.30390-2-johan+linaro@kernel.org>
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

The decision whether to enable a wake irq during suspend can not be done
based on the runtime PM state directly as a driver may use wake irqs
without implementing runtime PM. Such drivers specifically leave the
state set to the default 'suspended' and the wake irq is thus never
enabled at suspend.

Add a new wake irq flag to track whether a dedicated wake irq has been
enabled at runtime suspend and therefore must not be enabled at system
suspend.

Note that pm_runtime_enabled() can not be used as runtime PM is always
disabled during late suspend.

Fixes: 69728051f5bf ("PM / wakeirq: Fix unbalanced IRQ enable for wakeirq")
Cc: stable@vger.kernel.org      # 4.16
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/base/power/power.h   |  1 +
 drivers/base/power/wakeirq.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 0eb7f02b3ad5..922ed457db19 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -29,6 +29,7 @@ extern u64 pm_runtime_active_time(struct device *dev);
 #define WAKE_IRQ_DEDICATED_MASK		(WAKE_IRQ_DEDICATED_ALLOCATED | \
 					 WAKE_IRQ_DEDICATED_MANAGED | \
 					 WAKE_IRQ_DEDICATED_REVERSE)
+#define WAKE_IRQ_DEDICATED_ENABLED	BIT(3)
 
 struct wake_irq {
 	struct device *dev;
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index d487a6bac630..afd094dec5ca 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -314,8 +314,10 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 	return;
 
 enable:
-	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE)) {
 		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
@@ -336,8 +338,10 @@ void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 	if (cond_disable && (wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
 		return;
 
-	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED) {
+		wirq->status &= ~WAKE_IRQ_DEDICATED_ENABLED;
 		disable_irq_nosync(wirq->irq);
+	}
 }
 
 /**
@@ -376,7 +380,7 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 
 	if (device_may_wakeup(wirq->dev)) {
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			enable_irq(wirq->irq);
 
 		enable_irq_wake(wirq->irq);
@@ -399,7 +403,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 		disable_irq_wake(wirq->irq);
 
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			disable_irq_nosync(wirq->irq);
 	}
 }
-- 
2.41.0

