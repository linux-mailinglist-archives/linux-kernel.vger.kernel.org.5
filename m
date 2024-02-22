Return-Path: <linux-kernel+bounces-75711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA185EDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E3284D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D2D29B;
	Thu, 22 Feb 2024 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CazNXKw8"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859A881F;
	Thu, 22 Feb 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561094; cv=none; b=EUtDuJIqL6ko/bUwftFupv8R9nKNTAUX2s9jqBdh3BXnr1EVySEKys6yNG71tJa4+JJPPn/NGkwkZxO/kuL0Lj0rkOuY1JpwnD/O9ZT3gEXHAu4v1epW5yx20LW4ObbqfkE0hvUqi+pGtDT5kWq+e7YaZuQOlhOEuYkH2i/6wFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561094; c=relaxed/simple;
	bh=FrAXIPTWWnkhkaYqpxHWgqk2q1pIoZ9PfvME+zPZpw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjQwvL2jbAKPFXDlOibcdmabHW98H2M4R1y0uZPx6O6xXwlR2L7p4zlcoYxFomNhRCkTIxBdcgmuqZh532LpD0YyXdVMj3cNszELtHSLOWSxC6/HH3rKvVnn4K39q3si8xkv1EbUVfKA2b9ythSFJ9bImjQPJBBdWKZLHbrbXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CazNXKw8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.121])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA24B20B2000;
	Wed, 21 Feb 2024 16:18:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA24B20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708561092;
	bh=M6SAgZbkSYLON3Fg38OnMCPdKisAi1QzQx+eUR6LCLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CazNXKw8gsHPPL1h5iMGJJwGokwUCVYw3EnJbqkFXFb31NVIhuZPiOW7u7Qw7WWIU
	 BprxKY9ARXWwSakaiWm0AgqkONzfGLOQMm7DeZQgjaNu/mEN69sGpRLw6LaWVJehph
	 7gLfGOdSjrIwu7XwTyqkalex87ZRy/AlyVrdA4Vg=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v4 2/4] tracing/user_events: Introduce multi-format events
Date: Thu, 22 Feb 2024 00:18:05 +0000
Message-Id: <20240222001807.1463-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222001807.1463-1-beaub@linux.microsoft.com>
References: <20240222001807.1463-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently user_events supports 1 event with the same name and must have
the exact same format when referenced by multiple programs. This opens
an opportunity for malicous or poorly thought through programs to
create events that others use with different formats. Another scenario
is user programs wishing to use the same event name but add more fields
later when the software updates. Various versions of a program may be
running side-by-side, which is prevented by the current single format
requirement.

Add a new register flag (USER_EVENT_REG_MULTI_FORMAT) which indicates
the user program wishes to use the same user_event name, but may have
several different formats of the event. When this flag is used, create
the underlying tracepoint backing the user_event with a unique name
per-version of the format. It's important that existing ABI users do
not get this logic automatically, even if one of the multi format
events matches the format. This ensures existing programs that create
events and assume the tracepoint name will match exactly continue to
work as expected. Add logic to only check multi-format events with
other multi-format events and single-format events to only check
single-format events during find.

Change system name of the multi-format event tracepoint to ensure that
multi-format events are isolated completely from single-format events.
This prevents single-format names from conflicting with multi-format
events if they end with the same suffix as the multi-format events.

Add a register_name (reg_name) to the user_event struct which allows for
split naming of events. We now have the name that was used to register
within user_events as well as the unique name for the tracepoint. Upon
registering events ensure matches based on first the reg_name, followed
by the fields and format of the event. This allows for multiple events
with the same registered name to have different formats. The underlying
tracepoint will have a unique name in the format of {reg_name}.{unique_id}.

For example, if both "test u32 value" and "test u64 value" are used with
the USER_EVENT_REG_MULTI_FORMAT the system would have 2 unique
tracepoints. The dynamic_events file would then show the following:
  u:test u64 count
  u:test u32 count

The actual tracepoint names look like this:
  test.0
  test.1

Both would be under the new user_events_multi system name to prevent the
older ABI from being used to squat on multi-formatted events and block
their use.

Deleting events via "!u:test u64 count" would only delete the first
tracepoint that matched that format. When the delete ABI is used all
events with the same name will be attempted to be deleted. If
per-version deletion is required, user programs should either not use
persistent events or delete them via dynamic_events.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/uapi/linux/user_events.h |   6 +-
 kernel/trace/trace_events_user.c | 102 +++++++++++++++++++++++++++----
 2 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
