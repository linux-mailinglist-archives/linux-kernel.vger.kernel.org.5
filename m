Return-Path: <linux-kernel+bounces-124443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D28917D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6231C21872
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147B6A340;
	Fri, 29 Mar 2024 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcP2rDSC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B361096F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711964; cv=none; b=kzKSeEsK1w1noTt0SzuAGHZwESGD6+YwtEGiP1/Ae2Amrf/ccTDiqJ3NDXKFSheIvtgA5g8CLlX8ZuyNeW4Tb+/J0xpCIGiGAiyOz1bj4nzryeaNe/cQQ41UBOE5rJxfjXwRIk6bK6Up+HrCrC0WVrvvDYehGyjQ4lDaY0XDrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711964; c=relaxed/simple;
	bh=YiuwKN8qhFuIAOgDB7+gvuNvcRqxhHIJg2+GdaxoSzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8gCLLGtil6xUY+iLerl0IcQAV3SBFjvPtSLIpHN+u3/18FFAQH6hKqLa7LO+wiSQpkDD8Z/UD7AAkUB3lJ2T/TbZABzMAJqlEElFj2BtnoxP197w8ygmVPGhnLUsuNJiR4Yu5/lxkKJZR9cuj0jKCbWAL9iyz1C5tEvvx76v8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcP2rDSC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711711961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4oBdGOgnjp9VHMYVc4RnnPVdgFa9XSj8SazzjSXu5g=;
	b=bcP2rDSCCZN3unXTl/bFQhKjSRh1ICkbMMDcT0kdhM1axr5y/xqPN1bLBiGriJa0vv1MGN
	g+1OYfmL6OIConAQJKspButkXf4+Vrf20m1pp57pgOqo+c9NVyKw7ppktSg1X5CTGNu8OY
	ULM6sqq7272gIVyaFY4t4dYocC/Qvpg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-5FajaeG8MqSzNuwJHyBVug-1; Fri, 29 Mar 2024 07:32:40 -0400
X-MC-Unique: 5FajaeG8MqSzNuwJHyBVug-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a47416276c7so104983566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711959; x=1712316759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4oBdGOgnjp9VHMYVc4RnnPVdgFa9XSj8SazzjSXu5g=;
        b=b4VZIG4CzkHiHpnGPl13t2ZTYw0QpQw4nMGEn2BVoHO11TTm5KnBsfZQ9d5kW4wr+N
         6aSm4t7hB6ldWY3N13juSTWOtace1q/QMSpqImJVvf26Hx6cTWo91Wp6/GDPf4cAQRI0
         /GMbyhmtTCyL3T6mNB/ro83ndbHvByukf+mCQj6jyXLdbl3tH0p67m5ipkBHLHXo7LpV
         8EPQrhnvEh00ELH7RzugSrmPnM+Dc/VWyoE7TueUGfPzIOwYIlhowyjKwWtI86hYLItf
         34DTJ5plFEVAPpOqhGhTC+hAXgy2HoaDsUFQrAHvfsMK+6HULx3QBg6JP5640rINN4sS
         N1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTyh0rdDIWNbcrI4+sqwsyDoMXTVgsNlZ9Ff+6eOnX+qCIo7smDjEAfFQW3B2VQQxa0u+dCOY0/l5k6ftm+A8k7di9OtHyEacsNToU
X-Gm-Message-State: AOJu0YxxMdFUMuMnchs90M7KNz6HmkcGkppJ539YLkc0lM/V3ufbxKq0
	NOdZnhldISeCCfdiAZW1eyCc2BNyaODwIMgdcUPfGkkEk9djk9tM91SiHtmz+jA3+fifMR3AlJP
	0bJLKoCUhTP99Ay3IQI9KA2nbjGSd8vssHE7Sd1DAdVCgfLWayLYUwMoOSMj9kQ==
X-Received: by 2002:a17:906:e0c4:b0:a4e:359e:a03e with SMTP id gl4-20020a170906e0c400b00a4e359ea03emr918554ejb.71.1711711959052;
        Fri, 29 Mar 2024 04:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER87D3bzG0neKDu29z4yu8LMxlAbCl6f3aOgE1ToOp8JlQHq1fhlVNJsW8s36yFAEfLW/eDA==
X-Received: by 2002:a17:906:e0c4:b0:a4e:359e:a03e with SMTP id gl4-20020a170906e0c400b00a4e359ea03emr918545ejb.71.1711711958715;
        Fri, 29 Mar 2024 04:32:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m16-20020a170906581000b00a4a3807929esm1823908ejq.119.2024.03.29.04.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 04:32:38 -0700 (PDT)
Message-ID: <f3d9a568-8953-4fce-9fef-5fe1539fb91a@redhat.com>
Date: Fri, 29 Mar 2024 12:32:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: core: simplify charge_behaviour formatting
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/29/24 9:18 AM, Thomas Weißschuh wrote:
> The function power_supply_show_charge_behaviour() is not needed and can
> be removed completely.
> Removing the function also saves a spurious read of the property from
> the driver on each call.
> 
> The convulted logic was a leftover from an earlier patch revision.
> Some restructuring made this cleanup possible.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/all/9e035ae4-cb07-4f84-8336-1a0050855bea@redhat.com/
> Fixes: 4e61f1e9d58f ("power: supply: core: fix charge_behaviour formatting")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/power_supply_sysfs.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 0d2c3724d0bc..b86e11bdc07e 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -271,23 +271,6 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
>  	return count;
>  }
>  
> -static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> -						  struct power_supply *psy,
> -						  union power_supply_propval *value,
> -						  char *buf)
> -{
> -	int ret;
> -
> -	ret = power_supply_get_property(psy,
> -					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> -					value);
> -	if (ret < 0)
> -		return ret;
> -
> -	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> -						  value->intval, buf);
> -}
> -
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -321,7 +304,8 @@ static ssize_t power_supply_show_property(struct device *dev,
>  						&value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> -		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
> +		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> +							 value.intval, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
> 
> ---
> base-commit: 070c1470ae24317e7b19bd3882b300b6d69922a4
> change-id: 20240329-power-supply-simplify-5722806eefdd
> 
> Best regards,


