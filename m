Return-Path: <linux-kernel+bounces-77285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377C0860337
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AD9288316
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF386E605;
	Thu, 22 Feb 2024 19:50:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDD6E5F0;
	Thu, 22 Feb 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631415; cv=none; b=BXZemLbkIiEN9uFhw3/qhECgVgshDzpmiE/I7y3rzWjpiHy83uwAdDh4ZGwLWf3jK/Zk0TB37CuoPqbxdJzlbDqmo50eq3yPee7qakDqcdt62NtPzYrfg2jN7heLPD6AVPszU1Zyvx/nYp/v2x8bP8Eax41squd28KVvtbl4IPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631415; c=relaxed/simple;
	bh=DN/mPR/MulUxISIwqdVAZ+Dv5KqrCmA0c9BnouZcZQI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dGvxEd5cYFtv2BFOwEFoR9yDBy/5fGm398a7fM8I2K6Pzq4m4B95xu7YGK50FNZ8hjymplp6hDG0Q0L3AwxK1w9+41Ind2x7Af0O0QVdt9y3hMxjKDVtsxwe4jqYZeklbvKl62wHU6jQTLiqQIiHBJ+XdeqkEdwAHszy/6XsAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BFAC433A6;
	Thu, 22 Feb 2024 19:50:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdF70-00000006fYj-0CcN;
	Thu, 22 Feb 2024 14:52:06 -0500
Message-ID: <20240222195205.909016488@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 14:51:13 -0500
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
Subject: [PATCH 2/2] tracing: Do not calculate strlen() twice for __string() fields
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
length of s->string is done twice. Once at the __string() and again in the
__assign_str().

The length of the string is calculated via a strlen(), not once, but twice
(via strcpy() in __assign_str()). Once during the __string() macro and again
in __assign_str(). But the length is actually already recorded in the data
location and there's no reason to call strlen() again.

Just use the saved length that was saved in the __string() code for the
__assign_str() code.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage6_event_callback.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index e09e3d019dcc..d389725937e9 100644
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



