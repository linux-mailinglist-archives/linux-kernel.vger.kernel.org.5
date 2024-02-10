Return-Path: <linux-kernel+bounces-60403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3316A85046F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE992837BA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6577481A6;
	Sat, 10 Feb 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfUScMxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E863D554;
	Sat, 10 Feb 2024 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707569667; cv=none; b=DUBc3+wzDl5CgxruzD4kBQqYreBkWzA24nw/Gro8IEqKD5wABdGokuDYKvlQdJv/Fg2UF3V5Q3fkQGDLeybzObHtAJ0V/AajitIaftzuTEd9iTVKqYsRPoJpbnrzbl7oP99fUhCN2R4GUJku/iUd1zk6/GvUiOkLI4unMIwLes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707569667; c=relaxed/simple;
	bh=P3JJJiaFId5xU05cFeGLQCUxRMWxW3t2dKar6K/PXt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkhVzTCB4EgkrdGX2k/GmXY3Rw+4+HI+Z3OCPMJ179k+LE+4IgaI2GDJtpRJS3lmr2tZ2S+LtgkvXEtIYnFsBGTP8ZmVVpS7EoicqO+FDQS8l85zq/Z9VCSNkH7tzHgqDMG/PfVBIZjY5poO09yt46zBhBIDDS6/PaMNz03pvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfUScMxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A0FC433F1;
	Sat, 10 Feb 2024 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707569666;
	bh=P3JJJiaFId5xU05cFeGLQCUxRMWxW3t2dKar6K/PXt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfUScMxk+qyy5srl1agLhWC0mDHTIsxn+YGi1R3+g4Bbg3gCTaiWnEAkMikgOLLax
	 SDnGhjeQ7rqrhEfod8qptVjKWNe6GUFFH1GSFNMhj7ia1Lg2LyaX1mDXafPX4ikd4/
	 YKqB9d9WeVl7a5q8ae5Ex6jsOAL4foqsZs4VFLdjlxV9Q08sb1dWSiPm+sdQUlSZ9G
	 rvZ5dlYNz2oTO26mthRUaFCGvECJS4IvoAbFszoG2OQjXmQvU3oJJwnSa5nMoVDXFO
	 YRVW4BscSRRr+Jbz0XzmM4dsS4IumqXctyHrI1RRDFyvv+b98SQ/fQs+Qvlb8oLfFi
	 nFVqVb/kwvFiw==
Date: Sat, 10 Feb 2024 13:54:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240210-dackel-getan-619c70fefa62@brauner>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240210123033.GA27557@redhat.com>

On Sat, Feb 10, 2024 at 01:30:33PM +0100, Oleg Nesterov wrote:
> Christian,
> 
> Thanks again! the last 2 commits in vfs.pidfd look good to me.
> 
> As for this patch, I am not sure I understand your concerns, and I
> have another concern, please see below.
> 
> For the moment, please forget about PIDFD_THREAD.
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

We don't need one. We could if we wanted to was my point. But let's
ignore that for now.

> 
> To me it looks fine if we allow to send the signal to pgrp if
> flags & PIDFD_SIGNAL_PROCESS_GROUP.

Yes, that's what I want too, I just wonder about the semantics.

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
> 
> And personally I think this is all we need.
> 
> ------------------------------------------------------------------------------
> But if you want to make PIDFD_SIGNAL_THREAD_GROUP work even if the
> target task is not a leader, then yes, we need something like
> 
> 	task_pgrp(pid_task(pid, PIDTYPE_PID))
> 
> like you did in the new kill_pgrp_info() helper in this patch.
> 
> I won't argue, but do you think this makes a lot of sense?

The question is what is more useful for userspace when they do:
pidfd_send_signal(1234, PIDFD_SEND_PROCESS_GROUP)?

(1) They either mean to signal a process group that is headed by 1234.
(2) Or they want to signal a process group of which 1234 is a member or
    the leader.

From a usability perspective (1) is a lot more restrictive because it
requires @pidfd to refer to a process group leader. Whereas (2) doesn't
require userspace to hold a @pidfd to a process group leader. It is
enough to just hold a @pidfd. In other words, (2) has wider scope.

And intuitively that is what I had thought is more useful. But by that
logic PIDFD_SEND_THREAD_GROUP would have to signal to the thread-group
that @pidfd is in regardless of whether @pidfd is actually a
thread-group leader.

Which is also what you're pointing out, afaict.

