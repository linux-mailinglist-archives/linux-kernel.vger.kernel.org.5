Return-Path: <linux-kernel+bounces-85086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151286B036
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD65282149
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5614EFC9;
	Wed, 28 Feb 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLyd4s4D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0EB14AD34
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126635; cv=none; b=ENGTb6g11OA7r263uGcQgwfMyPoX40iTELJrlyFHW7+2pp+Bpl5ne/xwsb/ZoR4AU14/6KvIE3leQl6PSFdPD+11x08lEXZIqolRvf7X4h9zHCWzt7IwfUurT33pDaVX8/UZI5g/ulGbukl2oyMSeLNLl4eOTZ6kLDUtQnktAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126635; c=relaxed/simple;
	bh=J0pBZVG/kTNtQjh0TGoSqnc1pSpyF2AqAzhFgvJaJbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgQ+E+9W+2TwXIB4D1KWGiUY2/sCrAN7x6xnD3DhO7EWIdnvx+tsvjr1OWS9d3AJ0mvShqoCakuwATxEWL1ducOlOSKmicjOEvRNgiPGMr7w2dHtRrXBbvu3HtOWTnDws1DqO+mN7wkew7rfi46UvhESTq2LzyWMmsPUMTLXfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLyd4s4D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709126632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKq+KbCVvhl5Mkuq8KIf4CJGUk342M8pPpaYXQOAlfk=;
	b=CLyd4s4DDndN3vkXBQzOsum5WmPj5Iti0djm5sC8uSNjlje6BFUhrVrUvBtZqpmdxDIqKg
	MWj8n0m6TgYDB0ux9NSqhwZGnT8qwnJ7nmOtZT6VYUtnofr2wOOP4XDENx3W+9TPz0HP/Z
	C+Bb/M7Z5cJ5eLDgYb5kbJhdnKD89oY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-TwImy4aKPnSHbOwOQHUWgQ-1; Wed, 28 Feb 2024 08:23:51 -0500
X-MC-Unique: TwImy4aKPnSHbOwOQHUWgQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3f84b660b8so351040266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126629; x=1709731429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKq+KbCVvhl5Mkuq8KIf4CJGUk342M8pPpaYXQOAlfk=;
        b=rmaTmoIvf0tcGKZpHw07quOqmLjisRYsRq486rGDCfjFKe8EgkPqQwo4ZLiKerbqqa
         X9aveNeR9raIVLvwYJ7rQJzCYjadsb+FIEVktI5V5ZRzu3kFzNZouF2+bMTdzaMa6hOw
         rwEDQttVMmp7ioDfBNRKBvX4rnEpZ0hhHG06KPM1qknBWt20bqzs30yIHSsZKiIoN4Fa
         hz1WmffnZlAGQZ45hToJCnbJn1iZ8tS7trBNRP5holRw8nMWR0EDEGwes+YALaEgzCV8
         1npocxT/qYIY9KWha+5P7tMPtfSCxdXMbLek9eRlQhIN2HXCHdx63bxTN20iYwMtnDJF
         D8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHSZ3JX8fBj+lGNxttQeY0oMyQ1aREiKw/ikgUzr5O2gaA8gJ36uSX9II4hwGeJzMCBRddYn0Ri0EvLm0gzgAy5x7JBmNBEu/lkJcB
X-Gm-Message-State: AOJu0YzIGgL1RAGqbxtjasnAV8nRjKemls2JQJ94lPeUHP4EJ5fhAFoQ
	9b8muMJCoYzuHJ3PqJvsprlufzSkMCyg62AKa5WPkE9qN8XLiChHBJUbfDUSw+wJi+uoqaQ22M6
	en9QjSfQ99wqTC7TDPnCvyBONhwXmtG6lOvllNl018oUPV23Rj7OGGlfTpMJwXg==
X-Received: by 2002:a17:906:5a95:b0:a43:eb29:a293 with SMTP id l21-20020a1709065a9500b00a43eb29a293mr1522626ejq.5.1709126629249;
        Wed, 28 Feb 2024 05:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCxC/SMtA4W6mzulwwMdFiwybWP/9ffS59LzWkV0Sb2HZmnAM5CGQsVznOpvrUUdOBQ+YnWA==
