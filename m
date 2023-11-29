Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467017FD055
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjK2IFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2IFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:05:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACD2D40
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701245136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=8v095EuMzzISmu5Y1f0aoY1vTTbA82jShxtCDF/8mD4=;
        b=jTOoLiRbHXxFJGL4eZQbZcrOTtkJt2jnZCUHLF4Lsus8TosaC9p+n5EJl2/P5U5Ke0qp4e
        qpykO1V2L3ouvSWwbQ3H92cLkCkDFn3Ys5puMnwd5atV226NHGRZblWHAJWBLjwyrkqpTS
        DMwvbKQXfoqENhvCegEZZSxNbKOU5jc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-JddXo1B6M3KsSIAE8py5aA-1; Wed, 29 Nov 2023 03:05:35 -0500
X-MC-Unique: JddXo1B6M3KsSIAE8py5aA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332dfa77997so4452352f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701245134; x=1701849934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v095EuMzzISmu5Y1f0aoY1vTTbA82jShxtCDF/8mD4=;
        b=PcwdnjRcLcQZTawN5OrYpH8qJq0orERhBuu6kGpABCVMqi/kD7Mqh2iSPP36OY3k6+
         2aG+heJhmjPQmks9BCqUlmZ67lUFtNp1U2v+kvva+VL+fq6xOLF90tsGunh5TuBgXpJl
         5+CGB5OH+BwAc8cj+yDKZhhcb4au0DzOveTSKZQK1qy9FIjdPgtA2faf90iAJj7sAmM3
         fCf2BkTNhSDo6R6svg/stYUwwagukFloECp/ck5pOZuRHQl3/eiC46pGP6W+L9OSsN8n
         x3DpUrW0mKm2cIbBxc/vrX2YpgACE5pD1uD+NswT+k/9cdY6d7Gz472kF85UTW1UPgNo
         aYVw==
X-Gm-Message-State: AOJu0YxPG1q84tvHijWzWAYqnZ+G9Us9L7o51nv5Kc6jVd93uoiEJ92Y
        zFZiKOU0hvs9XitdJ2GVTuhrY7lJ77ZcWHMH03WpCPUtwMyR3eaUYxcebtWqeKhiUMRHJlU3cMo
        wRHPJnQ7v9gZN9k2Keloi14bC
X-Received: by 2002:a5d:40c8:0:b0:332:ca80:a9ea with SMTP id b8-20020a5d40c8000000b00332ca80a9eamr15317538wrq.41.1701245134059;
        Wed, 29 Nov 2023 00:05:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH+cIaBxAciCd2fsZSq+1PDb19SejhgJa0v9lNP3Bybizd9hcikvV8V3BG6r7q69GN1MF/Aw==
X-Received: by 2002:a5d:40c8:0:b0:332:ca80:a9ea with SMTP id b8-20020a5d40c8000000b00332ca80a9eamr15317508wrq.41.1701245133531;
        Wed, 29 Nov 2023 00:05:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c710:f600:634b:35f:ffa8:475b? (p200300cbc710f600634b035fffa8475b.dip0.t-ipconnect.de. [2003:cb:c710:f600:634b:35f:ffa8:475b])
        by smtp.gmail.com with ESMTPSA id df2-20020a5d5b82000000b0032fbe5b1e45sm16817600wrb.61.2023.11.29.00.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:05:33 -0800 (PST)
Message-ID: <e29bbb0d-8c61-49b8-9bf0-df7ddf2728e7@redhat.com>
Date:   Wed, 29 Nov 2023 09:05:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 03/10] mm: thp: Introduce per-size thp sysfs
 interface
To:     John Hubbard <jhubbard@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-4-ryan.roberts@arm.com>
 <1a738e0a-ac11-4cd3-be2f-6b6e7cb4980a@nvidia.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1a738e0a-ac11-4cd3-be2f-6b6e7cb4980a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.23 04:42, John Hubbard wrote:
