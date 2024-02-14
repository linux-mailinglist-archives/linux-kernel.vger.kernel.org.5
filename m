Return-Path: <linux-kernel+bounces-65722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B708550CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCFE28894E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F23129A67;
	Wed, 14 Feb 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tGzDrNLn"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C086644;
	Wed, 14 Feb 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933059; cv=none; b=iEtBrxkauEcGE4/aBoeuZJoDgnXKE5bjOxGHtKvXwWI6bhr3/Z+j47FGHC3iTsxewTKx738ton7zsNQmUPVwGli6/epmdRD/AZaorHtG2EWMaCxz2rj/WJKd1m2pAxsToxy3P8L2I3kwYGOJtcu77w3kPAg8kScqlF/lLlWwfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933059; c=relaxed/simple;
	bh=1n+POexB4IxIKN4NogGOvLi6IfL+92Wk9tP/cRbJstg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjjRrzwr7f8WjTxKaxv0IEGH6UErVg2QLfZVuY5NoyR4jY+2Eyd18DkEU8mcxyyZa/6M6gBviZP0vJH1YIe+7IlSB0rjLDEeiEft7GqX/NzAOMdEosmYYOnLKTWCVtF39DATXBYo5g2l7N9kROWz+LQtJaFkMZF5l+dP97btDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tGzDrNLn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id 59AB320B2004;
	Wed, 14 Feb 2024 09:50:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59AB320B2004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707933056;
	bh=9VOCGDdI8wf7ppg3CttBYebJqIACHcsfFVDg2ERPXoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGzDrNLnvdm7wkDwXHHGty2XSx7A6lxBHg7yWMvzCC0UqI+U8U4e2wbJGTtOg3XB/
	 RyKh3ul3asNW9w2nYqGIo8RnajGdnLV/4H3desJ8oatH+EB4pm/PlXaOW8DHN5EOkq
	 e6pXtt2g9uuDLxBsAmBTsGpD4kImHeeEYObSBQVc=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v3 4/4] tracing/user_events: Document multi-format flag
Date: Wed, 14 Feb 2024 17:50:46 +0000
Message-Id: <20240214175046.240-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214175046.240-1-beaub@linux.microsoft.com>
References: <20240214175046.240-1-beaub@linux.microsoft.com>
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


