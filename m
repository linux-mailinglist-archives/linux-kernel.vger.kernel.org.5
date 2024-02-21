Return-Path: <linux-kernel+bounces-74859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E385DDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B881F28561C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54657F7FD;
	Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC507C093
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524400; cv=none; b=L5pUz7jf49PSE6wz4PG3UvTIgFucHY5GJbS8y+BaYubmLT9akHHHE2At4VKcvm//19KMfpQZXN8Wgx30KXfn0ghNukNwsFT+E60v2G58Ty1Cv1lo8xN186Oyw18CTjRlY+8+6dUx1lYS/JNsziAWGhMl/vxqa1xId+TNhWelJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524400; c=relaxed/simple;
	bh=dbYZpa01gBm8dnFQ3bsiWZKxefe6r9i28byH8LL9dDg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qEVUEcnpKzPtdwi1erzS513TB+dXEfPYPrryZ8SQGqZNmXMI78e0h1VePJ043q9NZCvJt6IGfWAp/vlLYSfZH6caSHaBAL6Ci/I9xc+RBGqTFSJhp0i/A8j+ZRQ5j8mz7jPE4mI4qToKtlvFk39MruHBnTgR9/S/OIB4Z4qflWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C281C43601;
	Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rcnGu-00000002i8O-21Kr;
	Wed, 21 Feb 2024 09:08:28 -0500
Message-ID: <20240221140828.346521235@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 21 Feb 2024 09:07:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>
Subject: [for-next][PATCH 03/11] tracing: Have saved_cmdlines arrays all in one allocation
References: <20240221140756.797572998@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
Link: https://lore.kernel.org/linux-trace-kernel/20240220140703.182330529@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Mete Durlu <meted@linux.ibm.com>
Fixes: 44dc5c41b5b1 ("tracing: Fix wasted memory in saved_cmdlines logic")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8198bfc54b58..52faa30e64ed 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2325,6 +2325,10 @@ struct saved_cmdlines_buffer {
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
+/* Holds the size of a cmdline and pid element */
+#define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)			\
+	(TASK_COMM_LEN + sizeof((s)->map_cmdline_to_pid[0]))
+
 static inline char *get_saved_cmdlines(int idx)
 {
 	return &savedcmd->saved_cmdlines[idx * TASK_COMM_LEN];
@@ -2339,7 +2343,6 @@ static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
 {
 	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
 
-	kfree(s->map_cmdline_to_pid);
 	kmemleak_free(s);
 	free_pages((unsigned long)s, order);
 }
@@ -2352,7 +2355,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	int order;
 
 	/* Figure out how much is needed to hold the given number of cmdlines */
-	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
+	orig_size = sizeof(*s) + val * SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
 	order = get_order(orig_size);
 	size = 1 << (order + PAGE_SHIFT);
 	page = alloc_pages(GFP_KERNEL, order);
@@ -2364,16 +2367,11 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
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



