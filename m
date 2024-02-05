Return-Path: <linux-kernel+bounces-52363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EDE849722
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E791286946
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3350F12E6F;
	Mon,  5 Feb 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu9RAwbF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C87134A9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127136; cv=none; b=Xr9ea7jQ3QoNRP6yk6XNY5OW86ACdL7PiFDOvfjgVxZtPxEnJnFXeri27GORmeJhVJX2UD3lqKYy/0mY41lNhmwUZmvRTOEdQw+z+7jWYGV0pxGnDvdNUfbWfqdHM6vUdtL1fnReebyM0uhSew+VID/CGlSyGpHFZpa4iKMgWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127136; c=relaxed/simple;
	bh=mb1/KcgecyNLcCeUcncjkR6BU0A4oba2K9W561gf2x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyBhSw/rMXgsS5oFqEH35MkQM3gXI/L/WVwurGck/Md+/JwP7J6TbPad6BxddXlf/XLA1ikZ25wNpvILz8c2Gw3KH4js/TJC8h9ISvC6C146qo+8CcSZabWpu5vZLYgJjUgBmcMJGs+Ye6xuM2EbnRTlyR9/4GKwkVd2aJjO8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tu9RAwbF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707127133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kjvfci9ng+Lg5/KtBL6NJAaxrnR1eQ8Ii0bZQgClIa8=;
	b=Tu9RAwbFBiERxi18ZVg+bStZWrwaDjkw6fruJyYJ3uSdtvCNlk4EWMzkiDJxfokGBO9+oB
	+yv9CQ2893KEJj3SAYmuXygMpZh+OD9vHsJBdHOhUfnv51+7unIRdbmAaUiPHCF3G4k4dI
	6eNNaohWt42viYL671dDNYJFlUbJmEY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-51QE5ow6NOuMRB9g2JizYA-1; Mon, 05 Feb 2024 04:58:52 -0500
X-MC-Unique: 51QE5ow6NOuMRB9g2JizYA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a34a22e09ccso173756866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127131; x=1707731931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjvfci9ng+Lg5/KtBL6NJAaxrnR1eQ8Ii0bZQgClIa8=;
        b=i4iTda0tDfd/ddrjKEMX6Q1QhKPLS/evSo/Usw1A+zESiG7vJAPk9scb/mhGIiwema
         GifO6C957ehZK3soTqKGTO79d/eouO4InX38euxUlLp9wMf9fotK3D1+3+k9E9zzfVaJ
         lbUI/FClnz3umK0VhsLzwI19waicBE58u7Z9lJ1JglAoav8GvObHccWgh39ZKniftJNA
         n46qLaJFUMLx6owM8QqEpzGOH+zwUyS4ICNVllba6C7AIxvLDeGKa2g7uHpuQqTr26G7
         3xg8QZpjV1C4m5mYeqos86SLZYUVTprqFocYFoVIUl/0xBgAQQpCIgqd0xWQ8GPciY17
         RUpg==
X-Gm-Message-State: AOJu0YysOplHFOoGvSvwgPNz9ghWlyWVJ76vMHCNyXLuYSPXrP3p3DD5
	aZ6gk0WwVq7L9fxiaGExP/13lXDl3i8bRcikhT9ZwDQCpY98cdPGORUreEtflbxnVLGPw33UaRb
	iKpcGbA5PKx/8q7Sy1usA/VJ8zi//rD9HIe7GB7u91CaMBNKhJ7PX64rtUiYV3A==
X-Received: by 2002:a17:907:7ea4:b0:a37:3922:8838 with SMTP id qb36-20020a1709077ea400b00a3739228838mr5562130ejc.70.1707127130884;
        Mon, 05 Feb 2024 01:58:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhrgzDj9wcLEvr6QvzHjHtsXi5ONowJ3C3vvpDSjPlWyjXq0CqHugKN2OKf64ERJaKxqN3Wg==
X-Received: by 2002:a17:907:7ea4:b0:a37:3922:8838 with SMTP id qb36-20020a1709077ea400b00a3739228838mr5562117ejc.70.1707127130597;
        Mon, 05 Feb 2024 01:58:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5fWfVG7eogvLtPNKTrXLM4Y7+jpxTvk2yEmJwepCMZkgDtk3PMd8rVSD4NlnHELDJRedYq/inZbG3Z8cG+/Bd1BFHjI8KEO5fdm+BBIEEHU6BBzSmyZTATANggSet2UoiNXq5qfPQQOQapCoPW31vd47cG2RHLbvHQ0gvou4FrldnLLT+9ReE3D98xTXaV3Vs8IzTag==
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a20-20020a170906671400b00a34d0a865ecsm4078151ejp.163.2024.02.05.01.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:58:50 -0800 (PST)
Message-ID: <a1035d98-31b3-4926-b7d7-676bf18a4311@redhat.com>
Date: Mon, 5 Feb 2024 10:58:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] power: supply: core: drop workaround for missing
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-4-06a20c958f96@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-4-06a20c958f96@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 2/4/24 18:26, Thomas Weißschuh wrote:
> As the mm8013 driver was extended to also report that property the
> workaround is not needed anymore.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 3680cfc2e908..3804a3bbed24 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -273,7 +273,6 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
>  
>  static ssize_t power_supply_show_charge_behaviour(struct device *dev,
>  						  struct power_supply *psy,
> -						  struct power_supply_attr *ps_attr,
>  						  union power_supply_propval *value,
>  						  char *buf)
>  {
> @@ -289,9 +288,7 @@ static ssize_t power_supply_show_charge_behaviour(struct device *dev,
>  	ret = power_supply_get_property(psy,
>  					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
>  					&available);
> -	if (ret == -EINVAL)
> -		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value->intval]);

More of a remark on patch 1 really, note that if you use
POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] here in patch 1, e.g. :

		return sysfs_emit(buf, "%s\n",
				  POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[value->intval]);

then you can omit the ps_attr argument in patch 1 already, which in turn
will cause this patch to be simpler / smaller.

Regards,

Hans





> -	else if (ret < 0)
> +	if (ret < 0)
>  		return ret;
>  
>  	return power_supply_charge_behaviour_show(dev, available.intval, value->intval, buf);
> @@ -337,8 +334,7 @@ static ssize_t power_supply_show_property(struct device *dev,
>  						&value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> -		ret = power_supply_show_charge_behaviour(dev, psy, ps_attr,
> -							 &value, buf);
> +		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
> 


