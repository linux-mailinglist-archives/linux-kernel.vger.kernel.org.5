Return-Path: <linux-kernel+bounces-77284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C1860336
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A881C215E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9246E5F5;
	Thu, 22 Feb 2024 19:50:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095646E5EA;
	Thu, 22 Feb 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631415; cv=none; b=qTAetJDTfBsggRmxNz8T9E33OdDCgphqTewHNgxtXHMIWK4SKRQBaV9kzhERzAwp1NBhZUIke//dG+xa6z7RcGkncuidcnqfYdj7yCd0gzHbOSerHrFiXKV0CLvkr9dB1O2QqxWau8jxQ5zPRX+1Jes+1YTfWpDZazTkgNndEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631415; c=relaxed/simple;
	bh=ENNrx8LU2SglAI7SNvKnlAfbFGWELUY1AmKqj7P0Lds=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H0QfKUzBBoh/yLGFVA2Hf9fYj0b60GQTgP9JKCsek8qK+PIu4aEby4HQ22LtToRKTvOofVGBgHKkylJYrhkIhAl7n6veFb5Dq8iCWJMUj3Yri2BT9P1VNQSEhJbhzkPFFd7H0cgrYLQXEdXVcmP+h5g9M6OXOKcSSjdE+8ctUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A541BC433F1;
	Thu, 22 Feb 2024 19:50:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdF6z-00000006fYE-3iyz;
	Thu, 22 Feb 2024 14:52:05 -0500
Message-ID: <20240222195205.753538473@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 14:51:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/2] tracing: Rework __assign_str() and __string() to not duplicate
 getting the string
References: <20240222195111.139824528@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The TRACE_EVENT() macro handles dynamic strings by having:

  TP_PROTO(struct some_struct *s),
  TP_ARGS(s),
  TP_STRUCT__entry(
	__string(my_string, s->string)
 ),
 TP_fast_assign(
	__assign_str(my_string, s->string);
 )
 TP_printk("%s", __get_str(my_string))

There's even some code that may call a function helper to find the
s->string value. The problem with the above is that the work to get the
s->string is done twice. Once at the __string() and again in the
__assign_str().

The __string() uses dynamic_array() which has a helper structure that
is created holding the offsets and length of the string fields. Instead of
finding the string twice, just save it off in another field in that helper
structure, and have __assign_str() use that instead.

Note, this also means that the second parameter of __assign_str() isn't
even used anymore, and may be removed in the future.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage2_data_offsets.h   |  4 ++--
 include/trace/stages/stage5_get_offsets.h    | 15 ++++++++++-----
 include/trace/stages/stage6_event_callback.h | 12 ++++++++----
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 469b6a64293d..8b0cff06d346 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -24,7 +24,7 @@
 #define __array(type, item, len)
 
 #undef __dynamic_array
-#define __dynamic_array(type, item, len)	u32 item;
+#define __dynamic_array(type, item, len)	u32 item; const void *item##_ptr_;
 
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
@@ -45,7 +45,7 @@
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
 #undef __rel_dynamic_array
-#define __rel_dynamic_array(type, item, len)	u32 item;
+#define __rel_dynamic_array(type, item, len)	u32 item; const void *item##_ptr_;
 
 #undef __rel_string
 #define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index e30a13be46ba..c71f38e10419 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -47,10 +47,12 @@
 
 #undef __string
 #define __string(item, src) __dynamic_array(char, item,			\
-		    strlen((src) ? (const char *)(src) : "(null)") + 1)
+		    strlen((src) ? (const char *)(src) : "(null)") + 1)	\
+	__data_offsets->item##_ptr_ = src;
 
 #undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
+#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)\
+	__data_offsets->item##_ptr_ = src;
 
 #undef __vstring
 #define __vstring(item, fmt, ap) __dynamic_array(char, item,		\
@@ -67,11 +69,14 @@
 	__data_size += __item_length;
 
 #undef __rel_string
-#define __rel_string(item, src) __rel_dynamic_array(char, item,			\
-		    strlen((src) ? (const char *)(src) : "(null)") + 1)
+#define __rel_string(item, src) __rel_dynamic_array(char, item,		\
+		    strlen((src) ? (const char *)(src) : "(null)") + 1); \
+	__data_offsets->item##_ptr_ = src;
 
 #undef __rel_string_len
-#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, (len) + 1)
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, (len) + 1)\
+	__data_offsets->item##_ptr_ = src;
+
 /*
  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
  * num_possible_cpus().
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 919b1a4da980..e09e3d019dcc 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -32,12 +32,14 @@
 
 #undef __assign_str
 #define __assign_str(dst, src)						\
-	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
+	strcpy(__get_str(dst), __data_offsets.dst##_ptr_ ?		\
+	       __data_offsets.dst##_ptr_ : "(null)")
 
 #undef __assign_str_len
 #define __assign_str_len(dst, src, len)					\
 	do {								\
-		memcpy(__get_str(dst), (src), (len));			\
+		memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ?	\
+		       __data_offsets.dst##_ptr_ : "(null)", len);	\
 		__get_str(dst)[len] = '\0';				\
 	} while(0)
 
@@ -92,12 +94,14 @@
 
 #undef __assign_rel_str
 #define __assign_rel_str(dst, src)					\
-	strcpy(__get_rel_str(dst), (src) ? (const char *)(src) : "(null)");
+	strcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ?		\
+	       __data_offsets.dst##_ptr_ : "(null)")
 
 #undef __assign_rel_str_len
 #define __assign_rel_str_len(dst, src, len)				\
 	do {								\
-		memcpy(__get_rel_str(dst), (src), (len));		\
+		memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ?	\
+		       __data_offsets.dst##_ptr_ : "(null)", len);	\
 		__get_rel_str(dst)[len] = '\0';				\
 	} while (0)
 
-- 
2.43.0



