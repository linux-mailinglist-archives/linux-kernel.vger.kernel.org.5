Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877D804F98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjLEJ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjLEJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19520D4F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701770266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=n0iB+z0JnNDgITCIOQyqCuqmTb7Fl36TPJYhi24pgek=;
        b=J+kukpZRGYnEZWy3Zczz/lml871uDuyEtYmD6Ed7Aptj/Rab6JEQ6Jyph+mMwI1Tu6URgK
        jLOHjnpvcyZcaQWVujZNNadxDLsaOIJL9BQS9HbOiNdbcwq3uP0B7N2HDGClQACF271HeX
        IqdXmuRmRh96cr8+AVD1jgW97Y43kt8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584--crVeTAgN8-cLrVDkshf2Q-1; Tue, 05 Dec 2023 04:57:44 -0500
X-MC-Unique: -crVeTAgN8-cLrVDkshf2Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b5482879cso33767965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770263; x=1702375063;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0iB+z0JnNDgITCIOQyqCuqmTb7Fl36TPJYhi24pgek=;
        b=YUZyRTsO6sphbshy9Kkztks9HcHV+soDCQnfnHaR4hmfUCC6D5doATMCWjxIifxsV4
         FD0NHZW3YSW+30hPJ7xgIKr8kc7E5JkRyOHII/y8np04btxvH9onJ/PYlgqJQDs/l/JJ
         YGQMcOsqyInK5XB/dGQhlaWm9I3SiSNafJM9BfLsB3FtJr7TEVwz8ozGFzq5YZeJ7VRN
         JYREZnH8gpEeiGxZl5sqHUy1iWFzdx0N2LCtnH0gnDX6WAmkKEVitWAMdOxjzKRsCReJ
         tWI5zgSab3ZeIFbywViKVPUVGxOluNf4FiryzeAe0eMqu0FC4raredS1e0avUhHuF6sH
         6p2w==
X-Gm-Message-State: AOJu0YxnkYibGGY19hEEBCsSaxzsPbIEcraCeRlp1zxy7Sm+Sz9wDlUl
        G5YgeDjABWzn9YQbfo0YinXECVeeFfhQLN5gvzwtFMixas9WencCEmCHl+Rbd1T9kSGbIDo1GQI
        YzebS+1pn6fszF+KNwwF17Upw
X-Received: by 2002:a05:600c:19c7:b0:40b:51c7:7ad7 with SMTP id u7-20020a05600c19c700b0040b51c77ad7mr388741wmq.18.1701770263364;
        Tue, 05 Dec 2023 01:57:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG26xnxaT1nBEjjHdqqb/xNDXhpMqdQwrcux6lHRl2eLbSGrF5mDSnGL3u3Ny24YBX5XANXGA==
X-Received: by 2002:a05:600c:19c7:b0:40b:51c7:7ad7 with SMTP id u7-20020a05600c19c700b0040b51c77ad7mr388718wmq.18.1701770262981;
        Tue, 05 Dec 2023 01:57:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d4490000000b003333e71ef9asm8004884wrq.115.2023.12.05.01.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:57:42 -0800 (PST)
Message-ID: <c97d60cc-6c31-4da1-b519-86516008bb4c@redhat.com>
Date:   Tue, 5 Dec 2023 10:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-4-ryan.roberts@arm.com>
 <CAGsJ_4zU6pHOwEzCQxo9UWUFmHZp0pvfgF4pKbkFfDPCRyFwyw@mail.gmail.com>
 <8adbde1c-970b-4a26-81b0-91b913c4850b@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8adbde1c-970b-4a26-81b0-91b913c4850b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.23 10:50, Ryan Roberts wrote:
> On 05/12/2023 04:21, Barry Song wrote:
>> On Mon, Dec 4, 2023 at 11:21 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> In preparation for adding support for anonymous multi-size THP,
>>> introduce new sysfs structure that will be used to control the new
>>> behaviours. A new directory is added under transparent_hugepage for each
>>> supported THP size, and contains an `enabled` file, which can be set to
>>> "inherit" (to inherit the global setting), "always", "madvise" or
>>> "never". For now, the kernel still only supports PMD-sized anonymous
>>> THP, so only 1 directory is populated.
>>>
>>> The first half of the change converts transhuge_vma_suitable() and
>>> hugepage_vma_check() so that they take a bitfield of orders for which
>>> the user wants to determine support, and the functions filter out all
>>> the orders that can't be supported, given the current sysfs
>>> configuration and the VMA dimensions. If there is only 1 order set in
>>> the input then the output can continue to be treated like a boolean;
>>> this is the case for most call sites. The resulting functions are
>>> renamed to thp_vma_suitable_orders() and thp_vma_allowable_orders()
>>> respectively.
>>>
>>> The second half of the change implements the new sysfs interface. It has
>>> been done so that each supported THP size has a `struct thpsize`, which
>>> describes the relevant metadata and is itself a kobject. This is pretty
>>> minimal for now, but should make it easy to add new per-thpsize files to
>>> the interface if needed in future (e.g. per-size defrag). Rather than
>>> keep the `enabled` state directly in the struct thpsize, I've elected to
>>> directly encode it into huge_anon_orders_[always|madvise|inherit]
>>> bitfields since this reduces the amount of work required in
>>> thp_vma_allowable_orders() which is called for every page fault.
>>>
>>> See Documentation/admin-guide/mm/transhuge.rst, as modified by this
>>> commit, for details of how the new sysfs interface works.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>
>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> 
> Thanks!
> 
>>
>>> -khugepaged will be automatically started when
>>> -transparent_hugepage/enabled is set to "always" or "madvise, and it'll
>>> -be automatically shutdown if it's set to "never".
>>> +khugepaged will be automatically started when one or more hugepage
>>> +sizes are enabled (either by directly setting "always" or "madvise",
>>> +or by setting "inherit" while the top-level enabled is set to "always"
>>> +or "madvise"), and it'll be automatically shutdown when the last
>>> +hugepage size is disabled (either by directly setting "never", or by
>>> +setting "inherit" while the top-level enabled is set to "never").
>>>
>>>   Khugepaged controls
>>>   -------------------
>>>
>>> +.. note::
>>> +   khugepaged currently only searches for opportunities to collapse to
>>> +   PMD-sized THP and no attempt is made to collapse to other THP
>>> +   sizes.
>>
>> For small-size THP, collapse is probably a bad idea. we like a one-shot
>> try in Android especially we are using a 64KB and less large folio size. if
>> PF succeeds in getting large folios, we map large folios, otherwise we
>> give up as those memories can be quite unstably swapped-out, swapped-in
>> and madvised to be DONTNEED.
>>
>> too many compactions will increase power consumption and decrease UI
>> response.
> 
> Understood; that's very useful information for the Android context. Multiple
> people have made comments about eventually needing khugepaged (or something
> similar) support in the server context though to async collapse to contpte size.
> Actually one suggestion was a user space daemon that scans and collapses with
> MADV_COLLAPSE. I suspect the key will be to ensure whatever solution we go for
> is flexible and can be enabled/disabled/configured for the different environments.

There certainly is interest for 2 MiB THP on arm64 64k where the THP 
size would normally be 512 MiB. In that scenario, khugepaged makes 
perfect sense.

-- 
Cheers,

David / dhildenb

