Return-Path: <linux-kernel+bounces-123334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050008906B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B30293D34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087BF13A25D;
	Thu, 28 Mar 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gS/Z+Ycy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393F139D09
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645268; cv=none; b=U7Stxw6+WW/mq2OjHFvzSUrUWf5ylZe5QuCDLkuaVpa3tb/tOhSuzD8zWpgxLaeFwe4bMeSwItTtuzXsNAxYo8HypqDAhjvqZShjxt6fDkYtE9nUhQ4RDwi3rL/tqFpzoVKfG8PV35Zsk380RfSjgHSHAciwMzlx7zXBXzbkSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645268; c=relaxed/simple;
	bh=hjX99r91SWP3e4RGhPGLXBRAcAG9BmjA0B6NhCnUjG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhStst7NGSBnGhV5+vbn8xxnlLbpEe3WR05i+AgvcC464CGtMPBljTBrIxzs0UKhZN4SRNOsRMQZyfDYKAosDO5W3ojQChLlrL2BYnDvQPDJFU0pPPVuTvp3ABOgTe7cvqWXaQ15gJiC9Z7IQEG4SLg/FADrYp7cMuHqJWbIJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gS/Z+Ycy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qd6vtGEjaeTzV1f2AcS0milHcb/EgWIylwqRgm6gjBE=;
	b=gS/Z+Ycy8EMbSpA8FhN21JvW3Mfbkc+CW7qvDcrg3pGS2Y/JfJHT8k57zsPTMww/t57ABw
	GZt+lsDdaVu+spSSr4Snrjxo1n/vTbYgjCYx2e1x3fh64VKbTJVrwu9EbzUt7FOPaZaVBe
	bcFgsv90jt7MXS8MxaeLsgzmrI77JPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-7eerDfoqM5CBPLLPqa-S7Q-1; Thu, 28 Mar 2024 13:00:58 -0400
X-MC-Unique: 7eerDfoqM5CBPLLPqa-S7Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41543b58075so4689715e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645257; x=1712250057;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd6vtGEjaeTzV1f2AcS0milHcb/EgWIylwqRgm6gjBE=;
        b=XDQXQSB5b8/1N+7XkJ0UVfdKqSDCSxvKpxvGp0vApKoOkpD3+IO76FwyH0HbUhyKy8
         cqU3L/V6FjicGXWgQMN0CoD8VEae7Ox9YOA0Y29K3YZjgPmXn6tba66UICS4MzJEHYw+
         PcmLIq6E/9l2PRv4XPqYgmucdzJcaxDUX+AUtGG5dTGvXfXlBRJ2PCKme2Dm19eKyG4O
         riXXbkWboUFRoR6cudZzo/ocBuOFMtbBm6g80t/fSJiF/56rrxvnCZY2wxH5k5AhYYf6
         n/liEqP8fM4dYLU7GWs/ySXyLRPNZrmd5ARs8MFuIB0qep+Y1MAQgAZxPPcEJNNcnRi+
         Vc2A==
X-Forwarded-Encrypted: i=1; AJvYcCWrAR1NGM2DVcBT1TSoI3sVyF7f+rv9Ecy9A7EgE61C5dgxKnQK+/9HCHTkriR1cX0HU/wIbXpoz1rHtt7jii0NVQy03ZtRPhoWU0mX
X-Gm-Message-State: AOJu0YwAoKILJYZEyRoL4s/OCYY6Hx12o0p/JQud6CI60VDAoghSU2FQ
	vQeVhaXcj0j9egxGP7EJcmhsJYygi+g6ceQTognL6Sj2p5k0Ik6p6r1mELbjwQYDdFOs4aFtNR0
	0c0vr9JmtkmiTrUqSL/9BgO/BRbsGogp3UO1hQaI7f5JvcF8tQfOawtIZTf7cVw==
X-Received: by 2002:a05:600c:1546:b0:414:c5:8503 with SMTP id f6-20020a05600c154600b0041400c58503mr2315130wmg.38.1711645257219;
        Thu, 28 Mar 2024 10:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMU1YeDRsoWUWg166ruOHtocc/arSMbGoFCV9vPwHpC+elMIiA2PAku43lcB8JHeDBeeyjlg==
X-Received: by 2002:a05:600c:1546:b0:414:c5:8503 with SMTP id f6-20020a05600c154600b0041400c58503mr2315108wmg.38.1711645256913;
        Thu, 28 Mar 2024 10:00:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b004148c3685ffsm2893798wmq.3.2024.03.28.10.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:00:56 -0700 (PDT)
Message-ID: <a3eda30d-920b-4913-a207-a475d490115b@redhat.com>
Date: Thu, 28 Mar 2024 18:00:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau/gr/gf100: Remove second semicolon
To: Colin Ian King <colin.i.king@gmail.com>, Karol Herbst
 <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240315090930.2429958-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240315090930.2429958-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/15/24 10:09, Colin Ian King wrote:
> There is a statement with two semicolons. Remove the second one, it
> is redundant.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thanks!

> ---
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> index 986e8d547c94..060c74a80eb1 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> @@ -420,7 +420,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_chan *fifoch,
>   			return ret;
>   	} else {
>   		ret = nvkm_memory_map(gr->attrib_cb, 0, chan->vmm, chan->attrib_cb,
> -				      &args, sizeof(args));;
> +				      &args, sizeof(args));
>   		if (ret)
>   			return ret;
>   	}


