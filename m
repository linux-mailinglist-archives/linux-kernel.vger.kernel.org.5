Return-Path: <linux-kernel+bounces-63941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D63885369A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4988A28CC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C75FB94;
	Tue, 13 Feb 2024 16:51:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA05FB90;
	Tue, 13 Feb 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843115; cv=none; b=fYH2UMgqGlLEJxwMGyCHz2yqTIv4nMkDlmgoyuCvJ8VIy4UWtCv+Loy3IPR+KxDMoyBcJVqbpJCQTKXmj6dwOiC7JaAOBRGbGli0y1KQLrRpur16lZSUeasBdQie1egyi8dSK+07x8YTM4z+gMGFzqqN2x8oIaEnXIk2PW1Zmsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843115; c=relaxed/simple;
	bh=pDNrTzFYVWPEbMC4V/M9gXVJh6i7WKDwFhKiB2AoIz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iY+3DlZ8ipU1TY56c92vOQe5VlMmSvatVAtFINe7g1RNo9AMhudyMWUNNQGGLFaXRLJTh8izLLNiL9L42DzFd3LQNzQZ4b730wwWOBnAwiTyUpy2sCZny2JHLQbRloy6pwKPwcmFyJSZXZrbAMBj+cxe2MRTTfTB6uKDB1O8Woo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE644C433C7;
	Tue, 13 Feb 2024 16:51:49 +0000 (UTC)
Date: Tue, 13 Feb 2024 11:52:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Tim
  Chen <tim.c.chen@linux.intel.com>, Vincent Donnefort 
 <vdonnefort@google.com>, Sven Schnelle  <svens@linux.ibm.com>, Mete Durlu 
 <meted@linux.ibm.com>
Subject: [PATCH v2] tracing: Have saved_cmdlines arrays all in one
 allocation
Message-ID: <20240213115232.5fd9e611@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The saved_cmdlines have three arrays for mapping PIDs to COMMs:

 - map_pid_to_cmdline[]
 - map_cmdline_to_pid[]
 - saved_cmdlines

The map_pid_to_cmdline[] is PID_MAX_DEFAULT in size and holds the index
into the other arrays. The map_cmdline_to_pid[] is a mapping back to the
full pid as it can be larger than PID_MAX_DEFAULT. And the
saved_cmdlines[] just holds the COMMs associated to the pids.

Currently the map_pid_to_cmdline[] and saved_cmdlines[] are allocated
together (in reality the saved_cmdlines is just in the memory of the
rounding of the allocation of the structure as it is always allocated in
powers of two). The map_cmdline_to_pid[] array is allocated separately.

Since the rounding to a power of two is rather large (it allows for 8000
elements in saved_cmdlines), also include the map_cmdline_to_pid[] array.
(This drops it to 6000 by default, which is still plenty for most use
cases). This saves even more memory as the map_cmdline_to_pid[] array
doesn't need to be allocated.

Link: https://lore.kernel.org/linux-trace-kernel/20240212174011.068211d9@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240212180941.379c419b@gandalf.local.home/

-- Added SAVED_CMDLINE_MAP_ELEMENT_SIZE helper macro.

 kernel/trace/trace_sched_switch.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e4fbcc3bede5..5f3e9bc87079 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -175,6 +175,10 @@ struct saved_cmdlines_buffer {
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
+/* Holds the size of a cmdline and pid element */
+#define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)			\
+	(TASK_COMM_LEN + sizeof((s)->map_cmdline_to_pid[0]))
+
 static inline char *get_saved_cmdlines(int idx)
 {
 	return &savedcmd->saved_cmdlines[idx * TASK_COMM_LEN];
@@ -201,7 +205,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	int order;
 
 	/* Figure out how much is needed to hold the given number of cmdlines */
-	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
+	orig_size = sizeof(*s) + val * SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
 	order = get_order(orig_size);
 	size = 1 << (order + PAGE_SHIFT);
 	page = alloc_pages(GFP_KERNEL, order);
@@ -212,16 +216,11 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	memset(s, 0, sizeof(*s));
 
 	/* Round up to actual allocation */
-	val = (size - sizeof(*s)) / TASK_COMM_LEN;
+	val = (size - sizeof(*s)) / SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
 	s->cmdline_num = val;
 
-	s->map_cmdline_to_pid = kmalloc_array(val,
-					      sizeof(*s->map_cmdline_to_pid),
-					      GFP_KERNEL);
-	if (!s->map_cmdline_to_pid) {
-		free_saved_cmdlines_buffer(s);
-		return NULL;
-	}
+	/* Place map_cmdline_to_pid array right after saved_cmdlines */
+	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
 
 	s->cmdline_idx = 0;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
-- 
2.43.0


