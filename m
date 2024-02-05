Return-Path: <linux-kernel+bounces-52510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E6849924
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EE82895D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B75019BBA;
	Mon,  5 Feb 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QARxpV0z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB071199BA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133442; cv=none; b=FpOaTIRm6A/Fwpr2Lm2gnkUABv1DHnTZx3yMaVtQwJI2LkjZ0aWgYRHbr9z04ZB7tU8AUDPbbkPZ2p3rGs9DJ4CQrybSTeSIsHsf/mSv+8IsnOlyCyjVcsu3xLIA/ZB40gvXlbz615SQ90YRrZQFH2vDr5+u7fU1Gx37PiM5nSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133442; c=relaxed/simple;
	bh=x4zCB2jJPLY//ELhsFJfgp/Hc/wSidVR4/cirg0/D4c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=edzNjs3UH6nZEFvctua7lqyj+TLANrXcCd8hRcskxhX4gb8pf7C4F/iJVzkuiVL8Ihis78rH88So/eF0Hpkb2/ST+BdYbYF151yauEmGFdkOGvXp9lzcNx1IJ20C7v6UjdgSZ+XOyZZEq+pDKxcCRQI9aVY9JyRzu7HEAkhBYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QARxpV0z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707133438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bH938qwo42+I5N8TlaiJJi9jSN19vAPRnOWM/iaHMuo=;
	b=QARxpV0zC1AXfELEfO70VGUle6zqTM2dLm5BqqkSpY1UUiiPDq35Lq79QX96SHgzTjx3n7
	DNQfdoDc6mLw0VBfBfkRKdiAA2pCq7qRsuvFTGHj0rQhyG6z5S1aGEHAR+77sKp49tsWu2
	zec/74TdI0BVGls5fD5+o8T0KRYctRI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-W5EqJXtCOpa73HNEh3aDfA-1; Mon, 05 Feb 2024 06:43:57 -0500
X-MC-Unique: W5EqJXtCOpa73HNEh3aDfA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a35860bff34so396852866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707133436; x=1707738236;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bH938qwo42+I5N8TlaiJJi9jSN19vAPRnOWM/iaHMuo=;
        b=qGfmh1FWB0JMFlV7tlGSFfv42y7TE8MO50uQFKMkKUGPb7AhvAn7b29cCdH8+bovQS
         viTDPaaxsVMJr5B3Ju+JRURCIrZGjlbI2nIrWKiQThUnCqXrIfE0/l36o8T4fN4pvEj/
         CwsqSGYdvyJoIdg05CEDD1IOuslySBkd6+Jqfa9ovZfHcVJjLyy0bsHhn0E0mQyGZvAq
         QsXXTSVFwy0NjUCN9dC9OujjlTQIr9VKzR8fEVUDusw2z5ycznbWpsIXbilz595Whtqb
         M5/IepdB0pLgEe6W5tIsbeGuatLBt2xHIHzUqvs+1AAlByRDlz9vKldfu+J7EqSyD5zN
         E4xw==
X-Gm-Message-State: AOJu0Yze9vVs0ZOyhBFy+HDwKbZmqI9y5BylZ7XA7gCeOglEJFRXuQYs
	F20fgntgG21Ylr3fvArpePC22BfI/MEd7c67Dn6xy8IIlJ9QEKSzYworo/cPuAaUIUIndIyRiq6
	XVATtPcxIcqwS2U38R5LXYu3n3jt0p/xjjRTwZlsKGY9GpdakVBJG1Yl8HlNkfQ==
X-Received: by 2002:a17:906:3019:b0:a37:2a6e:f55e with SMTP id 25-20020a170906301900b00a372a6ef55emr5389666ejz.59.1707133436177;
        Mon, 05 Feb 2024 03:43:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpTaS8OWHS8oILL+F5TVUEpveugOeQ87e7BjKFvoC3u11XuhRAVJIwtzgmvBkpgJQk0oylRg==
