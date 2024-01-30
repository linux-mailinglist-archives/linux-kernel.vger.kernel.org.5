Return-Path: <linux-kernel+bounces-43673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CE84177E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1ED8B22A80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F5168BE;
	Tue, 30 Jan 2024 00:35:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162531B59D;
	Tue, 30 Jan 2024 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574941; cv=none; b=eZ7stavw9S/BZRjX3cWCHgM/gW3MWu3Z9EUBkhAXR/dbQKb1q3Wi+qDocUVdnhJlRtWjONrWH8uJYdgAN9j6DE2oRFBOdNsBrpt0xtjyXrfaIUJUsh7CzCUTZjyczLr76E0tLQj8I8pP/AmhcLZbXGARj1ivXHGlmmtE1o7qytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574941; c=relaxed/simple;
	bh=JS9b4dljgl7LjUP6KCTkMBXE0p22YQkNx+HEl5sDoVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCncRp+lCNiZ9NhfZWY0Zq7bcx0KcI8dC9q3W2cFfzKEPahIMUyYgSdHAbn7pL0DOvboPGo0+s2ywYHs46zv1W2sMQI5i7ETEjiSuveS98aEPB5m7iFHJ0uWyt86Gi1i4Z3uFzbjVnDK6iPleRCdRvzKWetSXzFxUnMnE7RCxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520E3C433C7;
	Tue, 30 Jan 2024 00:35:39 +0000 (UTC)
Date: Mon, 29 Jan 2024 19:35:49 -0500
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
Message-ID: <20240129193549.265f32c8@gandalf.local.home>
In-Reply-To: <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
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
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 16:01:25 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'll go see what's up with the "create it again" case - I don't
> immediately see what's wrong.

Interesting. I added a printk in the lookup, and just did this:

 # cd /sys/kernel/tracing
 # ls events/kprobes

And it showed that it tried to see if "kprobes" existed in the lookup.
Which it did not because I haven't created any kprobes yet.

Then I did:

 # echo 'p:sched schedule' >> /sys/kernel/tracing/kprobe_events
 # ls -l events/kprobes/
ls: cannot access 'events/kprobes/': No such file or directory

Where it should now exist but doesn't. But the lookup code never triggered.

If the lookup fails, does it cache the result?

-- Steve

