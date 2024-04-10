Return-Path: <linux-kernel+bounces-138278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA35389EF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9328232E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61A157E6E;
	Wed, 10 Apr 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTJ0MMb7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DB154BF6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742585; cv=none; b=ckz0lzvSV/kqTVlF4rJmfdL7VjC8+8JqoLTdwAcI75STcuXN98ntQ76ObATTmS0s2YOxGu+I3BCRlQl1HE4DOifKptoOx4Eh+hhxThn0zkgXxEMcjpy2PpY2/ZQ6pRZQZokiNH3mXzDZ0sevEReGXX5oHI7XhCDr/BbB1D1t1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742585; c=relaxed/simple;
	bh=klfDPrCvc98Pgiflt1Vg1y7iAn0sJnOfgOE6PhfLZ7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amWRz0DenLvP8HwqX/AI3SxdmyTqaxD82lGIzGDVNTDBoTJacVZ1U7p80yFPcSQe615gDtwZFbdV1YGw+dXw/tQTCnnG1bK+AZgzSA6I6CBuKCwXXLEKLXxRTPaYGpmXRnponM9EoAEchNtfsRqSf2U8zyqsjLP621CIzTde1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTJ0MMb7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pRXMt3aXZQoPiGdhsxvUmNv7PrrOysXS3/E/K5bS6E=;
	b=YTJ0MMb71lmit/2rB8SW/UmGI+ZEp0VGB58FM99WCn8JdF1V1FCxUmc1w9mXFFBjl115sm
	rPSnbZ59u/mc1oBXn5x0aMjhZwD7DCExj/VDRLlKy4bq7C5U/eePMOFHbO5VAWBcBy8UHl
	yPh1Edr83ap5h0xMq/HXUl2bNtRotoU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-KI9dcP8GMDmHazebheoaDQ-1; Wed, 10 Apr 2024 05:49:40 -0400
X-MC-Unique: KI9dcP8GMDmHazebheoaDQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69945d13e40so46616646d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712742580; x=1713347380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pRXMt3aXZQoPiGdhsxvUmNv7PrrOysXS3/E/K5bS6E=;
        b=G7p1Cq4DelXMKP0J9CQKxf4FMmR1URSX44Iudam131xSTHU1LWZ4VVrxmh8yRBALwe
         jiFjUwwKoWxkiEe2NrtruWyZeZRQiWxMULqFDiovc0qfERtCR+zG9bTfpVx1rb5zjKZK
         TxGwWtDUeNoD+CLkjbKdCcYyn8UlQyjtVMu5gXaEO03LqJ1O4kvHQbmTB12NF9zG1hBA
         4/M75HQ3ERHAhx4oo21JbGGpYpG7X3F72yYGCFsXcefFfn5ztcjRi1v8ZsSB7pU2Jjgp
         +Rj1JpYRUE3UMMIvkbOqkQnhZF9IoWROV/wISxAKyIzwYfwZfqCq11rM1Y7v9m+VELyf
         5j0g==
X-Forwarded-Encrypted: i=1; AJvYcCXmvO6cD3DK5/XQj6cFfuxx8laa1PnJQbE9jZHA/BdvDeLtBeQMi9FB3peZzEPsy1BvPi63n8bizZvE58dJ5ameFNhm1IXYuN7ht8qW
X-Gm-Message-State: AOJu0YzYc5aqdfjS6ktvb3QhKw2O1s+sgZa4jw+qB1RIk1zryNXJzNy5
	9vZbGj3/nb8dmj9pt16CzAwxAHvvx9F4vEfL/FwEaDwJm5norpp6WavWg0zblL5OEJBwFlusPCR
	nPf3ItfIdBberlEyTnAzWM4nCQz1OoeBIv17FDYJrOJKDCM+/vaQlmAtzX6aW
X-Received: by 2002:a0c:dd04:0:b0:69b:2c8f:7da6 with SMTP id u4-20020a0cdd04000000b0069b2c8f7da6mr1856229qvk.22.1712742580260;
        Wed, 10 Apr 2024 02:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiaAGsOOoZ72Rn+sbvYOnnJM94AhBx/sLlijNUMWUkj8HBIcUx4nI3IXaeoqT8rh8j5vlrlQ==
X-Received: by 2002:a0c:dd04:0:b0:69b:2c8f:7da6 with SMTP id u4-20020a0cdd04000000b0069b2c8f7da6mr1856216qvk.22.1712742579915;
        Wed, 10 Apr 2024 02:49:39 -0700 (PDT)
Received: from [192.168.9.29] (net-2-34-25-239.cust.vodafonedsl.it. [2.34.25.239])
        by smtp.gmail.com with ESMTPSA id do18-20020a056214097200b0069942d4cc06sm4574683qvb.115.2024.04.10.02.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 02:49:39 -0700 (PDT)
