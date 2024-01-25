Return-Path: <linux-kernel+bounces-39057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512783CA52
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07D21F2217A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C2132C15;
	Thu, 25 Jan 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brdktsig"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754413173D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205156; cv=none; b=Esh4zWwGrAmbrkojTvPIux9dhABkY6a4bYp7l+zBtFCGoy257Y4xSLklk9AUXn7/iXdvkh5c95STDymE8uAhWAgR/AKh4audfupDCNL47wrBQNEfuRGFnE6pCtMQ9kcUl3Bqk+6F/WRLJioRBs/sjPO+F1L7f82q4UmGT96pnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205156; c=relaxed/simple;
	bh=Yy1GT2lp77XeMuurRLrfbVb7XC2c9zvSK8wdBd9j4ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT5+QO8WFDmNWOY/Xs5yjwUnWYnQzEkRKw9cezJAFA1lsxvYPQgi4vuCNqNab2KVc4ujB0eRUMJNitI3UkpDoGzpcMYc0AUiB0hDFOfDmPR08qMAcT5nx+/QuMvJoALNNmTVLG+bwoOZUK5+HDNBGABZ0KOA72plRbLQ7vbI42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brdktsig; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706205154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g5i6hZoO43ocf7ks9R4XVTZTyBaBFXg6GPxWhGdS98Y=;
	b=brdktsigcE+5aUnJnkMJTzj++O9/FclPytV/zh/8uRWyqW2U9D7xGRQxG0UH5vbMPCxCJF
	cyL07AERcnixy+puFvXGM75aT6oMN7b4yKUB/idONAVwMBy9GKuQ/BUxr+8YfRojD4DBCL
	4ceQfvwy3VKvRe7heTUzfXM3c/ewDaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-i6VYpv1nNoqo5h8Snemz_Q-1; Thu, 25 Jan 2024 12:52:30 -0500
X-MC-Unique: i6VYpv1nNoqo5h8Snemz_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E98748489B1;
	Thu, 25 Jan 2024 17:52:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 49EC440C106C;
	Thu, 25 Jan 2024 17:52:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jan 2024 18:51:16 +0100 (CET)
Date: Thu, 25 Jan 2024 18:51:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240125175113.GC5513@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240125-tricksen-baugrube-3f78c487a23a@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-tricksen-baugrube-3f78c487a23a@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 01/25, Christian Brauner wrote:
>
> > > When it is reaped is "mostly unrelated".
> >
> > Then why pidfd_poll() can't simply check !task || task->exit_state ?
> >
> > Nevermind. So, currently pidfd_poll() succeeds when the leader can be
>
> Hm, the comment right above mentions:
>
>         /*
>          * Inform pollers only when the whole thread group exits.
>          * If the thread group leader exits before all other threads in the
>          * group, then poll(2) should block, similar to the wait(2) family.
>          */
> > reaped, iow the whole thread group has exited.

Yes, but the comment doesn't contradict with what I have said?


> > But even if you are the
> > parent, you can't expect that wait(WNOHANG) must succeed, the leader
> > can be traced. I guess it is too late to change this behaviour.
>
> Hm, why is that an issue though?

Well, I didn't say this is a problem. I simply do not know how/why people
use pidfd_poll().

I mostly tried to explain why do I think that do_notify_pidfd() should
be always called from exit_notify() path, not by release_task(), even
if the task is not a leader.

> Because a program would rely on WNOHANG to hang on
> a ptraced leader? That seems esoteric imho.

To me it would be usefule, but lets not discuss this now. The "patch"
I sent doesn't change the current behaviour.

> > What if we add the new PIDFD_THREAD flag? With this flag
> >
> > 	- sys_pidfd_open() doesn't require the must be a group leader
>
> Yes.
>
> >
> > 	- pidfd_poll() succeeds when the task passes exit_notify() and
> > 	  becomes a zombie, even if it is a leader and has other threads.
>
> Iiuc, if an existing user creates a pidfd for a thread-group leader and
> then polls that pidfd they would currently only get notified if the
> thread-group is empty and the leader has exited.
>
> If we now start notifying when the thread-group leader exits but the
> thread-group isn't empty then this would be a fairly big api change

Hmm... again, this patch doesn't (shouldn't) change the current behavior.

Please note "with this flag" above. If sys_pidfd_open() was called
without PIDFD_THREAD, then sys_pidfd_open() still requires that the
target task must be a group leader, and pidfd_poll() won't succeed
until the leader exits and thread_group_empty() is true.

Oleg.


