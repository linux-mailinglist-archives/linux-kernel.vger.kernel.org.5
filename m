Return-Path: <linux-kernel+bounces-125546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63860892800
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE1283E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BF13F456;
	Fri, 29 Mar 2024 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6HR25eo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5B13F446
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756731; cv=none; b=LY/nKBsux+/qzsncPDbscqatpoYaBomRjBQyqUiimZoMxl4n0nj/JcNdUM8mU6Y8dAamROOh8IeqNaXLcHBKm3cb9vD1a18axlw3OrEte34drlXscb1RxjesnSKYhoAJ/qifJXOEV1uJwXdpY8K9HZzZbx57+mwI3jlKK06kGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756731; c=relaxed/simple;
	bh=GmB2wTQS4lTN4x1DBM9671s8jAtPbaalNinvZ1OGbQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN5RPzWb0BYdE0+ntjUU4dSrmFHUov2NhSmRRJRdmn8gJE1XN/6BgHxZDyFqc4Xhf5eFZ1yJCUWuLRqKP3+9v8r6prO3ch0Z/OsvAOGw+ORAb3MWuKrCDGRCQJV9ZBgBGRvVHK4gIBN/y7sK5U4jZbociB6Xs555cSR6wje1Yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6HR25eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD650C433A6;
	Fri, 29 Mar 2024 23:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711756731;
	bh=GmB2wTQS4lTN4x1DBM9671s8jAtPbaalNinvZ1OGbQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6HR25eo1eOGai9gNwTe9QF6SBpR/4G4XgXEhXUmniRnlGCSCDAbDUNdfZyqKj3h+
	 k8PirAMVjA1LMBmgeoXnQ+KU+zMUN7UJ1vDNF1T/9xY3KT618Fu/MRydTQFdCrH0R7
	 BgGBWwKAOk1oxBbSAYqKkX8GFHu3duigfZ4foOyjpYWGXXRoqA56G/wBSWLky8ZIdd
	 sH7BWt9iPbMYgRj2IvIblWxsRrvmwGJcNuST8XVa35S7WxdUWcXW0e3k52lPc0WELa
	 Po4uyTOy6JZiKVi1nCjXUeJCVzhN23CWgXTVokGHgO3prtupPxTeIhS1oT4KK/+vlu
	 HAq0zHdJmVlYQ==
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
Subject: [PATCH 4/4] perf: Fix event leak upon exec and file release
Date: Sat, 30 Mar 2024 00:58:12 +0100
Message-ID: <20240329235812.18917-5-frederic@kernel.org>
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

The perf pending task work is never waited upon the matching event
release. In the case of a child event, released via free_event()
directly, this can potentially result in a leaked event, such as in the
following scenario that doesn't even require a weak IRQ work
implementation to trigger:

schedule()
   prepare_task_switch()
=======> <NMI>
      perf_event_overflow()
         event->pending_sigtrap = ...
         irq_work_queue(&event->pending_irq)
<======= </NMI>
      perf_event_task_sched_out()
          event_sched_out()
              event->pending_sigtrap = 0;
              atomic_long_inc_not_zero(&event->refcount)
              task_work_add(&event->pending_task)
   finish_lock_switch()
=======> <IRQ>
   perf_pending_irq()
      //do nothing, rely on pending task work
<======= </IRQ>

begin_new_exec()
   perf_event_exit_task()
      perf_event_exit_event()
         // If is child event
         free_event()
            WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
            // event is leaked

Similar scenarios can also happen with perf_event_remove_on_exec() or
simply against concurrent perf_event_release().

Fix this with synchonizing against the possibly remaining pending task
work while freeing the event, just like is done with remaining pending
IRQ work. This means that the pending task callback neither need nor
should hold a reference to the event, preventing it from ever beeing
freed.

Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 33 +++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..2f2e222e1003 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -786,6 +786,7 @@ struct perf_event {
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
+	wait_queue_head_t 		pending_work_wq;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c1632e69c69d..588e35848a4e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2290,7 +2290,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		if (state != PERF_EVENT_STATE_OFF &&
 		    !event->pending_work) {
 			if (task_work_add(current, &event->pending_task, TWA_RESUME) >= 0) {
-				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 				dec = false;
 				event->pending_work = 1;
 			}
@@ -5188,9 +5187,35 @@ static bool exclusive_event_installable(struct perf_event *event,
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
+static void perf_pending_task_sync(struct perf_event *event)
+{
+	struct callback_head *head = &event->pending_task;
+
+	if (!event->pending_work)
+		return;
+	/*
+	 * If the task is queued to the current task's queue, we
+	 * obviously can't wait for it to complete. Simply cancel it.
+	 */
+	if (task_work_cancel(current, head)) {
+		event->pending_work = 0;
+		local_dec(&event->ctx->nr_pending);
+		return;
+	}
+
+	/*
+	 * All accesses related to the event are within the same
+	 * non-preemptible section in perf_pending_task(). The RCU
+	 * grace period before the event is freed will make sure all
+	 * those accesses are complete by then.
+	 */
+	wait_event(event->pending_work_wq, !event->pending_work);
+}
+
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	perf_pending_task_sync(event);
 
 	unaccount_event(event);
 
@@ -6808,24 +6833,23 @@ static void perf_pending_task(struct callback_head *head)
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
 
+	preempt_disable_notrace();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
 	 */
-	preempt_disable_notrace();
 	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_pending);
+		wake_up(&event->pending_work_wq);
 	}
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 	preempt_enable_notrace();
-
-	put_event(event);
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS
@@ -11933,6 +11957,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	init_task_work(&event->pending_task, perf_pending_task);
+	init_waitqueue_head(&event->pending_work_wq);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
-- 
2.44.0


