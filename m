Return-Path: <linux-kernel+bounces-71334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8B85A3A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4BA283585
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3E2E84A;
	Mon, 19 Feb 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1Y7TAAe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3582E832
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346426; cv=none; b=rPmxHm8RbDC5jYqLAUkOCYNhSvHjGJjPoEVQa7VOiv2ThuFRZPrFCG8n2wr1xbDbaGxwpaIwvZbWe+5DP7GzZvs9eZQjGdrPzcEmbyl/vydDngQ7vw/yoMgYTJpR5xm0+SDWD5RSiWJpU6m59aoGu1Stf9dsZou50ltpNVoFvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346426; c=relaxed/simple;
	bh=eCc2czVnLrR2p0hVwpCcQ0OeUJg74XlztzgLwxVGqBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjnT5QnzVaW2rkZpLqT+K9vgbkxHkizT81erFAq5zolWQot24D/KgXIz+WSy/oDHdwpTIekbpOHeqdWP9Qc3IAHqLI5EgpDYs6YJ6Seu08VCoFZGKXC/i+2tP+oDbNO0BYzZoiB1ytYI28Ik6q4gq+aqil//b+Gb+Z4g14O/nkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1Y7TAAe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708346423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSoWtrntvZIWbBvyP8tHbFaYn0WgGKZufHXTx2xqEdU=;
	b=F1Y7TAAenyC5pS/MBHntHt6BEhudbz7C5zQnDBihlrn/9sEq1b8/mgd76ZdiR3KCBpX/XW
	FdoRy6VVJohGV6gRi2SBHuJziWMbFIpWTnVzjV/v0Lh4s894Tx0IIsxWa/NghLzXW5wmYU
	EWC+i5RKlNyQqufZFLDm7NwQrPEJvkw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-sNV2z4jEOyupa5qdAqt3Mg-1; Mon, 19 Feb 2024 07:40:21 -0500
X-MC-Unique: sNV2z4jEOyupa5qdAqt3Mg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3d7cd58ae2so147854666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346420; x=1708951220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSoWtrntvZIWbBvyP8tHbFaYn0WgGKZufHXTx2xqEdU=;
        b=TKvwRBNrM/aUWfMvpnBpeJfLIj89ccmJxUAlXuES7Or5dHVxQYjpRxQQ9Ca4vUnYwP
         XVTdGpk4GEqvJyNc0RbLGmFrEfViP5kgiXbbhKeyKoVEIR5UQrGONxqzGFzTC2I2KEPA
         oFoRvUhJ7n13uYeoh0ZAudBj8bZ2oitCnrhemXckY4R2IRbQoAs0xjE7GkiUr7UKSr1x
         koHi/HnW1EOM4hA4AGyV2LUsVVKw8p1gy+20ybPgiz7JOuOcSWxGbS2Ab2X1jJko9h5W
         efgSWesRVC79e9q1XESuBeF7IX/V+LfNPuawJUkD6YgR1jNZjT7hwZBRad3iOmODzv1c
         t3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWl7uGugQAxBAZuZQ1Efc2pyJjF7ysat/bx7chcPSbOVOREJ1PbGprYF/7DzNUtTSw+NqcYGIZidi8GVRDroc/nfisbsWQUMxYp1i7
X-Gm-Message-State: AOJu0YwX1+oBCBrNHHQp77+ymEQ8QrH6DCYgwvHJcMI14CtWsDE3e9Gm
	pzTTVFEhtb0+PLcArinOTjLXiDWkVf71Jrv+R1zNTMt8VI9FAPT3krAiX0OqrIHn6wMznTjmEjh
	m9DyE+6JXsrNLDXvygUaoraUB1eR624cX++oj+Vega5O1vuTUpu8KiCwwVuh1EQ==
X-Received: by 2002:aa7:d9d0:0:b0:564:1cc7:eae5 with SMTP id v16-20020aa7d9d0000000b005641cc7eae5mr3840387eds.5.1708346420521;
        Mon, 19 Feb 2024 04:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJPwTlrDEIiQMRVVihRGIPASE6RYyVHWyKpduDzXfgFX4C0OoLGPoJXJ0K8YO5iiFR7giCXA==
X-Received: by 2002:aa7:d9d0:0:b0:564:1cc7:eae5 with SMTP id v16-20020aa7d9d0000000b005641cc7eae5mr3840375eds.5.1708346420235;
        Mon, 19 Feb 2024 04:40:20 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id x16-20020a056402415000b005644e4fdf36sm1657308eda.6.2024.02.19.04.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 04:40:19 -0800 (PST)
Message-ID: <f6cc1cf6-b8e3-4687-83a6-3880b033288f@redhat.com>
Date: Mon, 19 Feb 2024 13:40:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix a potential race with policy
 binary sideload
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, Shyam-sundar.S-k@amd.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217015642.113806-1-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240217015642.113806-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/17/24 02:56, Mario Limonciello wrote:
> The debugfs `update_policy` file is created before
> amd_pmf_start_policy_engine() has completed, and thus there could be
> a possible (albeit unlikely) race between sideloading a policy and the
> BIOS policy getting setup.
> 
> Move the debugfs file creation after all BIOS policy is setup.
> 
> Fixes: 10817f28e533 ("platform/x86/amd/pmf: Add capability to sideload of policy binary")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Closes: https://lore.kernel.org/platform-driver-x86/15df7d02-b0aa-457a-954a-9d280a592843@redhat.com/T/#m2c445f135e5ef9b53184be7fc9df84e15f89d4d9
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans

> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index 4f74de680654..8527dca9cf56 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -456,8 +456,6 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
>  	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
>  
>  	amd_pmf_hex_dump_pb(dev);
> -	if (pb_side_load)
> -		amd_pmf_open_pb(dev, dev->dbgfs_dir);
>  
>  	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
>  	if (!dev->prev_data)
> @@ -467,6 +465,9 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
>  	if (ret)
>  		goto error;
>  
> +	if (pb_side_load)
> +		amd_pmf_open_pb(dev, dev->dbgfs_dir);
> +
>  	return 0;
>  
>  error:


