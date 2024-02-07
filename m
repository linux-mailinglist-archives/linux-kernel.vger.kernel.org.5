Return-Path: <linux-kernel+bounces-56178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B480C84C70B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2F028307A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAF120DCC;
	Wed,  7 Feb 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwiXccck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAED20B21;
	Wed,  7 Feb 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297325; cv=none; b=VAUuAFlASaFpvsLA8n7dT+E1BK+Qx8CijqlsO1kvP4TfDP6TjuLnJCP1Af6hUVhXq5RHYJXiMP4GouEcWczsyAq8ByQ4P0sz1K+sqRS0xMVblRIrXc4r47TFa2bfs3nLW7PN2tJDMVW+s64SKeIxbrCMQvEwO8UJ4FBylMtPQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297325; c=relaxed/simple;
	bh=PdzsS0hD82qvdEpGRHg6Fb2zmu189QNDYRg81/jndD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL+Bmag4J1dpq3QXI3F3Cz6c0sZCXYamepbnqq3ZVt1xb6u2gNKsIA4bULjrVMWNu6tF5+G7m3YnzglDs3a6AMHH4S+LAegaySARTk0HSvjhyFzEruRL7/AXUXFvlGfgIj7o2cB5iJHTy9AohtA2BcR5qFisnfghAkneYzf+xi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwiXccck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98072C433C7;
	Wed,  7 Feb 2024 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707297325;
	bh=PdzsS0hD82qvdEpGRHg6Fb2zmu189QNDYRg81/jndD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwiXccckQ8miYKkauGuR2oS8cquNdxFMONQmEFEHnSoDA6w+ute/EcJBTF+VK+VW7
	 k9jlBTxNUhq1IHlridQCSTXM1ijvkGF0b2lX4WTyj9uVeRwYl0AbruO6xpQ7x/eOwu
	 Mt0TGaboGNc5las8H/5jxwdJMycwdl0q46gNZLzUx85Onwne02Uo6DIsNnD5nOWXDm
	 P+dsWU5S+Q26FlshAKGKP5o/6dAEmV44ZatEk3dzB7mB9Nc2I0GjD/uCi6YwSep7hS
	 Lzd0hWWFtDraFDO/KphLjumT1IxSVKmWoLhgyMDAGL/nUbG8+t0CqlXUkSm/OrZLBG
	 nOwKVdlHsHHIw==
Date: Wed, 7 Feb 2024 10:15:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v2] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240207-vibrieren-waldarbeiten-30eeade05203@brauner>
References: <20240206192357.81942-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206192357.81942-1-tycho@tycho.pizza>

On Tue, Feb 06, 2024 at 12:23:57PM -0700, Tycho Andersen wrote:
> From: Tycho Andersen <tandersen@netflix.com>
> 
> We can get EBADF from __pidfd_fget() if a task is currently exiting, which
> might be confusing. Let's check PF_EXITING, and just report ESRCH if so.
> 
> I chose PF_EXITING, because it is set in exit_signals(), which is called
> before exit_files(). Since ->exit_status is mostly set after exit_files()
> in exit_notify(), using that still leaves a window open for the race.
> 
> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> v2: fix a race in the check by putting the check after __pidfd_fget()
>     (thanks Oleg)
> ---
>  kernel/pid.c                                  | 17 +++++++++-
>  .../selftests/pidfd/pidfd_getfd_test.c        | 31 ++++++++++++++++++-
>  2 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index de0bf2f8d18b..a8cd6296ed6d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -693,8 +693,23 @@ static int pidfd_getfd(struct pid *pid, int fd)
>  
>  	file = __pidfd_fget(task, fd);
>  	put_task_struct(task);
> -	if (IS_ERR(file))
> +	if (IS_ERR(file)) {
> +		/*
> +		 * It is possible that the target thread is exiting; it can be
> +		 * either:
> +		 * 1. before exit_signals(), which gives a real fd
> +		 * 2. before exit_files() takes the task_lock() gives a real fd
> +		 * 3. after exit_files() releases task_lock(), ->files is NULL;
> +		 *    this has PF_EXITING, since it was set in exit_signals(),
> +		 *    __pidfd_fget() returns EBADF.
> +		 * In case 3 we get EBADF, but that really means ESRCH, since
> +		 * the task is currently exiting and has freed its files
> +		 * struct, so we fix it up.
> +		 */
> +		if (task->flags & PF_EXITING && PTR_ERR(file) == -EBADF)
> +			return -ESRCH;

Isn't that a potential UAF because we called put_task_struct() above but
this is exiting task->flags afterwards?

