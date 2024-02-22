Return-Path: <linux-kernel+bounces-77378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE286048C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610FB1F21EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250D13792A;
	Thu, 22 Feb 2024 21:12:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27757137903;
	Thu, 22 Feb 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636372; cv=none; b=GGcUBHFbSJnsi7CXPgq+kC/fJ50vYk6LBSFaT8JeEAcQb11ujQhsBEntl3IwkJEtWUhv2YkO/4mQLizlN6Pl+D1OdhdRgKfpYoNog8mED/scJgxQO3sTZ00/eUok8hvUBD3y20p8a2gnKWHIIG82HsEDE4Xpmk11CkwxG0LKKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636372; c=relaxed/simple;
	bh=K36FV3Egg1ePTt42OBtqs/A8IUwW7W91nGRmDT5sWiQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KHdyQvmjQ3JirmBSTwtjcV5zNdwv8C80GcnreA5rBeLFgBPB8NkjVTD/KKk0AonqGFNmLpHyoquo5Z91IOmoU36LIIOoGmz4cGEbRbel9KWmOUIvVELtil3G2m0LDJVivDf5Qxh2909Fb7iTwPgJVxGXieWX7bee6YseczLJff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC94C43394;
	Thu, 22 Feb 2024 21:12:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdGOx-00000006hrN-0MMp;
	Thu, 22 Feb 2024 16:14:43 -0500
Message-ID: <20240222211442.949327725@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 16:14:18 -0500
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
Subject: [PATCH v2 3/4] tracing: Use ? : shortcut in trace macros
References: <20240222211415.255659509@goodmis.org>
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



