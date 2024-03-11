Return-Path: <linux-kernel+bounces-98598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C6877C72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6AA2822A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893802BAE4;
	Mon, 11 Mar 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X76AEdLo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F829CEC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148603; cv=none; b=M88LY1SHa4P5R8kRfkSgzbJLX+SZYz3opYsscomJj3I9uMH+YArV5QyoruGiGKJkkDd4dX9tPWMfKz/T0Pk6BJahZm57Ni9suF7bKcirvUaq0LF9TUZY0oHl3Z9yLjSBqydUR2/5LE7brQOQ3LWAGq+0MIVqJ5X/z2j7kTw8I6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148603; c=relaxed/simple;
	bh=YhVl++BZOeI6zwz1aTmXNBeQhgXKmhmPqQVXenLFTfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJwSlD/yXadnyBO58qR1oUygV5709lWp2QYUEsRBc8cJ5oVcIAkeD9E4fHVYKI6ndYM9tIdYiHYE4jSYKNZ/MsCT2pJKaQuJwEIAEq0bQReUECezepJ5UQENhAuMnaJEGj3esMDkdP5qpoYVQYKL/zP+P8lpCpTnyLBYvFxYAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X76AEdLo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710148601;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1Ri9kDddSL5LEfhUJzNl9VSoQTVKWDORtXZoaQ46AI=;
	b=X76AEdLoM30szPK4+QhprtIx5s5NnETK0tUWq5z5Fuqhe6WT8YP7Ub+pKSatKQ/Hw3C+t9
	QJiSKku5xwwr5xgcDxYQh3pM1TPuV8UNp7Lrkqy2vsXOYY/l2JpmIJw4NHMS2ZgB8zQkea
	PeELbLANZxRtH4ZSK2lubsPZCdAEO7g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-_Vuh7k4uPMyi5T2LS-pbCg-1; Mon, 11 Mar 2024 05:16:37 -0400
X-MC-Unique: _Vuh7k4uPMyi5T2LS-pbCg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412eeb789d9so21760975e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148596; x=1710753396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1Ri9kDddSL5LEfhUJzNl9VSoQTVKWDORtXZoaQ46AI=;
        b=VL6VeDkJiwexSBddjFKFXS79YKFy8AyvmxeePt1kJLIxLgMISGkkZbnfQOZqeZW7hH
         7XNhGdMbf+4jbseCdDjKG7pbtMojh8efZ8bJs/LyEplsjSGYKM1EnuJFReyNlkxl/cGd
         Gh2zt61PDdHmF69xw9NJaoldN/LFWxL9dkqGVbC2wSyVigFH6amB/TuUgSXWAZ5Kazg+
         tANHqQiIirKa+pzuMld967VWQVZKdfr2c4LXu7FzcL6x5RwcpNfMSqsYS0v3yzDCIAxw
         HdVdZDsmbLKTyPv3LGy2CtePEueNa0hV9U4+8/GmbmAxyVya1fnNFNeIFHlVn1ZwH1M5
         50Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW+9iiDePd2BNAnb/rvNVayhHsWthlQ7jRwCm7FHYysmcEnsu+JGCU8L/VpVOovQ8O3Ah8fvphvxgQwMgFm+ROlhE2nBDC7nwo+sO2b
X-Gm-Message-State: AOJu0YwvRjCPj+CTohIdTHQ8yVDWS0tmK/KYmmeeVOHnF9Di8sQXG2Ko
	UYzUUkcB5OVK/ylHagg5H7BZZQqsjUKzAZL5g0R3IWkIEecpeUJaA/TNLLEoHkwk6zLe750r1kx
	9THfXYGfAljvc4k1DiNgPqoy69Slp5H7FoPHdpXImLIuUBAdtvQBPWeOai14OSw==
X-Received: by 2002:a05:600c:35c8:b0:413:14da:a9f7 with SMTP id r8-20020a05600c35c800b0041314daa9f7mr4558897wmq.0.1710148596654;
        Mon, 11 Mar 2024 02:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq2xtSDxKyoXCZ4290qqGUfXEXDNrk4RQV0BmYu6hnCQ4RqLN62Fs5tQRIZAVlJsCDhIwRnQ==
X-Received: by 2002:a05:600c:35c8:b0:413:14da:a9f7 with SMTP id r8-20020a05600c35c800b0041314daa9f7mr4558881wmq.0.1710148596305;
        Mon, 11 Mar 2024 02:16:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm14934328wmq.21.2024.03.11.02.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:16:35 -0700 (PDT)
Message-ID: <70d2114b-0b72-4065-b70d-c31cbc70291a@redhat.com>
Date: Mon, 11 Mar 2024 10:16:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 5/7] vfio/platform: Disable virqfds on cleanup
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, clg@redhat.com, reinette.chatre@intel.com,
 linux-kernel@vger.kernel.org, kevin.tian@intel.com, stable@vger.kernel.org
References: <20240308230557.805580-1-alex.williamson@redhat.com>
 <20240308230557.805580-6-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240308230557.805580-6-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 3/9/24 00:05, Alex Williamson wrote:
> irqfds for mask and unmask that are not specifically disabled by the
> user are leaked.  Remove any irqfds during cleanup
>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: a7fa7c77cf15 ("vfio/platform: implement IRQ masking/unmasking via an eventfd")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/vfio/platform/vfio_platform_irq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> index 61a1bfb68ac7..e5dcada9e86c 100644
> --- a/drivers/vfio/platform/vfio_platform_irq.c
> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> @@ -321,8 +321,11 @@ void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
>  {
>  	int i;
>  
> -	for (i = 0; i < vdev->num_irqs; i++)
> +	for (i = 0; i < vdev->num_irqs; i++) {
> +		vfio_virqfd_disable(&vdev->irqs[i].mask);
> +		vfio_virqfd_disable(&vdev->irqs[i].unmask);
>  		vfio_set_trigger(vdev, i, -1, NULL);
> +	}
>  
>  	vdev->num_irqs = 0;
>  	kfree(vdev->irqs);


