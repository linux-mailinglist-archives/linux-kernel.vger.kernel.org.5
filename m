Return-Path: <linux-kernel+bounces-79205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BDB861EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C81CB23B44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F941493B6;
	Fri, 23 Feb 2024 21:23:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684BC1DDC3;
	Fri, 23 Feb 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723407; cv=none; b=pkrrxbvCXgmbY/AtmzZDKceFPrWBxnn5z3WUk67LuWBlf/cJPuKNFdCIGjMTFDlZAhklETv866YNe7VaBsR1SCAacRw5vmumlfNXKdYQdRMlH7wz+3uzNPxNwKRp/N1L6BOyHSYIa4RIIqp2dlGwjfGc07+oBi7i3YpdJ7Zl0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723407; c=relaxed/simple;
	bh=yqTC6CNCGndCwN3XIdjvcwzQ+nsaHPctVb6WPNXyc18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Lv8n7EuLSll0K7IITJPWEND5I5lbwL9N0/g7VAzo0rZ0uRkU2ccxaYg3xUdteR30jQ/EErh8HoS8TBEdbM/uV6hO5vx8K5PTpZl653zqTqdcVDNHGv0HEOa34ev58OEwj6fkiAY8HKWNCM7xcLTwKQGIDCubowy8kqYJMp3+lns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55164C433F1;
	Fri, 23 Feb 2024 21:23:26 +0000 (UTC)
Date: Fri, 23 Feb 2024 16:25:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Remove second parameter to __assign_rel_str()
Message-ID: <20240223162519.2beb8112@gandalf.local.home>
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

The second parameter of __assign_rel_str() is no longer used. It can be removed.

Note, the only real users of rel_string is user events. This code is just
in the sample code for testing purposes.

This makes __assign_rel_str() different than __assign_str() but that's
fine. __assign_str() is used over 700 places and has a larger impact. That
change will come later.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage6_event_callback.h | 2 +-
 samples/trace_events/trace-events-sample.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 935608971899..a0c15f67eabe 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -91,7 +91,7 @@
 #define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
 
 #undef __assign_rel_str
-#define __assign_rel_str(dst, src)					\
+#define __assign_rel_str(dst)						\
 	do {								\
 		char *__str__ = __get_rel_str(dst);			\
 		int __len__ = __get_rel_dynamic_array_len(dst) - 1;	\
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 2dfaf7fc7bfa..500981eca74d 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -574,7 +574,7 @@ TRACE_EVENT(foo_rel_loc,
 	),
 
 	TP_fast_assign(
-		__assign_rel_str(foo, foo);
+		__assign_rel_str(foo);
 		__entry->bar = bar;
 		__assign_rel_bitmask(bitmask, mask,
 			BITS_PER_BYTE * sizeof(unsigned long));
-- 
2.43.0


