Return-Path: <linux-kernel+bounces-32794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E656836026
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DD8B21339
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A913A264;
	Mon, 22 Jan 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFKNrXL0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D83AC0F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920815; cv=none; b=q3QkGYU56ciEqJQSWOoD/v7ZF6yjtXm0lkxEMl1tqEBcf9Tn/Lg+6nYkBkzualPu967UN/QlwHLLMuCMxjnGldUxdRkWGZT6rCqXEi6TN1uynEFMyTRFfJa8+5UCWhf+dQBshNpYUUjBmgnDBc422pkOkzAj5yMYMEFUKVGRirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920815; c=relaxed/simple;
	bh=ONTUORr79F/Xba5hq2zlrbnfx8Q4+LpZeX2oM73bVME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLWjpeCCGKkERU+Frpfg2+ZpyDKPrirutNOyXioR0HFcw3/lyd4thAFpVMoQwNiwbjnRS4fPnk2OmfIhRgq07QW0F9poTKa7V8bBk9cyh7Y04TUpnAjiisfGx7zNaOdKkv4PwQCmZUdsi8OX8Q8eRJy9kUDDrF2+6ISzylaIpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFKNrXL0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705920812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRuo/d5F/YUO1+PfgH7jzbdO8sZRQjFRJowRJyMpMzc=;
	b=EFKNrXL0uB+GTluUIil2bnExFN1EDKQJi2LFesVQFu4SDK6r4QKYr97pEmIJVcWeAvtxqH
	7V43RhTWi1lU5qhSFN+Kq06PHlGW+f8pmZcZIs33UaUk3vVuyikWF8snw7q8rUv1LyzISt
	5oGnQKG89gAWOEwC4+1+GDeiQL1grR8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-XqtBdFn1OxK3HIxOBLiWYQ-1; Mon, 22 Jan 2024 05:53:30 -0500
X-MC-Unique: XqtBdFn1OxK3HIxOBLiWYQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e5195db01so1940226e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920809; x=1706525609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRuo/d5F/YUO1+PfgH7jzbdO8sZRQjFRJowRJyMpMzc=;
        b=g083+HtuwtQ8CL22O1ZmDuQYCIL3WwnZgBL7ope89Vk0V8eoiXqqHz/BuTQntSWXut
         ex3l8nFkE3ZwyhihS+x1UMFFgAxMrd4Umgo4bfzkTkd9eOGPbAbRZQu1ce82tFOj1KT5
         FltbDTGBwwN2hNTUtl+dF3XiZ/DOSIQDvYoRkwEzr+Ul4EfRyVooqfNsOUTNKVODa1P3
         PTN45JEUDX5ryNGIUqkhgtKc8XFdo/+oTyySGuqg3uFwlUdSxaTpU585qr39ieadfRlY
         VROWQxUpgWGw7Gkne7Ei2VW+NofLUBVZFtjkBDZeAbS23RdxiCRQga/sfRYTZIS2Sp/t
         R1Uw==
X-Gm-Message-State: AOJu0Yzx78wu37ml0bfoOV0HBB1AIyAqkBXg7LG+6J8CAl9TwVrf5uSt
	NzkdbAX70yDnDWwZIchFqz67vgHlxEnnPXkIHXeOlvTSZ60zx9sH/8HHQO0INXXNOZ50gfS5R9x
	q9Bee+eUROt7w1yu/66PpOOlvOLJwx+zmzFPN+gj2KNUbkz+aKhW/ePqbXKpjFw==
X-Received: by 2002:a19:2d0e:0:b0:50e:dc99:cda with SMTP id k14-20020a192d0e000000b0050edc990cdamr1413288lfj.24.1705920809422;
        Mon, 22 Jan 2024 02:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyTmUfVSX+vJoYJg0IKWMYbWKAZUBV/HESlmeaB1+ats3yxoOKYy9UhP5uqWmmXdb1IQmghw==
X-Received: by 2002:a19:2d0e:0:b0:50e:dc99:cda with SMTP id k14-20020a192d0e000000b0050edc990cdamr1413276lfj.24.1705920808966;
        Mon, 22 Jan 2024 02:53:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q21-20020a1709066b1500b00a2990007447sm13138964ejr.122.2024.01.22.02.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:53:28 -0800 (PST)
