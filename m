Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7561076A4AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGaXR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGaXRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A91BEC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C14161356
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F92C433CD;
        Mon, 31 Jul 2023 23:17:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8P-003fLP-28;
        Mon, 31 Jul 2023 19:17:05 -0400
Message-ID: <20230731231705.484662632@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 03/15] tracing: Remove unnecessary copying of tr->current_trace
References: <20230731231634.031452225@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The iterator allocated a descriptor to copy the current_trace. This was done
with the assumption that the function pointers might change. But this was a
false assuption, as it does not change. There's no reason to make a copy of the
current_trace and just use the pointer it points to. This removes needing to
manage freeing the descriptor. Worse yet, there's locations that the iterator
is used but does make a copy and just uses the pointer. This could cause the
actual pointer to the trace descriptor to be freed and not the allocated copy.

This is more of a clean up than a fix.

Link: https://lkml.kernel.org/r/20230715141348.135792275@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: d7350c3f45694 ("tracing/core: make the read callbacks reentrants")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f6ed6b79d91f..5e665c356df7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4189,15 +4189,9 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	loff_t l = 0;
 	int cpu;
 
-	/*
-	 * copy the tracer to avoid using a global lock all around.
-	 * iter->trace is a copy of current_trace, the pointer to the
-	 * name may be used instead of a strcmp(), as iter->trace->name
-	 * will point to the same string as current_trace->name.
-	 */
 	mutex_lock(&trace_types_lock);
-	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name))
-		*iter->trace = *tr->current_trace;
+	if (unlikely(tr->current_trace != iter->trace))
+		iter->trace = tr->current_trace;
 	mutex_unlock(&trace_types_lock);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -4846,16 +4840,8 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	iter->fmt = NULL;
 	iter->fmt_size = 0;
 
-	/*
-	 * We make a copy of the current tracer to avoid concurrent
-	 * changes on it while we are reading.
-	 */
 	mutex_lock(&trace_types_lock);
-	iter->trace = kzalloc(sizeof(*iter->trace), GFP_KERNEL);
-	if (!iter->trace)
-		goto fail;
-
-	*iter->trace = *tr->current_trace;
+	iter->trace = tr->current_trace;
 
 	if (!zalloc_cpumask_var(&iter->started, GFP_KERNEL))
 		goto fail;
@@ -4920,7 +4906,6 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
  fail:
 	mutex_unlock(&trace_types_lock);
-	kfree(iter->trace);
 	kfree(iter->temp);
 	kfree(iter->buffer_iter);
 release:
@@ -5005,7 +4990,6 @@ static int tracing_release(struct inode *inode, struct file *file)
 	free_cpumask_var(iter->started);
 	kfree(iter->fmt);
 	kfree(iter->temp);
-	kfree(iter->trace);
 	kfree(iter->buffer_iter);
 	seq_release_private(inode, file);
 
-- 
2.40.1
