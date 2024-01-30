Return-Path: <linux-kernel+bounces-44214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599B841EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3341F2BA60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054FF5914E;
	Tue, 30 Jan 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoTkEI92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2C58120
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605907; cv=none; b=Q7+e+27Bir+C75VSxJqUWD/HwbCZ56Pg1BMAuKfHjWfyuidbkwlPOR5+K4mdr6H2YJzod7D4jC/V6cV0dqgKxE4tnWgYuVBZfx4R8fucs1IznLRrhaAZ35Qcw/talJWsVX2FA/8nFFHlhM3v5mOR0TtTRJr2kVn9+0xCvVEg5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605907; c=relaxed/simple;
	bh=iOP2KXEOOGWBsVf+9872GoWmuWoOPq2IE9ros2SOLHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMkEoyF31YnhsX8NqYRvLlbYI5B7p3cAo81sokBqwXsd4izzk48EaLBOimAebgRW1u5ji52zVW4xaNHhVb7CdnWZknIFKxQCHZEWToD8DysiBpj5NsEpWPyfv9yIUnTVcpxzJy+3idUWG55RqTA1BIOCdLxhdiuPh42MHArjftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoTkEI92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D23C433C7;
	Tue, 30 Jan 2024 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706605906;
	bh=iOP2KXEOOGWBsVf+9872GoWmuWoOPq2IE9ros2SOLHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoTkEI92AC+PUmil+8rH12bstaBvvlUN4UWkxg/3o8tOErY6zDfZDWL2COwZ6DnAb
	 o9rt87V+o+nvcsG2z2kqygnJzk96n6dGYIpeQorbyZNi8b4+fLUrfw7P4Hyjb1lzpt
	 eaPRfTUWFsJ7eyj9W3Pkrxm6MeqXpDuMoOZ8D29HYGBFZqnKqe/69k4/J8l+PNq90C
	 SivtCgSMpi5THdeJBNBrQM6m8FD1+Mlm8poYdIDCmwEsInUJccUQcFkSb5yBBA3uBu
	 epDT3+FI1nMpSVBYFH5eB5ME17K2HLFsPKycJkcbI8JtLLsB5FN2dxtCXwGaXJxvdr
	 BRyblMe11WcKg==
Date: Tue, 30 Jan 2024 11:11:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: use SZ_{8M, 128M} helper macro
Message-ID: <Zbi9OyG9kcldGyJ1@kernel.org>
References: <20240126085905.2835513-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085905.2835513-1-yajun.deng@linux.dev>

On Fri, Jan 26, 2024 at 04:59:05PM +0800, Yajun Deng wrote:
> Use SZ_{8M, 128M} macro intead of the number in init_user_reserve and
> reserve_mem_notifier.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/mmap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 476de5daf598..f90924b2a6d2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3845,7 +3845,7 @@ static int init_user_reserve(void)
>  
>  	free_kbytes = K(global_zone_page_state(NR_FREE_PAGES));
>  
> -	sysctl_user_reserve_kbytes = min(free_kbytes / 32, 1UL << 17);
> +	sysctl_user_reserve_kbytes = min(free_kbytes / 32, SZ_128M);

(1UL << 17) != SZ_128M

>  	return 0;
>  }
>  subsys_initcall(init_user_reserve);
> @@ -3866,7 +3866,7 @@ static int init_admin_reserve(void)
>  
>  	free_kbytes = K(global_zone_page_state(NR_FREE_PAGES));
>  
> -	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, 1UL << 13);
> +	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, SZ_8M);
>  	return 0;
>  }
>  subsys_initcall(init_admin_reserve);
> @@ -3898,12 +3898,12 @@ static int reserve_mem_notifier(struct notifier_block *nb,
>  	case MEM_ONLINE:
>  		/* Default max is 128MB. Leave alone if modified by operator. */
>  		tmp = sysctl_user_reserve_kbytes;
> -		if (0 < tmp && tmp < (1UL << 17))
> +		if (tmp > 0 && tmp < SZ_128M)
>  			init_user_reserve();
>  
>  		/* Default max is 8MB.  Leave alone if modified by operator. */
>  		tmp = sysctl_admin_reserve_kbytes;
> -		if (0 < tmp && tmp < (1UL << 13))
> +		if (tmp > 0 && tmp < SZ_8M)

(1UL << 13) != SZ_8M

>  			init_admin_reserve();
>  
>  		break;
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.