Message-ID: <e437050a-032c-462d-a415-1282adc820e1@redhat.com>
Date: Mon, 22 Jan 2024 11:53:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Re-enable custom fan curves after
 setting throttle_thermal_policy
Content-Language: en-US, nl
To: Luke Jones <luke@ljones.dev>
Cc: Andrei Sabalenka <mechakotik@gmail.com>, corentin.chary@gmail.com,
 ilpo.jarvinen@linux.intel.com, acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240115122315.10250-1-mechakotik@gmail.com>
 <e776db0e-2376-415b-8688-f166118d4007@redhat.com>
 <JQKB7S.8ATKNVGHLV1L@ljones.dev>
 <15f8da52-e413-4440-bd63-2ee8e96a340d@redhat.com>
 <PFDD7S.4NAT8RZ4C0PR2@ljones.dev>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <PFDD7S.4NAT8RZ4C0PR2@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luke,

On 1/16/24 20:43, Luke Jones wrote:
> 
> 
> On Tue, Jan 16 2024 at 11:25:41 +01:00:00, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Luke,
>>
>> On 1/15/24 21:25, Luke Jones wrote:
>>>
>>>
>>>  On Mon, Jan 15 2024 at 13:38:16 +01:00:00, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>  Hi,
>>>>
>>>>  On 1/15/24 13:22, Andrei Sabalenka wrote:
>>>>>   When changing throttle_thermal_policy, all the custom fan curves are getting disabled. This patch re-enables all the custom fan curves that were enabled before changing throttle_thermal_policy.
>>>>>
>>>>>   I believe it makes asus-wmi sysfs interface more convenient, as it allows userspace to manage fan curves independently from platform_profile and throttle_thermal_policy. At the kernel level, custom fan curves should not be tied to "power profiles" scheme in any way, as it gives the user less freedom of controlling them.
>>>>
>>>>  Setting a high performance power-profile typically also involves ramping up
>>>>  the fans harder. So I don't think this patch is a good idea.
>>>>
>>>>  If you really want this behavior then you can always re-enable the custom
>>>>  curve after changing the profile.
>>>>
>>>>  Luke, do you have any opinion on this?
>>>
>>>  I see some misconceptions that should be addressed:
>>>  1. ASUS themselves set separate fan curves per "platform profile", both standard and custom
>>>  2. fan curves are not tied to platform profiles, they are tied to the throttle_thermal_policy, and this is actually done in the acpi - so the code here is a mirror of that
>>>  3. platform-profiles are tied to throttle_thermal_policy
>>>
>>>  There is no lack of user control at all, a decent tool (like asusctl) can set fan curves without issues but it's perhaps not convenient for manually setting via a script etc.
>>>
>>>  The main reason that a curve is disabled for the policy being switched to is for safety. It was a paranoid choice I made at the time. The kernel (and acpi) can't guarantee that a user set a reasonable default for that policy so the safest thing is to force an explicit re-enable of it.
>>>
>>>  Having said that: I know that the curve was previously set for that profile/policy and in theory should be fine plus it is already used by the user, it is also not possible to set a curve for a different profile to the one a user is currently in -  this is forced in ACPI as you can set only the curve for the profile you are in (the kernel code also mirrors this).
>>>
>>>  So this patch should be fine.
>>>
>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>
>> So I just checked asus-wmi.c again and there seems to be only 1 custom
>> curve per fan, one curve for CPU one for GPU and one for MID.
> 
> I misread sorry. Yes this is correct. The ACPI only allows fetching the defaults for the currently loaded profile so this was a result of that.
> 
>> And while the custom curve may be fine for e.g. low-power mode,
>> that same custom curve may lead to overheating/throttling with
>> performance mode since performance mode typically requires
>> higher fan speeds.
>>
>> As you write yourself: 'ASUS themselves set separate fan curves per
>> "platform profile", both standard and custom', but there is only 1
>> custom/user curve (in the kernel), not 1 per platform-profile.
>>
>> So IMHO disabling the custom curve on profile switching is
>> the correct thing to do. Then userspace can do something like:
>>
> 
> Yes agreed. And that is indeed why I set them to off originally when changing profile.
> 
>> 1. Have per platform-profile custom curves in some tool
>> 2. Have that tool change (or monitor) platform-profile
>> 3. Load new custom profile based on the new platform-profile
>> 4. Enable the new (fitting to the new platform-profile)
>>    custom fan curve.
>>
>> I also see that fan_curve_get_factory_default() retrieves the
>> defaults for a *specific* thermal-policy / platform-profile
>>
>> So if a user somehow just enables custom-fancurves without
>> actually changing the curve then this patch would lead
>> to the following scenario:
>>
>> 1. Driver loads, lets assume the system boots in balanced
>> mode, balanced factory-default fan-curve is now loaded into
>> the custom fan-curve by fan_curve_check_present()
>>
>> 2. User calls fan_curve_enable_store() writing "1", because
>> reasons.
>>
>> 3. User changes platform-profile to performance,
>> throttle_thermal_policy_write() calls asus_wmi_set_devstate(
>> ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY) and the EC
>> sets fan curve to performance factory-default fan-curve.
>>
>> 4. Next throttle_thermal_policy_write() will now call
>> fan_curve_write() restoring the balanced factory-default
>> fan-curve even though we are in performance mode now.
>>
>> This seems undesirable to me.
>>
>> Restoring custom fan-curves automatically on platform-profile
>> change IMHO requires also storing a separate custom curve
>> per profile inside the kernel and populating all custom
>> curves with the factory defaults at boot. If I read what
>> you have written above this would also actually match
>> what you wrote above about ASUS using separate custom curves
>> per profile. If ASUS uses separate custom curves per profile
>> then IMHO so should Linux.
> 
> This is correct yes.
> 
>>
>> Note custom fan-curves per profile still means that the custom
>> curve will be overwritten when changing profiles, some new sysfs
>> interface would be necessary to write the non-active custom
>> curves so that the restored curve on profile switch can be
>> custom too on the first switch.
>>
>> (rather then having to switch to be able to write the custom
>> curve for a profile other then the currently active profile).
>>
>> Note this is not a 100% hard nack for this patch, but atm
>> I'm leaning towards a nack.
> 
> I revert my signed-off. This is a nack. Everything a user may want can be done in userspace.

