Return-Path: <linux-kernel+bounces-78463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412A78613CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D469DB21C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493F84A30;
	Fri, 23 Feb 2024 14:17:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CD823CD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697830; cv=none; b=fKt284zUtIsGd4ZzCPB4cCv3tZwGy5tkdCVuCCW4pVdisREr55yPCxKVRXO8YnGbuQzSndBPFZHE1bGauIkeaO+X+PJghuSD6nC5VagW2Lk/VjrRWqNoKtGqGHkemjHiHP89HuRZ1C6t1V2a8B0wfENiR4gelGxGTzL+IW1HqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697830; c=relaxed/simple;
	bh=TRTlBeIWlLJicEJm6c+SDXQxnX8BueJpz4S9NWvpEnU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Xp6O3B8SNT3o2JWIkVf3+tFGHIxNCfUELQ9SMsng5iXmBEd9bFFtL+xeAbBFSSpPKZh91FKJkGMiFDrQ8dRSpUf3yJzArkdTvgRnaFs6jiCTGmm3zZTytJOgVYWDp7nzvlyjTuovZ2aJ2gAvxx6qMBWVVr6O4clrLA9/RGl3Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079ADC433C7;
	Fri, 23 Feb 2024 14:17:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOF-000000077PA-03aA;
	Fri, 23 Feb 2024 09:19:03 -0500
Message-ID: <20240223141902.873290088@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: [for-next][PATCH 09/13] tracing: Do not calculate strlen() twice for __string() fields
References: <20240223141838.985298316@goodmis.org>
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

Link: https://lore.kernel.org/linux-trace-kernel/20240222211442.793074999@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
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



