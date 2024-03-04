Return-Path: <linux-kernel+bounces-91182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336E870ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE911F23497
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2672979943;
	Mon,  4 Mar 2024 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TG1GrgKZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9A7869E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580669; cv=none; b=L8x5hNK7gqmeBd/t7Hf8qxsDakeQvZxQb23RudANiWoKT1RGwzRZzGtMlAnr3C3PWi5b2ceHwuZuouGIc+DGzot/ycXujT9xb5a3G4P0+/kt/pLxTHMGDv2EfEiV/2U+5z/A8Gi3DKUjGesGn4hx59zS/gI3CgII+Bz1FFs5oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580669; c=relaxed/simple;
	bh=YqmnToorxdOZkcIzTIgw+FAyk+5fPsdOrBqK+qA/cZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTscOmKH7lc4NTsjfiaOh8FDLIofpnMpRLUObMGVPhUv/D/VSdlagpgqfWtwcy0TrbcjjaHDgdr4bHJ/bUHN1kChjsTpOQeEps5k/19nHPV3sBgfx84X95WfqA24KLIpr8RPeKgBr0j/8jz8+e0jNgBM5rTIugo4cjWDsLFD/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TG1GrgKZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709580666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89WGEOoyMRT4MR7NoSbobr3LI1BSvbvCbPDFIgj4TQo=;
	b=TG1GrgKZlYuoaR98qCD9UYinc1yNc8R1kF+0WH1ZXailp5+vwHI7mSNtYWR0rDcnRGYLcD
	w3pW37P3wNp+uhDlxEU6yHDOGa1btEiwuaJ8/v+RxkZna2PWUu3ApmFCldSj3ZPJ91ursW
	YKNU5DnRF0jX0ixPYmngqeH+8UXL0x0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-zUSs_BLUO52QoNjd2Ol1pw-1; Mon, 04 Mar 2024 14:31:05 -0500
X-MC-Unique: zUSs_BLUO52QoNjd2Ol1pw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-783350c4584so816126685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580665; x=1710185465;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89WGEOoyMRT4MR7NoSbobr3LI1BSvbvCbPDFIgj4TQo=;
        b=OEKAymDoDN5Vu6a1QJj0Zrf3KMmBlIj2uWhKur9zgVaxpSOGjtAkuixrC7vwUJvMcL
         m6JmpU0R129Y7XzeI8i/jt2WXANAXtY2IoI5DAWJn4mx4/VBzg4b+32N88AsAC7oJ0Ee
         IDf6jt1/nv9dg8GFZ7uVwpBryCQJQbVXZxlx9NWylKVLgDAf2F3D4Qtann5U2VH/UURc
         55o326iJT+scoA32ptwLAgkiStDxbdT+7Y69g7ufzhY+iUm40+8Tvl0/IQ7WwHcztH0J
         x3EcULFv9M6sQUvUlA39aWBvyFfAatt/CeKLcpfrMyClRfpDdpJ/DSO4OQV5pGuKaiUU
         CehQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE7F7fjLzYjN0F8pz71GzAvEOoDRkFee2ATdy1p0IAWju3tYtaZY+5O2Kc/efo/SlSTAO4kSgxmtboozJlzZhDISPO9TEGtXjzcAuJ
X-Gm-Message-State: AOJu0YyvEpuSLHYJxUjN++MqFcUz6W5OLxUdCKJ77ns40JtnlXo7DQMv
	sC+6E+T/lLWb+vhuW3fmoliOIxjVKgkGenxIsGQJ0DiY6OjoofPgoiZeehA2QbZEQMQhFgZhRrW
	bKjzGSvOgneIAGjiQD+VNvdii3P4nGLXXqldiaCEt9FQgTDxbbz/fPl+0bbMLZg==
X-Received: by 2002:a05:620a:60e4:b0:788:260f:79e with SMTP id dy36-20020a05620a60e400b00788260f079emr4307577qkb.46.1709580664992;
        Mon, 04 Mar 2024 11:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF5Tl1gweMqc9KYYc21k+yK8+83zyrSM20gKwKNxphb4CWZHLr1Vey/1x03LZhKciw95R+8A==
