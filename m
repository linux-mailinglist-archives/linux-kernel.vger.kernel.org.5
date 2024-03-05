Return-Path: <linux-kernel+bounces-92021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6B8719E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3771F210E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00C535B9;
	Tue,  5 Mar 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF6c874q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B85339E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632057; cv=none; b=QHMr2YzFt3vkgpk1zEBbypas7UGFXImZ2kplMpwcIaB+acqVXEbDjmA0l7sBo3BjTAApMFy/UOkZDO6jvKqbzI82G2jgEdNnWlyomwscF6nw0wC0zbuq5YEZVhhW8o6ZJKuMmWIVeNNq7cZUasdWG7OORwxzHG/46ok7dHSCJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632057; c=relaxed/simple;
	bh=FEn6/6EKZGsnNA0+B7tmFuE7HeJTxYX3bJK2YrmrITM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWtOwcKZMQzcEVvFJB79HIA1d/5qv72BrIgn4ZmH6VQ94Y35kRWjtonrk9u/lJ22MLrYacFXLAOALsK8yXxqW7kiTl+Ip90v8mVBx5KKlVInpXEB+Os5zrpMzyemVZ67xPOs5NR2QmxdzO9MEgbukGq0mqcF3iqtjYHK/qxQcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EF6c874q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709632054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbI5i4Q4tsI2CMeqv6RPoW9fsJnk/FBruMClWqYDOF0=;
	b=EF6c874q0mn3wGALKxq+MebDwpOPZonbXVY/ijeMdObAiab6tfneICTy27ouTnVzfUQHpS
	RuLMeGNjgUuq54thXxq0wg5SIssROqWt5qfsH85v6X9b/EuQ1oX1TYRZskmJmOMluH8CXX
	ojTKIxhgxgpA+FidU2zmlnBHDmsid90=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-o7QQIbSlOdiaSD1KoZnP1Q-1; Tue, 05 Mar 2024 04:47:33 -0500
X-MC-Unique: o7QQIbSlOdiaSD1KoZnP1Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78819cae842so394846985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632052; x=1710236852;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbI5i4Q4tsI2CMeqv6RPoW9fsJnk/FBruMClWqYDOF0=;
        b=EMcL9jAzDmvwNVUsi+zQaamMAp4j8nqNCRlQtnTFVwlsU3qD2bIGclXeejRex0XHQn
         3itzOHkNB4aQ72XD/Yr5FCPXaulq+rR2P0W1NYpNLa79mLxIFactJgax2wl90tWV24B2
         1ol2rjOA/uWqRfNqIIyXLg8E2eN8f9vBTkIEIEbmrVuKirYy1clPHbFZOrQOQ3d25gAk
         J8lQcG2C6stjlWxttSvatlz69/wWIGNUlJFarMgAvcM1EvxT+Bh2zT9HUfiX6GjUGpJ7
         J0BsGsE1OC8pVyXJxnR2bBSq4eZD26QhrpHCb6F6C/fRvsWjhbKHP2pc6vs5B2o7hyAs
         xyVw==
X-Forwarded-Encrypted: i=1; AJvYcCUzmgrlY4OHCZESQduRDouOzR+iWOi7Tcmn/DZF+1bAIis3Xgk1vVQKbRsnoUazrtQwvYOsAmduY2IMprPJCLNqLHlR+mnSCyua+SSR
X-Gm-Message-State: AOJu0Ywll92U+PsOu8QKXF4EFjHTfAK76qWdtid0KmpvvLCLsqr4WIMP
	R/7JzLFj0HawPl4l7wZU374rJcxbReG9Blwg83NFkC8ruUm/z1/KqaLy++mVJ8gQKt9wh8ngS2Z
	Wdn08Ei3xWZAskqxrwDj873im1cLokPwQo9+k7aHx5nQDSkdrJasZzCH2GzrsmWGOy8o4MA==
X-Received: by 2002:a05:620a:1242:b0:787:d904:c4a0 with SMTP id a2-20020a05620a124200b00787d904c4a0mr1202516qkl.22.1709630353359;
        Tue, 05 Mar 2024 01:19:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR/eLfKqYtzfYee7+jBwIfv5EmSixRoxgVGr/h1uW7ijmEXZ0/siIVOehOVecT/HyGvhvi8w==
X-Received: by 2002:a05:620a:1242:b0:787:d904:c4a0 with SMTP id a2-20020a05620a124200b00787d904c4a0mr1202512qkl.22.1709630353047;
        Tue, 05 Mar 2024 01:19:13 -0800 (PST)
