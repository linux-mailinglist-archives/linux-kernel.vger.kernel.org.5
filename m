Return-Path: <linux-kernel+bounces-144815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB98A4B14
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E811F22815
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7734AECE;
	Mon, 15 Apr 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+Jwz14X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9E45944
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171818; cv=none; b=ZEiuEL1o/fdlsSwiCSSGcrpSjMiu18uSzRxNcjia8hW21xpNNFO1z3RbObNpWlr8FDKKUVdPUDxijgh3GotuR/rMGtsqHmRydacwG5DZMVm7yVrJC2KFYN0Fsozwd3QtLQSPH857oo6UmVDobIP7Q872hVj0cPhZam7LYSraPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171818; c=relaxed/simple;
	bh=IdA7HDUJdk3wBbS7HCQh1S2W+nwF7tdQmhHF55XBlCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtBThgwkmyE305QdaSMkvENQ5SP/OXO7SipIoWArVe+KVE5F9Up8kjohwKHdS8Pqf4o52NIgNM+yFmfaWAJu3M4Hkgg9+/zsvRGvtfL76DGCJT60Gwawqk5bPoHKjl9uQBoEa1ftrUXDZSVEmZkglAQ5w3MuWl0oWfct3JlzUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+Jwz14X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713171812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYKa4KTPniO6R7CGdMFUdNW1Z1y9QZTKRFmp+ZRDLRU=;
	b=W+Jwz14XJGDiLRbFeCnRK+eGC1OYW33R9FZF+03eay7wiFZZOQNpeRYkcHJ8HunR9maoG4
	3O2m7A0CsYpN5vzMOj8qwQBKQDqdnASwnKIu3Io4xyxx2zbTRtmri3mO18A5ftkimqbMJs
	FdbmY7ytDNwvQAu0NNZ4HIoq5o0z1PQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-MNvlK1_xNIK1EHHcyiEuJg-1; Mon, 15 Apr 2024 05:03:28 -0400
X-MC-Unique: MNvlK1_xNIK1EHHcyiEuJg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343e46df264so1642993f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713171808; x=1713776608;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYKa4KTPniO6R7CGdMFUdNW1Z1y9QZTKRFmp+ZRDLRU=;
        b=e7/7LPrFBTd0Jfj00tXGqy5qFdCqf2DAnzDWLmDvPtM0900NkDsjIc9sUkUgrqFjur
         WL00pcNNquP8OKEHChDCYhnIYSsYO1giYp4sxVmNr0LGch7Nd2wfd3UQIaKxwGtLL6DD
         JlLrWq+cpMrXinb4R47a6LNA3z86m9aAjVzrzs4leHUOVt29lXMb2MBR1AFnuhCCjX/F
         qiXMFkTWUKAUf8vStb5e3B5HA2ViTNSuhXqKPUhnlayc5nC9PjCsg1ARuShpby1HKJY2
         as3T7usGKvS7x47naq26WBayKgeNBdCu9aHuOP+xy+zY5brGslMvdSPZbKkl3PJAGeUE
         Z7jA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Ci9mS91iRd+RG+nRN1XuTWHHwYVN+9eXRU3nSB80C1pwkQQdA+tVGdGGOvis5OURkh5caLX+WiTkiaj+Fj6ePlbXELPWgH8iqxBD
X-Gm-Message-State: AOJu0Yz+SXOs0WUZ0dUxQsQZBufKI9yVDpr6S1kSWx+N3rsZeVk6C1Jb
	gkMscS7oOQ3ad4vZp3LBQiHgsgN/jzWKKPQ9KM1IW9/vTZL/Jd82CKDp4dEVO8Tpv/LB+vLtY72
	qv6RlYWQAeeovvK5gMASnuKnFM1lNKoPNyh3D5ELn+VjKGDS3FpXM6Jgulb0EBg==
X-Received: by 2002:adf:e591:0:b0:341:e358:7bee with SMTP id l17-20020adfe591000000b00341e3587beemr6359824wrm.39.1713171807858;
        Mon, 15 Apr 2024 02:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpwdZY2D2UwysYuZQw3OrScHwpqCJhWnmaPIklA/3flPX0PP7YVvECg4t0EjHiFSoANE2vtw==
