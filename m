Return-Path: <linux-kernel+bounces-37055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA483AABE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7621C2547C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935A77F07;
	Wed, 24 Jan 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFw/9swF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5988CA69;
	Wed, 24 Jan 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102074; cv=none; b=lE0fVJ1uqOlVgRZOM89+ScNkY0//MfAKbXdItrLpqs7oX+oTVu0Xn3rl80BpAYx5WcG3UURVFiRjYoM1dNxhtXh5hdacc/ZjmhSL5rEsQ0fu0V4v2ZdxhxXRueMsmtsK0D7oFYfMb5OEpFkvwvCKmxB2K8iwntZdt5aRwqMM0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102074; c=relaxed/simple;
	bh=koDgMrcjogLVfiLz/IfmsWpml4ucZzU/i7sdgvu3aAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLKxtX5bwcNzXy+57VwTSdNHQ5GWFWBW0xALPo+byzrVWoZOKPzGytcWePPgtSCoez/RfaEfzuUfKH6WqOXs2u7u5uIYf1tfjRLFeQk3yQ686WTeaKBafhdiimF/C07mug1F/7w76V0MZAkNEsF3KQyVNmNQLH8m/dVEgHY9CKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFw/9swF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17517C433F1;
	Wed, 24 Jan 2024 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706102074;
	bh=koDgMrcjogLVfiLz/IfmsWpml4ucZzU/i7sdgvu3aAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFw/9swF4yJbajb5ujAMqD5qk1RQ2eMITTdGpWSrYOi7h3ltC2ZnNpXUtHKauO8dj
	 vBUyrF4W3C7gnnL4FbfIRWeHjbr2n+64EOsIXeYaQB8dNWBqBc9TL7o7BOjePIetRx
	 Ml1LOps2VBY6+/vqKgb0lER33yQRmrVBvMLF06cQ=
Date: Wed, 24 Jan 2024 05:14:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	"Starke, Daniel" <daniel.starke@siemens.com>,
	Lee Jones <lee@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>,
	linux-kernel@vger.kernel.org,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: n_gsm: restrict tty devices to attach
Message-ID: <2024012418-passover-habitual-5a92@gregkh>
References: <00000000000039f237060f354ef7@google.com>
 <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
 <9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp>
 <82aa07d4-13ac-4b1d-80cd-0970c71752a5@kernel.org>
 <7dc23b9d-5120-4966-b47b-fcabe270d498@I-love.SAKURA.ne.jp>
 <42d17017-1d30-4c54-9c28-9d9ba2494e07@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d17017-1d30-4c54-9c28-9d9ba2494e07@I-love.SAKURA.ne.jp>

On Wed, Jan 24, 2024 at 07:06:04PM +0900, Tetsuo Handa wrote:
> syzbot is reporting sleep in atomic context, for gsmld_write() is calling
> con_write() with spinlock held and IRQs disabled.
> 
> Since n_gsm is designed to be used for serial port, reject attaching to
> virtual consoles and PTY devices, by checking tty's device major/minor
> numbers at gsmld_open().
> 
> Link: https://www.kernel.org/doc/html/v6.7/driver-api/tty/n_gsm.html
> Reported-by: syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=06fa1063cca8163ea541
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/tty/n_gsm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 4036566febcb..14581483af78 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3623,6 +3623,7 @@ static void gsmld_close(struct tty_struct *tty)
>  static int gsmld_open(struct tty_struct *tty)
>  {
>  	struct gsm_mux *gsm;
> +	int major;
>  
>  	if (!capable(CAP_NET_ADMIN))
>  		return -EPERM;
> @@ -3630,6 +3631,17 @@ static int gsmld_open(struct tty_struct *tty)
>  	if (tty->ops->write == NULL)
>  		return -EINVAL;
>  
> +	major = tty->driver->major;
> +	/* Reject Virtual consoles */
> +	if (major == 4 && tty->driver->minor_start == 1)
> +		return -EINVAL;
> +	/* Reject Unix98 PTY masters/slaves */
> +	if (major >= 128 && major <= 143)
> +		return -EINVAL;
> +	/* Reject BSD PTY masters/slaves */
> +	if (major >= 2 && major <= 3)
> +		return -EINVAL;

That is a lot of hard-coded magic numbers, why aren't these defined
anywhere?

But really, this is only for fuzz testers, why can't they just not ever
bind this to a console?  Why do we have to have these checks in the
kernel to prevent userspace from doing dumb things that no real
userspace will ever do?

thanks,

greg k-h

