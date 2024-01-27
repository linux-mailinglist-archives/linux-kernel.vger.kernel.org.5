Return-Path: <linux-kernel+bounces-41162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7E83ECC3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4691C21A27
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922421F61C;
	Sat, 27 Jan 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxuX+qzB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192301EB23
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706352958; cv=none; b=K9jf+tiaboL2pLQq4d34Usr1qxGbNSxWOrTTWR91T1Z9PZrzPxabP4ZrVPM6yzHjiH6Cf7BNJMUTNsiV9uOb1GucV0SdtGP+XT+/a0YnKi+U2guHjOSp7C0304ShkQOoGtc1Oga1sIzDxsKhgHiQNZd+/lA8sbRh9f590yEOk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706352958; c=relaxed/simple;
	bh=+2nxUypKCl4qZXxWoMbNPWaDEVm/qCE9a1uPbOpHh8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkJIdR6t4hmU0vCyWf76Axpq5LiyExTKcoGpUp7bhFBrC2cDuOorjR/pQKKqi8pLNXovEA/HUjuOvFtd653cD3/NaldJVcItJPK875jUMLn6EIV5LBoHamQxR4ELwkgSNsKFugsAoSNO9TANYY7fkV9aXwuk8BiolkBwqSMLkkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxuX+qzB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706352956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhSpdrAEG/Xg7ifdmmn18ddjocywgcMnyaE1xYJmTF0=;
	b=DxuX+qzBtYhZXWbLC+ZEcV5dtm+d11BZQaVRJrfVV0FMrucOPdtEQsC1MYY8nqSLdLh2v1
	31sgf79MCVK9cYGWIi7kGHCkvifZYqCDY5oqy7nZiDf8w1knFqT8Im+E2144ap5vhulPXr
	umqaojPJ0++6So40B8jtgvd8JOq5tg0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-yau6CuoZNXebOAapKq6-JA-1; Sat, 27 Jan 2024 05:55:50 -0500
X-MC-Unique: yau6CuoZNXebOAapKq6-JA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDFA085A58A;
	Sat, 27 Jan 2024 10:55:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by smtp.corp.redhat.com (Postfix) with SMTP id D93C31121306;
	Sat, 27 Jan 2024 10:55:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 27 Jan 2024 11:54:35 +0100 (CET)
Date: Sat, 27 Jan 2024 11:54:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240127105410.GA13787@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQpPknTTCyiyxrP@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Tycho,

On 01/26, Tycho Andersen wrote:
>
> On Thu, Jan 25, 2024 at 03:08:31PM +0100, Oleg Nesterov wrote:
> > What do you think?
>
> Thank you, it passes all my tests.

Great, thanks!

OK, I'll make v2 on top of the recent
"pidfd: cleanup the usage of __pidfd_prepare's flags"

but we need to finish our discussion with Christian about the
usage of O_EXCL.

As for clone(CLONE_PIDFD | CLONE_THREAD), this is trivial but
I think this needs another discussion too, lets do this later.

> > +	/* unnecessary if do_notify_parent() was already called,
> > +	   we can do better */
> > +	do_notify_pidfd(tsk);
>
> "do better" here could be something like,
>
> [...snip...]

No, no, please see below.

For the moment, please forget about PIDFD_THREAD, lets discuss
the current behaviour.

> but even with that, there's other calls in the tree to
> do_notify_parent() that might double notify.

Yes, and we can't avoid this. Well, perhaps do_notify_parent()
can do something like

	if (ptrace_reparented())
		do_notify_pidfd();

so that only the "final" do_notify_parent() does do_notify_pidfd()
but this needs another discussion and in fact I don't think this
would be right or make much sense. Lets forget this for now.

Now. Even without PIDFD_THREAD, I think it makes sense to change
do_notify_parent() to do

	if (thread_group_empty(tsk))
		do_notify_pidfd(tsk);

thread_group_empty(tsk) can only be true if tsk is a group leader
and it is the last thread. And this is exactly what pidfd_poll()
currently needs.

In fact I'd even prefer to do this in a separate patch for the
documentation purposes.

Now, PIDFD_THREAD can just add

	if (!thread_group_empty(tsk))
		do_notify_pidfd(tsk);

right after "tsk->exit_state = EXIT_ZOMBIE", that is all.

This also preserves the do_notify_pidfd/__wake_up_parent ordering.
Not that I think this is important, just for consistency.

> This brings up another interesting behavior that I noticed while
> testing this, if you do a poll() on pidfd, followed quickly by a
> pidfd_getfd() on the same thread you just got an event on, you can
> sometimes get an EBADF from __pidfd_fget() instead of the more
> expected ESRCH higher up the stack.

exit_notify() is called after exit_files(). pidfd_getfd() returns
ESRCH if the exiting thread completes release_task(), otherwise it
returns EBADF because ->files == NULL. This too doesn't really
depend on PIDFD_THREAD.

> I wonder if it makes sense to abuse ->f_flags to add a PIDFD_NOTIFIED?
> Then we can refuse further pidfd syscall operations in a sane way, and

But how? We only have "struct pid *", how can we find all files
"attached" to this pid?

> also "do better" above by checking this flag from do_pidfd_notify()
> before doing it again?

and even it was possible, I don't think it makes a lot of sense, see
also above.

but perhaps I understood you...

Oleg.


