Return-Path: <linux-kernel+bounces-82159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CAB86800A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34C5B246B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D71130E2C;
	Mon, 26 Feb 2024 18:47:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186C12F59F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973271; cv=none; b=R9YegZS+nmaK7MIrzbEOL/jBOi//3bVvmZPkBZ+JlKtgnGXreNM7y2+OnQcDeKcd/8V+C5yGtDs08+LNB7eUbTqPAwDiGDemlbAFQEeZPX/OlD2/DEHzYeerZgFmCrjFj1CS9CKLYU/RSZhCYc8RLl/FSV2mQ51A/e9M7SEThYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973271; c=relaxed/simple;
	bh=6vxNuCJhE20SNjmJNgdjljhBB1xNE4nu9UBSoxje/d4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VMbTXXuuInguw7jXsgBFrT3VLs8kdQuuGj+LjWBA558YwtdGGqkKQzGw3UKjHfDpqSYIHduTyKSBQWzSM+UyVdU9nHSYj6Fy6j/Ak6eNH+JY8B1diy0076CW1JA7rs+TMgnw1QiBjURNYhakH40wjarQRv7Wd2LidnwQR+Prk7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322C8C43609;
	Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1reg2x-000000090bP-2VIq;
	Mon, 26 Feb 2024 13:49:51 -0500
Message-ID: <20240226184951.460548167@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 26 Feb 2024 13:49:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 5/5] tracing: Remove second parameter to __assign_rel_str()
References: <20240226184932.303400070@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The second parameter of __assign_rel_str() is no longer used. It can be removed.

Note, the only real users of rel_string is user events. This code is just
in the sample code for testing purposes.

This makes __assign_rel_str() different than __assign_str() but that's
fine. __assign_str() is used over 700 places and has a larger impact. That
change will come later.

Link: https://lore.kernel.org/linux-trace-kernel/20240223162519.2beb8112@gandalf.local.home

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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



