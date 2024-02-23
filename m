Return-Path: <linux-kernel+bounces-78466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37608613CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4488DB21C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED684A35;
	Fri, 23 Feb 2024 14:17:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59482868
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697830; cv=none; b=DJR9dZsa2lDZT1wLEcfyYY4yTjELp0mgF4FUxiZTfCPUWtFRV+ndr9/Uzw+opFa1US3OU5zwGtVsImOcw2imt4vwY+JfsQSa1+V7Ufeq31eNZ/W9g1ZPkiukEAIbHsVN85CJliDANw7I5sVwwIxVgiw2bVWb/P175gZilM80Btg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697830; c=relaxed/simple;
	bh=ZgqLTdRoUVgbCvGQljZzqd+I5mUdqZPv5Wp0Z7wOMSk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j8JK/MMNZsoItuD/rdXWUCWL5FSyKo0hqV9mEgaOXXpfDxRm1cEeDPfhUcesPjXPVeKwKdhyUHwGk/7rj0z5w06p6DWvGEg4ulgwtqldZUKad2MIjWddL07khjvVPPgXHyJi9bW7LcjRl9JQ6DehQ1htYtT+CAQc0cCX6RNAyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65B5C43390;
	Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOF-000000077RA-2jRW;
	Fri, 23 Feb 2024 09:19:03 -0500
Message-ID: <20240223141903.512514224@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 13/13] tracing: Decrement the snapshot if the snapshot trigger fails to
 register
References: <20240223141838.985298316@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Running the ftrace selftests caused the ring buffer mapping test to fail.
Investigating, I found that the snapshot counter would be incremented
every time a snapshot trigger was added, even if that snapshot trigger
failed.

 # cd /sys/kernel/tracing
 # echo "snapshot" > events/sched/sched_process_fork/trigger
 # echo "snapshot" > events/sched/sched_process_fork/trigger
 -bash: echo: write error: File exists

That second one that fails increments the snapshot counter but doesn't
decrement it. It needs to be decremented when the snapshot fails.

Link: https://lore.kernel.org/linux-trace-kernel/20240223013344.729055907@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Fixes: 16f7e48ffc53a ("tracing: Add snapshot refcount")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 62e4f58b8671..4bec043c8690 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1491,7 +1491,10 @@ register_snapshot_trigger(char *glob,
 	if (ret < 0)
 		return ret;
 
-	return register_trigger(glob, data, file);
+	ret = register_trigger(glob, data, file);
+	if (ret < 0)
+		tracing_disarm_snapshot(file->tr);
+	return ret;
 }
 
 static void unregister_snapshot_trigger(char *glob,
-- 
2.43.0



