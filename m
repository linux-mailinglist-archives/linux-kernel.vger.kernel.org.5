Return-Path: <linux-kernel+bounces-77379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE586048D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D501C23529
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA113793B;
	Thu, 22 Feb 2024 21:12:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF5137913;
	Thu, 22 Feb 2024 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636372; cv=none; b=GBjVo2Koy4ryOWRDg0KYOXwOZf8QZkWxlXnJwjBmcGbjqT07kWlMlwunT+uxnclKUqzCHoBzt7g9F7q+JWcp2ATLOQR+lp1VSjyzhC86DUDMPxY8PUbD+QjVTIS9MDuZ9OVT1TEdHQl8uvaBoy1pdmRHjNMsRObGtgxxxsYKzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636372; c=relaxed/simple;
	bh=id3eDHQukH2Z3zNAGOCXwZENmZCc62HfeeRfUEVnlQM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kVR+H34oFjgbv/LyR7eZZbxpSamwlV0iseQrBXaqpWeRs4CTyb8GuK1cF2hVxK5PTKWPvv7Njmy4aJ7nxHFF0oXmMtsEeCwmjyuOo4NdFeaa+qjwRUI0d01LYFcES2D/Swwhl84OPyNHD3FJMLpWSgvH6iL8vTcj69goeOA/Cnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27A0C43399;
	Thu, 22 Feb 2024 21:12:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdGOx-00000006hrr-12BD;
	Thu, 22 Feb 2024 16:14:43 -0500
Message-ID: <20240222211443.106216915@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 16:14:19 -0500
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
Subject: [PATCH v2 4/4] tracing: Use EVENT_NULL_STR macro instead of open coding "(null)"
References: <20240222211415.255659509@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The TRACE_EVENT macros has some dependency if a __string() field is NULL,
where it will save "(null)" as the string. This string is also used by
__assign_str(). It's better to create a single macro instead of having
something that will not be caught by the compiler if there is an
unfortunate typo.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h                 |  3 +++
 include/trace/events/sunrpc.h                | 12 ++++++------
 include/trace/stages/stage5_get_offsets.h    |  4 ++--
 include/trace/stages/stage6_event_callback.h |  8 ++++----
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..b9d88aced7e1 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -17,6 +17,9 @@ struct dentry;
 struct bpf_prog;
 union bpf_attr;
 
+/* Used for event string fields when they are NULL */
+#define EVENT_NULL_STR		"(null)"
+
 const char *trace_print_flags_seq(struct trace_seq *p, const char *delim,
 				  unsigned long flags,
 				  const struct trace_print_flags *flag_array);
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index cdd3a45e6003..ce6a85b82afa 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1327,18 +1327,18 @@ TRACE_EVENT(xs_stream_read_data,
 		__field(ssize_t, err)
 		__field(size_t, total)
 		__string(addr, xprt ? xprt->address_strings[RPC_DISPLAY_ADDR] :
-				"(null)")
+				EVENT_NULL_STR)
 		__string(port, xprt ? xprt->address_strings[RPC_DISPLAY_PORT] :
-				"(null)")
+				EVENT_NULL_STR)
 	),
 
 	TP_fast_assign(
 		__entry->err = err;
 		__entry->total = total;
 		__assign_str(addr, xprt ?
-			xprt->address_strings[RPC_DISPLAY_ADDR] : "(null)");
+			xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
 		__assign_str(port, xprt ?
-			xprt->address_strings[RPC_DISPLAY_PORT] : "(null)");
+			xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
 	),
 
 	TP_printk("peer=[%s]:%s err=%zd total=%zu", __get_str(addr),
@@ -1783,7 +1783,7 @@ TRACE_EVENT(svc_process,
 		__string(service, name)
 		__string(procedure, svc_proc_name(rqst))
 		__string(addr, rqst->rq_xprt ?
-			 rqst->rq_xprt->xpt_remotebuf : "(null)")
+			 rqst->rq_xprt->xpt_remotebuf : EVENT_NULL_STR)
 	),
 
 	TP_fast_assign(
@@ -1793,7 +1793,7 @@ TRACE_EVENT(svc_process,
 		__assign_str(service, name);
 		__assign_str(procedure, svc_proc_name(rqst));
 		__assign_str(addr, rqst->rq_xprt ?
-			     rqst->rq_xprt->xpt_remotebuf : "(null)");
+			     rqst->rq_xprt->xpt_remotebuf : EVENT_NULL_STR);
 	),
 
 	TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%s",
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index 20b801ed3fd4..e6b96608f452 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -47,7 +47,7 @@
 
 #undef __string
 #define __string(item, src) __dynamic_array(char, item,			\
-		    strlen((const char *)(src) ? : "(null)") + 1)	\
+		    strlen((const char *)(src) ? : EVENT_NULL_STR) + 1)	\
 	__data_offsets->item##_ptr_ = src;
 
 #undef __string_len
@@ -70,7 +70,7 @@
 
 #undef __rel_string
 #define __rel_string(item, src) __rel_dynamic_array(char, item,		\
-		    strlen((const char *)(src) ? : "(null)") + 1)	\
+		    strlen((const char *)(src) ? : EVENT_NULL_STR) + 1)	\
 	__data_offsets->item##_ptr_ = src;
 
 #undef __rel_string_len
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 38732855eadb..2bfd49713b42 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -32,14 +32,14 @@
 
 #undef __assign_str
 #define __assign_str(dst, src)						\
-	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ? : "(null)",	\
+	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, \
 	       __get_dynamic_array_len(dst))
 
 #undef __assign_str_len
 #define __assign_str_len(dst, src, len)					\
 	do {								\
 		memcpy(__get_str(dst),					\
-		       __data_offsets.dst##_ptr_ ? : "(null)", len);	\
+		       __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, len); \
 		__get_str(dst)[len] = '\0';				\
 	} while(0)
 
@@ -94,14 +94,14 @@
 
 #undef __assign_rel_str
 #define __assign_rel_str(dst, src)					\
-	memcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ? : "(null)", \
+	memcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, \
 	       __get_rel_dynamic_array_len(dst))
 
 #undef __assign_rel_str_len
 #define __assign_rel_str_len(dst, src, len)				\
 	do {								\
 		memcpy(__get_rel_str(dst),				\
-		       __data_offsets.dst##_ptr_ ? : "(null)", len);	\
+		       __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, len); \
 		__get_rel_str(dst)[len] = '\0';				\
 	} while (0)
 
-- 
2.43.0



