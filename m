Return-Path: <linux-kernel+bounces-104018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3C87C7F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1258E282CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB2D51D;
	Fri, 15 Mar 2024 03:28:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713ED6119;
	Fri, 15 Mar 2024 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473284; cv=none; b=AQ1El9d5A0CbbJrkMeTPtl+Kjq8Fxtq4iaHyebdOo6eqgHd+4Hcz99r9jX0s+FlKTjUylzgv8kn+v3qCs4wgduwG/v/to6e5P5QMlZXWiAClsF7hgUMLE5Q9Oh1pwdyc/ywTE7tQFEYiPKQGnDvWQAVBDJWXIB/5wW5BHpSxYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473284; c=relaxed/simple;
	bh=zze3VT6QquY3Ueh/mkcygZY7SuZLkTnzG3VRK9GE89w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DNi2tudRrss/cnS3XHUZdtRQNcSppSNLGHvVQcBtX09w17UNYD+ryJCD7YYQBSheoxWoa0HQEaEIgoNnqG5cQ3ogggtf98tnWuluSPZ/x7QrwHHZ+kMoGDFvLd6RACI8afEDLNOLPN7yT0bYMc24uSxm6iv3JoDaHocKCiPO3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFDFC43390;
	Fri, 15 Mar 2024 03:28:03 +0000 (UTC)
Date: Thu, 14 Mar 2024 23:27:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alison Schofield
 <alison.schofield@intel.com>
Subject: [PATCH] tracing: Add __string_src() helper to help compilers not to
 get confused
Message-ID: <20240314232754.345cea82@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The __string() helper macro of the TRACE_EVENT() macro is used to
determine how much of the ring buffer needs to be allocated to fit the
given source string. Some trace events have a string that is dependent on
another variable that could be NULL, and in those cases the string is
passed in to be NULL.

The __string() macro can handle being passed in a NULL pointer for which
it will turn it into "(null)". It does that with:

  strlen((src) ? (const char *)(src) : "(null)") + 1

But if src itself has the same conditional type it can confuse the
compiler. That is:

  __string(r ? dev(r)->name : NULL)

Would turn into:

 strlen((r ? dev(r)->name : NULL) ? (r ? dev(r)->name : NULL) : "(null)" + 1

For which the compiler thinks that NULL is being passed to strlen() and
gives this kind of warning:

/include/trace/stages/stage5_get_offsets.h:50:21: warning: argument 1 null where non-null expected [-Wnonnull]
   50 |                     strlen((src) ? (const char *)(src) : "(null)") + 1)

Instead, create a static inline function that takes the src string and
will return the string if it is not NULL and will return "(null)" if it
is. This will then make the strlen() line:

 strlen(__string_src(src)) + 1

Where the compiler can see that strlen() will not end up with NULL and
does not warn about it.

Note that this depends on commit 51270d573a8d ("tracing/net_sched: Fix
tracepoints that save qdisc_dev() as a string") being applied, as passing
the qdisc_dev() into __string_src() will give an error.

Link: https://lore.kernel.org/all/ZfNmfCmgCs4Nc+EH@aschofie-mobl2/

Reported-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage5_get_offsets.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index e6b96608f452..c6a62dfb18ef 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -9,6 +9,16 @@
 #undef __entry
 #define __entry entry
 
+#ifndef __STAGE5_STRING_SRC_H
+#define __STAGE5_STRING_SRC_H
+static inline const char *__string_src(const char *str)
+{
+       if (!str)
+	       return EVENT_NULL_STR;
+       return str;
+}
+#endif /* __STAGE5_STRING_SRC_H */
+
 /*
  * Fields should never declare an array: i.e. __field(int, arr[5])
  * If they do, it will cause issues in parsing and possibly corrupt the
@@ -47,7 +57,7 @@
 
 #undef __string
 #define __string(item, src) __dynamic_array(char, item,			\
-		    strlen((const char *)(src) ? : EVENT_NULL_STR) + 1)	\
+		    strlen(__string_src(src)) + 1)			\
 	__data_offsets->item##_ptr_ = src;
 
 #undef __string_len
@@ -70,7 +80,7 @@
 
 #undef __rel_string
 #define __rel_string(item, src) __rel_dynamic_array(char, item,		\
-		    strlen((const char *)(src) ? : EVENT_NULL_STR) + 1)	\
+		    strlen(__string_src(src)) + 1)			\
 	__data_offsets->item##_ptr_ = src;
 
 #undef __rel_string_len
-- 
2.43.0


