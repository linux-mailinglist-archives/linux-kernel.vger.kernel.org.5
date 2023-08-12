Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206C77A442
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 01:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjHLX4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 19:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHLX4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 19:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87935120
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691884558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cGh7zid5ZGwPKAdnl7BrC00lAfOv/xMnB8BBHpPER64=;
        b=ZiWQlVEwCYtAQ7S3ocl5AldigE0zcc7L8Jh6n0MN3913bHW0SrFhZJWOrNbeD+tTaRO+Y3
        4EEZlJjV0MULwHh+CME90tuAWUYB4bjEjAsUJt5DPH5+MIWNdi27we44nZ37gxklJ6+MGr
        HEtPWvPg3G0FEV1rIiV3RtPI7XFbUso=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-oTyg707rMKqvdk8bVac-Xg-1; Sat, 12 Aug 2023 19:55:55 -0400
X-MC-Unique: oTyg707rMKqvdk8bVac-Xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFCBD3C025B1;
        Sat, 12 Aug 2023 23:55:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61CFD63F6D;
        Sat, 12 Aug 2023 23:55:54 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6] perf/arm-dmc620: Fix dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Date:   Sat, 12 Aug 2023 19:55:49 -0400
Message-Id: <20230812235549.494174-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

The following locking order happens when dmc620_pmu_get_irq() calls
cpuhp_state_add_instance_nocalls().

	lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)

On the other hand, the calling sequence

  cpuhp_thread_fun()
    => cpuhp_invoke_callback()
      => dmc620_pmu_cpu_teardown()

leads to the locking sequence

	lock(cpuhp_state-down) => lock(dmc620_pmu_irqs_lock)

Here dmc620_pmu_irqs_lock protects both the dmc620_pmu_irqs and the
pmus_node lists in various dmc620_pmu instances. dmc620_pmu_get_irq()
requires protected access to dmc620_pmu_irqs whereas
dmc620_pmu_cpu_teardown() needs protection to the pmus_node lists.
Break this circular locking dependency by using two separate locks to
protect dmc620_pmu_irqs list and the pmus_node lists respectively.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/perf/arm_dmc620_pmu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 9d0f01c4455a..30cea6859574 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -66,8 +66,13 @@
 #define DMC620_PMU_COUNTERn_OFFSET(n) \
 	(DMC620_PMU_COUNTERS_BASE + 0x28 * (n))
 
-static LIST_HEAD(dmc620_pmu_irqs);
+/*
+ * dmc620_pmu_irqs_lock: protects dmc620_pmu_irqs list
+ * dmc620_pmu_node_lock: protects pmus_node lists in all dmc620_pmu instances
+ */
 static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
+static DEFINE_MUTEX(dmc620_pmu_node_lock);
+static LIST_HEAD(dmc620_pmu_irqs);
 
 struct dmc620_pmu_irq {
 	struct hlist_node node;
@@ -475,9 +480,9 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
 		return PTR_ERR(irq);
 
 	dmc620_pmu->irq = irq;
-	mutex_lock(&dmc620_pmu_irqs_lock);
+	mutex_lock(&dmc620_pmu_node_lock);
 	list_add_rcu(&dmc620_pmu->pmus_node, &irq->pmus_node);
-	mutex_unlock(&dmc620_pmu_irqs_lock);
+	mutex_unlock(&dmc620_pmu_node_lock);
 
 	return 0;
 }
@@ -486,9 +491,11 @@ static void dmc620_pmu_put_irq(struct dmc620_pmu *dmc620_pmu)
 {
 	struct dmc620_pmu_irq *irq = dmc620_pmu->irq;
 
-	mutex_lock(&dmc620_pmu_irqs_lock);
+	mutex_lock(&dmc620_pmu_node_lock);
 	list_del_rcu(&dmc620_pmu->pmus_node);
+	mutex_unlock(&dmc620_pmu_node_lock);
 
+	mutex_lock(&dmc620_pmu_irqs_lock);
 	if (!refcount_dec_and_test(&irq->refcount)) {
 		mutex_unlock(&dmc620_pmu_irqs_lock);
 		return;
@@ -638,10 +645,10 @@ static int dmc620_pmu_cpu_teardown(unsigned int cpu,
 		return 0;
 
 	/* We're only reading, but this isn't the place to be involving RCU */
-	mutex_lock(&dmc620_pmu_irqs_lock);
+	mutex_lock(&dmc620_pmu_node_lock);
 	list_for_each_entry(dmc620_pmu, &irq->pmus_node, pmus_node)
 		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
-	mutex_unlock(&dmc620_pmu_irqs_lock);
+	mutex_unlock(&dmc620_pmu_node_lock);
 
 	WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
 	irq->cpu = target;
-- 
2.31.1

