Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260F775D965
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGVDSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVDSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252F03A9C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689995863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0uW4VHgKV+Lqk0wGj2Kld/LW6LChZPKDcy+khsmFX/c=;
        b=TTbdomkbmAGMuYeSn12K2JvROlXP9ZDFJC20jC3OuHLL9OqDMwj1L2veume5WiT/BgrIDM
        WBclYLnq09QcrOYnX7mcpapCVaUPdYEJ+1VXMSmhhjwUoc8s1CMCBCzzozX/c/Z8BUfP5O
        mbLo6sqNRy9BCYItYYQ7KsVN8NN3k+o=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-ds7PrvWIO_iOLDwToedKAA-1; Fri, 21 Jul 2023 23:17:40 -0400
X-MC-Unique: ds7PrvWIO_iOLDwToedKAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24EBE3C0D183;
        Sat, 22 Jul 2023 03:17:40 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEE77200A7CA;
        Sat, 22 Jul 2023 03:17:39 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3] perf/arm-dmc620: Fix dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Date:   Fri, 21 Jul 2023 23:17:28 -0400
Message-Id: <20230722031729.3913953-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

This locking order happens when dmc620_pmu_get_irq() is called from
dmc620_pmu_device_probe(). Since dmc620_pmu_irqs_lock is used for
protecting the dmc620_pmu_irqs structure only, we don't actually need
to hold the lock when adding a new instance to the CPU hotplug subsystem.

Fix this possible deadlock scenario by releasing the lock before
calling cpuhp_state_add_instance_nocalls() and reacquiring it afterward.
To avoid the possibility of 2 racing dmc620_pmu_get_irq() calls inserting
duplicated dmc620_pmu_irq structures with the same irq number, a dummy
entry is inserted before releasing the lock which will block a competing
thread from inserting another irq structure of the same irq number.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/perf/arm_dmc620_pmu.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 9d0f01c4455a..7cafd4dd4522 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -76,6 +76,7 @@ struct dmc620_pmu_irq {
 	refcount_t refcount;
 	unsigned int irq_num;
 	unsigned int cpu;
+	unsigned int valid;
 };
 
 struct dmc620_pmu {
@@ -423,9 +424,14 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
 	struct dmc620_pmu_irq *irq;
 	int ret;
 
-	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
-		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
+	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node) {
+		if (irq->irq_num != irq_num)
+			continue;
+		if (!irq->valid)
+			return ERR_PTR(-EAGAIN);	/* Try again later */
+		if (refcount_inc_not_zero(&irq->refcount))
 			return irq;
+	}
 
 	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
 	if (!irq)
@@ -447,13 +453,23 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
 	if (ret)
 		goto out_free_irq;
 
-	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
-	if (ret)
-		goto out_free_irq;
-
 	irq->irq_num = irq_num;
 	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
 
+	/*
+	 * Release dmc620_pmu_irqs_lock before calling
+	 * cpuhp_state_add_instance_nocalls() and reacquire it afterward.
+	 */
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
+	mutex_lock(&dmc620_pmu_irqs_lock);
+
+	if (ret) {
+		list_del(&irq->irqs_node);
+		goto out_free_irq;
+	}
+
+	irq->valid = true;
 	return irq;
 
 out_free_irq:
-- 
2.31.1

