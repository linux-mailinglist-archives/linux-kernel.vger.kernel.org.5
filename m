Return-Path: <linux-kernel+bounces-100435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69A879784
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A22A1C21E09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE27C0BC;
	Tue, 12 Mar 2024 15:27:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DE58AD4;
	Tue, 12 Mar 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257278; cv=none; b=TqqOaqcWGCPa/7h58wQvqxUB1A0VwgXHK6GeUXy84CgGEVF918/FO5yRKszW+0K90l0HL7rhGGygvF+Awq+5G4Jk/pUo8IDToe7AwBLX9V2QswPurUmIvuV8xU5o9s9MvsHtrEhvOx7AqFWvQeLrCd5yrO7agx6PSQT1CktF5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257278; c=relaxed/simple;
	bh=6b7L4Sbs/Q00lM4mIgsLsO8GHS3s4iVoc322HloRkfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s2b8c553faPY86HDXXLxMEVq465sucPF3Gzj3clVjBuavLcQmY5rxEcYhHdo7Ev/q4QP8/F4KLBWMPjVyDHpyB1hIUUR8cobrjQ5UwYhSQodJYergWU+bbL0ATOAC/A6z0m15m+IYhtbRaQWm5bvP41mCnZpC6xxYNrrCXrM58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D6C433C7;
	Tue, 12 Mar 2024 15:27:56 +0000 (UTC)
Date: Tue, 12 Mar 2024 11:30:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>, Nathan
 Chancellor <nathan@kernel.org>
Subject: [PATCH] tracing: Use strcmp() in __assign_str() WARN_ON() check
Message-ID: <20240312113002.00031668@gandalf.local.home>
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

The WARN_ON() check in __assign_str() to catch where the source variable
to the macro doesn't match the source variable to __string() gives an
error in clang:

>> include/trace/events/sunrpc.h:703:4: warning: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Wstring-compare]
     670 |                         __assign_str(progname, "unknown");

That's because the __assign_str() macro has:

   WARN_ON_ONCE((src) != __data_offsets.dst##_ptr_);

Where "src" is a string literal. Clang warns when comparing a string
literal directly as it is undefined to what the value of the literal is.

Since this is still to make sure the same string that goes to __string()
is the same as __assign_str(), for string literals do a test for that and
then use strcmp() in those cases

Note that this depends on commit 51270d573a8d ("tracing/net_sched: Fix
tracepoints that save qdisc_dev() as a string") being applied, as this was
what found that bug.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402292111.KIdExylU-lkp@intel.com/
Fixes: 433e1d88a3be ("tracing: Add warning if string in __assign_str() does not match __string()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage6_event_callback.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index a0c15f67eabe..83da83a0c14f 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -35,7 +35,9 @@
 	do {								\
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
-		WARN_ON_ONCE((src) != __data_offsets.dst##_ptr_);	\
+		WARN_ON_ONCE(__builtin_constant_p(src) ?		\
+			     strcmp((src), __data_offsets.dst##_ptr_) :	\
+			     (src) != __data_offsets.dst##_ptr_);	\
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] = '\0';				\
-- 
2.43.0


