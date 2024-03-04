Return-Path: <linux-kernel+bounces-91421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66F87114B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5534F2813E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3E7D3E1;
	Mon,  4 Mar 2024 23:45:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23EA7D06E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595937; cv=none; b=CGgLucPXjXCBAacKaOJHI/rCOXJwbuzVkQVoqya4GWkC10qAPCxeJQJFRQ6GP30GdX0K/3TWNSpqGGXFPj/Z0ETJY3LimVUWycHHmBYJJsYNdeH8vZwP2WIZOiMfoy9sgx8mF+GNWPLuLGY8og6oqliX5lDoL/pAi8FlBeS1Hcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595937; c=relaxed/simple;
	bh=rWCalsQ/ubomWP4T3IoTLD+8DsTwXYo/CmCx4jzu1OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3OBiKqiQyBNuPW1PKzzGJDqC7pqRTCy3vW4E+r1nDSmb9KbyKIbblLI9daUN4RPJQ1rd/o/qAuktPL6dvNfR3VxCnfQ3DtOYA9XX+MJWq8QbOyySykzMslOxuuiALzK4Hs6qt8Ep9jzCXjiobZGCfhXrf2uzTrzisQIgs6xIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6A4C43390;
	Mon,  4 Mar 2024 23:45:36 +0000 (UTC)
Date: Mon, 4 Mar 2024 18:47:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240304184725.55449e70@gandalf.local.home>
In-Reply-To: <CAHk-=wi53cJEKim7UvUXtdhQG1BR7oU5TABPXaOq5SmBKLSKYg@mail.gmail.com>
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
	<20240304164205.3245608a@gandalf.local.home>
	<CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com>
	<20240304171034.08d037aa@gandalf.local.home>
	<CAHk-=wi53cJEKim7UvUXtdhQG1BR7oU5TABPXaOq5SmBKLSKYg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 15:20:52 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 4 Mar 2024 at 14:08, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Fine, I'll just remove the precision as that's not needed. There was no
> > other overflows involved here.  
> 
> I really want you to add the size check on the trace buffer *creation* side.
> 
> I don't understand why you refuse to accept the fact that the
> precision warning found a PROBLEM.

And what exactly was that problem? That someone wrote a huge string into
the trace_marker on a machine that had huge page sizes?

What exactly broke?

There was no overflow. No bad memory. KASAN is happy.


> 
> And no, the fix was never to paper over the problem by limiting the
> precision field. Hiding a problem isn't fixing it.

What was broken? The fact that we allowed the buffer to be 64K on a system
that has 64K PAGE_SIZE and we limited the strings to the size of what the
buffer can hold?

I would limit the buffers themselves but they are used in page mappings
which needs to be PAGE_SIZE. Which is most cases is only 4K.

> 
> And no, the fix was also never to chop up the printing of the string
> in smaller pieces to hide paper over the precision field. Again,
> hiding a problem isn't fixing it.

Yes, I didn't like that change either.

> 
> And finally, NO, the fix was also never to add extra debug code to see
> that there was a NUL character there.

That was not a fix, but just a paranoid check. The only times that my
paranoid checks usually trigger is during development which saves a few
hours of debugging as they point out exactly what broke.

> 
> The fix was *always* to simply not accept insanely long strings in the
> first place, and make sure that the field was correctly *set*.

And what exactly is an "insane size"?

The buffer is allocated by page size, and when writing to it I make sure it
fits. I'm now supposed to add some code to tell the user, "No you can't
write that much into the buffer, even though we allocated enough to fit it"?

If I had never added that precision (which I just recently added), there
would have been no bug report, because there would have been no bug.


> 
> IOW, at *creation* time the code needed a proper check for length
> (which obviously indirectly includes checking for the terminating NUL
> character at that point).
> 
> Why do these threads with you always have to end up this long? Why do
> I Nhave to explain every single step of the way that you need to *FIX*
> the problem, not try to hide it with new extra code.

Because I still don't know what exactly the problem is! I'm supposed to add
some arbitrary limit to what people can enter just because we think it's
crazy to have big strings?

If I remove the precision, as I did in this patch. Then adding a limit is
not fixing any bug. It's just adding a limit.

-- Steve

