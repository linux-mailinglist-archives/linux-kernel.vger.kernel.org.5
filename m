Return-Path: <linux-kernel+bounces-56140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C184C68A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5591F22BC8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA062233E;
	Wed,  7 Feb 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJvTgf5S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECF2231F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295521; cv=none; b=mwMkYxm5k0aN+bhzzWLL+YsM13v1zMjF5JReTjCHFEfxduOZCLqanWBT3PqSE8TN6xq+NqvqUcXpTiWCWEHptl+ZQKbNrPBuR5D33tE47hm5r0sAB4sj/cj8dNWW8z1C7xV0gTJCDXwxy+wkH6ny8cSQM11dC90EM5yrxi687lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295521; c=relaxed/simple;
	bh=x6TOK/SXpEcwBQEsj61MJOdrAEHzqaKovzCOQhEVAwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hjZHaox7y1/ML47SWCJoEJFSbNSrEMz4x+o+6fKf0PncyvUZQpgxyXk5MK9nPRihRQix7khp3FqneEKU6n9Ks354OrE88GZuABn2vJlv0+ewpzK4i7CvR7zsOC5/07rx5D8E5iTk60hfnY7sn4Hw311uK5BW7o/2nvop07U0Rs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJvTgf5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFF5C433F1;
	Wed,  7 Feb 2024 08:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295520;
	bh=x6TOK/SXpEcwBQEsj61MJOdrAEHzqaKovzCOQhEVAwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CJvTgf5ScE12wPa8XCNLRmT/HPUpSk1SHiBCCoPWym5MQ3IzDApPRzNAmKqhx0eXN
	 JisO5k4g19mymyd3jN5e1PXqBL3X2iwMoOehOk6mNCi/Ymnbh0MxIL4LLdrmcpY5Pk
	 zdaln3g1l+NCYGsSPCcOmuiK3t1lR9ktO9FahgYWbfktTe1P+MobzSkziC36EHE3X8
	 bI10NCn0NwzeQTLs3t0cu0+pHoHuVzoQ7HQDrRKBGRzc8jXZZdVcpm2OgJRHbTteao
	 MqLfj8w8cNxbhJWpWz9gWJ4I6ZVcjc47p/I4RLmwUspP6hf7YMTYdYF33uEVILgl38
	 kCUyiTQc4H8HQ==
Date: Wed, 7 Feb 2024 09:45:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: exit: kill the no longer used
 thread_group_exited()
Message-ID: <20240207-fenster-strotzen-b31de9bee30b@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcJmiBxpaElivX2J@tycho.pizza>
 <ZcJmbUzox6Rd3587@tycho.pizza>

On Tue, Feb 06, 2024 at 10:04:08AM -0700, Tycho Andersen wrote:
> On Mon, Feb 05, 2024 at 06:43:47PM +0100, Oleg Nesterov wrote:
> > It was used by pidfd_poll() but now it has no callers.
> > 
> > If it finally finds a modular user we can revert this change, but note
> > that the comment above this helper and the changelog in 38fd525a4c61
> > ("exit: Factor thread_group_exited out of pidfd_poll") are not accurate,
> > thread_group_exited() won't return true if all other threads have passed
> > exit_notify() and are zombies, it returns true only when all other threads
> > are completely gone. Not to mention that it can only work if the task
> > identified by @pid is a thread-group leader.
> > 
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> 
> Reviewed-by: Tycho Andersen <tandersen@netflix.com>

On Tue, Feb 06, 2024 at 10:03:41AM -0700, Tycho Andersen wrote:
> On Mon, Feb 05, 2024 at 03:13:48PM +0100, Oleg Nesterov wrote:
> > rather than wake_up_all(). This way do_notify_pidfd() won't wakeup the
> > POLLHUP-only waiters which wait for pid_task() == NULL.
> > 
> > TODO:
> >     - as Christian pointed out, this asks for the new wake_up_all_poll()
> >       helper, it can already have other users.
> > 
> >     - we can probably discriminate the PIDFD_THREAD and non-PIDFD_THREAD
> >       waiters, but this needs more work. See
> >       https://lore.kernel.org/all/20240205140848.GA15853@redhat.com/
> > 
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> 
> Reviewed-by: Tycho Andersen <tandersen@netflix.com>

I updated the trailers with your RVBs.

