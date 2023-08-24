Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972BE786544
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbjHXCTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbjHXCSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE0510C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FFA364AB2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F000DC433C9;
        Thu, 24 Aug 2023 02:18:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvx-001hWH-00;
        Wed, 23 Aug 2023 22:18:53 -0400
Message-ID: <20230824021852.814428025@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Eric Vaughn <ervaughn@linux.microsoft.com>
Subject: [for-next][PATCH 12/14] tracing/user_events: Optimize safe list traversals
References: <20230824021812.938245293@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Vaughn <ervaughn@linux.microsoft.com>

Several of the list traversals in the user_events facility use safe list
traversals where they could be using the unsafe versions instead.

Replace these safe traversals with their unsafe counterparts in the
interest of optimization.

Link: https://lore.kernel.org/linux-trace-kernel/20230810194337.695983-1-ervaughn@linux.microsoft.com

Suggested-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Eric Vaughn <ervaughn@linux.microsoft.com>
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 33cb6af31f39..6f046650e527 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1328,14 +1328,14 @@ static int user_field_set_string(struct ftrace_event_field *field,
 
 static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
 {
-	struct ftrace_event_field *field, *next;
+	struct ftrace_event_field *field;
 	struct list_head *head = &user->fields;
 	int pos = 0, depth = 0;
 	const char *str_func;
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
-	list_for_each_entry_safe_reverse(field, next, head, link) {
+	list_for_each_entry_reverse(field, head, link) {
 		if (depth != 0)
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
 
@@ -1347,7 +1347,7 @@ static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
-	list_for_each_entry_safe_reverse(field, next, head, link) {
+	list_for_each_entry_reverse(field, head, link) {
 		if (user_field_is_dyn_string(field->type, &str_func))
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 					", %s(%s)", str_func, field->name);
@@ -1732,7 +1732,7 @@ static int user_event_create(const char *raw_command)
 static int user_event_show(struct seq_file *m, struct dyn_event *ev)
 {
 	struct user_event *user = container_of(ev, struct user_event, devent);
-	struct ftrace_event_field *field, *next;
+	struct ftrace_event_field *field;
 	struct list_head *head;
 	int depth = 0;
 
@@ -1740,7 +1740,7 @@ static int user_event_show(struct seq_file *m, struct dyn_event *ev)
 
 	head = trace_get_fields(&user->call);
 
-	list_for_each_entry_safe_reverse(field, next, head, link) {
+	list_for_each_entry_reverse(field, head, link) {
 		if (depth == 0)
 			seq_puts(m, " ");
 		else
@@ -1816,13 +1816,14 @@ static bool user_field_match(struct ftrace_event_field *field, int argc,
 static bool user_fields_match(struct user_event *user, int argc,
 			      const char **argv)
 {
-	struct ftrace_event_field *field, *next;
+	struct ftrace_event_field *field;
 	struct list_head *head = &user->fields;
 	int i = 0;
 
-	list_for_each_entry_safe_reverse(field, next, head, link)
+	list_for_each_entry_reverse(field, head, link) {
 		if (!user_field_match(field, argc, argv, &i))
 			return false;
+	}
 
 	if (i != argc)
 		return false;
-- 
2.40.1
