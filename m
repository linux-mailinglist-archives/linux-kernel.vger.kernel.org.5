Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C387DCCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjJaMIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbjJaMIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD14239
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698753537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=9TY9BTlqFgLhZbIpjJcIPfstT96f2DSA0CuHLc5kNN4=;
        b=DlD/kB7lWf8fQ4oGbtuW8sZcRK2DHJBR9mLslLmkNKVfqMXuT+CrsLmuGY1g/X78wuSTw5
        W8VFDKC8+62F1lS+6c2OjAm1vvLk6cy0t1V9FuqDwVkRmU69D8sNjjlhN/cgLteQxnWrVb
        sMH29hMkaqf3dsegJBEMk6p4MKiiMWk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-1Kbw8GHuN3K7yOsjj3PCKQ-1; Tue, 31 Oct 2023 07:58:55 -0400
X-MC-Unique: 1Kbw8GHuN3K7yOsjj3PCKQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5a7cc433782so53467327b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698753535; x=1699358335;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TY9BTlqFgLhZbIpjJcIPfstT96f2DSA0CuHLc5kNN4=;
        b=iXaaTeBb8MMlj7v7uyed7xxSNhOsunWF79DHTXF/DvmH6/s7wVhYYtmMMgn2ylYHHA
         cKqbt1+sdSRVAf0ov65UB/khCvMFyRRZNsUACFez7JfNgqXkKUQs73Tzu61v4o3IqcX0
         iHEJo1jfiuAZcYsRNN77U0zbL23j/59yqZ0NIp6FaK4PHp9Atu1r13HtLZqW0yH7tgwY
         AimNXrHElQaTvMWFUnOqPdDkQ74iZJ8Q8GBUcLwF+NZM9hn+FcgV5FrPp0A+bIy7uZ7t
         3ru6pskA5suzwETEyk91iJSdk7X1krwKlHrflDYCfkutDn/rPp5oOZJxN08/3dD1gcwi
         cMOw==
X-Gm-Message-State: AOJu0YweUh8dk6eeO/xu125KBIfqNcz7BbHB73VW/pk7Qm7uMVJA9UBC
        4mvkHFqFAi317BulzLePET7YNUeDTlkjG/3cGQlQuevxYpgMaxBrK1SmEbHvcb+mdnZfdyEJNZT
        oOXA1HM3ZNP98bv1WOzjXgpU6
X-Received: by 2002:a81:d206:0:b0:59c:a7f:ca7b with SMTP id x6-20020a81d206000000b0059c0a7fca7bmr8332258ywi.51.1698753534867;
        Tue, 31 Oct 2023 04:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELCEpiLOVQnaJQz27k7IYUw0zZaIBb05+G3bRfzR/pHZOZDHVZfXfQXdZ+PRJSBB5J0q/kAA==
X-Received: by 2002:a81:d206:0:b0:59c:a7f:ca7b with SMTP id x6-20020a81d206000000b0059c0a7fca7bmr8332242ywi.51.1698753534456;
        Tue, 31 Oct 2023 04:58:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:8f00:43b0:1107:57d2:28ee? (p200300cbc7078f0043b0110757d228ee.dip0.t-ipconnect.de. [2003:cb:c707:8f00:43b0:1107:57d2:28ee])
        by smtp.gmail.com with ESMTPSA id n18-20020ad444b2000000b0067169e210b3sm458681qvt.70.2023.10.31.04.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:58:54 -0700 (PDT)
Message-ID: <fbea7d70-d9fa-4322-99c6-1ad56bfbbb8c@redhat.com>
Date:   Tue, 31 Oct 2023 12:58:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
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
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
 <7a3a2d49-528d-4297-ae19-56aa9e6c59c6@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7a3a2d49-528d-4297-ae19-56aa9e6c59c6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.23 12:50, Ryan Roberts wrote:
> On 06/10/2023 21:06, David Hildenbrand wrote:
> [...]
>>
>> Change 2: sysfs interface.
>>
>> If we call it THP, it shall go under "/sys/kernel/mm/transparent_hugepage/", I
>> agree.
>>
>> What we expose there and how, is TBD. Again, not a friend of "orders" and
>> bitmaps at all. We can do better if we want to go down that path.
>>
>> Maybe we should take a look at hugetlb, and how they added support for multiple
>> sizes. What *might* make sense could be (depending on which values we actually
>> support!)
>>
>>
>> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/
>> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/
>> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/
>> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/
>> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/
>> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/
>>
>> Each one would contain an "enabled" and "defrag" file. We want something minimal
>> first? Start with the "enabled" option.
>>
>>
>> enabled: always [global] madvise never
>>
>> Initially, we would set it for PMD-sized THP to "global" and for everything else
>> to "never".
> 
> Hi David,

Hi!

> 
> I've just started coding this, and it occurs to me that I might need a small
> clarification here; the existing global "enabled" control is used to drive
> decisions for both anonymous memory and (non-shmem) file-backed memory. But the
> proposed new per-size "enabled" is implicitly only controlling anon memory (for
> now).

Anon was (way) first, and pagecache later decided to reuse that one as 
an indication whether larger folios are desired.

For the pagecache, it's just a way to enable/disable it globally. As 
there is no memory waste, nobody currently really cares about the exact 
sized the pagecache is allocating (maybe that will change at some point, 
maybe not, who knows).

> 
> 1) Is this potentially confusing for the user? Should we rename the per-size
> controls to "anon_enabled"? Or is it preferable to jsut keep it vague for now so
> we can reuse the same control for file-backed memory in future?

The latter would be my take. Just like we did with the global toggle.

> 
> 2) The global control will continue to drive the file-backed memory decision
> (for now), even when hugepages-2048kB/enabled != "global"; agreed?

That would be my take; it will allocate other sizes already, so just 
glue it to the global toggle and document for the other toggles that 
they only control anonymous THP for now.

-- 
Cheers,

David / dhildenb

