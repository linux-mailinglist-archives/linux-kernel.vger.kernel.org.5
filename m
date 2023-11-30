Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD027FED21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjK3Km7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjK3Kmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DC1D6C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701340977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZ1Pvc4c3F7Q6rOgmqORqJyTcv5oSL8c+4FiyLvo39c=;
        b=ersfTt86mLEN7HBxjPZTxp53CO/6N6FQO/w6RVvoqxqN4zHPua80QnO5zgqexK8GDRCa4J
        xjvzxCpgXNiioxTs00jufBv0Zn9Jo+5zFA8CSHtn0GiKaFFmGaeAevv0CND9Z5qSQqRPdA
        JVQCg13gWVZbXxKwGdFOn4zQCKrAyX0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-ieeTxCG4PpyQDgUYJsHWAw-1; Thu, 30 Nov 2023 05:42:41 -0500
X-MC-Unique: ieeTxCG4PpyQDgUYJsHWAw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bb9ed52deso826754e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340959; x=1701945759;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ1Pvc4c3F7Q6rOgmqORqJyTcv5oSL8c+4FiyLvo39c=;
        b=FSUOaUi8ZTR3NZzOH74r55aSwzgRVBvWmuZ4N/Wn0uaagqMwGc1qt2RxWZcAuekGNS
         L1uVPKNVulLX7AxAXJudD/Swsj17wsxrNt0Xy+RRQieRQhrz61InrQpZVDbXe2SLUauo
         Lt4X/DMUE1NJ4CXo5E32sBwCuVorr3AomzW6J/GCHq2WVFEb8DbXoWE5EHRQidhjGgij
         pd29OVoL3BxUkyqJVYIHrO7x9JNBgnG533DzGAOhQCiQP8Sj5CCx4H2OVQuyyMf63eWO
         2qx3oPdnpyrOFqNGitmojzBrJZsVIIx9loWv8Jm2xQPcSROhP/QpFGwIOfJPm4sgXuL1
         g0hQ==
X-Gm-Message-State: AOJu0YzblEk9/O4xcsKq22YnoiuztOlQ7F4Od/kHyo5KMo2JCgAQCjU7
        PA87GmRChTmpll0NuO6oHBF3JcyKoOvwEz/Qh9rH32OdRqLoNj2fp725PPmtfP++T/+GUCIdCJU
        AHbww/BpJEqfAMiuNANI5H2PwgqiG8Pg=
X-Received: by 2002:a05:6512:39c5:b0:50b:caed:71f5 with SMTP id k5-20020a05651239c500b0050bcaed71f5mr1675851lfu.6.1701340959121;
        Thu, 30 Nov 2023 02:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+4iQXCCZBlJckrLPtfF30/I0+ZNGOYW/SKU86jNTI4+7W2JATdzHLDiNH16XXm3B3+/4aAQ==
X-Received: by 2002:a05:6512:39c5:b0:50b:caed:71f5 with SMTP id k5-20020a05651239c500b0050bcaed71f5mr1675827lfu.6.1701340958759;
        Thu, 30 Nov 2023 02:42:38 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-30-38.cust.vodafonedsl.it. [2.34.30.38])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b00332cfd83b8dsm1164223wrs.96.2023.11.30.02.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 02:42:38 -0800 (PST)
Message-ID: <7004d215-5185-4cce-a51e-42e131a30453@redhat.com>
Date:   Thu, 30 Nov 2023 11:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marco Pagani <marpagan@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] fpga: add a module owner field to fpga_manager
 and fpga_manager_ops
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231124162807.238724-1-marpagan@redhat.com>
 <20231124162807.238724-2-marpagan@redhat.com>
 <ZWG6Tg0egX6Cy9j5@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <ZWG6Tg0egX6Cy9j5@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-25 10:11, Xu Yilun wrote:
