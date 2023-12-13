Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD6807E9D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443059AbjLGChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjLGChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:37:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63ECD51
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 18:37:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496E2C433C9;
        Thu,  7 Dec 2023 02:37:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rB4HK-00000001aMj-49r6;
        Wed, 06 Dec 2023 21:38:19 -0500
Message-ID: <20231207023818.766723807@goodmis.org>
User-Agent: quilt/0.67
Date:   Wed, 06 Dec 2023 21:37:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: [for-linus][PATCH 1/8] tracing: Always update snapshot buffer size
References: <20231207023752.712829638@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It use to be that only the top level instance had a snapshot buffer (for
latency tracers like wakeup and irqsoff). The update of the ring buffer
size would check if the instance was the top level and if so, it would
also update the snapshot buffer as it needs to be the same as the main
buffer.

Now that lower level instances also has a snapshot buffer, they too need
to update their snapshot buffer sizes when the main buffer is changed,
otherwise the following can be triggered:

 # cd /sys/kernel/tracing
 # echo 1500 > buffer_size_kb
 # mkdir instances/foo
 # echo irqsoff > instances/foo/current_tracer
 # echo 1000 > instances/foo/buffer_size_kb

Produces:

 WARNING: CPU: 2 PID: 856 at kernel/trace/trace.c:1938 update_max_tr_single.part.0+0x27d/0x320

Which is:

	ret = ring_buffer_swap_cpu(tr->max_buffer.buffer, tr->array_buffer.buffer, cpu);

	if (ret == -EBUSY) {
		[..]
	}

	WARN_ON_ONCE(ret && ret != -EAGAIN && ret != -EBUSY);  <== here

That's because ring_buffer_swap_cpu() has:

	int ret = -EINVAL;

	[..]

	/* At least make sure the two buffers are somewhat the same */
	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
		goto out;

	[..]
 out:
	return ret;
 }

Instead, update all instances' snapshot buffer sizes when their main
buffer size is updated.

Link: https://lkml.kernel.org/r/20231205220010.454662151@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 6d9b3fa5e7f6 ("tracing: Move tracing_max_latency into trace_array")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9aebf904ff97..231c173ec04f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6392,8 +6392,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		return ret;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!(tr->flags & TRACE_ARRAY_FL_GLOBAL) ||
-	    !tr->current_trace->use_max_tr)
+	if (!tr->current_trace->use_max_tr)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
-- 
2.42.0


