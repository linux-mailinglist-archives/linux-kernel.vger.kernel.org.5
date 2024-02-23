Return-Path: <linux-kernel+bounces-77628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F8586083F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CEF1C21D32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97FEB66C;
	Fri, 23 Feb 2024 01:31:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA482C9E;
	Fri, 23 Feb 2024 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651913; cv=none; b=NVWNr7TBS7cuB1UlCsMQlKomQd+6B7uRMXdXELEmQGoLPNXHtm7p5ZbV6fQrUnVzwZ2gExHoTvr5vroW5SHuW1lOKjsm4HbN+ADiepkPZGOvNOJd2yynZzhR21OIIUzx2JdIAyJDislNxzMZIODo6r9YUBSM5g0OQ7+Ov2+rZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651913; c=relaxed/simple;
	bh=4NKBpeaolII1sBupq/IxTuoIHTKsguTYUdtlaE5KXXQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WHPhmHMCVUaFXBdBSoW9KAK31QxLqpAQrqw1tX4C4Am8PqDxEwCEQihhBhbnS+AcPS0LBvRXtCkG//weOW7/zNEut5UDscK7K8noIptkO3mMKn0uHDoTi396D2hoStWL8qXQu+ri6rb2giGji2+fUYi6mNed/YCGK9MqG2kWvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CF8C43390;
	Fri, 23 Feb 2024 01:31:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdKRc-00000006ogb-3daK;
	Thu, 22 Feb 2024 20:33:44 -0500
Message-ID: <20240223013344.729055907@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 20:33:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH 2/2] tracing: Decrement the snapshot if the snapshot trigger fails to
 register
References: <20240223013323.798805901@goodmis.org>
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



