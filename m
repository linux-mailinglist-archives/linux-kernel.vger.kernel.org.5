Return-Path: <linux-kernel+bounces-50439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6328B8478FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9291C27A23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4848173B;
	Fri,  2 Feb 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ChIloMUd"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054980630;
	Fri,  2 Feb 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899501; cv=none; b=V2dO+QXrxW7SkDZRK5M3bF8VyAfEEXnE9uBUa1Q0CYsIDSWIE7sFR5NbsuUBFNYZkh6N2i4/4QjajKhgUY3j4CuJfJyibjKg1qhJ4zCBJ7pBMjE1GvbY1PPzyKmY9XfsLjXM2WmveQf6/V5/jufnTWxCGNToHUATa2aSkGalgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899501; c=relaxed/simple;
	bh=1n+POexB4IxIKN4NogGOvLi6IfL+92Wk9tP/cRbJstg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BepaPCQWKJ6MRy1et/o/j96mJCqxjhZVa2zt37dR49+hrmXxabvbH6x30aYpMBPoVOBHPybyP53KtONM81dkbMzWTmxcrlP9nBipQs+yN2FS+3xGJ6G+79ntX3THJc5ZIRgXWg9qfKhRKvBvHWZy689Qz2p2VjfSAwGjpwMHpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ChIloMUd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.115])
	by linux.microsoft.com (Postfix) with ESMTPSA id F24EA20B2004;
	Fri,  2 Feb 2024 10:44:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F24EA20B2004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706899499;
	bh=9VOCGDdI8wf7ppg3CttBYebJqIACHcsfFVDg2ERPXoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChIloMUd7Yz15+MUeaAt+evM/yKzUa9w93jRRTjQVtaLOdVIgmvoHP8fjPd+/yO8P
	 Q73voyHyfz2JAKH0aaLznSS4grT74qYZBB5wkychvJe0WsJ79hSy8wLwNgAUkUwat3
	 ZGSqUd7CAoF7XRQKb/wFZmqyZGEB4VyyUq4ug4ak=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v2 4/4] tracing/user_events: Document multi-format flag
Date: Fri,  2 Feb 2024 18:44:49 +0000
Message-Id: <20240202184449.1674-5-beaub@linux.microsoft.com>
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

User programs can now ask user_events to handle the synchronization of
multiple different formats for an event with the same name via the new
USER_EVENT_REG_MULTI_FORMAT flag.

Add a section for USER_EVENT_REG_MULTI_FORMAT that explains the intended
purpose and caveats of using it. Explain how deletion works in these
cases and how to use /sys/kernel/tracing/dynamic_events for per-version
deletion.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 Documentation/trace/user_events.rst | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index d8f12442aaa6..1d5a7626e6a6 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -92,6 +92,24 @@ The following flags are currently supported.
   process closes or unregisters the event. Requires CAP_PERFMON otherwise
   -EPERM is returned.
 
++ USER_EVENT_REG_MULTI_FORMAT: The event can contain multiple formats. This
+  allows programs to prevent themselves from being blocked when their event
+  format changes and they wish to use the same name. When this flag is used the
+  tracepoint name will be in the new format of "name.unique_id" vs the older
+  format of "name". A tracepoint will be created for each unique pair of name
+  and format. This means if several processes use the same name and format,
+  they will use the same tracepoint. If yet another process uses the same name,
+  but a different format than the other processes, it will use a different
+  tracepoint with a new unique id. Recording programs need to scan tracefs for
+  the various different formats of the event name they are interested in
+  recording. The system name of the tracepoint will also use "user_events_multi"
+  instead of "user_events". This prevents single-format event names conflicting
+  with any multi-format event names within tracefs. The unique_id is output as
+  a hex string. Recording programs should ensure the tracepoint name starts with
+  the event name they registered and has a suffix that starts with . and only
+  has hex characters. For example to find all versions of the event "test" you
+  can use the regex "^test\.[0-9a-fA-F]+$".
+
 Upon successful registration the following is set.
 
 + write_index: The index to use for this file descriptor that represents this
@@ -106,6 +124,9 @@ or perf record -e user_events:[name] when attaching/recording.
 **NOTE:** The event subsystem name by default is "user_events". Callers should
 not assume it will always be "user_events". Operators reserve the right in the
 future to change the subsystem name per-process to accommodate event isolation.
+In addition if the USER_EVENT_REG_MULTI_FORMAT flag is used the tracepoint name
+will have a unique id appended to it and the system name will be
+"user_events_multi" as described above.
 
 Command Format
 ^^^^^^^^^^^^^^
@@ -156,7 +177,11 @@ to request deletes than the one used for registration due to this.
 to the event. If programs do not want auto-delete, they must use the
 USER_EVENT_REG_PERSIST flag when registering the event. Once that flag is used
 the event exists until DIAG_IOCSDEL is invoked. Both register and delete of an
-event that persists requires CAP_PERFMON, otherwise -EPERM is returned.
+event that persists requires CAP_PERFMON, otherwise -EPERM is returned. When
+there are multiple formats of the same event name, all events with the same
+name will be attempted to be deleted. If only a specific version is wanted to
+be deleted then the /sys/kernel/tracing/dynamic_events file should be used for
+that specific format of the event.
 
 Unregistering
 -------------
-- 
2.34.1


