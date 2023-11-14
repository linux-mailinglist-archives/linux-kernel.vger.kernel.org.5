Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255347EB650
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjKNSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D9121
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699986157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=JrgxpS9b6RH/dIRyuh67+QVxOU1qulfPt53kMoouXlk=;
        b=LZd6BTAU275HOZSpa693UppKjtR24VuA/+z2sSDzagPMKIpX8g+8FpIZytc9CxwCoXCYNa
        mGJGe3fC2OFrsRwOnJy0pf0JVBC+XSeKrlr5GM7lSUx8Wl57bvpej8v4PTozYj+qWujhZl
        hmlbCRfYSsRqSCbXUB8ePa85pSK6urI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-JAyWkMu4MmCICzIFuBYArg-1; Tue, 14 Nov 2023 13:22:36 -0500
X-MC-Unique: JAyWkMu4MmCICzIFuBYArg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4094158c899so37619545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699986155; x=1700590955;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrgxpS9b6RH/dIRyuh67+QVxOU1qulfPt53kMoouXlk=;
        b=BJfgw3qs1NDPTOtQSqH1KutyMM9cm2mQ1QCIQziolEXpGD2EJnANmEUsjz6RqBPhAS
         8O4w1w3LA9FxwbovMd4NsU7Nz/3pvnXulscc/44T3gg5+egJt+b0MgD2qcm2uynKG6Fy
         s7XyHnD3GmQw0V1dHOAHv10iea5KsIi6CT+MsT2rzOQ6USJenNkD1AKe+WwGz3naQ0Z4
         UX48JlTWHDkWwzpTZqYr2KMqV9oJjSuX1pI3fJkrthkwnLHKfh+mLVnMrpP1pk1h3VcC
         E0R+5V2X+A+Y/ZD8t274nydzGNupqIkzoLJCOD67vplrPIIQ4T9bwg26kZT6XQtoD4Xb
         1IvQ==
X-Gm-Message-State: AOJu0YxrsbRj1Kd1zedqJETWI6U/IPa2mI/Ay1/ykVEM/SyhnZbCLChm
        7X9FfDb+b4X5CFG58vlG6FU4cwxgITkQ4LrRuKEoab87jSi65viR2oCCuLId9mrMeT29RacEAc6
        x3x0AFjlxmdNxyUm3uMbNt6WFBXMNLUiX
X-Received: by 2002:a05:600c:4715:b0:40a:42dd:c82c with SMTP id v21-20020a05600c471500b0040a42ddc82cmr8263505wmo.27.1699986155163;
        Tue, 14 Nov 2023 10:22:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn/GeMx7sBAgFV3p8wQXfRgUF2SWBFj/UeA4oLtE0jb5nkAdUsv27yq7SwbP4ZK++6gN0n4w==
X-Received: by 2002:a05:600c:4715:b0:40a:42dd:c82c with SMTP id v21-20020a05600c471500b0040a42ddc82cmr8263482wmo.27.1699986154681;
        Tue, 14 Nov 2023 10:22:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd? (p200300cbc73e890002d8c9f0f3fbd4fd.dip0.t-ipconnect.de. [2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b004094c5d929asm12490539wms.10.2023.11.14.10.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 10:22:34 -0800 (PST)
Message-ID: <cbf8863a-d987-472f-8df3-bc621599f1ee@redhat.com>
Date:   Tue, 14 Nov 2023 19:22:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm/memory_hotplug: fix memory hotplug locking order
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <20231114180238.1522782-2-sumanthk@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231114180238.1522782-2-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.23 19:02, Sumanth Korikkar wrote:

The patch subject talks about "fixing locking order", but it's actually 
missing locking, no?

>  From Documentation/core-api/memory-hotplug.rst:
> When adding/removing/onlining/offlining memory or adding/removing
> heterogeneous/device memory, we should always hold the mem_hotplug_lock
> in write mode to serialise memory hotplug (e.g. access to global/zone
> variables).
> 
> mhp_(de)init_memmap_on_memory() functions can change zone stats and
> struct page content, but they are currently called w/o the
> mem_hotplug_lock.
> 
> When memory block is being offlined and when kmemleak goes through each
> populated zone, the following theoretical race conditions could occur:
> CPU 0:					     | CPU 1:
> memory_offline()			     |
> -> offline_pages()			     |
> 	-> mem_hotplug_begin()		     |
> 	   ...				     |
> 	-> mem_hotplug_done()		     |
> 					     | kmemleak_scan()
> 					     | -> get_online_mems()
> 					     |    ...
> -> mhp_deinit_memmap_on_memory()	     |
>    [not protected by mem_hotplug_begin/done()]|
>    Marks memory section as offline,	     |   Retrieves zone_start_pfn
>    poisons vmemmap struct pages and updates   |   and struct page members.
>    the zone related data			     |
>     					     |    ...
>     					     | -> put_online_mems()
> 
> Fix this by ensuring mem_hotplug_lock is taken before performing
> mhp_init_memmap_on_memory(). Also ensure that
> mhp_deinit_memmap_on_memory() holds the lock.

What speaks against grabbing that lock in these functions?

-- 
Cheers,

David / dhildenb