> On 11/22/23 08:29, Ryan Roberts wrote:
>> In preparation for adding support for anonymous small-sized THP,
>> introduce new sysfs structure that will be used to control the new
>> behaviours. A new directory is added under transparent_hugepage for each
>> supported THP size, and contains an `enabled` file, which can be set to
>> "global" (to inherrit the global setting), "always", "madvise" or
>> "never". For now, the kernel still only supports PMD-sized anonymous
>> THP, so only 1 directory is populated.
>>
>> The first half of the change converts transhuge_vma_suitable() and
>> hugepage_vma_check() so that they take a bitfield of orders for which
>> the user wants to determine support, and the functions filter out all
>> the orders that can't be supported, given the current sysfs
>> configuration and the VMA dimensions. If there is only 1 order set in
>> the input then the output can continue to be treated like a boolean;
>> this is the case for most call sites.
>>
>> The second half of the change implements the new sysfs interface. It has
>> been done so that each supported THP size has a `struct thpsize`, which
>> describes the relevant metadata and is itself a kobject. This is pretty
>> minimal for now, but should make it easy to add new per-thpsize files to
>> the interface if needed in future (e.g. per-size defrag). Rather than
>> keep the `enabled` state directly in the struct thpsize, I've elected to
>> directly encode it into huge_anon_orders_[always|madvise|global]
>> bitfields since this reduces the amount of work required in
>> transhuge_vma_suitable() which is called for every page fault.
>>
>> The remainder is copied from Documentation/admin-guide/mm/transhuge.rst,
>> as modified by this commit. See that file for further details.
>>
>> Transparent Hugepage Support for anonymous memory can be entirely
>> disabled (mostly for debugging purposes) or only enabled inside
>> MADV_HUGEPAGE regions (to avoid the risk of consuming more memory
>> resources) or enabled system wide. This can be achieved
>> per-supported-THP-size with one of::
>>
>> 	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> 	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> 	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>>
>> where <size> is the hugepage size being addressed, the available sizes
>> for which vary by system. Alternatively it is possible to specify that
>> a given hugepage size will inherrit the global enabled setting::
>>
>> 	echo global >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>>
>> The global (legacy) enabled setting can be set as follows::
>>
>> 	echo always >/sys/kernel/mm/transparent_hugepage/enabled
>> 	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>> 	echo never >/sys/kernel/mm/transparent_hugepage/enabled
>>
>> By default, PMD-sized hugepages have enabled="global" and all other
>> hugepage sizes have enabled="never". If enabling multiple hugepage
>> sizes, the kernel will select the most appropriate enabled size for a
>> given allocation.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>    Documentation/admin-guide/mm/transhuge.rst |  74 ++++--
>>    Documentation/filesystems/proc.rst         |   6 +-
>>    fs/proc/task_mmu.c                         |   3 +-
>>    include/linux/huge_mm.h                    | 100 +++++---
>>    mm/huge_memory.c                           | 263 +++++++++++++++++++--
>>    mm/khugepaged.c                            |  16 +-
>>    mm/memory.c                                |   6 +-
>>    mm/page_vma_mapped.c                       |   3 +-
>>    8 files changed, 387 insertions(+), 84 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index b0cc8243e093..52565e0bd074 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -45,10 +45,23 @@ components:
>>       the two is using hugepages just because of the fact the TLB miss is
>>       going to run faster.
>>
>> +As well as PMD-sized THP described above, it is also possible to
>> +configure the system to allocate "small-sized THP" to back anonymous
> 
> Here's one of the places to change to the new name, which lately is
> "multi-size THP", or mTHP or m_thp for short. (I've typed "multi-size"
> instead of "multi-sized", because the 'd' doesn't add significantly to
> the meaning, and if in doubt, shorter is better.
> 
> 
>> +memory (for example 16K, 32K, 64K, etc). These THPs continue to be
>> +PTE-mapped, but in many cases can still provide similar benefits to
>> +those outlined above: Page faults are significantly reduced (by a
>> +factor of e.g. 4, 8, 16, etc), but latency spikes are much less
>> +prominent because the size of each page isn't as huge as the PMD-sized
>> +variant and there is less memory to clear in each page fault. Some
>> +architectures also employ TLB compression mechanisms to squeeze more
>> +entries in when a set of PTEs are virtually and physically contiguous
>> +and approporiately aligned. In this case, TLB misses will occur less
>> +often.
>> +
> 
> OK, all of the above still seems like it can remain the same.
> 
>>    THP can be enabled system wide or restricted to certain tasks or even
>>    memory ranges inside task's address space. Unless THP is completely
>>    disabled, there is ``khugepaged`` daemon that scans memory and
>> -collapses sequences of basic pages into huge pages.
>> +collapses sequences of basic pages into PMD-sized huge pages.
>>
>>    The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>>    interface and using madvise(2) and prctl(2) system calls.
>> @@ -95,12 +108,29 @@ Global THP controls
>>    Transparent Hugepage Support for anonymous memory can be entirely disabled
>>    (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
>>    regions (to avoid the risk of consuming more memory resources) or enabled
>> -system wide. This can be achieved with one of::
>> +system wide. This can be achieved per-supported-THP-size with one of::
>> +
>> +	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> +	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> +	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> +
>> +where <size> is the hugepage size being addressed, the available sizes
>> +for which vary by system. Alternatively it is possible to specify that
>> +a given hugepage size will inherrit the global enabled setting::
> 
> typo: inherrit
> 
>> +
>> +	echo global >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> +
>> +The global (legacy) enabled setting can be set as follows::
>>
>>    	echo always >/sys/kernel/mm/transparent_hugepage/enabled
>>    	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>>    	echo never >/sys/kernel/mm/transparent_hugepage/enabled
>>
>> +By default, PMD-sized hugepages have enabled="global" and all other
>> +hugepage sizes have enabled="never". If enabling multiple hugepage
>> +sizes, the kernel will select the most appropriate enabled size for a
>> +given allocation.
>> +
> 
> This is slightly murky. I wonder if "inherited" is a little more directly
> informative than global; it certainly felt that way my first time running
> this and poking at it.
> 
> And a few trivial examples would be a nice touch.
> 
> And so overall with a few other minor tweaks, I'd suggest this:
> 
> ...
> where <size> is the hugepage size being addressed, the available sizes
> for which vary by system.
> 
> For example:
> 	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> Alternatively it is possible to specify that a given hugepage size will inherit
> the top-level "enabled" value:
> 
> 	echo inherited >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> 
> For example:
> 	echo inherited >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> The top-level setting (for use with "inherited") can be by issuing one of the
> following commands::
> 
> 	echo always >/sys/kernel/mm/transparent_hugepage/enabled
> 	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> 	echo never >/sys/kernel/mm/transparent_hugepage/enabled
> 
> By default, PMD-sized hugepages have enabled="inherited" and all other
> hugepage sizes have enabled="never".

"inherited" works for me as well.

-- 
Cheers,

David / dhildenb

