Return-Path: <linux-kernel+bounces-145613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3628A5889
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7021C20F28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D3127E2A;
	Mon, 15 Apr 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XX9oUfhB"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B984FDD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200570; cv=none; b=E71DGUics6vgpaO4XgmUaYFoNaMrp7FL20XNqMJZ9Su06mctK14IOvJPrQeY+ewBZfo0iNTssXANQm0wEBsL2LnOMz29S7nbl+anPTcJSFMPsUEmJ5oyNvx+A0xnhIeHPzjbrarW3du2Hw+A5eratkYk4lTfBfQfS7UUi5FwKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200570; c=relaxed/simple;
	bh=AJlbdwTuteDTe4BVvJtE1OezY51Uyz1iTxO1OAraBxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAtt1dJMFkJLLvQ5oUHZk2+Gl9u+UlYVP4rqjvte8Gb91NQ4/oAIuGAOLhXPb5+vvUQUgsDfVoHqFhAomh43pJV8NsFR/iplIWfUO3lqtPQTbRWuBmpFdW8A3ArLFBhIt2y9G3AS5gY0dFQbgQX/b0rPsXioXgKO+MJ7fPw+yOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XX9oUfhB; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5aa28cde736so2030555eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713200565; x=1713805365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJWFLlk6ICNRWZIRD9WFPl1zIlLjuJU9kdqkQByqVPQ=;
        b=XX9oUfhBESo2zB+WXlt8Jg+5awq0OVYPunOqQO9VbBtA7vh14otskbcieERHVhFVbL
         D8262Kqv0Tc12KeVypPjx7oiIF7OWdIWeXS/RXe+7J7e/L2UpcBc3D/woD+PvHMRQQy0
         XSV4zdoXG0lf/CEUbexMHqPzUvq0ybKmeB6ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200565; x=1713805365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJWFLlk6ICNRWZIRD9WFPl1zIlLjuJU9kdqkQByqVPQ=;
        b=UuhnogiGaEPmlWH2PBAaPfmvYH5idTSYMGdcU6nSo9J61/edm+VjfQEkwrDTY3qD74
         1vvorWOQn8V1Jkg8ffCjYZZSHYMhvWxYSgzUlrgRS3zjVMXQox7xXM3CvhiSYfcOZtC2
         8JPlgmBz8kNR3Ko/eLsDYTOWXa3D5p29wOOj4ZxfxSoHJUhfsKooRNzMGmszmpHv/ScL
         NGQHvsus/M7AysVr3CwppGAiqoMXELCIj9VL3Omk9TQIjcpxdsfR/4osJmMqFpwvuIRa
         cx7A2CplGxLUhhdyscTPRp/IgaGefUqQIUGtEMNCxZACaNt4GBilWHr/bdvfx7O0sgvD
         Y1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUDHialetFxD2Cl4tV4Lp8534hQcdo5+P6iZzcbfzCVpiD8KRTWyVoknTM+SxfIahn9lcogoFEb4jBU9CIMaHFyvYQlFYvXgddY5Ck9
X-Gm-Message-State: AOJu0YwjI9cPRLxMPGLPfDdY0VA4AvPygqCQeCa55Rp1Su+wg6fTcmvx
	qcloXAvTzyTsdngOy1MUCp4f5k25ke6cDOFyG0jiSd5uzasiVJTL5UXySyD3Zw==
X-Google-Smtp-Source: AGHT+IEYOZbcVvtVCv2aHOV1jRW+BNuqsUZsbfmYxla8sMqqORfgbGkTG2HFnkY4yJ0uy+SrQBOPFw==
X-Received: by 2002:a05:6358:688b:b0:17e:bfb8:dd86 with SMTP id z11-20020a056358688b00b0017ebfb8dd86mr11908320rwh.3.1713200564920;
        Mon, 15 Apr 2024 10:02:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a656244000000b005dc4fc80b21sm6296328pgv.70.2024.04.15.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:02:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Message-ID: <202404150945.0E96AB727@keescook>
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
 <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>
 <ZhztQ9CvDm3UPgE9@FVFF77S0Q05N>
 <c5a3598d-16dd-4aeb-904e-2084fafef9fe@I-love.SAKURA.ne.jp>
 <Zhz3EEsnGSOgnYWA@shell.armlinux.org.uk>
 <2ab55fd1-7eb0-488e-93ea-660fa05ee43a@I-love.SAKURA.ne.jp>
 <Zh0A9p/l8lmIrunk@shell.armlinux.org.uk>
 <Zh0S_7Pit6Zc04mS@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh0S_7Pit6Zc04mS@FVFF77S0Q05N.cambridge.arm.com>

