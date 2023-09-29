Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33867B3C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjI2WBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjI2WBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:01:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73697EB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:01:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1534C433C9;
        Fri, 29 Sep 2023 22:01:17 +0000 (UTC)
Date:   Fri, 29 Sep 2023 18:01:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH] ring-buffer: Update "shortest_full" in polling
Message-ID: <20230929180113.01c2cae3@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It was discovered that the ring buffer polling was incorrectly stating
that read would not block, but that's because polling did not take into
account that reads will block if the "buffer-percent" was set. Instead,
the ring buffer polling would say reads would not block if there was any
data in the ring buffer. This was incorrect behavior from a user space
point of view. This was fixed by commit 42fb0a1e84ff by having the polling
code check if the ring buffer had more data than what the user specified
"buffer percent" had.

The problem now is that the polling code did not register itself to the
writer that it wanted to wait for a specific "full" value of the ring
buffer. The result was that the writer would wake the polling waiter
whenever there was a new event. The polling waiter would then wake up, see
that there's not enough data in the ring buffer to notify user space and
then go back to sleep. The next event would wake it up again.

Before the polling fix was added, the code would wake up around 100 times
for a hackbench 30 benchmark. After the "fix", due to the constant waking
of the writer, it would wake up over 11,0000 times! It would never leave
the kernel, so the user space behavior was still "correct", but this
definitely is not the desired effect.

To fix this, have the polling code add what it's waiting for to the
"shortest_full" variable, to tell the writer not to wake it up if the
buffer is not as full as it expects to be.

Note, after this fix, it appears that the waiter is now woken up around 2x
the times it was before (~200). This is a tremendous improvement from the
11,000 times, but I will need to spend some time to see why polling is
more aggressive in its wakeups than the read blocking code.

Cc: stable@vger.kernel.org
Fixes: 42fb0a1e84ff ("tracing/ring-buffer: Have polling block on watermark")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28daf0ce95c5..515cafdb18d9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1137,6 +1137,9 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	if (full) {
 		poll_wait(filp, &work->full_waiters, poll_table);
 		work->full_waiters_pending = true;
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
 	} else {
 		poll_wait(filp, &work->waiters, poll_table);
 		work->waiters_pending = true;
-- 
2.40.1

