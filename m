Return-Path: <linux-kernel+bounces-145642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60338A58DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D03B21A41
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A39985942;
	Mon, 15 Apr 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLFQr6/9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA98248E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201074; cv=none; b=SHUNCjcpo8TZCvmyJe8hE3s4upL5ichE/7gx/IdImYTWkn21sv+zpekcXphhRqNqM63PSyltNIYidNJIFRBrRW1ekb/sheKbg1UJH8aoej7FzxVK3NFSx9Zbkl2u2DyJYYxGFuvwNUY+/wkg2UcrEpuL29Oykox7qRWMD6Ba2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201074; c=relaxed/simple;
	bh=SEcuJt/UZ8ba3isISMeftKrW6x4eGf3z22U6SReVxT8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tT5kq3rY6l9yH8Pe9cQ0PxE5L6gW8F3C6PwaHk6rYFJ0L8/0wm7aIGyP0/Uun21VlaMAbjN6hUj5VRcB7e9Tzo34x/2lzC27uwLhSZVgoqhqKHi5HgWKclSNNy3wE+eQILgJ6ff0iORCFn1eEQCsjUKLMU1XXmZFCHpwXr+/dZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLFQr6/9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713201070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khDc6xFWFIXG4OuztGv/s1Ulbk4vHwkXmIffcldK9WU=;
	b=HLFQr6/9olfijrbzpiTzPWwruPS2pkWceet18zuE6S2YowAXgpEzWloSWAB5BhrMVWinMe
	jgxvFwMnogxWVb4v/YyWLswbpGguRpeEnVJxGGxFUzJ9Mtqq5pUcUq2LjtdAqqaB862iYv
	h4dsNBGQFnVqodTLvZXKSE/riugjC6g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-WFgnz0kWOYe1GRnM74ZO-g-1; Mon, 15 Apr 2024 13:11:08 -0400
X-MC-Unique: WFgnz0kWOYe1GRnM74ZO-g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-518b4b45e91so1952713e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201067; x=1713805867;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khDc6xFWFIXG4OuztGv/s1Ulbk4vHwkXmIffcldK9WU=;
        b=a4Szovy7R5FgMxQhXtdnfYPrDFyDLnWWFFebuMll1XkrznDlx2TRvP/T1J1TWdbcyJ
         UXDQ0o/+Y2G9MAOR3mJz5UfSmRpTABVw4daC1y8QDWDH1tYr4G7pnkKzV09106RKhePR
         CSMoS5gz/JGeUzS1NB111wF0AJH24X254gi2LVrZiUVLXGPqVSHQzV/JJP1x68ueYjYr
         YC/TWwqXKTR0QTtO6emUso0nfq4d4RXg2gwLCJwuwOGXbFmLcFOwNuk/Qyi+sqslIfmG
         kRlPFonyTvY94mARRYt+uGPZmHlel99FUYEvM+sdH2bQIvypWvshXeexBuGh0nOBz+gz
         GnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAVXdmhb/r9JdFu1MMqQO7T1Jo9oSBYOupfoWGlWV2xLqo66G43a3ITYIDc0QNU+bmqlWMMBHI32T5ZXWUAVaufHK4FZ9WqBoXQtdh
X-Gm-Message-State: AOJu0YzycrONThrUYUIKb3YuyY5XdELtmjzL+ZkKYcKFF0n0HVYKrJEc
	hRb/LVUxaAa+Rvoht28q/6S5P9DJzLuwi/MLHoaBKezDeIDlxeY+7eRkNBTNU632dEBu5izkro3
	07V8F+GAo0nRXD14p43dmdDSKi8QA7sSgM76t875tnium3dSpF2HfznP5cQMu
X-Received: by 2002:a05:6512:10c7:b0:518:c82a:bdf9 with SMTP id k7-20020a05651210c700b00518c82abdf9mr5757475lfg.44.1713201067081;
        Mon, 15 Apr 2024 10:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/cIZ45K0OXdCc0M88lP7x/UqAbRwJSShIeGFCm4QF4V9CYuZrhpeNIeziBGI5i34SzHi2vQ==
X-Received: by 2002:a05:6512:10c7:b0:518:c82a:bdf9 with SMTP id k7-20020a05651210c700b00518c82abdf9mr5757434lfg.44.1713201066606;
        Mon, 15 Apr 2024 10:11:06 -0700 (PDT)
Received: from [192.168.142.123] ([78.209.35.245])
        by smtp.gmail.com with ESMTPSA id si29-20020a170906cedd00b00a4e5866448bsm5679354ejb.155.2024.04.15.10.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 10:11:06 -0700 (PDT)
Message-ID: <e5f15ea4-f8e4-4a97-95f6-63a2099d084c@redhat.com>
Date: Mon, 15 Apr 2024 19:11:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] fpga: region: add owner module and take its refcount
From: Marco Pagani <marpagan@redhat.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Tull <atull@opensource.altera.com>, Russ Weight
 <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240411144811.121500-1-marpagan@redhat.com>
 <ZhnviXAgnTdzUyV4@yilunxu-OptiPlex-7050>
 <669b8b55-df83-4c32-9c8f-41895db18b75@redhat.com>
