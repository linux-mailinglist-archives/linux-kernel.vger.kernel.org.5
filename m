Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302F47527A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjGMPqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGMPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AD52686;
        Thu, 13 Jul 2023 08:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D59F661881;
        Thu, 13 Jul 2023 15:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB775C433C7;
        Thu, 13 Jul 2023 15:46:27 +0000 (UTC)
Date:   Thu, 13 Jul 2023 11:46:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [PATCH 1/2] tracing: Remove unnecessary copying of
 tr->current_trace
Message-ID: <20230713114626.704ebe8e@gandalf.local.home>
In-Reply-To: <20230713114510.04c452ca@gandalf.local.home>
References: <20230713114510.04c452ca@gandalf.local.home>
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

I have no idea why the iterator had to allocate a descriptor to make a
copy of "current_trace" (now "tr->current_trace"). The content of that
pointer never changes, so it's sufficient to just copy the pointer to
maintain integrity with reading it.

This is more of a clean up than a fix.

Fixes: d7350c3f45694 ("tracing/core: make the read callbacks reentrants")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be847d45d81c..1c370ffbe062 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4205,15 +4205,9 @@ static void *s_start(struct seq_file *m, loff_t *pos)
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
@@ -4862,16 +4856,8 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
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
@@ -4936,7 +4922,6 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
  fail:
 	mutex_unlock(&trace_types_lock);
-	kfree(iter->trace);
 	kfree(iter->temp);
 	kfree(iter->buffer_iter);
 release:
@@ -5021,7 +5006,6 @@ static int tracing_release(struct inode *inode, struct file *file)
 	free_cpumask_var(iter->started);
 	kfree(iter->fmt);
 	kfree(iter->temp);
-	kfree(iter->trace);
 	kfree(iter->buffer_iter);
 	seq_release_private(inode, file);
 
-- 
2.40.1

