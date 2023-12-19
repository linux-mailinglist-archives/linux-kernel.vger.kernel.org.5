Return-Path: <linux-kernel+bounces-5186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DD98187B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E648B22B27
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD3182CF;
	Tue, 19 Dec 2023 12:44:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB01A58B;
	Tue, 19 Dec 2023 12:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA2DC433C8;
	Tue, 19 Dec 2023 12:44:44 +0000 (UTC)
Date: Tue, 19 Dec 2023 07:45:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] ring-buffer: Add interrupt information to dump of data
 sub-buffer
Message-ID: <20231219074542.6f304601@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When the ring buffer timestamp verifier triggers, it dumps the content of
the sub-buffer. But currently it only dumps the timestamps and the offset
of the data as well as the deltas. It would be even more informative if
the event data also showed the interrupt context level it was in.

That is, if each event showed that the event was written in normal,
softirq, irq or NMI context. Then a better idea about how the events may
have been interrupted from each other.

As the payload of the ring buffer is really a black box of the ring
buffer, just assume that if the payload is larger than a trace entry, that
it is a trace entry. As trace entries have the interrupt context
information saved in a flags field, look at that location and report the
output of the flags.

If the payload is not a trace entry, there's no way to really know, and
the information will be garbage. But that's OK, because this is for
debugging only (this output is not used in production as the buffer check
that calls it causes a huge overhead to the tracing). This information,
when available, is crucial for debugging timestamp issues. If it's
garbage, it will also be pretty obvious that its garbage too.

As this output usually happens in kselftests of the tracing code, the user
will know what the payload is at the time.

Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 79 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a4ada4f303c4..c0cc45482e1e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3185,6 +3185,76 @@ EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
 #define CHECK_FULL_PAGE		1L
 
 #ifdef CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS
+
+static const char *show_irq_str(int bits)
+{
+	const char *type[] = {
+		".",	// 0
+		"s",	// 1
+		"h",	// 2
+		"Hs",	// 3
+		"n",	// 4
+		"Ns",	// 5
+		"Nh",	// 6
+		"NHs",	// 7
+	};
+
+	return type[bits];
+}
+
+/* Assume this is an trace event */
+static const char *show_flags(struct ring_buffer_event *event)
+{
+	struct trace_entry *entry;
+	int bits = 0;
+
+	if (rb_event_data_length(event) - RB_EVNT_HDR_SIZE < sizeof(*entry))
+		return "X";
+
+	entry = ring_buffer_event_data(event);
+
+	if (entry->flags & TRACE_FLAG_SOFTIRQ)
+		bits |= 1;
+
+	if (entry->flags & TRACE_FLAG_HARDIRQ)
+		bits |= 2;
+
+	if (entry->flags & TRACE_FLAG_NMI)
+		bits |= 4;
+
+	return show_irq_str(bits);
+}
+
+static const char *show_irq(struct ring_buffer_event *event)
+{
+	struct trace_entry *entry;
+
+	if (rb_event_data_length(event) - RB_EVNT_HDR_SIZE < sizeof(*entry))
+		return "";
+
+	entry = ring_buffer_event_data(event);
+	if (entry->flags & TRACE_FLAG_IRQS_OFF)
+		return "d";
+	return "";
+}
+
+static const char *show_interrupt_level(void)
+{
+	unsigned long pc = preempt_count();
+	unsigned char level = 0;
+
+	if (pc & SOFTIRQ_OFFSET)
+		level |= 1;
+
+	if (pc & HARDIRQ_MASK)
+		level |= 2;
+
+	if (pc & NMI_MASK)
+		level |= 4;
+
+	return show_irq_str(level);
+}
+
 static void dump_buffer_page(struct buffer_data_page *bpage,
 			     struct rb_event_info *info,
 			     unsigned long tail)
@@ -3224,8 +3294,9 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 
 		case RINGBUF_TYPE_DATA:
 			ts += event->time_delta;
-			pr_warn(" 0x%x:  [%lld] delta:%d\n",
-				e, ts, event->time_delta);
+			pr_warn(" 0x%x:  [%lld] delta:%d %s%s\n",
+				e, ts, event->time_delta,
+				show_flags(event), show_irq(event));
 			break;
 
 		default:
@@ -3316,11 +3387,11 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		atomic_inc(&cpu_buffer->record_disabled);
 		/* There's some cases in boot up that this can happen */
 		WARN_ON_ONCE(system_state != SYSTEM_BOOTING);
-		pr_warn("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s\n",
+		pr_warn("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s context:%s\n",
 			cpu_buffer->cpu,
 			ts + info->delta, info->ts, info->delta,
 			info->before, info->after,
-			full ? " (full)" : "");
+			full ? " (full)" : "", show_interrupt_level());
 		dump_buffer_page(bpage, info, tail);
 		atomic_dec(&ts_dump);
 		/* Do not re-enable checking */
-- 
2.42.0