Content-Language: en-US
In-Reply-To: <669b8b55-df83-4c32-9c8f-41895db18b75@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-15 14:19, Marco Pagani wrote:
> 
> 
> On 2024-04-13 04:35, Xu Yilun wrote:
>>>  /**
>>> - * fpga_region_register_full - create and register an FPGA Region device
>>> + * __fpga_region_register_full - create and register an FPGA Region device
>>>   * @parent: device parent
>>>   * @info: parameters for FPGA Region
>>> + * @owner: owner module containing the get_bridges function
>>
>> This is too specific and easily get unaligned if we add another
>> callback. How about "module containing the region ops"?
> 
> I had some concerns about using the name "region ops" in the kernel-doc
> comment since it was not supported by a struct definition nor referenced
> in the documentation. However, since the name is now referred to in the
> ops_owner pointer, making the change makes sense to me.
> 

On second thought, I think it would be better to leave the @owner
description to "module containing the get_bridges function" for the
moment. Otherwise, it could confuse the user by blurring the connection
between the @owner and @get_bridges parameters.

* __fpga_region_register - create and register an FPGA Region device
* [...]
* @get_bridges: optional function to get bridges to a list
* @owner: owner module containing get_bridges function

We can always modify the @owner description later, together with all the
necessary changes to add a new op, like grouping all ops in a structure
and changing the registration function signature.

Thanks,
Marco

> 
>>
>>>   *
>>>   * Return: struct fpga_region or ERR_PTR()
>>>   */
>>>  struct fpga_region *
>>> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
>>> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
>>> +			    struct module *owner)
>>>  {
>>>  	struct fpga_region *region;
>>>  	int id, ret = 0;
>>> @@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>>  	region->compat_id = info->compat_id;
>>>  	region->priv = info->priv;
>>>  	region->get_bridges = info->get_bridges;
>>> +	region->ops_owner = owner;
>>>  
>>>  	mutex_init(&region->mutex);
>>>  	INIT_LIST_HEAD(&region->bridge_list);
>>> @@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>>  
>>>  	return ERR_PTR(ret);
>>>  }
>>> -EXPORT_SYMBOL_GPL(fpga_region_register_full);
>>> +EXPORT_SYMBOL_GPL(__fpga_region_register_full);
>>>  
>>>  /**
>>> - * fpga_region_register - create and register an FPGA Region device
>>> + * __fpga_region_register - create and register an FPGA Region device
>>>   * @parent: device parent
>>>   * @mgr: manager that programs this region
>>>   * @get_bridges: optional function to get bridges to a list
>>> + * @owner: owner module containing get_bridges function
>>
>> ditto
>>
>>>   *
>>>   * This simple version of the register function should be sufficient for most users.
>>>   * The fpga_region_register_full() function is available for users that need to
>>> @@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
>>>   * Return: struct fpga_region or ERR_PTR()
>>>   */
>>>  struct fpga_region *
>>> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>>> -		     int (*get_bridges)(struct fpga_region *))
>>> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>>> +		       int (*get_bridges)(struct fpga_region *), struct module *owner)
>>>  {
>>>  	struct fpga_region_info info = { 0 };
>>>  
>>>  	info.mgr = mgr;
>>>  	info.get_bridges = get_bridges;
>>>  
>>> -	return fpga_region_register_full(parent, &info);
>>> +	return __fpga_region_register_full(parent, &info, owner);
>>>  }
>>> -EXPORT_SYMBOL_GPL(fpga_region_register);
>>> +EXPORT_SYMBOL_GPL(__fpga_region_register);
>>>  
>>>  /**
>>>   * fpga_region_unregister - unregister an FPGA region
>>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>>> index 9d4d32909340..5fbc05fe70a6 100644
>>> --- a/include/linux/fpga/fpga-region.h
>>> +++ b/include/linux/fpga/fpga-region.h
>>> @@ -36,6 +36,7 @@ struct fpga_region_info {
>>>   * @mgr: FPGA manager
>>>   * @info: FPGA image info
>>>   * @compat_id: FPGA region id for compatibility check.
>>> + * @ops_owner: module containing the get_bridges function
>>
>> ditto
>>
>> Thanks,
>> Yilun
>>
>>>   * @priv: private data
>>>   * @get_bridges: optional function to get bridges to a list
>>>   */
>>> @@ -46,6 +47,7 @@ struct fpga_region {
>>>  	struct fpga_manager *mgr;
>>>  	struct fpga_image_info *info;
>>>  	struct fpga_compat_id *compat_id;
>>> +	struct module *ops_owner;
>>>  	void *priv;
>>>  	int (*get_bridges)(struct fpga_region *region);
>>>  };
>>


