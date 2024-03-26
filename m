Return-Path: <linux-kernel+bounces-119734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4513788CC89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFB41F331F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D513C9D6;
	Tue, 26 Mar 2024 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6FCbg14"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D413C91F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479545; cv=none; b=D2y7b3eL6YwmmMglVnaRHR86NFmjuQmj5JThkAzVORx08xGnyUm/UfUPDBsWblT5nel2dYZ8oGwdWMOyen1rynUmlSk+JuD5sXy1pr2eq8Rs1zpFT2GiQAIpZ/NymOebkzwUkZiheCZ0gHd4KXgA4bqioQkBVACndDzeR2QLTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479545; c=relaxed/simple;
	bh=nzlWsc/uDBEtSoEPDmhVs0OiVWzdIGK9LtPb8FUS+30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX8ZZfZrTWaWh8ZE5hnLua/CBN7wN+4sYS6IFq6BsV77dmjlbrxVI53yn5k1gSvPlOZBBBF2JpIOsmTWJ4XwYVR2e6k+V153F3vHpjYd2fRQnGTP26Rh4wlwUiTZ3p3+sGWrYszpL2iapMC18R0E6gQk183ysM0gR3prljz/Wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6FCbg14; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711479542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQIrddOl3QUoZaT2l/FFu3ki6nhY9Dj9MjNzIjnSbds=;
	b=D6FCbg14QN9Z1LJTrpy0O9jAbqOiMonO3nxLDCCPGF/0E1XYjawQl0cUq7/mEagVybOJwu
	1U4VybEhxKiJMFT0rJv3rlR37q1pHuMJARK8xaiZY9cQHQxNjWJehHfNkjVPGwvYfUjbuU
	UqibWzDrrPxnq1JTwWZS6Fvt7q/cut0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-oR1XN4hvNhG2TWSB6hCfVw-1; Tue, 26 Mar 2024 14:58:59 -0400
X-MC-Unique: oR1XN4hvNhG2TWSB6hCfVw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c3cef6224dso1427921b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479538; x=1712084338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQIrddOl3QUoZaT2l/FFu3ki6nhY9Dj9MjNzIjnSbds=;
        b=Mhgq4U1ytuERihLMezmKaTt9QmsdqMSbOZKzmh6vt0B9LhmFK3wmzEwnoHd9P9PEPP
         LYtnqCmU1CJneNF5qAzaAu0C+/T8YXqhVwaNs8g/Pk028UFvxKhIkHVE1aT7aIJg/V5x
         IzdSUfDXTzwJ44CWGGFgdDt2wCu74CFd3mnlSF3X1S61PtF+BicN0K3J6JM9ycpiTpcF
         ZbL4schypVZfPMjbW2hevNI5MG83g44rqo4RYdOi/zBY/TfwXHRgcNhSXdQ5ZVzz3mjs
         rLpHIoXZOWhuGHhK+4IhRgumQq4suCNPx3jgSe3nELBWHXB8jYAPlE8bjp041xowWScr
         to4g==
X-Forwarded-Encrypted: i=1; AJvYcCW1AQMDMbHduSLwj1ply8B92+xFqfWtvbiWuh6jT70kTc9gu5tZ2nW7/q9bM5xmToZ+NUU3uf1degFHXRwV7AEdNJUmEUIKoulqeV7c
X-Gm-Message-State: AOJu0YwN8EDNaYAMIgZa56leNbLJRdamlyfjhG+mRulXw7zgr5BByCi/
	nD6g1XJV4cbr6w3hqL2aAQnCHCmDM7JD4oPVH7vhTAGnsoNCH6tRclhEQ95dzpVg6jTjUiuOphk
	+yCgVL20UUnFFdXoWSb/fuCFJtHCfC5t/0OdIYVuybO4hzwMS2LQobcE++bfH
X-Received: by 2002:a05:6808:201a:b0:3c3:8822:dc36 with SMTP id q26-20020a056808201a00b003c38822dc36mr477652oiw.28.1711479538556;
        Tue, 26 Mar 2024 11:58:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrik+AkTkIE9LjyOL97tsR5AKnWXtxMce6KS0OU3DQAjEkRYoZ9yMnGkVi5vEp8AiJwCmJyw==
X-Received: by 2002:a05:6808:201a:b0:3c3:8822:dc36 with SMTP id q26-20020a056808201a00b003c38822dc36mr477630oiw.28.1711479538296;
        Tue, 26 Mar 2024 11:58:58 -0700 (PDT)
Received: from [192.168.9.34] (net-2-34-30-89.cust.vodafonedsl.it. [2.34.30.89])
        by smtp.gmail.com with ESMTPSA id eo7-20020a05622a544700b00431532ced95sm2620960qtb.27.2024.03.26.11.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 11:58:58 -0700 (PDT)
Message-ID: <befc8ccf-0661-4c6f-b262-3dab3c34e0be@redhat.com>
Date: Tue, 26 Mar 2024 19:58:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: region: add owner module and take its refcount
To: Russ Weight <russ.weight@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Alan Tull <atull@opensource.altera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fpga@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240322171931.233925-1-marpagan@redhat.com>
 <20240326172854.h6gww3mqlq63kxbp@4VRSMR2-DT.corp.robot.car>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20240326172854.h6gww3mqlq63kxbp@4VRSMR2-DT.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-26 18:28, Russ Weight wrote:
