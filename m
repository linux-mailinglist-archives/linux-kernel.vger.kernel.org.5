Return-Path: <linux-kernel+bounces-39020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D983C9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D2F1F2A3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A05130E2F;
	Thu, 25 Jan 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgirTWx3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9971481CB;
	Thu, 25 Jan 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203054; cv=none; b=D7yqlEVHai+chCN4Spx38dMD6ZiBCtto+6fdXo4mI/neC4H82NB0sZA2aQ2GjQhXqxDabwVmo2c7b8lfSoGm/c7k3f8EiD/Y60R9PZZKcB1MgGNwL4yMdr9cO+97gmLOYojR10uT38IK/is7sAHfY+h8y1WENUvPbqBeEKYSk2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203054; c=relaxed/simple;
	bh=XOkUlRa5eHk06Kro62nOMMdRLnDaIgyB0IrS1YuvRJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVBC4DFG8ZISsP2fKVO9T/UbtVWEZVc3Tqnjgu2Tq4xrQyMQdYmjjx5UQkg4Aazt3t83h6Y2hcqaw5D8hbDK8P3ckId8H+YL1DTLHzn+oEpPMxtpKXpfXAoDm/sBf11B6SPgg1sMl5PGvBVmshJdMc49BcfdXn7nY8vOo2fKnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgirTWx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797BAC433F1;
	Thu, 25 Jan 2024 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203054;
	bh=XOkUlRa5eHk06Kro62nOMMdRLnDaIgyB0IrS1YuvRJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgirTWx3sIMsG9sEKOoqvWpEEh7At8BEL6d0l5uVGzhRws5aFTvtjsmmOm4LbKPn4
	 ZlgAKOMo3Xy7R+NGFRNH/o+wuoYWkROsn3nnFyXauXWR7wQHYb+ZvWw6CunxluRtsQ
	 IeSd6Hgk8qXZiuHq5qFrbHtGfJ6YpCLr+KVTe+whB3uzs7+MbEHI0RNuwHKcYFF7DK
	 5Uy4SqW2he+UiiYnODrnJDNHpCz7AqgQyzmpiIigA3MHePwRk+iuW7i714nYTZRotg
	 MbEOHQZjbkc7Qzw0DWcCEZr/j8I8I/nZ0XbcLPdW6qMfan4dEAZn9WfmtjJJ8KF3wj
	 KLajivB4u4UIA==
Date: Thu, 25 Jan 2024 18:17:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240125-tricksen-baugrube-3f78c487a23a@brauner>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125140830.GA5513@redhat.com>

> > When it is reaped is "mostly unrelated".
> 
> Then why pidfd_poll() can't simply check !task || task->exit_state ?
> 
> Nevermind. So, currently pidfd_poll() succeeds when the leader can be

Hm, the comment right above mentions:

        /*
         * Inform pollers only when the whole thread group exits.
         * If the thread group leader exits before all other threads in the
         * group, then poll(2) should block, similar to the wait(2) family.
         */

> reaped, iow the whole thread group has exited. But even if you are the
> parent, you can't expect that wait(WNOHANG) must succeed, the leader
> can be traced. I guess it is too late to change this behaviour.

Hm, why is that an issue though? And if it is an issue why shouldn't we
be able to change it? Because a program would rely on WNOHANG to hang on
a ptraced leader? That seems esoteric imho. I might just misunderstand.

> 
> What if we add the new PIDFD_THREAD flag? With this flag
> 
> 	- sys_pidfd_open() doesn't require the must be a group leader

Yes.

> 
> 	- pidfd_poll() succeeds when the task passes exit_notify() and
> 	  becomes a zombie, even if it is a leader and has other threads.

Iiuc, if an existing user creates a pidfd for a thread-group leader and
then polls that pidfd they would currently only get notified if the
thread-group is empty and the leader has exited.

If we now start notifying when the thread-group leader exits but the
thread-group isn't empty then this would be a fairly big api change and
I would expect this to cause regressions as that surely is something
that userspace relies on. Am I understand this right?

