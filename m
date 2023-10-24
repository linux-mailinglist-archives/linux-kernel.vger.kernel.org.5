Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F757D4E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjJXK4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjJXK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:56:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3B5AE5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:56:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1C7215BF;
        Tue, 24 Oct 2023 03:57:11 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106D03F64C;
        Tue, 24 Oct 2023 03:56:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 24 Oct 2023 11:56:20 +0100
Subject: [PATCH 4/4] firmware: arm_ffa: Fix FFA notifications cleanup path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-ffa-notification-fixes-v1-4-d552c0ec260d@arm.com>
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
In-Reply-To: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2084; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=//JpqRCTG6133GyveR4ek+FR3WO6FNVPAfl35AD8fYY=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlN6LZAKdF6iJn1GsMxaobrUC4sNzZJsjmewCVP
 gjo4REtbPeJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZTei2QAKCRAAQbq8MX7i
 mObpD/4mSWyNNXZefkniqBQplfV6ySTNlgWi/ZjEF3LgcqkTPQ2IHYYUaJksssKwZCgiHaRWRt7
 859lkifjOHGoqD+ndW9Ty+beHUyBZUEpr3NXikQEzSQQJBOjtXfK1pRiWoLHS6yppWa49XUx6CO
 o6HSA7AZZ88K/Gvui5yjjsHWnrveR+JjK1VTHQp4AN4YkrQJdNKLsxSaHX9RZAKbbtyYXK7c4XF
 Ya/jcFlV5ddHoRxy64ATyLq32XNYidYFQkwkdNljayIt/CsJTv83BHIxvysdCtmrGKL0w1skTVU
 acAeMcueb8M86oMhcPnWmSezEm+eQOuc/kN/k5vZEh/B5gkiJADmovLQ7wDkwbXYlaDu0EH/ody
 T+s/6Xm+AP6NrVU04y5EN9+Ua4zOek9haZ+4nHGePdMgeHAIpnguer9aet1YJHRvRKmGHbNH4vW
 Y8fwW+5pkeOiTbv3zVd/k+rk3o1FBnj2186MMLVuI4yEdTxD/xcIES1/N65Vp2g/97/Wo41o5Ab
 DL25Gd1mHGBkVGdvJYbIQtChqClYVMLDvxME6xAb6uCAbyF3XvJQR5RMGGaGeCqEji0vjx7eJG8
 X527nLjYmcW4iKPmYkIIHjiY76YH+IctvETObLcDpqevYQwVq4eGxCSBa8sEBdA3jCG3imLK4tw
 VAoNnN0LsdysdiQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We allow the FF-A to be initialised successfully even when notification
fails. When the notification fails, ffa_notifications_cleanup() gets
called on the failure path.

However, the driver information about the notifications like the irq,
workqueues and cpu hotplug state for enabling and disabling percpu IRQ
are not cleared. This may result in unexpected behaviour during CPU
hotplug because of percpu IRQ being enabled and disabled or during the
driver removal when ffa_notifications_cleanup() gets executed again.

Fix the FFA notifications cleanup path by clearing all the notification
related driver information.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b097452597a2..e636181694aa 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1326,8 +1326,10 @@ static int ffa_sched_recv_irq_map(void)
 
 static void ffa_sched_recv_irq_unmap(void)
 {
-	if (drv_info->sched_recv_irq)
+	if (drv_info->sched_recv_irq) {
 		irq_dispose_mapping(drv_info->sched_recv_irq);
+		drv_info->sched_recv_irq = 0;
+	}
 }
 
 static int ffa_cpuhp_pcpu_irq_enable(unsigned int cpu)
@@ -1344,17 +1346,23 @@ static int ffa_cpuhp_pcpu_irq_disable(unsigned int cpu)
 
 static void ffa_uninit_pcpu_irq(void)
 {
-	if (drv_info->cpuhp_state)
+	if (drv_info->cpuhp_state) {
 		cpuhp_remove_state(drv_info->cpuhp_state);
+		drv_info->cpuhp_state = 0;
+	}
 
-	if (drv_info->notif_pcpu_wq)
+	if (drv_info->notif_pcpu_wq) {
 		destroy_workqueue(drv_info->notif_pcpu_wq);
+		drv_info->notif_pcpu_wq = NULL;
+	}
 
 	if (drv_info->sched_recv_irq)
 		free_percpu_irq(drv_info->sched_recv_irq, drv_info->irq_pcpu);
 
-	if (drv_info->irq_pcpu)
+	if (drv_info->irq_pcpu) {
 		free_percpu(drv_info->irq_pcpu);
+		drv_info->irq_pcpu = NULL;
+	}
 }
 
 static int ffa_init_pcpu_irq(unsigned int irq)

-- 
2.42.0

