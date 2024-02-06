Return-Path: <linux-kernel+bounces-55112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105C84B7E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD0B287ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ACF13248A;
	Tue,  6 Feb 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0VHpjpJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008012FF97;
	Tue,  6 Feb 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229706; cv=none; b=oB6jhZgddSPd1/k/MjO0tIWPZfHzxlkw6JVgOlv2HU/WmUFjumnVKekBV4V83vl1RPIXotOeYA9stA+h9HahlsvbzIEUyybGQ8xM3hOyGc0C5WmfwOhCaAEnzbGBevOYsWEtR0euurokSb9E3GFubTKWByMhOB0LslbLvHmbqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229706; c=relaxed/simple;
	bh=hmXqe5k8v3i33MWN1QBzjt67fki9OQRH2STGLdo6P2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHb02FM4JUMQJWfPcbqUOq2MrUTtG7125sW8MPwpyp7SQc+kST19f83il3btFP+ALlhrPjIix50h6ikhsJsAXEdE0VvRszndAiCnxQZT0mRVQU/z8fAzS5Q+GAoRmTkNJwiCqBl1B/HBg4DGETdY8jc1vWwuiIs2DhFHB3GtOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0VHpjpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E6DC433F1;
	Tue,  6 Feb 2024 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707229705;
	bh=hmXqe5k8v3i33MWN1QBzjt67fki9OQRH2STGLdo6P2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0VHpjpJH+zUJi1bZCbGmCbKZhtveqNFuFGEb8wMS/RJ9rQiLusebqLcNa03LJiE9
	 LgkrDycuc9x/4QX6Abyv3QQGHczPeUeFcdw4DMrawX7yV75irk21sxSaDNJyoOVvFA
	 J92RWEQMv6Jo8/6AYtOEdOIeztMM5MBja8nH7dS8=
Date: Tue, 6 Feb 2024 14:28:22 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	"Starke, Daniel" <daniel.starke@siemens.com>,
	Lee Jones <lee@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>,
	linux-kernel@vger.kernel.org,
	linux-serial <linux-serial@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tty: n_gsm: restrict tty devices to attach
Message-ID: <2024020615-stir-dragster-aeb6@gregkh>
References: <00000000000039f237060f354ef7@google.com>
 <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
 <9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp>
 <82aa07d4-13ac-4b1d-80cd-0970c71752a5@kernel.org>
 <7dc23b9d-5120-4966-b47b-fcabe270d498@I-love.SAKURA.ne.jp>
 <42d17017-1d30-4c54-9c28-9d9ba2494e07@I-love.SAKURA.ne.jp>
 <2024012418-passover-habitual-5a92@gregkh>
 <1eab9734-8e4a-431b-8996-fb30f0c6b173@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eab9734-8e4a-431b-8996-fb30f0c6b173@I-love.SAKURA.ne.jp>

On Sat, Feb 03, 2024 at 10:45:53PM +0900, Tetsuo Handa wrote:
> On 2024/01/24 22:14, Greg Kroah-Hartman wrote:
> >> @@ -3630,6 +3631,17 @@ static int gsmld_open(struct tty_struct *tty)
> >>  	if (tty->ops->write == NULL)
> >>  		return -EINVAL;
> >>  
> >> +	major = tty->driver->major;
> >> +	/* Reject Virtual consoles */
> >> +	if (major == 4 && tty->driver->minor_start == 1)
> >> +		return -EINVAL;
> >> +	/* Reject Unix98 PTY masters/slaves */
> >> +	if (major >= 128 && major <= 143)
> >> +		return -EINVAL;
> >> +	/* Reject BSD PTY masters/slaves */
> >> +	if (major >= 2 && major <= 3)
> >> +		return -EINVAL;
> > 
> > That is a lot of hard-coded magic numbers, why aren't these defined
> > anywhere?
> 
> Well, include/uapi/linux/major.h defines
> 
>   #define TTY_MAJOR 4
>   #define UNIX98_PTY_MASTER_MAJOR 128
>   #define UNIX98_PTY_MAJOR_COUNT 8
>   #define UNIX98_PTY_SLAVE_MAJOR (UNIX98_PTY_MASTER_MAJOR+UNIX98_PTY_MAJOR_COUNT)
>   #define PTY_MASTER_MAJOR 2
>   #define PTY_SLAVE_MAJOR 3
> 
> but does not define end of UNIX98_PTY_SLAVE_MAJOR range, and
> no file defines start of minor number for virtual consoles.

Then use the ones you have, don't make us be forced to figure out what
is going on please.

> Does fixing this bug worth updating include/uapi/linux/major.h and adding
> include/uapi/linux/minor.h ? Since these numbers won't change, I feel that
> a line of comment is sufficient.

No, don't add new ones where not needed.

> > But really, this is only for fuzz testers, why can't they just not ever
> > bind this to a console?  Why do we have to have these checks in the
> > kernel to prevent userspace from doing dumb things that no real
> > userspace will ever do?
> 
> Fuzz testing is for testing unexpected arguments. This bug is nothing but
> missing validation that should be fixed on the kernel side rather than
> trying to tune fuzzers.

I'll push back on this, fuzzers, running as root, can easily crash the
kernel as root can crash the kernel easily.  So trying to keep the
kernel from hurting itself like this is odd to me.

Again, just tell the fuzzers to not do this.  I don't want random
hard-coded numbers in here, that's adding maintance requirements on us
in the kernel for random userspace tools doing random things :(

thanks,

greg k-h

