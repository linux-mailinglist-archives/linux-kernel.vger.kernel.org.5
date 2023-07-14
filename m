Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484B9753520
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjGNIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjGNIgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592DB1BFB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689323752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fH2TVmHvkuGKbv2hcI4xKi7nRAASFrz5xNlTKuAGh58=;
        b=SELPjBVbjQwxBrAHze8MiMgBNlSDroeeqI011MisB30qlD9YrS4NX6MTd3TBTt/XmcMN+Q
        uU24xjQ5TS0mjhuO9lO9FgsUiifiGItTTW1K+fif7Abkun/PhYOhxg36HkjzTeX7m30EhG
        iGvuaGJ8V9spmjiGDjTUGzWEDy4OPfY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-hn_tEpcMOl2e2pNddZY28w-1; Fri, 14 Jul 2023 04:35:51 -0400
X-MC-Unique: hn_tEpcMOl2e2pNddZY28w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3113da8b778so990980f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689323750; x=1691915750;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fH2TVmHvkuGKbv2hcI4xKi7nRAASFrz5xNlTKuAGh58=;
        b=F2pXhPh+qTeops02tTTnyzZflZyEO7DZk2w7MsbzcgHtjFOj2NFhD/HO8C+ZwETY7E
         PTjyPcIj2WxXNjgOyLuXCXaAXH4spFJxBvejzEngn7wILYPz6EowPH5xfk3GydLEo1B/
         g7aPjYDsUUzd5385XjlGyDzq3BylovsKG7/O0ME/woztC3kZtsiL086X78zc26duk76N
         CsVP5EA3qjSgp3ua3iS7eFuR2+J+rVF1CldzyOtWVcSfPTWaJDVD4Sn6Zupq9iD3qBI7
         TrcceHRxft3PDLKEBjRLPaRO/9sHd2o8MonNTucnMJYvzD1zBz4O5wMiza4hzCHWbs+I
         WnkA==
X-Gm-Message-State: ABy/qLb/vJQidhIKJVOWG0hy6uUoLz6R8gPLjIge8BUi8jwVoS+mbrS7
        UY4ePIXHCofEaMKwW893O9FpqK5WZtit+s9YHQRX4bbs3GqujOyfSiWwzUSg/zQhbeXJqfu8jeF
        Wl9vDui6jUPRyohRBYw1elvCa
X-Received: by 2002:a5d:4006:0:b0:314:21b4:8322 with SMTP id n6-20020a5d4006000000b0031421b48322mr3144967wrp.10.1689323750010;
        Fri, 14 Jul 2023 01:35:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGnmP51HKlsUWs7J70Wsu4Nis9jH3dnqaKZpH2XGHxORN4tmFKjwWx8/wDgKSU/KYu85DXo5Q==
X-Received: by 2002:a5d:4006:0:b0:314:21b4:8322 with SMTP id n6-20020a5d4006000000b0031421b48322mr3144944wrp.10.1689323749637;
        Fri, 14 Jul 2023 01:35:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb? (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de. [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d6752000000b0031434cebcd8sm10132122wrw.33.2023.07.14.01.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 01:35:49 -0700 (PDT)
Message-ID: <cfeecd92-3aa4-a07d-b71a-793531785692@redhat.com>
Date:   Fri, 14 Jul 2023 10:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <29c9b998-f453-59f2-5084-9b4482b489cf@redhat.com>
 <x49fs5r7hj1.fsf@segfault.boston.devel.redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
In-Reply-To: <x49fs5r7hj1.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 21:12, Jeff Moyer wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 16.06.23 00:00, Vishal Verma wrote:
>>> The dax/kmem driver can potentially hot-add large amounts of memory
>>> originating from CXL memory expanders, or NVDIMMs, or other 'device
>>> memories'. There is a chance there isn't enough regular system memory
>>> available to fit ythe memmap for this new memory. It's therefore
>>> desirable, if all other conditions are met, for the kmem managed memory
>>> to place its memmap on the newly added memory itself.
>>>
>>> Arrange for this by first allowing for a module parameter override for
>>> the mhp_supports_memmap_on_memory() test using a flag, adjusting the
>>> only other caller of this interface in dirvers/acpi/acpi_memoryhotplug.c,
>>> exporting the symbol so it can be called by kmem.c, and finally changing
>>> the kmem driver to add_memory() in chunks of memory_block_size_bytes().
>>
>> 1) Why is the override a requirement here? Just let the admin
>> configure it then then add conditional support for kmem.
>>
>> 2) I recall that there are cases where we don't want the memmap to
>> land on slow memory (which online_movable would achieve). Just imagine
>> the slow PMEM case. So this might need another configuration knob on
>> the kmem side.
> 
>  From my memory, the case where you don't want the memmap to land on
> *persistent memory* is when the device is small (such as NVDIMM-N), and
> you want to reserve as much space as possible for the application data.
> This has nothing to do with the speed of access.

Now that you mention it, I also do remember the origin of the altmap --
to achieve exactly that: place the memmap on the device.

commit 4b94ffdc4163bae1ec73b6e977ffb7a7da3d06d3
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri Jan 15 16:56:22 2016 -0800

     x86, mm: introduce vmem_altmap to augment vmemmap_populate()
     
     In support of providing struct page for large persistent memory
     capacities, use struct vmem_altmap to change the default policy for
     allocating memory for the memmap array.  The default vmemmap_populate()
     allocates page table storage area from the page allocator.  Given
     persistent memory capacities relative to DRAM it may not be feasible to
     store the memmap in 'System Memory'.  Instead vmem_altmap represents
     pre-allocated "device pages" to satisfy vmemmap_alloc_block_buf()
     requests.

In PFN_MODE_PMEM (and only then), we use the altmap (don't see a way to
configure it).


BUT that case is completely different from the "System RAM" mode. The memmap
of an NVDIMM in pmem mode is barely used by core-mm (i.e., not the buddy).

In comparison, if the buddy and everybody else works on the memmap in
"System RAM", it's much more significant if that resides on slow memory.


Looking at

commit 9b6e63cbf85b89b2dbffa4955dbf2df8250e5375
Author: Michal Hocko <mhocko@suse.com>
Date:   Tue Oct 3 16:16:19 2017 -0700

     mm, page_alloc: add scheduling point to memmap_init_zone
     
     memmap_init_zone gets a pfn range to initialize and it can be really
     large resulting in a soft lockup on non-preemptible kernels
     
       NMI watchdog: BUG: soft lockup - CPU#31 stuck for 23s! [kworker/u642:5:1720]
       [...]
       task: ffff88ecd7e902c0 ti: ffff88eca4e50000 task.ti: ffff88eca4e50000
       RIP: move_pfn_range_to_zone+0x185/0x1d0
       [...]
       Call Trace:
         devm_memremap_pages+0x2c7/0x430
         pmem_attach_disk+0x2fd/0x3f0 [nd_pmem]
         nvdimm_bus_probe+0x64/0x110 [libnvdimm]


It's hard to tell if that was only required due to the memmap for these devices
being that large, or also partially because the access to the memmap is slower
that it makes a real difference.


I recall that we're also often using ZONE_MOVABLE on such slow memory
to not end up placing other kernel data structures on there: especially,
user space page tables as I've been told.


@Dan, any insight on the performance aspects when placing the memmap on
(slow) memory and having that memory be consumed by the buddy where we frequently
operate on the memmap?

-- 
Cheers,

David / dhildenb

