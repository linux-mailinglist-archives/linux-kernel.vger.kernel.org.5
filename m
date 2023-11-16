Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62D67EE71A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjKPTCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPTCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7EFD49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700161358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3OC2ADiYU02tF1nm9tqRn9IHNlSGDAKnuIeHEkk+2J4=;
        b=g+84dBK7rR8+EGXM5PI186pl2vC0RoqbhDd/qaj/l36VoXtRi/ezAM98WMlZX1DWv/XPDZ
        jt6x6D1aKb/3lPHx140M3BTZ2qaV3EESa3MpL4mmTvoTPY2uNfCn8sX0m0egZs7ZPDO6Xu
        GZ+gt9irC0fKjYM+FXsJJMQFf8538nU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-077-TspTOkSelLy6Ns2Shg-1; Thu, 16 Nov 2023 14:02:36 -0500
X-MC-Unique: 077-TspTOkSelLy6Ns2Shg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32ddd6f359eso629622f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161355; x=1700766155;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OC2ADiYU02tF1nm9tqRn9IHNlSGDAKnuIeHEkk+2J4=;
        b=WN46ICnvQ5+7T6MzjkD2Bh3m23iA1KCr8Km2BY5yh3i/oDH74sKLG68BJUV+a2yS66
         ZKLPNwNF+ZGN6N9CWNt//fpAKlog1mbyzkEknviHt5jqcnmrXUElMivSvHuqbtbXZgmf
         xXOTDUbdAMV1TAJNTGOys31LDFYtH0iFEA2hd0E5SpDbjrjEtmVDPdQ3ODgQbThLWfB/
         6aDdkTX/a+FmV3pMI63BgqyMP1GMxYrC5GY4brAFRHhz23iz5RcQ4bedgPx5l9Otg+rT
         t36gt5ZK+RwH725VRGdZ6eDagOm7x2IU3fXyUiGRB5aIkNOsBzHzfO59MR0ydrQE/mvt
         KQbg==
X-Gm-Message-State: AOJu0YwFbOcYsyAgkZNJDOjBYTsFytTzn+tmmD6xmOoMu/xm23QGtI7B
        o3jI4cBE6yuNhet+xXs9DmrIlvRg8JlvcI0AXH24KdyQ2vKBVmUppeYVX4SLxi/Gk+1isX5AkYK
        W2BfjeU/8AMX5KwC0aKpA2T+l
X-Received: by 2002:a5d:47af:0:b0:32f:83e4:50e7 with SMTP id 15-20020a5d47af000000b0032f83e450e7mr14055543wrb.12.1700161355374;
        Thu, 16 Nov 2023 11:02:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJZU5B+uYez9qcnvhBGOUNZ24syk4/bBQhpb99E7lot+IXamjxEmMc6ZazLGreL/SmH0Na2A==
X-Received: by 2002:a5d:47af:0:b0:32f:83e4:50e7 with SMTP id 15-20020a5d47af000000b0032f83e450e7mr14055513wrb.12.1700161354826;
        Thu, 16 Nov 2023 11:02:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:e000:d929:2324:97c7:112c? (p200300cbc714e000d929232497c7112c.dip0.t-ipconnect.de. [2003:cb:c714:e000:d929:2324:97c7:112c])
        by smtp.gmail.com with ESMTPSA id j10-20020adfff8a000000b00326f0ca3566sm162043wrr.50.2023.11.16.11.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 11:02:34 -0800 (PST)
Message-ID: <2123c5e8-bba6-4ce8-9050-266a63cc2f14@redhat.com>
Date:   Thu, 16 Nov 2023 20:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] mm/memory_hotplug: introduce MEM_PHYS_ONLINE/OFFLINE
 memory notifiers
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-5-sumanthk@linux.ibm.com>
 <7c85bd39-8b34-4b09-b503-b0a2f2e58b88@redhat.com>
 <20231115160337.5c60f50a@thinkpad-T15>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231115160337.5c60f50a@thinkpad-T15>
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

