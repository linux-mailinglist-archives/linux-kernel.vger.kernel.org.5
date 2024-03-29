Return-Path: <linux-kernel+bounces-125543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E6D8927FD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA77283F53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD413E6DB;
	Fri, 29 Mar 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLMiWGGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C2196
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756723; cv=none; b=mMUKxgrhfsgjg1qgNuyMDoxSspBv6uWBHXl4O7VHiNI4vOv3PoOmlyz2UwHdpY8FWV3BRuHhmPRr8CwxEdEf88eYCSFVZxGN3i2iQ8lrxEuC1mzWD4+eZw8wRfychA55FN592lXMU+9OsNKvx0DoBA0xUtpAe5m46fgWlBMrZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756723; c=relaxed/simple;
	bh=a8ZIwcOzFWpAazFJq80nYQpJgGvoSiKotzpuXLRiwFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef5h4xjq9TeVEFlQ8/8NCv3NJtuyIViCcFwqxZhAaTRsa4HeYtRrLhAMWXdrKpp4Ej0Yqd/cwFuwXKmlCxgN6Mk5nVT0hj8mB1UVjTvqyIRXZKL7wAyg2dFvbAIjkS08DMGdFcKPNuaOd5WPr5WqbUZgMyf0IBuUQu6Wb40cFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLMiWGGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EC4C433A6;
	Fri, 29 Mar 2024 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711756722;
	bh=a8ZIwcOzFWpAazFJq80nYQpJgGvoSiKotzpuXLRiwFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLMiWGGDt8GGp9SAk0E+qPUqHo0K+TIxfNmN0U7mkjYtVOKJbuvZ6+6xidYiZsrps
	 jfn0wesESCoywGJODRx0vjSdS7LshuewgW0DAGyUtO1MclzQ9Rhrpjns66r1jH44QS
	 A/+VLV966VfjOXt061IaoHt/ioQ/TxBo4myxEA05KBvvI+EPhfUN+xXGtngOFFxe+I
	 lnj72Dqdglpw+CwLe7MV4ljUFVRqvv8xncQXer6pPFpVLJOa9d1DPrZm/Clmqa9uaQ
	 w5JCVvXmz3l7sXMz10wxwbA942qYKXXaTJe2P5BDOxZQQePW9ff40piqYooenbIfBx
	 3UQWooTDwcTFw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] task_work: s/task_work_cancel()/task_work_cancel_func()/
Date: Sat, 30 Mar 2024 00:58:09 +0100
Message-ID: <20240329235812.18917-2-frederic@kernel.org>
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

A proper task_work_cancel() API that actually cancels a callback and not
*any* callback pointing to a given function is going to be needed for
perf events event freeing. Do the appropriate rename to prepare for
that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/task_work.h |  2 +-
 kernel/irq/manage.c       |  2 +-
 kernel/task_work.c        | 10 +++++-----
 security/keys/keyctl.c    |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 3564172dbc27..89ee2cbf044b 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -36,7 +36,7 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
-struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
+struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ad3eaf2ab959..2464e98879f3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1333,7 +1333,7 @@ static int irq_thread(void *data)
 	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
-	task_work_cancel(current, irq_thread_dtor);
+	task_work_cancel_func(current, irq_thread_dtor);
 	return 0;
 }
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index d283f603d916..c1b4d3ba2590 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -120,9 +120,9 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
 }
 
 /**
- * task_work_cancel - cancel a pending work added by task_work_add()
- * @task: the task which should execute the work
- * @func: identifies the work to remove
+ * task_work_cancel_func - cancel a pending work matching a function added by task_work_add()
+ * @task: the task which should execute the func's work
+ * @func: identifies the func to match with a work to remove
  *
  * Find the last queued pending work with ->func == @func and remove
  * it from queue.
@@ -131,7 +131,7 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
  * The found work or NULL if not found.
  */
 struct callback_head *
-task_work_cancel(struct task_struct *task, task_work_func_t func)
+task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 {
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
@@ -168,7 +168,7 @@ void task_work_run(void)
 		if (!work)
 			break;
 		/*
-		 * Synchronize with task_work_cancel(). It can not remove
+		 * Synchronize with task_work_cancel_match(). It can not remove
 		 * the first entry == work, cmpxchg(task_works) must fail.
 		 * But it can remove another entry from the ->next list.
 		 */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 10ba439968f7..3aff32a2bcf3 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1693,7 +1693,7 @@ long keyctl_session_to_parent(void)
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
-	oldwork = task_work_cancel(parent, key_change_session_keyring);
+	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
-- 
2.44.0


