Return-Path: <linux-kernel+bounces-8623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00181BA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745B21F244B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3EF4B13D;
	Thu, 21 Dec 2023 15:11:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D6539E8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70FAC433CB;
	Thu, 21 Dec 2023 15:11:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rGKiv-000000040VK-2JWM;
	Thu, 21 Dec 2023 10:12:33 -0500
Message-ID: <20231221151233.336510377@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 21 Dec 2023 10:09:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [for-linus][PATCH 1/3] tracing/synthetic: fix kernel-doc warnings
References: <20231221150922.017965539@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Randy Dunlap <rdunlap@infradead.org>

scripts/kernel-doc warns about using @args: for variadic arguments to
functions. Documentation/doc-guide/kernel-doc.rst says that this should
be written as @...: instead, so update the source code to match that,
preventing the warnings.

trace_events_synth.c:1165: warning: Excess function parameter 'args' description in '__synth_event_gen_cmd_start'
trace_events_synth.c:1714: warning: Excess function parameter 'args' description in 'synth_event_trace'

Link: https://lore.kernel.org/linux-trace-kernel/20231220061226.30962-1-rdunlap@infradead.org

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 35ca5207c2d11 ("tracing: Add synthetic event command generation functions")
Fixes: 8dcc53ad956d2 ("tracing: Add synth_event_trace() and related functions")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 846e02c0fb59..e7af286af4f1 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1137,7 +1137,7 @@ EXPORT_SYMBOL_GPL(synth_event_add_fields);
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
  * @name: The name of the synthetic event
  * @mod: The module creating the event, NULL if not created from a module
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the synth_event_gen_cmd_start() wrapper, which
@@ -1695,7 +1695,7 @@ __synth_event_trace_end(struct synth_event_trace_state *trace_state)
  * synth_event_trace - Trace a synthetic event
  * @file: The trace_event_file representing the synthetic event
  * @n_vals: The number of values in vals
- * @args: Variable number of args containing the event values
+ * @...: Variable number of args containing the event values
  *
  * Trace a synthetic event using the values passed in the variable
  * argument list.
-- 
2.42.0



