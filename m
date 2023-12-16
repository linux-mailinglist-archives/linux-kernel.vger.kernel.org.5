Return-Path: <linux-kernel+bounces-2055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1306815758
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7871C243D3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39621E4A7;
	Sat, 16 Dec 2023 04:21:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB11A28E;
	Sat, 16 Dec 2023 04:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A30FC433B6;
	Sat, 16 Dec 2023 04:21:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rEMCL-00000002yGF-1QzQ;
	Fri, 15 Dec 2023 23:22:45 -0500
Message-ID: <20231216042245.133638178@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 23:22:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 12/15] ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs
References: <20231216042214.905262999@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Mathieu Desnoyers pointed out an issue in the rb_time_cmpxchg() for 32 bit
architectures. That is:

 static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
	unsigned long cnt, top, bottom, msb;
	unsigned long cnt2, top2, bottom2, msb2;
	u64 val;

	/* The cmpxchg always fails if it interrupted an update */
	 if (!__rb_time_read(t, &val, &cnt2))
		 return false;

	 if (val != expect)
		 return false;

<<<< interrupted here!

	 cnt = local_read(&t->cnt);

The problem is that the synchronization counter in the rb_time_t is read
*after* the value of the timestamp is read. That means if an interrupt
were to come in between the value being read and the counter being read,
it can change the value and the counter and the interrupted process would
be clueless about it!

The counter needs to be read first and then the value. That way it is easy
to tell if the value is stale or not. If the counter hasn't been updated,
then the value is still good.

Link: https://lore.kernel.org/linux-trace-kernel/20231211201324.652870-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/linux-trace-kernel/20231212115301.7a9c9a64@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 10464b4aa605e ("ring-buffer: Add rb_time_t 64 bit operations for speeding up 32 bit")
Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ad4af0cba159..b8ab0557bd1b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -706,6 +706,9 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	unsigned long cnt2, top2, bottom2, msb2;
 	u64 val;
 
+	/* Any interruptions in this function should cause a failure */
+	cnt = local_read(&t->cnt);
+
 	/* The cmpxchg always fails if it interrupted an update */
 	 if (!__rb_time_read(t, &val, &cnt2))
 		 return false;
@@ -713,7 +716,6 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	 if (val != expect)
 		 return false;
 
-	 cnt = local_read(&t->cnt);
 	 if ((cnt & 3) != cnt2)
 		 return false;
 
-- 
2.42.0



