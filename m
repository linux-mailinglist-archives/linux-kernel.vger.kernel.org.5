Return-Path: <linux-kernel+bounces-5848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D98E819013
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD93B24D19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E0405FA;
	Tue, 19 Dec 2023 18:55:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2D3DBA3;
	Tue, 19 Dec 2023 18:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCB1C433C9;
	Tue, 19 Dec 2023 18:55:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFfGZ-00000003R5q-1toW;
	Tue, 19 Dec 2023 13:56:31 -0500
Message-ID: <20231219185631.230636734@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 13:54:27 -0500
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
Subject: [PATCH v5 13/15] ring-buffer: Add documentation on the buffer_subbuf_order file
References: <20231219185414.474197117@goodmis.org>
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



