Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16457B99CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbjJEBwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244350AbjJEBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:52:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8423D8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:52:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDC7C433D9;
        Thu,  5 Oct 2023 01:52:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qoDYl-005FJW-0c;
        Wed, 04 Oct 2023 21:53:51 -0400
Message-ID: <20231005015351.006166381@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 04 Oct 2023 21:53:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 3/7] tracing/user_events: Allow events to persist for perfmon_capable
 users
References: <20231005015310.859143353@goodmis.org>
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

From: Beau Belgrave <beaub@linux.microsoft.com>

There are several scenarios that have come up where having a user_event
persist even if the process that registered it exits. The main one is
having a daemon create events on bootup that shouldn't get deleted if
the daemon has to exit or reload. Another is within OpenTelemetry
exporters, they wish to potentially check if a user_event exists on the
system to determine if exporting the data out should occur. The
user_event in this case must exist even in the absence of the owning
process running (such as the above daemon case).

Expose the previously internal flag USER_EVENT_REG_PERSIST to user
processes. Upon register or delete of events with this flag, ensure the
user is perfmon_capable to prevent random user processes with access to
tracefs from creating events that persist after exit.

Link: https://lkml.kernel.org/r/20230912180704.1284-2-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/uapi/linux/user_events.h | 11 +++++++++-
 kernel/trace/trace_events_user.c | 36 +++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
index 2984aae4a2b4..f74f3aedd49c 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/uapi/linux/user_events.h
@@ -17,6 +17,15 @@
 /* Create dynamic location entry within a 32-bit value */
 #define DYN_LOC(offset, size) ((size) << 16 | (offset))
 
+/* List of supported registration flags */
+enum user_reg_flag {
+	/* Event will not delete upon last reference closing */
+	USER_EVENT_REG_PERSIST		= 1U << 0,
+
+	/* This value or above is currently non-ABI */
+	USER_EVENT_REG_MAX		= 1U << 1,
+};
+
 /*
  * Describes an event registration and stores the results of the registration.
  * This structure is passed to the DIAG_IOCSREG ioctl, callers at a minimum
@@ -33,7 +42,7 @@ struct user_reg {
 	/* Input: Enable size in bytes at address */
 	__u8	enable_size;
 
-	/* Input: Flags for future use, set to 0 */
+	/* Input: Flags to use, if any */
 	__u16	flags;
 
 	/* Input: Address to update when enabled */
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b87f41187c6a..9365ce407426 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -49,18 +49,6 @@
 #define EVENT_STATUS_PERF BIT(1)
 #define EVENT_STATUS_OTHER BIT(7)
 
-/*
- * User register flags are not allowed yet, keep them here until we are
- * ready to expose them out to the user ABI.
- */
-enum user_reg_flag {
-	/* Event will not delete upon last reference closing */
-	USER_EVENT_REG_PERSIST		= 1U << 0,
-
-	/* This value or above is currently non-ABI */
-	USER_EVENT_REG_MAX		= 1U << 1,
-};
-
 /*
  * Stores the system name, tables, and locks for a group of events. This
  * allows isolation for events by various means.
@@ -220,6 +208,17 @@ static u32 user_event_key(char *name)
 	return jhash(name, strlen(name), 0);
 }
 
+static bool user_event_capable(u16 reg_flags)
+{
+	/* Persistent events require CAP_PERFMON / CAP_SYS_ADMIN */
+	if (reg_flags & USER_EVENT_REG_PERSIST) {
+		if (!perfmon_capable())
+			return false;
+	}
+
+	return true;
+}
+
 static struct user_event *user_event_get(struct user_event *user)
 {
 	refcount_inc(&user->refcnt);
@@ -1811,6 +1810,9 @@ static int user_event_free(struct dyn_event *ev)
 	if (!user_event_last_ref(user))
 		return -EBUSY;
 
+	if (!user_event_capable(user->reg_flags))
+		return -EPERM;
+
 	return destroy_user_event(user);
 }
 
@@ -1926,10 +1928,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	int argc = 0;
 	char **argv;
 
-	/* User register flags are not ready yet */
-	if (reg_flags != 0 || flags != NULL)
+	/* Currently don't support any text based flags */
+	if (flags != NULL)
 		return -EINVAL;
 
+	if (!user_event_capable(reg_flags))
+		return -EPERM;
+
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
 	user = find_user_event(group, name, &key);
@@ -2062,6 +2067,9 @@ static int delete_user_event(struct user_event_group *group, char *name)
 	if (!user_event_last_ref(user))
 		return -EBUSY;
 
+	if (!user_event_capable(user->reg_flags))
+		return -EPERM;
+
 	return destroy_user_event(user);
 }
 
-- 
2.40.1
