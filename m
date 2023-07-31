Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2B76A4B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjGaXRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjGaXRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770DD1B7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D1466135A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74772C433CB;
        Mon, 31 Jul 2023 23:17:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8Q-003fN3-0s;
        Mon, 31 Jul 2023 19:17:06 -0400
Message-ID: <20230731231706.089777331@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [for-next][PATCH 06/15] tracing: Require all trace events to have a TRACE_SYSTEM
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

The creation of the trace event directory requires that a TRACE_SYSTEM is
defined that the trace event directory is added within the system it was
defined in.

The code handled the case where a TRACE_SYSTEM was not added, and would
then add the event at the events directory. But nothing should be doing
this. This code also prevents the implementation of creating dynamic
dentrys for the eventfs system.

As this path has never been hit on correct code, remove it. If it does get
hit, issues a WARN_ON_ONCE() and return ENODEV.

Link: https://lkml.kernel.org/r/1690568452-46553-2-git-send-email-akaher@vmware.com

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ajay Kaher <akaher@vmware.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 578f1f7d49a6..3ecc41f6acd9 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2420,14 +2420,15 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 
 	/*
 	 * If the trace point header did not define TRACE_SYSTEM
-	 * then the system would be called "TRACE_SYSTEM".
+	 * then the system would be called "TRACE_SYSTEM". This should
+	 * never happen.
 	 */
-	if (strcmp(call->class->system, TRACE_SYSTEM) != 0) {
-		d_events = event_subsystem_dir(tr, call->class->system, file, parent);
-		if (!d_events)
-			return -ENOMEM;
-	} else
-		d_events = parent;
+	if (WARN_ON_ONCE(strcmp(call->class->system, TRACE_SYSTEM) == 0))
+		return -ENODEV;
+
+	d_events = event_subsystem_dir(tr, call->class->system, file, parent);
+	if (!d_events)
+		return -ENOMEM;
 
 	name = trace_event_name(call);
 	file->dir = tracefs_create_dir(name, d_events);
-- 
2.40.1
