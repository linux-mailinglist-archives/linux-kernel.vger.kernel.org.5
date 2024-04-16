Return-Path: <linux-kernel+bounces-147700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FBD8A77EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A27B2849A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73613A3EF;
	Tue, 16 Apr 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZBe7aqK7"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14E313777C;
	Tue, 16 Apr 2024 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307271; cv=none; b=GsOYRu35QJnumOaK+ADDFr4IPuWId7cyPz6pZMk3H8qHTV64vDa24GcTJgD4H1Qv8nP4XebQujrt1PoFYpmdTWhYtPHKSltYIicE0JWs+yt8vdMdra7P00mxmwUvVB36Wsm0cB+y3dhUVrm9FC8WRoVRpRt+vPMs9mIMarXp2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307271; c=relaxed/simple;
	bh=dEMeNbiGcJkTmHBlkEheKf/NQ6fLQMhVAPpQ+UzB0yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R9RHUHGcJAOl+ZsR6MRiHj9Bp0MmHPOzZiyEr3OpGbnht2gtvOc8Kc9oqVR1h0LeXxr9TX8WxiDca4ePk0fFro0fBIQf/r9tLG5m7UB7hhNl2bXF7Hfs3sUmjWU31ryZH3idwfW9PduS4Rpk1AgL6IIKKTKQrr19cOwIpatRmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZBe7aqK7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4647D20FD479;
	Tue, 16 Apr 2024 15:41:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4647D20FD479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713307269;
	bh=dSrv7BpYFAq4ZUURseFkXOC1yBAm1YhNBa+55AKOBxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBe7aqK7rnOawlKCwF5mfw4bZAIzGbU3nYGowjR4CLM49RBaZcOWGZz1O6uQrJXBc
	 K2IWl5I0mFCynJAziQbSeuH1UgUMg8Owo9d5dTNm+/04ah+A6Ie0vMvov+BkzC5zXc
	 RwFI9qlfa+HJeQGQO155mQeerk4GxeL01pJuyMS4=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dcook@linux.microsoft.com
Subject: [PATCH 1/2] tracing/user_events: Fix non-spaced field matching
Date: Tue, 16 Apr 2024 22:41:01 +0000
Message-Id: <20240416224102.734-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416224102.734-1-beaub@linux.microsoft.com>
References: <20240416224102.734-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ABI was updated to prevent same name w/different args, it
missed an important corner case when fields don't end with a space.
Typically, space is used for fields to help separate them, like
"u8 field1; u8 field2". If no spaces are used, like
"u8 field1;u8 field2", then the parsing works for the first time.
However, the match check fails on a subsequent register, leading to
confusion.

This is because the match check uses argv_split() and assumes that all
fields will be split upon the space. When spaces are used, we get back
{ "u8", "field1;" }, without spaces we get back { "u8", "field1;u8" }.
This causes a mismatch, and the user program gets back -EADDRINUSE.

Add a method to detect this case before calling argv_split(). If found
force a space after the field separator character ';'. This ensures all
cases work properly for matching.

With this fix, the following are all treated as matching:
u8 field1;u8 field2
u8 field1; u8 field2
u8 field1;\tu8 field2
u8 field1;\nu8 field2

Fixes: ba470eebc2f6 ("tracing/user_events: Prevent same name but different args event")
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 88 +++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 70d428c394b6..9184d3962b2a 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1989,6 +1989,92 @@ static int user_event_set_tp_name(struct user_event *user)
 	return 0;
 }
 
+/*
+ * Counts how many ';' without a trailing space are in the args.
+ */
+static int count_semis_no_space(char *args)
+{
+	int count = 0;
+
+	while ((args = strchr(args, ';'))) {
+		args++;
+
+		if (!isspace(*args))
+			count++;
+	}
+
+	return count;
+}
+
+/*
+ * Copies the arguments while ensuring all ';' have a trailing space.
+ */
+static char *fix_semis_no_space(char *args, int count)
+{
+	char *fixed, *pos;
+	char c, last;
+	int len;
+
+	len = strlen(args) + count;
+	fixed = kmalloc(len + 1, GFP_KERNEL);
+
+	if (!fixed)
+		return NULL;
+
+	pos = fixed;
+	last = '\0';
+
+	while (len > 0) {
+		c = *args++;
+
+		if (last == ';' && !isspace(c)) {
+			*pos++ = ' ';
+			len--;
+		}
+
+		if (len > 0) {
+			*pos++ = c;
+			len--;
+		}
+
+		last = c;
+	}
+
+	/*
+	 * len is the length of the copy excluding the null.
+	 * This ensures we always have room for a null.
+	 */
+	*pos = '\0';
+
+	return fixed;
+}
+
+static char **user_event_argv_split(char *args, int *argc)
+{
+	/* Count how many ';' without a trailing space */
+	int count = count_semis_no_space(args);
+
+	if (count) {
+		/* We must fixup 'field;field' to 'field; field' */
+		char *fixed = fix_semis_no_space(args, count);
+		char **split;
+
+		if (!fixed)
+			return NULL;
+
+		/* We do a normal split afterwards */
+		split = argv_split(GFP_KERNEL, fixed, argc);
+
+		/* We can free since argv_split makes a copy */
+		kfree(fixed);
+
+		return split;
+	}
+
+	/* No fixup is required */
+	return argv_split(GFP_KERNEL, args, argc);
+}
+
 /*
  * Parses the event name, arguments and flags then registers if successful.
  * The name buffer lifetime is owned by this method for success cases only.
@@ -2012,7 +2098,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 		return -EPERM;
 
 	if (args) {
-		argv = argv_split(GFP_KERNEL, args, &argc);
+		argv = user_event_argv_split(args, &argc);
 
 		if (!argv)
 			return -ENOMEM;
-- 
2.34.1


