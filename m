Return-Path: <linux-kernel+bounces-100097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FECD8791BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A604283AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D767866A;
	Tue, 12 Mar 2024 10:16:42 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7086F33994;
	Tue, 12 Mar 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238601; cv=none; b=RBBtTWVBPmBmMaSzOCxXPDFk4JI1go7oyFHl7LriGg4R6YRrYaDM+uUwtGNAZTxrJdnNHr5TjgaF2pSEtvztp5vRILCXI41LolHotYFXZZYlvZQNMn5noVjKrZj1pWhbEgYP0ibOZnPPMhO8oaqGrQ6LGSipLPYSNnmS9ESTDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238601; c=relaxed/simple;
	bh=V8fgbGcwYwbcwGV97uvR0GW9obhuumcbfnTf1wMuuKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVXVv7GHPTQMOVw2YK1607NQY+fVNq4+1LwM2V2lWcJRSrFYdDnUMYitczXEgi+u999eKsi96JEyNXj6bCk+r/xFzgQ5XZuwhK/F1tP2pWQuNDmYgbh+SGD4f0nCnd4RjzieSHIEPfRXCdu+3HRSjJjJx75NqTI/YHjyxGW3BIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id D653372C8F5;
	Tue, 12 Mar 2024 13:16:30 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id C79B87CCB3A; Tue, 12 Mar 2024 12:16:30 +0200 (IST)
Date: Tue, 12 Mar 2024 12:16:30 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
Message-ID: <20240312101630.GA903@altlinux.org>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-6-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912205658.3432-6-casey@schaufler-ca.com>

Hi,

On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
[...]
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>  {
>  	return security_getselfattr(attr, ctx, size, flags);
>  }
> +
> +/**
> + * sys_lsm_list_modules - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: pointer to size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
> +		u32, flags)

I'm sorry but the size of userspace size_t is different from the kernel one
on 32-bit compat architectures.

Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, ...)
now.  Other two added lsm syscalls also have this issue.


-- 
ldv

