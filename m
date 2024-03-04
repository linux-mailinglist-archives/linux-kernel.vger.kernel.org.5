Return-Path: <linux-kernel+bounces-91317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37E870E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F89FB23670
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD397868F;
	Mon,  4 Mar 2024 21:40:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0F8F58
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588418; cv=none; b=YWoyluyZGi48OT5jw0YvemtI40BcMu26uWRcm21999oQAZJNYZRiU7aFrwtQVu/OSvHNuSFIiXfUM+RB5CwOywby19DJ4KazbJH8Ulr2AUDTqEN6mqQ55M1eHPXnmsf3qZje3U/4FyyxY43/rM1BMs5s75jyuXQQ/oA598bFZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588418; c=relaxed/simple;
	bh=3ntDNlaGJ25j0IKSazoQA6wzxcTmmHZK9qx9N8ADKaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ba/WZNtbqVFSZ9YPu6wp7kiwNBN77xIu3nd0D20K1KJ/zjR8mNubLg1l0Yy9WHSSGFebWWYjdTBNVSRUoqNpthN9JQOxSAtVBWah+vlrDtGGK08p17L8vO4sruHxz65R9EQBwD5ZCzmcyzFVQyFDjmZ7njjQmOgBHs9pkupDdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5797EC43390;
	Mon,  4 Mar 2024 21:40:17 +0000 (UTC)
Date: Mon, 4 Mar 2024 16:42:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240304164205.3245608a@gandalf.local.home>
In-Reply-To: <20240303160024.458d4f91@rorschach.local.home>
References: <20240302111244.3a1674be@gandalf.local.home>
	<CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
	<20240302145958.05aabdd2@rorschach.local.home>
	<CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
	<20240302154713.71e29402@rorschach.local.home>
	<CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
	<20240303075937.36fc6043@rorschach.local.home>
	<CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
	<20240303140705.0f655e36@rorschach.local.home>
	<CAHk-=wiTGmAXfHiRB8ku4diLxRpN=Hac_q86=j65oiP3J5uXKg@mail.gmail.com>
	<20240303160024.458d4f91@rorschach.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Mar 2024 16:00:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > So I now tell you that you should
> > 
> >  (a) get rid of the stupid and nonsensical precision  
> 
> I can do that.

As I mentioned that the design is based on that the allocated buffer size is
the string length rounded up to the word size, all I need to do is to make
sure that there's a nul terminating byte within the last word of the
allocated buffer. Then "%s" is all I need.

Although, when writing this I found that it isn't rounded from the size of
the string itself, but because I allocate a bit more than what is written
to trace_marker, in case I need to append a '\n' and '\0' just word size
checking isn't enough. Doing two words is more than enough to find the
terminating nul unless there's a bug, in which case this would trigger a
warning.

Would this work for you?

I tested this on both 32 bit and 64 bit machines, with the following command:

 # cd /sys/kernel/tracing
 # for s in 80 480 1000 1450 2000 3000 4050 5500; do
	let c=$s+64;
	for i in `seq $s $c` ; do
		str=`printf -- 'X%.0s' $(seq $i)`;
		echo "write $i";
		echo "$str" > trace_marker;
	done;
   done
 # cat trace

-- Steve

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3e7fa44dc2b2..848a78bab20e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1581,6 +1581,25 @@ static struct trace_event trace_bprint_event = {
 	.funcs		= &trace_bprint_funcs,
 };
 
+/*
+ * Strings in the print entry are stored by their length rounded
+ * up to the nearest word size. The write to the buffer also allocates
+ * a couple of extra bytes in case it needs to append a '\n' and '\0'
+ * if the passed in string doesn't contain them. Check up to two words
+ * in length back to make sure there's a terminating nul.
+ */
+static int test_trace_string(int len, const char *str)
+{
+	int test = sizeof(long) * 2;
+
+	for (int i = 0; len > i && i < test; i++) {
+		if (!str[len - (i + 1)])
+			return 0;
+	}
+	WARN_ONCE(1, "Trace print string missing nul terminator %d", len);
+	return -1;
+}
+
 /* TRACE_PRINT */
 static enum print_line_t trace_print_print(struct trace_iterator *iter,
 					   int flags, struct trace_event *event)
@@ -1591,8 +1610,11 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 
 	trace_assign_type(field, iter->ent);
 
+	if (test_trace_string(max, field->buf))
+		return TRACE_TYPE_UNHANDLED;
+
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %.*s", max, field->buf);
+	trace_seq_printf(s, ": %s", field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1605,7 +1627,10 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
+	if (test_trace_string(max, field->buf))
+		return TRACE_TYPE_UNHANDLED;
+
+	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }

