Return-Path: <linux-kernel+bounces-88704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF586E598
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169981F26081
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0770CC2;
	Fri,  1 Mar 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CleJIN2x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983940BE5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310573; cv=none; b=M5JoHXHFvHBb5FyNrAIX5LLeBPWylMMUZQe15aABCOmhSprI0K5ty3MQFTFTUF2AOT+vZHk/kVl8G8gHGG4vjZttGNBLQqgx+sKZl6RYmGZfuhSQJ5wUz5aT6DOOWDb1qAfebRok6o/BLZK7Idd71BD9k6+ACO+qT1F7sBLFtKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310573; c=relaxed/simple;
	bh=4ENR5LUp28xMXehmU/AKJ8VrJmmzhvBxZei16elzGu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jofyk7Gcay7NYE5SQyT/q0cQA1AFUdZiWKuimDZ3yonWsts9GNX39R0qKqyzNSWdSE+oK0wVXmZ4vWWiwu7tUnwgeyvXVEho6d/qMJuW7FQEA4EJwhehU/pHTXDUKfvgPeNVhk1Bdr0wOV2YWdulbTX78GgCgTFob0tCwnvYVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CleJIN2x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709310569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNe7wQkN/o3BCAKNQu3U4+jdytvs3hfcAhbPOfxPT0w=;
	b=CleJIN2xhp19wvws37NpfiIBpjjUABusiCi/8tLU1Dt25RkcdTq3fDdgmrLFof5+odsT1/
	YVrvdbcvcyoAd1xWHIu7Oo/8c7R8EiZ0XSBBpqQmljnfkzrtuZbfHs7HWEe/bjhs9hxers
	/wJEN5vCVlTzlNnTS+teLRr28e38pNw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-2jI96-GCNF6DNxP9k-6Ohg-1; Fri, 01 Mar 2024 11:29:28 -0500
X-MC-Unique: 2jI96-GCNF6DNxP9k-6Ohg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c1a4222aa2so2950459b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709310568; x=1709915368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNe7wQkN/o3BCAKNQu3U4+jdytvs3hfcAhbPOfxPT0w=;
        b=Ign6MpVpWeNpssEiVWJ79yQsTvYJ4pHkpDsboe5YORudRo6HtkHXz1F+HxvDU8OuEU
         1D/Ab0e473ooSiG9nzcG60aPtHKtk2G45mSv5BATbS6xMlK7x6jfi4YnGspvLuow/LVr
         Dzq2TBODYA1t47Aym5gJNeUFY+Ei7FnkNtt3syPx+LtappfLUbpyYBOBqZagQVpIo2iK
         EoyA44RJoM7puAuJyeSV06tPzujQiXI7IfuCU955qqGhuTJKMrnhnPGs5MYl9FubAiNG
         5YtwWOvbiQ71x7vuDG1ve/jLHpx2flcLoJSbXggtvu9de1VVhhWkZlcvNpW17GC6PrJg
         OFdA==
X-Forwarded-Encrypted: i=1; AJvYcCXG02ABaE6YxDksVAqr2gWfE1PS4K7wQO45karU9c4x4GtAw0lTBnXYAS1I8WHmkLMiJVV4TjEKarAhJ/k6hFYwr3qezoTv0YSit/V1
X-Gm-Message-State: AOJu0Yxfogl9p95nE9huPum9N7BJvS4dIE13BezJC8K9kz1XTZf1lH+d
	59BuoZXb6CgtJTqd3LPDIroghK6BAxNeQZsRhyXb0tDQPNaTCPMiqPZcyotBwNml/YWJ+4y2py5
	9O+0RXf6sTnUYaESHbS4OyQ3RmK9Xb26pkq8SS1xab/D7gkeLhYk8XSB6vHp1
X-Received: by 2002:a05:6808:2124:b0:3c1:c250:96ee with SMTP id r36-20020a056808212400b003c1c25096eemr2651214oiw.2.1709310567911;
        Fri, 01 Mar 2024 08:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlTpfV8lDCDZU0jDCFb2TIQ4JuCOInMQ1C6p5i+3jWLtn6h3oIis54i4vBrQ/yhtLTAXXavg==
