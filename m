Return-Path: <linux-kernel+bounces-55436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A5484BCB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0581C24BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4281078B;
	Tue,  6 Feb 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8XgOjRz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE96DF42
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242854; cv=none; b=II9Zf6LWJATZY7MtCMVlSIufe6Ff7wKVc8ZUAP2Cs7ZwkgbuspohFioftjNhKB0jdVNu4I8wuFpNz3n2KxqS8OeZm7GiQUPySUyDkN/r6o7NUuvu3TwMF3kSnHhu5sqCbczp2Exy9SohJ/4UBoU3AP/Tpn8tBHNMUuYrbYkVTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242854; c=relaxed/simple;
	bh=GP3AdmJhwLFXuWiy7rvWADVhXvVh1fs62Emf7JRG3WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCskNuT897HSdMDLTGmr1l3zO22DcM4MyaFSxYpen/zPwA59/5Bf+SzxYWBx71z8UwHs/JG7fFnMnQnYrJZ3S8DFDRGiGrV06C3793skE1UZwOCat2LCMXeCFbDjvvbrtzzdBc+bexFulVt2tjLMFg4/CNJ10GfI5uYWJldv2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8XgOjRz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707242851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvMLQJZTmssaBchGK7lN9IcLsx2n0fKoUI5Hxr88UkU=;
	b=P8XgOjRzUDnR+cYdyV7IDULjN9GZxqX512RDQmhxqQIUohxEmgGxor1eD+mtjM3fVFYSET
	RDgYsjC+CwdHGh3ITxbnO+5/FnmOL2yZvj46r0plt+7FGfoTRmdgSuD6cKeJ3MNpV5bv/e
	RlsNv8Rl5TVD5E0yHjRv2f/Jtwi3KUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Acl4GtxYMTGuC8p1BvC62A-1; Tue, 06 Feb 2024 13:07:26 -0500
X-MC-Unique: Acl4GtxYMTGuC8p1BvC62A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACA0B101FA2F;
	Tue,  6 Feb 2024 18:07:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.46])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0E6EE112132A;
	Tue,  6 Feb 2024 18:07:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 Feb 2024 19:06:09 +0100 (CET)
Date: Tue, 6 Feb 2024 19:06:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240206180607.GB3593@redhat.com>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173722.GA3593@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Sorry for noise, forgot to mention...

On 02/06, Oleg Nesterov wrote:
>
> On 02/06, Tycho Andersen wrote:
> >
> > From: Tycho Andersen <tandersen@netflix.com>
> >
> > We can get EBADF from __pidfd_fget() if a task is currently exiting, which
> > might be confusing.
> 
> agreed, because EBADF looks as if the "fd" argument was wrong,
> 
> > Let's check PF_EXITING, and just report ESRCH if so.
> 
> agreed, we can pretend that the task has already exited,
> 
> But:
> 
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -688,7 +688,7 @@ static int pidfd_getfd(struct pid *pid, int fd)
> >  	int ret;
> >  
> >  	task = get_pid_task(pid, PIDTYPE_PID);
> > -	if (!task)
> > +	if (!task || task->flags & PF_EXITING)
> >  		return -ESRCH;
> 
> This looks racy. Suppose that pidfd_getfd() races with the exiting task.
> 
> It is possible that this task sets PF_EXITING and does exit_files()
> after the "task->flags & PF_EXITING" check above and before pidfd_getfd()
> does __pidfd_fget(), in this case pidfd_getfd() still returns the same
> EBADF we want to avoid.
> 
> Perhaps we can change pidfd_getfd() to do
> 
> 	if (IS_ERR(file))
> 		return (task->flags & PF_EXITING) ? -ESRCH : PTR_ERR(file);

Or we can check task->files != NULL rather than PF_EXITING.

To me this looks even better, but looks more confusing without a comment.
OTOH, imo this needs a comment anyway ;)

> 
> instead?
> 
> This needs a comment to explain the PF_EXITING check. And perhaps another
> comment to explain that we can't miss PF_EXITING if the target task has
> already passed exit_files, both exit_files() and fget_task() take the same
> task_lock(task).
> 
> What do you think?
> 
> Oleg.


