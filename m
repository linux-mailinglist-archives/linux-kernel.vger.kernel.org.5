Return-Path: <linux-kernel+bounces-60497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95718505B6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5F92816B8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8555D488;
	Sat, 10 Feb 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8K4oQ3I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC45380C;
	Sat, 10 Feb 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585779; cv=none; b=eloccX4hyO2IMCWWpnFGAdRXDttyjwLYA7HO42vN9NHL6hPdfd/qHP2AwLRtDXAW+BwA4cpypw2vWYlpOAXzBtzvuvrOo1UhH0PkeocRJwbuHeI5L3gfdfOUQOj4vTmG5Z2v9gc64p3mOIUE4Qfyf0sOmKUm55fJNiv4w363OJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585779; c=relaxed/simple;
	bh=wU4lyT7QKhQe201ARBPkcpqXar4YYZc2vEKe20J8mTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roBLM+mWbd+yZiABnYUUS6jTlJ1qJDmBZ+oVSwe0b8eRf2ByP5NGVKzJbOBmvo87o1xsvM1YYrI0LA5rFL9MeAy6q5L+jXQqjglb/OoYiym+PyLUrVorR+byuH/rdt0NMsvtnr5Xi6WC4Liv+nGMAdYU5+Gv0URTbJqGHMxCvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8K4oQ3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B151C433F1;
	Sat, 10 Feb 2024 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707585779;
	bh=wU4lyT7QKhQe201ARBPkcpqXar4YYZc2vEKe20J8mTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8K4oQ3ICJ5RGjRrS9mJ39grWPbL69RlywqjExMvsbQlk1hQNFmYoI/3R/Vne3ETW
	 1cdBOBp1C52muk+MysV7vN2XQ+HIfN3InFYrBKoboHl+qGQxweQco8xq8P/9Sit1cj
	 kOoZp3W8l1QyYvOHEFxgu7IkNpy02K552t1pYvJLq2SFaMgTGCDAI4ZRjB3AD2ON2g
	 3gg7DkZ4ZXQ6vnaD2/Lrwq36W/WNM9AJF2US9OU7axaLrpIqPGW9+v4xE3Yo7pmggB
	 rhwGZZUAKxjVCZypXpXsILNaQ8/15+Y6Q9xzIPzeIfvgSw8gzPBAzYe7KBVaYxhyfE
	 cOvFQQYCuq+pA==
Date: Sat, 10 Feb 2024 18:22:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240210-gemolken-gasteltern-2ca46a9d7fa2@brauner>
References: <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240210165133.GD27557@redhat.com>

On Sat, Feb 10, 2024 at 05:51:33PM +0100, Oleg Nesterov wrote:
> On 02/10, Christian Brauner wrote:
> >
> > On Sat, Feb 10, 2024 at 02:15:18PM +0100, Oleg Nesterov wrote:
> > > On 02/10, Christian Brauner wrote:
> > > >
> > > > The question is what is more useful for userspace when they do:
> > > > pidfd_send_signal(1234, PIDFD_SEND_PROCESS_GROUP)?
> > > >
> > > > (1) They either mean to signal a process group that is headed by 1234.
> > >
> > > Yes, this is what I had in mind, see also another email from me.
> > > Simple, clear, and matches kill(-1234).
> >
> > I went for a walk and kept thinking about this and I agree with you.
> > It will require that 1234 will be a process group leader but I think
> > that this is ok to require that.
> 
> Yes... but I am starting to understand why you mentioned the new
> open PIDFD_PROCESS_GROUP flag... perhaps we can do something like
> this later, but this needs more thinking.
> 
> > +	if (type == PIDFD_SIGNAL_PROCESS_GROUP)
> > +		ret = kill_pgrp_info(sig, &kinfo, pid);
> 
> I guess you meant
> 
> 	if (type == PIDTYPE_PGID)
> 
> other than that,

Bahaa, yes of course.

> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks!

