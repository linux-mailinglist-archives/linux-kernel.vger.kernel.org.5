Return-Path: <linux-kernel+bounces-60402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DDE85046C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6544F1C21102
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD3481A4;
	Sat, 10 Feb 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIc0E/vV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9147A7E
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707569313; cv=none; b=BxtpGUe3IBH8DSqtT4J6RLWi87n344NhPjzuvBvc19qdrea6PT+bmuV3sNlYv1WXgy0pJrea8HUT0CVUHgGt0/o+m6DEEKa6+4J8W1N4Jo/kVx7FJn4p5lJwNdziTbPOvVzQ53s8cvq8kzUSUvQpYHxbFMkhZ9yWyDQkTmTsU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707569313; c=relaxed/simple;
	bh=5ZCGE2D6BjdHZDF56ZZ2sS6U790ZU0GDo6OY3wAA4II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoW073VVjYcxnCzTzUVSpv8yTW2NXkBkPFhhMXqbmOyUORTtKRCUqEsPJv77OmMYHqeGQPsr0Rrkr3o7jmT6qsrtZuGZSUUhGy/gMYMiurDa7WcTKrIy1cnTH6Pr2tT+I1rWSBMrX21iatkPUG90pDrWqBqORyhPD8HPbzrZ4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIc0E/vV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707569311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEhCrduBe0d0dS/swjdcoc7IV7EN3jeoaehg+0ZcY7U=;
	b=XIc0E/vVfTRMCl5O0cNWs/0iopceXxL5uWdMsLVZFrKy6mkH3Y3UCvAMFfxlzrlyCVi8vJ
	tRq57zpr9Acf4hmHung9xUmbnMR8juSvovdMPbSlMRNIBc4yCWAeefPkGYdHjIfNBwqorG
	VLbWpTQLMqDat7PK1BBEBiMVZdYIL+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-FBHrH_pdMsat5QBf9ecVqA-1; Sat, 10 Feb 2024 07:48:27 -0500
X-MC-Unique: FBHrH_pdMsat5QBf9ecVqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56419845DC0;
	Sat, 10 Feb 2024 12:48:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with SMTP id 64580200B3BE;
	Sat, 10 Feb 2024 12:48:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 10 Feb 2024 13:47:10 +0100 (CET)
Date: Sat, 10 Feb 2024 13:47:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240210124708.GB27557@redhat.com>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210123033.GA27557@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/10, Oleg Nesterov wrote:
>
> On 02/10, Christian Brauner wrote:
> >
> > (1) kill(-1234) => kill process group with id 1234
> > (2) kill(0)     => kill process group of @current
> >
> > which implementation wise is indicated by
> >
> > __kill_pgrp_info(..., pid ? find_vpid(-pid) ? task_pgrp(current))
> >
> > We're obviously not going to implement (2) as that doesn't really make a
> > sense for pidfd_send_signal().
>
> Sure,
>
> > But (1) is also wrong for pidfd_send_signal(). If we'd ever implement
> > (1) it should be via pidfd_open(1234, PIDFD_PROCESS_GROUP).
>
> Why do you think we need another flag for open() ?
>
> To me it looks fine if we allow to send the signal to pgrp if
> flags & PIDFD_SIGNAL_PROCESS_GROUP.
>
> And pidfd_send_signal() can just do
>
> 	if (PIDFD_SIGNAL_THREAD_GROUP)
> 		ret = __kill_pgrp_info(sig, kinfo, pid);
> 	else
> 		ret = kill_pid_info_type(...);
>
> (yes, yes, this needs tasklist, just a pseudo code to simpliy)
>
> Now lets recall about PIDFD_THREAD.
>
> If the target task is a group leader - there is no difference.
>
> If it is not a leader - then __kill_pgrp_info() will always return
> -ESRCH, do_each_pid_task(PIDTYPE_PGID) won't find any task.

To clarify, __kill_pgrp_info() should send the signal to pgrp
identified by @pid, so it will return ESRCH if the target didn't
do setpgid/etc.

> And personally I think this is all we need.

Yes. I don't think we should send a signal to task_pgrp(target).

And this matches sys_kill(). I mean,

	pidfd = pidfd_open(1234);
	pidfd_send_signal(pidfd, PIDFD_PROCESS_GROUP);

should act as kill(-1234).

> ------------------------------------------------------------------------------
> But if you want to make PIDFD_SIGNAL_THREAD_GROUP work even if the
> target task is not a leader, then yes, we need something like
>
> 	task_pgrp(pid_task(pid, PIDTYPE_PID))
>
> like you did in the new kill_pgrp_info() helper in this patch.
>
> I won't argue, but do you think this makes a lot of sense?
>
> Oleg.


