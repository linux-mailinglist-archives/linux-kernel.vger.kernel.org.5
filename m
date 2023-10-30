Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACF17DBC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjJ3Owd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjJ3Owb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83826C2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698677502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iZM5Ir1agMVPmsp/0h/z8SE5MvN1kGhnLqtdaxL5v4U=;
        b=UrNZkCfc99nrG6JWraMNbIgCnD2ZOfrDTgdal9GkGb7lbEqCs/qGmARn9osFqTfNcCfoaz
        W8OINYUvt20JW9JlkuuMmUnGPOwn5ZL6BH8+A9jRrGKdgkMV7YEfmqmqJVMlQdNnSiZ6eU
        DKPUcJZYgtY9iHojQzHSGLXYs80cuhg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-ZvuMTU3_O-aBrCNMZjNOXQ-1; Mon,
 30 Oct 2023 10:51:32 -0400
X-MC-Unique: ZvuMTU3_O-aBrCNMZjNOXQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61BD61C01B2C;
        Mon, 30 Oct 2023 14:51:31 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EA81492BE0;
        Mon, 30 Oct 2023 14:51:28 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] sched/fair: Make the BW replenish timer expire in hardirq context for PREEMPT_RT
Date:   Mon, 30 Oct 2023 15:51:04 +0100
Message-ID: <20231030145104.4107573-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following scenario under PREEMPT_RT:
o A CFS task p0 gets throttled while holding read_lock(&lock)
o A task p1 blocks on write_lock(&lock), making further readers enter the
  slowpath
o A ktimers or ksoftirqd task blocks on read_lock(&lock)

If the cfs_bandwidth.period_timer to replenish p0's runtime is enqueued on
the same CPU as one where ktimers/ksoftirqd is blocked on read_lock(&lock),
this creates a circular dependency.

This has been observed to happen with:
o fs/eventpoll.c::ep->lock
o net/netlink/af_netlink.c::nl_table_lock (after hand-fixing the above)
but can trigger with any rwlock that can be acquired in both process and
softirq contexts.

The linux-rt tree has had
  1ea50f9636f0 ("softirq: Use a dedicated thread for timer wakeups.")
which helped this scenario for non-rwlock locks by ensuring the throttled
task would get PI'd to FIFO1 (ktimers' default priority). Unfortunately,
rwlocks cannot sanely do PI as they allow multiple readers.

Make the period_timer expire in hardirq context under PREEMPT_RT. The
callback for this timer can end up doing a lot of work, but this is
mitigated somewhat when using nohz_full / CPU isolation: the timers *are*
pinned, but on the CPUs the taskgroups are created on, which is usually
going to be HK CPUs.

Link: https://lore.kernel.org/all/xhsmhttqvnall.mognet@vschneid.remote.csb/
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8767988242ee3..15cf7de865a97 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6236,7 +6236,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *paren
 	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
 
 	/* Add a random offset so that timers interleave */
@@ -6263,7 +6263,7 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	cfs_b->period_active = 1;
 	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
-	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
-- 
2.41.0

