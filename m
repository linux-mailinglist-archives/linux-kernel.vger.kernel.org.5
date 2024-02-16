Return-Path: <linux-kernel+bounces-69150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2643085851C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20BCB22FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39291350F4;
	Fri, 16 Feb 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjfbCtA9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931113174B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108061; cv=none; b=WDXJAtWjnJKH5mFcbXaWmhYx1xDV9W1kwxt0JvPCKFZz2JECff9FGOVRYFC3jYuaKNCESaI5y4VoiuaD13aBH7nTaedpckUufmE3PrxRpcjwFid9pnee9GNh5KLzwAfqrFFTD0s24jQsqfAho6xnhBOeweJJTBVHq+Bf3hAU2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108061; c=relaxed/simple;
	bh=UnShZ8EdBWD5I7RRNruBpEbtffINfrd97Kk9hac9+lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+PPvTBxbaN1Wa8QvDx+BKVDYeF1fbsP8QDkB2lKfFTLRUTxpzOyOUhh4KhRwGeIqranS60coDt/OclRfygLy4Tqyi3PbCpACpd4rZI7V++x7WNw5CJuYte5awbTwwq7s8f7W+AFzt2D7tkIPhd2o0VSF29QPkJ6+5mgo8ZBxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjfbCtA9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708108055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pAxnKiY0v6Unt1MeteP4zhCiQHYAe7S4qrGIbBvNAI=;
	b=GjfbCtA9flktVchGPdcx621/wFUrJgrVIpkMD1GAuGJ46Y8H4IbJV2uUja6OxBifaEJZgT
	aXiGvkObZFD+OH2T0ZsvQ8se0HxT7ZgW14zsBEy0hGnigjuSKbcumFP2NNL/8RBt+qcA7D
	Pz7aSdfffXqUykA57zmYJP7j9zCACRc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-LYwSfQq_NNu3PJieQw9TOA-1; Fri, 16 Feb 2024 13:27:33 -0500
X-MC-Unique: LYwSfQq_NNu3PJieQw9TOA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2c4e9cb449so173543366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108052; x=1708712852;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pAxnKiY0v6Unt1MeteP4zhCiQHYAe7S4qrGIbBvNAI=;
        b=r7dKSwgjzvme3W3rf4F8LrVRav4zpWgu6v3Ryv3uYxe8AM1Bj1IAMBwaVCIrWLa0+S
         0DC5wEIULCPCLwD5upNjeOUzZTWfzERBwe1iP+8Pu8UZpK+8w6irjWe6GjMN7w4EpgO4
         0lzL6CS13RgVsQ20tHeoEDWb8BBax1UzTXdeJpH4LpjZfHQ/QbLTM+RnlC1YfkFzbmVI
         6GrL8lhyqJMXfOxRdMC8Wo5IrqkOTuGHo5s0srQNAyFfdbyVk2U+wCBFF2Zm074y9Hwu
         sK9vWWjkSo2lLMmBBqS73QXNE7vIsM1Tdprs9f8TTXVzPOOgESwdXy2nS6IPCqPXTUVi
         KukQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi/kZhCCB1mUJ+ixPynoQ83t7/nsKOFHBPzT0+IzPPsj50wGreHBYXunp9Lhe1pAJlPUfMTiEOZcJCbTCcts2rBi7zwKCrF3j7L5Va
X-Gm-Message-State: AOJu0YxYaoLWtIsmi+DpGo2v1fmtXBFy2m5JcBCEgZPaBtDEg6/g5w1Q
	eB1QMGtzsPeJ/98vrg3R6Ab0Xjxd4ke39PUnlBK7vtGQiclo0UuexCRmQi1YLmt1YYC5KZMd1VH
	NX3Wm9NU7aEgh7IF1onDutaxcEiLGHOafsyctXkkqBnA2cf+gdus7J64vUg/rKA==
X-Received: by 2002:aa7:de0e:0:b0:564:7b9:8c18 with SMTP id h14-20020aa7de0e000000b0056407b98c18mr1164588edv.22.1708108052534;
        Fri, 16 Feb 2024 10:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc7HnCrb8Q59cHQe9Z/g3oIfkHjAxB+9md3uAcAJ23mrUVRozwXdVXewL5xF6l4JirE/riHw==
X-Received: by 2002:aa7:de0e:0:b0:564:7b9:8c18 with SMTP id h14-20020aa7de0e000000b0056407b98c18mr1164581edv.22.1708108052264;
        Fri, 16 Feb 2024 10:27:32 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id p27-20020a056402501b00b00562d908daf4sm224163eda.84.2024.02.16.10.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:27:31 -0800 (PST)
Message-ID: <9d9fcdeb-4d0c-4371-b871-ad1fb8055033@redhat.com>
Date: Fri, 16 Feb 2024 19:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nouveau: fix function cast warnings
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240213095753.455062-1-arnd@kernel.org>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240213095753.455062-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 10:57, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-16 warns about casting between incompatible function types:
> 
> drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c:161:10: error: cast from 'void (*)(const struct firmware *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>    161 |         .fini = (void(*)(void *))release_firmware,
> 
> This one was done to use the generic shadow_fw_release() function as a
> callback for struct nvbios_source. Change it to use the same prototype
> as the other five instances, with a trivial helper function that actually
> calls release_firmware.
> 
> Fixes: 70c0f263cc2e ("drm/nouveau/bios: pull in basic vbios subdev, more to come later")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to drm-misc-fixes, thanks!

> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> index 19188683c8fc..8c2bf1c16f2a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
> @@ -154,11 +154,17 @@ shadow_fw_init(struct nvkm_bios *bios, const char *name)
>   	return (void *)fw;
>   }
>   
> +static void
> +shadow_fw_release(void *fw)
> +{
> +	release_firmware(fw);
> +}
> +
>   static const struct nvbios_source
>   shadow_fw = {
>   	.name = "firmware",
>   	.init = shadow_fw_init,
> -	.fini = (void(*)(void *))release_firmware,
> +	.fini = shadow_fw_release,
>   	.read = shadow_fw_read,
>   	.rw = false,
>   };


