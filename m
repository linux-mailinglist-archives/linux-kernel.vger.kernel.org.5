Return-Path: <linux-kernel+bounces-78457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8588613C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B561F23552
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A181AD8;
	Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2180BE3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697829; cv=none; b=OCrSnxER5Aai7PvPmlnHKPeOGoDPkRUs/2dTszJ+WSnz42hjj6FmPn7IY3bs0PI/t4lnwTb8a6NU0WEN4f3t54rbOdngnVWzWZv0F6qNKbwCXVQkf/98Js4x2Ycne3Ihjrc/j15pcbSMOpfRwCHlJFY3QMoATXDtpoAY8q6T8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697829; c=relaxed/simple;
	bh=nKcWAWVRnB8xYWN/oRCb/6ODPrdVBFq4pB5n9Mp0FBY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cZDCSNvcI0DrMUbxldcgcyKfzhULlPsmnTHOxmc0+ccTWnkoiHjw7D0env7jmKAeJjl7lMmr1Op6Z4W6OFoVFqsWFk7g33xJJPXc6VNba1crGedmYA/2FXXBPUEkCFg1PYlxQO20BXPfQQCZ5BzT16vTzT8+MCwRxgGFzf4hys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0AEC43390;
	Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOE-000000077Mi-0sLR;
	Fri, 23 Feb 2024 09:19:02 -0500
Message-ID: <20240223141902.070244243@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 04/13] tracing/user_events: Document multi-format flag
References: <20240223141838.985298316@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Beau Belgrave <beaub@linux.microsoft.com>

User programs can now ask user_events to handle the synchronization of
multiple different formats for an event with the same name via the new
USER_EVENT_REG_MULTI_FORMAT flag.

Add a section for USER_EVENT_REG_MULTI_FORMAT that explains the intended
purpose and caveats of using it. Explain how deletion works in these
cases and how to use /sys/kernel/tracing/dynamic_events for per-version
deletion.

Link: https://lore.kernel.org/linux-trace-kernel/20240222001807.1463-5-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.43.0



