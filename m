Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93303811C40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjLMSVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjLMSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:20:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255112D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:20:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F96DC433C8;
        Wed, 13 Dec 2023 18:20:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDTrH-00000002a8l-3nb3;
        Wed, 13 Dec 2023 13:21:23 -0500
Message-ID: <20231213182123.691123886@goodmis.org>
User-Agent: quilt/0.67
Date:   Wed, 13 Dec 2023 13:17:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v3 06/15] ring-buffer: Clear pages on error in ring_buffer_subbuf_order_set()
 failure
References: <20231213181737.791847466@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On failure to allocate ring buffer pages, the pointer to the CPU buffer
pages is freed, but the pages that were allocated previously were not.
Make sure they are freed too.

Fixes: TBD ("tracing: Set new size of the ring buffer sub page")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 729fd4f07c1e..ea3c217e4e43 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6069,6 +6069,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	for_each_buffer_cpu(buffer, cpu) {
 		if (!cpu_buffers[cpu])
 			continue;
+		rb_free_cpu_buffer(cpu_buffers[cpu]);
 		kfree(cpu_buffers[cpu]);
 	}
 	kfree(cpu_buffers);
-- 
2.42.0