index f74f3aedd49c..a03de03dccbc 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/uapi/linux/user_events.h
@@ -12,6 +12,7 @@
 #include <linux/ioctl.h>
 
 #define USER_EVENTS_SYSTEM "user_events"
+#define USER_EVENTS_MULTI_SYSTEM "user_events_multi"
 #define USER_EVENTS_PREFIX "u:"
 
 /* Create dynamic location entry within a 32-bit value */
@@ -22,8 +23,11 @@ enum user_reg_flag {
 	/* Event will not delete upon last reference closing */
 	USER_EVENT_REG_PERSIST		= 1U << 0,
 
+	/* Event will be allowed to have multiple formats */
+	USER_EVENT_REG_MULTI_FORMAT	= 1U << 1,
+
 	/* This value or above is currently non-ABI */
-	USER_EVENT_REG_MAX		= 1U << 1,
+	USER_EVENT_REG_MAX		= 1U << 2,
 };
 
 /*
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index dda58681247e..044920c415e7 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -34,7 +34,8 @@
 
 /* Limit how long of an event name plus args within the subsystem. */
 #define MAX_EVENT_DESC 512
-#define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
+#define EVENT_NAME(user_event) ((user_event)->reg_name)
+#define EVENT_TP_NAME(user_event) ((user_event)->tracepoint.name)
 #define MAX_FIELD_ARRAY_SIZE 1024
 
 /*
@@ -54,10 +55,13 @@
  * allows isolation for events by various means.
  */
 struct user_event_group {
-	char		*system_name;
-	struct		hlist_node node;
-	struct		mutex reg_mutex;
+	char			*system_name;
+	char			*system_multi_name;
+	struct hlist_node	node;
+	struct mutex		reg_mutex;
 	DECLARE_HASHTABLE(register_table, 8);
+	/* ID that moves forward within the group for multi-event names */
+	u64			multi_id;
 };
 
 /* Group for init_user_ns mapping, top-most group */
