Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588F5754938
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGOON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjGOONw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4121BFA;
        Sat, 15 Jul 2023 07:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F17160BBB;
        Sat, 15 Jul 2023 14:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852F9C433CB;
        Sat, 15 Jul 2023 14:13:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qKg1s-001040-1h;
        Sat, 15 Jul 2023 10:13:48 -0400
Message-ID: <20230715141348.341887497@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 15 Jul 2023 10:12:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] tracing: Add free_trace_iter_content() helper function
References: <20230715141213.970003974@goodmis.org>
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

As the trace iterator is created and used by various interfaces, the clean
up of it needs to be consistent. Create a free_trace_iter_content() helper
function that frees the content of the iterator and use that to clean it
up in all places that it is used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c370ffbe062..8775930aa545 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4815,6 +4815,25 @@ static const struct seq_operations tracer_seq_ops = {
 	.show		= s_show,
 };
 
+/*
+ * Note, as iter itself can be allocated and freed in different
+ * ways, this function is only used to free its content, and not
+ * the iterator itself. The only requirement to all the allocations
+ * is that it must zero all fields (kzalloc), as freeing works with
+ * ethier allocated content or NULL.
+ */
+static void free_trace_iter_content(struct trace_iterator *iter)
+{
+	/* The fmt is either NULL, allocated or points to static_fmt_buf */
+	if (iter->fmt != static_fmt_buf)
+		kfree(iter->fmt);
+
+	kfree(iter->temp);
+	kfree(iter->buffer_iter);
+	mutex_destroy(&iter->mutex);
+	free_cpumask_var(iter->started);
+}
+
 static struct trace_iterator *
 __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 {
@@ -4922,8 +4941,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
  fail:
 	mutex_unlock(&trace_types_lock);
-	kfree(iter->temp);
-	kfree(iter->buffer_iter);
+	free_trace_iter_content(iter);
 release:
 	seq_release_private(inode, file);
 	return ERR_PTR(-ENOMEM);
@@ -5002,11 +5020,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 
 	mutex_unlock(&trace_types_lock);
 
-	mutex_destroy(&iter->mutex);
-	free_cpumask_var(iter->started);
-	kfree(iter->fmt);
-	kfree(iter->temp);
-	kfree(iter->buffer_iter);
+	free_trace_iter_content(iter);
 	seq_release_private(inode, file);
 
 	return 0;
@@ -6763,10 +6777,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	mutex_unlock(&trace_types_lock);
 
-	free_cpumask_var(iter->started);
-	kfree(iter->fmt);
-	kfree(iter->temp);
-	mutex_destroy(&iter->mutex);
+	free_trace_iter_content(iter);
 	kfree(iter);
 
 	trace_array_put(tr);
-- 
2.40.1
