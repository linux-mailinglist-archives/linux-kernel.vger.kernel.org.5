Return-Path: <linux-kernel+bounces-89904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEC986F71A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F25EB2104B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729237A146;
	Sun,  3 Mar 2024 21:00:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4A1CA8F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709499628; cv=none; b=mZjFFaZyMlFJDFUBWNZKIRT7PMbcsixlzb6+EuNa8emtaX+tmADjTbOZpp9w8FcOEvHrXNAXIJdoWRJRDybP00Dc//EM3aWPuz/mBhhqUoW4e/uUTWws+FPDUNhawhelcW+pmxEGeBKb+apIFYcGEmCzJl+tla66pnZwZF+yj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709499628; c=relaxed/simple;
	bh=4K/6qawlxlLp5YPXg9nf1OpXPhPLHshxrMH66rS1Icg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRW3Bsetku9UB47AQntD44lwHrKzgfIXU2KqsSzFtNFOGQfiLDv62DPOIRccndiMrCNlD8RKFo2K7xUwP8r5X8B3nSQpqQ+METI6DL40EkB8b6JhW9ONhrRhmlpINWKxVnzlADdenkF35IezZV48x0fmIOYg0h5SXB0tgxaYPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4241EC433C7;
	Sun,  3 Mar 2024 21:00:26 +0000 (UTC)
Date: Sun, 3 Mar 2024 16:00:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240303160024.458d4f91@rorschach.local.home>
In-Reply-To: <CAHk-=wiTGmAXfHiRB8ku4diLxRpN=Hac_q86=j65oiP3J5uXKg@mail.gmail.com>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Mar 2024 12:09:37 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:



> 
> Doing insane chunking in 1kB pieces was another "let's paper over the
> symptom, not fix the problem".
> 
> And now you finally admit that the actual problem was that YOUR
> PRECISION WAS STUPID TO BEGIN WITH.

A little more background. I wanted my tracing buffer to take bigger
events like perf does. Specifically to get stack traces from user
space. perf allows for greater than PAGE_SIZE events, so I had to do
the same to get this to work.

The code was changed a bit which also allowed trace_marker to use the
full buffer as well. I even used trace_marker to test the "large
events" code.

The problem that happened here was PowerPC's 64k PAGE_SIZE which also
allowed the trace_marker to take a string that's 64K. I never did test
that as I don't have any machines with 64k PAGE_SIZE. If I didn't add a
trace_marker test to test a large string as well, I would never have
seen this.

> 
> Do you really not see what the truly _fundamental_ problem here is?
> 
> Kernel code doesn't "paper over" stuff. We do things *right*. No more
> of this crap.
> 
> You really need to take a deep look at what you are doing. I spend
> more time on your pull requests than I want to, exactly because you
> have had this pattern of doing something wrong in the first place, and
> then adding MORE CODE to paper over all the problems that initial
> wrong decision causes.
> 
> This was *exactly* the same same thing that happened on the tracefs
> side. You did things wrong, and then you spent a lot of effort in
> trying to patch up the resulting problems, instead of going back and
> doing it *right*.

This is different than tracefs. I actually do understand the code here,
where as in tracefs there was a lot I didn't understand.

The only reason I added a precision is that during the code change I
truncated the string on the write due to a bug that didn't write the
full event, and the print caused a crash due to the missing '\0'. I
figured by adding a precision it would "harden" the code as the missing
'\0' was a bug and should never happen by design.

> 
> And honestly, I still think that the fundamental mistake you have done
> is to let people say "I want to have these big strings" and you just
> roll over and say "sure, we'll create shit kernel code for you".

Writing a bit over 4K isn't that crazy. Writing over 32K is, but that
is only possible on PowerPC due to allocating PAGE_SIZE buffers that
are 64K in size.

> 
> WTF do you think it's fine to say "let people do insane things"
> instead of just telling people that no, we have sane and small limits.

System calls are expensive, writing more in one call is better than
writing lots of little calls. Again, 32K is stupid, but it was based on
the kernel allocated buffer size.

> 
> As a maintainer, one of your jobs is to say "No, we're not doing crazy
> stuff". I still think that having so big strings that this came up in
> the first place is a sign of the deeper problem, and then the fact
> that you had an insane and pointless precision field was just a small
> implementation issue.

BTW, I never did add any code change to allow for the large strings
because someone asked me to. That was a side effect. Yes, people asked
for it because it caused "funny output", and I told them sorry. And
that's it.

But to add code for the stack traces I changed the buffers to allow
larger than 4K. The increase string size write was a side effect of that
work. And it even helped to make an easy way to test large events as I
used the trace_marker in my tests. I added a test to write into the
trace_marker to test these large events as well.

It wasn't until Sachin reported that the test caused the precision
overflow on PowerPC. I didn't even know there was a way to write more
than 32K.


> 
> Doing tracing in the kernel is not some kind of general-purpose thing.
> It's ok - in fact, it's a really damn good idea - to just tell people
> "yes, you can add strings, but dammit, there needs to be sanity to
> it".
> 
> So I now tell you that you should
> 
>  (a) get rid of the stupid and nonsensical precision

I can do that.

> 
>  (b) tell people that their string are limited (and that 4kB is an
> _upper_ value to sane string lengths in the kernel)

Well, I actually did tell people that. I just changed the code for
other reasons that gave this "feature" as a side effect, and only on
PowerPC does it get insanely large.

> 
>  (c) really fundamentally stop with the "paper over" things approach
> to kernel programming
> 
> Large strings are not a "feature". They are a bug.
> 
> It's also sad that apparently your strings are counted, but you don't
> count them very well, so instead of just using the count (which is
> *much* cheaper) you end up using '%s' and do things until you hit a
> NUL byte.  Guess what? All our printk infrastructure is designed for
> small strings, so '%s' isn't exactly optimized, because we expected
> sanity. It ends up in a loop that literally does things one byte at a
> time.

Note, this is the slow path, as it only happens on reading the trace or
trace_pipe files. And again, these strings in most use cases are small.
If someone cares about performance of the read, then they should read
trace_pipe_raw which just reads the raw data without any string
processing.

-- Steve

