Return-Path: <linux-kernel+bounces-103389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D781687BECE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9490E289D66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969DA71B53;
	Thu, 14 Mar 2024 14:21:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE870CDE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426085; cv=none; b=FGViZUwskk3P7QETA13hs+ksjLaAsWQ75Px44DscqQ0nFsqTf1+NKufbSdm/fnqNEH3hXM4m6IstsMODABpqhhR0CZNuygxFr0NnuAhbytBL8DKtGdz7MYw+aXVehK7vxD1fkiW0JugAdVHqEJaEjrj79XxmR8XvJfm1ISeZnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426085; c=relaxed/simple;
	bh=ITYjfWzRNvPA40h3ntsvuJ1TUwwxrgRbD4mfqfcOLvo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dtKM4Ek0tP9N2gzeXQ83upfLJ3Q8ZrKr2mFq+12Q9zCoAX4RZ3sdHHviIikfGMIXkHlyDBcozWNn5WlcYpkDBH/TM3RrWB4Juzv6q2xYSdftjIj8Udf3aiL55KBQ+RZlry59MSGPU7jlo96Qjh9vt8AQ1lnhZOcGhOtn33lGp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85401C43394;
	Thu, 14 Mar 2024 14:21:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rklzb-00000002dgP-41ND;
	Thu, 14 Mar 2024 10:23:35 -0400
Message-ID: <20240314142335.820517632@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 14 Mar 2024 10:23:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>,
 kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 8/8] tracing: Use strcmp() in __assign_str() WARN_ON() check
References: <20240314142301.170713485@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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

Link: https://lore.kernel.org/linux-trace-kernel/20240312113002.00031668@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nathan Chancellor <nathan@kernel.org>
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