X-Received: by 2002:a05:620a:60e4:b0:788:260f:79e with SMTP id dy36-20020a05620a60e400b00788260f079emr4307562qkb.46.1709580664688;
        Mon, 04 Mar 2024 11:31:04 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id qs16-20020a05620a395000b007881f9c0397sm2198739qkn.60.2024.03.04.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:31:04 -0800 (PST)
Message-ID: <7aedbb9f48b50b0f823ef7d622161905e41e76ec.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau: move more missing UAPI bits
From: Lyude Paul <lyude@redhat.com>
To: Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org
Date: Mon, 04 Mar 2024 14:31:03 -0500
In-Reply-To: <20240304183157.1587152-2-kherbst@redhat.com>
References: <20240304183157.1587152-1-kherbst@redhat.com>
	 <20240304183157.1587152-2-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Mon, 2024-03-04 at 19:31 +0100, Karol Herbst wrote:
> Those are already de-facto UAPI, so let's just move it into the uapi
> header.
>=20
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_abi16.c | 20 +++++++++++++++-----
>  drivers/gpu/drm/nouveau/nouveau_abi16.h | 12 ------------
>  include/uapi/drm/nouveau_drm.h          | 22 ++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/no=
uveau/nouveau_abi16.c
> index cd14f993bdd1b..92f9127b284ac 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -312,11 +312,21 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
>  	if (device->info.family >=3D NV_DEVICE_INFO_V0_KEPLER) {
>  		if (init->fb_ctxdma_handle =3D=3D ~0) {
>  			switch (init->tt_ctxdma_handle) {
> -			case 0x01: engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_GR    ; break;
> -			case 0x02: engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_MSPDEC; break;
> -			case 0x04: engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_MSPPP ; break;
> -			case 0x08: engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_MSVLD ; break;
> -			case 0x30: engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_CE    ; break;
> +			case NOUVEAU_FIFO_ENGINE_GR:
> +				engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_GR;
> +				break;
> +			case NOUVEAU_FIFO_ENGINE_VP:
> +				engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_MSPDEC;
> +				break;
> +			case NOUVEAU_FIFO_ENGINE_PPP:
> +				engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_MSPPP;
> +				break;
> +			case NOUVEAU_FIFO_ENGINE_BSP:
> +				engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_MSVLD;
> +				break;
> +			case NOUVEAU_FIFO_ENGINE_CE:
> +				engine =3D NV_DEVICE_HOST_RUNLIST_ENGINES_CE;
> +				break;
>  			default:
>  				return nouveau_abi16_put(abi16, -ENOSYS);
>  			}
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.h b/drivers/gpu/drm/no=
uveau/nouveau_abi16.h
> index 11c8c4a80079b..661b901d8ecc9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.h
> @@ -50,18 +50,6 @@ struct drm_nouveau_grobj_alloc {
>  	int      class;
>  };
> =20
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
>  struct drm_nouveau_setparam {
>  	uint64_t param;
>  	uint64_t value;
> diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_dr=
m.h
> index 77d7ff0d5b110..5404d4cfff4c2 100644
> --- a/include/uapi/drm/nouveau_drm.h
> +++ b/include/uapi/drm/nouveau_drm.h
> @@ -73,6 +73,16 @@ struct drm_nouveau_getparam {
>  	__u64 value;
>  };
> =20
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
>  struct drm_nouveau_channel_alloc {
>  	__u32     fb_ctxdma_handle;
>  	__u32     tt_ctxdma_handle;
> @@ -95,6 +105,18 @@ struct drm_nouveau_channel_free {
>  	__s32 channel;
>  };
> =20
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
>  #define NOUVEAU_GEM_DOMAIN_CPU       (1 << 0)
>  #define NOUVEAU_GEM_DOMAIN_VRAM      (1 << 1)
>  #define NOUVEAU_GEM_DOMAIN_GART      (1 << 2)

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