> On Fri, Nov 24, 2023 at 05:28:06PM +0100, Marco Pagani wrote:
>> Add a module *owner field to the fpga_manager_ops and fpga_manager
>> structs to protect the fpga manager against the unloading of the
>> low-level control module while someone is holding a reference to the
>> manager device. Low-level control modules should statically set the
>> owner field of the fpga_manager_ops struct to THIS_MODULE. Then, when
>> the manager is registered using fpga_mgr_register(), the value is copied
>> into the owner field of the fpga_manager struct (that contains the
>> device context). In this way, the manager can later use it in
>> fpga_mgr_get() to take the low-level module's refcount. To prevent races
>> while unloading the low-level control module, fpga_mgr_get() and part of
>> the fpga_mgr_unregister() methods are protected with a mutex.
>>
>> Other changes: move put_device() from __fpga_mgr_get() to fpga_mgr_get()
>> and of_fpga_mgr_get() to improve code clarity.
>>
>> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-mgr.c       | 56 +++++++++++++++++++++++++----------
>>  include/linux/fpga/fpga-mgr.h |  4 +++
>>  2 files changed, 44 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 06651389c592..608605d59860 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -21,6 +21,8 @@
>>  static DEFINE_IDA(fpga_mgr_ida);
>>  static const struct class fpga_mgr_class;
>>  
>> +static DEFINE_MUTEX(mgr_lock);
>> +
>>  struct fpga_mgr_devres {
>>  	struct fpga_manager *mgr;
>>  };
>> @@ -667,17 +669,15 @@ ATTRIBUTE_GROUPS(fpga_mgr);
>>  static struct fpga_manager *__fpga_mgr_get(struct device *dev)
>>  {
>>  	struct fpga_manager *mgr;
>> +	struct module *owner;
>>  
>>  	mgr = to_fpga_manager(dev);
>> +	owner = mgr->owner;
>>  
>> -	if (!try_module_get(dev->parent->driver->owner))
>> -		goto err_dev;
>> +	if (owner && !try_module_get(owner))
> 
> No need to test owner == NULL, try_module_get() does this.

You are right. I'll remove it in the next version.

> 
>> +		mgr = ERR_PTR(-ENODEV);
>>  
>>  	return mgr;
>> -
>> -err_dev:
>> -	put_device(dev);
>> -	return ERR_PTR(-ENODEV);
>>  }
>>  
>>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
>> @@ -693,12 +693,22 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
>>   */
>>  struct fpga_manager *fpga_mgr_get(struct device *dev)
>>  {
>> -	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
>> -						   fpga_mgr_dev_match);
>> +	struct fpga_manager *mgr = ERR_PTR(-ENODEV);
>> +	struct device *mgr_dev;
>> +
>> +	mutex_lock(&mgr_lock);
>> +
>> +	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
>>  	if (!mgr_dev)
>> -		return ERR_PTR(-ENODEV);
>> +		goto out;
>> +
>> +	mgr = __fpga_mgr_get(mgr_dev);
>> +	if (IS_ERR(mgr))
>> +		put_device(mgr_dev);
>>  
>> -	return __fpga_mgr_get(mgr_dev);
>> +out:
>> +	mutex_unlock(&mgr_lock);
>> +	return mgr;
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_get);
>>  
>> @@ -711,13 +721,22 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
>>   */
>>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>>  {
>> -	struct device *dev;
>> +	struct fpga_manager *mgr = ERR_PTR(-ENODEV);
>> +	struct device *mgr_dev;
>> +
>> +	mutex_lock(&mgr_lock);
>> +
>> +	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
>> +	if (!mgr_dev)
>> +		goto out;
>>  
>> -	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
>> -	if (!dev)
>> -		return ERR_PTR(-ENODEV);
>> +	mgr = __fpga_mgr_get(mgr_dev);
>> +	if (IS_ERR(mgr))
>> +		put_device(mgr_dev);
>>  
>> -	return __fpga_mgr_get(dev);
>> +out:
>> +	mutex_unlock(&mgr_lock);
>> +	return mgr;
>>  }
>>  EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>>  
>> @@ -727,7 +746,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>>   */
>>  void fpga_mgr_put(struct fpga_manager *mgr)
>>  {
>> -	module_put(mgr->dev.parent->driver->owner);
>> +	module_put(mgr->owner);
>>  	put_device(&mgr->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>> @@ -806,6 +825,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>>  
>>  	mgr->name = info->name;
>>  	mgr->mops = info->mops;
>> +	mgr->owner = info->mops->owner;
>>  	mgr->priv = info->priv;
>>  	mgr->compat_id = info->compat_id;
>>  
>> @@ -888,7 +908,11 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>>  	 */
>>  	fpga_mgr_fpga_remove(mgr);
>>  
>> +	mutex_lock(&mgr_lock);
>> +
>>  	device_unregister(&mgr->dev);
>> +
>> +	mutex_unlock(&mgr_lock);
> 
> Why this part should be protected rather than the whole
> fpga_mgr_unregister()?
>

Protecting the fpga_remove() op seems unnecessary to me because it
does not affect the manager device's lifetime. Moreover, it may hold
the mutex for a long time since it was intended to interact with the
hardware to put it in a specific state before removing the driver.

> I feel the scope of the protection is unclear to me in this patch. What
> data should be protected from concurrent access by this mutex? From the
> code seems the racing of mgr dev should be protected but apparently it
> doesn't have to.

The mutex is there to ensure the lifetime of the manager device and
its context (struct fpga_manager) if fpga_mgr_get() happens to run
concurrently with the removal of the low-level module.

> 
> And with this mutex, the get/put/unregister() for one mgr should be
> exclusive with another mgr, but that also seems not necessary.
> 

I decided to use a static mutex because I thought putting the mutex
in the manager's context would be unsafe since its life would be tied
to the manager's life. For instance, consider the following sequence:

- A removes the low-level control module, and delete_module progresses
up to the point when it calls the module's exit function, which in turn
calls fpga_mgr_unregister().

- fpga_mgr_unregister() takes the mutex but gets descheduled before
completing the unregistering of the manager device.

- Meanwhile, B wants to get the manager (it is still there) and calls
fpga_mgr_get(), which tries to take the mutex but gets suspended since
it is held by A.

- A resumes and fpga_mgr_unregister() releases the manager device and
its context, including the mutex on which B is suspended.

We could mitigate this specific case using mutex_trylock(). However,
there will still be other problematic cases, like if fpga_mgr_get()
gets suspended right before taking the mutex and then delete_module
proceeds up to when fpga_mgr_unregister() frees the manager device
and its context.

> I think the mgr->owner & mgr->ops should be protected from concurrent
> access of delete_module & fpga_mgr_get/put(), so how about:
> 
> struct fpga_manager_ops {
> 	struct module *owner;
> 	...
> };
> 
> struct fpga_manager {
> 	...
> 	struct mutex mops_lock;
> 	const struct fpga_manager_ops *mops;
> 	...
> };
> 
> 
> static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> {
> 	struct fpga_manager *mgr;
> 
> 	mgr = to_fpga_manager(dev);
> 
> 	mutex_lock(&mgr->mops_lock);
> 
> 	if (!mgr->mops || !try_module_get(mgr->mops->owner))
> 		mgr = ERR_PTR(-ENODEV);
> 
> 	mutex_unlock(&mgr->mops_lock);
> 		
> 	return mgr;
> }
> 
> void fpga_mgr_unregister(struct fpga_manager *mgr)
> {
> 	fpga_mgr_fpga_remove(mgr);	
> 
> 	mutex_lock(&mgr->ops_lock);
> 	mgr->mops = NULL;
> 	mutex_unlock(&mgr->ops_lock);
> 
> 	device_unregister(&mgr->dev);	
> }
> 
> Not actually tested.
> 

I think protecting the only the ops is not enough for the same reasons.
If fpga_mgr_get() gets suspended right after class_find_device(),and
meanwhile the low-level module is removed, it resumes with a reference
to a manager device that no longer exists.

In a certain sense, however, using a mutex seems like a mitigation
that does not solve the problem at its root. I honestly still think
that taking the module's refcount right when registering the manager
is the only way that is both safe and robust against code changes.
However, my proposal was rejected.

So, if you prefer, I can drop the mutex entirely in the next version,
and we leave the responsibility of keeping all kernel pieces to the
user. It will still be an improvement over taking the low-level
module's refcount through the parent device's driver pointer.

Thanks,
Marco

