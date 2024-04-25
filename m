Return-Path: <linux-kernel+bounces-159204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EDE8B2AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DFE1F21981
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81B5155729;
	Thu, 25 Apr 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YVZ0RW8b"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EB1553B9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080270; cv=none; b=ClYG0IpaVzXP7XSQhl6JLTKW/aAFDvz6IK9/8yHOISkKyq58daVEWHRIlwRjS9unR9AEJV7jfygvBBCNNRrxaiu7FoC8yYues7nhRZCquvehBKXukSh+NPWy7donI/4KWyeWfRB851eQ1EyITrZJIj8PEx4AafEBZ62yE4A+JVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080270; c=relaxed/simple;
	bh=7hgElzkGGU4LOW+W09DF7A1KIdz9b4uk5d/lmNS5l4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJ4YjMTHM+PHb8ubXvASz6wZFrbmL6/eHuTufJ4jd8PSsknRlYdcKuCtNLje/GBbANPF0x758+33pPmnTsp59Gfa8qHvR/FhwS/qMDQ/59qhY9WzawV8xYxD2q4lWErKaf6IXLFqep57xUD3BSNSXo2TNJ4f5qP1ANc/TqLtd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YVZ0RW8b; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso1356268b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714080267; x=1714685067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ra+gBoWOeuJuI+Ezc3sgY9mFyzgfI39aGWs6cfLFtkw=;
        b=YVZ0RW8b2YU0w5ikFhI1oKRO3CtsVJwztxuMBahCWDlEkk6G/7C11aeFzT41+UfbGO
         2uwbJ+4PQUCXyHzAkJSuciA8R6d7Yp/QaolOsZgKPZwNicVY/YaRMOnvR91q8P+Slw4H
         WQsZluYKYrl9m2Uj2PVX24FnSGaIUn9pp+2L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080267; x=1714685067;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ra+gBoWOeuJuI+Ezc3sgY9mFyzgfI39aGWs6cfLFtkw=;
        b=dnuNrCjND/XYhPRfi/jul/OBIYEu1Kg5+DFE7ocsy9AQ41PaZgFtmppwUx5Mew5Szx
         PuPWTS/xqnUQ+yDKWY5pgG7SG8He2XOCmYhVcdGLfkzLMq+ghvK4iq/hVBManahyJHIW
         1mDqn2nSvBLlGDVv5Bp6nRTce2N1k95Bk6P+s8N7eX64Am9XvRDQ0Yynbz7xBjtMdTFp
         HNLPJpI1SOxc+eznAyABXw/2Ef0XbPmbeFvwojaEdbgQog4syClaVjZB0oS7xPVP2wSd
         AfQxMQgvWbO6esjIxu+Jsm1NgpkIbGWhdNRSN12ya7XinakA/raxrLazdAfiEHW69eJE
         YDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWDIiaK5oeTO/WVQrDZyEP8RqVrIpl94Jy0S87FOErMzf/oli0C0NSwtxbTf6qJh6MplK4zHpZAooIe6N9KsacM5ZfsrWp9xKaPJMg
X-Gm-Message-State: AOJu0YwpjRtyKmPgHghzCNsxUJMEoj1eVfNJKXTrCScFViz8CBYZmkjg
	M9rA15JYnaUUHSYALu3opJJz5UqeLPy9KnhFrBMjTm+ScLjv81xQ86QCP/N7BA==
X-Google-Smtp-Source: AGHT+IFjRI1KL92CI5//kxL5g2K5AdC261aXqb0p/mvglOwYKbX0B59aSLlt6Vxzy9YL74iEhxcDrw==
X-Received: by 2002:a05:6a20:d41f:b0:1aa:9c29:b98d with SMTP id il31-20020a056a20d41f00b001aa9c29b98dmr968628pzb.24.1714080267556;
        Thu, 25 Apr 2024 14:24:27 -0700 (PDT)
Received: from [10.211.41.59] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001e2b8c91f04sm14230143plg.22.2024.04.25.14.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 14:24:27 -0700 (PDT)
Message-ID: <e2569ac9-85ba-46b2-a285-161ddf3b3cd3@broadcom.com>
Date: Thu, 25 Apr 2024 14:24:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Fix invalid reads in fence signaled events
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com,
 martin.krastev@broadcom.com, zdi-disclosures@trendmicro.com,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240425192748.1761522-1-zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20240425192748.1761522-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/24 12:27, Zack Rusin wrote:
> Correctly set the length of the drm_event to the size of the structure
> that's actually used.
> 
> The length of the drm_event was set to the parent structure instead of
> to the drm_vmw_event_fence which is supposed to be read. drm_read
> uses the length parameter to copy the event to the user space thus
> resuling in oob reads.
> 
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 8b7de6aa8468 ("vmwgfx: Rework fence event action")
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23566
> Cc: David Airlie <airlied@gmail.com>
> CC: Daniel Vetter <daniel@ffwll.ch>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v3.4+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> index 2a0cda324703..5efc6a766f64 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -991,7 +991,7 @@ static int vmw_event_fence_action_create(struct drm_file *file_priv,
>  	}
>  
>  	event->event.base.type = DRM_VMW_EVENT_FENCE_SIGNALED;
> -	event->event.base.length = sizeof(*event);
> +	event->event.base.length = sizeof(event->event);
>  	event->event.user_data = user_data;
>  
>  	ret = drm_event_reserve_init(dev, file_priv, &event->base, &event->event.base);

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

Thanks,

Maaz Mombasawala <maaz.mombasawala@broadcom.com>

