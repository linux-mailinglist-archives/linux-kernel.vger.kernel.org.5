Return-Path: <linux-kernel+bounces-52352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0313849709
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A7B1C2242E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B912E75;
	Mon,  5 Feb 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drAZe/ZH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38C171C7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126744; cv=none; b=fHYDCzC8fy9rk3DGz2u8u0tt01hEuCXPFSvM7Tg0h4zw5ELZzR1B4qfuRJULP7BWYg94zoquBndWTNam35XkPrKPhLwPJJu3PtIWYj8coHXxMbvAw93xz1MmwG3GE43TIG2r8o6Sy+o8YYI27hTeyhs3Yo9bahUOUtbu36qXdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126744; c=relaxed/simple;
	bh=RYsOsd6ldEsi+lU2Q+O3tJbWbufBwua8TQrvi9JLfMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+uC8AJ7t+jnhQ4UscPAKi8YA/r3/GycXuk0olQQSfKr5GPCFbsjl9uGdQxnsD4917VxlgDmiXJviPISWnCAtpcK1mgoBYbqEAJusErglm6YyhQRXdeLprrQI1/dlQnYOuL5uWvJUJgyC6xmVnVFScyXIAfXtXEdHP0Rkbw1De4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drAZe/ZH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707126742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okBHNXFWzy/uWqNBvrxx3KCWO+YYFDnkyYLrHcHPYIs=;
	b=drAZe/ZH7VlrxEMJXCOHCMMOEaJARRKKAmCmED5bp4aBA8sLQNXzwcTWd4cDoOK7R6Dsrv
	hqajmqEOEy6WGu/pLWU47Wwk4Jsjmy/cY/PsKv63rTpxTn3RjCQuHiDydVlAUDENDJxeTF
	VqQb+qbfe64O3FwutcuQctP/wPOC2+I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-DGoy1kXhM2qWDbGYpXBukA-1; Mon, 05 Feb 2024 04:52:20 -0500
X-MC-Unique: DGoy1kXhM2qWDbGYpXBukA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2bc65005feso305844866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126739; x=1707731539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okBHNXFWzy/uWqNBvrxx3KCWO+YYFDnkyYLrHcHPYIs=;
        b=lpKxqylBDVyBR5Tk/HoawBhWDwUecb0HDk7ZYQKxcl3zD+ehMPRXDSZxmR9nTprxua
         3E4/ihDys9mInPMzfJ5RtejJFQXGMzZxEVpQm6BkhlGPGRr4KQfo49L1KskktlHKQA4p
         OqP6iU9X5a7VKiIYO+fqleRHwYLh2BqgmSh6FHIAoF9iiAbQu2taFMCuD6pOqL1F2wRY
         +pYMsffJNhHRNbfWTo2XBFnqMJ+NFpCknlfXxN21OCDV7FLTQiBSLKUkX0LAJ6UVZHzT
         xb7tSNwSYI65/ttDzogOwep4gPACcmOWDvxNuBMVpjZ89ASPahgRrhZ0QT7NlyqKdu9N
         x5tw==
X-Gm-Message-State: AOJu0YwRHi8MSij74joagzgRe/WAbP67tVHy10XMtVnij6st5bsoi94k
	ZWBB51dfpUGtpxeRxRRLsT8SB6OlaMhKClAhC3wXc/V2JCteu+PHDmcyMN4UEOY0fwZ5R1Nhmi8
	VS3wsgnZ7M2zNtRnQSs7hfHIhbxM6MYjpkqKTF0ci9s/ODgPoVDcdupj2MyUrLQ==
X-Received: by 2002:a17:906:b20b:b0:a37:d28b:9618 with SMTP id p11-20020a170906b20b00b00a37d28b9618mr862204ejz.54.1707126739439;
        Mon, 05 Feb 2024 01:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERkOiRHWd9RmqerUx3reRoJ3IolfcQQNXRrF5RPAOb1fR2qjTlyFHkoDgX/mkXmpxCXqr4XA==
