Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348EB7E0A55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378338AbjKCUcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377822AbjKCUcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BA718B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699043466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUVZCuDlw1vrRsBXp616LcFSx5iLjv4rRMsKc8gpbRU=;
        b=cHvBcuFCXy4NA153MDL+JETakbCsPG7VQhmyPBMGiYYsSXrezcwU808cliuJ7nxtAyLdRc
        51ADIuUvrDXEDuCA86NTuvLx7t8IYrVCjDOnVMH6REJQXUnf+iApEYxlMCVoKhDSqoBD5c
        zKdM6yCRG3OJsDEjgToruo2WtOShJUw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-qNXd-u9eOI2y6kIHUR-gaw-1; Fri, 03 Nov 2023 16:31:05 -0400
X-MC-Unique: qNXd-u9eOI2y6kIHUR-gaw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9bea60bd1adso395875166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 13:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699043464; x=1699648264;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUVZCuDlw1vrRsBXp616LcFSx5iLjv4rRMsKc8gpbRU=;
        b=PwGHsTF4IpRxTwJRycSkdtWX6CrTUpmkQ2H7djzQDtFIlcto0Cu+A8zA6ACKdKkrjl
         hEXBOAjWuXO8C9140M5gk8EOhci0i6SRvP8mn0sdnpI2lU6FR84s4pvWJGww+EpRAWI1
         XvQmr3pHVhlseSl++JihMQe6GimufQEB8lqYK0vW8ZHyaduSGUEcVqtdMlQU9cJfhZXs
         Hl73ZjYx70VeovpWQgmQb2xdPTnVDuQ9vjxPrL4SGJZsAlYGGzP0nk3ZYJm7hvhnz2n6
         U+xDOOoABTRAOgHkBQZ19Pq3HrDKyU4iOBsUvvVUVguly8GJSTQilacmQwtoPZdg2a2c
         jolQ==
X-Gm-Message-State: AOJu0YxReck0vOYXdjDDugapz+PerNLkagcktzHcaO20DK9UX9RLr2AP
        mUXPuvv9F0U9KgT+nhrON+4lutkMhO6LxmrRdt3I363vtx8cvpDGrhHr7O6yL8ihAAFtWFMPFGB
        XmbbsXwt2hZ5uSbfztK4dBZI=
X-Received: by 2002:a17:906:259:b0:9dd:97aa:afcd with SMTP id 25-20020a170906025900b009dd97aaafcdmr1288471ejl.3.1699043464163;
        Fri, 03 Nov 2023 13:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESCr3u+/pSYYA4aGqwAoS8MR/r+TXJGwpgI5CLPVTeaK7VpdmtOCtaTjjMWwXW049xKLjE3g==
X-Received: by 2002:a17:906:259:b0:9dd:97aa:afcd with SMTP id 25-20020a170906025900b009dd97aaafcdmr1288459ejl.3.1699043463754;
        Fri, 03 Nov 2023 13:31:03 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709061cc700b0098921e1b064sm1249608ejh.181.2023.11.03.13.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 13:31:03 -0700 (PDT)
Message-ID: <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
Date:   Fri, 3 Nov 2023 21:31:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marco Pagani <marpagan@redhat.com>
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-30 09:32, Xu Yilun wrote:
> On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
>> Remove unnecessary module reference counting from the core components
>> of the subsystem. Low-level driver modules cannot be removed before
>> core modules since they use their exported symbols.
> 
> Could you help show the code for this conclusion?
> 
> This is different from what I remember, a module cannot be removed when
> its exported symbols are being used by other modules. IOW, the core
> modules cannot be removed when there exist related low-level driver
> modules. But the low-level driver modules could be removed freely
> without other protecting mechanism.
>

My understanding was that we wanted to remove module reference counting
from the fpga core and ease it from the responsibility of preventing
low-level driver modules from being unloaded. 

If we want to keep reference counting in the fpga core, we could add a
struct module *owner field in the struct fpga_manager_ops (and others
core *_ops) so that the low-level driver can set it to THIS_MODULE.
In this way, we can later use it in fpga_mgr_register() to bump up the
refcount of the low-level driver module by calling
try_module_get(mgr->mops->owner) directly when it registers the manager.
Finally, fpga_mgr_unregister() would call module_put(mgr->mops->owner)
to allow unloading the low-level driver module.

In this way, it would no longer be necessary to call try_module_get()
in fpga_mrg_get() since we could use a kref (included in the struct
fpga_manager) to do refcounting for the in-kernel API users. Only when
the kref reaches zero fpga_mgr_unregister() would succeed and put the
low-level driver module.

I think this approach would be safer since it would avoid the crash
that can currently happen if the low-level driver module is removed
right when executing try_module_get() in fpga_mrg_get(). The possible
caveat is that it would be required to call fpga_mgr_unregister()
before being able to remove the low-level driver module.

>>
>> For more context, refer to this thread:
>> https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
>>
>> Other changes:
>>
>> In  __fpga_bridge_get(): do a (missing ?) get_device() and bind the
> 
> I think get_device() is in (of)_fpga_bridge_get() -> class_find_device()
> and put_device() correspond to it.
>

You are right. I missed that one.
 
> But the code style here is rather misleading, the put_device() should be
> moved out to (of)_fpga_bridge_get().
>

Right, I'll improve the (of)_fpga_bridge_get() style for the next version.

