Return-Path: <linux-kernel+bounces-8737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5D81BB90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E3DB25EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67A651A9;
	Thu, 21 Dec 2023 16:10:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376364AB3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34733C433C7;
	Thu, 21 Dec 2023 16:10:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rGLda-000000041Ma-0nq3;
	Thu, 21 Dec 2023 11:11:06 -0500
Message-ID: <20231221161105.976193556@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 21 Dec 2023 11:10:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [for-next][PATCH 13/16] ring-buffer: Add documentation on the buffer_subbuf_order file
References: <20231221161024.478795180@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add to the documentation how to use the buffer_subbuf_order file to change
the size and how it affects what events can be added to the ring buffer.

Link: https://lore.kernel.org/linux-trace-kernel/20231219185631.230636734@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 23572f6697c0..231d26ceedb0 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -203,6 +203,33 @@ of ftrace. Here is a list of some of the key files:
 
 	This displays the total combined size of all the trace buffers.
 
+  buffer_subbuf_order:
+
+	This sets or displays the sub buffer page size order. The ring buffer
+	is broken up into several same size "sub buffers". An event can not be
+	bigger than the size of the sub buffer. Normally, the sub buffer is
+	the size of the architecture's page (4K on x86). The sub buffer also
+	contains meta data at the start which also limits the size of an event.
+	That means when the sub buffer is a page size, no event can be larger
+	than the page size minus the sub buffer meta data.
+
+	The buffer_subbuf_order allows the user to change the size of the sub
+	buffer. As the sub buffer is a set of pages by the power of 2, thus
+	the sub buffer total size is defined by the order:
+
+	order		size
+	----		----
+	0		PAGE_SIZE
+	1		PAGE_SIZE * 2
+	2		PAGE_SIZE * 4
+	3		PAGE_SIZE * 8
+
+	Changing the order will change the sub buffer size allowing for events
+	to be larger than the page size.
+
+	Note: When changing the order, tracing is stopped and any data in the
+	ring buffer and the snapshot buffer will be discarded.
+
   free_buffer:
 
 	If a process is performing tracing, and the ring buffer	should be
-- 
2.42.0