X-Received: by 2002:a17:906:b20b:b0:a37:d28b:9618 with SMTP id p11-20020a170906b20b00b00a37d28b9618mr862191ejz.54.1707126739044;
        Mon, 05 Feb 2024 01:52:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU8Vr+eBLMR4ssBFUkqUPcJQZH34qWFVMSrCrAgBw8FizRT//yIBi6j9p/6x6f2aBfVXKtImpT59DFF7fz9YHXH6PEfsyn7VnPvL6U31AHf/kzXkMJs4P7OqIdvqPf5cPZjS1SLLp6lFiS7C+kMyDdxhKE6GuDd9DMwBk7/QFlgdhNA3UFPS2DpWE1C9d4EdJDufqioVw==
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id vw3-20020a170907a70300b00a35920de35dsm4113963ejc.188.2024.02.05.01.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:52:18 -0800 (PST)
Message-ID: <53082075-852f-4698-b354-ed30e7fd2683@redhat.com>
Date: Mon, 5 Feb 2024 10:52:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: supply: core: fix charge_behaviour formatting
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-1-06a20c958f96@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-1-06a20c958f96@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

Thank you for your patches for this.

On 2/4/24 18:26, Thomas Weißschuh wrote:
> This property is documented to have a special format which exposes all
> available behaviours and the currently active one at the same time.
> For this special format some helpers are provided.
> 
> However the default property logic in power_supply_sysfs.c is not using
> the helper and the default logic only prints the currently active
> behaviour.
> 
> Adjust power_supply_sysfs.c to follow the documented format.
> 
> There are currently two in-tree drivers exposing charge behaviours:
> thinkpad_acpi and mm8013.
> thinkpad_acpi is not affected by the change, as it directly uses the
> helpers and does not use the power_supply_sysfs.c logic.
> 
> As mm8013 does not implement POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
> the new logic will preserve the simple output format in this case.
> 
> Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 32 +++++++++++++++++++++++++++++++
>  include/linux/power_supply.h              |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 977611e16373..3680cfc2e908 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -271,6 +271,32 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> +						  struct power_supply *psy,
> +						  struct power_supply_attr *ps_attr,
> +						  union power_supply_propval *value,
> +						  char *buf)
> +{
> +	union power_supply_propval available;
> +	int ret;
> +
> +	ret = power_supply_get_property(psy,
> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +					value);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = power_supply_get_property(psy,
> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
> +					&available);
> +	if (ret == -EINVAL)
> +		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value->intval]);
> +	else if (ret < 0)

No need for "else if" here since the if above does a return. So you can just do:

	if (ret < 0)
		return ret;


> +		return ret;
> +
> +	return power_supply_charge_behaviour_show(dev, available.intval, value->intval, buf);
> +}
> +
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -282,6 +308,8 @@ static ssize_t power_supply_show_property(struct device *dev,
>  
>  	if (psp == POWER_SUPPLY_PROP_TYPE) {
>  		value.intval = psy->desc->type;
> +	} else if (psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR) {
> +		value.intval = -1;
>  	} else {
>  		ret = power_supply_get_property(psy, psp, &value);
>  

I'm not a fan of this, I guess that you are doing this because you do not
want to enter this if:

        if (ps_attr->text_values_len > 0 &&
            value.intval < ps_attr->text_values_len && value.intval >= 0) {
                return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
        }

But by doing this you add both the special case of setting value.intval = -1
here and you now need to do the power_supply_get_property() which is in the else
manually in power_supply_show_charge_behaviour() and the error handling / logging
of power_supply_get_property() in power_supply_show_charge_behaviour() is different.

What I think you can (and should) do here instead is move:

        if (ps_attr->text_values_len > 0 &&
            value.intval < ps_attr->text_values_len && value.intval >= 0) {
                return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
        }

into the default case of the switch (psp) {} below it in a preparation patch.

This if is never entered for the 2 non default cases in that switch, so it
is safe to move it into the default case, e.g. something like this:

	default:
	        if (ps_attr->text_values_len > 0 &&
        	    value.intval < ps_attr->text_values_len && value.intval >= 0)
                	ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
		else
			ret = sysfs_emit(buf, "%d\n", value.intval);

I think that also actually makes things a bit cleaner then the current
early-exit for printing enum values.

And then in the next patch you can just add:

	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
		ret = power_supply_show_charge_behaviour(dev, psy, ps_attr,
							 &value, buf);
		break;

Without needing to set intval = -1 and without needing to get the value
inside power_supply_show_charge_behaviour() since that will already
be done for you then.

Regards,

Hans







> @@ -308,6 +336,10 @@ static ssize_t power_supply_show_property(struct device *dev,
>  		ret = power_supply_show_usb_type(dev, psy->desc,
>  						&value, buf);
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		ret = power_supply_show_charge_behaviour(dev, psy, ps_attr,
> +							 &value, buf);
> +		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
>  		break;
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c0992a77feea..9a6e6b488164 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -135,6 +135,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
> 


