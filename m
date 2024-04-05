Return-Path: <linux-kernel+bounces-133349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF989A2A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334571F24680
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7C416F275;
	Fri,  5 Apr 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKNsYItO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924A16C871
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335084; cv=none; b=Uo402jcOkoDSoXEbqIgGFwhq9xToyejMXXL0fng1Sh4KmWjts4IaJQbKTND8wbuMH2+k2oEAuaoJ7jCzs+DNvoahaa22584Dw0K9OZ6FbcKRYx+WZfCgxh1S9iEpXee35Bft3YElND60VhyiMT30lb3SDrrlAqF7rKN34Yw3qOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335084; c=relaxed/simple;
	bh=BLotXCHXqHDC9O4AKiHbeR7Z5NsPPN4ypYaPcCf605E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLtspvtKDlIpTWFQLhqTU19yvF1ir4NTXdLvKMIXsrBgGJMAamv02WxfKvru6Zm9OGhzXCLhgic2n+iFoKR177nJRA8Lq7uNygMv2BHxeMh2LBgFTpUGGffaEwcQUg2PWKsJ+MxIUFnCiN5COoIXcpA9vBnyaYyBz35qTcpI/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKNsYItO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712335082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkF4QSWzhf6Nw/44NW74bQyP4bUB/6PnvqawpC9bEv4=;
	b=NKNsYItOuCy+lMvw2UcnqA5wEEMp0zo/QT4Llw7N5Rx8d8t5wODaoAaCZf3C/wmxFhDF+V
	AofiYIkPITIaePY18DdQef4AGy5aDC+dV/g902gVN4qMsS3U5JmHJDYwnA5yqng8xyf6WE
	B55HhmKqOapOZmO8bt6vpM/4tl0tPPU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-Xi5Z8WvAOJCcRqPvtyuK8Q-1; Fri, 05 Apr 2024 12:38:00 -0400
X-MC-Unique: Xi5Z8WvAOJCcRqPvtyuK8Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343d6732721so664902f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 09:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335079; x=1712939879;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkF4QSWzhf6Nw/44NW74bQyP4bUB/6PnvqawpC9bEv4=;
        b=uNbCVSk2DBytkuZAodM5hjEYLtc7sTq825ORqKbVuUV4bIs3oZDG6cuPHFlgubyqhN
         O2GJuGTgdEgeHlxe1BKB4UqGFF26fVA2YCW6vulLhT7CuQf9gmcrGVJPgrXaNxEjvbIp
         wHYHO6q2xKcoSmcZDiccJdrew+MlJaQqfZyAq8Zji2o7nwMeiO2f06ZZM5oaRZoA7kpn
         qZXbPu2FGsNW62ZfvaR8yrDXcmb5SW6LI7NoQ6rZhlhxENqsEgb7R8n7F+ju2qvslWsa
         sretJwAt836URE++cYKEPuuf8V8HyHpq4zpifNAeoPV34aHfO8DrpWt+NvHBHyTzC/e8
         bDeg==
X-Forwarded-Encrypted: i=1; AJvYcCV/qtFQ8Nz2XYb8s1mGrYE8W0y/Tn6NdmcMeGyGSD2NAW0HFcsl+B6EeFB/Q6fYB8uNOKl2BHP9s6uJEP7OXO5+WjGOK9HRgMIiP98H
X-Gm-Message-State: AOJu0YzQI0Tl7mwEuPsX9Fu/itcEeOPRzPrADRvUAjf7e9aQ9tU+TOiA
	wKBQbaFuw5yyYz4JZbFbCLaYZcux6dK0p7jUMjKQfKiuYBUZNUsY92Akfh/04IL26tJqXWxvcqS
	CZX9RX1Smt+HF8NEZIp4xSZQ9TIE2neIRr5J1ktX93EorDUt26RlNYBxuGJruBg==
X-Received: by 2002:adf:e849:0:b0:343:e031:69b8 with SMTP id d9-20020adfe849000000b00343e03169b8mr1687198wrn.41.1712335079586;
        Fri, 05 Apr 2024 09:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ46bQriV6ycJFTO0VuNynMncgm9/Re4exnqTKKZrOf8MmqZKAujsFuh4iSK3zn2MXU1fy4Q==
X-Received: by 2002:adf:e849:0:b0:343:e031:69b8 with SMTP id d9-20020adfe849000000b00343e03169b8mr1687176wrn.41.1712335079306;
        Fri, 05 Apr 2024 09:37:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id q8-20020adfea08000000b00341c6440c36sm2409149wrm.74.2024.04.05.09.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 09:37:58 -0700 (PDT)
Message-ID: <cefb67c2-f5f5-4b54-8ed6-a9cab3718ff5@redhat.com>
Date: Fri, 5 Apr 2024 18:37:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] nouveau: fix function cast warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>
References: <20240404160234.2923554-1-arnd@kernel.org>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240404160234.2923554-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 18:02, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Calling a function through an incompatible pointer type causes breaks
> kcfi, so clang warns about the assignment:
> 
> drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c:73:10: error: cast from 'void (*)(const void *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>     73 |         .fini = (void(*)(void *))kfree,
> 
> Avoid this with a trivial wrapper.
> 
> Fixes: c39f472e9f14 ("drm/nouveau: remove symlinks, move core/ to nvkm/ (no code changes)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to drm-misc-fixes, thanks!

> ---
> v2: avoid 'return kfree()' expression returning a void
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
> index 4bf486b57101..cb05f7f48a98 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
> @@ -66,11 +66,16 @@ of_init(struct nvkm_bios *bios, const char *name)
>   	return ERR_PTR(-EINVAL);
>   }
>   
> +static void of_fini(void *p)
> +{
> +	kfree(p);
> +}
> +
>   const struct nvbios_source
>   nvbios_of = {
>   	.name = "OpenFirmware",
>   	.init = of_init,
> -	.fini = (void(*)(void *))kfree,
> +	.fini = of_fini,
>   	.read = of_read,
>   	.size = of_size,
>   	.rw = false,


