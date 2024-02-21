Return-Path: <linux-kernel+bounces-74251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEE85D19C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC18428535E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79983AC2D;
	Wed, 21 Feb 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpNqZ7zi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43553A8FF;
	Wed, 21 Feb 2024 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501364; cv=none; b=u06Ex1giY2QDU/0Mk2QI89DMdcDKbLMBTGK1cXCOEk10UGIypzBGov1daaWMRXfQsnMb29hRjJaBXUWVQoGk6pYHOEt9JSzclun/mGdkGgk9QlYJzn0aLinGcieg4hQ9PtGOtpo7fYlY7R2gmuWMkx8XE8v4LOzjhVKFNtdxjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501364; c=relaxed/simple;
	bh=uXAz7xXdcMNahPSHz+7qP/fjoRiyBQeWYpw6GfEaaLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+o8GCi8PLKbBEBYbcs7qysV4+pNkE6eMpTrgoVXR1EBPzPinXSaG3a783kdsv83ZbC5Ge6+6k+FWRVaKMb/WjbXdx8Llqy3kqioQy230wU7dKA6wvXcJHJc5c8ny+Q21osFmVZAQpy0jIUgAWXy53+YYnhMPw+O4XNZzu2RmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpNqZ7zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0691C433C7;
	Wed, 21 Feb 2024 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708501363;
	bh=uXAz7xXdcMNahPSHz+7qP/fjoRiyBQeWYpw6GfEaaLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpNqZ7ziO14grUIYwy2MhFcYCRf2S/zmY0GlzrtHJIbBsYjeGHTmMMcfVaXJfFWRk
	 y1LHfAfoFnJE5GKdlRe1ST9BLbfLq2Eu0tH0RPBKBTVUUwPdrUOjc6rRcitVkEoZXO
	 7e1RoD1mBgafz0qfT4SBTeysmdoSFywhRB9pyIwcyo/DLpxsTruohTJUwD/hyYL+w7
	 z5QgzRn/oqoTsbXq3G3VzHoZzv/gTu1loZ7rvBDiSY6woJOfzTmZ8Ph1/uIsDI9IBG
	 XalnrB3PfinJQ7uZGUS2ocoQlJv3EFK5tmkNm6g3HiVKZAofC5hufbE2cJdkNz5jhK
	 F9hC/IctSCApw==
Date: Wed, 21 Feb 2024 08:42:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240221-zapfhahn-pulsschlag-e8f9d919c350@brauner>
References: <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
 <20240220090255.GA7783@redhat.com>
 <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
 <20240220110012.GB7783@redhat.com>
 <20240220-anlegen-feinmechaniker-3c2cfcc3ec01@brauner>
 <20240220162201.GD7783@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220162201.GD7783@redhat.com>

On Tue, Feb 20, 2024 at 05:22:02PM +0100, Oleg Nesterov wrote:
> On 02/20, Christian Brauner wrote:
> >
> > On Tue, Feb 20, 2024 at 12:00:12PM +0100, Oleg Nesterov wrote:
> > >
> > > Perhaps we can kill the "task_pid(current) != pid" check and just return
> > > EPERM if "kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL", I don't think
> > > anobody needs pidfd_send_send_signal() to signal yourself. See below.
> >
> > Yeah.
> 
> You have my ack in advance
> 
> > > > +       /* Currently unused. */
> > > > +       if (info)
> > > > +               return -EINVAL;
> > >
> > > Well, to me this looks like the unnecessary restriction... And why?
> >
> > Because right now we aren't sure that it's used
> 
> Yes, but...
> 
> > and we aren't sure what use-cases are there.
> 
> the same use-cases as for rt_sigqueueinfo() ?

Specifically for pidfd_send_signal() I mean. To me it seems very
unlikely that anyone would be opening a pidfd to itself and then use
pidfd_send_signal() when they could entirely avoid this - race free - by
simply using *sigqueueinfo(). But I may be wrong of course.

> 
> Christian, I won't really argue but I still disagree.
> 
> Let me first repeat once again, I do not know what people do with pidfd
> and pidfd_send_signal() in particular, so I won't be surprised if this
> change won't cause any regression report.

Fwiw, that's fine as long as we'd fix it up.

> 
> But at the same time, I can easily imagine the following scenario: a
> userspace programmer tries to use pidfd_send_signal(info != NULL), gets
> -EINVAL, decides it can't/shouldn't work, and switches to sigqueueinfo()
> without any report to lkml.
> 
> > Yes, absolutely. That was always the plan. See appended patch I put on top.
> > I put you as author since you did spot this. Let me know if you don't
> > want that.
> 
> Ah. Thanks Christian. I am fine either way, whatever is more convenient
> for you.
> 
> But just in case, I won't mind at all if you simply fold this minor fix
> into your PIDFD_SEND_PROCESS_GROUP patch, I certainly don't care about
> the "From" tag ;)
> 
> A really, really minor/cosmetic nit below, feel free to ignore:
> 
> > -		if ((task_pid(current) != pid) &&
> > +		if (((task_pid(current) != pid) || type > PIDTYPE_TGID) &&
> 
> we can remove the unnecessary parens around "task_pid(current) != pid"
> or add the extra parens aroung "type > PIDTYPE_TGID".
> 
> I mean, the 1st operand of "&&" is
> 
> 	(task_pid(current) != pid) || type > PIDTYPE_TGID
> 
> and this looks a bit inconsistent to me.

Ok, will do.

