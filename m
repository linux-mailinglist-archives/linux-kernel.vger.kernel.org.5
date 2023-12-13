Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFA810823
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378405AbjLMCTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378316AbjLMCTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:19:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686BCF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:19:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC20C433CA;
        Wed, 13 Dec 2023 02:19:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDEr5-00000002TqJ-1VjB;
        Tue, 12 Dec 2023 21:20:11 -0500
Message-ID: <20231213022011.141490099@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 12 Dec 2023 21:19:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 11/15] ring-buffer: Keep the same size when updating the order
References: <20231213021914.361709558@goodmis.org>
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

The function ring_buffer_subbuf_order_set() just updated the sub-buffers
to the new size, but this also changes the size of the buffer in doing so.
As the size is determined by nr_pages * subbuf_size. If the subbuf_size is
increased without decreasing the nr_pages, this causes the total size of
the buffer to increase.

This broke the latency tracers as the snapshot needs to be the same size
as the main buffer. The size of the snapshot buffer is only expanded when
needed, and because the order is still the same, the size becomes out of
sync with the main buffer, as the main buffer increased in size without
the tracing system knowing.

Calculate the nr_pages to allocate with the new subbuf_size to be
buffer_size / new_subbuf_size.

Fixes: TBD ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2c908b4f3f68..86d3cac2a877 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6039,7 +6039,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
 
-		nr_pages = buffer->buffers[cpu]->nr_pages;
+		/* Update the number of pages to match the new size */
+		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
+		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
+
 		cpu_buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
 		if (!cpu_buffers[cpu]) {
 			err = -ENOMEM;
-- 
2.42.0


