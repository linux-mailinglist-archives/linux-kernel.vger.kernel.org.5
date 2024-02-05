Return-Path: <linux-kernel+bounces-52812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA7849CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6E284657
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C228E26;
	Mon,  5 Feb 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AShhOTyW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A922F11
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143036; cv=none; b=l8v2eS0cWyh12o4qfWmU2NLC2WLfUg4z0uX57pboyyCxtVtGxttBuwdaYz1gpXKZPhNIYNg4akTSMc8HTFNmT5jtva9a7n7uNZH4pXpBTt65LJqSJz9CUVv81yrxAZTRddw0DdavyinfZ/go1pjtgebcilwxllhgUFwoyKE0iMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143036; c=relaxed/simple;
	bh=6/5mKIj8fn/l/2zcBE1I76cqFTdIUIkRulboZYl02L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPGxF+8ZA+LadWGKZHEesDIu0TikEoOKKFTRD/F0czVU6tdydtgoOQGjbVIkc5PZFY19865gSZn/QBUOJMGCCqR7yQUwzdd8PsMz1rbbeu0STizHMns5iPC8AgsbuUXdityy8Yc99Y2vJFKrOVd9jTM7CiM9WNSfliqGGn0N/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AShhOTyW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707143033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vD4cczi13MuDg3gk2/XtBn2JMSKQaW/Vs1BWrM2cQA=;
	b=AShhOTyWieQhtLU0DPki5e6AkrsqIqlWHxUYQHiug0COlJtD9leHdqdibNrL/BiWyiM0rZ
	EJIN+hoDuX7J7w/FsoHgSWbf78BVKS+6KzWokF3IAfSuOmH2jgIaYXAIpuqADVc8LHkkor
	f2iz+2VzyTm4F5Jx56LY9dbNZw7QDPQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-hm6g-lS1M9iKInPMpQE9nw-1; Mon,
 05 Feb 2024 09:23:47 -0500
X-MC-Unique: hm6g-lS1M9iKInPMpQE9nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21C783CBDF61;
	Mon,  5 Feb 2024 14:23:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.165])
	by smtp.corp.redhat.com (Postfix) with SMTP id A9A1E40C95AD;
	Mon,  5 Feb 2024 14:23:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Feb 2024 15:22:31 +0100 (CET)
Date: Mon, 5 Feb 2024 15:22:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change do_notify_pidfd() to use
 __wake_up(poll_to_key(EPOLLIN))
Message-ID: <20240205142229.GA16757@redhat.com>
References: <20240205141050.GA16278@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205141050.GA16278@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Argh, sorry for noise Christian, I have sent the same patch twice.

Please ignore this email, the next email from me with the same
subject adds the reference to our discussion into the changelog.

On 02/05, Oleg Nesterov wrote:
>
> rather than wake_up_all(). This way do_notify_pidfd() won't wakeup the
> POLLHUP-only waiters which wait for pid_task() == NULL.
> 
> TODO:
>     - as Christian pointed out, this asks for the new wake_up_all_poll()
>       helper, it can already have other users.
> 
>     - we can probably discriminate the PIDFD_THREAD and non-PIDFD_THREAD
>       waiters, but this needs more work.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/signal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9b40109f0c56..c3fac06937e2 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2021,11 +2021,12 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  
>  void do_notify_pidfd(struct task_struct *task)
>  {
> -	struct pid *pid;
> +	struct pid *pid = task_pid(task);
>  
>  	WARN_ON(task->exit_state == 0);
> -	pid = task_pid(task);
> -	wake_up_all(&pid->wait_pidfd);
> +
> +	__wake_up(&pid->wait_pidfd, TASK_NORMAL, 0,
> +			poll_to_key(EPOLLIN | EPOLLRDNORM));
>  }
>  
>  /*
> -- 
> 2.25.1.362.g51ebf55
> 
> 


