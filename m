Return-Path: <linux-kernel+bounces-74860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5CC85DDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BD5B29C82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA77FBA9;
	Wed, 21 Feb 2024 14:06:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709A7C6E9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524400; cv=none; b=DZWYQsSY4RNB3nArWROv7oJ4c66c090jZ77Dl0AMS8bgH68NknauAIbvDteuWVXX3JCc3PL8hZ5/ArLPzfpev4CVnJ1b+jSOlS/j/zFibGP8jeTK0a1HDAL2YZGIFHwlkBnoZGWXc9EJLChIjBr2aOElCQlkJk+uMT+EED9JXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524400; c=relaxed/simple;
	bh=8ZvfGh9uyjaSsAfOjwGr/knP7gfKA/kQ4IkMrV52pyQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CxCe0bkFlJSLUfqu1n7dnZkZAp9etZVjoHnK7y7zGrjB8XB2XHTjXJmnNl9Re5fTG1JkbIBVSG/IWhjWZmAqnOvFLjQjh06sPgcWS36lnWhTU/w74zRGkBS1GtlVag7pReiX3q1tVBNzmbx7zLpZDav3Pes4EuwYNChfmxpH4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7330AC43390;
	Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rcnGu-00000002i8s-2iIu;
	Wed, 21 Feb 2024 09:08:28 -0500
Message-ID: <20240221140828.504715799@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 21 Feb 2024 09:08:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>
Subject: [for-next][PATCH 04/11] tracing: Move open coded processing of tgid_map into helper function
References: <20240221140756.797572998@goodmis.org>
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

Link: https://lore.kernel.org/linux-trace-kernel/20240220140703.338116216@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 52faa30e64ed..06c593fc93d0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5432,10 +5432,31 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
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
@@ -5458,20 +5479,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
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