@@ -78,6 +82,7 @@ static unsigned int current_user_events;
  */
 struct user_event {
 	struct user_event_group		*group;
+	char				*reg_name;
 	struct tracepoint		tracepoint;
 	struct trace_event_call		call;
 	struct trace_event_class	class;
@@ -127,6 +132,8 @@ struct user_event_enabler {
 
 #define ENABLE_BIT(e) ((int)((e)->values & ENABLE_VAL_BIT_MASK))
 
+#define EVENT_MULTI_FORMAT(f) ((f) & USER_EVENT_REG_MULTI_FORMAT)
+
 /* Used for asynchronous faulting in of pages */
 struct user_event_enabler_fault {
 	struct work_struct		work;
@@ -330,6 +337,7 @@ static void user_event_put(struct user_event *user, bool locked)
 static void user_event_group_destroy(struct user_event_group *group)
 {
 	kfree(group->system_name);
+	kfree(group->system_multi_name);
 	kfree(group);
 }
 
@@ -348,6 +356,11 @@ static char *user_event_group_system_name(void)
 	return system_name;
 }
 
+static char *user_event_group_system_multi_name(void)
+{
+	return kstrdup(USER_EVENTS_MULTI_SYSTEM, GFP_KERNEL);
+}
+
 static struct user_event_group *current_user_event_group(void)
 {
 	return init_group;
@@ -367,6 +380,11 @@ static struct user_event_group *user_event_group_create(void)
 	if (!group->system_name)
 		goto error;
 
+	group->system_multi_name = user_event_group_system_multi_name();
+
+	if (!group->system_multi_name)
+		goto error;
+
 	mutex_init(&group->reg_mutex);
 	hash_init(group->register_table);
 
@@ -1482,6 +1500,11 @@ static int destroy_user_event(struct user_event *user)
 	hash_del(&user->node);
 
 	user_event_destroy_validators(user);
+
+	/* If we have different names, both must be freed */
+	if (EVENT_NAME(user) != EVENT_TP_NAME(user))
+		kfree(EVENT_TP_NAME(user));
+
 	kfree(user->call.print_fmt);
 	kfree(EVENT_NAME(user));
 	kfree(user);
@@ -1504,12 +1527,24 @@ static struct user_event *find_user_event(struct user_event_group *group,
 	*outkey = key;
 
 	hash_for_each_possible(group->register_table, user, node, key) {
+		/*
+		 * Single-format events shouldn't return multi-format
+		 * events. Callers expect the underlying tracepoint to match
+		 * the name exactly in these cases. Only check like-formats.
+		 */
+		if (EVENT_MULTI_FORMAT(flags) != EVENT_MULTI_FORMAT(user->reg_flags))
+			continue;
+
 		if (strcmp(EVENT_NAME(user), name))
 			continue;
 
 		if (user_fields_match(user, argc, argv))
 			return user_event_get(user);
 
+		/* Scan others if this is a multi-format event */
+		if (EVENT_MULTI_FORMAT(flags))
+			continue;
+
 		return ERR_PTR(-EADDRINUSE);
 	}
 
@@ -1889,8 +1924,12 @@ static bool user_event_match(const char *system, const char *event,
 	struct user_event *user = container_of(ev, struct user_event, devent);
 	bool match;
 
-	match = strcmp(EVENT_NAME(user), event) == 0 &&
-		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
+	match = strcmp(EVENT_NAME(user), event) == 0;
+
+	if (match && system) {
+		match = strcmp(system, user->group->system_name) == 0 ||
+			strcmp(system, user->group->system_multi_name) == 0;
+	}
 
 	if (match)
 		match = user_fields_match(user, argc, argv);
@@ -1923,6 +1962,33 @@ static int user_event_trace_register(struct user_event *user)
 	return ret;
 }
 
+static int user_event_set_tp_name(struct user_event *user)
+{
+	lockdep_assert_held(&user->group->reg_mutex);
+
+	if (EVENT_MULTI_FORMAT(user->reg_flags)) {
+		char *multi_name;
+
+		multi_name = kasprintf(GFP_KERNEL_ACCOUNT, "%s.%llx",
+				       user->reg_name, user->group->multi_id);
+
+		if (!multi_name)
+			return -ENOMEM;
+
+		user->call.name = multi_name;
+		user->tracepoint.name = multi_name;
+
+		/* Inc to ensure unique multi-event name next time */
+		user->group->multi_id++;
+	} else {
+		/* Non Multi-format uses register name */
+		user->call.name = user->reg_name;
+		user->tracepoint.name = user->reg_name;
+	}
+
+	return 0;
+}
+
 /*
  * Parses the event name, arguments and flags then registers if successful.
  * The name buffer lifetime is owned by this method for success cases only.
@@ -1985,7 +2051,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	INIT_LIST_HEAD(&user->validators);
 
 	user->group = group;
-	user->tracepoint.name = name;
+	user->reg_name = name;
+	user->reg_flags = reg_flags;
+
+	ret = user_event_set_tp_name(user);
+
+	if (ret)
+		goto put_user;
 
 	ret = user_event_parse_fields(user, args);
 
@@ -1999,11 +2071,14 @@ static int user_event_parse(struct user_event_group *group, char *name,
 
 	user->call.data = user;
 	user->call.class = &user->class;
-	user->call.name = name;
 	user->call.flags = TRACE_EVENT_FL_TRACEPOINT;
 	user->call.tp = &user->tracepoint;
 	user->call.event.funcs = &user_event_funcs;
-	user->class.system = group->system_name;
+
+	if (EVENT_MULTI_FORMAT(user->reg_flags))
+		user->class.system = group->system_multi_name;
+	else
+		user->class.system = group->system_name;
 
 	user->class.fields_array = user_event_fields_array;
 	user->class.get_fields = user_event_get_fields;
@@ -2025,8 +2100,6 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	if (ret)
 		goto put_user_lock;
 
-	user->reg_flags = reg_flags;
-
 	if (user->reg_flags & USER_EVENT_REG_PERSIST) {
 		/* Ensure we track self ref and caller ref (2) */
 		refcount_set(&user->refcnt, 2);
@@ -2050,6 +2123,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	user_event_destroy_fields(user);
 	user_event_destroy_validators(user);
 	kfree(user->call.print_fmt);
+
+	/* Caller frees reg_name on error, but not multi-name */
+	if (EVENT_NAME(user) != EVENT_TP_NAME(user))
+		kfree(EVENT_TP_NAME(user));
+
 	kfree(user);
 	return ret;
 }
@@ -2641,7 +2719,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 	hash_for_each(group->register_table, i, user, node) {
 		status = user->status;
 
-		seq_printf(m, "%s", EVENT_NAME(user));
+		seq_printf(m, "%s", EVENT_TP_NAME(user));
 
 		if (status != 0)
 			seq_puts(m, " #");
-- 
2.34.1


