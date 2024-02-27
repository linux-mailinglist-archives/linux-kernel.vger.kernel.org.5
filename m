Return-Path: <linux-kernel+bounces-84006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C654586A142
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1761F22034
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9314EFF3;
	Tue, 27 Feb 2024 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo6G1mRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29513AA36;
	Tue, 27 Feb 2024 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067502; cv=none; b=ufIFS0W5tM29b7vudR6dcW/sNPena+V+DPO38H4lX3Y+PYjptyq1d1ddHOlj9ONzOY+5qGasDNy5/Dcnv8A5a04SatxGHO4DTEYZYqBUKq8qsEzMu8+x7wsYN91/VtSprJZU0MJjyaRScuDCy8lBa5u1sLj7C8ijjivJqGKHzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067502; c=relaxed/simple;
	bh=S4m9bTr9zzQmMMFY2/OXtF3VQx5pxQRtlH/CRZM8IfM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BiNoe5K/lMudptGYflSMDjtAjqAA5N7QHiNzJ6EF40GpwvJbldM3LzUXyBUgxyYj8+4iuogrG9zhQdL4btq+KEeLqHWdE1BkhJ4yPGgoIBIZHD2xxYMYwBvJL/KNN4wUE2D0ZzuAR+Ka5f2LH/EFwmnMpD5ptIXbU8bvHQ0Pvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo6G1mRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEBAC43390;
	Tue, 27 Feb 2024 20:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709067502;
	bh=S4m9bTr9zzQmMMFY2/OXtF3VQx5pxQRtlH/CRZM8IfM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eo6G1mRufXusc5lBh8VM/I4kP7svGiyBEr5GcRHlW2rjy8FQ6LMKLVCmTbh5uUzK7
	 /4wqI2mIBHYcUUZQjAwFoZvHuy/ey/pSoFbG5wUffKiJXrp1l8NWFz4wlZq+IfcDZT
	 dfbMxAuBzypEcrjbDjDbjYrjhZ53lXcTchOKNeh8FSWjfgX6PAqyA92l64dGlyG2m9
	 3DKoCefKda353PzsCgR1KZYec9AoA5zN9HXoCtcA2+n0hoGVNtehajnKdNu0VtxE9O
	 yhQXUFqPbtfuuRWgF2ql2N4iQHHM82e3MCiyW5UwCTvYGojZ1Tb2Wer35+iBh05+dA
	 achG7ZtD0zjnw==
From: Kalle Valo <kvalo@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org,  Nishanth Menon <nm@ti.com>,  Breno Leitao
 <leitao@debian.org>,  Li Zetao <lizetao1@huawei.com>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wlcore: sdio: warn only once for
 wl12xx_sdio_raw_{read,write}() failures
References: <20240227002059.379267-1-javierm@redhat.com>
Date: Tue, 27 Feb 2024 22:58:18 +0200
In-Reply-To: <20240227002059.379267-1-javierm@redhat.com> (Javier Martinez
	Canillas's message of "Tue, 27 Feb 2024 01:20:46 +0100")
Message-ID: <8734tdaal1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Martinez Canillas <javierm@redhat.com> writes:

> Report these failures only once, instead of keep logging the warnings for
> the same condition every time that a SDIO read or write is attempted. This
> behaviour is spammy and unnecessarily pollutes the kernel log buffer.

Removing error messages is not usually a good idea, it would be much
better to fix the root cause.

> For example, on an AM625 BeaglePlay board where accessing a SDIO WiFi chip
> fails with an -110 error:
>
>   $ dmesg | grep "sdio write\|read failed (-110)" | wc -l
>   39

-110 is -ETIMEDOUT. Why is it timing out?

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  drivers/net/wireless/ti/wlcore/sdio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
> index eb5482ed76ae..47ecf33a0fbe 100644
> --- a/drivers/net/wireless/ti/wlcore/sdio.c
> +++ b/drivers/net/wireless/ti/wlcore/sdio.c
> @@ -75,8 +75,8 @@ static int __must_check wl12xx_sdio_raw_read(struct device *child, int addr,
>  
>  	sdio_release_host(func);
>  
> -	if (WARN_ON(ret))
> -		dev_err(child->parent, "sdio read failed (%d)\n", ret);
> +	if (WARN_ON_ONCE(ret))
> +		dev_err_once(child->parent, "sdio read failed (%d)\n", ret);

WARN_ON() feels excessive here, maybe remove that entirely? But
dev_err_ratelimited() feels more approriate than printing the error just
once.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

