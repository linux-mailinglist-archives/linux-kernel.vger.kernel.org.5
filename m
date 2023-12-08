Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7927A80A25E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573584AbjLHLgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjLHLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C077171D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702035418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=7iZNobHl/GPobGa2I6qixx18BC281Bjl3vJdU1mmkuQ=;
        b=M8isj7Gzmk6RnET9OXHO43zLSQApDTC6e9x/9AtxGw432CO83hkgBIL2DCZ8BZhHSosD+G
        Z6YPZZm1/Rxm4TjQbn0Uakytrs+/gwlXV8WOhjNLb4hpUgrL+hUuusiUfXTuJOc3aEw7T/
        hgKCXpt19JcxgZ8MGrCD84TzSRls0vg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-laGh8A2tPfWEpD2LuTM97A-1; Fri, 08 Dec 2023 06:36:57 -0500
X-MC-Unique: laGh8A2tPfWEpD2LuTM97A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33608afb161so663486f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035415; x=1702640215;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iZNobHl/GPobGa2I6qixx18BC281Bjl3vJdU1mmkuQ=;
        b=GPnt2ddbqU1fMWgR+fLtVCd/7xGn9va9Xy43A/qzAJHDxH55bVR0Z9xzuqkIS27T4d
         wPXr0N3w2vtekpilSMjhMx/FnBDJWeVa2C5KxGuqM9DwvBzvUMjztZvautGRvUPWrA3E
         ZzIf66tktEHh4gI0zZwn4ALpWkeWou5vlBUbYyXTHvBIGq2b3IRiKpOaY+9muh1HtXT2
         2NWQm3EePruWHjX0ooLhffTY/K9cdS71npIvhqHbi32r23rLT4+EE/05bL5ADTDusOJV
         fDGyXCENSxZqXSxy9wY/TiT3vhfcV5ToiZ/SEKI297lPvoIiebAqn4SIjx8fDx+i9rca
         DaxQ==
X-Gm-Message-State: AOJu0YwapGTghgm+d0HCkxnVoMEJEcOyF0cahX5kGfzd1xHPwP6R8scb
        jcU0+nOY2w1Vm3oLmGR87WfpKS3MQJAiz4C+hMtV1W+jvdyQIIKUnViiKZ0ifSOvDH/ymT0Z/72
        rJqOy1R3/bkDUuw8Xwi4iAFwL
X-Received: by 2002:a05:600c:54f1:b0:40b:5e59:ccd4 with SMTP id jb17-20020a05600c54f100b0040b5e59ccd4mr2455930wmb.181.1702035415749;
        Fri, 08 Dec 2023 03:36:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5LCs+9ecahCq1vp9Sw1TdZj3EbHX2btIMBL9/oJRDL+AiIApsb4Y2A2vh6l7BLPckKuqoQw==
X-Received: by 2002:a05:600c:54f1:b0:40b:5e59:ccd4 with SMTP id jb17-20020a05600c54f100b0040b5e59ccd4mr2455915wmb.181.1702035415310;
        Fri, 08 Dec 2023 03:36:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c724:2100:3826:4f41:d72c:dc1b? (p200300cbc724210038264f41d72cdc1b.dip0.t-ipconnect.de. [2003:cb:c724:2100:3826:4f41:d72c:dc1b])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm2605930wms.7.2023.12.08.03.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 03:36:54 -0800 (PST)
Message-ID: <e9323c58-6a99-436f-b8c5-ffc68b940de3@redhat.com>
Date:   Fri, 8 Dec 2023 12:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com>
 <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.23 05:36, Vishal Verma wrote:
> Add a sysfs knob for dax devices to control the memmap_on_memory setting
> if the dax device were to be hotplugged as system memory.
> 
> The default memmap_on_memory setting for dax devices originating via
> pmem or hmem is set to 'false' - i.e. no memmap_on_memory semantics, to
> preserve legacy behavior. For dax devices via CXL, the default is on.
> The sysfs control allows the administrator to override the above
> defaults if needed.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>   drivers/dax/bus.c                       | 40 +++++++++++++++++++++++++++++++++
>   Documentation/ABI/testing/sysfs-bus-dax | 13 +++++++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1ff1ab5fa105..11abb57cc031 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1270,6 +1270,45 @@ static ssize_t numa_node_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(numa_node);
>   
> +static ssize_t memmap_on_memory_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct dev_dax *dev_dax = to_dev_dax(dev);
> +
> +	return sprintf(buf, "%d\n", dev_dax->memmap_on_memory);
> +}
> +
> +static ssize_t memmap_on_memory_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct dev_dax *dev_dax = to_dev_dax(dev);
> +	struct dax_region *dax_region = dev_dax->region;
> +	ssize_t rc;
> +	bool val;
> +
> +	rc = kstrtobool(buf, &val);
> +	if (rc)
> +		return rc;
> +
> +	if (dev_dax->memmap_on_memory == val)
> +		return len;
> +
> +	device_lock(dax_region->dev);
> +	if (!dax_region->dev->driver) {
> +		device_unlock(dax_region->dev);
> +		return -ENXIO;
> +	}
> +
> +	device_lock(dev);
> +	dev_dax->memmap_on_memory = val;
> +	device_unlock(dev);
> +
> +	device_unlock(dax_region->dev);
> +	return rc == 0 ? len : rc;
> +}
> +static DEVICE_ATTR_RW(memmap_on_memory);
> +
>   static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>   {
>   	struct device *dev = container_of(kobj, struct device, kobj);
> @@ -1296,6 +1335,7 @@ static struct attribute *dev_dax_attributes[] = {
>   	&dev_attr_align.attr,
>   	&dev_attr_resource.attr,
>   	&dev_attr_numa_node.attr,
> +	&dev_attr_memmap_on_memory.attr,
>   	NULL,
>   };
>   
> diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
> index a61a7b186017..bb063a004e41 100644
> --- a/Documentation/ABI/testing/sysfs-bus-dax
> +++ b/Documentation/ABI/testing/sysfs-bus-dax
> @@ -149,3 +149,16 @@ KernelVersion:	v5.1
>   Contact:	nvdimm@lists.linux.dev
>   Description:
>   		(RO) The id attribute indicates the region id of a dax region.
> +
> +What:		/sys/bus/dax/devices/daxX.Y/memmap_on_memory
> +Date:		October, 2023
> +KernelVersion:	v6.8
> +Contact:	nvdimm@lists.linux.dev
> +Description:
> +		(RW) Control the memmap_on_memory setting if the dax device
> +		were to be hotplugged as system memory. This determines whether
> +		the 'altmap' for the hotplugged memory will be placed on the
> +		device being hotplugged (memmap_on+memory=1) or if it will be
> +		placed on regular memory (memmap_on_memory=0). This attribute
> +		must be set before the device is handed over to the 'kmem'
> +		driver (i.e.  hotplugged into system-ram).
> 

Should we note the dependency on other factors as given in 
mhp_supports_memmap_on_memory(), especially, the system-wide setting and 
some weird kernel configurations?

-- 
Cheers,

David / dhildenb

