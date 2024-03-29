Return-Path: <linux-kernel+bounces-125545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188C8927FF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1E1B231D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBB13F424;
	Fri, 29 Mar 2024 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNXj0OHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F713F01B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756728; cv=none; b=lXlVF6xVvaFU8KLAuM2wvju+RGhK9Xlp485RF6x+gDdz3D5URNIzfwRhSf3/Cnrp3rBU9NWKQgjwsD6WFhnFNQ7XEKpcHyfcBTmiiUhCjYs8GG4Mis5r6K5KJZ/jFZi+Z5MZZBK1o9OqZJL149oeEFjKSFafi15gz7OuT40pAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756728; c=relaxed/simple;
	bh=jdiXquXAPPtPajTSj3ryNiWP4Z6gOwf8+7VBRKa5ETE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRoLAycOvLeo16XTi9CUCWvcVKoKKd05G5U6PGqS8uUabaNwnAJSsQme6pW/tpaRE6lzvE5q04nR+GbNL5DTpiIC8Q6oEmdSyxVIArGTSwlRlKO8zzqRsbYpxP9jfQGZqSp4KTkshz41UHjnu6KEokRaP/mvwIqiB0K1/GlEwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNXj0OHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE78AC433B1;
	Fri, 29 Mar 2024 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711756728;
	bh=jdiXquXAPPtPajTSj3ryNiWP4Z6gOwf8+7VBRKa5ETE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNXj0OHrqHocYTHj5KYi2Dvp4W1KeU6L284QF6RtRSMRQJnDVgK+IyAc1OQyx+7uc
	 9fgQDvLn1UmxLcaPxbyEpXaYyjV/3fv3Oven2GCWjiWfyn9uflPOzqTPpt9EPdG19M
	 A70Pn5KvlNooPN1PoLiDr2UMqTxY+RAhPBoY1RHF3XoyLVtoiMN9Mg6ik1W/dnb0Ob
	 QHrKDcejZSqvPNkes92IvfsXut5youx7rMSb4c6qKAIcf+lrIeEarhEWZn56/GkLqr
	 /k+1DvDz+MQciUAvUuGEO2Gt4iFhchQJEzrhh24uB6dnFqT5wxpSqKSMjgFitKbUvA
	 mTFMg45v2mr5Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] perf: Fix event leak upon exit
Date: Sat, 30 Mar 2024 00:58:11 +0100
Message-ID: <20240329235812.18917-4-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329235812.18917-1-frederic@kernel.org>
References: <20240329235812.18917-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a task is scheduled out, pending sigtrap deliveries are deferred
to the target task upon resume to userspace via task_work.

However failures while adding en event's callback to the task_work
engine are ignored. And since the last call for events exit happen
after task work is eventually closed, there is a small window during
which pending sigtrap can be queued though ignored, leaking the event
refcount addition such as in the following scenario:

    TASK A
    -----

    do_exit()
       exit_task_work(tsk);

       <IRQ>
       perf_event_overflow()
          event->pending_sigtrap = pending_id;
          irq_work_queue(&event->pending_irq);
       </IRQ>
    =========> PREEMPTION: TASK A -> TASK B
       event_sched_out()
          event->pending_sigtrap = 0;
          atomic_long_inc_not_zero(&event->refcount)
          // FAILS: task work has exited
          task_work_add(&event->pending_task)
       [...]
       <IRQ WORK>
       perf_pending_irq()
          // early return: event->oncpu = -1
       </IRQ WORK>
       [...]
    =========> TASK B -> TASK A
       perf_event_exit_task(tsk)
          perf_event_exit_event()
             free_event()
                WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
                // leak event due to unexpected refcount == 2

As a result the event is never released while the task exits.

Fix this with appropriate task_work_add()'s error handling.

Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/events/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..c1632e69c69d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2289,10 +2289,11 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		event->pending_sigtrap = 0;
 		if (state != PERF_EVENT_STATE_OFF &&
 		    !event->pending_work) {
-			event->pending_work = 1;
-			dec = false;
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
+			if (task_work_add(current, &event->pending_task, TWA_RESUME) >= 0) {
+				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
+				dec = false;
+				event->pending_work = 1;
+			}
 		}
 		if (dec)
 			local_dec(&event->ctx->nr_pending);
-- 
2.44.0


