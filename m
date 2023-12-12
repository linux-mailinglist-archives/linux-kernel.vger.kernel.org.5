Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3ED80EB10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjLLL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:58:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03876AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:58:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5096C433C8;
        Tue, 12 Dec 2023 11:58:40 +0000 (UTC)
Date:   Tue, 12 Dec 2023 06:59:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2] ring-buffer: Fix writing to the buffer with
 max_data_size
Message-ID: <20231212065922.05f28041@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Also, if the buffer has "time_stamp_abs" set, then also check if the
length plus the timestamp is greater than the BUF_MAX_DATA_SIZE.

Cc: stable@vger.kernel.org
Fixes: a4543a2fa9ef3 ("ring-buffer: Get timestamp after event is allocated")
Reported-by: Kent Overstreet <kent.overstreet@linux.dev> # (on IRC)
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231209170139.33c1b452@gandalf.local.home

- Instead of subtracting the timestamp size from the max data, check if the
  event is the fist event on the sub-buffer and if it is do not add a timestamp.

- If the ring buffer enabled adding timestamps for every event, then check
  if the added timestamp puts the length over BUF_MAX_DATA_SIZE.


 kernel/trace/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8d2a4f00eca9..d8ce1dc5110e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3584,7 +3584,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
 			info->delta = info->ts - info->after;
-			if (unlikely(test_time_stamp(info->delta))) {
+			if (w && unlikely(test_time_stamp(info->delta))) {
 				info->add_timestamp |= RB_ADD_STAMP_EXTEND;
 				info->length += RB_LEN_TIME_EXTEND;
 			}
@@ -3737,6 +3737,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
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

