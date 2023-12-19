Return-Path: <linux-kernel+bounces-5378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141FC818A11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F901F2671B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BA20DEB;
	Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE627208D0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B376C433CA;
	Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFb9X-00000003MER-2HJA;
	Tue, 19 Dec 2023 09:32:59 -0500
Message-ID: <20231219143259.319621961@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 09:32:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 02/10] ring-buffer: Add offset of events in dump on mismatch
References: <20231219143233.204534014@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

On bugs that have the ring buffer timestamp get out of sync, the config
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS, that checks for it and if it is
detected it causes a dump of the bad sub buffer.

It shows each event and their timestamp as well as the delta in the event.
But it's also good to see the offset into the subbuffer for that event to
know if how close to the end it is.

Also print where the last event actually ended compared to where it was
expected to end.

Link: https://lore.kernel.org/linux-trace-kernel/20231211131623.59eaebd2@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 83eab547f1d1..bfe2697a92ee 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3358,29 +3358,34 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 		case RINGBUF_TYPE_TIME_EXTEND:
 			delta = rb_event_time_stamp(event);
 			ts += delta;
-			pr_warn("  [%lld] delta:%lld TIME EXTEND\n", ts, delta);
+			pr_warn(" 0x%x: [%lld] delta:%lld TIME EXTEND\n",
+				e, ts, delta);
 			break;
 
 		case RINGBUF_TYPE_TIME_STAMP:
 			delta = rb_event_time_stamp(event);
 			ts = rb_fix_abs_ts(delta, ts);
-			pr_warn("  [%lld] absolute:%lld TIME STAMP\n", ts, delta);
+			pr_warn(" 0x%x:  [%lld] absolute:%lld TIME STAMP\n",
+				e, ts, delta);
 			break;
 
 		case RINGBUF_TYPE_PADDING:
 			ts += event->time_delta;
-			pr_warn("  [%lld] delta:%d PADDING\n", ts, event->time_delta);
+			pr_warn(" 0x%x:  [%lld] delta:%d PADDING\n",
+				e, ts, event->time_delta);
 			break;
 
 		case RINGBUF_TYPE_DATA:
 			ts += event->time_delta;
-			pr_warn("  [%lld] delta:%d\n", ts, event->time_delta);
+			pr_warn(" 0x%x:  [%lld] delta:%d\n",
+				e, ts, event->time_delta);
 			break;
 
 		default:
 			break;
 		}
 	}
+	pr_warn("expected end:0x%lx last event actually ended at:0x%x\n", tail, e);
 }
 
 static DEFINE_PER_CPU(atomic_t, checking);
-- 
2.42.0



