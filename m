Return-Path: <linux-kernel+bounces-120675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF288DB54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C70B24867
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E95273FB;
	Wed, 27 Mar 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqoqEM5p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216734EB49
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535799; cv=none; b=IO4+y6fFSVrLCTWzyHU48haVU9KFWkjkSy2QAMr3tCVVOJm5AVvEL5fFu1i5f0C01yfE8BeL0R7af+fb2WD+T9dPDOCSygkYnh2eK3mbzK4OC9gZsPK2WzBPCeIfd1M5ikBvZWa2xocN4B2J9btTP2Glkqf6RibabPlx3V19qHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535799; c=relaxed/simple;
	bh=XEp433VhhnNwlu79bpyjOldg952MtmkR6qNohpSTB9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6k/1gjDXurrFytGpvpVFUEr1FvGzdUEp7cH3IXfD1SrPV2z3qDMHQsPh3+hHw5b2SYDHfc9cP0a+mRWMUVkBOQ9WvndrhOe3+UmaIICwO43YLdW3jcyIEWA0FVn7+K7iIF9hLRb5LjVpRH+XzyTWiFNJRL7kRwl/XvNj9Vc/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqoqEM5p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711535797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGUgmAiaU2v/ONksowbWzodJ2NKOgb64oDRR6Sk5hgk=;
	b=dqoqEM5pRc8Gt4JCMhqoabpPIuErv64J//bAGQYdkcR755u89orgr0EVEyWjnpcwGUdTfy
	dgep3OEWghgBQY6jKw++C411fnLuTk2mxEh7xUrtYrlb2trxZI238GBpM0o8iv9HVgTYEj
	wghrZt20blUlqvN2vZ6j9CIszYDuo0w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-JtL8dl3XMzOsivkYvjfM8Q-1; Wed, 27 Mar 2024 06:36:35 -0400
X-MC-Unique: JtL8dl3XMzOsivkYvjfM8Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-568a9f3ba97so4036705a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535794; x=1712140594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGUgmAiaU2v/ONksowbWzodJ2NKOgb64oDRR6Sk5hgk=;
        b=gyI+ZiCjspSOl13PSxJEdTcNHXU4CVPOUpy2/ChvSe0/J8HTCU1P2hTN4upfg3EK+U
         B6T9w37lqiQTv6iuvPFw8A0oj5HgF7HP/GMZpIjFZTe7NJmOC4QC9myl22uONF89w/e5
         NUz9hwTaEWGvoH+Dlj57EEDKVrc4uliP7ltMmiZQvy1O4nYcpRvTnJIL8ZGe27pmSlCV
         ivp9cgY0lGbkrv3dIlleOMSI3F3OPTVN35xadp1RHI/YoYYUErTMwRaNxlVtw+/GPmDz
         7xiP6wwk3ac+4LVfAi0c7DfSj5CM2ULMAmVtP9ZrsrFJVGDuDiDlrZe1L0ImTNu5cy+c
         i9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXBxZWVY4N7bl130ZIv5tyiEzHRZh6k81HdBDW7eQhc06ag76uByjSK47vyRWt66fHgy2mw2AB1UC7+OayIoB07e7zmYxQQQDrx7pUd
X-Gm-Message-State: AOJu0YwW5nmqCj0W59vfynSVaE9RjuSGcpK1ZhlErlrxi1kDfSV1kwHQ
	Jv9DEpkAc/19P3eBbwChn3fAufgpCH1ziHFRAOITKqZ8idl4az5s5BtVwcXCXGOZNbPcTcKqTNi
	iyaWzp0RDo+zTavg+YLccavsga3zPouKagDb+rXy5Iq4EtwOmXSJnx7ZCkcdLDw==
X-Received: by 2002:a17:906:1358:b0:a47:535e:1dc2 with SMTP id x24-20020a170906135800b00a47535e1dc2mr1619545ejb.40.1711535794156;
        Wed, 27 Mar 2024 03:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH7ngVeH0pniStwJCtY+MKwAFE9hhBWQYw+PianGTWnmh3mdumzCWEDjJ1RgHYJ9n1CTm6RA==
X-Received: by 2002:a17:906:1358:b0:a47:535e:1dc2 with SMTP id x24-20020a170906135800b00a47535e1dc2mr1619395ejb.40.1711535788605;
        Wed, 27 Mar 2024 03:36:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ch12-20020a170906c2cc00b00a44180ab871sm5258891ejb.50.2024.03.27.03.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:36:28 -0700 (PDT)
Message-ID: <c217d7e6-5f20-4362-b59c-adb64bd54dab@redhat.com>
Date: Wed, 27 Mar 2024 11:36:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] power: supply: core: ease special formatting
 implementations
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-2-8ebb0a7c2409@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-2-8ebb0a7c2409@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/3/24 4:31 PM, Thomas Weißschuh wrote:
> By moving the conditional into the default-branch of the switch new
> additions to the switch won't have to bypass the conditional.
> 
> This makes it easier to implement those special cases like the upcoming
> change to the formatting of "charge_behaviour".
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/lkml/53082075-852f-4698-b354-ed30e7fd2683@redhat.com/
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/power/supply/power_supply_sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 977611e16373..10fec411794b 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -298,11 +298,6 @@ static ssize_t power_supply_show_property(struct device *dev,
>  		}
>  	}
>  
> -	if (ps_attr->text_values_len > 0 &&
> -	    value.intval < ps_attr->text_values_len && value.intval >= 0) {
> -		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> -	}
> -
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_USB_TYPE:
>  		ret = power_supply_show_usb_type(dev, psy->desc,
> @@ -312,7 +307,12 @@ static ssize_t power_supply_show_property(struct device *dev,
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
>  		break;
>  	default:
> -		ret = sysfs_emit(buf, "%d\n", value.intval);
> +		if (ps_attr->text_values_len > 0 &&
> +				value.intval < ps_attr->text_values_len && value.intval >= 0) {
> +			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> +		} else {
> +			ret = sysfs_emit(buf, "%d\n", value.intval);
> +		}
>  	}
>  
>  	return ret;
> 


