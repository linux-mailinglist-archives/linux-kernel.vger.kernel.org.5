Return-Path: <linux-kernel+bounces-95316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8F8874C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3DA282814
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB03084FCC;
	Thu,  7 Mar 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7TG1tNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C884FD6;
	Thu,  7 Mar 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806639; cv=none; b=qeNPMS+7YdXWmi+Xqfn0xIG/GyA0e6b0pcd0y49uXrt+9Vs+z4quWVq+wu/9SFh1cK3gqu9MV3uWTyIHea9E4QGSauPQOGA2bc31lGPEu8KnRrDE8wgTlu+754xNgb11xhpjwxg8LgnWoSchRR2FTZclPXwQ1IDTvb7yMFkI2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806639; c=relaxed/simple;
	bh=dSfsFSg4cADwP8Sk6K+DLBAvbPx8lxXSyAMiQIkTfkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl2nTlx81jZIOwU2GiV9k+HdoE1+xVCzKPeCMEPxqU8N5x9MSBAERFCCvH0dg0i9dNxcLJ99B9wPxmSnwoykhUi0lQ2mFwioo4sXgI93Vq7CdSZ3eTB7UTFS6H69hs5oXEaIE8vwpKTe9Tiib9fbjhycyUm6ij6eebhoKVFTMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7TG1tNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2020FC433F1;
	Thu,  7 Mar 2024 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709806638;
	bh=dSfsFSg4cADwP8Sk6K+DLBAvbPx8lxXSyAMiQIkTfkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7TG1tNbAzTL6AwHzkSDsH/OlOnRcNBf1OD2UTyJFOQZftoRnPLcZDOJI2XNPHQKq
	 Qh8pQPUphhRBJ2LF2tKooMGUxVShYY2eg5YfkxFZseRBp/n4VcqqSVOG7HtEoPew09
	 P6O6WIdRaWltEifNpZFxYYqN/6Li5o+8jCymc19DGud2vK7lTHBoFxCHxzoOZmR/MM
	 tWAqbTFae/nWu+im6xPFvNrrE7agij3gHqESmPV8CqQpg4RqOwK/bYzK8bbW2LqUp1
	 7Z4OkpoEdijpFTMlW/D6E1hnxZMbxg9DWvRVh9cL1c0qcGSVZcvcyO43MbGGp0Fghn
	 NeIMHYomjAx8g==
Date: Thu, 7 Mar 2024 11:17:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>, 
	Kees Cook <keescook@chromium.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Use f_cred in security_file_open() hook
Message-ID: <20240307-fehlten-gewinn-18c93d5fb9e6@brauner>
References: <20240307095203.1467189-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307095203.1467189-1-mic@digikod.net>

On Thu, Mar 07, 2024 at 10:52:03AM +0100, Mickaël Salaün wrote:
> Use landlock_cred(file->f_cred)->domain instead of
> landlock_get_current_domain() in security_file_open() hook
> implementation.
> 
> This should not change the current behavior but could avoid potential
> race conditions in case of current task's credentials change.

I have no problem with the patch but I'm curious how that credential
change could happen behind your back?

> 
> This will also ensure consistency with upcoming audit support relying on
> file->f_cred.
> 
> Add and use a new get_fs_domain() helper to mask non-filesystem domains.
> 
> file->f_cred is set by path_openat()/alloc_empty_file()/init_file() just
> before calling security_file_alloc().
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240307095203.1467189-1-mic@digikod.net
> ---
>  security/landlock/fs.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6f0bf1434a2c..c15559432d3d 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -248,15 +248,18 @@ get_handled_fs_accesses(const struct landlock_ruleset *const domain)
>  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>  }
>  
> -static const struct landlock_ruleset *get_current_fs_domain(void)
> +static const struct landlock_ruleset *
> +get_fs_domain(const struct landlock_ruleset *const domain)
>  {
> -	const struct landlock_ruleset *const dom =
> -		landlock_get_current_domain();
> -
> -	if (!dom || !get_raw_handled_fs_accesses(dom))
> +	if (!domain || !get_raw_handled_fs_accesses(domain))
>  		return NULL;
>  
> -	return dom;
> +	return domain;
> +}
> +
> +static const struct landlock_ruleset *get_current_fs_domain(void)
> +{
> +	return get_fs_domain(landlock_get_current_domain());
>  }
>  
>  /*
> @@ -1334,7 +1337,8 @@ static int hook_file_open(struct file *const file)
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>  	access_mask_t open_access_request, full_access_request, allowed_access;
>  	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> -	const struct landlock_ruleset *const dom = get_current_fs_domain();
> +	const struct landlock_ruleset *const dom =
> +		get_fs_domain(landlock_cred(file->f_cred)->domain);
>  
>  	if (!dom)
>  		return 0;
> -- 
> 2.44.0
> 

