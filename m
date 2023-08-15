Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15477C85E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjHOHMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjHOHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D01991
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692083481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUx5LEJZOPKDsMypuqMlxZ2NyXniu36dIsENemGDz2U=;
        b=KUY83w3GGF5VIXo0q6oJrjBfhfoLpmP9OKILtHR7DI6mlxF+bBQvu4iROtMZOYODmoG7FB
        vpeLGgzI4szYKuZLJOnixh1sTjgyHov5APqW5ADAvqbic/V9QwGVUzu7TmX6jXsPPBcbkY
        V2MQoBRDfnyH9wmMxpEYXYfGacaGo5I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-f069pFkCPA67KiNpIiQNSw-1; Tue, 15 Aug 2023 03:11:20 -0400
X-MC-Unique: f069pFkCPA67KiNpIiQNSw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe4cca36b7so34131725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692083479; x=1692688279;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUx5LEJZOPKDsMypuqMlxZ2NyXniu36dIsENemGDz2U=;
        b=SZBvWYvIKzOlnrYe/HTWIe9EQCqW6jxcCGInDLZPgEdpXxjVUp1WYCy98hLtFx6xzu
         PpQrFnzVbRTzrwYqL5uaDTIOcUnykcAs/6UkfT5E0u/kteaHUjC/RXMyYdR24q7/SXEK
         WuVXOdZ6ai847S5vyKojv0m9fIAGF1X4qltc4cP8wOqlBRt1Ggb+lRzO8eC9ULsgMc2C
         r/aCrHdQYI99TMiDgJx/Ybi/62Zq9Ls2fb8ivflE2AOyTHS0dIwg/ZrFTOEdF+1AjEYj
         jLdUKlyK3isFLs6BZxMsATbzH6wO1Juy7W0HZagoDaVOW9oU0y02dNPqG1IGZoab9mjW
         grIg==
X-Gm-Message-State: AOJu0YwSQ0xlA7de0850zCcqb6qtv0/EE+bCm2KCxya11QXZSrLtbjhr
        a+TPlvvbEci9yaFY2muzu/iVJ4OW5hlXiuAntDp39e9h5DbHoiZfyvRdDDTgJy6bOVwIxYAiazm
        cT/X44FsRrmhkUDqAiM1+0SN4
X-Received: by 2002:a05:600c:2990:b0:3fe:485f:ed13 with SMTP id r16-20020a05600c299000b003fe485fed13mr9404367wmd.29.1692083478912;
        Tue, 15 Aug 2023 00:11:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiQ+EYuKIjtdDIXSbwm8P8GjevS6zUtMu7iUNLTT7TYUjZWJk7Cfz7u1UU0MPiq0T6R+AMng==
X-Received: by 2002:a05:600c:2990:b0:3fe:485f:ed13 with SMTP id r16-20020a05600c299000b003fe485fed13mr9404349wmd.29.1692083478509;
        Tue, 15 Aug 2023 00:11:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:3100:c642:ba83:8c37:b0e? (p200300cbc7013100c642ba838c370b0e.dip0.t-ipconnect.de. [2003:cb:c701:3100:c642:ba83:8c37:b0e])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bca48000000b003fa96fe2bd9sm19977946wml.22.2023.08.15.00.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:11:17 -0700 (PDT)
Message-ID: <76e6b2ad-4e1e-2ad3-95df-00b4d33ec9d2@redhat.com>
Date:   Tue, 15 Aug 2023 09:11:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [BUG] Re: [PATCH v3 10/13] mm/khugepaged:
 collapse_pte_mapped_thp() with mmap_read_lock()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
 <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com>
 <CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com>
 <cacd4a19-386d-8bea-400-e99778dbc3b@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cacd4a19-386d-8bea-400-e99778dbc3b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.23 08:34, Hugh Dickins wrote:
> On Mon, 14 Aug 2023, Jann Horn wrote:
>> On Wed, Jul 12, 2023 at 6:42 AM Hugh Dickins <hughd@google.com> wrote:
>>> Bring collapse_and_free_pmd() back into collapse_pte_mapped_thp().
>>> It does need mmap_read_lock(), but it does not need mmap_write_lock(),
>>> nor vma_start_write() nor i_mmap lock nor anon_vma lock.  All racing
>>> paths are relying on pte_offset_map_lock() and pmd_lock(), so use those.
>>
>> We can still have a racing userfaultfd operation at the "/* step 4:
>> remove page table */" point that installs a new PTE before the page
>> table is removed.
>>
>> To reproduce, patch a delay into the kernel like this:
>>
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 9a6e0d507759..27cc8dfbf3a7 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/swapops.h>
>>   #include <linux/shmem_fs.h>
>>   #include <linux/ksm.h>
>> +#include <linux/delay.h>
>>
>>   #include <asm/tlb.h>
>>   #include <asm/pgalloc.h>
>> @@ -1617,6 +1618,11 @@ int collapse_pte_mapped_thp(struct mm_struct
>> *mm, unsigned long addr,
>>          }
>>
>>          /* step 4: remove page table */
>> +       if (strcmp(current->comm, "DELAYME") == 0) {
>> +               pr_warn("%s: BEGIN DELAY INJECTION\n", __func__);
>> +               mdelay(5000);
>> +               pr_warn("%s: END DELAY INJECTION\n", __func__);
>> +       }
>>
>>          /* Huge page lock is still held, so page table must remain empty */
>>          pml = pmd_lock(mm, pmd);
>>
>>
>> And then run the attached reproducer against mm/mm-everything. You
>> should get this in dmesg:
>>
>> [  206.578096] BUG: Bad rss-counter state mm:000000000942ebea
>> type:MM_ANONPAGES val:1
> 
> Thanks a lot, Jann. I haven't thought about it at all yet; and just
> tried to reproduce, but haven't yet got the "BUG: Bad rss-counter":
> just see "Invalid argument" on the UFFDIO_COPY ioctl.
> Will investigate tomorrow.

Maybe you're missing a fixup:

https://lkml.kernel.org/r/20230810192128.1855570-1-axelrasmussen@google.com

When the src address is not page aligned, UFFDIO_COPY in mm-unstable 
would erroneously fail.

-- 
Cheers,

David / dhildenb

