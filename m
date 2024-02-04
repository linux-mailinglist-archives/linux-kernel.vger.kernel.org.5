Return-Path: <linux-kernel+bounces-51900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7DC849088
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C95282B14
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796428E3F;
	Sun,  4 Feb 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Lg3Mqzm4"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E22868D
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707080791; cv=none; b=hkccPh7r9NeDSRLjokFtQWPv+eb2aOPFaw+ILMxtKH+/KbfaeVe1tPvu02CM1VsxxYCWpfLyA6tIqIqMtGyPx5RZDfR0ltzilXpe3wijJryX34h5rG7iJgOetgrfPcTg1PsOZaWR12I75DQH6Ehn77kMN9mIdKxDhgpruWFzvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707080791; c=relaxed/simple;
	bh=PTpkAQYaiEd/H/K1pEJCdiG03wTlBPR/xvUqZnaKzc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzr7rl5JEeRS8MfgaFU53+qNuTKXgmrTRQfv4gi895s8Cg+VCUrCBBuqcFCUMk1OFvv61WWWk8YQvnWARoQqISf9Rh2BD+K3Ji3HsKtcjgKn+X7DWLpOB9UbA/++Fdwv9d3nnM9MXSKrY11KOzEKlJzbojERjpWz9i0Zs1uxNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Lg3Mqzm4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a372a3773a5so183682466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1707080786; x=1707685586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIBefr9jY7okRpcwBBo6tcStVqxml+OF8xjJACWyuys=;
        b=Lg3Mqzm4WzfQFGhaQV7dhSQzdFhfvPtZFdlMePwUtZ6xuJm1XRh41ZOGdCj+aWTzFj
         3saA9+S5jaa/vfqEYxVFc5e32mEzkvvwIKVkaXybEoH91lWy3DWTfmuTepaia4phvUFY
         zXPdJwk2pUMjsnenipIOvB9cg5fCpeCrYFFAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707080786; x=1707685586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIBefr9jY7okRpcwBBo6tcStVqxml+OF8xjJACWyuys=;
        b=FTqUAmLppPHLQ31ywbAYThe2TX/MIOLrMjgFlMHyyU67tiGM9HRmx/Ft2Y/yXFiLVG
         ebi9wVjOsBruMHQJkqE0JZG/BGjTqcb6gq8IA9zYReHON8xFiQ0sCv2i/P9PiejSWhvc
         RpoF3pDTs2fFRpkvdtub9+jcLQxtQJY4BUgusOKMVJyXOU3oBpBJhs71zSLBKfqMkFTZ
         UxhBFixI5kIukr8eAOwqSukqNxhKcUa9iYNFT2YIYQMl7DLV2SKRS64QanA6g3mnHvvE
         vwfWOKPhtHm4sHW5advI8C55RwZ/+BguUxG+UomYLMC496lllcS2UM1/iGA7D+0aQpDc
         3xrA==
X-Gm-Message-State: AOJu0YzjALqRxCKdzGvWRAtUYjti1AwfTHGGnXxVOJUejohRQ80rKh58
	Jz5Dybkd9Xy3SlSu4T9WXAp9SBD7sWsH6UIAAL/wRhDrD2SnBoLx5Vndhb5geA==
X-Google-Smtp-Source: AGHT+IGkokpPEnIXbIHAoQGWdATZZl6xxNcxvTGj+iXBZGdRkSBb+EOhzYTxOFZwHRqw5vByITGcig==
X-Received: by 2002:a17:906:d554:b0:a2f:b9be:66df with SMTP id cr20-20020a170906d55400b00a2fb9be66dfmr6807154ejc.17.1707080786682;
        Sun, 04 Feb 2024 13:06:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYQQKl7q9Vn/UAOvmcfLyfIm/GrO4H0ab7oKfZi3tiJb5xm9pQBy5eKYEK9Y5UtIAYZIiIf7GPnT7ICt9fZB2Gbj1S9tYBufvayaV0UNZT7lNjuRgwC6md504LsmvAcMIQA5qokHZxyioBRVAeeTFnwaAdxlnq4wdOr4e6h/5vEz5PBUFUF99x3BEC1i/PQkn8l6rbSNa8OVrqFws9eByrURodsF5OINMhSc9H1CIrIYAciSrS/r1TkGwklgb0A1yoPBFgyZ78
Received: from [10.211.55.3] ([94.107.229.70])
        by smtp.googlemail.com with ESMTPSA id hw16-20020a170907a0d000b00a372330e834sm2872890ejc.102.2024.02.04.13.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 13:06:26 -0800 (PST)
Message-ID: <fccd3a15-b3a1-4ea2-ad0f-a6c0d3a8e134@ieee.org>
Date: Sun, 4 Feb 2024 15:06:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rbd: make rbd_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>
Cc: ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-block-v1-1-fc77afd8d7cc@marliere.net>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240204-bus_cleanup-block-v1-1-fc77afd8d7cc@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/4/24 9:31 AM, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the rbd_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Great!

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 0202a4e5d6cf..21f2b9e9b9ff 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -575,7 +575,7 @@ static const struct attribute_group rbd_bus_group = {
>   };
>   __ATTRIBUTE_GROUPS(rbd_bus);
>   
> -static struct bus_type rbd_bus_type = {
> +static const struct bus_type rbd_bus_type = {
>   	.name		= "rbd",
>   	.bus_groups	= rbd_bus_groups,
>   };
> 
> ---
> base-commit: aa826a9b19b93bf8aabc462381ae436a60b2a320
> change-id: 20240204-bus_cleanup-block-9986bfea7975
> 
> Best regards,


