Return-Path: <linux-kernel+bounces-52365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCD849727
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70491F2221D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6F134A0;
	Mon,  5 Feb 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rc/JlJEj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CE12E45
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127207; cv=none; b=UFscxg7mUgteAlMadExj5rdV6ziQdKSacHg7SfwbbSwGsDmqfTgZ6Ev34aFbNz2v0J17cbxwZqFmcq8rPvkbIfxhOrfz4AmVYGW83vQQ7q273/7xkr91wbIUlFnAyZ3JX1byyXihAuiPUxqIdwR2Btlyx1Su+Ih3/2aODsib4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127207; c=relaxed/simple;
	bh=0zwGLQozIm1xLIUb+JT1QR0nH+Sj7un9j5w6FlqwRqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+VP8wOZk0xyqCOG+ERex6RjwlK9qNkq/lLTrRu9rY1DRbb83kMxiy+7rlgjfqAudocdN+OW7/kNLVIyOMlMenKbpS+eUKeWT28FTYyXIvylvlpDyMMelz701pcBt7msC2NsFRD0YNCZyuuFVF4sH2aQKhk6oLVaOARmW6nYVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rc/JlJEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707127205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1Gn5QY0RzFz/c12Z/qyBnZZspPbZJTFIJYfZUyz5g0=;
	b=Rc/JlJEjFs+lQ/VsqDODI7PqwNqGtTZ+XMuTuOdOYew0oQg6BH0+QL282adZukX+o/yhPQ
	Jyv8PZXkRmLzPMHjaZdqnxuxQXDwGtC068pSpIAfw4tc8sqIvgy3LFxLtnTtl6CLhDWUVc
	zq9T3Rs+kLCzMkWeGBYJ5q6Xr87PgMM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-1WmNpTp7OcqK7EMeteud7A-1; Mon, 05 Feb 2024 05:00:03 -0500
X-MC-Unique: 1WmNpTp7OcqK7EMeteud7A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a35118e98caso252618166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127202; x=1707732002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Gn5QY0RzFz/c12Z/qyBnZZspPbZJTFIJYfZUyz5g0=;
        b=VnJAAFbq0vn7fjhK6sCvDMHbZrpHb8JNEOiEUtwvPWfGAaha9dgsvbtFwvij4j6vN7
         E308ptzTlAxNlohmTHhureCwzTEpgEuMKYQQ+vU6h+HXxakWSeP6YzQpaAEDzoclNvEb
         OKEL08zHBiP/qvQULzNxdH0//cxU+T5T4KtinFqfSV+ClNiCCSsZoAKc2ZAsSfyYOwRX
         LnDyl0wdyxshAY34RMWr+2bpJW9uTo1fvLEvQ2JrYia2+CeW6eSs0WDkjp6u3BGfYfg7
         bY1XvVpkv6v8zoKF8Lg82vzSFqEl0qOMgKsN5JQpszlzfDfMQwYcFlfY0SdM3ZxV1lNg
         92zw==
X-Gm-Message-State: AOJu0YzkJ7la58fQZ1N+ZFmcgFBJbO1D/vYACPBPvnFKF29teC58tliE
	r+YprQvxyzXC7Y7y2jLgD5AATQzuoCcndM+VqKwreB5Z75GwNJkgKHNv3CYXIycSHk/h/qNwx1R
	fEvnKgoinjdvdi7fYzB8H6jkVyCgaBcfbCuqlVejUG14hi6F8jYn44E0ltlHnzQ==
X-Received: by 2002:a17:906:6c9a:b0:a37:7e9c:17ea with SMTP id s26-20020a1709066c9a00b00a377e9c17eamr2558741ejr.12.1707127202756;
        Mon, 05 Feb 2024 02:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDasoEfxSl3kUGHu4aAoww/p36CcrrtEFIiFCNTq9O7sX/0D5DLggoumkHWtoeIrvXiXZpyQ==
X-Received: by 2002:a17:906:6c9a:b0:a37:7e9c:17ea with SMTP id s26-20020a1709066c9a00b00a377e9c17eamr2558726ejr.12.1707127202454;
        Mon, 05 Feb 2024 02:00:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHkc55LLSsMQmfs5K3PghfD0W5Y6o+ipTZQwDlhI1YPtrAzL/9GF/wwI4wDRsnZ7N0EybIZobE6yyZV2QDLJ7xLHaFKjf1bXNJ5zfk50Yqh6Sh36nzquGVd62Tf95f1E3nFAD4YsvTwAisbkSx6SDQzabBCkMYuSM+ml756DyN1OdwNqPTmYBifwido3Ab2PdlMlD4Nw==
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a20-20020a170906671400b00a34d0a865ecsm4078151ejp.163.2024.02.05.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 02:00:01 -0800 (PST)
Message-ID: <2f244f9f-8796-4cad-8bf8-d0c3411588c1@redhat.com>
Date: Mon, 5 Feb 2024 11:00:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] power: supply: mm8013: implement
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/4/24 18:26, Thomas Weißschuh wrote:
> The sysfs is documented to report both the current and all available
> behaviours. For this POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE needs
> to be implemented.
> 
> Note that this changes the format of the sysfs file
> (to the documented format):
> 
> Before: "auto"
> After:  "[auto] inhibit-charge"
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Changing userspace API like this is never ideal, but given how
new the mm8013 driver is and that this brings things inline
with the docs I think that this should be fine:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/power/supply/mm8013.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
> index caa272b03564..695df8bd6cb0 100644
> --- a/drivers/power/supply/mm8013.c
> +++ b/drivers/power/supply/mm8013.c
> @@ -72,6 +72,7 @@ static int mm8013_checkdevice(struct mm8013_chip *chip)
>  static enum power_supply_property mm8013_battery_props[] = {
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
> @@ -113,6 +114,10 @@ static int mm8013_get_property(struct power_supply *psy,
>  		else
>  			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE:
> +		val->intval = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
> +			    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
> +		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		ret = regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
>  		if (ret < 0)
> 