Received: from [10.32.64.131] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05620a458900b0078812f8a042sm3635157qkb.90.2024.03.05.01.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 01:19:12 -0800 (PST)
Message-ID: <123c38bd-5b68-4f28-a218-b96fbb41f15d@redhat.com>
Date: Tue, 5 Mar 2024 10:19:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/nouveau: move more missing UAPI bits
Content-Language: en-US
To: Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
References: <20240304183157.1587152-1-kherbst@redhat.com>
 <20240304183157.1587152-2-kherbst@redhat.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240304183157.1587152-2-kherbst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 19:31, Karol Herbst wrote:
> Those are already de-facto UAPI, so let's just move it into the uapi
> header.
> 
> Signed-off-by: Karol Herbst <kherbst@redhat.com>

Reviewed-by: Danilo Krummrich <dakr@redhat.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_abi16.c | 20 +++++++++++++++-----
>   drivers/gpu/drm/nouveau/nouveau_abi16.h | 12 ------------
>   include/uapi/drm/nouveau_drm.h          | 22 ++++++++++++++++++++++
>   3 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index cd14f993bdd1b..92f9127b284ac 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -312,11 +312,21 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
>   	if (device->info.family >= NV_DEVICE_INFO_V0_KEPLER) {
>   		if (init->fb_ctxdma_handle == ~0) {
>   			switch (init->tt_ctxdma_handle) {
> -			case 0x01: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_GR    ; break;
> -			case 0x02: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSPDEC; break;
> -			case 0x04: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSPPP ; break;
> -			case 0x08: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSVLD ; break;
> -			case 0x30: engine = NV_DEVICE_HOST_RUNLIST_ENGINES_CE    ; break;
> +			case NOUVEAU_FIFO_ENGINE_GR:
> +				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_GR;
> +				break;
> +			case NOUVEAU_FIFO_ENGINE_VP:
> +				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSPDEC;
> +				break;
> +			case NOUVEAU_FIFO_ENGINE_PPP:
> +				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSPPP;
> +				break;
> +			case NOUVEAU_FIFO_ENGINE_BSP:
> +				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_MSVLD;
> +				break;
> +			case NOUVEAU_FIFO_ENGINE_CE:
> +				engine = NV_DEVICE_HOST_RUNLIST_ENGINES_CE;
> +				break;
>   			default:
>   				return nouveau_abi16_put(abi16, -ENOSYS);
>   			}
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.h b/drivers/gpu/drm/nouveau/nouveau_abi16.h
> index 11c8c4a80079b..661b901d8ecc9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.h
> @@ -50,18 +50,6 @@ struct drm_nouveau_grobj_alloc {
>   	int      class;
>   };
>   
> -struct drm_nouveau_notifierobj_alloc {
> -	uint32_t channel;
> -	uint32_t handle;
> -	uint32_t size;
> -	uint32_t offset;
> -};
> -
> -struct drm_nouveau_gpuobj_free {
> -	int      channel;
> -	uint32_t handle;
> -};
> -
>   struct drm_nouveau_setparam {
>   	uint64_t param;
>   	uint64_t value;
> diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
> index 77d7ff0d5b110..5404d4cfff4c2 100644
> --- a/include/uapi/drm/nouveau_drm.h
> +++ b/include/uapi/drm/nouveau_drm.h
> @@ -73,6 +73,16 @@ struct drm_nouveau_getparam {
>   	__u64 value;
>   };
>   
> +/*
> + * Those are used to support selecting the main engine used on Kepler.
> + * This goes into drm_nouveau_channel_alloc::tt_ctxdma_handle
> + */
> +#define NOUVEAU_FIFO_ENGINE_GR  0x01
> +#define NOUVEAU_FIFO_ENGINE_VP  0x02
> +#define NOUVEAU_FIFO_ENGINE_PPP 0x04
> +#define NOUVEAU_FIFO_ENGINE_BSP 0x08
> +#define NOUVEAU_FIFO_ENGINE_CE  0x30
> +
>   struct drm_nouveau_channel_alloc {
>   	__u32     fb_ctxdma_handle;
>   	__u32     tt_ctxdma_handle;
> @@ -95,6 +105,18 @@ struct drm_nouveau_channel_free {
>   	__s32 channel;
>   };
>   
> +struct drm_nouveau_notifierobj_alloc {
> +	__u32 channel;
> +	__u32 handle;
> +	__u32 size;
> +	__u32 offset;
> +};
> +
> +struct drm_nouveau_gpuobj_free {
> +	__s32 channel;
> +	__u32 handle;
> +};
> +
>   #define NOUVEAU_GEM_DOMAIN_CPU       (1 << 0)
>   #define NOUVEAU_GEM_DOMAIN_VRAM      (1 << 1)
>   #define NOUVEAU_GEM_DOMAIN_GART      (1 << 2)


