Return-Path: <linux-kernel+bounces-135671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6189C98E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58991C22308
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B4D142640;
	Mon,  8 Apr 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXFNc0sx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6B3BBD4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593934; cv=none; b=gaL3knDVPpsjtNOe7d2AWeRD2a8udGRZV1LdUClasp+TBTSSXJhGQFxYxtZL56iRdF53Ji7tKspxY9t0Rvw306gEfisMxjBkB4YlaqI23po7EFtnagq9q2NGTaKFAU9mzrioFc2qGBK7Y1D5LZG9rZ+EkfIVEg7yDtlnc3xQmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593934; c=relaxed/simple;
	bh=IM2PmEen9JbrBMi5K5aT/byAFBBt1UEiEK7PZPTPAtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbOQN2JRnEKlHUHakJXxrnYBeq9W6ai39EcZp749+WkS62Kqylrdx/w1dqMzW3hMgLUFo2BFU25+KJswE2P66dNYyJuTnhlR+8KJwldwPie6CsZ313UMLLG641aLcfnT9q/Z6AWsFZWc418yBk3Y/bma0WlclRtHmwZe449npEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXFNc0sx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712593931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljcKnbxjo9t71e4KMWvMpt4jeYhvFYvpjGCo4iNu8rE=;
	b=ZXFNc0sxHdBokcDmnamgOKo72mi4HWpalAzhOt5yWf3BiZjs+o1hmpTcVG0+Emiu2HDs5r
	sGbxOAN83h3ZvL72Ts5sYXIQlrIrHoLcW+vjhS2W8I6SZPbDO7ZvCk+r+ZHcKd6++ff0Dv
	ulu/2/H3xKKCZc6aSpKi7rvQ0MBlTjw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-WK4yHT6EN-OC4SYaH24AMw-1; Mon, 08 Apr 2024 12:32:10 -0400
X-MC-Unique: WK4yHT6EN-OC4SYaH24AMw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-516dc3ada5dso1671498e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 09:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593925; x=1713198725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljcKnbxjo9t71e4KMWvMpt4jeYhvFYvpjGCo4iNu8rE=;
        b=I5N5Q2zpRuOzEaYyn+JVVwZbgeznHSnZobZ2MwNuYP4I9MneaSUvnwrIF7OBnxfSgA
         sXbGGsLRn9zVW7xoLWb/XbiPZaSK8biOiocBQshSH5h1WEJtQ12AmVwB42kECa5vgo3u
         2vBs+IehSFoqs8qzHZmz7JC4/zsz04JBjG1VJCZtRdfSaEAscghFrbFJnHD/M5AYYbTn
         mMvpmwHEGub6Uor9Ss4qcv+LRnqzdcyomGzEksqZv0TfTTwbLD5nflksc+Ek345XqjGP
         e68MOirrquEQE3q+BJ52fq1cnIQyqe0GvmlqrqnlXnH3w1WWz5LF8H3ZqHeSo+/Y6uqI
         FIqA==
X-Forwarded-Encrypted: i=1; AJvYcCUlSw+AhXPSu5TT+lGD/qki2eH5f8Stu2j2QVAu/35/t7swHA9yCs6kjXTPNjMTVy+53WzZbkQKUS2NHigu/bXCMHogHVikbJ9bRAKb
X-Gm-Message-State: AOJu0YxG6e/CX0q7tMie97XzoEPIMv7HlI9oTIpC3H4QSADxw9mHLRID
	QlK6FYjcwN7M+CVImFLkEcuewX5BBMj3IfnnzzatMBVjATiGqmyafRptg2jFSfa+rsZkkPq6CwS
	/FYu1+ntkvmITdSmH8ASYBbQ0O8BhwndCCwCLSHfTPUJYD95o78SD4jeRcLYRRg==
X-Received: by 2002:a05:6512:3c8e:b0:516:a8f6:3863 with SMTP id h14-20020a0565123c8e00b00516a8f63863mr8477630lfv.30.1712593925057;
        Mon, 08 Apr 2024 09:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWIQymYEjSKCxfK3nxCFMBtH/777p/hSJiL2cY7x4i08UnxTjELKkUTIuGvzvvNlU0uFkbeQ==
X-Received: by 2002:a05:6512:3c8e:b0:516:a8f6:3863 with SMTP id h14-20020a0565123c8e00b00516a8f63863mr8477598lfv.30.1712593924670;
        Mon, 08 Apr 2024 09:32:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id es9-20020a056402380900b0056e598155fasm1786767edb.64.2024.04.08.09.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 09:32:04 -0700 (PDT)
Message-ID: <b53104be-2443-4832-9bb0-c0bec64e72d8@redhat.com>
Date: Mon, 8 Apr 2024 18:32:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] platform/x86: asus-wmi: add support for 2024 ROG
 Mini-LED
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D. Jones" <luke@ljones.dev>
Cc: corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240404001652.86207-1-luke@ljones.dev>
 <20240404001652.86207-2-luke@ljones.dev>
 <590fea48-ac39-4db4-47c5-366a6814c9b3@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <590fea48-ac39-4db4-47c5-366a6814c9b3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/4/24 11:33 AM, Ilpo Järvinen wrote:
