Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718AF813365
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573539AbjLNOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjLNOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:42:20 -0500
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B410F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=jqR1PdpxUe277eWAS5cvqpQThpJfFkZiLbIzwxpvjek=; b=NXTQcpriBuGC
        aIOUskXuamralQFLA9YtboOEW736Fgcj65KZgLC/l33D9ZjAih+o7ZqQZqMNOswWPwKNJ7oEaQs8x
        H1v4XpnQ6ytCy7eCzwTwKXYR9Wtpxqw9AoXn/UI6FVxGIwwpXPdAQOq6CyY+TdHN8BLQY+kKtMAmc
        Qb6I5p0K61MLq0oQY8yCH/AqmPqTCVtpeoJPMgg+ZRh7gheCI1l+xS1KnvmYGsiNY1U/+hr79iBrv
        6syD4DhJkcguuckWtt7Ti8xYcK0+oDFrPxFAS5dc7upJFmQPit0BHFHD2Ljae1k0x3ppY57WpdSaj
        vr1XTkdMLpOqvS9JTsQ+VA==;
Received: from [130.117.225.1] (helo=finist-alma9.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.96)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1rDmsh-001CPb-0g;
        Thu, 14 Dec 2023 15:42:04 +0100
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Do not scan non-movable tasks several times
Date:   Thu, 14 Dec 2023 17:42:04 +0300
Message-Id: <20231214144204.2179345-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK and all
tasks are not movable, detach_tasks() should not iterate more than tasks
available in the busiest rq.

Previously the (env->loop > env->loop_max) condition prevented us from
scanning non-movable tasks more than rq size times, but after we start
checking the LBF_ALL_PINNED flag, the "all tasks are not movable" case
is under threat.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..faa2a765e899 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11219,7 +11219,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.dst_rq		= this_rq,
 		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
-		.loop_break	= SCHED_NR_MIGRATE_BREAK,
 		.cpus		= cpus,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
@@ -11265,6 +11264,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * correctly treated as an imbalance.
 		 */
 		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
+		/*
+		 * If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK
+		 * and all tasks are not movable, detach_tasks() should not
+		 * iterate more than tasks available in rq.
+		 */
+		env.loop_break = min(SCHED_NR_MIGRATE_BREAK, busiest->nr_running);
 
 more_balance:
 		rq_lock_irqsave(busiest, &rf);
-- 
2.39.3

