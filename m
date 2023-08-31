Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9111878E998
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjHaJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjHaJi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0E1A1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693474687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pIHkr0l2kEulrVce5uaSBSAoxxMZwAnZ1GdIhmQZ2hI=;
        b=FcR1owKotFeRyO5im98NG/LGG/8jlwxlG0mUOxymKDoETPHo3+fDsrTb3holqqpLc9qAgD
        fx/ghmOEWmMqmvDnnrQk6MLdyOGxqGVuavx2CIvQFv8n2PGDfUtiYXVbFJDRiQ+OHbjEAb
        aGEV1BXu7C0M0eaV1aHVlGbersNhL84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-LnRHs2JGOduXWRKhYf_VWg-1; Thu, 31 Aug 2023 05:38:02 -0400
X-MC-Unique: LnRHs2JGOduXWRKhYf_VWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84D7985CBE0;
        Thu, 31 Aug 2023 09:38:00 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F65C1121315;
        Thu, 31 Aug 2023 09:37:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH V4] lib/group_cpus.c: avoid to acquire cpu hotplug lock in group_cpus_evenly
Date:   Thu, 31 Aug 2023 17:37:54 +0800
Message-Id: <20230831093754.2322955-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

group_cpus_evenly() could be part of storage driver's error handler,
such as nvme driver, when may happen during CPU hotplug, in which
storage queue has to drain its pending IOs because all CPUs associated
with the queue are offline and the queue is becoming inactive. And
handling IO needs error handler to provide forward progress.

Then dead lock is caused:

1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
handler is waiting for inflight IO

2) error handler is waiting for CPU hotplug lock

3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
error handling can't provide forward progress.

Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
in which two stage spreads are taken: 1) the 1st stage is over all present
CPUs; 2) the end stage is over all other CPUs.

Turns out the two stage spread just needs consistent 'cpu_present_mask', and
remove the CPU hotplug lock by storing it into one local cache. This way
doesn't change correctness, because all CPUs are still covered.

Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Reported-by: Guangwu Zhang <guazhang@redhat.com>
Tested-by: Guangwu Zhang <guazhang@redhat.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V4:
	- annotate lockess read of cpu_present_mask with data_race()
	- document why lockless read of cpu_present_mask is correct for
	group_cpus_evenly, as suggested by Thomas
	
V3:
	- reuse `npresmsk`, and avoid to allocate new variable, suggested by
	Chengming Zhou

V2:
	- fix "Cc: block list"
	- add tested-by tag


 lib/group_cpus.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index aa3f6815bb12..ee272c4cefcc 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -366,13 +366,25 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	if (!masks)
 		goto fail_node_to_cpumask;
 
-	/* Stabilize the cpumasks */
-	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
+	/*
+	 * Make a local cache of 'cpu_present_mask', so the two stages
+	 * spread can observe consistent 'cpu_present_mask' without holding
+	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
+	 * hotplug code.
+	 *
+	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
+	 * we can live with the case because it only affects that hotplug
+	 * CPU is handled in the 1st or 2nd stage, and either way is correct
+	 * from API user viewpoint since 2-stage spread is sort of
+	 * optimization.
+	 */
+	cpumask_copy(npresmsk, data_race(cpu_present_mask));
+
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  cpu_present_mask, nmsk, masks);
+				  npresmsk, nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
 	nr_present = ret;
@@ -387,15 +399,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
 				  npresmsk, nmsk, masks);
 	if (ret >= 0)
 		nr_others = ret;
 
  fail_build_affinity:
-	cpus_read_unlock();
-
 	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numgrps);
 
-- 
2.40.1

