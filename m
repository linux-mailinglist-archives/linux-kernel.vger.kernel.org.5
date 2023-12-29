Return-Path: <linux-kernel+bounces-13181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3388200CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B212828DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98012B84;
	Fri, 29 Dec 2023 17:23:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CFA12B6B;
	Fri, 29 Dec 2023 17:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D0FC433C8;
	Fri, 29 Dec 2023 17:23:11 +0000 (UTC)
Date: Fri, 29 Dec 2023 12:24:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] ring-buffer/Documentation: Add documentation on
 buffer_percent file
Message-ID: <20231229122402.537eb252@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When the buffer_percent file was added to the kernel, the documentation
should have been updated to document what that file does.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231226130149.4685c838@gandalf.local.home

- s/watermark/water-mark/ (Randy Dunlap)

- Added '::' and indented the number list so that it has better
  formatting (kernel test robot)

 Documentation/trace/ftrace.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 933e7efb9f1b..917501a2f348 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -180,6 +180,21 @@ of ftrace. Here is a list of some of the key files:
 	Only active when the file contains a number greater than 0.
 	(in microseconds)
 
+  buffer_percent:
+
+	This is the watermark for how much the ring buffer needs to be filled
+	before a waiter is woken up. That is, if an application calls a
+	blocking read syscall on one of the per_cpu trace_pipe_raw files, it
+	will block until the given amount of data specified by buffer_percent
+	is in the ring buffer before it wakes the reader up. This also
+	controls how the splice system calls are blocked on this file::
+
+	  0   - means to wake up as soon as there is any data in the ring buffer.
+	  50  - means to wake up when roughly half of the ring buffer sub-buffers
+	        are full.
+	  100 - means to block until the ring buffer is totally full and is
+	        about to start overwriting the older data.
+
   buffer_size_kb:
 
 	This sets or displays the number of kilobytes each CPU
-- 
2.42.0


