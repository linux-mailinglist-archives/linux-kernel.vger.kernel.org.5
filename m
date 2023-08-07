Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253387729B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjHGPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHGPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617EE212E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691423105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7w4UuYP3MJszw+7GPKE+QIfdQPV+qBZTD63Uc3XzFSQ=;
        b=fzKwL2p4bD+RlKHoAxPcgicvpUbsPCKneCJsTlrHY/NCaBXbYEVPdB8KnLKqjMtEb2AxzP
        nhTbO+GYHr7m0lTc+YZqffNHMyv+we/eImFuvxA1HeRntB5SU8K6yu9ePds9hMnaa/hGqy
        XYsPwG2YOzpRQtrWAak2mR1aOy+KalM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-zlU_T_61PsaDCEfqc8eR-Q-1; Mon, 07 Aug 2023 11:45:00 -0400
X-MC-Unique: zlU_T_61PsaDCEfqc8eR-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21DDA3811F2C;
        Mon,  7 Aug 2023 15:44:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 028472026D4B;
        Mon,  7 Aug 2023 15:44:57 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4] perf/arm-dmc620: Fix dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Date:   Mon,  7 Aug 2023 11:44:46 -0400
Message-Id: <20230807154446.208572-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following circular locking dependency was reported when running
cpus online/offline test on an arm64 system.

[   84.195923] Chain exists of:
                 dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> cpuhp_state-down

[   84.207305]  Possible unsafe locking scenario:

[   84.213212]        CPU0                    CPU1
[   84.217729]        ----                    ----
[   84.222247]   lock(cpuhp_state-down);
[   84.225899]                                lock(cpu_hotplug_lock);
[   84.232068]                                lock(cpuhp_state-down);
[   84.238237]   lock(dmc620_pmu_irqs_lock);
[   84.242236]
                *** DEADLOCK ***

The problematic locking order seems to be

	lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)

This locking order happens when dmc620_pmu_get_irq() calls
cpuhp_state_add_instance_nocalls(). Since dmc620_pmu_irqs_lock is used
for protecting the dmc620_pmu_irqs structure only, we don't actually need
to hold the lock when adding a new instance to the CPU hotplug subsystem.

Fix this possible deadlock scenario by adding a new
dmc620_pmu_get_irq_lock for protecting the call to __dmc620_pmu_get_irq()
and taking dmc620_pmu_irqs_lock inside __dmc620_pmu_get_irq()
only when dmc620_pmu_irqs is being searched or modified. As a
result, cpuhp_state_add_instance_nocalls() won't be called with
dmc620_pmu_irqs_lock held and cpu_hotplug_lock won't be acquired after
dmc620_pmu_irqs_lock.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/perf/arm_dmc620_pmu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 9d0f01c4455a..895971915f2d 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -68,6 +68,7 @@
 
 static LIST_HEAD(dmc620_pmu_irqs);
 static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
+static DEFINE_MUTEX(dmc620_pmu_get_irq_lock);
 
 struct dmc620_pmu_irq {
 	struct hlist_node node;
@@ -421,11 +422,18 @@ static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
 static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
 {
 	struct dmc620_pmu_irq *irq;
+	bool found = false;
 	int ret;
 
+	mutex_lock(&dmc620_pmu_irqs_lock);
 	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
-		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
-			return irq;
+		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount)) {
+			found = true;
+			break;
+		}
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+	if (found)
+		return irq;
 
 	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
 	if (!irq)
@@ -452,7 +460,9 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
 		goto out_free_irq;
 
 	irq->irq_num = irq_num;
+	mutex_lock(&dmc620_pmu_irqs_lock);
 	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
 
 	return irq;
 
@@ -467,9 +477,9 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
 {
 	struct dmc620_pmu_irq *irq;
 
-	mutex_lock(&dmc620_pmu_irqs_lock);
+	mutex_lock(&dmc620_pmu_get_irq_lock);
 	irq = __dmc620_pmu_get_irq(irq_num);
-	mutex_unlock(&dmc620_pmu_irqs_lock);
+	mutex_unlock(&dmc620_pmu_get_irq_lock);
 
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
-- 
2.31.1

