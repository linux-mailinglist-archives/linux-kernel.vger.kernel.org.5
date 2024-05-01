Return-Path: <linux-kernel+bounces-164966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC758B858C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A150B1F22E37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43C4D117;
	Wed,  1 May 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="k9Hg5Guy"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE294C3C3;
	Wed,  1 May 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714544697; cv=none; b=Adyle3qIi2hXa5FErel7PWP6Q9InxfShvPFsxplrKSSfN9wwec4qq2MbhB7/Sbz8LLSAj4iTB+c8EEizzfCTRdor8vTryw/5NWdSGWDpZZ8gX7r0dfq4gwGlCPiI5M8ef3ed3FhugKoO0a+iFNnAjz7j/5Qirzv7stwnIRp74yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714544697; c=relaxed/simple;
	bh=szuttc/QC/Sxc5UHd3+sAZAHunyukn12/WvWz5dIhy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j57aI8PqgHUeT46PRKdgog+petA7khQ3Q7Nrc7cOO5I/s/a7jtWwG0QbvBDT73Y4Irn0qx9XinTQDzaSsNSad1FTGyrphyM6IWPXd2CDDhPyeYAf3R6J7ROimf1IcilhAYWNeBE24RXTexIcHy54+Gu19p/nJMZzQsZbX/0obcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=k9Hg5Guy; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9851D1C0084; Wed,  1 May 2024 08:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1714544686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlywhDM5dANIfY7Auj2TGF5Vh0fzpL/TBhTvUnaV50U=;
	b=k9Hg5Guy34fpmsO6WvenI+gAzfoIvNXi9PQ/sZjGEkKA7Bn6kFQxfWbSlU2ZiQprE0FWa5
	bOZ+I9dbXivaC5w68EiypSk8FUNBQU2MvxGV9b8zWItZ+MHfwWfmOeKcLdArl6vmWAQQ8w
	BsOEggBeLbtFCKSJ1kG6VW/IcYVPNjA=
Date: Wed, 1 May 2024 08:24:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PM: hibernate: add retry mechanism for S4 image
 loading failures
Message-ID: <ZjHgLlAC3ArqFLH0@ucw.cz>
References: <20240501061258.2874092-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501061258.2874092-1-luoxueqin@kylinos.cn>

> During the S4 resume process, there's a rare chance of image loading
> failure. We provide three retries to load it successfully. If the
> recovery fails after these attempts, print out the handle CRC32
> value. When the CRC32 value obtained on each retry are inconsistent,
> there may be a memory anomaly. When the values are consistent, it
> might indicate corrupted swapped memory data.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>

NAK. If machine is so broken it can't load memory image, it is not
safe to  continue.

								Pavel
> ---
>  kernel/power/hibernate.c |  8 ++++++++
>  kernel/power/swap.c      | 14 ++++++++------
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 43b1a82e800c..d9bcf38221ef 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -703,6 +703,7 @@ static int load_image_and_restore(void)
>  {
>  	int error;
>  	unsigned int flags;
> +	int cnt = 0;
>  
>  	pm_pr_dbg("Loading hibernation image.\n");
>  
> @@ -713,7 +714,14 @@ static int load_image_and_restore(void)
>  		goto Unlock;
>  	}
>  
> +retry:
>  	error = swsusp_read(&flags);
> +	if (error && (cnt++ < 3)) {
> +		pr_err("Failed to load hibernation image, trying to load again...\n");
> +		swsusp_free();
> +		goto retry;
> +	}
> +
>  	swsusp_close();
>  	if (!error)
>  		error = hibernation_restore(flags & SF_PLATFORM_MODE);
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 5bc04bfe2db1..4b866c645cd7 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1489,15 +1489,17 @@ static int load_compressed_image(struct swap_map_handle *handle,
>  		ret = snapshot_write_finalize(snapshot);
>  		if (!ret && !snapshot_image_loaded(snapshot))
>  			ret = -ENODATA;
> -		if (!ret) {
> -			if (swsusp_header->flags & SF_CRC32_MODE) {
> -				if(handle->crc32 != swsusp_header->crc32) {
> -					pr_err("Invalid image CRC32!\n");
> -					ret = -ENODATA;
> -				}
> +	}
> +	if (!ret) {
> +		if (swsusp_header->flags & SF_CRC32_MODE) {
> +			if (handle->crc32 != swsusp_header->crc32) {
> +				pr_err("Invalid image CRC32, swsusp header CRC32: %u, handle CRC32: %u\n",
> +					 swsusp_header->crc32, handle->crc32);
> +				ret = -ENODATA;
>  			}
>  		}
>  	}
> +
>  	swsusp_show_speed(start, stop, nr_to_read, "Read");
>  out_clean:
>  	hib_finish_batch(&hb);
> 2.25.1

