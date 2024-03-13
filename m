Return-Path: <linux-kernel+bounces-102477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF0987B2A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE21E1C20AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521FB51C30;
	Wed, 13 Mar 2024 20:12:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536B50243;
	Wed, 13 Mar 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360732; cv=none; b=FGWrJ/NsQcU6ZWaYW9SGc7yv7DMvRodnYIjpk3NE8AOJqLpobO6mrvnz/AsJ6KtY7vDePwMX50eYkpcXtOthF1reNQ5yYxwM2j5J4/Af814KnqjjsUbMSZnWuNfyTdZrpgr/gVXHxCAYfv4TB8fdMw3aiyfmxwFakyXsmJduABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360732; c=relaxed/simple;
	bh=DoSvdQHEHpaTFMIhARnfPiNgrJvH1Ozx282n9iN1Boc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEHvMzLk1OQ2fg/YnN4zkndK7c946d5l8oWAJoOCxBPdb6crhL0mbMN0ClYZygJwu6/nzCeRa+Po+7mvXNWlD1JUv0lORfKIrDCfrSzGj8Inx8qfCV9pHrywRTRgu3g5VubLJ4GlZ+2cw3ApmxIK6vPmNwN8V+RKbao17Pa+THM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8C4C433C7;
	Wed, 13 Mar 2024 20:12:11 +0000 (UTC)
Date: Wed, 13 Mar 2024 16:14:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kernel test robot <lkp@intel.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] tracing: Use strcmp() in __assign_str() WARN_ON() check
Message-ID: <20240313161420.3b668558@gandalf.local.home>
In-Reply-To: <20240313134550.68a11319@gandalf.local.home>
References: <20240312113002.00031668@gandalf.local.home>
	<20240313165903.GA3021536@dev-arch.thelio-3990X>
	<20240313134550.68a11319@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 13:45:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Let me test to make sure that when src is a string "like this" that it does
> the strcmp(). Otherwise, we may have to always do the strcmp(), which I
> really would like to avoid.

I added the below patch and enabled sched_switch and it triggered the
warning (expected if it went the strcmp() path). I then changed it to be:

#define __assign_str(dst, src)						\
	do {								\
		char *__str__ = __get_str(dst);				\
		int __len__ = __get_dynamic_array_len(dst) - 1;		\
		WARN_ON_ONCE(__builtin_constant_p(src) ?		\
			     strcmp((src), __data_offsets.dst##_ptr_) :	\
-			     (src) != __data_offsets.dst##_ptr_);	\
+			     (src) == __data_offsets.dst##_ptr_);	\
		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
		       EVENT_NULL_STR, __len__);			\
		__str__[__len__] = '\0';				\
	} while (0)

And the sched_switch did not trigger (expected). So it seems that it should
not be a problem.

Note, I only tested this with gcc and not clang.

But I guess there's also the case where we have:

	__assign_str(str, field ? field : "NULL")

But hopefully that's not an issue.

-- Steve

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..eaacd0c4e899 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -236,6 +236,7 @@ TRACE_EVENT(sched_switch,
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
 		__field(	int,	next_prio			)
+		__string( test, "this")
 	),
 
 	TP_fast_assign(
@@ -246,6 +247,7 @@ TRACE_EVENT(sched_switch,
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
+		__assign_str(test, "this");
 		/* XXX SCHED_DEADLINE */
 	),
 
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 83da83a0c14f..cf301c723fd0 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -36,7 +36,7 @@
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
 		WARN_ON_ONCE(__builtin_constant_p(src) ?		\
-			     strcmp((src), __data_offsets.dst##_ptr_) :	\
+			     !strcmp((src), __data_offsets.dst##_ptr_) :	\
 			     (src) != __data_offsets.dst##_ptr_);	\
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\

