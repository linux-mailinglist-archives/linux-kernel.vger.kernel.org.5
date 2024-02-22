Return-Path: <linux-kernel+bounces-75713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0585EDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5300D284EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C310A05;
	Thu, 22 Feb 2024 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p9sFiuyE"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1853F6FC7;
	Thu, 22 Feb 2024 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561095; cv=none; b=Mg0OVpGTP6sUf1hHSq9StK7+z4H8/lr5jGnK+f5d0Spv9SxPS+GdOR+G3eJhQHz+BXHLDFxOEDdRp3D6hUlB2/6wBq9H0UOf2gp2XyFelxUgtqmWHuq5zm6peDEM9Xlf9bqzw4fTMB5oQ2oDPTYIJpvySmiW+c/hn1B0JSfGBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561095; c=relaxed/simple;
	bh=ZRB6dt/HxdQPGvW2NFnJnN1E61Lbl+sYGO/3BsA27zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDa7EnaCPTqsivFlFfCSZMmD6IJaH/3CeIsFEU2og3gfFYY9YtNngZXqKIwS7W42W9jjyr+/OZHcIqtRabBIiPSeOvWj+kg1dOsMFoRSH3WovwjyEr7B4UOpmTvzWVxqfNrdsPvxayMQnZrpIQcbD5iAzACVn1HDpC73FZ82BHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p9sFiuyE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.121])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE7342083ED9;
	Wed, 21 Feb 2024 16:18:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE7342083ED9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708561092;
	bh=U7quCGz6M7V53QYSXMIQhVMYbmAzb4pJq8PR81kSJHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9sFiuyE7p+O/Fz8mCnIlhQrHD2coUviFKplcNTdQ9QREdYtWH2qCd0EXA3YoAmsZ
	 1+WY0Y3Uk1lFUd/xcblfaJI+rZjeAZp1JBZSvxBhTeF7D1yp6il13mzqiDJc2AZwK9
	 w85CC30zxp7D2s0vKGF+iZrpWQtcJG5bl7wjOXJQ=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v4 1/4] tracing/user_events: Prepare find/delete for same name events
Date: Thu, 22 Feb 2024 00:18:04 +0000
Message-Id: <20240222001807.1463-2-beaub@linux.microsoft.com>
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

The current code for finding and deleting events assumes that there will
never be cases when user_events are registered with the same name, but
different formats. Scenarios exist where programs want to use the same
name but have different formats. An example is multiple versions of a
program running side-by-side using the same event name, but with updated
formats in each version.

This change does not yet allow for multi-format events. If user_events
are registered with the same name but different arguments the programs
see the same return values as before. This change simply makes it
possible to easily accomodate for this.

Update find_user_event() to take in argument parameters and register
flags to accomodate future multi-format event scenarios. Have find
validate argument matching and return error pointers to cover when
an existing event has the same name but different format. Update
callers to handle error pointer logic.

Move delete_user_event() to use hash walking directly now that
find_user_event() has changed. Delete all events found that match the
register name, stop if an error occurs and report back to the user.

Update user_fields_match() to cover list_empty() scenarios now that
find_user_event() uses it directly. This makes the logic consistent
accross several callsites.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 107 +++++++++++++++++--------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9365ce407426..dda58681247e 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -202,6 +202,8 @@ static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
 static void user_event_mm_put(struct user_event_mm *mm);
 static int destroy_user_event(struct user_event *user);
+static bool user_fields_match(struct user_event *user, int argc,
+			      const char **argv);
 
 static u32 user_event_key(char *name)
 {
@@ -1493,17 +1495,24 @@ static int destroy_user_event(struct user_event *user)
 }
 
 static struct user_event *find_user_event(struct user_event_group *group,
-					  char *name, u32 *outkey)
+					  char *name, int argc, const char **argv,
+					  u32 flags, u32 *outkey)
 {
 	struct user_event *user;
 	u32 key = user_event_key(name);
 
 	*outkey = key;
 
-	hash_for_each_possible(group->register_table, user, node, key)
-		if (!strcmp(EVENT_NAME(user), name))
+	hash_for_each_possible(group->register_table, user, node, key) {
+		if (strcmp(EVENT_NAME(user), name))
+			continue;
+
+		if (user_fields_match(user, argc, argv))
 			return user_event_get(user);
 
+		return ERR_PTR(-EADDRINUSE);
+	}
+
 	return NULL;
 }
 
