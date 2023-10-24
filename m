Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBF97D4E58
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjJXK4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJXK4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:56:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2417A109
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:56:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD05C15;
        Tue, 24 Oct 2023 03:57:08 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197BB3F64C;
        Tue, 24 Oct 2023 03:56:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 24 Oct 2023 11:56:17 +0100
Subject: [PATCH 1/4] firmware: arm_ffa: Allow FF-A initialisation even when
 notification fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-ffa-notification-fixes-v1-1-d552c0ec260d@arm.com>
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
In-Reply-To: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=UW+oG+gsm0FKrpPXyKAnSuAo0QMzo5a2SfkP+2CJjXs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlN6LZt+oDW+pFRLk3OWWPZo4Q2axp2luX1Qowh
 FMTLIcpzCyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZTei2QAKCRAAQbq8MX7i
 mAFTEACpCDJLAhCp4Eu76ebowZKy1lZohQoC7AnD3RVB0A+S741ljXq/zk5k7p+3GHuk9GBoy+2
 0GnK1CqbJ53cbrDL33KF4VzNSVRaGWdAMfMJUd5GUdbozL0Ew++JB5XVg9v2gZC/Q56DE4UhZ+C
 kj8mocLnf7kvJoRNpQN88qEXKATw+bdEHFh1JWhnfZi+6zUi9h1F4CtP72il69AVlCxis87YikG
 dLJFdjTxyZz8cRB+OaB90zXYP5xm9ff7QGcZnoD/8ZF2wP5InyTno3XuNOjLFwP7QSaLDr0iZgA
 LvA5Vz+yTvfXeIFwYks+CmBxwG4qp0KKzpgcGVduf8V9UBhjITXfJ014T0eXBqSoNyU/H1GbWIS
 Q8vYbiKNSpnmrPmSPwAYfHkVJUujkKRUo8qdbVtRuo9w+7qfbBeQci+quKHWLajxuCBJhqboFea
 qq+Y3ZAHrscn6Y++NI0YlxxAIuojDnU8LYhuHZku5B7Bn+NxLwM6ZcHgpQlTw97UmsC+h/mIyD+
 gIGXSASEVM0zvZNqcPrjR05cH4tQ6w5MRFXtrLXrYnVF/jK5p4ynR17uveToNy5HQFZOrHW1q8n
 iyYdayr4SNF6tVQWsK1asEjJFpDJixAfDEUCD3Bg4PZLIAidnd9QoImOoZCI+WJI0EnogV1OEDE
 Aeznv2xfy7NdTzA==
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

FF-A notifications are optional feature in the specification. Currently
we allow to continue if the firmware reports no support for the
notifications. However, we fail to continue and complete the FF-A
driver initialisation if the notification setup fails for any reason.

Let us allow the FF-A driver to complete the initialisation even if the
notification fails to setup. We will just flag the error and continue
to provide other features in the driver.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 07b72c679247..b4ba52d674e5 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1390,20 +1390,20 @@ static void ffa_notifications_cleanup(void)
 	}
 }
 
-static int ffa_notifications_setup(void)
+static void ffa_notifications_setup(void)
 {
 	int ret, irq;
 
 	ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
 	if (ret) {
-		pr_err("Notifications not supported, continuing with it ..\n");
-		return 0;
+		pr_info("Notifications not supported, continuing with it ..\n");
+		return;
 	}
 
 	ret = ffa_notification_bitmap_create();
 	if (ret) {
-		pr_err("notification_bitmap_create error %d\n", ret);
-		return ret;
+		pr_info("Notification bitmap create error %d\n", ret);
+		return;
 	}
 	drv_info->bitmap_created = true;
 
@@ -1426,10 +1426,11 @@ static int ffa_notifications_setup(void)
 	ret = ffa_sched_recv_cb_update(drv_info->vm_id, ffa_self_notif_handle,
 				       drv_info, true);
 	if (!ret)
-		return ret;
+		return;
 cleanup:
+	pr_info("Notification setup failed %d, not enabled\n", ret);
 	ffa_notifications_cleanup();
-	return ret;
+	return;
 }
 
 static int __init ffa_init(void)
@@ -1487,13 +1488,9 @@ static int __init ffa_init(void)
 
 	ffa_set_up_mem_ops_native_flag();
 
-	ret = ffa_notifications_setup();
-	if (ret)
-		goto partitions_cleanup;
+	ffa_notifications_setup();
 
 	return 0;
-partitions_cleanup:
-	ffa_partitions_cleanup();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);

-- 
2.42.0

