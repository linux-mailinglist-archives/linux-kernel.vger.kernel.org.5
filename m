Return-Path: <linux-kernel+bounces-1484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2F814F50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44ED71F2399C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3247783;
	Fri, 15 Dec 2023 17:54:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050D4644A;
	Fri, 15 Dec 2023 17:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1447C433C8;
	Fri, 15 Dec 2023 17:54:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rECPZ-00000002wRI-3Bcg;
	Fri, 15 Dec 2023 12:55:45 -0500
Message-ID: <20231215175545.543297356@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 12:55:10 -0500
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
Subject: [PATCH v4 08/15] ring-buffer: Make sure the spare sub buffer used for reads has same
 size
References: <20231215175502.106587604@goodmis.org>
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
index d4d4e7c7357f..c148797afe6d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7589,6 +7589,7 @@ struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
 	unsigned int		spare_cpu;
+	unsigned int		spare_size;
 	unsigned int		read;
 };
 
@@ -8308,6 +8309,15 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 
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
@@ -8316,6 +8326,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 			info->spare = NULL;
 		} else {
 			info->spare_cpu = iter->cpu_file;
+			info->spare_size = page_size;
 		}
 	}
 	if (!info->spare)
-- 
2.42.0



