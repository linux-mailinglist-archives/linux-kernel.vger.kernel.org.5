Return-Path: <linux-kernel+bounces-50499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5038479ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E801FB2467E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763180611;
	Fri,  2 Feb 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix+wiRNs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60A15E5AE;
	Fri,  2 Feb 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903437; cv=none; b=YBqje9N6e+aM6E55VAjRsDUQITnqSlCu8MNxiIfKkCWwmdhvrlAO1ot7MrmFWwR8DP7O88F33TzfND/1H2U7R2t99N7Ox27Z6/cl7ShunOx6hT28LTGVRXUIGO181T74rN3Cw6oypNlq2eLROc1ivd/0Veny136gwP6DFY4bOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903437; c=relaxed/simple;
	bh=RpTKH1GmdbAknJVQJeDBmi4gdortzBLU+ygpaRJ7R5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkS383aFXeTQANouB8dvQzxmB2/cUvk/zcvjpcpgYCqhZL1kjET5CvuPnClVXb8401nqXs0HaMgPJ7k5xAy8PhhPdEg25AJbz1pCduoMAmd1q5RCF8vDG2F2+BhkIiI6O4imPpGX9Kvb3IYYtfhpc5b+u8MiuXZv5aRqZbXp8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix+wiRNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F22FC433F1;
	Fri,  2 Feb 2024 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903436;
	bh=RpTKH1GmdbAknJVQJeDBmi4gdortzBLU+ygpaRJ7R5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ix+wiRNsDG04HfIHohs2ECLXZUCFtw6q+nyoR8L4lTExGOIGP4yLSdg3fw/w1FyG8
	 GKHCrOdgRO1ysq4eGRsaaDRrVBYSosxve8xX4NDS1dpdOJ+hKINLayiFknUHR2fls+
	 7HDfY3zYSxsqALhZVIHpHalavT3svlLE1GbXYLhxEWgN+V9cQRfxodgnmiaUK8Baex
	 hmrXHtLsbcOhPfh0t98nhoV0eo4LKqhWOQ7q/0eurrLut447z7MtAMJHoqHHivKcw7
	 NKVlcTJR8r53S3FwGPDNIztZWMqRr4sdvtHE2T7tEQl342/Y4r8JB+e/QcxK0YVcVy
	 sEOywtNgbhIAw==
Date: Fri, 2 Feb 2024 20:50:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202-biegen-gegangen-66cc9fbde51d@brauner>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
 <20240202-arbeit-fruchtig-26880564a21a@brauner>
 <20240202160704.GA5850@redhat.com>
 <20240202-lackmantel-vervielfachen-4c0f0374219b@brauner>
 <20240202190529.GA28818@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202190529.GA28818@redhat.com>

On Fri, Feb 02, 2024 at 08:05:29PM +0100, Oleg Nesterov wrote:
> On 02/02, Christian Brauner wrote:
> >
> > > I think we need a simpler patch. I was going to send it as 4/4, but I'd
> > > like to think more, _perhaps_ we can also discriminate the PIDFD_THREAD
> > > and non-PIDFD_THREAD waiters. I'll try to make the patch(es) tomorrow or
> >
> > Right, I didn't go that far.
> >
> > > at least provided more info.
> > >
> > > 3 notes for now:
> > >
> > > 	1. we can't use wake_up_poll(), it passes nr_exclusive => 1
> >
> > Bah. So we need the same stuff we did for io_uring and use
> > __wake_up() directly. Or we add wake_up_all_poll() and convert the other
> > three callsites:
> 
> ...
> 
> > +#define wake_up_all_poll(x, m)                                                 \
> > +       __wake_up(x, TASK_NORMAL, 0, poll_to_key(m))
> 
> Agreed, but I think this + s/wake_up/wake_up_all_poll/ conversions
> need a separate patch.

Yeah, I know. This is just a scribbled draft.

> 
> 
> > -void do_notify_pidfd(struct task_struct *task)
> > +void pidfd_wake_up_poll(struct task_struct *task, bool dead)
> >  {
> > -	struct pid *pid;
> > -
> >  	WARN_ON(task->exit_state == 0);
> > -	pid = task_pid(task);
> > -	wake_up_all(&pid->wait_pidfd);
> > +	WARN_ON(mask == 0);
> > +	wake_up_all_poll(&task_pid(task)->wait_pidfd,
> > +			 EPOLLIN | EPOLLRDNORM | dead ? EPOLLHUP : 0);
> 
> No...
> 
> This is still overcomplicated and is not right.

I'm all ears.

> Christian, I'll write another email tomorrow.

Sure, there's no rush. I had not intended that this patch be used. I
have another large series I need to take care of so I can't spend a lot
of time on writing this anyway. I just hadn't used the keyed apis before
and got curious. So don't get the impression that I intend to write
this. I fully expected you to do it.