X-Received: by 2002:adf:e591:0:b0:341:e358:7bee with SMTP id l17-20020adfe591000000b00341e3587beemr6359799wrm.39.1713171807476;
        Mon, 15 Apr 2024 02:03:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id u7-20020adfeb47000000b0033ec9ddc638sm11497808wrn.31.2024.04.15.02.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 02:03:26 -0700 (PDT)
Message-ID: <ad01f30e-4944-44f6-9efa-8e04726d1486@redhat.com>
Date: Mon, 15 Apr 2024 11:03:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: nv04: Fix out of bounds access
To: Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 Francisco Jerez <currojerez@riseup.net>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, Karol Herbst <kherbst@redhat.com>
References: <20240411110854.16701-1-m.kobuk@ispras.ru>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240411110854.16701-1-m.kobuk@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 13:08, Mikhail Kobuk wrote:
> When Output Resource (dcb->or) value is assigned in
> fabricate_dcb_output(), there may be out of bounds access to
> dac_users array in case dcb->or is zero because ffs(dcb->or) is
> used as index there.
> The 'or' argument of fabricate_dcb_output() must be interpreted as a
> number of bit to set, not value.
> 
> Utilize macros from 'enum nouveau_or' in calls instead of hardcoding.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2e5702aff395 ("drm/nouveau: fabricate DCB encoder table for iMac G4")
> Fixes: 670820c0e6a9 ("drm/nouveau: Workaround incorrect DCB entry on a GeForce3 Ti 200.")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>

Applied to drm-misc-fixes, thanks!

> ---
> Changes in v2:
> - Instead of checking ffs(dcb->or), adjust function calls to match
>    argument semantics
> - Link to v1: https://lore.kernel.org/all/20240331064552.6112-1-m.kobuk@ispras.ru/
> 
>   drivers/gpu/drm/nouveau/nouveau_bios.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
> index 479effcf607e..79cfab53f80e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include "nouveau_drv.h"
> +#include "nouveau_bios.h"
>   #include "nouveau_reg.h"
>   #include "dispnv04/hw.h"
>   #include "nouveau_encoder.h"
> @@ -1677,7 +1678,7 @@ apply_dcb_encoder_quirks(struct drm_device *dev, int idx, u32 *conn, u32 *conf)
>   	 */
>   	if (nv_match_device(dev, 0x0201, 0x1462, 0x8851)) {
>   		if (*conn == 0xf2005014 && *conf == 0xffffffff) {
> -			fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 1, 1, 1);
> +			fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 1, 1, DCB_OUTPUT_B);
>   			return false;
>   		}
>   	}
> @@ -1763,26 +1764,26 @@ fabricate_dcb_encoder_table(struct drm_device *dev, struct nvbios *bios)
>   #ifdef __powerpc__
>   	/* Apple iMac G4 NV17 */
>   	if (of_machine_is_compatible("PowerMac4,5")) {
> -		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, 1);
> -		fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG, 1, all_heads, 2);
> +		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, DCB_OUTPUT_B);
> +		fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG, 1, all_heads, DCB_OUTPUT_C);
>   		return;
>   	}
>   #endif
>   
>   	/* Make up some sane defaults */
>   	fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG,
> -			     bios->legacy.i2c_indices.crt, 1, 1);
> +			     bios->legacy.i2c_indices.crt, 1, DCB_OUTPUT_B);
>   
>   	if (nv04_tv_identify(dev, bios->legacy.i2c_indices.tv) >= 0)
>   		fabricate_dcb_output(dcb, DCB_OUTPUT_TV,
>   				     bios->legacy.i2c_indices.tv,
> -				     all_heads, 0);
> +				     all_heads, DCB_OUTPUT_A);
>   
>   	else if (bios->tmds.output0_script_ptr ||
>   		 bios->tmds.output1_script_ptr)
>   		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS,
>   				     bios->legacy.i2c_indices.panel,
> -				     all_heads, 1);
> +				     all_heads, DCB_OUTPUT_B);
>   }
>   
>   static int


