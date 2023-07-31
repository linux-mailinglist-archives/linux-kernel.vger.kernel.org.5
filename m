Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61476A4AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGaXRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjGaXRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F61FDE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBE6F61361
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E281C433C8;
        Mon, 31 Jul 2023 23:17:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8Q-003fMV-0D;
        Mon, 31 Jul 2023 19:17:06 -0400
Message-ID: <20230731231705.888984593@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-next][PATCH 05/15] tracing: Set actual size after ring buffer resize
References: <20230731231634.031452225@goodmis.org>
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

From: Zheng Yejian <zhengyejian1@huawei.com>

Currently we can resize trace ringbuffer by writing a value into file
'buffer_size_kb', then by reading the file, we get the value that is
usually what we wrote. However, this value may be not actual size of
trace ring buffer because of the round up when doing resize in kernel,
and the actual size would be more useful.

Link: https://lore.kernel.org/linux-trace-kernel/20230705002705.576633-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a3c4f9826872..bc96567dc230 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6286,6 +6286,15 @@ static void set_buffer_entries(struct array_buffer *buf, unsigned long val)
 		per_cpu_ptr(buf->data, cpu)->entries = val;
 }
 
+static void update_buffer_entries(struct array_buffer *buf, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		set_buffer_entries(buf, ring_buffer_size(buf->buffer, 0));
+	} else {
+		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_size(buf->buffer, cpu);
+	}
+}
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 /* resize @tr's buffer to the size of @size_tr's entries */
 static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
@@ -6364,18 +6373,12 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		return ret;
 	}
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
-		set_buffer_entries(&tr->max_buffer, size);
-	else
-		per_cpu_ptr(tr->max_buffer.data, cpu)->entries = size;
+	update_buffer_entries(&tr->max_buffer, cpu);
 
  out:
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
-		set_buffer_entries(&tr->array_buffer, size);
-	else
-		per_cpu_ptr(tr->array_buffer.data, cpu)->entries = size;
+	update_buffer_entries(&tr->array_buffer, cpu);
 
 	return ret;
 }
-- 
2.40.1