X-Received: by 2002:a17:906:3019:b0:a37:2a6e:f55e with SMTP id 25-20020a170906301900b00a372a6ef55emr5389649ejz.59.1707133435767;
        Mon, 05 Feb 2024 03:43:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUNlHGRB5iOsh+IeIb18zeWU5DIgjfZuJJVIAGO/AL4pNzVmXWeVvowhrgD6dn0Umol2WSQJEwwuuoHGzPYjaRM2rzgCj5BRVkLdOcSZxdjA83YgTwx3ZhVXUKs1GQ0AXp5QmqLs2hjm4LLjog/zV3QPwXOx9qr+zwWU19q+Vpns1IJp3i12hgQLYteihYBKWi+LRKvGQ==
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hu21-20020a170907a09500b00a34b15c5cedsm4288819ejc.170.2024.02.05.03.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 03:43:55 -0800 (PST)
Message-ID: <3d27029b-caef-45a1-88bf-98f78e6d6a61@redhat.com>
Date: Mon, 5 Feb 2024 12:43:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: supply: core: fix charge_behaviour formatting
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-1-06a20c958f96@weissschuh.net>
 <53082075-852f-4698-b354-ed30e7fd2683@redhat.com>
In-Reply-To: <53082075-852f-4698-b354-ed30e7fd2683@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/5/24 10:52, Hans de Goede wrote:
> Hi Thomas,
> 
> Thank you for your patches for this.
> 
> On 2/4/24 18:26, Thomas Weißschuh wrote:
>> This property is documented to have a special format which exposes all
>> available behaviours and the currently active one at the same time.
>> For this special format some helpers are provided.
>>
>> However the default property logic in power_supply_sysfs.c is not using
>> the helper and the default logic only prints the currently active
>> behaviour.
>>
>> Adjust power_supply_sysfs.c to follow the documented format.
>>
>> There are currently two in-tree drivers exposing charge behaviours:
>> thinkpad_acpi and mm8013.
>> thinkpad_acpi is not affected by the change, as it directly uses the
>> helpers and does not use the power_supply_sysfs.c logic.
>>
>> As mm8013 does not implement POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
>> the new logic will preserve the simple output format in this case.
>>
>> Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>  drivers/power/supply/power_supply_sysfs.c | 32 +++++++++++++++++++++++++++++++
>>  include/linux/power_supply.h              |  1 +
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> index 977611e16373..3680cfc2e908 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -271,6 +271,32 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
>>  	return count;
>>  }
>>  
>> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
>> +						  struct power_supply *psy,
>> +						  struct power_supply_attr *ps_attr,
>> +						  union power_supply_propval *value,
>> +						  char *buf)
>> +{
>> +	union power_supply_propval available;
>> +	int ret;
>> +
>> +	ret = power_supply_get_property(psy,
>> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>> +					value);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = power_supply_get_property(psy,
>> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
>> +					&available);
>> +	if (ret == -EINVAL)
>> +		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value->intval]);
>> +	else if (ret < 0)
> 
> No need for "else if" here since the if above does a return. So you can just do:
> 
> 	if (ret < 0)
> 		return ret;
> 
> 
>> +		return ret;
>> +
>> +	return power_supply_charge_behaviour_show(dev, available.intval, value->intval, buf);
>> +}
>> +
>>  static ssize_t power_supply_show_property(struct device *dev,
>>  					  struct device_attribute *attr,
>>  					  char *buf) {
>> @@ -282,6 +308,8 @@ static ssize_t power_supply_show_property(struct device *dev,
>>  
>>  	if (psp == POWER_SUPPLY_PROP_TYPE) {
>>  		value.intval = psy->desc->type;
>> +	} else if (psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR) {
>> +		value.intval = -1;
>>  	} else {
>>  		ret = power_supply_get_property(psy, psp, &value);
>>  
> 
> I'm not a fan of this, I guess that you are doing this because you do not
> want to enter this if:
> 
>         if (ps_attr->text_values_len > 0 &&
>             value.intval < ps_attr->text_values_len && value.intval >= 0) {
>                 return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
>         }
> 
> But by doing this you add both the special case of setting value.intval = -1
> here and you now need to do the power_supply_get_property() which is in the else
> manually in power_supply_show_charge_behaviour() and the error handling / logging
> of power_supply_get_property() in power_supply_show_charge_behaviour() is different.
> 
> What I think you can (and should) do here instead is move:
> 
>         if (ps_attr->text_values_len > 0 &&
>             value.intval < ps_attr->text_values_len && value.intval >= 0) {
>                 return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
>         }
> 
> into the default case of the switch (psp) {} below it in a preparation patch.
> 
> This if is never entered for the 2 non default cases in that switch, so it
> is safe to move it into the default case, e.g. something like this:
> 
> 	default:
> 	        if (ps_attr->text_values_len > 0 &&
>         	    value.intval < ps_attr->text_values_len && value.intval >= 0)
>                 	ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> 		else
> 			ret = sysfs_emit(buf, "%d\n", value.intval);
> 
> I think that also actually makes things a bit cleaner then the current
> early-exit for printing enum values.
> 
> And then in the next patch you can just add:
> 
> 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> 		ret = power_supply_show_charge_behaviour(dev, psy, ps_attr,
> 							 &value, buf);
> 		break;
> 
> Without needing to set intval = -1 and without needing to get the value
> inside power_supply_show_charge_behaviour() since that will already
> be done for you then.

One more note on this. With the suggested preparation patch to move
the if checking for ps_attr->text_values into the default case,
you can then also properly turn POWER_SUPPLY_PROP_USB_TYPE into an
enum too:

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 977611e16373..768df64330f4 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -209,7 +209,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
 	POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
 	POWER_SUPPLY_ENUM_ATTR(TYPE),
-	POWER_SUPPLY_ATTR(USB_TYPE),
+	POWER_SUPPLY_ENUM_ATTR(USB_TYPE),
 	POWER_SUPPLY_ENUM_ATTR(SCOPE),
 	POWER_SUPPLY_ATTR(PRECHARGE_CURRENT),
 	POWER_SUPPLY_ATTR(CHARGE_TERM_CURRENT),

IOW you can now set ps_attr->text_values* for POWER_SUPPLY_PROP_USB_TYPE
too, without needing to worry this causing power_supply_show_usb_type()
no longer to get called.

The reason I'm mentioning this is because power_supply_show_usb_type()
and power_supply_charge_behaviour_show() show a lot of code-duplication.

And I think that we can have one generic function replacing both
by using ps_attr->text_values* instead of hardcoding POWER_SUPPLY_USB_TYPE_TEXT
resp. power_supply_charge_behaviour_show (and yes this contradicts
my earlier comment on patch 4/4).

Although at a closer look I see now that the usb-types code uses
a list of supported type enum values in the power_supply_desc,
where as the charge_behavior code uses a bitmask which you retrieve
through a new property.

Thinking more about this, I think that adding a fake
POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE property as you do here
might actually not be the best idea. All the other properties
are visible in sysfs, so this one is a bit weird. I think it might
be better to add this info to power_supply_desc like how this is
done for the usb-types.

And:
        const enum power_supply_usb_type *usb_types;
        size_t num_usb_types;

Should probably be converted into a bitmask too. I checked
and there are not that many users of this.

Once we have that as a bitmask too, we can refactor
power_supply_show_usb_type() and power_supply_charge_behaviour_show()
into a single new helper.

But I believe that refactoring:

        const enum power_supply_usb_type *usb_types;
        size_t num_usb_types;

into a bitmask is out of scope for this series. So I guess
that for now just add the bitmask of available charge behaviors
to power_supply_desc rather then making it a fake property
and then in the future we can do the refactor of usb-type
to a bitmask and remove the code duplication between
power_supply_show_usb_type() and power_supply_charge_behaviour_show()

Sebastian, any comments ?

Regards,

Hans









>> @@ -308,6 +336,10 @@ static ssize_t power_supply_show_property(struct device *dev,
>>  		ret = power_supply_show_usb_type(dev, psy->desc,
>>  						&value, buf);
>>  		break;
>> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
>> +		ret = power_supply_show_charge_behaviour(dev, psy, ps_attr,
>> +							 &value, buf);
>> +		break;
>>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>>  		ret = sysfs_emit(buf, "%s\n", value.strval);
>>  		break;
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index c0992a77feea..9a6e6b488164 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -135,6 +135,7 @@ enum power_supply_property {
>>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
>>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
>>  	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
>>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>>  	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>>  	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
>>
> 


