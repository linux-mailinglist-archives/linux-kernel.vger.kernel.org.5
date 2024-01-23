Return-Path: <linux-kernel+bounces-35998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A48399E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91391C20B52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2594982D88;
	Tue, 23 Jan 2024 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwsxdhnA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C582D6E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039850; cv=none; b=MoX6qNcGr5SWRPirRYZWErOLKuTwywYJmhWzSnX3VTb/aM6DSadLQm8LbytdXilI2cyS7OZnOAPLAtY1oBJ0vJENEirKhxCtlINBJqmjoSwAdOE8k5W3+I/al3WK3d6YgOT+pfXRFruhSlU/31Vb2Y/xOM+wLsCOdX+CgqUSxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039850; c=relaxed/simple;
	bh=eHkPR3/xKx5knTznkRRWuM3jQAUkvV0DDAKaVcE10cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub32bvcvzz9Ma0WdZHmy5jLULDEPRcZjo2jRn/AbsH4Nr98uDzZkrAu7JvNUZpzLHILaT8gHte2Z38//jpr5omhw565ZnAATbD4ModjMQGS5LlwzWbeW3CoWbdr5zoE8xEveW+2wKEdkpdq1R8unuxvk/JUzhaOokg6AfbmNbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwsxdhnA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706039848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vwh8XXykxSRKxJ8L9h/647T2KFRZBxRZj81Ie4/Uls=;
	b=iwsxdhnAHqj2b/GBB/ktKueOKQgMLLQBE9xf0kW+kPLjv7PG5iDugMlrs0eVjohoMajRE/
	fB0XWA79EhI9BOyyxr2BNJFPJ2fo1NrmjIQBlkYYIqexlQ9kexBO1A4tcHRoyEJ1YHuMco
	VPW99LgUp4Ijb8NYEhSvR4Ut4fcRerA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-JItt-U_pOjajNrstXhT0bQ-1; Tue, 23 Jan 2024 14:57:24 -0500
X-MC-Unique: JItt-U_pOjajNrstXhT0bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4F9C10AFA03;
	Tue, 23 Jan 2024 19:57:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with SMTP id 82BEB2026D66;
	Tue, 23 Jan 2024 19:57:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jan 2024 20:56:10 +0100 (CET)
Date: Tue, 23 Jan 2024 20:56:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240123195608.GB9978@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153452.170866-2-tycho@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Too late for me, but I don't understand this patch after a quick glance.
perhaps I missed something...

On 01/23, Tycho Andersen wrote:
>
> @@ -256,6 +256,17 @@ void release_task(struct task_struct *p)
>  	write_lock_irq(&tasklist_lock);
>  	ptrace_release_task(p);
>  	thread_pid = get_pid(p->thread_pid);
> +
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

>  	__exit_signal(p);

and,  do_notify_pidfd() is called before __exit_signal() which does
__unhash_process() -> detach_pid(PIDTYPE_PID).

Doesn't this mean that pidfd_poll() can hang? thread_group_exited()
won't return true after do_notify_pidfd() above, not to mention that
thread_group_empty() is not possible if !thread_group_leader().

So. When do we want to do do_notify_pidfd() ? Whe the task (leader or not)
becomes a zombie (passes exit_notify) or when it is reaped by release_task?

Either way pidfd_poll() needs more changes with this patch and it can't
use thread_group_exited(). If do_notify_pidfd() is called by release_task()
after __exit_signal(), it can just check pid_has_task(PIDTYPE_PID).

Oleg.


