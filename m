Return-Path: <linux-kernel+bounces-45442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC828430D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF9B2154C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF97EF14;
	Tue, 30 Jan 2024 23:04:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE27EEEE;
	Tue, 30 Jan 2024 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655867; cv=none; b=R5qHL3epTu2goCCzj2uPnzdh5EV4hsjV/v+e7vKV/vKNoWK7WOcfOFrEM2asYClyiLtXIbzIoaX53FAE/SyiGqu9MGIeWGIi0HuiUhAEoWwcXqXSF1oMZDZJ1QQC4tDjpymGy/KmpuxtcCtzEWh8iexNKUVIb2Wqni49Qd5xN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655867; c=relaxed/simple;
	bh=8NvnJ6yLxCPzDDYn04+1f/mot7OzNi4he6SMYtI/riM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtHmoB/qjMx3wsxOK5sGA9g/qlifwIs3DkbaLEuMb/Ox7Ge9f7Folj99lUKOi7rHG5aJacFlISMFS11EghfzjlBXVQ19XTn48A5M5jAhyGkwKNNINGjuKhMb4FdbSBNhPS3W0HHMJX8Mkm2z+mZ1VauukE8bPrr13Ne/gwubGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E46C433F1;
	Tue, 30 Jan 2024 23:04:26 +0000 (UTC)
Date: Tue, 30 Jan 2024 18:04:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240130180438.25ba29ff@gandalf.local.home>
In-Reply-To: <CAHk-=wgTKsxPYyys-U5guyEUDb63MtfTz4y+r6cgKT52zBNOpQ@mail.gmail.com>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
	<20240130155550.4881d558@gandalf.local.home>
	<CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
	<20240130175603.5f686e46@gandalf.local.home>
	<CAHk-=wgTKsxPYyys-U5guyEUDb63MtfTz4y+r6cgKT52zBNOpQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 14:58:26 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 30 Jan 2024 at 14:55, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Remember, the files don't have an ei allocated. Only directories.  
> 
> Crossed emails.
> 
> > I then counted the length of the string - 7 bytes (which is the same as the
> > length of the string plus the '\0' character - 8 bytes) to accommodate the
> > pointer size, and it's a savings of 22KB per instance. And in actuality, I
> > should have rounded to the nearest kmalloc slab size as kzalloc() isn't going to
> > return 35 bytes back but 64 bytes will be allocated.  
> 
> No. See my other email. The kmalloc sizes actually means that it comes
> out exactly even.
>

But that wouldn't be the case if I switched over to allocating as its own
slab, as it would make it better condensed.

But, I can keep it your way until I do that, as the biggest savings I
needed was getting rid of all the file meta-data as that was what took up
10s of megabytes.

-- Steve

