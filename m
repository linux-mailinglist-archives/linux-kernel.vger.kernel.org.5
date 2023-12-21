Return-Path: <linux-kernel+bounces-8734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB5F81BB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CACE1F212B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202C63515;
	Thu, 21 Dec 2023 16:10:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE2634E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522E4C433CA;
	Thu, 21 Dec 2023 16:10:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rGLdZ-000000041L3-1Jnc;
	Thu, 21 Dec 2023 11:11:05 -0500
Message-ID: <20231221161105.083563911@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 21 Dec 2023 11:10:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [for-next][PATCH 10/16] tracing: Stop the tracing while changing the ring buffer subbuf size
References: <20231221161024.478795180@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Because the main buffer and the snapshot buffer need to be the same for
some tracers, otherwise it will fail and disable all tracing, the tracers
need to be stopped while updating the sub buffer sizes so that the tracers
see the main and snapshot buffers with the same sub buffer size.

Link: https://lore.kernel.org/linux-trace-kernel/20231219185630.353222794@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Fixes: 2808e31ec12e ("ring-buffer: Add interface for configuring trace sub buffer size")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2439e00aa4ce..82303bd2bba1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9412,13 +9412,16 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 	if (val < 0 || val > 7)
 		return -EINVAL;
 
+	/* Do not allow tracing while changing the order of the ring buffer */
+	tracing_stop_tr(tr);
+
 	old_order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
 	if (old_order == val)
-		return 0;
+		goto out;
 
 	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, val);
 	if (ret)
-		return 0;
+		goto out;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 
@@ -9445,11 +9448,15 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 			 */
 			tracing_disabled = 1;
 		}
-		return ret;
+		goto out;
 	}
  out_max:
 #endif
 	(*ppos)++;
+ out:
+	if (ret)
+		cnt = ret;
+	tracing_start_tr(tr);
 	return cnt;
 }
 
-- 
2.42.0



