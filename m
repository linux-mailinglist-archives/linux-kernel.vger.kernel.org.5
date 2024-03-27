Return-Path: <linux-kernel+bounces-120674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812688DB51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23521F2BA61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91D2EAE6;
	Wed, 27 Mar 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgYlabsX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDF20DE8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535784; cv=none; b=FS1iFfZDR2nm4JWBAupnZ6RqeNe+l/OCnAsBIQom1FcpD79aWCJUnJQGtHEDqyuP0PWXg+uWMkhUDGlqJJQuREbybEJss3R/fMExS2pdOFjxfxelt7vCsgJUxSZU4SqFDqA2gv26jNoLMYdUqWybF9eN2GLbqZGQtGQbwJkum0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535784; c=relaxed/simple;
	bh=L6tlt98OmYQtFpQLamK6Qa2xfI5IedwVJCtmpxBH+q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGRzDkC0L0J5gk4U7mW79H+bfG4CHJpH7fgZGyuffrzxHNOgLaQLKDQZ4FGF4lVG2iS6wpqn6s0zBaT+QM0++WvKCf9QONtBeixodNYlPHzfoJHJpDZ+xwJLWqyP6m+Z8q85V4IJc0xoOLbi8G8N3EEYf1fYW0sYJj9lgSSPBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgYlabsX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711535781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLhy70EK4wmXFy+4nX1nQRJ3JiG17ewD5LnGkbVypKo=;
	b=VgYlabsXTyUBKGXV2NQhdUaeebwfNRtxNzJKdOghXmlLzhkAupAV92/LHVMDYonxTPosk8
	IDNmXBeyDVXr7a9C00FRZRPKTaWl7dSMsCpxH7WuKTu+n7vlctsCk+vaKUHOnQF6FKd9vg
	yrX0ZOtasEgD4byeAf3J0HbWwAujaXk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-5sUdwCGMPLq-jiYieFJfxg-1; Wed, 27 Mar 2024 06:36:20 -0400
X-MC-Unique: 5sUdwCGMPLq-jiYieFJfxg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-515a7cead49so3138751e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535779; x=1712140579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLhy70EK4wmXFy+4nX1nQRJ3JiG17ewD5LnGkbVypKo=;
        b=D3hQPGyAsZuaPyvQtoK4MAlK7MtUGHdVO42JpxFLUuMSe95dNNb2S3gfPesFGGChaM
         4ltd0eAn+LB+ehrKHDqRwrz7YongA5SFjwdQ0vbTGOHwAQ1Grwe2ZSmSI5XLoO3k0kl+
         r7lPlCJBHorOwNoJC2eRFGlrHE2mS1wsJ4E2m2wne3LkmBUSRYKHopdcoN3T5FE9OFJ8
         4RtQDHoBiUAXhtKYB4+2VYGHL2bsczbhz2PSjNSnw3srucsYmlnz0qwVVjFYSbJuzmB6
         uFHftwa2VzFYM8i7f/QF/hTX9U3ryh2jrEM+gR8aulUraoZXvUsW6RmCqjM6WvaFIodI
         RDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBIvOQQ5A8EaRkXoQbAMP7F0aRt1XUmZ4K3fy3hWO+gnBPty3jzUjjs4wqRvTbDC5yU5DaKTXYBYrFETdGhXZ80v8a8At4qgUXgt9U
X-Gm-Message-State: AOJu0YzqnW2o/GNL2GlCw9BECeRYLEwLLsouZ/p8RAiONsrf7kRmOyVr
	NuWL6hoIEAdDV7aK4cpgvHff8QNngYVqMHrrn451nJNVILkRYu2bdvcc1EL3sj8XysD+ylL4fzj
	JVZiwgLcK9b4yR1Uuw4W/XljINvrFqUH0ZYtUbuLgeMsuF5uRxiGxKV0B4FWXUA==
X-Received: by 2002:ac2:4850:0:b0:515:aca8:233 with SMTP id 16-20020ac24850000000b00515aca80233mr3990126lfy.15.1711535778878;
        Wed, 27 Mar 2024 03:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/1YlG0KyIzovm9MKsFwVixKSZvkkV0QgI9sTS8W5neKd/mOR4UjIkBWGVMhpL66SJai1Bgg==
X-Received: by 2002:ac2:4850:0:b0:515:aca8:233 with SMTP id 16-20020ac24850000000b00515aca80233mr3990111lfy.15.1711535778507;
        Wed, 27 Mar 2024 03:36:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ch12-20020a170906c2cc00b00a44180ab871sm5258891ejb.50.2024.03.27.03.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:36:18 -0700 (PDT)
Message-ID: <635d887f-2c3b-44dd-9aa5-3263fae880c5@redhat.com>
Date: Wed, 27 Mar 2024 11:36:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply: mm8013: fix "not charging"
 detection
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/3/24 4:31 PM, Thomas Weißschuh wrote:
> The charge_behaviours property is meant as a control-knob that can be
> changed by the user.
> 
> Page 23 of [0] which documents the flag CHG_INH as follows:
> 
>   CHG_INH : Charge Inhibit      When the current is more than or equal to charge
>                                 threshold current,
>                                 charge inhibit temperature (upper/lower limit) ：1
>                                 charge permission temperature or the current is
>                                 less than charge threshold current ：0
> 
> So this is pure read-only information which is better represented as
> POWER_SUPPLY_STATUS_NOT_CHARGING.
> 
> [0] https://product.minebeamitsumi.com/en/product/category/ics/battery/fuel_gauge/parts/download/__icsFiles/afieldfile/2023/07/12/1_download_01_12.pdf
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/mm8013.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
> index caa272b03564..20c1651ca38e 100644
> --- a/drivers/power/supply/mm8013.c
> +++ b/drivers/power/supply/mm8013.c
> @@ -71,7 +71,6 @@ static int mm8013_checkdevice(struct mm8013_chip *chip)
>  
>  static enum power_supply_property mm8013_battery_props[] = {
>  	POWER_SUPPLY_PROP_CAPACITY,
> -	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
> @@ -103,16 +102,6 @@ static int mm8013_get_property(struct power_supply *psy,
>  
>  		val->intval = regval;
>  		break;
> -	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> -		ret = regmap_read(chip->regmap, REG_FLAGS, &regval);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (regval & MM8013_FLAG_CHG_INH)
> -			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> -		else
> -			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> -		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		ret = regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
>  		if (ret < 0)
> @@ -187,6 +176,8 @@ static int mm8013_get_property(struct power_supply *psy,
>  
>  		if (regval & MM8013_FLAG_DSG)
>  			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (regval & MM8013_FLAG_CHG_INH)
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		else if (regval & MM8013_FLAG_CHG)
>  			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>  		else if (regval & MM8013_FLAG_FC)
> 


