Return-Path: <linux-kernel+bounces-50441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA08478FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE941F26B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662A81741;
	Fri,  2 Feb 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OaYjw1GI"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04C415E5C3;
	Fri,  2 Feb 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899501; cv=none; b=Qgqh8VvzOaxWBwEjI+0z3BAV4VQnXqjRZufNjqfy5vZA3tVSzTuAD3PNmfMlGmDVix09RRPAKGQvTl5sTor1+/uY0g5fw8I9KHI26CIznpmH2NTh2LU306jVft6iBT1XZEvdGi6Wk4pap8pvBPLM517qbsei6oCKopmqzJ6RQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899501; c=relaxed/simple;
	bh=KenrMU6vAcUiIUu/TZYJLnCdcqT4s32o0HvqsMuQF1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKBlbLA02qNu/djRkaXgl25LSqnzaRjJ4uXQWFUxj71pU23YO1H1p1kAwCkjN+nj7dwoWEIuamG8gxZ3k8QOs1J8CNWPeHkdNT1FY1V8zREyoeYUsY8fpSrxeo6jbIWAgQ5WKCHx4aDP62H2Qynz6lSPKFwVufiGxyBoNqcFM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OaYjw1GI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.115])
	by linux.microsoft.com (Postfix) with ESMTPSA id A4E1320B2001;
	Fri,  2 Feb 2024 10:44:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4E1320B2001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706899498;
	bh=4arN1d1NnrJYcNCC77SrMmzQ3peDQgWS/FWwlKcDITU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaYjw1GI9ueWPT6T2RPGPiB0HCltl9hnCrLv22VwVho0aRdcYzwynuFFM/PpPlNr+
	 GIpqdfWfVyFSbPQNOgBAXJEQL4W1BMsO9VC64oa1yxtOUhKTt9N/bivnEAgxJy+8YW
	 FP2IL3Q/CoMHCSuJnZ7vVy53VBPsNUPdJM1LSvL4=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v2 1/4] tracing/user_events: Prepare find/delete for same name events
Date: Fri,  2 Feb 2024 18:44:46 +0000
Message-Id: <20240202184449.1674-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202184449.1674-1-beaub@linux.microsoft.com>
References: <20240202184449.1674-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code for finding and deleting events assumes that there will
never be cases when user_events are registered with the same name, but
different formats. In the future this scenario will exist to ensure
user programs can be updated or modify their events and run different
versions of their programs side-by-side without being blocked.

This change does not yet allow for multi-format events. If user_events
are registered with the same name but different arguments the programs
see the same return values as before. This change simply makes it
possible to easily accomodate for this in future changes.

Update find_user_event() to take in argument parameters and register
flags to accomodate future multi-format event scenarios. Have find
validate argument matching and return error pointers to cover address
in use cases, or allocation errors. Update callers to handle error
pointer logic.

Move delete_user_event() to use hash walking directly now that find has
changed. Delete all events found that match the register name, stop
if an error occurs and report back to the user.

Update user_fields_match() to cover list_empty() scenarios instead of
each callsite doing it now that find_user_event() uses it directly.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 106 +++++++++++++++++--------------
 1 file changed, 58 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9365ce407426..0480579ba563 100644
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
@@ -2052,25 +2055,32 @@ static int user_event_parse(struct user_event_group *group, char *name,
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
+	u32 key = user_event_key(name);
+	int ret = -ENOENT;
 
-	if (!user)
-		return -ENOENT;
+	/* Attempt to delete all event(s) with the name passed in */
+	hash_for_each_possible(group->register_table, user, node, key) {
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


