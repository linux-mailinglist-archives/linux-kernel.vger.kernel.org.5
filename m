Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0EA79D858
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjILSHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjILSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:07:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 472CB10D8;
        Tue, 12 Sep 2023 11:07:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id C6DE2212BC1A;
        Tue, 12 Sep 2023 11:07:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6DE2212BC1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694542030;
        bh=pwgfnQGdYQ7dhrASDB16knk3pMkjAyqpomjeERDUJlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwdP8ZmyOXqIQfJ+1KExC6cxFh7aklIGehuRzQTeGUWv5VOHkNXtB96OAGHtHS53w
         /PCYLQjajPdGfrPCKG+oLLGDRx7/EQuePqOlyNVugLrja72QynpBgthlz4TY3LE28I
         P11sDV/9GOvdj7jGJ14B8olkkoGWRECPfRb2oNJI=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v2 1/3] tracing/user_events: Allow events to persist for perfmon_capable users
Date:   Tue, 12 Sep 2023 18:07:02 +0000
Message-Id: <20230912180704.1284-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912180704.1284-1-beaub@linux.microsoft.com>
References: <20230912180704.1284-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
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
index 6f046650e527..e3f2b8d72e01 100644
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
@@ -191,6 +179,17 @@ static u32 user_event_key(char *name)
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
@@ -1773,6 +1772,9 @@ static int user_event_free(struct dyn_event *ev)
 	if (!user_event_last_ref(user))
 		return -EBUSY;
 
+	if (!user_event_capable(user->reg_flags))
+		return -EPERM;
+
 	return destroy_user_event(user);
 }
 
@@ -1888,10 +1890,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
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
@@ -2024,6 +2029,9 @@ static int delete_user_event(struct user_event_group *group, char *name)
 	if (!user_event_last_ref(user))
 		return -EBUSY;
 
+	if (!user_event_capable(user->reg_flags))
+		return -EPERM;
+
 	return destroy_user_event(user);
 }
 
-- 
2.34.1