X-Received: by 2002:a17:906:5a95:b0:a43:eb29:a293 with SMTP id l21-20020a1709065a9500b00a43eb29a293mr1522600ejq.5.1709126628814;
        Wed, 28 Feb 2024 05:23:48 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gv18-20020a170906f11200b00a413d1eda4bsm1848568ejb.87.2024.02.28.05.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 05:23:48 -0800 (PST)
Message-ID: <807c658b-358f-47c3-b14a-f1b76e9208c6@redhat.com>
Date: Wed, 28 Feb 2024 14:23:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform/x86: wmi: Do not instantiate older WMI
 drivers multiple times
Content-Language: en-US, nl
To: Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: jithu.joseph@intel.com, linux@weissschuh.net,
 ilpo.jarvinen@linux.intel.com, Dell.Client.Kernel@dell.com,
 jdelvare@suse.com, linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226193557.2888-1-W_Armin@gmx.de>
 <20240226193557.2888-2-W_Armin@gmx.de> <20240227203058.eun4ylvhk4t7uogk@pali>
 <a8602a4a-39e1-46c3-9fe9-b6896c75fa73@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a8602a4a-39e1-46c3-9fe9-b6896c75fa73@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Armin,

On 2/27/24 23:47, Armin Wolf wrote:
> Am 27.02.24 um 21:30 schrieb Pali Rohár:
> 
>> On Monday 26 February 2024 20:35:56 Armin Wolf wrote:
>>> Many older WMI drivers cannot be instantiated multiple times for
>>> two reasons:
>>>
>>> - they are using the legacy GUID-based WMI API
>>> - they are singletons (with global state)
>>>
>>> Prevent such WMI drivers from binding to WMI devices with a duplicated
>>> GUID, as this would mean that the WMI driver will be instantiated at
>>> least two times (one for the original GUID and one for the duplicated
>>> GUID).
>>> WMI drivers which can be instantiated multiple times can signal this
>>> by setting a flag inside struct wmi_driver.
>> What do you think about opposite direction? Adding ".singleton = true"
>> into every driver which is not compatible with duplicated initialization
>> and having the default value that drivers are not singletons.
>>
>> But if the direction it to not accept new "legacy" drivers and start get
>> rid of all "legacy" drivers by rewriting them, then it does not matter
>> if "no_singleton" or "is_singleton" is used...
> 
> Hi,
> 
> i want to make sure that i wont forget any legacy WMI drivers. This way, the
> older legacy WMI drivers automatically initialize no_singleton with false.
> 
> Also i intent to not accept new legacy WMI drivers.

Somewhat offtopic question, how do you plan to handle the case where
there are 2 WMI GUIDs for what really is a single "thing",
specifically one main WMI GUID for a vendor specific interface
for say the embedded-controller and a separate GUID for events ?

IIRC we have several such cases. I thought we even have a case
where the main WMI GUID already is bound to using wmi_bus wmi_driver,
while the event guid is listened to by using wmi_install_notify_handler()
but I cannot find the code doing this, so I might be mistaken on this.

Regards,

Hans



