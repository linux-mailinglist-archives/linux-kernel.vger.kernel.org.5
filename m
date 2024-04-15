Return-Path: <linux-kernel+bounces-145001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794258A4DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193231F217A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A370561699;
	Mon, 15 Apr 2024 11:44:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A655DF05
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181454; cv=none; b=WQVlHDahR301ieGwAJjJi44oDsb5u61kX7tMoiCAQdXAs14s1icKVu/1AwpBL7Blj3R4irwTQvoHmY8d2a4XDOX1WFvyXHTGeb31W0m0RjRWOAIDq9LDk67IWT1mZKcH3T7nMFx51qSCE6do0JURsYM5wYb5hojkMNsl9c7YbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181454; c=relaxed/simple;
	bh=vlz4xdTeFh3JWcWl9uGUVQlRxwjBAqpOUnqtGkd7sNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+CesjCz/Pq2vL8/oh/wsIeDb1xRAjqmWxkNwMEAoCVmlTq16BLntUSZWezH8YD5MvbKN8swQ0d4UGoj9MCvuzqQ4NCz//TnMIIQnMSVhvJB1sOvQXGTMQh8bp2JqXKNRVlAIkPQmkqHSoT8ZfbiW/M0Q3Mf5ce2gTylJecRrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133382F4;
	Mon, 15 Apr 2024 04:44:39 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 984023F738;
	Mon, 15 Apr 2024 04:44:09 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:43:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Kees Cook <keescook@chromium.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Message-ID: <Zh0S_7Pit6Zc04mS@FVFF77S0Q05N.cambridge.arm.com>
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
 <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>
 <ZhztQ9CvDm3UPgE9@FVFF77S0Q05N>
 <c5a3598d-16dd-4aeb-904e-2084fafef9fe@I-love.SAKURA.ne.jp>
 <Zhz3EEsnGSOgnYWA@shell.armlinux.org.uk>
 <2ab55fd1-7eb0-488e-93ea-660fa05ee43a@I-love.SAKURA.ne.jp>
 <Zh0A9p/l8lmIrunk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh0A9p/l8lmIrunk@shell.armlinux.org.uk>

On Mon, Apr 15, 2024 at 11:27:02AM +0100, Russell King (Oracle) wrote:
> On Mon, Apr 15, 2024 at 06:58:30PM +0900, Tetsuo Handa wrote:
> > On 2024/04/15 18:44, Russell King (Oracle) wrote:
> > > On Mon, Apr 15, 2024 at 06:38:33PM +0900, Tetsuo Handa wrote:
> > >> On 2024/04/15 18:02, Mark Rutland wrote:
> > >>>   08626a6056aad824 ("arm: Implement thread_struct whitelist for hardened usercopy")
> > >>>
> > >>> That commit says that all accesses are bounce-buffered and bypass the check,
> > >>> but AFAICT the fpa_set() code hasn't changed since then, so either that was
> > >>> wrong or the user_regset_copyin() code has changed.
> > >>
> > >> Then, can we go with https://lkml.kernel.org/r/0b49d91b-511f-449e-b7c3-93b2ccce6c49@I-love.SAKURA.ne.jp ?
> > > 
> > > Have you visited that URL? It doesn't point to an email containing a
> > > patch, so sorry, I don't know what patch you're referring to.
> > > 
> > 
> > Containing a link to a diff. ;-)
> > 
> > diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> > index c421a899fc84..347611ae762f 100644
> > --- a/arch/arm/kernel/ptrace.c
> > +++ b/arch/arm/kernel/ptrace.c
> > @@ -583,10 +583,15 @@ static int fpa_set(struct task_struct *target,
> >  		   const void *kbuf, const void __user *ubuf)
> >  {
> >  	struct thread_info *thread = task_thread_info(target);
> > +	const unsigned int pos0 = pos;
> > +	char buf[sizeof(struct user_fp)];
> > +	int ret;
> >  
> > -	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> > -		&thread->fpstate,
> > -		0, sizeof(struct user_fp));
> > +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> > +				 buf, 0, sizeof(struct user_fp));
> > +	if (!ret)
> > +		memcpy(&thread->fpstate, buf, pos - pos0);
> > +	return ret;
> >  }
> >  
> >  #ifdef CONFIG_VFP
> 
> No, not unless there is really no other option. It's hacking around the
> issue, creating two copy operations of the data (one onto the stack)
> rather than solving it properly - and I will not put up with that kind
> of mentality - it's a completely broken approach to open source
> software. If there is a problem, always fix it using the correct fix,
> never try to sticky-plaster around a problem.
> 
> It seems there is a way for architectures to tell the code what is
> safe to write to, and it seems that a misunderstanding meant this
> wasn't implemented. So let's see whether it's possible to fix that
> first.

I completely agree.

We'll have to wait for Kees to wake up, but IIUC one assumption here was that
thread_info was particularly sensitive, and hence any state to be copied
to/from userspace would live in thread_struct. Either we need to remove that
assumption, or we need to move things so that we can use
arch_thread_struct_whitelist().

Given that arm always selects THREAD_INFO_IN_TASK, I think it would be a fairly
mechanical change to move fp_state (and vfp_state!) into thread_struct. That
would mean that the TI_FPSTATE offset would grow, but assuming that still fits
into an ADD immediate, we'd be ok, and then arch_thread_struct_whitelist()
could be used to handle these structures.

Mark.