Ok, I'm dropping this patch from the platfrom-driver-x86 patch-queue then.

Regards,

Hans




>>>>>   Signed-off-by: Andrei Sabalenka <mechakotik@gmail.com>
>>>>>   ---
>>>>>    drivers/platform/x86/asus-wmi.c | 29 ++++++++++++++++++++++-------
>>>>>    1 file changed, 22 insertions(+), 7 deletions(-)
>>>>>
>>>>>   diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>>>   index 18be35fdb..c2e38f6d8 100644
>>>>>   --- a/drivers/platform/x86/asus-wmi.c
>>>>>   +++ b/drivers/platform/x86/asus-wmi.c
>>>>>   @@ -3441,13 +3441,28 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>>>>            return -EIO;
>>>>>        }
>>>>>
>>>>>   -    /* Must set to disabled if mode is toggled */
>>>>>   -    if (asus->cpu_fan_curve_available)
>>>>>   -        asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
>>>>>   -    if (asus->gpu_fan_curve_available)
>>>>>   -        asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
>>>>>   -    if (asus->mid_fan_curve_available)
>>>>>   -        asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled = false;
>>>>>   +    /* Re-enable fan curves after profile change */
>>>>>   +    if (asus->cpu_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled) {
>>>>>   +        err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_CPU]);
>>>>>   +        if (err) {
>>>>>   +            pr_warn("Failed to re-enable CPU fan curve: %d\n", err);
>>>>>   +            return err;
>>>>>   +        }
>>>>>   +    }
>>>>>   +    if (asus->gpu_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled) {
>>>>>   +        err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_GPU]);
>>>>>   +        if (err) {
>>>>>   +            pr_warn("Failed to re-enable GPU fan curve: %d\n", err);
>>>>>   +            return err;
>>>>>   +        }
>>>>>   +    }
>>>>>   +    if (asus->mid_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled) {
>>>>>   +        err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_MID]);
>>>>>   +        if (err) {
>>>>>   +            pr_warn("Failed to re-enable MID fan curve: %d\n", err);
>>>>>   +            return err;
>>>>>   +        }
>>>>>   +    }
>>>>>
>>>>>        return 0;
>>>>>    }
>>>>
>>>
>>>
>>
> 
> 


