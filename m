Return-Path: <linux-kernel+bounces-8732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AAC81BB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B00A1F2383B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E1462801;
	Thu, 21 Dec 2023 16:10:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E335992C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B3CC116B3;
	Thu, 21 Dec 2023 16:10:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rGLdY-000000041JZ-1nnd;
	Thu, 21 Dec 2023 11:11:04 -0500
Message-ID: <20231221161104.201002261@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 21 Dec 2023 11:10:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [for-next][PATCH 07/16] ring-buffer: Do no swap cpu buffers if order is different
References: <20231221161024.478795180@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As all the subbuffer order (subbuffer sizes) must be the same throughout
the ring buffer, check the order of the buffers that are doing a CPU
buffer swap in ring_buffer_swap_cpu() to make sure they are the same.

If the are not the same, then fail to do the swap, otherwise the ring
buffer will think the CPU buffer has a specific subbuffer size when it
does not.

Link: https://lore.kernel.org/linux-trace-kernel/20231219185629.467894710@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3c11e8e811ed..fdcd171b09b5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5417,6 +5417,9 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
 
+	if (buffer_a->subbuf_order != buffer_b->subbuf_order)
+		goto out;
+
 	ret = -EAGAIN;
 
 	if (atomic_read(&buffer_a->record_disabled))
-- 
2.42.0



