Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72297781BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjHJTno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjHJTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:43:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 861F912B;
        Thu, 10 Aug 2023 12:43:42 -0700 (PDT)
Received: from ervaughn-nix0.corp.microsoft.com (c-24-17-148-188.hsd1.wa.comcast.net [24.17.148.188])
        by linux.microsoft.com (Postfix) with ESMTPSA id DA10D20FCF9B;
        Thu, 10 Aug 2023 12:43:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA10D20FCF9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691696622;
        bh=OgmQ2xb2jL4XJBw8qiia8lyh2jYmNXY1qwwbeOZ4xZE=;
        h=From:To:Cc:Subject:Date:From;
        b=gxuL1FqFGP+jbqZYHm3LdsDtjBjDU+giotYWYaBIUP9rYwNgJAXONq7KbUmuW8MVO
         G+n0NMES+V/ylOLCq7K4qXy4gZGzjHi5wQpIuanEfZxl8kUewbI+RTVRYjr5rX0Gva
         mAl1kK9DQ07ZGsB9RfolrNvb9lv8pJtCC9PRCPk8=
From:   Eric Vaughn <ervaughn@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        beaub@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/user_events: Optimize safe list traversals
Date:   Thu, 10 Aug 2023 12:43:37 -0700
Message-Id: <20230810194337.695983-1-ervaughn@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several of the list traversals in the user_events facility use safe list
traversals where they could be using the unsafe versions instead.

Replace these safe traversals with their unsafe counterparts in the
interest of optimization.

Suggested-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Eric Vaughn <ervaughn@linux.microsoft.com>
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
2.34.1

