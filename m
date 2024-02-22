Return-Path: <linux-kernel+bounces-77377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE186048B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9DFB299D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D572137924;
	Thu, 22 Feb 2024 21:12:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F012D1F9;
	Thu, 22 Feb 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636372; cv=none; b=gHZnUNM7uCeJRP18DSFZ3IPImu5A4bFXYUiq1zROh26ec+RcpSLwHGLpPiNsAsWDTTPyy1DIO5CVD7Srk/LAdG78K4kFwD5N1UgODh26kgIaJLh0xw3eNWeD8XDvZDBdylS0W0k9yI6+QFLq/6wrJpma8BPOG4nDbKYhRazqNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636372; c=relaxed/simple;
	bh=ASKKBEQ/kPwz5mh0vibiuZNuVaq8X/g1jUk/IeZwsxE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ak7iD70+I0Mk0DIRHsL0IgGl4vtilJglWGs+jkb4cGpqR3FwEo+6zqefTfqFybrbZzOoXs+2kUML0lpWQYDuk/njfs3gMwJddItdJw6sLzgHUHBf01ZZe1sVBedqSN3U+5DqBDZTlGsmm8uxPIB7Ua1bUkUnNn3RXDLUhm1V7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B556DC433A6;
	Thu, 22 Feb 2024 21:12:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdGOw-00000006hqt-3tgc;
	Thu, 22 Feb 2024 16:14:42 -0500
Message-ID: <20240222211442.793074999@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 16:14:17 -0500
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
Subject: [PATCH v2 2/4] tracing: Do not calculate strlen() twice for __string() fields
References: <20240222211415.255659509@goodmis.org>
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

The length of the string is calculated via a strlen(), not once, but
twice. Once during the __string() macro and again in __assign_str(). But
the length is actually already recorded in the data location and here's no
reason to call strlen() again.

Just use the saved length that was saved in the __string() code for the
__assign_str() code.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage6_event_callback.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index b3e2f321e787..c0e5d097324e 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -32,8 +32,9 @@
 
 #undef __assign_str
 #define __assign_str(dst, src)						\
-	strcpy(__get_str(dst), __data_offsets.dst##_ptr_ ?		\
-	       __data_offsets.dst##_ptr_ : "(null)")
+	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ?		\
+	       __data_offsets.dst##_ptr_ : "(null)",			\
+	       __get_dynamic_array_len(dst))
 
 #undef __assign_str_len
 #define __assign_str_len(dst, src, len)					\
@@ -94,8 +95,9 @@
 
 #undef __assign_rel_str
 #define __assign_rel_str(dst, src)					\
-	strcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ?		\
-	       __data_offsets.dst##_ptr_ : "(null)")
+	memcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ?		\
+	       __data_offsets.dst##_ptr_ : "(null)",			\
+	       __get_rel_dynamic_array_len(dst))
 
 #undef __assign_rel_str_len
 #define __assign_rel_str_len(dst, src, len)				\
-- 
2.43.0



