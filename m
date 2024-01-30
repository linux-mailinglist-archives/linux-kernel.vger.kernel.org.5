Return-Path: <linux-kernel+bounces-45209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E246842D03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F551C24CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3867B3FD;
	Tue, 30 Jan 2024 19:37:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205D7B3C3;
	Tue, 30 Jan 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643443; cv=none; b=LJQVNplA08Q25EecJJQFYvOSFVRD3qYFCv5nrOLac5oc+iXEMLzrG2YxDxoxha0XP8oU+4KhX5mU2OEAvwhxgJheCr2kRhbwzeu6nOE3uteiYvWZYBWjoq8Xcaw8UZYYYmdtLjz7zoGiIkJqeCg5Flkv5+VRMIun4JqOpegbGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643443; c=relaxed/simple;
	bh=GxKaQUupgyHSD4vAyzXZUZyTLOzcJCOvvUvThgaT5bA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpY+eMk4IlPLQ0uKN+GCBh93pghv4rXKqDmkuz0Bos8HpDFr4ynLuntrqnEGJtErvMg5wut7755aEi4TtowtETt9IXxQdPY4PKALkSRHmOTSsx1toWSDUK8fYv7xx0hvOcR0njqjIuxIRJJauspNTbewp5Of7G1Ye9K/aoxLwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F7CC433F1;
	Tue, 30 Jan 2024 19:37:21 +0000 (UTC)
Date: Tue, 30 Jan 2024 14:37:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240130143734.31b9b3f1@gandalf.local.home>
In-Reply-To: <CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
	<20240129174950.5a17a86c@gandalf.local.home>
	<CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
	<20240129193549.265f32c8@gandalf.local.home>
	<CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
	<CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
	<20240130132319.022817e8@gandalf.local.home>
	<CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 11:19:01 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 30 Jan 2024 at 10:23, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I know you don't send patches inlined anymore, which is a shame, because
> > patchwork takes care of all the administering when patches are inlined, and
> > I don't miss patches like I use to.  
> 
> I just sent the whole series as individual patches., and doing a
> 
>   b4 am 20240130190355.11486-1-torvalds@linux-foundation.org
> 
> should get them all (or if you use patchwork, do that)

Thanks. I can get the mbox with:

 wget https://patchwork.kernel.org/series/821406/mbox/

For those interested, the series is at:

  https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=821406

And I got the above mbox link from the first patch and selecting the 'mbox'
link.

I download that and then run my scripts which adds the Link tags to them as
well as Cc's. I'll add the link to this thread as well. Then I simply do a
'git am -s'

Note, I mentioned the pain of pulling in your multi-attachment patches by
hand on IRC, and Konstantin replied that he'll fix b4 to do those too ;-)

But I still prefer patchwork, as that keeps history as well.

> 
> I don't normally do these inlined patches any more, because honestly,
> 99% of all patches I do end up being "I can't test this very well, I
> think you should do something like this".
> 
> In fact, for simple ones where I might not have even compile-tested
> them, much less booted into a kernel with them, I will actively
> whitespace-corrupt the patch, just to make sure they aren't applied as
> any kind of real workflow - they are almost always meant as a "I think
> you should do this, and take credit for it all".
> 
> And so when I'm working on a series like this, I'll send attachments
> just because it's easier, and because I don't want to patch-bomb
> people with some kind of crazy work-in-progress thing.
> 
> But I'm reasonably comfortable with this series now, so I sent it as a
> "real" patch series. I like it partly because it just removes a lot of
> lines:
> 
>  3 files changed, 160 insertions(+), 433 deletions(-)
> 
> but mostly because the lines it removes are what I consider actively
> broken code. So it's not just getting rid of LOC, it's getting rid of
> complexity (and bugs) IMHO.

Do you want me to put this in my urgent branch and mark them for stable,
and then send them for 6.8?

> 
> That said, I also don't think that patch series is any kind of
> "final". I didn't fix up the readdir iterator locking, for example. I
> don't think the SRCU parts are needed at all any more thanks to the
> refcounting - the 'ei' is no longer protected by SRCU, it's protected
> by virtue of us having the file open (and thus holding the dentry).
> 
> So please think of that series not as any kind of final word. More as
> a "I strongly believe this is the direction eventfs should go".
> 
> I am perfectly ok with you munging those patches and taking full
> credit for them, for example.

Before seeing your 5 patch series, I wrote that patch I showed you which
did basically the same thing. It passed all the preliminary tests so I'm
sure your version should work too. I'll still have to run it through my full
ktest suite, but that takes several hours to complete. I do that before I
send out my 'for-linus/next' or any git pulls.


> 
> My "testing" has not involved any real tracing usage, and while I
> *have* booted that thing, and have done some very basic smoke-testing
> in /sys/kernel/tracing, 99% of the work was literally me just going
> through the lookup code, removing everything I found objectionable,
> and replacing it with what the VFS layer generally would want.

I'll take your patches and start working on them.

Thanks for doing this!

-- Steve

