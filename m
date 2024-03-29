Return-Path: <linux-kernel+bounces-125544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C728927FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549511F224D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77EF13E8BC;
	Fri, 29 Mar 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0R6NEFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28413E895
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756726; cv=none; b=aGuvIV3fldei8iu8jscqatCp5NrcHEyTdu5jIc+83iBSyGIkG6BQIj1WsBF3sc8s9gVVdKvI7wY/l/sqIe+6uTodFUBcccfruJzhF6CQf/D89a12XMjAMkDiTxJkiP6SlILFoMB0eNXEpoJMU/iXqMUszT5fZ3+ECiAgD6Anm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756726; c=relaxed/simple;
	bh=leWar64/qGvuiTJiHqRj1593VB59JAei213MN3XaVAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3OexwQxWwR8ioXwqjHKdtJl2dFbH18wz+fYSWWPaWZ67r2jCAJoWT9+ZvAB7uU1W3ywOyJDb/13GToj7xmLfIJ7Fp+15D9MDY1Yi25/Ing9rdK2JvIf0a+iKF6uiX5wLT+iFCwwwn+S5It46pFhMAT3HeOSjsj32pS8gcO03qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0R6NEFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA34C43394;
	Fri, 29 Mar 2024 23:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711756725;
	bh=leWar64/qGvuiTJiHqRj1593VB59JAei213MN3XaVAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0R6NEFu+sVSytMxL/aGko019dWB+IpyKhvcsyhy6u888IV5cNz7AEUdcDbVt4+0V
	 poMdJvOb5448A1n/SYQ3/XYgI8WhLSrIkJrynCob9eWWvD6Mw5EqBFH5GFU7W8qM7A
	 IQQmLiA+AJ1ZC420BmTRw+34jvkwt4G82ulvDxc/r/aJRK1lxFFqo0wrRODpecI4w7
	 ZxcYPXC4AzI7FcXr68ovbqmE0G4adlkgrwc+5PIqdMAKmBaQsx051H+61fMSDGcJY8
	 ZUBS6v884uBI0k10NZJK9uy46L90/ct6glVL8dyHUhu7VJXAZNU9nEdxGU7m/42RV7
	 IYdr5qWMDCcZw==
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
Subject: [PATCH 2/4] task_work: Introduce task_work_cancel() again
Date: Sat, 30 Mar 2024 00:58:10 +0100
Message-ID: <20240329235812.18917-3-frederic@kernel.org>
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

Re-introduce task_work_cancel(), this time to cancel an actual callback
and not *any* callback pointing to a given function. This is going to be
needed for perf events event freeing.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/task_work.h |  1 +
 kernel/task_work.c        | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 89ee2cbf044b..58e42ef59580 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -37,6 +37,7 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
 struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
+bool task_work_cancel(struct task_struct *, struct callback_head *twork);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index c1b4d3ba2590..9e85ac7632ae 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -136,6 +136,30 @@ task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
 
+static bool task_work_match(struct callback_head *cb, void *data)
+{
+	return cb == data;
+}
+
+/**
+ * task_work_cancel - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @func: the work to remove if queued
+ *
+ * Remove a callback from a task's queue if queued.
+ *
+ * RETURNS:
+ * True if the callback was queued and got cancelled, false otherwise.
+ */
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
+{
+	struct callback_head *ret;
+
+	ret = task_work_cancel_match(task, task_work_match, cb);
+
+	return ret == cb;
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *
-- 
2.44.0


