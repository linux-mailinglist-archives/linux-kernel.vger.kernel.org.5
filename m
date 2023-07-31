Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881B576A4AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGaXRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGaXRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9BA1BEE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E03E6135C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB88CC43395;
        Mon, 31 Jul 2023 23:17:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8P-003fLx-2n;
        Mon, 31 Jul 2023 19:17:05 -0400
Message-ID: <20230731231705.683094817@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 04/15] tracing: Add free_trace_iter_content() helper function
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As the trace iterator is created and used by various interfaces, the clean
up of it needs to be consistent. Create a free_trace_iter_content() helper
function that frees the content of the iterator and use that to clean it
up in all places that it is used.

Link: https://lkml.kernel.org/r/20230715141348.341887497@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5e665c356df7..a3c4f9826872 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4799,6 +4799,25 @@ static const struct seq_operations tracer_seq_ops = {
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
@@ -4906,8 +4925,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
  fail:
 	mutex_unlock(&trace_types_lock);
-	kfree(iter->temp);
-	kfree(iter->buffer_iter);
+	free_trace_iter_content(iter);
 release:
 	seq_release_private(inode, file);
 	return ERR_PTR(-ENOMEM);
@@ -4986,11 +5004,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 
 	mutex_unlock(&trace_types_lock);
 
-	mutex_destroy(&iter->mutex);
-	free_cpumask_var(iter->started);
-	kfree(iter->fmt);
-	kfree(iter->temp);
-	kfree(iter->buffer_iter);
+	free_trace_iter_content(iter);
 	seq_release_private(inode, file);
 
 	return 0;
@@ -6747,10 +6761,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
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