Message-ID: <47d8db3f-6f36-4004-a5a6-3e5de383f7d4@redhat.com>
Date: Wed, 10 Apr 2024 11:49:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fpga: region: add owner module and take its refcount
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Alan Tull <atull@opensource.altera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240403144611.65507-1-marpagan@redhat.com>
 <ZhTFPLWGkh0oRhL/@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZhTFPLWGkh0oRhL/@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-09 06:34, Xu Yilun wrote:
> On Wed, Apr 03, 2024 at 04:46:09PM +0200, Marco Pagani wrote:
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
>> Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Xu Yilun <yilun.xu@intel.com>
>> Reviewed-by: Russ Weight <russ.weight@linux.dev>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>
>> v4:
>> - Split out the swap between put_device() and mutex_unlock() while
>>   releasing the region to avoid potential use after release issues
>> v3:
>> - Add reviewed-by Russ Weight
>> v2:
>> - Fixed typo in the documentation sets -> set
>> - Renamed owner pointer get_br_owner -> br_owner
>> ---
>>  Documentation/driver-api/fpga/fpga-region.rst | 13 ++++++----
>>  drivers/fpga/fpga-region.c                    | 24 +++++++++++--------
>>  include/linux/fpga/fpga-region.h              | 13 +++++++---
>>  3 files changed, 32 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
>> index dc55d60a0b4a..77190a5ef330 100644
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
>> +automatically set the module that registers the FPGA region as the owner.
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
> 
> Why you swap the order? You didn't do that for fpga-mgr.

Ouch, it's a typo.

>>  
>>  .. kernel-doc:: drivers/fpga/fpga-region.c
>>     :functions: fpga_region_unregister
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index b364a929425c..d50ab1509989 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>>  	}
>>  
>>  	get_device(dev);
>> -	if (!try_module_get(dev->parent->driver->owner)) {
>> +	if (!try_module_get(region->br_owner)) {
>>  		put_device(dev);
>>  		mutex_unlock(&region->mutex);
>>  		return ERR_PTR(-ENODEV);
>> @@ -75,7 +75,7 @@ static void fpga_region_put(struct fpga_region *region)
>>  
>>  	dev_dbg(dev, "put\n");
>>  
>> -	module_put(dev->parent->driver->owner);
>> +	module_put(region->br_owner);
>>  	put_device(dev);
>>  	mutex_unlock(&region->mutex);
>>  }
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
>> +	region->br_owner = owner;
>>  
>>  	mutex_init(&region->mutex);
>>  	INIT_LIST_HEAD(&region->bridge_list);
>> @@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>  
>>  	return ERR_PTR(ret);
>>  }
>> -EXPORT_SYMBOL_GPL(fpga_region_register_full);
>> +EXPORT_SYMBOL_GPL(__fpga_region_register_full);
>>  
>>  /**
>> - * fpga_region_register - create and register an FPGA Region device
>> + * __fpga_region_register - create and register an FPGA Region device
>>   * @parent: device parent
>>   * @mgr: manager that programs this region
>>   * @get_bridges: optional function to get bridges to a list
>> + * @owner: owner module containing get_bridges function
>>   *
>>   * This simple version of the register function should be sufficient for most users.
>>   * The fpga_region_register_full() function is available for users that need to
>> @@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
>>   * Return: struct fpga_region or ERR_PTR()
>>   */
>>  struct fpga_region *
>> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>> -		     int (*get_bridges)(struct fpga_region *))
>> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>> +		       int (*get_bridges)(struct fpga_region *), struct module *owner)
>>  {
>>  	struct fpga_region_info info = { 0 };
>>  
>>  	info.mgr = mgr;
>>  	info.get_bridges = get_bridges;
>>  
>> -	return fpga_region_register_full(parent, &info);
>> +	return __fpga_region_register_full(parent, &info, owner);
>>  }
>> -EXPORT_SYMBOL_GPL(fpga_region_register);
>> +EXPORT_SYMBOL_GPL(__fpga_region_register);
>>  
>>  /**
>>   * fpga_region_unregister - unregister an FPGA region
>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> index 9d4d32909340..d175babc3d68 100644
>> --- a/include/linux/fpga/fpga-region.h
>> +++ b/include/linux/fpga/fpga-region.h
>> @@ -36,6 +36,7 @@ struct fpga_region_info {
>>   * @mgr: FPGA manager
>>   * @info: FPGA image info
>>   * @compat_id: FPGA region id for compatibility check.
>> + * @br_owner: module containing the get_bridges function
> 
> I'm a little confused that you call it br_owner, just because there is
> only one get_bridge() callback provided by low-level module. If we
> further have another callback, the name & all the doc would be a problem.
> And It is really the owner of the region module, not the bridge module.
> 
> Maybe just name it owner, or ops_owner?

Right, it makes sense to me. How about rg_ops_owner for symmetry with
the manager and bridge?


Thanks,
Marco



