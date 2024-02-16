Return-Path: <linux-kernel+bounces-69336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D2858786
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03ACBB22C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195A145336;
	Fri, 16 Feb 2024 21:00:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA513AA56;
	Fri, 16 Feb 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117214; cv=none; b=u6tR3lj6FzIjmMIL5n4ZaaXXE4MDS4zUAIe7w9BPhsMtC3VBc6ZVJHzwy4ZnevMhZGF9prrENJyzPqOXEF4t08OhIqr1FL6PUVG7Q+tDwyrSA5/pabjV8nvScuW9iqDpX3pq4/lHGTqPjTs6tngv7WmjPcGOc2PkC7FBqd5k3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117214; c=relaxed/simple;
	bh=IvJLYtp9gt0fmSVqCctuit/Iiv1PQ8JuaI+bo/Qc3cE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JS5s3w92A/lTibTvMoDkCoFZl+8rb1X3lV6/sKkIvsoM+5DJthA6hhFKBoiuiK0D7kQ53PFSiyCKYnk5SJG9V9qRXQO0Nl7LwLAuVshnR/q2WD8GMQppBFfFlycUp2lQK6Tjiq0590GYJLUOsMrT2FVInCLRIUa28A62zjQfs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A014FC43394;
	Fri, 16 Feb 2024 21:00:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rb5LC-000000013CK-2oJd;
	Fri, 16 Feb 2024 16:01:50 -0500
Message-ID: <20240216210150.538844551@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 16 Feb 2024 16:00:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v3 2/3] tracing: Move open coded processing of tgid_map into helper function
References: <20240216210047.584712062@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation of moving the saved_cmdlines logic out of trace.c and into
trace_sched_switch.c, replace the open coded manipulation of tgid_map in
set_tracer_flag() into a helper function trace_alloc_tgid_map() so that it
can be easily moved into trace_sched_switch.c without changing existing
functions in trace.c.

No functional changes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7a96e5cfe266..00fe323b96d5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5433,10 +5433,31 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 	return 0;
 }
 
-int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
+static int trace_alloc_tgid_map(void)
 {
 	int *map;
 
+	if (tgid_map)
+		return 0;
+
+	tgid_map_max = pid_max;
+	map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
+		       GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	/*
+	 * Pairs with smp_load_acquire() in
+	 * trace_find_tgid_ptr() to ensure that if it observes
+	 * the tgid_map we just allocated then it also observes
+	 * the corresponding tgid_map_max value.
+	 */
+	smp_store_release(&tgid_map, map);
+	return 0;
+}
+
+int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
+{
 	if ((mask == TRACE_ITER_RECORD_TGID) ||
 	    (mask == TRACE_ITER_RECORD_CMD))
 		lockdep_assert_held(&event_mutex);
@@ -5459,20 +5480,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		trace_event_enable_cmd_record(enabled);
 
 	if (mask == TRACE_ITER_RECORD_TGID) {
-		if (!tgid_map) {
-			tgid_map_max = pid_max;
-			map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
-				       GFP_KERNEL);
-
-			/*
-			 * Pairs with smp_load_acquire() in
-			 * trace_find_tgid_ptr() to ensure that if it observes
-			 * the tgid_map we just allocated then it also observes
-			 * the corresponding tgid_map_max value.
-			 */
-			smp_store_release(&tgid_map, map);
-		}
-		if (!tgid_map) {
+		if (trace_alloc_tgid_map() < 0) {
 			tr->trace_flags &= ~TRACE_ITER_RECORD_TGID;
 			return -ENOMEM;
 		}
-- 
2.43.0