On Mon, Apr 15, 2024 at 12:43:59PM +0100, Mark Rutland wrote:
> On Mon, Apr 15, 2024 at 11:27:02AM +0100, Russell King (Oracle) wrote:
> > On Mon, Apr 15, 2024 at 06:58:30PM +0900, Tetsuo Handa wrote:
> > > On 2024/04/15 18:44, Russell King (Oracle) wrote:
> > > > On Mon, Apr 15, 2024 at 06:38:33PM +0900, Tetsuo Handa wrote:
> > > >> On 2024/04/15 18:02, Mark Rutland wrote:
> > > >>>   08626a6056aad824 ("arm: Implement thread_struct whitelist for hardened usercopy")
> > > >>>
> > > >>> That commit says that all accesses are bounce-buffered and bypass the check,
> > > >>> but AFAICT the fpa_set() code hasn't changed since then, so either that was
> > > >>> wrong or the user_regset_copyin() code has changed.
> > > >>
> > > >> Then, can we go with https://lkml.kernel.org/r/0b49d91b-511f-449e-b7c3-93b2ccce6c49@I-love.SAKURA.ne.jp ?
> > > > 
> > > > Have you visited that URL? It doesn't point to an email containing a
> > > > patch, so sorry, I don't know what patch you're referring to.
> > > > 
> > > 
> > > Containing a link to a diff. ;-)
> > > 
> > > diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> > > index c421a899fc84..347611ae762f 100644
> > > --- a/arch/arm/kernel/ptrace.c
> > > +++ b/arch/arm/kernel/ptrace.c
> > > @@ -583,10 +583,15 @@ static int fpa_set(struct task_struct *target,
> > >  		   const void *kbuf, const void __user *ubuf)
> > >  {
> > >  	struct thread_info *thread = task_thread_info(target);
> > > +	const unsigned int pos0 = pos;
> > > +	char buf[sizeof(struct user_fp)];
> > > +	int ret;
> > >  
> > > -	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> > > -		&thread->fpstate,
> > > -		0, sizeof(struct user_fp));
> > > +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> > > +				 buf, 0, sizeof(struct user_fp));
> > > +	if (!ret)
> > > +		memcpy(&thread->fpstate, buf, pos - pos0);
> > > +	return ret;
> > >  }
> > >  
> > >  #ifdef CONFIG_VFP
> > 
> > No, not unless there is really no other option. It's hacking around the
> > issue, creating two copy operations of the data (one onto the stack)
> > rather than solving it properly - and I will not put up with that kind
> > of mentality - it's a completely broken approach to open source
> > software. If there is a problem, always fix it using the correct fix,
> > never try to sticky-plaster around a problem.
> > 
> > It seems there is a way for architectures to tell the code what is
> > safe to write to, and it seems that a misunderstanding meant this
> > wasn't implemented. So let's see whether it's possible to fix that
> > first.
> 
> I completely agree.

FWIW, the bound buffer approach is used in other places as well
(especially for places that are not fastpath, like this case), as it
creates an explicit bounds check (i.e. the buffer on the stack). But
yes, if there is a way to specifically allow this during the kmem setup,
let's do that.

The timeline on this is interesting, it first showed up on syzbot about
a year ago (2023/05/05 12:53)
https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14

But hardened usercopy (and commit 08626a6056aad824) are from Jan 2018.
No one noticed for 5 years? :P

> We'll have to wait for Kees to wake up, but IIUC one assumption here was that
> thread_info was particularly sensitive, and hence any state to be copied
> to/from userspace would live in thread_struct. Either we need to remove that
> assumption, or we need to move things so that we can use
> arch_thread_struct_whitelist().
> 
> Given that arm always selects THREAD_INFO_IN_TASK, I think it would be a fairly
> mechanical change to move fp_state (and vfp_state!) into thread_struct. That
> would mean that the TI_FPSTATE offset would grow, but assuming that still fits
> into an ADD immediate, we'd be ok, and then arch_thread_struct_whitelist()
> could be used to handle these structures.

Sure, or use a bounce buffer, since no one noticed this for 5 years
it probably isn't heavy used[1]? But sure, I'm open to whatever --
the point is to not arbitrarily allow usercopy to touch the memory here.

-Kees

[1] We probably can't remove PTRACE_SETFPREGS, but yeah, it's really
uncommon:
https://codesearch.debian.net/search?q=ptrace%28PTRACE_SETFPREGS%2C&literal=1&perpkg=1
- systemtap test suite uses it
- rr is x86 only
- crui doesn't have a arm backend
- python ptrace may use it
- edb-debugger is x86 only
- llvm mentions it in comments only

-- 
Kees Cook

