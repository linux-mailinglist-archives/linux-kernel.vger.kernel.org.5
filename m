Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1BF81081E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378359AbjLMCT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378300AbjLMCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:19:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803EF7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:19:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D60C433CD;
        Wed, 13 Dec 2023 02:19:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDEr4-00000002Ton-26uq;
        Tue, 12 Dec 2023 21:20:10 -0500
Message-ID: <20231213022010.289709857@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 12 Dec 2023 21:19:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 08/15] ring-buffer: Make sure the spare sub buffer used for reads has same
 size
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

Now that the ring buffer specifies the size of its sub buffers, they all
need to be the same size. When doing a read, a swap is done with a spare
page. Make sure they are the same size before doing the swap, otherwise
the read will fail.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb43605aacf6..9fc5caecf2f6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7575,6 +7575,7 @@ struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
 	unsigned int		spare_cpu;
+	unsigned int		spare_size;
 	unsigned int		read;
 };
 
@@ -8294,6 +8295,15 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
 
+	/* Make sure the spare matches the current sub buffer size */
+	if (info->spare) {
+		if (page_size != info->spare_size) {
+			ring_buffer_free_read_page(iter->array_buffer->buffer,
+						   info->spare_cpu, info->spare);
+			info->spare = NULL;
+		}
+	}
+
 	if (!info->spare) {
 		info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer,
 							  iter->cpu_file);
@@ -8302,6 +8312,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 			info->spare = NULL;
 		} else {
 			info->spare_cpu = iter->cpu_file;
+			info->spare_size = page_size;
 		}
 	}
 	if (!info->spare)
-- 
2.42.0


