Return-Path: <linux-kernel+bounces-78464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB28613CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8EB28542F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF0584A37;
	Fri, 23 Feb 2024 14:17:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C314823D0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697830; cv=none; b=l7TbqePHpYTDb3sn6WbBQJzUjLUjErnsP7MOnjyax78CI+JB76k9ZaWcb36vs/S2udbpm0qS06+0uKXeIIV420nSEwy5xNkc9IxQgGt9TY6dYgmMFTkCtkSct/vSS7Jug9A452LC9uotdjvO9u7uXgRSpARxLzRypjsrTHkEZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697830; c=relaxed/simple;
	bh=CRDwQm02YMBZgJ/K9iwkHdDrBNbu7OUJpyW+gq/qcQg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mh+2TsIFWGaL11mMwnysddxQjIZUHEPTNTtm0NowmBRQDhODt6kLZ6tZZDJLtQ8OdA+HFhVNnIZDMYJ8Dr4dweF6mgWRXiZOJQxwy/tMvLHa5KQUY2obSmbAE0vFVyVRQlsFXXlP86mpXnFCkEEoAk95OAfBPZqGQVG6TJ+Y9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387C6C4166B;
	Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOF-000000077Pf-0hlO;
	Fri, 23 Feb 2024 09:19:03 -0500
Message-ID: <20240223141903.033285779@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: [for-next][PATCH 10/13] tracing: Use ? : shortcut in trace macros
References: <20240223141838.985298316@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Instead of having:

  #define __assign_str(dst, src)					\
	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ?		\
		__data_offsets.dst##_ptr_ : "(null)",			\
		__get_dynamic_array_len(dst))

Use the ? : shortcut and compact it down to:

  #define __assign_str(dst, src)					\
	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ? : "(null)",	\
	       __get_dynamic_array_len(dst))

Link: https://lore.kernel.org/linux-trace-kernel/20240222211442.949327725@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage5_get_offsets.h    |  4 ++--
 include/trace/stages/stage6_event_callback.h | 14 ++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index 45f8151cf622..20b801ed3fd4 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -47,7 +47,7 @@
 
 #undef __string
 #define __string(item, src) __dynamic_array(char, item,			\
-		    strlen((src) ? (const char *)(src) : "(null)") + 1)	\
+		    strlen((const char *)(src) ? : "(null)") + 1)	\
 	__data_offsets->item##_ptr_ = src;
 
 #undef __string_len
@@ -70,7 +70,7 @@
 
 #undef __rel_string
 #define __rel_string(item, src) __rel_dynamic_array(char, item,		\
-		    strlen((src) ? (const char *)(src) : "(null)") + 1)	\
+		    strlen((const char *)(src) ? : "(null)") + 1)	\
 	__data_offsets->item##_ptr_ = src;
 
 #undef __rel_string_len
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index c0e5d097324e..38732855eadb 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -32,15 +32,14 @@
 
 #undef __assign_str
 #define __assign_str(dst, src)						\
-	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ?		\
-	       __data_offsets.dst##_ptr_ : "(null)",			\
+	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ? : "(null)",	\
 	       __get_dynamic_array_len(dst))
 
 #undef __assign_str_len
 #define __assign_str_len(dst, src, len)					\
 	do {								\
-		memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ?	\
-		       __data_offsets.dst##_ptr_ : "(null)", len);	\
+		memcpy(__get_str(dst),					\
+		       __data_offsets.dst##_ptr_ ? : "(null)", len);	\
 		__get_str(dst)[len] = '\0';				\
 	} while(0)
 
@@ -95,15 +94,14 @@
 
 #undef __assign_rel_str
 #define __assign_rel_str(dst, src)					\
-	memcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ?		\
-	       __data_offsets.dst##_ptr_ : "(null)",			\
+	memcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ? : "(null)", \
 	       __get_rel_dynamic_array_len(dst))
 
 #undef __assign_rel_str_len
 #define __assign_rel_str_len(dst, src, len)				\
 	do {								\
-		memcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ?	\
-		       __data_offsets.dst##_ptr_ : "(null)", len);	\
+		memcpy(__get_rel_str(dst),				\
+		       __data_offsets.dst##_ptr_ ? : "(null)", len);	\
 		__get_rel_str(dst)[len] = '\0';				\
 	} while (0)
 
-- 
2.43.0



