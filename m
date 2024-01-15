Return-Path: <linux-kernel+bounces-25739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F882D523
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B71F21AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1F323C;
	Mon, 15 Jan 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0htwinv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD91FAB;
	Mon, 15 Jan 2024 08:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95D8C433F1;
	Mon, 15 Jan 2024 08:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705307748;
	bh=GjD/BfpgtpIkz8eTKJbEi5Lc7B/xYmzIs4wOqSyGKqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0htwinvSeTCNaRul69kNqnyoc/Yb4nXUW750F64JOL5iY/oQUDF/4SwdJep+QtQe
	 QazJF4IOhAzzPowH0SLWPRiqWQ6dwSHSeDF6eVY2CEYfX7VDFjrZTahaCX76yKHzTk
	 O6C3K8BRXwMIw4wkeFR2ItpLK+RNfKEcb+/dvoOQ=
Date: Mon, 15 Jan 2024 09:35:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jingzi Meng <mengjingzi@iie.ac.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: change the privilege required for tty operarions
Message-ID: <2024011523-lifter-narrow-fed3@gregkh>
References: <2024010247-polio-brittle-1b23@gregkh>
 <20240115082420.13372-1-mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115082420.13372-1-mengjingzi@iie.ac.cn>

On Mon, Jan 15, 2024 at 04:24:20PM +0800, Jingzi Meng wrote:
> Currently, CAP_SYS_ADMIN is responsible for tty-related functions in
> tty_ioctl(): TIOCSTI, TIOCCONS, TIOCVHANGUP. CAP_SYS_ADMIN is already
> overloaded, change it to CAP_SYS_TTY_CONFIG for a more fine-grained
> and accurate access control.
> 
> Signed-off-by: Jingzi Meng <mengjingzi@iie.ac.cn>
> ---
> 
> The userland api affected by this change is the ioctl system call,
> especially when the second argument is TIOCSTI, TIOCCONS, TIOCVHANGUP,
> which now requires sys_tty_config instead of sys_admin. Tested on Debian
> with kernel 6.7.0-rc5.

Tested how?  You are changing the permissions of a kernel operation,
which is arguably, going to break userspace in lots of interesting ways
unless you can prove that this is functionally the same as the existing
code.

And not all the world is Debian (although lots of it is, yes.)  But
actually running programs that exercise this kernel codepath is going to
be the key, did you do that?




> 
>  drivers/tty/tty_io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index f3ca2105b66d..c81479366317 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2286,7 +2286,7 @@ static int tiocsti(struct tty_struct *tty, u8 __user *p)
>  	if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN))
>  		return -EIO;
>  
> -	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
> +	if ((current->signal->tty != tty) && !capable(CAP_SYS_TTY_CONFIG))
>  		return -EPERM;
>  	if (get_user(ch, p))
>  		return -EFAULT;
> @@ -2390,7 +2390,7 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
>   */
>  static int tioccons(struct file *file)
>  {
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!capable(CAP_SYS_TTY_CONFIG))
>  		return -EPERM;
>  	if (file->f_op->write_iter == redirected_tty_write) {
>  		struct file *f;
> @@ -2719,7 +2719,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case TIOCSETD:
>  		return tiocsetd(tty, p);
>  	case TIOCVHANGUP:
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!capable(CAP_SYS_TTY_CONFIG))
>  			return -EPERM;
>  		tty_vhangup(tty);
>  		return 0;

Why did you just change these 3 usages, and not all of them?  Why are
these "safe" but the others not?

And most importantly of all, why make this change at all?  Who is using
capabilities these days in a fine-grained way to warrent this type of
modification?

thanks,

greg k-h