>>> Tested on a ASUS Prime B650-Plus.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>   drivers/hwmon/dell-smm-hwmon.c                 |  1 +
>>>   drivers/platform/x86/dell/dell-wmi-ddv.c       |  1 +
>>>   drivers/platform/x86/intel/wmi/sbl-fw-update.c |  1 +
>>>   drivers/platform/x86/intel/wmi/thunderbolt.c   |  1 +
>>>   drivers/platform/x86/wmi-bmof.c                |  1 +
>>>   drivers/platform/x86/wmi.c                     | 12 ++++++++++++
>>>   include/linux/wmi.h                            |  2 ++
>>>   7 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
>>> index 6d8c0f328b7b..168d669c4eca 100644
>>> --- a/drivers/hwmon/dell-smm-hwmon.c
>>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>>> @@ -1587,6 +1587,7 @@ static struct wmi_driver dell_smm_wmi_driver = {
>>>       },
>>>       .id_table = dell_smm_wmi_id_table,
>>>       .probe = dell_smm_wmi_probe,
>>> +    .no_singleton = true,
>>>   };
>>>
>>>   /*
>>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> index db1e9240dd02..0b2299f7a2de 100644
>>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> @@ -882,6 +882,7 @@ static struct wmi_driver dell_wmi_ddv_driver = {
>>>       },
>>>       .id_table = dell_wmi_ddv_id_table,
>>>       .probe = dell_wmi_ddv_probe,
>>> +    .no_singleton = true,
>>>   };
>>>   module_wmi_driver(dell_wmi_ddv_driver);
>>>
>>> diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
>>> index 040153ad67c1..75c82c08117f 100644
>>> --- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
>>> +++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
>>> @@ -131,6 +131,7 @@ static struct wmi_driver intel_wmi_sbl_fw_update_driver = {
>>>       .probe = intel_wmi_sbl_fw_update_probe,
>>>       .remove = intel_wmi_sbl_fw_update_remove,
>>>       .id_table = intel_wmi_sbl_id_table,
>>> +    .no_singleton = true,
>>>   };
>>>   module_wmi_driver(intel_wmi_sbl_fw_update_driver);
>>>
>>> diff --git a/drivers/platform/x86/intel/wmi/thunderbolt.c b/drivers/platform/x86/intel/wmi/thunderbolt.c
>>> index e2ad3f46f356..08df560a2c7a 100644
>>> --- a/drivers/platform/x86/intel/wmi/thunderbolt.c
>>> +++ b/drivers/platform/x86/intel/wmi/thunderbolt.c
>>> @@ -63,6 +63,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driver = {
>>>           .dev_groups = tbt_groups,
>>>       },
>>>       .id_table = intel_wmi_thunderbolt_id_table,
>>> +    .no_singleton = true,
>>>   };
>>>
>>>   module_wmi_driver(intel_wmi_thunderbolt_driver);
>>> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
>>> index 644d2fd889c0..df6f0ae6e6c7 100644
>>> --- a/drivers/platform/x86/wmi-bmof.c
>>> +++ b/drivers/platform/x86/wmi-bmof.c
>>> @@ -94,6 +94,7 @@ static struct wmi_driver wmi_bmof_driver = {
>>>       .probe = wmi_bmof_probe,
>>>       .remove = wmi_bmof_remove,
>>>       .id_table = wmi_bmof_id_table,
>>> +    .no_singleton = true,
>>>   };
>>>
>>>   module_wmi_driver(wmi_bmof_driver);
>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>> index 29dfe52eb802..349deced87e8 100644
>>> --- a/drivers/platform/x86/wmi.c
>>> +++ b/drivers/platform/x86/wmi.c
>>> @@ -883,6 +883,18 @@ static int wmi_dev_probe(struct device *dev)
>>>       struct wmi_driver *wdriver = drv_to_wdrv(dev->driver);
>>>       int ret = 0;
>>>
>>> +    /* Some older WMI drivers will break if instantiated multiple times,
>>> +     * so they are blocked from probing WMI devices with a duplicated GUID.
>>> +     *
>>> +     * New WMI drivers should support being instantiated multiple times.
>>> +     */
>>> +    if (test_bit(WMI_GUID_DUPLICATED, &wblock->flags) && !wdriver->no_singleton) {
>>> +        dev_warn(dev, "Legacy driver %s cannot be instantiated multiple times\n",
>>> +             dev->driver->name);
>>> +
>>> +        return -ENODEV;
>>> +    }
>>> +
>>>       if (wdriver->notify) {
>>>           if (test_bit(WMI_NO_EVENT_DATA, &wblock->flags) && !wdriver->no_notify_data)
>>>               return -ENODEV;
>>> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
>>> index 781958310bfb..63cca3b58d6d 100644
>>> --- a/include/linux/wmi.h
>>> +++ b/include/linux/wmi.h
>>> @@ -49,6 +49,7 @@ u8 wmidev_instance_count(struct wmi_device *wdev);
>>>    * @driver: Driver model structure
>>>    * @id_table: List of WMI GUIDs supported by this driver
>>>    * @no_notify_data: Driver supports WMI events which provide no event data
>>> + * @no_singleton: Driver can be instantiated multiple times
>>>    * @probe: Callback for device binding
>>>    * @remove: Callback for device unbinding
>>>    * @notify: Callback for receiving WMI events
>>> @@ -59,6 +60,7 @@ struct wmi_driver {
>>>       struct device_driver driver;
>>>       const struct wmi_device_id *id_table;
>>>       bool no_notify_data;
>>> +    bool no_singleton;
>>>
>>>       int (*probe)(struct wmi_device *wdev, const void *context);
>>>       void (*remove)(struct wmi_device *wdev);
>>> -- 
>>> 2.39.2
>>>
> 


