Return-Path: <linux-kernel+bounces-2044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF2815747
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA55A287328
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91B10A3D;
	Sat, 16 Dec 2023 04:21:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33610A06;
	Sat, 16 Dec 2023 04:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29489C433CA;
	Sat, 16 Dec 2023 04:21:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rEMCI-00000002yAm-0etS;
	Fri, 15 Dec 2023 23:22:42 -0500
Message-ID: <20231216042241.937275443@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 23:22:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 01/15] ring-buffer: Fix writing to the buffer with max_data_size
References: <20231216042214.905262999@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The maximum ring buffer data size is the maximum size of data that can be
recorded on the ring buffer. Events must be smaller than the sub buffer
data size minus any meta data. This size is checked before trying to
allocate from the ring buffer because the allocation assumes that the size
will fit on the sub buffer.

The maximum size was calculated as the size of a sub buffer page (which is
currently PAGE_SIZE minus the sub buffer header) minus the size of the
meta data of an individual event. But it missed the possible adding of a
time stamp for events that are added long enough apart that the event meta
data can't hold the time delta.

When an event is added that is greater than the current BUF_MAX_DATA_SIZE
minus the size of a time stamp, but still less than or equal to
BUF_MAX_DATA_SIZE, the ring buffer would go into an infinite loop, looking
for a page that can hold the event. Luckily, there's a check for this loop
and after 1000 iterations and a warning is emitted and the ring buffer is
disabled. But this should never happen.

This can happen when a large event is added first, or after a long period
where an absolute timestamp is prefixed to the event, increasing its size
by 8 bytes. This passes the check and then goes into the algorithm that
causes the infinite loop.

For events that are the first event on the sub-buffer, it does not need to
add a timestamp, because the sub-buffer itself contains an absolute
timestamp, and adding one is redundant.

The fix is to check if the event is to be the first event on the
sub-buffer, and if it is, then do not add a timestamp.

This also fixes 32 bit adding a timestamp when a read of before_stamp or
write_stamp is interrupted. There's still no need to add that timestamp if
the event is going to be the first event on the sub buffer.

Also, if the buffer has "time_stamp_abs" set, then also check if the
length plus the timestamp is greater than the BUF_MAX_DATA_SIZE.

Link: https://lore.kernel.org/all/20231212104549.58863438@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20231212071837.5fdd6c13@gandalf.local.home
Link: https://lore.kernel.org/linux-trace-kernel/20231212111617.39e02849@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: a4543a2fa9ef3 ("ring-buffer: Get timestamp after event is allocated")
Fixes: 58fbc3c63275c ("ring-buffer: Consolidate add_timestamp to remove some branches")
Reported-by: Kent Overstreet <kent.overstreet@linux.dev> # (on IRC)
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8d2a4f00eca9..b8986f82eccf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3579,7 +3579,10 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		 * absolute timestamp.
 		 * Don't bother if this is the start of a new page (w == 0).
 		 */
-		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
+		if (!w) {
+			/* Use the sub-buffer timestamp */
+			info->delta = 0;
+		} else if (unlikely(!a_ok || !b_ok || info->before != info->after)) {
 			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
@@ -3737,6 +3740,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
 		info.length += RB_LEN_TIME_EXTEND;
+		if (info.length > BUF_MAX_DATA_SIZE)
+			goto out_fail;
 	} else {
 		add_ts_default = RB_ADD_STAMP_NONE;
 	}
-- 
2.42.0



