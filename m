Return-Path: <linux-kernel+bounces-79019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01F6861C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585CEB233DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9560143C74;
	Fri, 23 Feb 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tEPf2WBO"
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5D7D413;
	Fri, 23 Feb 2024 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715832; cv=none; b=Lihw+bC63bc+7d0nMPIbFaIwIla/3jQhoNrlQSWyypE52+xVBnZRI5b1RfTCt6Dp0jqXPzNo4a/2/IPEUM5pGCCGHvYEZUsmb2YMm5dJls2xD+xlhroDEscNqdFeMggaEdQlxWrt8hRhE6BViv6sk0twUpvfziLciCASZJCWxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715832; c=relaxed/simple;
	bh=btAxHCenbi7nA/lRWN8WH3LBJ7bc55IUulvOXV3KHy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq4Xmq5GrSmvfob+6hkojqyoxZ4uSCCPYjhI0w3UciSIP2jahB7KG6709o+0s9vsvihYLXkH+hOqGA2DfqoPDsRsOwZC+76EwdVY+ucQbvaGmcyP2BPRQ6QHwPFg0KKkpOypXgjvRaTqmrI3B3fLC1CtfzX5+U0BQnjg/1kGI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tEPf2WBO; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThKWc173pzMq205;
	Fri, 23 Feb 2024 20:17:00 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThKWb3JSzzMpvFL;
	Fri, 23 Feb 2024 20:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708715820;
	bh=btAxHCenbi7nA/lRWN8WH3LBJ7bc55IUulvOXV3KHy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEPf2WBOddV0HtcOKEC89Zq1oHkkaqbIaJh7gNzZTdvff9eHWwSIfoKs7tUPC+Dg+
	 UpCviJ+Ib4KO5xHYkkkO4vtdWAXkWihiuLqBR5Mtj78Uu6Mkp+p5mE4z26sq4LXLcB
	 uDvHwTOeNX3xuAdjyaSslK3arp6nJMCing9z4RE8=
Date: Fri, 23 Feb 2024 20:16:51 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
Message-ID: <20240223.iph9eew7pooX@digikod.net>
References: <20240223190546.3329966-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223190546.3329966-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

These bugs have been found with syzkaller. I just sent a PR to add
support for the new LSM syscalls:
https://github.com/google/syzkaller/pull/4524


On Fri, Feb 23, 2024 at 08:05:45PM +0100, Mickaël Salaün wrote:
> selinux_lsm_getattr() may not initialize the value's pointer in some
> case.  As for proc_pid_attr_read(), initialize this pointer to NULL in
> selinux_getselfattr() to avoid an UAF in the kfree() call.
> 
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 762c934317e6 ("SELinux: Add selfattr hooks")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a6bf90ace84c..338b023a8c3e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6559,7 +6559,7 @@ static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>  			       size_t *size, u32 flags)
>  {
>  	int rc;
> -	char *val;
> +	char *val = NULL;
>  	int val_len;
>  
>  	val_len = selinux_lsm_getattr(attr, current, &val);
> -- 
> 2.43.0
> 

