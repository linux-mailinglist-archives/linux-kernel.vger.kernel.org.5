Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4142378FF60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350061AbjIAOmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbjIAOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE299F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693579266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqmyNseuv44Zzv1WRU9GbdFKMiMfyfVJ64aicRpb+Xw=;
        b=UtpsLsM8qg7cJkY2Ru8fvSPcUsj1D1aw0dvEG2uNYPdEKeS30rSQ1ygkeLwKb7JeJjIF1I
        Dr3fmsB1Sf3N94VkFtDg8F6PocUSmJ9oDXhQq2yDfhXzOjtQgcHIax2JH7RLhGS7SZgWfK
        wAIUJ6ABX+c0TzH/0XUGvCGwG4IN9GI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-7iMg_xP1PkuSBYwgRfk6pw-1; Fri, 01 Sep 2023 10:41:03 -0400
X-MC-Unique: 7iMg_xP1PkuSBYwgRfk6pw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401e521122fso15500545e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693579262; x=1694184062;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqmyNseuv44Zzv1WRU9GbdFKMiMfyfVJ64aicRpb+Xw=;
        b=TxMom3qcphgfefcl78+mz2UViCHpnl7aFmSfQk22A+s5zUW8ZPTBBAailK5tDF343B
         mKM95BI4hc9XdZaWSUpRx/waeRXM0SdW+XmebNV4po89RjkBDTMfajOnpE7s551eEyV9
         cP7AAvQ2aRgDCDtK+9p3EvdY4/NMcY4Jn/5r/ENXZA5P4NotqXxGq7lDE754Eg9coTDG
         YLFewX//t7uav7PpfPMjX828n/tmcL1qQss797xuVYgByuJLgTeZ/+wImYAOhOgi1VKd
         SJpyk/wOQJMVu9FQM6y2UFfYPSt3+p5uhKyNMW4oSzwo52+mdT9ElMN1hyEbwEJ/BJK1
         yj8g==
X-Gm-Message-State: AOJu0Yx3p4BBIgdPGcfWXBvdANimwZG+P6/jk1tIdOuRbgQ0zE6dnEX0
        ICdN5ZYuiF3O2v7yit9qd/MVFLQmoeaF6G62vVTymymycRoePMMNklKXaeH37pkEO/H0f7FQv8x
        KuODwkmsSHQE8+Dq2iXlTBLxa
X-Received: by 2002:a1c:7715:0:b0:3fe:16c8:65fa with SMTP id t21-20020a1c7715000000b003fe16c865famr2277861wmi.4.1693579262501;
        Fri, 01 Sep 2023 07:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXFD2NQLNXWVAoK1IYmHVvhJD5QOCX5CJMB4P6IfjReWthYnob1B4GGaOQ2pj7Q1/lwThk4Q==
X-Received: by 2002:a1c:7715:0:b0:3fe:16c8:65fa with SMTP id t21-20020a1c7715000000b003fe16c865famr2277827wmi.4.1693579262127;
        Fri, 01 Sep 2023 07:41:02 -0700 (PDT)
Received: from [10.59.19.200] (pd956a06e.dip0.t-ipconnect.de. [217.86.160.110])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003feff926fc5sm5086171wmd.17.2023.09.01.07.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 07:41:01 -0700 (PDT)
Message-ID: <341a66e1-c71a-24e8-3eba-6c2fa16babe0@redhat.com>
Date:   Fri, 1 Sep 2023 16:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Rientjes <rientjes@google.com>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
 <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
 <ZPCHpOtYgq32leay@casper.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
In-Reply-To: <ZPCHpOtYgq32leay@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.23 14:29, Matthew Wilcox wrote:
> On Thu, Aug 31, 2023 at 09:57:46AM +0200, David Hildenbrand wrote:
>> As raised in another mail, we can then discuss
>> * how we want to call this feature (transparent large pages? there is
>>    the concern that "THP" might confuse users. Maybe we can consider
>>    "large" the more generic version and "huge" only PMD-size, TBD)
>> * how to expose it in stats towards the user (e.g., /proc/meminfo)
>> * which minimal toggles we want
>>
>> I think there *really* has to be a way to disable it for a running system,
>> otherwise no distro will dare pulling it in, even after we figured out the
>> other stuff.
>>
>> Note that for the pagecache, large folios can be disabled and distributions
>> are actively making use of that.
> 
> You can't.  Well, you can for shmem/tmpfs, but you have to edit the
> source code or disable CONFIG_TRANSPARENT_HUGEPAGE to disable it for XFS.

While you cannot currently control the exact allocation granularity, you 
can limit the effect it has on apps that are sensitive to rss (memcg) 
changes. See

See as an example:

https://www.suse.com/support/kb/doc/?id=000019017


For the pagecache you arguably don't care, because the assumption is 
that you can reclaim that memory anytime. So even if you allocated 2 MiB 
and only mapped 4 KiB into the process, so far you can work around that 
breaking existing setups by setting fault_around_bytes.

For anon memory that's quite different (as of now and in the forseable 
future). For that reason, we have all these knobs to teach THP to not 
over-allocate memory (e.g., no thp on page fault, don't fill holes in 
khugepaged).

I know that Dave R. can share quite some details about that.

-- 
Cheers,

David / dhildenb

