Return-Path: <linux-kernel+bounces-5840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D7819008
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78211F220F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D2339FE0;
	Tue, 19 Dec 2023 18:55:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021739AC5;
	Tue, 19 Dec 2023 18:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE7CC433C7;
	Tue, 19 Dec 2023 18:55:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFfGX-00000003R2L-1frl;
	Tue, 19 Dec 2023 13:56:29 -0500
Message-ID: <20231219185629.179352802@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 13:54:20 -0500
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
Subject: [PATCH v5 06/15] ring-buffer: Clear pages on error in ring_buffer_subbuf_order_set()
 failure
References: <20231219185414.474197117@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

On failure to allocate ring buffer pages, the pointer to the CPU buffer
pages is freed, but the pages that were allocated previously were not.
Make sure they are freed too.

Fixes: TBD ("tracing: Set new size of the ring buffer sub page")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c2afcf98ea91..3c11e8e811ed 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5927,6 +5927,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	for_each_buffer_cpu(buffer, cpu) {
 		if (!cpu_buffers[cpu])
 			continue;
+		rb_free_cpu_buffer(cpu_buffers[cpu]);
 		kfree(cpu_buffers[cpu]);
 	}
 	kfree(cpu_buffers);
-- 
2.42.0



