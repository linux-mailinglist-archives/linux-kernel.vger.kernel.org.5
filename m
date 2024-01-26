Return-Path: <linux-kernel+bounces-40189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B683DBFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821891C223D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D91B81B;
	Fri, 26 Jan 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqGNxspG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB514A8F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279691; cv=none; b=rmCrAP/EokGqjoywgqG48LJJc7anjwVUA0v5jgSh1OGVc3yDpl2vbILfdJpHP/cIHPIe3ksnWTLaf7heUkfDYNaA5egwK0MHL0TbmI0Y877PuNvirdVjsquZLp6j/ze8rVZiLGKzr6UgdGjrP0uK+r6fML3/Boyc7rhXtyt7PWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279691; c=relaxed/simple;
	bh=O6w5GtbETgqNvB2B4amLXS691CrcakgId1zH5rYgGV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=std0qW2Xr7mwWfgRaElldvXOmZ8GnPiWIB339RVAt9XG+XKSeJkqEzvp5afGrFQqTp2Q7YRHjz/tC/whTBs2WUIoQfSCojuVfhPp/yachuEVBEPKdxyq+hAfWR1roSKVsIjmVtLA00mGQEdOJAN07hzfbUd3iesDkS6+pNRehaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqGNxspG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706279689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFn6EmRIbEx/AjhXTO5Xmd6giDPhExwD2qGwPUgkau4=;
	b=fqGNxspGs9ryLxndqdSVdZXj8xZ1XzsuEhiF/bYnIS+iDa8VTFVviKrpJJCtkTccuXzOAG
	NGfR/CeA77ZrzjI6oIzLDGF+Xl3L4jVnDLzQNudXehvMehje8+q/VFf3F2r+Bo23mNNqqg
	uQVAsWVboAGtcVDyzNLDtp3JwOnBBJs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-c-Dmt-ZFP1yuGrm51Z23CQ-1; Fri, 26 Jan 2024 09:34:43 -0500
X-MC-Unique: c-Dmt-ZFP1yuGrm51Z23CQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53F7A85A58F;
	Fri, 26 Jan 2024 14:34:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.164])
	by smtp.corp.redhat.com (Postfix) with SMTP id 78EB8492BFA;
	Fri, 26 Jan 2024 14:34:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jan 2024 15:33:29 +0100 (CET)
Date: Fri, 26 Jan 2024 15:33:27 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240126143326.GC7386@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240125-tricksen-baugrube-3f78c487a23a@brauner>
 <20240125175113.GC5513@redhat.com>
 <20240126-lokal-aktualisieren-fef41d9bce9f@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-lokal-aktualisieren-fef41d9bce9f@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 01/26, Christian Brauner wrote:
>
> No, it doesn't. I'm trying to understand what you are suggesting though.
> Are you saying !task || tas->exit_state is enough

If PIDFD_THREAD then I think it is enough. Otherwise we still need
!task || (exit_state && thread_group_empty)

> and we shouldn't use
> the helper that was added in commit 38fd525a4c61 ("exit: Factor
> thread_group_exited out of pidfd_poll"). If so what does that buy us
> open-coding the check instead of using that helper? Is there an actual
> bug here?

The patch adds the new xxx_exited(task, excl) helper which checks

	!task || (exit_state && (excl || thread_group_empty))

yes, the naming is not good.

> > Well, I didn't say this is a problem. I simply do not know how/why people
> > use pidfd_poll().
>
> Sorry, I just have a hard time understanding what you wanted then. :)
>
> "I guess it is too late to change this behavior." made it sound like a)
> there's a problem and b) that you would prefer to change behavior. Thus,
> it seems that wait(WNOHANG) hanging when a traced leader of an empty
> thread-group has exited is a problem in your eyes.

Again, I mostly tried to argue with do_notify_pidfd() called by realese_task().

I think that with PIDFD_THREAD set pidfd_poll() should succeed right
after the exiting thread becomes a zombie (passes exit_notify), whether
it is a leader or not.

Let me quote part of my reply to Tycho's patch

	> +	/*
	> +	 * If we're not the leader, notify any waiters on our pidfds. Note that
	> +	 * we don't want to notify the leader until /everyone/ in the thread
	> +	 * group is dead, viz. the condition below.
	> +	 *
	> +	 * We have to do this here, since __exit_signal() will
	> +	 * __unhash_processes(), and break do_notify_pidfd()'s lookup.
	> +	 */
	> +	if (!thread_group_leader(p))
	> +		do_notify_pidfd(p);

	This doesn't look consistent.

	If the task is a group leader do_notify_pidfd() is called by exit_notify()
	when it becomes a zombie (if no other threads), before it is reaped by its
	parent (unless autoreap).

	If it is a sub-thread, it is called by release_task() above. Note that a
	sub-thread can become a zombie too if it is traced.

Not to mention that this is racy.

I would not mind if we simply move do_notify_pidfd() from exit_notify() to
release_task() and do it regardless of thread_group_leader(). And in some
sense this looks more logical to me.

But as I said:

	- I do not know how/why people actually use poll(pidfd)

	- it is too late to change the current behaviour

Sorry for confusion.

> I'm not sure whether you remember that but when we originally did the
> pidfd work you and I discussed thread support and already decided back
> then that having a flag like PIDFD_THREAD would likely be the way to go.

All I can recall is that, yes, we had some discussions about pidfd in
the past ;)

> The PIDFD_THREAD flag would be would be interesting because we could
> make pidfd_send_signal() support this flag

Agreed,

Oleg.