@@ -1860,6 +1869,9 @@ static bool user_fields_match(struct user_event *user, int argc,
 	struct list_head *head = &user->fields;
 	int i = 0;
 
+	if (argc == 0)
+		return list_empty(head);
+
 	list_for_each_entry_reverse(field, head, link) {
 		if (!user_field_match(field, argc, argv, &i))
 			return false;
@@ -1880,10 +1892,8 @@ static bool user_event_match(const char *system, const char *event,
 	match = strcmp(EVENT_NAME(user), event) == 0 &&
 		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
 
-	if (match && argc > 0)
+	if (match)
 		match = user_fields_match(user, argc, argv);
-	else if (match && argc == 0)
-		match = list_empty(&user->fields);
 
 	return match;
 }
@@ -1922,11 +1932,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
 			    struct user_event **newuser, int reg_flags)
 {
-	int ret;
-	u32 key;
 	struct user_event *user;
+	char **argv = NULL;
 	int argc = 0;
-	char **argv;
+	int ret;
+	u32 key;
 
 	/* Currently don't support any text based flags */
 	if (flags != NULL)
@@ -1935,41 +1945,34 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	if (!user_event_capable(reg_flags))
 		return -EPERM;
 
+	if (args) {
+		argv = argv_split(GFP_KERNEL, args, &argc);
+
+		if (!argv)
+			return -ENOMEM;
+	}
+
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
-	user = find_user_event(group, name, &key);
+	user = find_user_event(group, name, argc, (const char **)argv,
+			       reg_flags, &key);
 	mutex_unlock(&event_mutex);
 
-	if (user) {
-		if (args) {
-			argv = argv_split(GFP_KERNEL, args, &argc);
-			if (!argv) {
-				ret = -ENOMEM;
-				goto error;
-			}
+	if (argv)
+		argv_free(argv);
 
-			ret = user_fields_match(user, argc, (const char **)argv);
-			argv_free(argv);
-
-		} else
-			ret = list_empty(&user->fields);
-
-		if (ret) {
-			*newuser = user;
-			/*
-			 * Name is allocated by caller, free it since it already exists.
-			 * Caller only worries about failure cases for freeing.
-			 */
-			kfree(name);
-		} else {
-			ret = -EADDRINUSE;
-			goto error;
-		}
+	if (IS_ERR(user))
+		return PTR_ERR(user);
+
+	if (user) {
+		*newuser = user;
+		/*
+		 * Name is allocated by caller, free it since it already exists.
+		 * Caller only worries about failure cases for freeing.
+		 */
+		kfree(name);
 
 		return 0;
-error:
-		user_event_put(user, false);
-		return ret;
 	}
 
 	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
@@ -2052,25 +2055,33 @@ static int user_event_parse(struct user_event_group *group, char *name,
 }
 
 /*
- * Deletes a previously created event if it is no longer being used.
+ * Deletes previously created events if they are no longer being used.
  */
 static int delete_user_event(struct user_event_group *group, char *name)
 {
-	u32 key;
-	struct user_event *user = find_user_event(group, name, &key);
+	struct user_event *user;
+	struct hlist_node *tmp;
+	u32 key = user_event_key(name);
+	int ret = -ENOENT;
 
-	if (!user)
-		return -ENOENT;
+	/* Attempt to delete all event(s) with the name passed in */
+	hash_for_each_possible_safe(group->register_table, user, tmp, node, key) {
+		if (strcmp(EVENT_NAME(user), name))
+			continue;
 
-	user_event_put(user, true);
+		if (!user_event_last_ref(user))
+			return -EBUSY;
 
-	if (!user_event_last_ref(user))
-		return -EBUSY;
+		if (!user_event_capable(user->reg_flags))
+			return -EPERM;
 
-	if (!user_event_capable(user->reg_flags))
-		return -EPERM;
+		ret = destroy_user_event(user);
 
-	return destroy_user_event(user);
+		if (ret)
+			goto out;
+	}
+out:
+	return ret;
 }
 
 /*
-- 
2.34.1


