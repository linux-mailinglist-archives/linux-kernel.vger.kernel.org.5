Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A047F0DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjKTIgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKTIgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:36:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F6B9E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700469388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CBLqoMyIVireLlLreZE4y9YWUgoFtH3j+ZLwtIAR6bY=;
        b=HUHlzKLEfszrbruskvsw0HcBledqTaQAxNszDt+ZaAyPkPwt+ILYeigKpeMkiiYq8ehTu0
        qsgsRfeqQGaxLj1iZ7WchGAjqR0jR+t5ons/C5sfEOSjtQ2ZSsI8mPxUYephkuOqNPoROs
        tmVIlUc6TSsjlEKNHHHj8iUVfjsl00Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-W8IigMUsOXuqc3NP8N005A-1; Mon,
 20 Nov 2023 03:36:23 -0500
X-MC-Unique: W8IigMUsOXuqc3NP8N005A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90AA53C0E657;
        Mon, 20 Nov 2023 08:36:22 +0000 (UTC)
Received: from localhost (unknown [10.72.120.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BDEA40C6EB9;
        Mon, 20 Nov 2023 08:36:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug lock in group_cpus_evenly
Date:   Mon, 20 Nov 2023 16:35:59 +0800
Message-ID: <20231120083559.285174-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
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
2.41.0