> 
> On Fri, Mar 22, 2024 at 06:19:30PM +0100, Marco Pagani wrote:
>> The current implementation of the fpga region assumes that the low-level
>> module registers a driver for the parent device and uses its owner pointer
>> to take the module's refcount. This approach is problematic since it can
>> lead to a null pointer dereference while attempting to get the region
>> during programming if the parent device does not have a driver.
>>
>> To address this problem, add a module owner pointer to the fpga_region
>> struct and use it to take the module's refcount. Modify the functions for
>> registering a region to take an additional owner module parameter and
>> rename them to avoid conflicts. Use the old function names for helper
>> macros that automatically set the module that registers the region as the
>> owner. This ensures compatibility with existing low-level control modules
>> and reduces the chances of registering a region without setting the owner.
>>
>> Also, update the documentation to keep it consistent with the new interface
>> for registering an fpga region.
>>
>> Other changes: unlock the mutex before calling put_device() in
>> fpga_region_put() to avoid potential use after release issues.
>>
>> Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Xu Yilun <yilun.xu@intel.com>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  Documentation/driver-api/fpga/fpga-region.rst | 13 ++++++----
>>  drivers/fpga/fpga-region.c                    | 26 +++++++++++--------
>>  include/linux/fpga/fpga-region.h              | 13 +++++++---
>>  3 files changed, 33 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
>> index dc55d60a0b4a..3aff5199b6d8 100644
>> --- a/Documentation/driver-api/fpga/fpga-region.rst
>> +++ b/Documentation/driver-api/fpga/fpga-region.rst
>> @@ -46,13 +46,16 @@ API to add a new FPGA region
>>  ----------------------------
>>  
>>  * struct fpga_region - The FPGA region struct
>> -* struct fpga_region_info - Parameter structure for fpga_region_register_full()
>> -* fpga_region_register_full() -  Create and register an FPGA region using the
>> +* struct fpga_region_info - Parameter structure for __fpga_region_register_full()
>> +* __fpga_region_register_full() -  Create and register an FPGA region using the
>>    fpga_region_info structure to provide the full flexibility of options
>> -* fpga_region_register() -  Create and register an FPGA region using standard
>> +* __fpga_region_register() -  Create and register an FPGA region using standard
>>    arguments
>>  * fpga_region_unregister() -  Unregister an FPGA region
>>  
>> +Helper macros ``fpga_region_register()`` and ``fpga_region_register_full()``
>> +automatically sets the module that registers the FPGA region as the owner.
> 
> s/sets/set/

Nice catch.

> 
>> +
>>  The FPGA region's probe function will need to get a reference to the FPGA
>>  Manager it will be using to do the programming.  This usually would happen
>>  during the region's probe function.
>> @@ -82,10 +85,10 @@ following APIs to handle building or tearing down that list.
>>     :functions: fpga_region_info
>>  
>>  .. kernel-doc:: drivers/fpga/fpga-region.c
>> -   :functions: fpga_region_register_full
>> +   :functions: __fpga_region_register
>>  
>>  .. kernel-doc:: drivers/fpga/fpga-region.c
>> -   :functions: fpga_region_register
>> +   :functions: __fpga_region_register_full
>>  
>>  .. kernel-doc:: drivers/fpga/fpga-region.c
>>     :functions: fpga_region_unregister
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index b364a929425c..f8bbda024d59 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>>  	}
>>  
>>  	get_device(dev);
>> -	if (!try_module_get(dev->parent->driver->owner)) {
>> +	if (!try_module_get(region->get_br_owner)) {
>>  		put_device(dev);
>>  		mutex_unlock(&region->mutex);
>>  		return ERR_PTR(-ENODEV);
>> @@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
>>  
>>  	dev_dbg(dev, "put\n");
>>  
>> -	module_put(dev->parent->driver->owner);
>> -	put_device(dev);
>> +	module_put(region->get_br_owner);
>>  	mutex_unlock(&region->mutex);
>> +	put_device(dev);
>>  }
>>  
>>  /**
>> @@ -181,14 +181,16 @@ static struct attribute *fpga_region_attrs[] = {
>>  ATTRIBUTE_GROUPS(fpga_region);
>>  
>>  /**
>> - * fpga_region_register_full - create and register an FPGA Region device
>> + * __fpga_region_register_full - create and register an FPGA Region device
>>   * @parent: device parent
>>   * @info: parameters for FPGA Region
>> + * @owner: owner module containing the get_bridges function
>>   *
>>   * Return: struct fpga_region or ERR_PTR()
>>   */
>>  struct fpga_region *
>> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
>> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
>> +			    struct module *owner)
>>  {
>>  	struct fpga_region *region;
>>  	int id, ret = 0;
>> @@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>  	region->compat_id = info->compat_id;
>>  	region->priv = info->priv;
>>  	region->get_bridges = info->get_bridges;
>> +	region->get_br_owner = owner;
> 
> get_* implies a function. Maybe this would be better called br_owner?

You are right. I will change it to br_owner in v2.

> 
> - Russ
> 

[ ... ]
Thanks,
Marco


