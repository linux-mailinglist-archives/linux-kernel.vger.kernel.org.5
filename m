Return-Path: <linux-kernel+bounces-32917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A68361DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483331C26789
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C633E47F;
	Mon, 22 Jan 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmZLyxD1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADF3E47C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922732; cv=none; b=rjVuEzpN3/tKcTegtWXXK6OK1M9C2h82QG5sShrG6XCe8rCVX8pBB9UPRL1tKkq57FVxcN+ZhfyUAquZzOtqFi2I1cS36BCi2z5ju7JaVllDqLJOPjDttEUPaqr6RLhJ7qnMQqEtga2E13Lf+sJQkxI6E/2kmr/n87URFyuCYos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922732; c=relaxed/simple;
	bh=yXc/8XLOOLR6Z9plLFl2z0OyNMPhY1UIiDGVUTzvafo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4iNtG2cu+UgNpQNDH3dp8qopknPQly7vndznW/VKaKW1lHMovaH7MHJAQRCLwMHJJr6tZmIXfqZTjOE2sHtfr3vHVrPVHCNA4Oj3hK2C3u274dRuV+kOKF0GHhGYMGWp5nZoqvPVjKjVtgSyHGtF4ejBAjJ4VD3OzZYGSM7Npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmZLyxD1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705922728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riQqxqcCMG9kFQapL/gNYoUtbP5fQJDMoi01u205GP8=;
	b=ZmZLyxD1l7+xm7jnYnOyo2sM+VsQKj0hxsNAsE8HQXxJQ1mGIsruwU2uWgejrgJw2pAe7V
	PH+45HXaQsjtyIa/z3kxSl2Si4dMmOinsOrJlZjaP+sqOPfAuCAjXgtmt0Kkv/w8uPnW3O
	IqeC8li9NNghZG6ZZNfxNH7993aTf4o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-_ud-2dD-MIOk4mScLrS1nw-1; Mon, 22 Jan 2024 06:25:26 -0500
X-MC-Unique: _ud-2dD-MIOk4mScLrS1nw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2ecf1de44fso101354866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922725; x=1706527525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riQqxqcCMG9kFQapL/gNYoUtbP5fQJDMoi01u205GP8=;
        b=uRkO4hkNGJjFJi2C7UrYdbs4aeRxpfCq/cCdvNx1sTkpXr8Wby+1LyKuNZm/MvMjay
         yAsPDyE8wvV4eWGm2JEOhwMT3EihH1YLZlpgOant5t26O2qeZJZk0mOEzvJ2SLrvoo6M
         /UU25ElfsgUKW1FwKKuaO44GFDk/iYk1yGet3N4uBFsEHVCVhh07YKOf/yKOkpJEw8jf
         hnmTn0sRDiB1Qr2H+6BbfEtuGYlzDOUwi2k4L9Auybyd8r44HqRqQmWc5MkoXiNMZem9
         8g5lEprXSRZaijz3Aunskn1g0PYwVPebjprB6wiHCgguFmG/k3igSEgViO+fCkYrA+v1
         041w==
X-Gm-Message-State: AOJu0YzDkeRrJhhDD3lYOFulpWi8QvI0g/C2TS6fMcb9WRavX5GAw+mX
	t0y5Tnxf1wYe25VQ0OuQBXhkA/WYdNuATf5LXVAjj8BZYaqioGGZVuC1Q7MsupSoPBYqTgRTnuk
	otzwyM2Tpp3QyxijKesRMdghtrq2VA66+QUHRNrHzfoR56UlbqdJ/7FkMwqSyDA==
X-Received: by 2002:a05:6402:3551:b0:55a:4c93:5f18 with SMTP id f17-20020a056402355100b0055a4c935f18mr2395877edd.56.1705922725771;
        Mon, 22 Jan 2024 03:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuS/XeZ7X3jIuEkZ1wdxxVlgQdUokojOxb2Vu/AjfTL2q7ps6W27aFaSz9H/GnvkfB1dYJ/g==
X-Received: by 2002:a05:6402:3551:b0:55a:4c93:5f18 with SMTP id f17-20020a056402355100b0055a4c935f18mr2395872edd.56.1705922725450;
        Mon, 22 Jan 2024 03:25:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fi6-20020a056402550600b0055c38f3ca66sm1057376edb.29.2024.01.22.03.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 03:25:25 -0800 (PST)
Message-ID: <866474df-04b4-4b60-87af-6add6b80db5a@redhat.com>
Date: Mon, 22 Jan 2024 12:25:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] platform/mellanox: mlxbf-pmc: Fix offset
 calculation for crspace events
Content-Language: en-US, nl
To: Shravan Kumar Ramani <shravankr@nvidia.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Vadim Pasternak <vadimp@nvidia.com>, David Thompson <davthompson@nvidia.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8834cfa496c97c7c2fcebcfca5a2aa007e20ae96.1705485095.git.shravankr@nvidia.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <8834cfa496c97c7c2fcebcfca5a2aa007e20ae96.1705485095.git.shravankr@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/17/24 11:01, Shravan Kumar Ramani wrote:
> The event selector fields for 2 counters are contained in one
> 32-bit register and the current logic does not account for this.
> 
> Fixes: 423c3361855c ("platform/mellanox: mlxbf-pmc: Add support for BlueField-3")
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in the pdx86 review-hans branch once I've
pushed my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 1dd84c7a79de..b1995ac268d7 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -1170,7 +1170,7 @@ static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
>  	int ret;
>  
>  	addr = pmc->block[blk_num].mmio_base +
> -		(rounddown(cnt_num, 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
> +		((cnt_num / 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
>  	ret = mlxbf_pmc_readl(addr, &word);
>  	if (ret)
>  		return ret;
> @@ -1413,7 +1413,7 @@ static int mlxbf_pmc_read_crspace_event(int blk_num, uint32_t cnt_num,
>  	int ret;
>  
>  	addr = pmc->block[blk_num].mmio_base +
> -		(rounddown(cnt_num, 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
> +		((cnt_num / 2) * MLXBF_PMC_CRSPACE_PERFSEL_SZ);
>  	ret = mlxbf_pmc_readl(addr, &word);
>  	if (ret)
>  		return ret;


