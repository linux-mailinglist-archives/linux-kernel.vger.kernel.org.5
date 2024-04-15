Return-Path: <linux-kernel+bounces-145051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559CE8A4EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CAB1C21072
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E00679E5;
	Mon, 15 Apr 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBT187MD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D23BBEB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183603; cv=none; b=nIFbNHPmtzVKsEcLLEviwQyoP1FFGXxT6HFbAqhy/d+kKBwVQqAnGOSFW811mibPPsuAGHeaMVm8k6gxw/EnPrEbi9f9y21lyDeubGodSdS3jEvt2Qqu6Y33Tr4/0haKnxDU2IrYr1cql1aryWAyr6jBwyLAOZQiazNqXMYTdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183603; c=relaxed/simple;
	bh=DcyrUNeaJ8nAPF0RyX391Zb04wfUNEPZcwOEW2UTTCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXO60nz9sqmMPCkYIKAyeEQdDmwSBIQR85VZbFiKJNkDynfoH48+1JQIYNXupKGZdgW/8Kf45JYiop0veME6JaH87dXwoOQpggvtZQb3Bt26xK0EhhIQJ4kD79JOIvjuQJ0oDsooewhYYRSVTpCmv9yU5LGgiD1vAYxp8o7yaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBT187MD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713183599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDQw6079hna9CEOsOlsyOrJetXoDSph8zEQlaRaMQu0=;
	b=JBT187MDvktzS2W9bI+tXghA1GhseYdXymjAVrakRN9VLG4S35V+qDk55gidsZLgm9oErq
	F9F/PtgmE1A5SV8cF6GqsOv6TUzmLvTjJBYhh7t8bUMoLypOh/1wty2wklyej2pVivjXlU
	NCeLRRxUNajg9kcl0MGEtgVqBIUWQuc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-qDW6RklnP9uolOXmzOMDdA-1; Mon, 15 Apr 2024 08:19:58 -0400
X-MC-Unique: qDW6RklnP9uolOXmzOMDdA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d546cc459so439100885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713183598; x=1713788398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDQw6079hna9CEOsOlsyOrJetXoDSph8zEQlaRaMQu0=;
        b=nYqgU6V60BTgle+QkW7uVFl2Bh3lCJLWSJQhtdDM7+XwbU4EcYwrcUZ5YBLpM8CkUA
         3UCxMSlsc7ST6guc4URXPvexqWkAgdDtzApCnWAjCTzdaMRGVEoj00uPO56TEO+B7y6A
         nFkdbK3peAHgUp/XyuBu6GTBOWO4IlpT18SDOAIM/c4aip8gm58t/fK6X8c5NXmAx1/l
         ccw0Jcm9r+Aodasm+6DLgJpzvmKvPOvWSESyuU9kVAKKfCB5UTzoMscFN/oobLNRFMma
         kKI9vBaTxRF7ubil1bE+h901kHCBQfP74rjw5ok86cnggB43/wFGZm07mCQ/bwCrD2Bz
         mitw==
X-Forwarded-Encrypted: i=1; AJvYcCVBVYkuVJxksX4h/U7RKPdGIStR6lUg27IFQICmFHTBTw47GgLzqToTRpsce8GYnDzYDX62oYSH2rMsA9gbBaEtKqsCIKEOZtA7LwsE
X-Gm-Message-State: AOJu0Yz+H/s8rmnc22yLLZqpZmpVtqg9cyB8L5dO/sloIjzM3TuFJogL
	ScbqSmwoGAFTfeKNU5wAX42qUqfxbhXFetpdHX/0bdmScivUlEnF3lKNVtk5MCLVq8ZsYwoBhBO
	CjK8ECM+s+q7ZAk1fWHkbWS7hedONMkDOjg1rU2/oVHjtZoUudURK/1g9kxUv
X-Received: by 2002:a05:620a:1649:b0:78e:bfdf:7186 with SMTP id c9-20020a05620a164900b0078ebfdf7186mr9789320qko.48.1713183597929;
        Mon, 15 Apr 2024 05:19:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzPxQkjmK6TPSajF2WEuVBaYH4aU4qzvZHPqTERmqD7BgD3ZV3P+H2fQaoPYI3sxBGLi1SiA==
X-Received: by 2002:a05:620a:1649:b0:78e:bfdf:7186 with SMTP id c9-20020a05620a164900b0078ebfdf7186mr9789306qko.48.1713183597635;
        Mon, 15 Apr 2024 05:19:57 -0700 (PDT)
Received: from [192.168.9.34] (net-2-34-28-196.cust.vodafonedsl.it. [2.34.28.196])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a080700b0078ec3aa9cc7sm5957738qks.25.2024.04.15.05.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 05:19:56 -0700 (PDT)
Message-ID: <669b8b55-df83-4c32-9c8f-41895db18b75@redhat.com>
Date: Mon, 15 Apr 2024 14:19:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] fpga: region: add owner module and take its refcount
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
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZhnviXAgnTdzUyV4@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-13 04:35, Xu Yilun wrote:
>>  /**
>> - * fpga_region_register_full - create and register an FPGA Region device
>> + * __fpga_region_register_full - create and register an FPGA Region device
>>   * @parent: device parent
>>   * @info: parameters for FPGA Region
>> + * @owner: owner module containing the get_bridges function
> 
> This is too specific and easily get unaligned if we add another
> callback. How about "module containing the region ops"?

I had some concerns about using the name "region ops" in the kernel-doc
comment since it was not supported by a struct definition nor referenced
in the documentation. However, since the name is now referred to in the
ops_owner pointer, making the change makes sense to me.

Thanks,
Marco

> 
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
>> +	region->ops_owner = owner;
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
> 
> ditto
> 
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
>> index 9d4d32909340..5fbc05fe70a6 100644
>> --- a/include/linux/fpga/fpga-region.h
>> +++ b/include/linux/fpga/fpga-region.h
>> @@ -36,6 +36,7 @@ struct fpga_region_info {
>>   * @mgr: FPGA manager
>>   * @info: FPGA image info
>>   * @compat_id: FPGA region id for compatibility check.
>> + * @ops_owner: module containing the get_bridges function
> 
> ditto
> 
> Thanks,
> Yilun
> 
>>   * @priv: private data
>>   * @get_bridges: optional function to get bridges to a list
>>   */
>> @@ -46,6 +47,7 @@ struct fpga_region {
>>  	struct fpga_manager *mgr;
>>  	struct fpga_image_info *info;
>>  	struct fpga_compat_id *compat_id;
>> +	struct module *ops_owner;
>>  	void *priv;
>>  	int (*get_bridges)(struct fpga_region *region);
>>  };
> 


