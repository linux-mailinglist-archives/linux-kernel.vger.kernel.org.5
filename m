Return-Path: <linux-kernel+bounces-5841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A91D81900A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABEF2879A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB14C3C69F;
	Tue, 19 Dec 2023 18:55:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110043A29B;
	Tue, 19 Dec 2023 18:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B60C433C9;
	Tue, 19 Dec 2023 18:55:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFfGX-00000003R3L-47qm;
	Tue, 19 Dec 2023 13:56:29 -0500
Message-ID: <20231219185629.763664788@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 13:54:22 -0500
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
Subject: [PATCH v5 08/15] ring-buffer: Make sure the spare sub buffer used for reads has same
 size
References: <20231219185414.474197117@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that the ring buffer specifies the size of its sub buffers, they all
need to be the same size. When doing a read, a swap is done with a spare
page. Make sure they are the same size before doing the swap, otherwise
the read will fail.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 711095aa731d..4dcdc30aa110 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7582,6 +7582,7 @@ struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
 	unsigned int		spare_cpu;
+	unsigned int		spare_size;
 	unsigned int		read;
 };
 
@@ -8301,6 +8302,15 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
 
+	/* Make sure the spare matches the current sub buffer size */
+	if (info->spare) {
+		if (page_size != info->spare_size) {
+			ring_buffer_free_read_page(iter->array_buffer->buffer,
+						   info->spare_cpu, info->spare);
+			info->spare = NULL;
+		}
+	}
+
 	if (!info->spare) {
 		info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer,
 							  iter->cpu_file);
@@ -8309,6 +8319,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 			info->spare = NULL;
 		} else {
 			info->spare_cpu = iter->cpu_file;
+			info->spare_size = page_size;
 		}
 	}
 	if (!info->spare)
-- 
2.42.0



