Return-Path: <linux-kernel+bounces-107921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EE880391
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A94B219AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80141E4B1;
	Tue, 19 Mar 2024 17:37:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF1134CB;
	Tue, 19 Mar 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869858; cv=none; b=s6TMmKYb9GrWV12952m4Bu82tJmudPdtgQLWR4Ii3TRTpDO6uvFcBbwkM7X5eWa46aIQra6eV/qdM+xJf48kdRncC9iCcUHh8v0b49ZGsAwLRxuTtJm/Myb+h43iyB0KJ9vuAUjUjbihdM5VBr+dVi1r608gl2BvJYOfgQMa9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869858; c=relaxed/simple;
	bh=rtuC/HT4xKteBC22K8GZi/JtBVYuPqSZjhgqWpvb4Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uD0c5XV10W4qWdEcx6OQMcMQrO6smbcKdIURBwLsDYN3L4/0StS6TTJOYBO3bJDGW8MPkhYJSF7AVlXmlKG0FB7xmg6VSEEv1Ia9Wh4d/IBsxqP2ltqcT9hmBNw5ZH5M5yZUzOcuopghZq0HIga6+CPo9WWQ9arfiXh7lwJc5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9B7C433C7;
	Tue, 19 Mar 2024 17:37:37 +0000 (UTC)
Date: Tue, 19 Mar 2024 13:39:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] tracing: Just use strcmp() for testing __string() and
 __assign_str() match
Message-ID: <20240319133959.349f5082@gandalf.local.home>
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

As __assign_str() no longer uses its "src" parameter, there's a check to
make sure nothing depends on it being different than what was passed to
__string(). It originally just compared the pointer passed to __string()
with the pointer passed into __assign_str() via the "src" parameter. But
there's a couple of outliers that just pass in a quoted string constant,
where comparing the pointers is UB to the compiler, as the compiler is
free to create multiple copies of the same string constant.

Instead, just use strcmp(). It may slow down the trace event, but this
will eventually be removed.

Also, fix the issue of passing NULL to strcmp() by adding a WARN_ON() to
make sure that both "src" and the pointer saved in __string() are either
both NULL or have content, and then checking if "src" is not NULL before
performing the strcmp().

Link: https://lore.kernel.org/all/CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com/

Fixes: b1afefa62ca9 ("tracing: Use strcmp() in __assign_str() WARN_ON() check")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage6_event_callback.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 83da83a0c14f..3690e677263f 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -35,9 +35,8 @@
 	do {								\
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
-		WARN_ON_ONCE(__builtin_constant_p(src) ?		\
-			     strcmp((src), __data_offsets.dst##_ptr_) :	\
-			     (src) != __data_offsets.dst##_ptr_);	\
+		WARN_ON_ONCE(!(void *)(src) != !(void *)__data_offsets.dst##_ptr_); \
+		WARN_ON_ONCE((src) && strcmp((src), __data_offsets.dst##_ptr_)); \
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] = '\0';				\
-- 
2.43.0