>> image to the bridge only after the mutex has been acquired.
> 
> This is good to me.
> 
>>
>> In __fpga_mgr_get(): do a get_device(). Currently, get_device() is
>> called when allocating an image in fpga_image_info_alloc().
>> However, since there are still two (of_)fpga_mgr_get() functions
>> exposed by the core, I think they should behave as expected.
> 
> Same as fpga bridge.
> 
>>
>> In fpga_region_get() / fpga_region_put(): call get_device() before
>> acquiring the mutex and put_device() after having released the mutex
>> to avoid races.
> 
> Could you help elaborate more about the race?
> 

I accidentally misused the word race. My concern was that memory might
be released after the last put_device(), causing mutex_unlock() to be
called on a mutex that does not exist anymore. It should not happen
for the moment since the region does not use devres, but I think it
still makes the code more brittle.

> Thanks,
> Yilun
> 
>>
>> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-bridge.c | 24 +++++++-----------------
>>  drivers/fpga/fpga-mgr.c    |  8 +-------
>>  drivers/fpga/fpga-region.c | 14 ++++----------
>>  3 files changed, 12 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index a024be2b84e2..3bcc9c9849c5 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -58,30 +58,21 @@ EXPORT_SYMBOL_GPL(fpga_bridge_disable);
>>  static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>>  					     struct fpga_image_info *info)
>>  {
>> -	struct fpga_bridge *bridge;
>> -	int ret = -ENODEV;
>> -
>> -	bridge = to_fpga_bridge(dev);
>> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>>  
>> -	bridge->info = info;
>> +	get_device(dev);
>>  
>>  	if (!mutex_trylock(&bridge->mutex)) {
>> -		ret = -EBUSY;
>> -		goto err_dev;
>> +		dev_dbg(dev, "%s: FPGA Bridge already in use\n", __func__);
>> +		put_device(dev);
>> +		return ERR_PTR(-EBUSY);
>>  	}
>>  
>> -	if (!try_module_get(dev->parent->driver->owner))
>> -		goto err_ll_mod;
>> +	bridge->info = info;
>>  
>>  	dev_dbg(&bridge->dev, "get\n");
>>  
>>  	return bridge;
>> -
>> -err_ll_mod:
>> -	mutex_unlock(&bridge->mutex);
>> -err_dev:
>> -	put_device(dev);
>> -	return ERR_PTR(ret);
>>  }
>>  
>>  /**
>> @@ -93,7 +84,7 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>>   * Return:
>>   * * fpga_bridge struct pointer if successful.
>>   * * -EBUSY if someone already has a reference to the bridge.
>> - * * -ENODEV if @np is not an FPGA Bridge or can't take parent driver refcount.
>> + * * -ENODEV if @np is not an FPGA Bridge.
>>   */
>>  struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>>  				       struct fpga_image_info *info)
>> @@ -146,7 +137,6 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
>>  	dev_dbg(&bridge->dev, "put\n");
>>  
>>  	bridge->info = NULL;
>> -	module_put(bridge->dev.parent->driver->owner);
>>  	mutex_unlock(&bridge->mutex);
>>  	put_device(&bridge->dev);
>>  }
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 06651389c592..6c355eafd18f 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -670,14 +670,9 @@ static struct fpga_manager *__fpga_mgr_get(struct device *dev)
>>  
>>  	mgr = to_fpga_manager(dev);
>>  
>> -	if (!try_module_get(dev->parent->driver->owner))
>> -		goto err_dev;
>> +	get_device(&mgr->dev);
>>  
>>  	return mgr;
>> -
>> -err_dev:
>> -	put_device(dev);
>> -	return ERR_PTR(-ENODEV);
>>  }
>>  
>>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
>> @@ -727,7 +722,6 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>>   */
>>  void fpga_mgr_put(struct fpga_manager *mgr)
>>  {
>> -	module_put(mgr->dev.parent->driver->owner);
>>  	put_device(&mgr->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index b364a929425c..c299956cafdc 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -41,22 +41,17 @@ EXPORT_SYMBOL_GPL(fpga_region_class_find);
>>   * Return:
>>   * * fpga_region struct if successful.
>>   * * -EBUSY if someone already has a reference to the region.
>> - * * -ENODEV if can't take parent driver module refcount.
>>   */
>>  static struct fpga_region *fpga_region_get(struct fpga_region *region)
>>  {
>>  	struct device *dev = &region->dev;
>>  
>> +	get_device(dev);
>> +
>>  	if (!mutex_trylock(&region->mutex)) {
>>  		dev_dbg(dev, "%s: FPGA Region already in use\n", __func__);
>> -		return ERR_PTR(-EBUSY);
>> -	}
>> -
>> -	get_device(dev);
>> -	if (!try_module_get(dev->parent->driver->owner)) {
>>  		put_device(dev);
>> -		mutex_unlock(&region->mutex);
>> -		return ERR_PTR(-ENODEV);
>> +		return ERR_PTR(-EBUSY);
>>  	}
>>  
>>  	dev_dbg(dev, "get\n");
>> @@ -75,9 +70,8 @@ static void fpga_region_put(struct fpga_region *region)
>>  
>>  	dev_dbg(dev, "put\n");
>>  
>> -	module_put(dev->parent->driver->owner);
>> -	put_device(dev);
>>  	mutex_unlock(&region->mutex);
>> +	put_device(dev);
>>  }
>>  
>>  /**
>> -- 
>> 2.41.0
>>
> 

