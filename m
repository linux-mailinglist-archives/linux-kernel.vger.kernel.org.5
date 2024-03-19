Return-Path: <linux-kernel+bounces-107261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B8387FA18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565591F22043
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA365190;
	Tue, 19 Mar 2024 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frfHXyCe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCC4594C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837884; cv=none; b=ksbMNClUfFduTZDm3dudAHN5IqkT1rZFUl/nmRMwemld9Mao8/4vl8VjiKQMiOq1FNhhfEhlzuzDl+vQCUiGlGxYR//prHK39TD8I09ELwI1uQjMNFT+mo34s62x29a+UJlW6KpQFNDvjgBQoYDkN1DbRfXE8o+ooX+zwTlL9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837884; c=relaxed/simple;
	bh=nI/rmMU9ID2DyMEA8YV+gCy4224Njr13NhON4ykD1XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSHnEYRj/aLHOmUZeB6qu8T9rI0FKUtPPaLojEk6FvO8EwT3MjKA/m2Otr4w/Ky8eyGG/3kiG73uBlFCXOTU7UUGmwNl3wF/Tl+ztbc1zrNlwNDhjfIK2yvwhHDnvuIdhd2FLigfTBGk8Z4iXhr/yZDe0uGM6a0FHkM6SMHQmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frfHXyCe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710837881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BMs4HF35a4VHWnMU3zgf6OkWkxPavqIDWhwgjjpgcYE=;
	b=frfHXyCejUXUFJGe6E1OphmzUdHQo/N3ypEvgk0Li25U98LhwmzdHsryO9KfPcBxKESA2D
	Td94jZiOGqMikACZfA2AHYX1lLOrz8Iwt6L37db4g83G8olN3+v7jhzMBS/BcUiLR/813+
	5ftOVavvniAsXelaUdtziDz6pG1GMSQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-LdEJgn8hNRqYb-EwagyjkQ-1; Tue, 19 Mar 2024 04:44:39 -0400
X-MC-Unique: LdEJgn8hNRqYb-EwagyjkQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4140408c7faso20336055e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710837878; x=1711442678;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMs4HF35a4VHWnMU3zgf6OkWkxPavqIDWhwgjjpgcYE=;
        b=RaY/83qHTFZrYKgtYTBw7kcKDkKTsJJZu1NIy3vKtXPZYI0Ih4Dip8ZpWMorTcGUDI
         uJ3v/+hqEXVP9E+M2RzpiDNoTg2H6nvLp+Yx8ZSKJ+ZDyQXGhE8k7ooWzDAMQ/3MEnwt
         44Ine2K8OXNnCI1uMQgQ/eak0KVTwQqyvfiM6ODciowA2hJf/4B+ldC7LQRbonn9Y+Ob
         BzFzvpNf2Mk0wRab03g9GU7OLvUiBifN3nWGQSao+U804VYm/eeBbDNRyeutIe70FHd/
         jjpDz68NZrDxtVBhj8Gnsx3bemleSlEbYvXwRR7iYuVc1yIU7Akq4k+PwMI/ZSHZba+k
         QLjw==
X-Forwarded-Encrypted: i=1; AJvYcCXzeeTMNxT3HpRbRj75aYe3XrmFh0jF8/ojlj7rqVM+1Z6Fd0jPshrA57K6e7KdKJ+heB+aCwZnBIYw+l7UGEeQuvlPg7mzZwMqcWBS
X-Gm-Message-State: AOJu0YyAXXUdlZEOPAoQvGR8B6xRdM243MxFdfmbcKzUYcAgNX/P6kwT
	xx/etLDfeSmytxcTjIN6gETJMpCh1yRBgfFvMN07kLA3+uzFB+blRB6nTKdlHQeSMqGfMI7KPAd
	snGmPffIZgRj/zO7RS16f/jR/vTEZHC74+pJfRYjXowQ+LvMnhfCkb5VMcJua1w==
X-Received: by 2002:a05:600c:458e:b0:412:dca9:aa83 with SMTP id r14-20020a05600c458e00b00412dca9aa83mr11200879wmo.21.1710837878007;
        Tue, 19 Mar 2024 01:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY8J1D4gPAkMDbpFJ8n3/pZS4T2O/lddQ41o4k92hqpqMiGYTWgOqdWPwnjj4DBmjx1XEuMQ==
X-Received: by 2002:a05:600c:458e:b0:412:dca9:aa83 with SMTP id r14-20020a05600c458e00b00412dca9aa83mr11200869wmo.21.1710837877606;
        Tue, 19 Mar 2024 01:44:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:2200:2adc:9a8d:ae91:2e9f? (p200300cbc74122002adc9a8dae912e9f.dip0.t-ipconnect.de. [2003:cb:c741:2200:2adc:9a8d:ae91:2e9f])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d6e02000000b0033e91e53e8fsm11896940wrz.24.2024.03.19.01.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 01:44:37 -0700 (PDT)
Message-ID: <46bb6670-1a61-45e6-af2b-a04b93fa1bbb@redhat.com>
Date: Tue, 19 Mar 2024 09:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio_balloon: Give the balloon its own wakeup
 source
To: David Stevens <stevensd@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20240318091034.535573-1-stevensd@google.com>
 <20240318091034.535573-2-stevensd@google.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240318091034.535573-2-stevensd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.24 10:10, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Wakeup sources don't support nesting multiple events, so sharing a
> single object between multiple drivers can result in one driver
> overriding the wakeup event processing period specified by another
> driver. Have the virtio balloon driver use the wakeup source of the
> device it is bound to rather than the wakeup source of the parent
> device, to avoid conflicts with the transport layer.
> 
> Note that although the virtio balloon's virtio_device itself isn't what
> actually wakes up the device, it is responsible for processing wakeup
> events. In the same way that EPOLLWAKEUP uses a dedicated wakeup_source
> to prevent suspend when userspace is processing wakeup events, a
> dedicated wakeup_source is necessary when processing wakeup events in a
> higher layer in the kernel.
> 
> Fixes: b12fbc3f787e ("virtio_balloon: stay awake while adjusting balloon")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/virtio/virtio_balloon.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1f5b3dd31fcf..7fe7ef5f1c77 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -450,7 +450,7 @@ static void start_update_balloon_size(struct virtio_balloon *vb)
>   	vb->adjustment_signal_pending = true;
>   	if (!vb->adjustment_in_progress) {
>   		vb->adjustment_in_progress = true;
> -		pm_stay_awake(vb->vdev->dev.parent);
> +		pm_stay_awake(&vb->vdev->dev);
>   	}
>   	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
>   
> @@ -462,7 +462,7 @@ static void end_update_balloon_size(struct virtio_balloon *vb)
>   	spin_lock_irq(&vb->adjustment_lock);
>   	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
>   		vb->adjustment_in_progress = false;
> -		pm_relax(vb->vdev->dev.parent);
> +		pm_relax(&vb->vdev->dev);
>   	}
>   	spin_unlock_irq(&vb->adjustment_lock);
>   }
> @@ -1028,6 +1028,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>   	}
>   
>   	spin_lock_init(&vb->adjustment_lock);

Can we add a comment here why we have to do that?

> +	device_set_wakeup_capable(&vb->vdev->dev, true);
>   
>   	virtio_device_ready(vdev);
>   

Absolutely not an expert on the details, but I assume this is fine.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


