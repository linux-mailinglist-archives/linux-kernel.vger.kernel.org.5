Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8612D78E775
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243661AbjHaH6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244303AbjHaH6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7FA4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693468672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMSp8JxFtHZeRBC/fQLH1dpfeLSCYczBKIaSZ0ygFTo=;
        b=Z0GmwKgpaqduHb9reW9+sduxBXM+wLQ0tjabQmwlI/ThiyyDecmCKGf3VfMT7mM/o0AW+H
        B1Rl7gunQfcrqKtqB1x4DzsMz3UFjV6Fow/XSnlpfQFOZGUjIakE7vy83ZLyWzKyzMMMBp
        GiUWPJb1eYdTw2fLw24Hs1hlWaSd+kk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ZVrdEs1-Om6hLQaqL-Ah_A-1; Thu, 31 Aug 2023 03:57:51 -0400
X-MC-Unique: ZVrdEs1-Om6hLQaqL-Ah_A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31c470305cfso252386f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693468670; x=1694073470;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMSp8JxFtHZeRBC/fQLH1dpfeLSCYczBKIaSZ0ygFTo=;
        b=g80SFp6h3NpC0M7llGJtrTWT0x1q0IPbf+yRkhbxbXY6cFmcaqD+15om8d8y9lhh9d
         0HC52bcsbHvOB/6bK/a8Ihw/wHGxtAKx528lIYtf9mOhDxH3XHs8+Ag6cQVCM9JW2YM2
         sKPev9a/YP7rMvYgi+FViKrlLZzzFHAKfNNm5CYm5FGkjV1mVnH5kChkY3woYFTGWZMI
         9oD3Vn3RxuqYFUJUdOV8dzix1Ajt/YxtYpsvAIA7J2VuVJBLdW66z76VSOUpkCv9LcgG
         ZOZhUXy+fU//zQzDNUDMwQgeRM4PYsMxWxDsmGWfFYir8PI7pgpVn1sHldKs9a5e6WCa
         NBiQ==
X-Gm-Message-State: AOJu0YxWwzRtHnn3b+audkywrJZeJTCWRYzsE+lORDgRyW2k+rM6YXL/
        u7x2Wrn/KHXLTQfEOds6pCazjNDC91u7zwZXAypdaTiWo+eXyxqlSFIuuyxxdV/XoZfhizullwe
        lIaawF9XwiQSqPvbEgll0hsLp
X-Received: by 2002:adf:f810:0:b0:319:8cc9:6d9b with SMTP id s16-20020adff810000000b003198cc96d9bmr3058461wrp.8.1693468669785;
        Thu, 31 Aug 2023 00:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmf9db3nUPfPoa19iO4dhVJUc1/FRSk62XgaHiLc1gUr0i4tAPTMDJpCSPchW+Ucy0bLAPBQ==
X-Received: by 2002:adf:f810:0:b0:319:8cc9:6d9b with SMTP id s16-20020adff810000000b003198cc96d9bmr3058445wrp.8.1693468669310;
        Thu, 31 Aug 2023 00:57:49 -0700 (PDT)
Received: from [10.59.19.200] (pd956a06e.dip0.t-ipconnect.de. [217.86.160.110])
        by smtp.gmail.com with ESMTPSA id y1-20020adff6c1000000b00317a29af4b2sm1290796wrp.68.2023.08.31.00.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 00:57:48 -0700 (PDT)
Message-ID: <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
Date:   Thu, 31 Aug 2023 09:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
 <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
In-Reply-To: <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.23 03:40, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 15/08/2023 22:32, Huang, Ying wrote:
>>> Hi, Ryan,
>>>
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>> allocated in large folios of a determined order. All pages of the large
>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>> counting, rmap management lru list management) are also significantly
>>>> reduced since those ops now become per-folio.
>>>>
>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>> which defaults to disabled for now; The long term aim is for this to
>>>> defaut to enabled, but there are some risks around internal
>>>> fragmentation that need to be better understood first.
>>>>
>>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>>> where fallback (>) is performed for various reasons, such as the
>>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>>
>>>>                  | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>                  | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>> ----------------|-----------|-------------|---------------|-------------
>>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>
>>> IMHO, we should use the following semantics as you have suggested
>>> before.
>>>
>>>                  | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>                  | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>> ----------------|-----------|-------------|---------------|-------------
>>> no hint         | S         | S           | LAF>S         | THP>LAF>S
>>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>
>>> Or even,
>>>
>>>                  | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>                  | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>> ----------------|-----------|-------------|---------------|-------------
>>> no hint         | S         | S           | S             | THP>LAF>S
>>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>
>>>  From the implementation point of view, PTE mapped PMD-sized THP has
>>> almost no difference with LAF (just some small sized THP).  It will be
>>> confusing to distinguish them from the interface point of view.
>>>
>>> So, IMHO, the real difference is the policy.  For example, prefer
>>> PMD-sized THP, prefer small sized THP, or fully auto.  The sysfs
>>> interface is used to specify system global policy.  In the long term, it
>>> can be something like below,
>>>
>>> never:      S               # disable all THP
>>> madvise:                    # never by default, control via madvise()
>>> always:     THP>LAF>S       # prefer PMD-sized THP in fact
>>> small:      LAF>S           # prefer small sized THP
>>> auto:                       # use in-kernel heuristics for THP size
>>>
>>> But it may be not ready to add new policies now.  So, before the new
>>> policies are ready, we can add a debugfs interface to override the
>>> original policy in /sys/kernel/mm/transparent_hugepage/enabled.  After
>>> we have tuned enough workloads, collected enough data, we can add new
>>> policies to the sysfs interface.
>>
>> I think we can all imagine many policy options. But we don't really have much
>> evidence yet for what it best. The policy I'm currently using is intended to
>> give some flexibility for testing (use LAF without THP by setting sysfs=never,
>> use THP without LAF by compiling without LAF) without adding any new knobs at
>> all. Given that, surely we can defer these decisions until we have more data?
>>
>> In the absence of data, your proposed solution sounds very sensible to me. But
>> for the purposes of scaling up perf testing, I don't think its essential given
>> the current policy will also produce the same options.
>>
>> If we were going to add a debugfs knob, I think the higher priority would be a
>> knob to specify the folio order. (but again, I would rather avoid if possible).
> 
> I totally understand we need some way to control PMD-sized THP and LAF
> to tune the workload, and nobody likes debugfs knob.
> 
> My concern about interface is that we have no way to disable LAF
> system-wise without rebuilding the kernel.  In the future, should we add
> a new policy to /sys/kernel/mm/transparent_hugepage/enabled to be
> stricter than "never"?  "really_never"?

Let's talk about that in a bi-weekly MM session. (I proposed it as a 
topic for next week).

As raised in another mail, we can then discuss
* how we want to call this feature (transparent large pages? there is
   the concern that "THP" might confuse users. Maybe we can consider
   "large" the more generic version and "huge" only PMD-size, TBD)
* how to expose it in stats towards the user (e.g., /proc/meminfo)
* which minimal toggles we want

I think there *really* has to be a way to disable it for a running 
system, otherwise no distro will dare pulling it in, even after we 
figured out the other stuff.

Note that for the pagecache, large folios can be disabled and 
distributions are actively making use of that.

-- 
Cheers,

David / dhildenb

