Return-Path: <linux-kernel+bounces-2056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B409E815759
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D131F25D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24547250E9;
	Sat, 16 Dec 2023 04:21:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5B1E493
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D64DC433CA;
	Sat, 16 Dec 2023 04:21:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rEMCL-00000002yGk-2eXm;
	Fri, 15 Dec 2023 23:22:45 -0500
Message-ID: <20231216042245.415755764@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 23:22:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 13/15] ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()
References: <20231216042214.905262999@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

The following race can cause rb_time_read() to observe a corrupted time
stamp:

rb_time_cmpxchg()
[...]
        if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
                return false;
        if (!rb_time_read_cmpxchg(&t->top, top, top2))
                return false;
<interrupted before updating bottom>
__rb_time_read()
[...]
        do {
                c = local_read(&t->cnt);
                top = local_read(&t->top);
                bottom = local_read(&t->bottom);
                msb = local_read(&t->msb);
        } while (c != local_read(&t->cnt));

        *cnt = rb_time_cnt(top);

        /* If top and msb counts don't match, this interrupted a write */
        if (*cnt != rb_time_cnt(msb))
                return false;
          ^ this check fails to catch that "bottom" is still not updated.

So the old "bottom" value is returned, which is wrong.

Fix this by checking that all three of msb, top, and bottom 2-bit cnt
values match.

The reason to favor checking all three fields over requiring a specific
update order for both rb_time_set() and rb_time_cmpxchg() is because
checking all three fields is more robust to handle partial failures of
rb_time_cmpxchg() when interrupted by nested rb_time_set().

Link: https://lore.kernel.org/lkml/20231211201324.652870-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/linux-trace-kernel/20231212193049.680122-1-mathieu.desnoyers@efficios.com

Fixes: f458a1453424e ("ring-buffer: Test last update in 32bit version of __rb_time_read()")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b8ab0557bd1b..f22a849da179 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -644,8 +644,8 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	*cnt = rb_time_cnt(top);
 
-	/* If top and msb counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(msb))
+	/* If top, msb or bottom counts don't match, this interrupted a write */
+	if (*cnt != rb_time_cnt(msb) || *cnt != rb_time_cnt(bottom))
 		return false;
 
 	/* The shift to msb will lose its cnt bits */
-- 
2.42.0



