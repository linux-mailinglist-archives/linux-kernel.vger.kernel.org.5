Return-Path: <linux-kernel+bounces-39953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4783D7C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C59C29DC53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58E7A714;
	Fri, 26 Jan 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJhFkcfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E741C73;
	Fri, 26 Jan 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262174; cv=none; b=VZL3eUVBAhKIHfhpIG4Nf3UjkSLoUtcL1o5jA2Uraf3O+OWfgSglgJuEy95W0bEfdRtsaBtVNUge259KQkICgVcibw0myKtHUG3QQaohiZ24fhvDoQDCyXjLavSPlk7bW6KlyyZcjJT2x9G8qWT6M1DSxkORgR4+EASStzlLtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262174; c=relaxed/simple;
	bh=iU+dhx4uwlWJ+Zksl8w2gW5ZDavTpu20u5Ubln+mkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6wew9m2L9W8Ro4TeUXP2l9VQYHDxE6jMUBW2d/2CK1e30R6loRCEz+LVV7TRCqFbOemvfG3zatL5r7Z2sc6A88Mv6N67KWlAToIteu10tKA31bhbEZtAy9VzKyZJetawWNFzFGGnaIkHsSIVUzqsfQb9ibEIkAaqTrEWWxfadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJhFkcfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152E2C433C7;
	Fri, 26 Jan 2024 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706262173;
	bh=iU+dhx4uwlWJ+Zksl8w2gW5ZDavTpu20u5Ubln+mkOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJhFkcfH5BAvpyB8BL40QECbmigZgT+0KVZRaZKcTaNK1vl+8xgwUNJ1FWwEgeoed
	 t0iD8R8HxVOG4XLbtJZ7rJzvXym5241fE8MWIQJR/liF44Sjn0pWCY7Ilwd4b2cnY2
	 5qbedr/7e+WCaZwO0wDCitPKaHrMuaxSdNfNLCYhpHf2Bb2/auVf5vUP3SkYISXamG
	 xsy57pHzr/i57HYgIklfpRbI+V3msv8PDDZWqZ5vmoO9bvKkkJo2ca9KJoYH2CEn9j
	 A5Hq+A638AI9Ml4C5vl4KbA20w2rZWZJjBAsLc4XYwvR3pecazLqwSiygkH8uHw0q8
	 je5q3xn8Lpobg==
Date: Fri, 26 Jan 2024 10:42:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240126-lokal-aktualisieren-fef41d9bce9f@brauner>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240125-tricksen-baugrube-3f78c487a23a@brauner>
 <20240125175113.GC5513@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125175113.GC5513@redhat.com>

On Thu, Jan 25, 2024 at 06:51:14PM +0100, Oleg Nesterov wrote:
> On 01/25, Christian Brauner wrote:
> >
> > > > When it is reaped is "mostly unrelated".
> > >
> > > Then why pidfd_poll() can't simply check !task || task->exit_state ?
> > >
> > > Nevermind. So, currently pidfd_poll() succeeds when the leader can be
> >
> > Hm, the comment right above mentions:
> >
> >         /*
> >          * Inform pollers only when the whole thread group exits.
> >          * If the thread group leader exits before all other threads in the
> >          * group, then poll(2) should block, similar to the wait(2) family.
> >          */
> > > reaped, iow the whole thread group has exited.
> 
> Yes, but the comment doesn't contradict with what I have said?

No, it doesn't. I'm trying to understand what you are suggesting though.
Are you saying !task || tas->exit_state is enough and we shouldn't use
the helper that was added in commit 38fd525a4c61 ("exit: Factor
thread_group_exited out of pidfd_poll"). If so what does that buy us
open-coding the check instead of using that helper? Is there an actual
bug here?

> > > But even if you are the
> > > parent, you can't expect that wait(WNOHANG) must succeed, the leader
> > > can be traced. I guess it is too late to change this behaviour.
> >
> > Hm, why is that an issue though?
> 
> Well, I didn't say this is a problem. I simply do not know how/why people
> use pidfd_poll().

Sorry, I just have a hard time understanding what you wanted then. :)

"I guess it is too late to change this behavior." made it sound like a)
there's a problem and b) that you would prefer to change behavior. Thus,
it seems that wait(WNOHANG) hanging when a traced leader of an empty
thread-group has exited is a problem in your eyes.

> 
> I mostly tried to explain why do I think that do_notify_pidfd() should
> be always called from exit_notify() path, not by release_task(), even
> if the task is not a leader.
> 
> > Because a program would rely on WNOHANG to hang on
> > a ptraced leader? That seems esoteric imho.
> 
> To me it would be usefule, but lets not discuss this now. The "patch"

Ok, that's good then. I would expect that at least stuff like rr makes
use of pidfd and they might rely on this behavior - although I haven't
checked their code.

> I sent doesn't change the current behaviour.

Yeah, I got that but it would still be useful to understand the wider
context you were adressing.

> 
> > > What if we add the new PIDFD_THREAD flag? With this flag
> > >
> > > 	- sys_pidfd_open() doesn't require the must be a group leader
> >
> > Yes.
> >
> > >
> > > 	- pidfd_poll() succeeds when the task passes exit_notify() and
> > > 	  becomes a zombie, even if it is a leader and has other threads.
> >
> > Iiuc, if an existing user creates a pidfd for a thread-group leader and
> > then polls that pidfd they would currently only get notified if the
> > thread-group is empty and the leader has exited.
> >
> > If we now start notifying when the thread-group leader exits but the
> > thread-group isn't empty then this would be a fairly big api change
> 
> Hmm... again, this patch doesn't (shouldn't) change the current behavior.
> 
> Please note "with this flag" above. If sys_pidfd_open() was called
> without PIDFD_THREAD, then sys_pidfd_open() still requires that the
> target task must be a group leader, and pidfd_poll() won't succeed
> until the leader exits and thread_group_empty() is true.

Yeah, I missed the PIDFD_THREAD flag suggestion. Sorry about that. Btw,
I'm not sure whether you remember that but when we originally did the
pidfd work you and I discussed thread support and already decided back
then that having a flag like PIDFD_THREAD would likely be the way to go.

The PIDFD_THREAD flag would be would be interesting because we could
make pidfd_send_signal() support this flag as well to allow sending a
signal to a specific thread. That's something that I had also wanted to
support. And I've been asked for this a few times already. What do you
think?

