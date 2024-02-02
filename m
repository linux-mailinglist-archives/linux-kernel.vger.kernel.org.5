Return-Path: <linux-kernel+bounces-50104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4D5847447
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE966287EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B9914A095;
	Fri,  2 Feb 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9osmUOF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466F1474A0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890116; cv=none; b=eJ4NrKBPH90EyuXHKz5pdbctOk1Q+yJnk0jj3ajqfNdkqKvHxrb9PvV9omRaIGDpQwGa0y06DQ1CeG16aQi3Prcud/uyK+qeOAdOQcSv+TRY8znWGUpDRC51LGWlO/i7G1+YZLLK7Qah0hGWzvhvn458T69x7Kc3RheH/Mkoal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890116; c=relaxed/simple;
	bh=1JYwTqCJ4uEoMXlTYqJt81XgNj9XNyCI/UtWV9zdacU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0K0plzQySej6PFQmlQARCMhnqn9gOyaD/eqidi3TItEBqGYzOI9/Nh4Tl3u84Rn7g2R4t6cni5koUhfkIQFIDTf4MbKswcMa84zlzdZRH01zFBvJ90Oj+qof6NDH0TMnwsImF7XyWyHE9Y0b46szBtniW+JMNTVWyeX4owgDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9osmUOF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706890110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKooBkJfrlPFWZGh8ggsnfNNsYh5keDnQCkz6nhWuPk=;
	b=J9osmUOFTpl7/U5jMOtzfpZ4gmQW794k1VnEZ5JSex7fNJnZpSFvY5v7rMUNyroMdaVNbO
	Mnhlm6tHxaAZofVh4nauVwl4InfZ11hlFbb2CT6MmL/SUeJdTDtK48j39/W6o+XrBtCUcI
	Orx/l2VksYAuZgoHy0kE7BdV35UYymY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-uO0_bLxiPcyeNoLRLdLUIw-1; Fri, 02 Feb 2024 11:08:27 -0500
X-MC-Unique: uO0_bLxiPcyeNoLRLdLUIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1133988D01E;
	Fri,  2 Feb 2024 16:08:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id 32E992166B31;
	Fri,  2 Feb 2024 16:08:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Feb 2024 17:07:11 +0100 (CET)
Date: Fri, 2 Feb 2024 17:07:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202160704.GA5850@redhat.com>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
 <20240202-arbeit-fruchtig-26880564a21a@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-arbeit-fruchtig-26880564a21a@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/02, Christian Brauner wrote:
>
> > TODO: change do_notify_pidfd() to use the keyed wakeups.
>
> How does the following appended patch look?

No, no.

I think we need a simpler patch. I was going to send it as 4/4, but I'd
like to think more, _perhaps_ we can also discriminate the PIDFD_THREAD
and non-PIDFD_THREAD waiters. I'll try to make the patch(es) tomorrow or
at least provided more info.

3 notes for now:

	1. we can't use wake_up_poll(), it passes nr_exclusive => 1

	2. exit_notify() should not pass EPOLLHUP to wake_up, we do
	   not want to wake up the { .events = POLLHUP } waiters.

	3. we do not need to change __change_pid().

	   Well, _perhaps_ it can/should use __wake_up_pollfree(), but
	   I need to check if fs/select.c use "autoremove" or not.


> -static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> +static __poll_t pidfd_poll(struct file *file, poll_table *wait)
>  {
>  	struct pid *pid = file->private_data;
>  	bool thread = file->f_flags & PIDFD_THREAD;
>  	struct task_struct *task;
>  	__poll_t poll_flags = 0;
>  
> -	poll_wait(file, &pid->wait_pidfd, pts);
> +	poll_wait(file, &pid->wait_pidfd, wait);

This is correct but only cosemtic and has nothing to do with what
we discuss?

Oleg.