On 15.11.23 16:03, Gerald Schaefer wrote:
> On Tue, 14 Nov 2023 19:27:35 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
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
>> Sorry to say, no. No hacks please, and this is a hack for memory that
>> has already been added to the system.
> 
> IIUC, when we enter memory_block_online(), memory has always already
> been added to the system, on all architectures. E.g. via ACPI events
> on x86, or with the existing s390 hack, where we add it at boot time,
> including memmap allocated from system memory. Without a preceding
> add_memory() you cannot reach memory_block_online() via sysfs online.

Adding that memory block at boot time is the legacy leftover s390x is 
carrying along; and now we want to "workaround" that by adding s390x 
special handling for online/offlining code and having memory blocks 
without any memmap, or configuring an altmap in the very last minute 
using a s390x specific memory notifier.

Instead, if you want to support the altmap, the kernel should not add 
standby memory to the system (if configured for this new feature), but 
instead only remember the standby memory ranges so it knows what can 
later be added and what can't.

 From there, users should have an interface where they can actually add 
memory to the system, and either online it manually or just let the 
kernel online it automatically.

s390x code will call add_memory() and properly prepare an altmap if 
requested and make that standby memory available. You can then even have 
an interface to remove that memory again once offline. That will work 
with an altmap or without an altmap.

This approach is aligned with any other code that hot(un)plugs memory 
and is compatible with things like variable-sized memory blocks people 
have been talking about quite a while already, and altmaps that span 
multiple memory blocks to make gigantic pages in such ranges usable.

Sure, you'll have a new interface and have to enable the new handling 
for the new kernel, but you're asking for supporting a new feature that 
cannot be supported cleanly just like any other architecture does. But 
it's a clean approach and probably should have been done that way right 
from the start (decades ago).

Note: We do have the same for other architectures without ACPI that add 
memory via the probe interface. But IIRC we cannot really do any checks 
there, because these architectures have no way of identifying what

> 
> The difference is that for s390, the memory is not yet physically
> accessible, and therefore we cannot use the existing altmap support
> in memory_block_online(), which requires that the memory is accessible
> before it calls mhp_init_memmap_on_memory().
> 
> Currently, on s390 we make the memory accessible in the GOING_ONLINE
> notifier, by sclp call to the hypervisor. That is too late for altmap
> setup code in memory_block_online(), therefore we'd like to introduce
> the new notifier, to have a hook where we can make it accessible
> earlier, and after that there is no difference to how it works for
> other architectures, and we can make use of the existing altmap support.
> 
>>
>> If you want memory without an altmap to suddenly not have an altmap
>> anymore, then look into removing and readding that memory, or some way
>> to convert offline memory.
> 
> We do not want to have memory suddenly not have an altmap support
> any more, but simply get a hook so that we can prepare the memory
> to have altmap support. This means making it physically accessible,
> and calling __add_pages() for altmap support, which for other
> architecture has already happened before.
> 
> Of course, it is a hack for s390, that we must skip __add_pages()
> in the initial (arch_)add_memory() during boot time, when we want
> altmap support, because the memory simply is not accessible at that
> time. But s390 memory hotplug support has always been a hack, and
> had to be, because of how it is implemented by the architecture.

I write above paragraph before reading this; and it's fully aligned with 
what I said above.

> 
> So we replace one hack with another one, that has the huge advantage
> that we do not need to allocate struct pages upfront from system
> memory any more, for the whole possible online memory range.
> 
> And the current approach comes without any change to existing
> interfaces, and minimal change to common code, i.e. these new
> notifiers, that should not have any impact on other architectures.
> 
> What exactly is your concern regarding the new notifiers? Is it
> useless no-op notifier calls on other archs (not sure if they
> would get optimized out by compiler)?

That it makes hotplug code more special because of s390x, instead of 
cleaning up that legacy code.

-- 
Cheers,

David / dhildenb