X-Received: by 2002:a05:6808:2124:b0:3c1:c250:96ee with SMTP id r36-20020a056808212400b003c1c25096eemr2651188oiw.2.1709310567520;
        Fri, 01 Mar 2024 08:29:27 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-30-118.cust.vodafonedsl.it. [2.34.30.118])
        by smtp.gmail.com with ESMTPSA id e12-20020ac84b4c000000b0042e69db4c1fsm1832196qts.39.2024.03.01.08.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:29:27 -0800 (PST)
Message-ID: <d4f5243c-696a-4d1d-94f4-0ecf42b6d7f0@redhat.com>
Date: Fri, 1 Mar 2024 17:29:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Tull <atull@opensource.altera.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org
References: <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
 <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
 <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
 <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>
 <ZdYKnZxdTCvu5THG@yilunxu-OptiPlex-7050>
 <ae3cd81b-82af-4977-91d7-fa809c6fc45a@redhat.com>
 <Zd7cff43ffbJOGNY@yilunxu-OptiPlex-7050>
 <0c885ff2-44bc-4158-b5dd-3d7513cb2857@redhat.com>
 <ZeHwatupHVmC2N2+@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZeHwatupHVmC2N2+@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-01 16:12, Xu Yilun wrote:
> On Thu, Feb 29, 2024 at 11:37:10AM +0100, Marco Pagani wrote:
>>
>> On 2024-02-28 08:10, Xu Yilun wrote:
>>> On Tue, Feb 27, 2024 at 12:49:06PM +0100, Marco Pagani wrote:
>>>>
>>>>
>>>> On 2024-02-21 15:37, Xu Yilun wrote:
>>>>> On Tue, Feb 20, 2024 at 12:11:26PM +0100, Marco Pagani wrote:
>>>>>>
>>>>>>
>>>>>> On 2024-02-18 11:05, Xu Yilun wrote:
>>>>>>> On Mon, Feb 05, 2024 at 06:47:34PM +0100, Marco Pagani wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2024-02-04 06:15, Xu Yilun wrote:
>>>>>>>>> On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2024-01-30 05:31, Xu Yilun wrote:
>>>>>>>>>>>> +#define fpga_mgr_register_full(parent, info) \
>>>>>>>>>>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>>>>>>>>>  struct fpga_manager *
>>>>>>>>>>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>>>>>>>>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>>>>>>>>>> +			 struct module *owner);
>>>>>>>>>>>>  
>>>>>>>>>>>> +#define fpga_mgr_register(parent, name, mops, priv) \
>>>>>>>>>>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>>>>>>>>>>>>  struct fpga_manager *
>>>>>>>>>>>> -fpga_mgr_register(struct device *parent, const char *name,
>>>>>>>>>>>> -		  const struct fpga_manager_ops *mops, void *priv);
>>>>>>>>>>>> +__fpga_mgr_register(struct device *parent, const char *name,
>>>>>>>>>>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
>>>>>>>>>>>> +
>>>>>>>>>>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>>>>>>>>>>  
>>>>>>>>>>>> +#define devm_fpga_mgr_register_full(parent, info) \
>>>>>>>>>>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>>>>>>>>>  struct fpga_manager *
>>>>>>>>>>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>>>>>>>>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>>>>>>>>>> +			      struct module *owner);
>>>>>>>>>>>
>>>>>>>>>>> Add a line here. I can do it myself if you agree.
>>>>>>>>>>
>>>>>>>>>> Sure, that is fine by me. I also spotted a typo in the commit log body
>>>>>>>>>> (in taken -> is taken). Do you want me to send a v6, or do you prefer
>>>>>>>>>> to fix that in place?
>>>>>>>>>
>>>>>>>>> No need, I can fix it.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> There is still a RFC prefix for this patch. Are you ready to get it merged?
>>>>>>>>>>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
>>>>>>>>>>
>>>>>>>>>> I'm ready for the patch to be merged. However, I recently sent an RFC
>>>>>>>>>> to propose a safer implementation of try_module_get() that would
>>>>>>>>>> simplify the code and may also benefit other subsystems. What do you
>>>>>>>>>> think?
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
>>>>>>>>>
>>>>>>>>> I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
>>>>>>>>> proposal is applied before the end of this cycle, we could re-evaluate
>>>>>>>>> this patch.
>>>>>>>>
>>>>>>>> That's fine by me.
>>>>>>>
>>>>>>> Sorry, I still found issues about this solution.
>>>>>>>
>>>>>>> void fpga_mgr_unregister(struct fpga_manager *mgr)
>>>>>>> {
>>>>>>>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>>>>>>>
>>>>>>>         /*
>>>>>>>          * If the low level driver provides a method for putting fpga into
>>>>>>>          * a desired state upon unregister, do it.
>>>>>>>          */
>>>>>>>         fpga_mgr_fpga_remove(mgr);
>>>>>>>
>>>>>>>         mutex_lock(&mgr->mops_mutex);
>>>>>>>
>>>>>>>         mgr->mops = NULL;
>>>>>>>
>>>>>>>         mutex_unlock(&mgr->mops_mutex);
>>>>>>>
>>>>>>>         device_unregister(&mgr->dev);
>>>>>>> }
>>>>>>>
>>>>>>> Note that fpga_mgr_unregister() doesn't have to be called in module_exit().
>>>>>>> So if we do fpga_mgr_get() then fpga_mgr_unregister(), We finally had a
>>>>>>> fpga_manager dev without mops, this is not what the user want and cause
>>>>>>> problem when using this fpga_manager dev for other FPGA APIs.
>>>>>>
>>>>>> How about moving mgr->mops = NULL from fpga_mgr_unregister() to
>>>>>> class->dev_release()? In that way, mops will be set to NULL only when the
>>>>>> manager dev refcount reaches 0.
>>>>>
>>>>> I'm afraid it doesn't help.  The lifecycle of the module and the fpga
>>>>> mgr dev is different.
>>>>>
>>>>> We use mops = NULL to indicate module has been freed or will be freed in no
>>>>> time.  On the other hand mops != NULL means module is still there, so
>>>>> that try_module_get() could be safely called.  It is possible someone
>>>>> has got fpga mgr dev but not the module yet, at that time the module is
>>>>> unloaded, then try_module_get() triggers crash.
>>>>>
>>>>>>
>>>>>> If fpga_mgr_unregister() is called from module_exit(), we are sure that nobody
>>>>>> got the manager dev earlier using fpga_mgr_get(), or it would have bumped up
>>>>>
>>>>> No, someone may get the manager dev but not the module yet, and been
>>>>> scheduled out.
>>>>>
>>>>
>>>> You are right. Overall, it's a bad idea. How about then using an additional 
>>>> bool flag instead of "overloading" the mops pointer? Something like:
>>>>
>>>> get:
>>>> 	if (!mgr->owner_valid || !try_module_get(mgr->mops_owner))
>>>>
>>>> remove:
>>>> 	mgr->owner_valid = false;
>>>
>>> I'm not quite sure which function is actually mentioned by "remove".  I
>>> assume it should be fpga_mgr_unregister().
>>
>> Yes, I was referring to fpga_mgr_unregister().
>>
>>> IIUC this flag means no more reference to fpga mgr, but existing
>>> references are still valid.
>>
>> Yes.
>>
>>>
>>> It works for me. But the name of this flag could be reconsidered to
>>> avoid misunderstanding.  The owner is still valid (we still need to put
>>> the owner) but allows no more reference.  Maybe "owner_inactive"?
>>
>> Right, owner_valid might be misleading. How about removing any
>> reference to the owner module and name the flag unreg?
> 
> the full name "unregistered" is better.

That's fine by me.

> 
>>
>> __fpga_mgr_get:
>> 	if (mgr->unreg || !try_module_get(mgr->mops_owner))
>> 		mgr = ERR_PTR(-ENODEV);
>>
>> fpga_mgr_unregister:
>>  	mgr->unreg = true;
>>
>>> I still wanna this owner reference change been splitted, so that
>>> we could simply revert it when the try_module_get_safe() got accepted.
>>
>> I guess it may take some time to have try_module_get_safe() accepted.
>> What do you prefer to do with the bridge and the region in the
>> meantime?
> 
> This issue could happen in little chance. I actually don't have much
> preference, either way is good to me.
> 

Okay, I'll also send the patch for the region then.

Thanks,
Marco


