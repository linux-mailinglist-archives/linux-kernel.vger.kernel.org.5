Return-Path: <linux-kernel+bounces-36117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BB839BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945CE1F27549
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B76F4F5F1;
	Tue, 23 Jan 2024 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gZZTReHY"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165574EB29;
	Tue, 23 Jan 2024 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047734; cv=none; b=LK6H7rTkB+6INVU4b9NN1YC3C8AP6PfhBLhL69a+wv0syfb9lOLOTsrL0rc0mIhC/6eydczhwOJ0CkmWHDd+vdpz1mIB3gasyIgheOmTkfZnkUdfWN3X/SSyXdXWbLUrHBlBphe+GGA8V78UM+S5K3EwLUmIDzSL0AafTV2XSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047734; c=relaxed/simple;
	bh=9Te8QU109FsYKMNcMkhy+Bclgt8khwJD6YzkbbvpwMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvHzUmxa0mNjN3R/GorjOdYy8aV7DunyRfeYrRlwMAtrrhO8M+KI9PEf0Stltcl4HTNZhHae4JTeVXuWrcEWnMsM+STbb2Do0P+0Iwmhl3oXcRdZnQZnvKCsoI7WGADSXt36nCDvauh0u6QL/56IxR2vVZ9YTSIGLnE8ssD7Ibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gZZTReHY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id B9CDA20E34D5;
	Tue, 23 Jan 2024 14:08:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9CDA20E34D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706047732;
	bh=0fCWA/SN48M3Zr4NtfVQYGw5i7hQZH5sCYXSJj4x1m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZZTReHYHK0CpgO6hJ/5UKbbE8d6V9JEOrNc1YZ1PrKSNKZxheyzwUxV3MueGSzsc
	 VzlIuP8bN/soQ5DZUUv6DTrHEYzvcuv05Z1Kk4trQ+Me8PphQdPqvMfaNurUP8DanE
	 b+fU8gPgKO01A1GjGI3AOurQFfPQMotsJi49G7k4=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH 4/4] tracing/user_events: Document multi-format flag
Date: Tue, 23 Jan 2024 22:08:44 +0000
Message-Id: <20240123220844.928-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123220844.928-1-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
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
 Documentation/trace/user_events.rst | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index d8f12442aaa6..35a2524bc73c 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -92,6 +92,20 @@ The following flags are currently supported.
   process closes or unregisters the event. Requires CAP_PERFMON otherwise
   -EPERM is returned.
 
++ USER_EVENT_REG_MULTI_FORMAT: The event can contain multiple formats. This
+  allows programs to prevent themselves from being blocked when their event
+  format changes and they wish to use the same name. When this flag is used the
+  tracepoint name will be in the new format of "name:[unique_id]" vs the older
+  format of "name". A tracepoint will be created for each unique pair of name
+  and format. This means if several processes use the same name and format,
+  they will use the same tracepoint. If yet another process uses the same name,
+  but a different format than the other processes, it will use a different
+  tracepoint with a new unique id. Recording programs need to scan tracefs for
+  the various different formats of the event name they are interested in
+  recording. The system name of the tracepoint will also use "user_events_multi"
+  instead of "user_events". This prevents single-format event names conflicting
+  with any multi-format event names within tracefs.
+
 Upon successful registration the following is set.
 
 + write_index: The index to use for this file descriptor that represents this
@@ -106,6 +120,9 @@ or perf record -e user_events:[name] when attaching/recording.
 **NOTE:** The event subsystem name by default is "user_events". Callers should
 not assume it will always be "user_events". Operators reserve the right in the
 future to change the subsystem name per-process to accommodate event isolation.
+In addition if the USER_EVENT_REG_MULTI_FORMAT flag is used the tracepoint name
+will have a unique id appended to it and the system name will be
+"user_events_multi" as described above.
 
 Command Format
 ^^^^^^^^^^^^^^
@@ -156,7 +173,11 @@ to request deletes than the one used for registration due to this.
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


