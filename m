Return-Path: <linux-kernel+bounces-89863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625D486F6AD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07FD1C209CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA89579B98;
	Sun,  3 Mar 2024 19:07:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B679942
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709492829; cv=none; b=P66bV1YyKMJ1q6BCeTE1jvTxnjs3xNW4nF4ld8CH/b09RNqq+MhZKVytg7r0HyG3SzkTlJW38d6tg39bO2JzOGaafk2Atk1WHNvnICPvwb4HOn9yAyUMYO6WWChH6GIVbVAh3V0J/mJfLi/Jh74kDuf3b/0yx6aMBKygd4In3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709492829; c=relaxed/simple;
	bh=4aA/QhnOS8y/rJZfTHI33lkdZ9aduMlhTAqLH88yuFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaoJpOyDJPuwyhbImXlYFTdFKvAEzWu7Dw1TwKhwaPWC61s/idFxsv7eVTb9u/JRqC8QfNa6y10aV+ips3y9eMB9pgWT4lrT5EtRjrCMEHTMA2srSPdFvZhHI3djPmaHfmxks8TXiheCwb1VWLHswQ8br7wkiOFO8mXLXsk70no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10666C433F1;
	Sun,  3 Mar 2024 19:07:07 +0000 (UTC)
Date: Sun, 3 Mar 2024 14:07:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240303140705.0f655e36@rorschach.local.home>
In-Reply-To: <CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
References: <20240302111244.3a1674be@gandalf.local.home>
	<CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
	<20240302145958.05aabdd2@rorschach.local.home>
	<CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
	<20240302154713.71e29402@rorschach.local.home>
	<CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
	<20240303075937.36fc6043@rorschach.local.home>
	<CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Mar 2024 09:38:04 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 3 Mar 2024 at 04:59, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > -       trace_seq_printf(s, ": %.*s", max, field->buf);
> > +       trace_seq_puts(s, ": ");
> > +       /* Write 1K chunks at a time */
> > +       p = field->buf;
> > +       do {
> > +               int pre = max > 1024 ? 1024 : max;
> > +               trace_seq_printf(s, "%.*s", pre, p);
> > +               max -= pre;
> > +               p += pre;
> > +       } while (max > 0);  
> 
> The above loop is complete garbage.
> 
> If 'p' is a string, you're randomly just walking past the end of the
> string with 'p += pre'

The string in question isn't some random string. It's a print event on
the ring buffer where the size is strlen(p) rounded up to word size.
That means, max will be no bigger than word-size - 1 greater than
strlen(p). That means the chunks of 1024 will never land in the middle
of garbage.

And even if for some reason it did, it would simply print garbage in
the output that is already available to user space via reading the raw
ring buffer.

> 
> And if 'o' isn't a string but has a fixed size, you shouldn't use '%s'
> in the first place, you should just use seq_write().

The precision actually isn't needed. I added it just in case for some
reason a bug happened and the \0 was truncated.

> 
> Just stop. You are doing things entirely wrong, and you're just adding
> random code.
> 
> I'm not taking *any* fixes from you as things are now, you're once
> again only making things worse.
> 
> What was wrong with saying "don't do that"? You seem to be bending
> over backwards to doing stupid things, and then insisting on doing
> them entirely wrong.

Don't do what?

The previous change was just adding some random limit to a write into
the ring buffer, to prevent one of the readers of the ring buffer from
overflowing the precision check.

Hell, I'm sorry I added that precision check. I guess this could all be
solved with:

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3e7fa44dc2b2..d8b302d01083 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1587,12 +1587,11 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
-	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %.*s", max, field->buf);
+	trace_seq_printf(s, ": %s", field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1601,11 +1600,10 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
-	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }

Because the string should always end with a '\0' in the first
place.

-- Steve
		

