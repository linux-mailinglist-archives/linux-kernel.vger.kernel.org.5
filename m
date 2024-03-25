Return-Path: <linux-kernel+bounces-117276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8288B366
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114AFC464F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13A153BE5;
	Mon, 25 Mar 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCEucwcI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B613AD0E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377739; cv=none; b=k8LStQUaKN9KRjXuZMm7HiqzpFHDxf2EQbKvjrY1T5nNu1dZPleU1L9mSlzhklNFwnex9rAGxh1q0xJfZGkhdpth7MOcX1qD/87yTfxzXDeLlyxWMSjYh6dyHmI6i4b7hM7U5LZpiC43szh90WvWmeWuRgo7tACehN1YkS+nrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377739; c=relaxed/simple;
	bh=H6GWCzUr4bu05tZUPxWIonNRb0KF+giuYdstauoVwsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UaLE8QkT12faqeaHzvBh/42YC1JE4neeaZ7arckHEANpa2Uf7hwaV4waarH/yfZbC+Wemzn26pwtGPdEAYqcrnnRKsCSktNML2T1DLryTRYgfBy+mLVo5TeEYeS6uPeNpwRSgGNo4gz/OdgQy0EgYsLN7kCuIP97ZAGk0cxRIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCEucwcI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711377736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLrR2JlfX0S1p3aWe4A7fE+XaM/6X9zPvy49Bs4Sz1M=;
	b=cCEucwcIcX6/3xivHR456S6RdDBNNvK0edlMonIw7kuuZsVxgd9pwX3flbmuw7yeMXvDbB
	Bj4z+n25Z8fNOL8iVumcacb/dcRW4lEKF09GDFhMINP2SEHURfqCVOKW5OkQ9QCxy6OK1G
	7hwYfwPcSVqZfrcST+jT3hrZ7ZNbqZw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-CYqdIhpHMbOAyS7VJyLIGg-1; Mon, 25 Mar 2024 10:42:14 -0400
X-MC-Unique: CYqdIhpHMbOAyS7VJyLIGg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-568a9f3ba97so2583360a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377733; x=1711982533;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLrR2JlfX0S1p3aWe4A7fE+XaM/6X9zPvy49Bs4Sz1M=;
        b=qCb2gjXcvZm7Xu+WUUjfWpRci8Kqia4wLNjdpm0C7wZlipWFMMRAyZOFbhXVHbeAfm
         1czSICWA2wbg7QvYleIwPqnmLn3gZBrteRs8UOgC03iz5fccrLzbezu0tUeoKlvyRofi
         Jg1nagbXKUjk5YM3CQ33hou3x+L1fsq0mchTOstqwmV7XQDZutUeT8Fn9BDJGxJ0zTSO
         MeDD0qpZlNCOr6gUCv+V7Y9/CeIkCakYYHNHU9XHc64wOyvjBJynn5yZLUQ7RC1czuv0
         nCl37ezaHgjg+K/EXi9DHQ2OfXCwkrnlygGwi1SPBPFiYso18iUql0tVnBPagJZ+z+ar
         TPew==
X-Forwarded-Encrypted: i=1; AJvYcCWOFyU+gAlvVsTdLPA3KpASHsNxToD6k/YfQMzj8gAYD06uoGaKA9BEhK9E/HWPcfUHVlo5buQOIVoPErSrYwGG4o1GIpM2urEIICm4
X-Gm-Message-State: AOJu0Yy0D3eaEjQIQsoEkWKmVgsAzCYhDCODnwKhKj8XKSh9Js3/xB7S
	WMexw7LMBf9xBaHFToyHVbCYvMRwTYnQC7vPQ6eTJoRxbAl8MI1OtwcQha4/yacSBG7MjTP2bKT
	Dc639yf9N/xEkgtosuv8MDy8ugMHwZaJU64fMAIlTVGF6QtPmz7GYcsTLGigdfQ==
X-Received: by 2002:a50:aac9:0:b0:56b:dd0e:9efc with SMTP id r9-20020a50aac9000000b0056bdd0e9efcmr4998305edc.38.1711377733505;
        Mon, 25 Mar 2024 07:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRLQNhiRa8ppxcfMI72+lnofbjam8B8WE2Ycdl8Cxt1uXmB5QRGI2z4FzNFqxon5LflPMetg==
X-Received: by 2002:a50:aac9:0:b0:56b:dd0e:9efc with SMTP id r9-20020a50aac9000000b0056bdd0e9efcmr4998287edc.38.1711377733144;
        Mon, 25 Mar 2024 07:42:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g7-20020a056402320700b0056c0996bf72sm1794239eda.83.2024.03.25.07.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:42:12 -0700 (PDT)
Message-ID: <7307a54e-b18c-497c-90d2-9c272f6e634e@redhat.com>
Date: Mon, 25 Mar 2024 15:42:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86: hp-wmi: use sysfs_emit() instead of
 sprintf()
Content-Language: en-US, nl
To: Ai Chao <aichao@kylinos.cn>, ilpo.jarvinen@linux.intel.com,
 u.kleine-koenig@pengutronix.de, mario.limonciello@amd.com, jes965@nyu.edu,
 alexbelm48@gmail.com, onenowy@gmail.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314063703.315841-1-aichao@kylinos.cn>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240314063703.315841-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/14/24 7:37 AM, Ai Chao wrote:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/hp/hp-wmi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 630519c08617..5fa553023842 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -681,7 +681,7 @@ static ssize_t display_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (value < 0)
>  		return value;
> -	return sprintf(buf, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>  }
>  
>  static ssize_t hddtemp_show(struct device *dev, struct device_attribute *attr,
> @@ -691,7 +691,7 @@ static ssize_t hddtemp_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (value < 0)
>  		return value;
> -	return sprintf(buf, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>  }
>  
>  static ssize_t als_show(struct device *dev, struct device_attribute *attr,
> @@ -701,7 +701,7 @@ static ssize_t als_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (value < 0)
>  		return value;
> -	return sprintf(buf, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>  }
>  
>  static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
> @@ -711,7 +711,7 @@ static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (value < 0)
>  		return value;
> -	return sprintf(buf, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>  }
>  
>  static ssize_t tablet_show(struct device *dev, struct device_attribute *attr,
> @@ -721,7 +721,7 @@ static ssize_t tablet_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (value < 0)
>  		return value;
> -	return sprintf(buf, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>  }
>  
>  static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
> @@ -732,7 +732,7 @@ static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (value < 0)
>  		return value;
> -	return sprintf(buf, "0x%x\n", value);
> +	return sysfs_emit(buf, "0x%x\n", value);
>  }
>  
>  static ssize_t als_store(struct device *dev, struct device_attribute *attr,


