Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC92798079
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbjIHCTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjIHCTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:19:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401D1BD5;
        Thu,  7 Sep 2023 19:19:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A94DC433C7;
        Fri,  8 Sep 2023 02:19:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeR6H-000MYU-1o;
        Thu, 07 Sep 2023 22:20:01 -0400
Message-ID: <20230908022001.371815239@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 07 Sep 2023 22:19:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 1/2] tracing: Use the new eventfs descriptor for print trigger
References: <20230908021910.507739229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The check to create the print event "trigger" was using the obsolete "dir"
value of the trace_event_file to determine if it should create the trigger
or not. But that value will now be NULL because it uses the event file
descriptor.

Change it to test the "ef" field of the trace_event_file structure so that
the trace_marker "trigger" file appears again.

Fixes: 27152bceea1df ("eventfs: Move tracing/events to eventfs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0608ad20cf30..122c23c9eb28 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9792,8 +9792,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 			  tr, &tracing_mark_fops);
 
 	file = __find_event_file(tr, "ftrace", "print");
-	if (file && file->dir)
-		trace_create_file("trigger", TRACE_MODE_WRITE, file->dir,
+	if (file && file->ef)
+		eventfs_add_file("trigger", TRACE_MODE_WRITE, file->ef,
 				  file, &event_trigger_fops);
 	tr->trace_marker_file = file;
 
-- 
2.40.1
