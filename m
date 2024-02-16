Return-Path: <linux-kernel+bounces-69156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DD85852A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC7C1F215D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAD136678;
	Fri, 16 Feb 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuzPwnJ8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A7135400
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108088; cv=none; b=a6Qf5GQS6b8r0qwxr0mUA29kSYciVwhMqWtBtXaSL6KlPNXm8Ji+DW54CcZAfg7b0GJNoKQsKmSf9avrzlCV9QfkPAC9EP79UOdkWDCstOqItA16GX8O9jF+37FveSLx2C+taarTzmt2FJs1FVPbMoJybcutV3TumqLzEgbGX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108088; c=relaxed/simple;
	bh=JpCJOojqx/HfeVTgc5nG9gyIcDxyi7NBWEmokq6KIOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSOx/f/5qrE2UD3xeZhzynGv63j/ueNzb5T5sHIniiXHHz3gYMILpeiIbLfgWmsZnIiXTZDpJT3haDpqmCJY7euD/T5q/YQtSL3QKqF6Il4IqStdIRB++PkSLGK+POu1w97PX9N/sGCoeQ5smSMs2EG5k+MYZYD7SNCFsu3FGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuzPwnJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708108085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04otk5iNZ32itm1hBkllWfSwBWl7wL1ic55X2+oUtF8=;
	b=OuzPwnJ86Cz+5xKg4WbOapzOnsMHr6TwMCZWwYAFTfwHVD3ZJGk+/NpSBKnRHJvjOde2lQ
	xif8LUGp8MjF1VwcgjVQpGwSAnGCcg+kw0gTI+4k+XGn+RnCZeseWMDt68adwxxVc9/LQZ
	IJn+uoMFhHHQ0ZQkO3gD0eds6uniJmY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-FGRI0xkuPTOKuOQxPJP0OQ-1; Fri, 16 Feb 2024 13:28:03 -0500
X-MC-Unique: FGRI0xkuPTOKuOQxPJP0OQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-511681b1fc4so2240230e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108082; x=1708712882;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04otk5iNZ32itm1hBkllWfSwBWl7wL1ic55X2+oUtF8=;
        b=YbRiYImwfCTnXng349PExS3pV78xrkPs70HrRQS1mFC1WH+kQKm60WSpYryyXtMHUj
         IXRzDpMD9KqDV13G2ylmH87xGWrQEXIPGMa20HiSWOcHFQ/rJu+iMVGKh4MqW0d4icsx
         CL7HD2KWCncyzh3GdoFwslVO35lehtqVzvKgBK/qIyEj4PKBK4Jr1uE9jpvlAMO0VxPw
         MXupPPc+u+F0wCMXNXGSdId4WdkjMAcmLO9M6Vq2PBM+9sMNlgWXQplTcee6lcjA5dzh
         ASCRg4e9qnDOII3lPJ8pEXEKsUJSJPc7nLmOrV5x2wXSxr8/PyFlkfe4SO/1Zg7+5QTr
         hUlA==
X-Forwarded-Encrypted: i=1; AJvYcCWwcLMqWVfw9juG749mghJ2uOMB8l3sUo8qX4FO/mCvJXMIP3VpGufgr9aZ2ePZSulTUFHvB7Fmmqg+sFOreS92Wbm8b0q1r1VEOzTc
X-Gm-Message-State: AOJu0YwwjSthTkMRa3HLqr9c73hFzyM8mWCpWwbrvkomhVI5fcMm0SNy
	Z7Vhry49KLFjP76xPZhmIuJgBuQT63DvnFKb9oN9kJQHE99tMz2VQg42tOFqV6GXn56mlFlsCmI
	V9UPHbrWnJR89T6lV7p8C0RR5F3xpUiGGaWd747YJLXH4AHgTarnyB5Y3c7hhgA==
X-Received: by 2002:a05:6512:6d5:b0:512:86fa:a781 with SMTP id u21-20020a05651206d500b0051286faa781mr5126921lff.62.1708108082049;
        Fri, 16 Feb 2024 10:28:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlTdqcYB6gYrq3Gc55U5e1iav+rzbv+UkBZ9iNFp6WAozBF1MgQrgrIw9sAy+0/Uzd7DC4mA==
X-Received: by 2002:a05:6512:6d5:b0:512:86fa:a781 with SMTP id u21-20020a05651206d500b0051286faa781mr5126912lff.62.1708108081675;
        Fri, 16 Feb 2024 10:28:01 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id p27-20020a056402501b00b00562d908daf4sm224163eda.84.2024.02.16.10.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:28:01 -0800 (PST)
Message-ID: <6536ebe0-4577-41dd-b3f1-1525b9fe30b7@redhat.com>
Date: Fri, 16 Feb 2024 19:28:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/mmu/r535: uninitialized variable in
 r535_bar_new_()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>
References: <dab21df7-4d90-4479-97d8-97e5d228c714@moroto.mountain>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <dab21df7-4d90-4479-97d8-97e5d228c714@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 19:09, Dan Carpenter wrote:
> If gf100_bar_new_() fails then "bar" is not initialized.
> 
> Fixes: 5bf0257136a2 ("drm/nouveau/mmu/r535: initial support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to drm-misc-fixes, thanks!

> ---
> It looks like this was intended to handle a failure from the "rm" func
> but "rm" can't actually fail so it's easier to write the error handling
> for the code as-is.
> 
>   drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c
> index 4135690326f4..3a30bea30e36 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c
> @@ -168,12 +168,11 @@ r535_bar_new_(const struct nvkm_bar_func *hw, struct nvkm_device *device,
>   	rm->flush = r535_bar_flush;
>   
>   	ret = gf100_bar_new_(rm, device, type, inst, &bar);
> -	*pbar = bar;
>   	if (ret) {
> -		if (!bar)
> -			kfree(rm);
> +		kfree(rm);
>   		return ret;
>   	}
> +	*pbar = bar;
>   
>   	bar->flushBAR2PhysMode = ioremap(device->func->resource_addr(device, 3), PAGE_SIZE);
>   	if (!bar->flushBAR2PhysMode)


