Return-Path: <linux-kernel+bounces-56206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9E084C75A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E48BB2341C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC5420DCD;
	Wed,  7 Feb 2024 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViONNc8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423020DE5;
	Wed,  7 Feb 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298196; cv=none; b=kzKgcMGl79S6Q3z7aKv9CZDm0e3/oi5yvA+71BFMSP7X86PFNlFOvK9adJEDl7ljPyL6odJluMp4RIphDWneY+eWIg5VErYsOGxrh0LH3yAIPskQHgn1KNz9RY8PyHSz0IqPkzqgWx2fa4NLtQ8aTzwXOZB3jsdiGynNr6QDntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298196; c=relaxed/simple;
	bh=AqL1GrUDNFS2//C3MYuy0qq/ymNdLTzPmwXANRzTwmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1uS6OGva7gDFScRm6DwtzzSsiB9NBR7OlBAyeS2pJ7tQ+j+hTT10LWmRnwXsMyXsBj6l9OoZaxj0j7WR9UKgpiu76QhwT0//xiwd0y292r3rnWXuJXwypaNdf1XfDDEx6E7MVUMldZABVoEw3feQVq9Lnqs80TOA94GwxzenpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViONNc8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C2EC433F1;
	Wed,  7 Feb 2024 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707298195;
	bh=AqL1GrUDNFS2//C3MYuy0qq/ymNdLTzPmwXANRzTwmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViONNc8yJsOV+qb8Z9cQNugPfNmJOGxrbuKKUoB11Lwbgr8NFXR+GkiTaufnc6Fqs
	 mx1n+KjKGfh0vStzchhZZmb4c9w89GYGHBfOJKNwiXwlaYmZaHH80KMqOL8zkDZNGX
	 D3kG2bBp5wLl0LfMhM2DraoyKVppeY1PsHQNwl9WynNzAZp+ivYNvejTU65SPvSDUh
	 4zVa7rBmhATzUjse7dmsC2rbk15BZLjZkKlop/nboB2pWiuF7r1eJ9Fjr7X9ntjWfd
	 YcNOEHbkzqcx/iRXfQjUxWLE2wkMFWUNUkfkBx4CU0ekVJgUOtk+mXPVA6boZVhtBb
	 +mTWppJv4SyIw==
Date: Wed, 7 Feb 2024 10:29:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v2] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240207-daran-fliesen-6039a2e36f39@brauner>
References: <20240206192357.81942-1-tycho@tycho.pizza>
 <20240207-vibrieren-waldarbeiten-30eeade05203@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207-vibrieren-waldarbeiten-30eeade05203@brauner>

On Wed, Feb 07, 2024 at 10:15:25AM +0100, Christian Brauner wrote:
> On Tue, Feb 06, 2024 at 12:23:57PM -0700, Tycho Andersen wrote:
> > From: Tycho Andersen <tandersen@netflix.com>
> > 
> > We can get EBADF from __pidfd_fget() if a task is currently exiting, which
> > might be confusing. Let's check PF_EXITING, and just report ESRCH if so.
> > 
> > I chose PF_EXITING, because it is set in exit_signals(), which is called
> > before exit_files(). Since ->exit_status is mostly set after exit_files()
> > in exit_notify(), using that still leaves a window open for the race.
> > 
> > Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> > v2: fix a race in the check by putting the check after __pidfd_fget()
> >     (thanks Oleg)
> > ---
> >  kernel/pid.c                                  | 17 +++++++++-
> >  .../selftests/pidfd/pidfd_getfd_test.c        | 31 ++++++++++++++++++-
> >  2 files changed, 46 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index de0bf2f8d18b..a8cd6296ed6d 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -693,8 +693,23 @@ static int pidfd_getfd(struct pid *pid, int fd)
> >  
> >  	file = __pidfd_fget(task, fd);
> >  	put_task_struct(task);
> > -	if (IS_ERR(file))
> > +	if (IS_ERR(file)) {
> > +		/*
> > +		 * It is possible that the target thread is exiting; it can be
> > +		 * either:
> > +		 * 1. before exit_signals(), which gives a real fd
> > +		 * 2. before exit_files() takes the task_lock() gives a real fd
> > +		 * 3. after exit_files() releases task_lock(), ->files is NULL;
> > +		 *    this has PF_EXITING, since it was set in exit_signals(),
> > +		 *    __pidfd_fget() returns EBADF.
> > +		 * In case 3 we get EBADF, but that really means ESRCH, since
> > +		 * the task is currently exiting and has freed its files
> > +		 * struct, so we fix it up.
> > +		 */
> > +		if (task->flags & PF_EXITING && PTR_ERR(file) == -EBADF)
> > +			return -ESRCH;
> 
> Isn't that a potential UAF because we called put_task_struct() above but
> this is exiting task->flags afterwards?

s/exiting/accessing/

