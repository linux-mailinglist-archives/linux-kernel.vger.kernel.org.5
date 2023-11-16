Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2E67EE722
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjKPTEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjKPTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F57182
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700161440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=noFtgqazCBC+/n+W0RzmjdI1W4IMXkcCumNBFAtwhRo=;
        b=ddZEkOKdzrtBOqsewMMsez5vI4DDWj/o1StXze29UcKV/05LSLXOpTZS5bdRxLMXVpQM6f
        gIngwMGLymhJrxAjeNFP4tv9JmKIeGhqOQpajT55qmVU2zyj9ZzdAvjC0cryKQ6OauLc5r
        vf4XXsafIgHuJnQHJwuzj83Csz1nr3c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-e2YbIfriOqaVSOq3OeJ7fQ-1; Thu, 16 Nov 2023 14:03:57 -0500
X-MC-Unique: e2YbIfriOqaVSOq3OeJ7fQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084e263ec4so7664005e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161436; x=1700766236;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noFtgqazCBC+/n+W0RzmjdI1W4IMXkcCumNBFAtwhRo=;
        b=I7iL37Vsi3HlyqrU6zETpPzwIaVJth6KQv/w3Qq0WRe+BAUAihTdTwhYGXQndLT6PJ
         Pja0GSa7v11y1IUsPOGjw79/V9CjkpS6Yj+MC+GkVvouvFD8G0i1BCUTiyaoYiBhCyj6
         bGg2kX8MwCPblwMZtB5NAhwshokPSU4Jo9HUqWMUDHJg7Qgb39xnoB9Hau9AzAzWFC2E
         XacC32oyXAD4o1OHD+E4zsX0btpQ/N+xcyODNc+JtxLnUNrbiTBLiwT5NtKcMQn9zyzW
         8Yv+Psv49MLGACiaKioySrJoskywjZowmpTugSQCgpY1UGGLa8ktWlsG0Q8zvwiWWQZB
         r4RQ==
X-Gm-Message-State: AOJu0YwNGsXH4OgZuLg+6caHqIIUN+lZsQUmzS1T3ZtOOy5r8eVCSvAr
        D+CTuG7kFRyEtIxXcpduqYp17QJBx3S9LSgnVCj9kp5kPN9ko/qgGnlAzGPfwYY33SHBGoHvFZs
        qnjBu856fHriB5+pkwIAoWwLS
X-Received: by 2002:adf:f9cf:0:b0:32d:14c5:643d with SMTP id w15-20020adff9cf000000b0032d14c5643dmr11981622wrr.5.1700161435786;
        Thu, 16 Nov 2023 11:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkeF+BhJMVhRUT0hTwF3xsLQX+bV0T7VMFgJrY68XUtb3ZDoOrmg4VK/IBwjz+J3pf8mXkoA==
X-Received: by 2002:adf:f9cf:0:b0:32d:14c5:643d with SMTP id w15-20020adff9cf000000b0032d14c5643dmr11981594wrr.5.1700161435301;
        Thu, 16 Nov 2023 11:03:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:e000:d929:2324:97c7:112c? (p200300cbc714e000d929232497c7112c.dip0.t-ipconnect.de. [2003:cb:c714:e000:d929:2324:97c7:112c])
        by smtp.gmail.com with ESMTPSA id j10-20020adfff8a000000b00326f0ca3566sm162043wrr.50.2023.11.16.11.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 11:03:54 -0800 (PST)
Message-ID: <b744a100-76a4-4735-89b1-08f16cf8b322@redhat.com>
Date:   Thu, 16 Nov 2023 20:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] mm/memory_hotplug: introduce MEM_PHYS_ONLINE/OFFLINE
 memory notifiers
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-5-sumanthk@linux.ibm.com>
 <7c85bd39-8b34-4b09-b503-b0a2f2e58b88@redhat.com>
 <ZVTUVuZzSJmQqEvk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZVTUVuZzSJmQqEvk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.23 15:23, Sumanth Korikkar wrote:
> On Tue, Nov 14, 2023 at 07:27:35PM +0100, David Hildenbrand wrote:
>> On 14.11.23 19:02, Sumanth Korikkar wrote:
>>> Add new memory notifiers to mimic the dynamic ACPI event triggered logic
>>> for memory hotplug on platforms that do not generate such events. This
>>> will be used to implement "memmap on memory" feature for s390 in a later
>>> patch.
>>>
>>> Platforms such as x86 can support physical memory hotplug via ACPI. When
>>> there is physical memory hotplug, ACPI event leads to the memory
>>> addition with the following callchain:
>>> acpi_memory_device_add()
>>>     -> acpi_memory_enable_device()
>>>        -> __add_memory()
>>>
>>> After this, the hotplugged memory is physically accessible, and altmap
>>> support prepared, before the "memmap on memory" initialization in
>>> memory_block_online() is called.
>>>
>>> On s390, memory hotplug works in a different way. The available hotplug
>>> memory has to be defined upfront in the hypervisor, but it is made
>>> physically accessible only when the user sets it online via sysfs,
>>> currently in the MEM_GOING_ONLINE notifier. This requires calling
>>> add_memory() during early memory detection, in order to get the sysfs
>>> representation, but we cannot use "memmap on memory" altmap support at
>>> this stage, w/o having it physically accessible.
>>>
>>> Since no ACPI or similar events are generated, there is no way to set up
>>> altmap support, or even make the memory physically accessible at all,
>>> before the "memmap on memory" initialization in memory_block_online().
>>>
>>> The new MEM_PHYS_ONLINE notifier allows to work around this, by
>>> providing a hook to make the memory physically accessible, and also call
>>> __add_pages() with altmap support, early in memory_block_online().
>>> Similarly, the MEM_PHYS_OFFLINE notifier allows to make the memory
>>> inaccessible and call __remove_pages(), at the end of
>>> memory_block_offline().
>>>
>>> Calling __add/remove_pages() requires mem_hotplug_lock, so move
>>> mem_hotplug_begin/done() to include the new notifiers.
>>>
>>> All architectures ignore unknown memory notifiers, so this patch should
>>> not introduce any functional changes.
>>
>> Sorry to say, no. No hacks please, and this is a hack for memory that has
>> already been added to the system.
>>
>> If you want memory without an altmap to suddenly not have an altmap anymore,
>> then look into removing and readding that memory, or some way to convert
>> offline memory.
> 
> Sorry, I couldnt get the context. Could you please give me more details?

See my reply to Gerald.

In an ideal world, there would not be any new callbacks, we would get 
rid of them, and just let the architecture properly hotplug memory to 
the system when requested by the user.

-- 
Cheers,

David / dhildenb

