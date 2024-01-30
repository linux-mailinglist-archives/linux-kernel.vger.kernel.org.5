Return-Path: <linux-kernel+bounces-45099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E729842BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84841F2AB98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096EB15696D;
	Tue, 30 Jan 2024 18:23:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F553157E98;
	Tue, 30 Jan 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638989; cv=none; b=t5Y9wZivks83UjHMfFkuggFQ24x27YjRzADBSQ9Jfwm/TxtlveMqNZ33yB0oBr9aEDT7xmQ4V8Pil+4tnuB15GfoWUvsXgVoYeJ7GEOMtESSSUG395M8TVQHvG+rGNtD91MpeuCMchPZX9tDssbnKh7caGn9+89LuRGD7iNM6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638989; c=relaxed/simple;
	bh=y1duc/zFuerroIv0zwgnkpk2zK5bc2TgkZVoPSAVmaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rB9ZzS91R/XigLvWjqlPkiixZdKVagj9JjoaDJR8sMoMaYpJPGlnDlfa75WNyF/TJ9hFJ34d0u6t5bIDmZiZdbt/Nf628kTi5xRd+8YbdLsoBJC6lENq2yDLAs6Q43sgjRHYIeWykRoBykaLUXTIHbf99unD+q1ifuYbuaV0chA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA18C433A6;
	Tue, 30 Jan 2024 18:23:07 +0000 (UTC)
Date: Tue, 30 Jan 2024 13:23:19 -0500
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
Message-ID: <20240130132319.022817e8@gandalf.local.home>
In-Reply-To: <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
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
	<20240129193549.265f32c8@gandalf.local.home>
	<CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
	<CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 19:56:52 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [0005-eventfs-get-rid-of-dentry-pointers-without-refcounts.patch  text/x-patch (15652 bytes)] 

I missed this email when I wrote basically the same thing :-p

It was sent just as I went to bed and this morning I mistaken it as an
email I already read. When you mentioned that your last patch was on top of
your other 5, I said to myself, "Wait? there's five?" and went back though
this thread looking at every email with an attachment. Well, even though I
duplicated your work, I'll take that as a learning experience.

Anyway, I'm assuming that the other 4 patches are exactly the same as the
previous version, as applying patches from attachments is a manual process.
I don't even develop on the machine with my email client, so it either is
me downloading each and scp'ing them over to my development box or finding
the lore link and going through them individually one by one.

I know you don't send patches inlined anymore, which is a shame, because
patchwork takes care of all the administering when patches are inlined, and
I don't miss patches like I use to.

So, I'll down load patch 5 here and just assume that I already have your
other 4 patches from the previous email.

-- Steve

