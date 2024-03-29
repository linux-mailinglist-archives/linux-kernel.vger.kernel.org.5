Return-Path: <linux-kernel+bounces-123968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA9891071
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD47E1F22F21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB81E532;
	Fri, 29 Mar 2024 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcRVJLnS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6A17BA6;
	Fri, 29 Mar 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711676257; cv=none; b=ZNLxQWT3Jkg4hdlGyqcyVy2DyiYAZY9xFk1BxrHJz2z1A7afj3reFsu5VdCWO5FluKpUAAlJB3W/udi8YQOISDc0xdBrMosQVAfz9pzQ1U542nN5tIC7eQ1df5bV5E7ryzQIZlGMYNx+qW9JO/aA20ctpZ9M4sTnqachziGXZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711676257; c=relaxed/simple;
	bh=JbtAUyPT22AwxJqe3Ht5mIeULM921gwcPFoPfCYQBJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/bUp644kTVaE8dZWgpcaUjOciDdhfbFYUNbKNDGwdm6/PspQhYHPEXquuaslhIkLlyCLFpZ5nH3kVZe/n+QyEuJ4pKCvBF5/00s3xlO9q53cgLtPLOIJgJ1kf2VzIzt+cCIaOxa9L8qAAsHQNIGjnOnukYhb+pcEja8SDhPE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcRVJLnS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711676254; x=1743212254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JbtAUyPT22AwxJqe3Ht5mIeULM921gwcPFoPfCYQBJI=;
  b=mcRVJLnSmnVzmKZgOvXashN3nmWY/SwPOaRHqw/vxJ2wEekreEVVT7xy
   +ork8l8I6h3mjJs3UECXN7rshwVA0bm0bhV7gptdHLuE+34Vr44HQtjVz
   lBXGcuHLg2fKdvRfBPLaXz6T7yhvoyazmZoNRrhWPec7BVYGISAS+kUEj
   feiHhPtxdrcagFOhfD5mfYYu4QCOAPSnRHtcNBctx0pRXFrXhnAR8Frr8
   bugXjjIfjfDAUS5y8pTOqW+SF7JpSeXYN4ETqY2Ym0+4jwBiKH8a/OWYU
   6W5W1cFHehQlO2cxz1ZgEGZT/+gbNsVg/VvXDM8cVYJj0s129JqJUzWtB
   Q==;
X-CSE-ConnectionGUID: ffjTCIcOTyWYkwlWA5WDEA==
X-CSE-MsgGUID: fRiq+XiGQzmoo45MOUMXVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24357769"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24357769"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16659567"
Received: from sroy1-mobl1.amr.corp.intel.com (HELO [10.209.99.151]) ([10.209.99.151])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:37:34 -0700
Message-ID: <9e7a081f-b727-4ead-84b9-3c80530a1039@linux.intel.com>
Date: Thu, 28 Mar 2024 18:37:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328012336.145612-1-W_Armin@gmx.de>
 <20240328012336.145612-2-W_Armin@gmx.de>
 <b82ded95-d599-4ef7-b984-ac4d8a5c2370@linux.intel.com>
 <3e41e132-98b9-496d-987f-6838289926b6@gmx.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <3e41e132-98b9-496d-987f-6838289926b6@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/28/24 5:26 PM, Armin Wolf wrote:
> Am 28.03.24 um 03:58 schrieb Kuppuswamy Sathyanarayanan:
>
>> On 3/27/24 6:23 PM, Armin Wolf wrote:
>>> Multiple WMI events can be received concurrently, so multiple instances
>>> of xiaomi_wmi_notify() can be active at the same time. Since the input
>>> device is shared between those handlers, the key input sequence can be
>>> disturbed.
>> Since locking is needed for all notify related calls in all WMI drivers,
>> is there a generic way to add this support in WMI core driver? Like
>> defining some common function which will hold the lock and call
>> driver specific notify handler? I am just thinking aloud.. If it is not
>> feasible, then it is fine.
>
> Hi,
>
> actually, not all notify-related calls need locking. It just so happens that
> input drivers must protect their key sequence, other WMI drivers might not need
> to use any locking at all.

Got it.

>
> I would prefer if the WMI driver does the locking, so it can be optimized for
> each WMI driver.

Why not implement this support?

>
> Thanks,
> Armin Wolf
>
>>> Fix this by protecting the key input sequence with a mutex.
>>>
>>> Compile-tested only.
>>>
>>> Fixes: edb73f4f0247 ("platform/x86: wmi: add Xiaomi WMI key driver")
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>   drivers/platform/x86/xiaomi-wmi.c | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
>>> index 1f5f108d87c0..7efbdc111803 100644
>>> --- a/drivers/platform/x86/xiaomi-wmi.c
>>> +++ b/drivers/platform/x86/xiaomi-wmi.c
>>> @@ -2,8 +2,10 @@
>>>   /* WMI driver for Xiaomi Laptops */
>>>
>>>   #include <linux/acpi.h>
>>> +#include <linux/device.h>
>>>   #include <linux/input.h>
>>>   #include <linux/module.h>
>>> +#include <linux/mutex.h>
>>>   #include <linux/wmi.h>
>>>
>>>   #include <uapi/linux/input-event-codes.h>
>>> @@ -20,12 +22,21 @@
>>>
>>>   struct xiaomi_wmi {
>>>       struct input_dev *input_dev;
>>> +    struct mutex key_lock;    /* Protects the key event sequence */
>>>       unsigned int key_code;
>>>   };
>>>
>>> +static void xiaomi_mutex_destroy(void *data)
>>> +{
>>> +    struct mutex *lock = data;
>>> +
>>> +    mutex_destroy(lock);
>>> +}
>>> +
>>>   static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>>>   {
>>>       struct xiaomi_wmi *data;
>>> +    int ret;
>>>
>>>       if (wdev == NULL || context == NULL)
>>>           return -EINVAL;
>>> @@ -35,6 +46,11 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>>>           return -ENOMEM;
>>>       dev_set_drvdata(&wdev->dev, data);
>>>
>>> +    mutex_init(&data->key_lock);
>>> +    ret = devm_add_action_or_reset(&wdev->dev, xiaomi_mutex_destroy, &data->key_lock);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>>       data->input_dev = devm_input_allocate_device(&wdev->dev);
>>>       if (data->input_dev == NULL)
>>>           return -ENOMEM;
>>> @@ -59,10 +75,12 @@ static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
>>>       if (data == NULL)
>>>           return;
>>>
>>> +    mutex_lock(&data->key_lock);
>>>       input_report_key(data->input_dev, data->key_code, 1);
>>>       input_sync(data->input_dev);
>>>       input_report_key(data->input_dev, data->key_code, 0);
>>>       input_sync(data->input_dev);
>>> +    mutex_unlock(&data->key_lock);
>>>   }
>>>
>>>   static const struct wmi_device_id xiaomi_wmi_id_table[] = {
>>> -- 
>>> 2.39.2
>>>
>>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


