Return-Path: <linux-kernel+bounces-116923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288788A529
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8236F2E7A10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E7C1BAA4C;
	Mon, 25 Mar 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6ljovrx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27EB1BAA4B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365200; cv=none; b=cfRNpC8+M4mdW5mQSYglHA96it9i4mQlpvg8nH9x3Jm5em5BmmJjFhWY2h9cukuS9xIPgyH9Dww1fycA6vjm7E2j7CNO45OZPHnbGW6Q0COR8wvh6zeD1jxswGpUKIuUvoe1/FxJfLnu/K4WqluPi/v+gEL+4cUxX9pDnPMkD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365200; c=relaxed/simple;
	bh=Hsa/4RMLo7slhwDozooCgxr8Rhe6jK9MdW6Cr2Tbkbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gAlLWBlw90hVyTvZnUVqDRoBG72jBnqIUntrUKxCC+I4oWcro+xO8TSN7rY2VkGGQJCqSbuv3J2EAFNAw8nVeSU7DiEdhCMj4iVq3fo1e/qfPSyIKrwjtm5FRX2I08Mcf02TZqoRMzSF98oXBWGtACOnYweLnMAUMLBIEpljaXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6ljovrx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711365195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAPHGbxlJ6k982EnibWHBxa9+vZqkzt4vbnevEyQxDY=;
	b=i6ljovrxAAxtvJII+5FvBck2e+Y+YtGgrYqG7qg0wLeKvICjtKddxa94WSc045W+j5P67U
	0GSPJYHBf1FupyAeHXOrIVlDAGU2R3BAjBQroPUBnv8F6uE+j1qu/D7GyecBcb/Ry2G38+
	tGjgXqYK2YW2BQBhQ3E7rxvsTuk/veY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-ZTyh1gzYMUSxzMHOKwnvLw-1; Mon, 25 Mar 2024 07:13:14 -0400
X-MC-Unique: ZTyh1gzYMUSxzMHOKwnvLw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56c0d3517deso652296a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365193; x=1711969993;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAPHGbxlJ6k982EnibWHBxa9+vZqkzt4vbnevEyQxDY=;
        b=Q+Kpl418cQPdEi6XCJ4yRKy7YQvulo5IJW7WE+rGZEVvjzHk/WaDMacWNM3k5MHuyq
         d7HjVqPBlQWwRWAcOi4B4XBqqRaqePboWPUUf+ubm4yST0Dp0WZBmUPvxrOWImfg/QI/
         4geRpX+FNP7zSWEfL2UJ+lWus1B7zfD7mKuByfUnPQYfnWL/qAahMxGbFbtKCTEld8vt
         svDBq+l02Iqjk5aSOWIAYoNPa2jo68L71RJ2UNwq9jXlWD3qL1KHhXoxqCn/g7jR8Eej
         Abu8Hthl+0GdKitT9yC1xvIRGwk6s8zj5Fqtkw7kQHFu3e1zpoSM2lOiMRPidgPwbg1v
         44og==
X-Forwarded-Encrypted: i=1; AJvYcCWNl/5tYXUZ6cRrbDIWliTAvvhE2YsHVdsQS7huxvF5LDwBWzMoClIYWmFylEfA5Xn7s83Ef9k/5CPhYz03YBKWvu3W/o5BBGHO8xLJ
X-Gm-Message-State: AOJu0YzVaP3DlGXftORc9IzENZ8QyjLQ5nw/H41siBZWLHgIoeU7gW6P
	QHgVA2zA2DiwRDKq2Qee7UuBkr5Ls2yN9fJybnVtDfA6zfmdYyMQct1R+3SA7aR3fpDGv8Gg7W1
	4HMTa7ZMAW1fxSYsHx9QFnn6/f1SA9oMN6u7PlZ9F6/Z+F1C3UlNw77O1sUanVA==
X-Received: by 2002:a50:8753:0:b0:568:aced:e5a0 with SMTP id 19-20020a508753000000b00568acede5a0mr5705680edv.14.1711365193413;
        Mon, 25 Mar 2024 04:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDFlIpB/lK3v3cbB5QOQ7Bbg8iNxhFwokSKMspks8TaBGXgxvtbwZi1GudHYxQskJStFdo7A==
X-Received: by 2002:a50:8753:0:b0:568:aced:e5a0 with SMTP id 19-20020a508753000000b00568acede5a0mr5705672edv.14.1711365193137;
        Mon, 25 Mar 2024 04:13:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fi24-20020a056402551800b0056bfa6ad5eesm2530825edb.91.2024.03.25.04.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 04:13:12 -0700 (PDT)
Message-ID: <f677cad0-4387-4a79-b7bb-f7b0676e5418@redhat.com>
Date: Mon, 25 Mar 2024 12:13:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] platform: intel_ips: Use PCI_IRQ_INTX
Content-Language: en-US, nl
To: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 ntb@lists.linux.dev, Lee Jones <lee@kernel.org>,
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-8-dlemoal@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240325070944.3600338-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/25/24 8:09 AM, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Thanks, patch looks good to me, feel free to merge
this through whatever tree is convenient (or let me
know if you want me to pick up just this one patch
from the series).

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/platform/x86/intel_ips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index ba38649cc142..73ec4460a151 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1505,7 +1505,7 @@ static int ips_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	 * IRQ handler for ME interaction
>  	 * Note: don't use MSI here as the PCH has bugs.
>  	 */
> -	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
> +	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
>  	if (ret < 0)
>  		return ret;
>  


