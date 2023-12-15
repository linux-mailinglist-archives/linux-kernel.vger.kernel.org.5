Return-Path: <linux-kernel+bounces-1485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0A814F51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E227283246
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDA47F65;
	Fri, 15 Dec 2023 17:54:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438346545;
	Fri, 15 Dec 2023 17:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D410C433C8;
	Fri, 15 Dec 2023 17:54:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rECPa-00000002wSI-1PpF;
	Fri, 15 Dec 2023 12:55:46 -0500
Message-ID: <20231215175546.125060181@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 12:55:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v4 10/15] tracing: Stop the tracing while changing the ring buffer subbuf size
References: <20231215175502.106587604@goodmis.org>
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

Fixes: TBD ("ring-buffer: Add interface for configuring trace sub buffer size")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 836514e566c7..b4626c9223a5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9419,13 +9419,16 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
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
 
@@ -9452,11 +9455,15 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
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



