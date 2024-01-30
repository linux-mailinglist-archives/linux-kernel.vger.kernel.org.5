Return-Path: <linux-kernel+bounces-44234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5974841F87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDD6B2B28E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFC65BD0;
	Tue, 30 Jan 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xem86HeO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28565BDA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606229; cv=none; b=Gm4oriA52gmWobJZxl32Kk6PO/TZBPlvu52d237dsnJ5RtvStbC4fb92pXIeBnsjANhGS1KFsSXOqsQdyScuWODJXz4ZfByjoMYL2kEKgE8M/SeV0UX7GVFM/diwFYmf1hMFOL+PWY1R47doAqrZUzqt0NLYZtjDW32l6wEDsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606229; c=relaxed/simple;
	bh=RB/RU+14zjSuFDBCBrMDaKkG53QFQyHCD+mk0Bdf+kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrsgmrksKwvzZ2SNflxZhbjGW9dW3U5SLLIVDqlnGJLg+oddlaCKoXiuZCPwcOzd2lM9eS28q5ZbYznjNj9nFqQpdESlWZJ7nBLrikcMvEdgp/fAnAgR/TUW88PC5o5VPsvzXrVETkJFj92h7xNcLPOkRKXLx9zKNINyWdcxEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xem86HeO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706606227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsxh3glxMHMP5Jb5fGRHylI+iN6TGtV7J1Cs1H5riFM=;
	b=Xem86HeOFZdyy/ptBBeNlVEZLJKUdvX9t6hdy1CERvwYi1WPmXpzoRjFQeIR2zlHHHKlhA
	Xdu2wwkqGKoDB0b6dmisSTyYzAw3XqffhOPiNFYNdqieNnT92ncBT8M1wDXY6U05AI9IbF
	lGnm8DYx1PT0mKF6wuUf+YTQ+CiH43I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-qn-fWWeoOVyBQxKWachJjg-1; Tue, 30 Jan 2024 04:17:05 -0500
X-MC-Unique: qn-fWWeoOVyBQxKWachJjg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a26f2da3c7bso196781666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606224; x=1707211024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsxh3glxMHMP5Jb5fGRHylI+iN6TGtV7J1Cs1H5riFM=;
        b=g4dPqKq1ovzl1XqoVoGCEcHrHDLfdU0jwkIcS+EW/SZbAbVq7UKDyxWJZpNjbj41dU
         53eGYWBSp/ZTD909J1SwTT98NFtL2stw63PAa7VgOdFlLoA+HQEbr12Ny78zeMkMIA4Y
         nPIG1pC9CTHekfJIiEO+2HYzm52vJ7Rag8WJ2vfDWKO4/5eWDLnBDdcTxr9r/b9gW+6O
         Nb530d3lOBbhq+NUFRW2aIv5cebWJW17pAMBNEYzKOvDrzA/1A1dwW7Eli3g7KXEICSH
         RQJ5NIx6wqDaP0bCkkkY9j3e8Cui0m90TSwGRhLuibhDGuh+ylTLUX8Gkb5WGYIKjU3c
         08zw==
X-Gm-Message-State: AOJu0YwLr0Tn50r5VbotBuhyh4JZ0rpO0rIfDi2B7ZTyA2H3bE8L1pXn
	k80E26uyLXUY9FML8gNjsgIPr2+hMqiMCAH7Woc0JnWRyH/Vt5VaxIELKS9ztDmArA7lRxFCzrl
	yv8/cPuJ6SKS8bXdr0tIrGOV8tyAmUNJydE1oK+mnySK5SxCmRyNs2rEHfc6NcA==
X-Received: by 2002:a17:906:a013:b0:a34:bc0d:3ca5 with SMTP id p19-20020a170906a01300b00a34bc0d3ca5mr5710542ejy.13.1706606223876;
        Tue, 30 Jan 2024 01:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa5kt/DuYffhGsop77KpBROb3I0ajmiY5RPux3EHSCMiQZl85DSsHnNvtpSFTn8tU8ZocQJQ==
X-Received: by 2002:a17:906:a013:b0:a34:bc0d:3ca5 with SMTP id p19-20020a170906a01300b00a34bc0d3ca5mr5710525ejy.13.1706606223543;
        Tue, 30 Jan 2024 01:17:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709061c5100b00a3472da6696sm4886274ejg.159.2024.01.30.01.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:17:02 -0800 (PST)
