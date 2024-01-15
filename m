Return-Path: <linux-kernel+bounces-26177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F282DC62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D397283AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC21774D;
	Mon, 15 Jan 2024 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lwQ8LtpP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70C17980;
	Mon, 15 Jan 2024 15:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5BEC433F1;
	Mon, 15 Jan 2024 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705332845;
	bh=GqeW8XFU0wr6W83/qQL3PqOyONODN3AZrhkX/pLrilQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwQ8LtpPqlmLuJMoprhcFoXM3+Cps/V3xxCEw8khijNXyQKFVTMppLUOGRTggzMkL
	 ylP4U2kaDVBFuC1vqUnsmSOzWKQPQ7cUKM69B/RrJ5HifJYy38bILtZbdpk4ToyN+R
	 JHbrtaHt8CSJhHdaRkJDFCYJF3Am0u6bPRzIxlC8=
Date: Mon, 15 Jan 2024 16:34:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: change the privilege required for tty operarions
Message-ID: <2024011556-barbecue-tackiness-78be@gregkh>
References: <2024010247-polio-brittle-1b23@gregkh>
 <20240115082420.13372-1-mengjingzi@iie.ac.cn>
 <2024011523-lifter-narrow-fed3@gregkh>
 <a47cd6e2-571f-4146-961f-758a51c52550@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a47cd6e2-571f-4146-961f-758a51c52550@iie.ac.cn>

On Mon, Jan 15, 2024 at 11:10:29PM +0800, 孟敬姿 wrote:
> 
> 在 2024-1-15 16:35, Greg KH 写道:
> > On Mon, Jan 15, 2024 at 04:24:20PM +0800, Jingzi Meng wrote:
> > > Currently, CAP_SYS_ADMIN is responsible for tty-related functions in
> > > tty_ioctl(): TIOCSTI, TIOCCONS, TIOCVHANGUP. CAP_SYS_ADMIN is already
> > > overloaded, change it to CAP_SYS_TTY_CONFIG for a more fine-grained
> > > and accurate access control.
> > > 
> > > Signed-off-by: Jingzi Meng<mengjingzi@iie.ac.cn>
> > > ---
> > > 
> > > The userland api affected by this change is the ioctl system call,
> > > especially when the second argument is TIOCSTI, TIOCCONS, TIOCVHANGUP,
> > > which now requires sys_tty_config instead of sys_admin. Tested on Debian
> > > with kernel 6.7.0-rc5.
> > Tested how?  You are changing the permissions of a kernel operation,
> > which is arguably, going to break userspace in lots of interesting ways
> > unless you can prove that this is functionally the same as the existing
> > code.
> > 
> > And not all the world is Debian (although lots of it is, yes.)  But
> > actually running programs that exercise this kernel codepath is going to
> > be the key, did you do that?
> > 
> First of all, this change is not about functionality, only about permissions.

I'm confused, permissions dictate functionality.

If I do not have permissions to do something, the functionality is
suddenly not there.  That's what you are doing here, you are changing
the requirement of previously one capability was required to achive a
function in the kernel, to a different capability.

So it is ALL ABOUT functionality here.

> I wrote 3 testcases which calls ioctl() with TIOCSTI, TIOCCONS, TIOCVHANGUP
> respectively. Then execute them on the origin kernel and patched kernel.
> Running it on both sets of kernels gives the same result. However, through
> the system error message, and the kernel log output I added, I confirmed
> that the relevant functionality under the origin kernel requires sys_admin,
> and under the patched kernel requires sys_tty_config.

I'm referring to existing programs that are not modified to have the new
capability that you are now requiring.  Who is going to do that work?
Where are they?  How have you searched to find them?

> Indeed, it doesn't have much to do with the distro either, I just tested it
> on Debian, and similar tests can be done on other distros.

That's not the issue, the issue is "what existing software is going to
break with this change in permission handling."

That needs to be answered first, and I suggest some research into how we
HAVE TO keep backwards compability and can not break it.

Without some more proof, this type of change can never be accepted, nor
would you want it to be.

good luck!

greg k-h

