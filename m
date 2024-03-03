Return-Path: <linux-kernel+bounces-89739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13F86F4EA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0522834F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BEAC153;
	Sun,  3 Mar 2024 12:59:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F52947B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470780; cv=none; b=EK8ZxWsXfBWgxzU3ycP9oe3pE8xviFMhTO/gUyMYr/2ksFVPyOFbMlYuW7tV2SMuKe9EkqFmlF+mtXFKEj2ON9PpBC06GdgNHtBSdJEPBid/i3i4yqRohqqFAJKzsiOWXvzj7k1ZuDdYC9loTAv8Z8cnH6UfRrMQimczgA6MPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470780; c=relaxed/simple;
	bh=efOaSPpHNMKkGkKPOPd5Oo42Pwvrx70v2nA/t76V7XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO9J5iqFYTUv3CPorFxvSqWkVkSsb/StQxf1LPjP6OcBdzQRmWkWtnwfqUf6iICPk9cfgAAjizhxTCIdHFFfg5rucjBS0PkdZ7zAHhXxJqscw0zZDvepAVuRiHsD4IYjnKun8NEGGFIih9o4LaRDzzvQET3sPNxsUBarr8G7D24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B8CC433F1;
	Sun,  3 Mar 2024 12:59:39 +0000 (UTC)
Date: Sun, 3 Mar 2024 07:59:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240303075937.36fc6043@rorschach.local.home>
In-Reply-To: <CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
References: <20240302111244.3a1674be@gandalf.local.home>
	<CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
	<20240302145958.05aabdd2@rorschach.local.home>
	<CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
	<20240302154713.71e29402@rorschach.local.home>
	<CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 12:55:10 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 2 Mar 2024 at 12:47, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I'm fine with just making it 4K with a comment saying that "4K is the
> > minimum page size on most archs, and to keep this consistent for crazy
> > architectures like PowerPC and it's 64K pages, we hard code 4K to keep
> > all architectures acting the same".  
> 
> 4k is at least a somewhat sane limit, and yes, being hw-independent is
> a good idea.
> 
> We have other strings that have that limit for similar reasons (ie PATH_MAX).
> 

I believe I was trying to solve this wrong. The vsprintf() is called on
reading of the ring buffer, and I was trying to fix it on the write
side. I believe that the fix should be on the read side where the
vsprintf() is called.

Sachin, can you try this patch.

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3e7fa44dc2b2..5c7962d612de 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1588,11 +1588,20 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
 	int max = iter->ent_size - offsetof(struct print_entry, buf);
+	const char *p;
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %.*s", max, field->buf);
+	trace_seq_puts(s, ": ");
+	/* Write 1K chunks at a time */
+	p = field->buf;
+	do {
+		int pre = max > 1024 ? 1024 : max;
+		trace_seq_printf(s, "%.*s", pre, p);
+		max -= pre;
+		p += pre;
+	} while (max > 0);
 
 	return trace_handle_return(s);
 }
@@ -1602,10 +1611,19 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 {
 	struct print_entry *field;
 	int max = iter->ent_size - offsetof(struct print_entry, buf);
+	const char *p;
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx", field->ip);
+	/* Write 1K chunks at a time */
+	p = field->buf;
+	do {
+		int pre = max > 1024 ? 1024 : max;
+		trace_seq_printf(&iter->seq, "%.*s", pre, p);
+		max -= pre;
+		p += pre;
+	} while (max > 0);
 
 	return trace_handle_return(&iter->seq);
 }