Message-ID: <c09ecd6a-7b1e-42a3-84fa-ba7dbeba2851@redhat.com>
Date: Tue, 30 Jan 2024 10:17:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Initialize ACPI device class
Content-Language: en-US, nl
To: Armin Wolf <W_Armin@gmx.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240124190732.4795-1-W_Armin@gmx.de>
 <9ccc3b9d-d71a-451c-80f5-3da62108d983@redhat.com>
 <CAJZ5v0j1qvJYXqo96eMmtD4JnGh4Mu2ESdri5cGAqL-4bK0geA@mail.gmail.com>
 <62a9942f-97b2-4237-b99f-131535368c68@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <62a9942f-97b2-4237-b99f-131535368c68@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/30/24 03:10, Armin Wolf wrote:
> Am 29.01.24 um 14:08 schrieb Rafael J. Wysocki:
> 
>> On Mon, Jan 29, 2024 at 1:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>> On 1/24/24 20:07, Armin Wolf wrote:
>>>> When an ACPI netlink event is received by acpid, the ACPI device
>>>> class is passed as its first argument. But since the class string
>>>> is not initialized, an empty string is being passed:
>>>>
>>>>        netlink:  PNP0C14:01 000000d0 00000000
>>>>
>>>> Fix this by initializing the ACPI device class during probe.
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>> Note: This patch is based on commit 3f399b5d7189 ("platform/x86: wmi: Use ACPI device name in netlink event")
>>>> ---
>>>>   drivers/platform/x86/wmi.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>>> index 7ef1e82dc61c..b92425c30a50 100644
>>>> --- a/drivers/platform/x86/wmi.c
>>>> +++ b/drivers/platform/x86/wmi.c
>>>> @@ -32,6 +32,8 @@
>>>>   #include <linux/wmi.h>
>>>>   #include <linux/fs.h>
>>>>
>>>> +#define ACPI_WMI_DEVICE_CLASS        "wmi"
>>>> +
>>>>   MODULE_AUTHOR("Carlos Corbacho");
>>>>   MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
>>>>   MODULE_LICENSE("GPL");
>>>> @@ -1202,7 +1204,7 @@ static int wmi_notify_device(struct device *dev, void *data)
>>>>                wblock->handler(*event, wblock->handler_data);
>>>>        }
>>>>
>>>> -     acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
>>>> +     acpi_bus_generate_netlink_event(acpi_device_class(wblock->acpi_device),
>>>>                                        acpi_dev_name(wblock->acpi_device), *event, 0);
>>>>
>>>>        return -EBUSY;
>>>> @@ -1267,6 +1269,8 @@ static int acpi_wmi_probe(struct platform_device *device)
>>>>                return -ENODEV;
>>>>        }
>>>>
>>>> +     strscpy(acpi_device_class(acpi_device), ACPI_WMI_DEVICE_CLASS, sizeof(acpi_device_class));
>>>> +
>>> Hmm, I'm not sure if you are supposed to do this when you are not an
>>> acpi_driver's add() function.
>> You aren't.
> 
> I believed otherwise, as the ACPI AC driver (which is a platform_driver) does the same thing.
> Seems i was wrong on that.

I'm pretty sure that the ACPI AC driver used to be an acpi_driver
and was converted to a platform_driver recently.

AFAIK the plan is to convert all drivers to platform_drivers
and completely get rid of the acpi_driver concept.

That does mean that we will indeed have platform_drivers
now setting the acpi_device_class. So I guess that maybe
this is ok to do for the WMI bus driver too, since that
is also not a plain driver.

>>> Rafael, do you have any comments on this ?
>> I'm not quite sure why this is done here.
> 
> The initialization of the ACPI device class is being done to access this value later when sending an
> ACPI netlink event like other ACPI drivers do.
> 
> However since you clarified that doing this outside of an acpi_driver's add() function is forbidden
> i think it would indeed be better to just pass the value directly without touching the ACPI device class.

Right I was thinking that you could just pass the string
directly to acpi_bus_generate_netlink_event() myself too.

Rafael, do you have any preference for how to solve this ?

Regards,

Hans


