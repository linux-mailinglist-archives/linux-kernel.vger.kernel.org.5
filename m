Return-Path: <linux-kernel+bounces-152270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874588ABBAD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0931C20AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BB1CD25;
	Sat, 20 Apr 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KA7MpRmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B442168A9;
	Sat, 20 Apr 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713618815; cv=none; b=ACakzZgG836T0iQCM8gLfRu1tEePn3c6oPeIVkZYVO1fN+wml5XXeLvIvUwCyb1gHyFGUwmEp9lDUK9U6YJPmVubAfw0P0hy5p1/3UuGnhLqtrxw34JisbwE+fdPBMj9Z94/LikMCrz6qmbr2V9pV1hH4v1Vk6FduvjNCFAIjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713618815; c=relaxed/simple;
	bh=vQLq3T2E6aLzExSjC1hCZflnkVv+RfpL1PDkKwTYI2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZYmpdQvH4GOotpF0lA+rRI9HIBxqcmYqaIlpKTpqDhwV3WsOqTE41i4quJAGMe7tY7anj2nRy/ERM7m1hD855tC3mfhIia02plSWS92DCX45QN2AbH6ZKsuaeiRHyQgpw2TwLudHGKZ75LY8fn0CuDfXE+rcR/ZMCzSP3uYMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KA7MpRmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB5CC072AA;
	Sat, 20 Apr 2024 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713618815;
	bh=vQLq3T2E6aLzExSjC1hCZflnkVv+RfpL1PDkKwTYI2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KA7MpRmgZnc0wcC/j+jD03glP8WGv/LNkQ4W6eY5qMQf5n22v1uxNfoEk2BQL7E4V
	 8LFUhGFzDNXQUP8ABJffAJp77j8fgoAUsNhJaQRuOmzoDjDqDjimf2DL3rJ9UGkXr2
	 VOObOIhtiNJMc3hp/pM3VZ3G0xYYvD1JQ7u7fmnM=
Date: Sat, 20 Apr 2024 15:13:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Starke, Daniel" <daniel.starke@siemens.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
Message-ID: <2024042031-uncoiled-sensually-7ade@gregkh>
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>

On Sat, Apr 20, 2024 at 08:12:32PM +0900, Tetsuo Handa wrote:
> syzbot is reporting sleep in atomic context, for gsmld_write() is calling
> con_write() with spinlock held and IRQs disabled.
> 
> Since n_gsm is designed to be used for serial port [1], reject attaching to
> virtual consoles and PTY devices, by checking tty's device major/minor
> numbers at gsmld_open().
> 
> Starke, Daniel commented
> 
>   Our application of this protocol is only with specific modems to enable
>   circuit switched operation (handling calls, selecting/querying networks,
>   etc.) while doing packet switched communication (i.e. IP traffic over
>   PPP). The protocol was developed for such use cases.
> 
> at [2], but it seems that nobody can define allow list for device numbers
> where this protocol should accept. Therefore, this patch defines deny list
> for device numbers.
> 
> Greg Kroah-Hartman is not happy with use of hard-coded magic numbers [3],
> but I don't think we want to update include/uapi/linux/major.h and add
> include/uapi/linux/minor.h just for fixing this bug.

Sorry, but again, do it properly, nothing has changed here, so I will
not take this patch.

> Link: https://www.kernel.org/doc/html/v6.8/driver-api/tty/n_gsm.html [1]
> Link: https://lkml.kernel.org/r/DB9PR10MB588170E923A6ED8B3D6D9613E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM [2]
> Link: https://lkml.kernel.org/r/2024020615-stir-dragster-aeb6@gregkh [3]
> Reported-by: syzbot <syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Adding LSM ML to CC list in order to ask for comments if Greg again
> complained that we don't want to add sanity check on the kernel side.
> I agree that we should fix fuzzers if fuzzers are writing random data
> to /dev/mem or /dev/kmem . But for example
> https://lkml.kernel.org/r/CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com
> demonstrates that developers try to fix bugs on the kernel side rather
> than tell fuzzers not to do artificial things.

Again, this ldisc requires root permissions to bind to it, and we have a
very long list of known bugs in this driver, this one being only one
very tiny minor one.  To fix it properly, do it right, as stated before,
this type of odd bandage isn't ok as it doesn't actually fix/solve
anything except fuzzers doing the wrong thing (i.e. no real user will
ever do this.)

thanks,

greg k-h

