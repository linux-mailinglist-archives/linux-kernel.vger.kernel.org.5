Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE2777C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjHJPmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjHJPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D57A2705
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691682085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=atSIShNb1k5EouTCC7gYCjFuXMvvzMrZitLjweZI368=;
        b=LelDGHSVtkS5s2qK7y7AvYpWMPbmNyvCiqyrPM62d77O6z+N0Y5VE5CCfMht4JlI9Dc6P+
        NpkcsaGX8Vozi4JeYydpkT5TtrmQXx86NOMDGEnn0P9+0kTit4uc4lHevTrfPvgGt0LcXF
        iPoA1zErY1ye1z7JQNWfRLkPeRKgWu0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-qUnfye_xObiUAg9FNFPnAg-1; Thu, 10 Aug 2023 11:41:24 -0400
X-MC-Unique: qUnfye_xObiUAg9FNFPnAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AFCB381C16D;
        Thu, 10 Aug 2023 15:41:22 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F33B72026D4B;
        Thu, 10 Aug 2023 15:41:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5] perf/arm-dmc620: Fix dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Date:   Thu, 10 Aug 2023 11:41:14 -0400
Message-Id: <20230810154114.405742-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
for protecting the dmc620_pmu_irqs structure, we don't actually need
to hold the lock when adding a new instance to the CPU hotplug subsystem.

Fix this possible deadlock scenario by adding a new dmc620_pmu_get_lock
for protecting the call to __dmc620_pmu_get_irq(). While at it, rename
dmc620_pmu_irqs_lock to dmc620_pmu_list_lock as it is now just protecting
the iteration and modification of pmus_node and irqs_node lists.

As a result, cpuhp_state_add_instance_nocalls() won't be called with
reanemd dmc620_pmu_list_lock held and cpu_hotplug_lock won't be acquired
after dmc620_pmu_list_lock.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/perf/arm_dmc620_pmu.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 9d0f01c4455a..a5bfc8f2e6ab 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -66,8 +66,14 @@
 #define DMC620_PMU_COUNTERn_OFFSET(n) \
 	(DMC620_PMU_COUNTERS_BASE + 0x28 * (n))
 
+/*
+ * The allowable lock ordering is:
+ * - dmc620_pmu_get_lock (protects call to __dmc620_pmu_get_irq())
+ * - dmc620_pmu_list_lock (protects pmus_node & irqs_node lists)
+ */
+static DEFINE_MUTEX(dmc620_pmu_get_lock);
+static DEFINE_MUTEX(dmc620_pmu_list_lock);
 static LIST_HEAD(dmc620_pmu_irqs);
-static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
 
 struct dmc620_pmu_irq {
 	struct hlist_node node;
@@ -423,9 +429,11 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
 	struct dmc620_pmu_irq *irq;
 	int ret;
 
+	mutex_lock(&dmc620_pmu_list_lock);
 	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
 		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
-			return irq;
+			goto unlock_out;
+	mutex_unlock(&dmc620_pmu_list_lock);
 
 	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
 	if (!irq)
@@ -452,8 +460,10 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
 		goto out_free_irq;
 
 	irq->irq_num = irq_num;
+	mutex_lock(&dmc620_pmu_list_lock);
 	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
-
+unlock_out:
+	mutex_unlock(&dmc620_pmu_list_lock);
 	return irq;
 
 out_free_irq:
@@ -467,17 +477,17 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
 {
 	struct dmc620_pmu_irq *irq;
 
-	mutex_lock(&dmc620_pmu_irqs_lock);
+	mutex_lock(&dmc620_pmu_get_lock);
 	irq = __dmc620_pmu_get_irq(irq_num);
-	mutex_unlock(&dmc620_pmu_irqs_lock);
+	mutex_unlock(&dmc620_pmu_get_lock);
 
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
 
 	dmc620_pmu->irq = irq;
-	mutex_lock(&dmc620_pmu_irqs_lock);
+	mutex_lock(&dmc620_pmu_list_lock);
 	list_add_rcu(&dmc620_pmu->pmus_node, &irq->pmus_node);
-	mutex_unlock(&dmc620_pmu_irqs_lock);
+	mutex_unlock(&dmc620_pmu_list_lock);
 
 	return 0;
 }
@@ -486,16 +496,16 @@ static void dmc620_pmu_put_irq(struct dmc620_pmu *dmc620_pmu)
 {
 	struct dmc620_pmu_irq *irq = dmc620_pmu->irq;
 
-	mutex_lock(&dmc620_pmu_irqs_lock);
+	mutex_lock(&dmc620_pmu_list_lock);
 	list_del_rcu(&dmc620_pmu->pmus_node);
 
 	if (!refcount_dec_and_test(&irq->refcount)) {
-		mutex_unlock(&dmc620_pmu_irqs_lock);
+		mutex_unlock(&dmc620_pmu_list_lock);
 		return;
 	}
 
 	list_del(&irq->irqs_node);
-	mutex_unlock(&dmc620_pmu_irqs_lock);
+	mutex_unlock(&dmc620_pmu_list_lock);
 
 	free_irq(irq->irq_num, irq);
 	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &irq->node);
@@ -638,10 +648,10 @@ static int dmc620_pmu_cpu_teardown(unsigned int cpu,
 		return 0;
 
 	/* We're only reading, but this isn't the place to be involving RCU */
-	mutex_lock(&dmc620_pmu_irqs_lock);
+	mutex_lock(&dmc620_pmu_list_lock);
 	list_for_each_entry(dmc620_pmu, &irq->pmus_node, pmus_node)
 		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
-	mutex_unlock(&dmc620_pmu_irqs_lock);
+	mutex_unlock(&dmc620_pmu_list_lock);
 
 	WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
 	irq->cpu = target;
-- 
2.31.1