> On Thu, 4 Apr 2024, Luke D. Jones wrote:
> 
>> Support the 2024 mini-led backlight and adjust the related functions
>> to select the relevant dev-id. Also add `available_mini_led_mode` to the
>> platform sysfs since the available mini-led levels can be different.
>>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>  .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
>>  drivers/platform/x86/asus-wmi.c               | 96 +++++++++++++++++--
>>  include/linux/platform_data/x86/asus-wmi.h    |  1 +
>>  3 files changed, 95 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> index 8a7e25bde085..ef1ac1a20a71 100644
>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>> @@ -126,6 +126,14 @@ Description:
>>  		Change the mini-LED mode:
>>  			* 0 - Single-zone,
>>  			* 1 - Multi-zone
>> +			* 2 - Multi-zone strong (available on newer generation mini-led)
>> +
>> +What:		/sys/devices/platform/<platform>/available_mini_led_mode
>> +Date:		Apr 2024
>> +KernelVersion:	6.10
>> +Contact:	"Luke Jones" <luke@ljones.dev>
>> +Description:
>> +		List the available mini-led modes.
>>  
>>  What:		/sys/devices/platform/<platform>/ppt_pl1_spl
>>  Date:		Jun 2023
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index 3f07bbf809ef..aa2a3b402e33 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -126,6 +126,17 @@ module_param(fnlock_default, bool, 0444);
>>  #define ASUS_SCREENPAD_BRIGHT_MAX 255
>>  #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
>>  
>> +#define ASUS_MINI_LED_MODE_MASK		0x03
>> +/* Standard modes for devices with only on/off */
>> +#define ASUS_MINI_LED_OFF		0x00
>> +#define ASUS_MINI_LED_ON		0x01
>> +/* New mode on some devices, define here to clarify remapping later */
>> +#define ASUS_MINI_LED_STRONG_MODE	0x02
>> +/* New modes for devices with 3 mini-led mode types */
>> +#define ASUS_MINI_LED_2024_WEAK		0x00
>> +#define ASUS_MINI_LED_2024_STRONG	0x01
>> +#define ASUS_MINI_LED_2024_OFF		0x02
>> +
>>  /* Controls the power state of the USB0 hub on ROG Ally which input is on */
>>  #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
>>  /* 300ms so far seems to produce a reliable result on AC and battery */
>> @@ -288,7 +299,7 @@ struct asus_wmi {
>>  	bool battery_rsoc_available;
>>  
>>  	bool panel_overdrive_available;
>> -	bool mini_led_mode_available;
>> +	u32 mini_led_dev_id;
>>  
>>  	struct hotplug_slot hotplug_slot;
>>  	struct mutex hotplug_lock;
>> @@ -2108,13 +2119,33 @@ static ssize_t mini_led_mode_show(struct device *dev,
>>  				   struct device_attribute *attr, char *buf)
>>  {
>>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>> -	int result;
>> +	u32 value;
>> +	int err;
>>  
>> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
>> -	if (result < 0)
>> -		return result;
>> +	err = asus_wmi_get_devstate(asus, asus->mini_led_dev_id, &value);
>> +	if (err < 0)
>> +		return err;
>> +	value = value & ASUS_MINI_LED_MODE_MASK;
>>  
>> -	return sysfs_emit(buf, "%d\n", result);
>> +	/*
>> +	 * Remap the mode values to match previous generation mini-led. The last gen
>> +	 * WMI 0 == off, while on this version WMI 2 ==off (flipped).
>> +	 */
>> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
>> +		switch (value) {
>> +		case ASUS_MINI_LED_2024_WEAK:
>> +			value = ASUS_MINI_LED_ON;
>> +			break;
>> +		case ASUS_MINI_LED_2024_STRONG:
>> +			value = ASUS_MINI_LED_STRONG_MODE;
>> +			break;
>> +		case ASUS_MINI_LED_2024_OFF:
>> +			value = ASUS_MINI_LED_OFF;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return sysfs_emit(buf, "%d\n", value);
>>  }
>>  
>>  static ssize_t mini_led_mode_store(struct device *dev,
>> @@ -2130,11 +2161,32 @@ static ssize_t mini_led_mode_store(struct device *dev,
>>  	if (result)
>>  		return result;
>>  
>> -	if (mode > 1)
>> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE &&
>> +		mode > ASUS_MINI_LED_ON)
>> +		return -EINVAL;
>> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2 &&
>> +		mode > ASUS_MINI_LED_STRONG_MODE)
> 
> The if condition continations should not be indented to the same level as 
> its statement block because it confuses the reader. Hans might be able to 
> fix this while applying though so I'm not sure if it's necessary to send a 
> new version just because of this.

Luke, thank you for the patches.

Ilpo, thank you for all the reviews.

I've fixed this small issue up while merging this and pushed out this
entire series to my review-hans branch.

Regards,

Hans



