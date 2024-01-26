Return-Path: <linux-kernel+bounces-39955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082F383D7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1711F30FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF7844388;
	Fri, 26 Jan 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as61CN+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E654437B;
	Fri, 26 Jan 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262548; cv=none; b=aFGzwL6vP7Giz/kkaA7YFSIrnomx3b9n9h7JkwpFezhY0mXsW23oT4RW5g5qu4YugfX40kze08kmCYxZGYu8rUsNDajy8lmqqhfHZnvyxrSwXfp+ahV35DFGPJyTxPnGfAzE+d1o0YT/t6OjsKKjUDTcxU0007g5/H/aU4lrE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262548; c=relaxed/simple;
	bh=IcUa1qktRqvNoH2A8HXCfCg+Bdxwvo8ugy/XN/Mhhpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuqO25UwqwOsmBJDQfsByk7ZpYauMkdUe6e/1FHzFtxvsInvYq63F1IGgO2OIHHiLRYMUVU6bG3a93iDsvdNK4cB3I835QSaRs1JUhUebHjeSeEhKVc1wg7mUF4PxLRJaOAnhTCWIXZ9a10t44FLt1+HmXwkROQjhTbg+zt/HUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as61CN+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E03CC433F1;
	Fri, 26 Jan 2024 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706262547;
	bh=IcUa1qktRqvNoH2A8HXCfCg+Bdxwvo8ugy/XN/Mhhpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=as61CN+K+kYtPU9tAM0FhvKfsWpyarSk0YjOUKVn+FJBPU6VAW6z2lxjHdEj6hIUL
	 3bD8O++Ri18a7ssmrZtj3zH0qnZiuxAu+Dib+l7JRLpdXy0q7Pe1eqLBgj0cEHw9sP
	 SY2Kkz61keoyH2WGAHN9BhnTzszijxMGxYezNiznBeNcirw00JjJcdKU03uT+8aaFd
	 7B2YJbAv+YEh8Rc0kNQIremkWYcI71cyHxWenuPoXCjfef6Ah0uw7wmRVzUjrB3ZhP
	 epCKhyDUJqNAuFtBY+FY2/9eq0Cy2tYIbSIHW5gz9PJ7OYNYHF1fqSHrxjpyc1RqTT
	 sBKhu5cB+3egA==
Date: Fri, 26 Jan 2024 10:49:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240126-indiz-radrennen-8554de0bc074@brauner>
References: <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240125-tricksen-baugrube-3f78c487a23a@brauner>
 <20240125175113.GC5513@redhat.com>
 <ZbKigMNQM0Yklc/5@tycho.pizza>
 <20240125182505.GD5513@redhat.com>
 <20240125183045.GE5513@redhat.com>
 <ZbKqQl39WlqX8dgp@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZbKqQl39WlqX8dgp@tycho.pizza>

On Thu, Jan 25, 2024 at 11:36:50AM -0700, Tycho Andersen wrote:
> On Thu, Jan 25, 2024 at 07:30:46PM +0100, Oleg Nesterov wrote:
> > On 01/25, Oleg Nesterov wrote:
> > >
> > > On 01/25, Tycho Andersen wrote:
> > > >
> > > > One of the things I don't like about PIDFD_THREAD is that it's hard to
> > > > tell whether an arbitrary thread is a leader or not. Right now we do
> > > > it by parsing /proc/pid/status, which shows all the stuff from
> > > > do_task_stat() that we don't care about but which is quite expensive
> > > > to compute. (Maybe there's a better way?)
> > > >
> > > > With PIDFD_THREAD we could could do it twice, once with the flag, get
> > > > EINVAL, and then do it again. But ideally we wouldn't have to.
> > >
> > > Too late for me, most probably I misunderstood.
> > >
> > > If you want the PIDFD_THREAD behaviour, you can always use this flag
> > > without any check...
> 
> Sorry, I hadn't read the patch. If it's ok to use PIDFD_THREAD on a
> leader, then we can just always specify it. (We don't care about the
> behavior of pidfd_poll().)
> 
> > > Could you spell?
> > 
> > Just in case, we can even add PIDFD_AUTO (modulo naming) which acts as
> > PIDFD_THREAD if the target task is not a leader or 0 (current behaviour)
> > otherwise. Trivial.
> 
> Yep, or given the above, maybe it'll work as-is, thank you.

Yes, let's rather do the explicit PIDFD_THREAD.

