Return-Path: <linux-kernel+bounces-146410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D828A64E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8184C1C21EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CF285261;
	Tue, 16 Apr 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjH1JMtw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66584FDC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251923; cv=none; b=HvV3X9sXB3uU7QWDQikAzhDL0VgHlV9hz6jR6oGhwqGm8G4dErMS/Y0Fi+koWXdWu9f/HnXBeUGYOrRSagPqQeIoonXPEG9Zs3Ph6XurWVNo0ox9JmF8+6PS7AHfe9y5SkHTABKhcJWIW4eD3wljIr+a3bkWyRtahSKf5XI1XKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251923; c=relaxed/simple;
	bh=c2VNVZ/A5X2R+H+oCvqQh6zaNGq/uswdETuAN0FXRVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUtHJT3/b7QWE0/OcVtLMqAnKqtRJsD9IdtoViMC3FPuCOB4ykxP7QEgaII7+hWTBvpo5pqJ9Hcc7YDN5NmvhCXaUQe4ofOSP5ecr1LSvffAMQCj+JhRjtau5qKDC+V1lUceH5haNcQ+fH7qwV0rx2KdtcgJKj78vqPSluGI9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjH1JMtw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713251920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPqFKR4ZvSJ+ALuuDWeJf0ty5XmJIME7qjvn7nFQuAk=;
	b=cjH1JMtwVyCN/sU6+rfMMWfu1IV7KVKE1NyGzGkaYAy2qTCOzcNPfypQ0yyktsAn0C5+kh
	9e4vzJha1Q7KEss9DhB3Hp16Z1f+f7ENMf4FTgWxaOCZ/LxPeoSC4jjTtW3JE9mo58GHr5
	/7zQ0pLKrvk5DC7JxjhbYYF3O5jEE28=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-W2gjaNEpOzKaD8w8FIwJog-1; Tue, 16 Apr 2024 03:18:38 -0400
X-MC-Unique: W2gjaNEpOzKaD8w8FIwJog-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a4a1065dc4so4217018a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713251918; x=1713856718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPqFKR4ZvSJ+ALuuDWeJf0ty5XmJIME7qjvn7nFQuAk=;
        b=afkz/CpWjaC8nX+ivhloAywJ7xL5AzeR+xe2wP8BQtxcM2TpjWssnCmfhfn59gLh8I
         BZcifTpztmmA2DOcS5VW3qffvDPlJMrP6Qkc3GSOD7W48mD1UDliNQusUsJfIN++iDPD
         uwdpBYdRvqcsLh/ZXvSGkww3xZHqR3lNgukOKfyHeWdSCyi+cNBQAAEPQW9o99tLbnUc
         G7QxiYUplg8V1YnLVYXqW8tedzXysYtwFXZOL5WJr/yyJmftw4Y8rolc5F6o+1sllKwW
         YUdCf2+uMwQghm5EnFYlhN8vURtYZmUeyTH40oSg0HqY5b32qGwYGibB/k2BzaiFXkV9
         4aQg==
X-Forwarded-Encrypted: i=1; AJvYcCXKd+usoaX4sbtPaQ2WRWO7M97B8qdKBtLNcrTapUvhdXRVN4gZn6KuylvoS455+Vsi5z2zh9e+UUgzYT7mieIqghKxHj9FmM9No7vZ
X-Gm-Message-State: AOJu0Ywtrq/rTOwQ2SdJ8OqXJgvSMPxFdFQz63j0zIPLlMIwxRVxd4iR
	M6wEu52qZJGcGEpEvd/gy+3HK2E8WziA5l+jWdBY31TJt7S15iBSY+o1SBpE7UkyezZTkTtJ26G
	g/Z4dRnA0tahEvOZlArwMljQH+s2dYfTrHvi0S+eHMrt9AvTgnRGsyq8Xm0isJOLY39lPZguIQF
	BIZ7ZS8gE6Gfv8VsVfugq1p2ZvmiJf6YsCFdy0
X-Received: by 2002:a17:90a:aa84:b0:2aa:48a6:5af6 with SMTP id l4-20020a17090aaa8400b002aa48a65af6mr3034296pjq.25.1713251917997;
        Tue, 16 Apr 2024 00:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTBpPPEeZEtMVW6wTs8kFPTMIszvWmpt5+nPNaz19aVia6JZInPGp1ra4TB49WmaBj16uKrKdtkh0pJin6o1M=
X-Received: by 2002:a17:90a:aa84:b0:2aa:48a6:5af6 with SMTP id
 l4-20020a17090aaa8400b002aa48a65af6mr3034289pjq.25.1713251917692; Tue, 16 Apr
 2024 00:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163707.517820-1-kovalev@altlinux.org>
In-Reply-To: <20240415163707.517820-1-kovalev@altlinux.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 15:18:26 +0800
Message-ID: <CACGkMEuvLmomcK7L7wQ-mGxAxof52xBAu8G4sB83gw4MkqeFHg@mail.gmail.com>
Subject: Re: [PATCH] vDPA: fix incorrect VDPA_ATTR_MAX value
To: kovalev@altlinux.org
Cc: mst@redhat.com, parav@nvidia.com, edumazet@google.com, elic@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:39=E2=80=AFAM <kovalev@altlinux.org> wrote:
>
> From: Vasiliy Kovalev <kovalev@altlinux.org>
>
> The VDPA_ATTR_MAX value should correspond to the index of the last
> available member of the structure, not their total number.

I think it's too late to change. More below.

>
> Otherwise, it can lead to interpretation errors in other functions
> when the structure (.maxattr =3D VDPA_ATTR_MAX) member is actually
> incremented by one and refers to invalid data.
>
> Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink in=
terface")
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  include/uapi/linux/vdpa.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 43c51698195ceb..ab132a09565232 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -74,7 +74,8 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_BLK_CFG_FLUSH,            /* u8 */
>
>         /* new attributes must be added above here */
> -       VDPA_ATTR_MAX,
> +       __VDPA_ATTR_MAX,
> +       VDPA_ATTR_MAX   =3D __VDPA_ATTR_MAX - 1,

Having a MAX in uapi is problematic as it may confuse the userspace. I
think the correct way is to drop it from uAPI.

Thanks

>  };
>
>  #endif
> --
> 2.33.8
>
>


