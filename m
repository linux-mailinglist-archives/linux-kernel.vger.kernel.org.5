Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873B806A86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjLFJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B7D4D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701854272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Eleg+pE/R+BnHgWT+QuZEqcgCjnh9bHSZKzS94qCP7w=;
        b=XoOBMuHaiOClMHIcu2JnqjnaaPhyGZiAq8bYAGhe6OHmuJW8YUWnfq+GIFFWePjjsrVjfQ
        vHicO4yAQZpXj2Qa/azCf0jnc7oiAMcqLqg71tWFGWGUQy/eyJ+aVoHe+H8nLISlgqUJeg
        i3HkWuCbkHeXxnSybGaHcgcVVZA9RZg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494--YI8fEJiMwC3_pPofVnGMg-1; Wed, 06 Dec 2023 04:17:51 -0500
X-MC-Unique: -YI8fEJiMwC3_pPofVnGMg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c1257782fso12279615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701854270; x=1702459070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eleg+pE/R+BnHgWT+QuZEqcgCjnh9bHSZKzS94qCP7w=;
        b=WOOdteRxkIy4gMLMQI2DOhiBp1yh/I4JM7u0IQXSiao0kyTSa5AZVsVULK00kVAc6T
         A+nLTHEwxXa5E+6f5saw8EpIQBJ0Yq7P68h6IwbsDD5Y0DZkquqpz1JG6LVH8xhPa78W
         qjI43xNO0Tf2N7i5aWfe1GeziXFS8HFdD73CFvCtAN6y3B3DMexrJWpEUNsDVsVYAGXB
         usd7n+jaP87YfGIds4YwV1QKdZ92/bH4gz8tV9BHa2TAqV0bOPBZ4FoULEr0Hq4MhhJn
         Az/W5wWw2UQtZgtKlSh3Rn+ADQ4vhjBIMYxut0jaKLJYFQeqoU1qEL6RWPNrZhWs4pvw
         ZkJw==
X-Gm-Message-State: AOJu0YzUzQ+wJxGZ9S9lA8XW0fif0Twjw9jgZtm2AiYCWBPdMyCMR4+8
        2i+A0QgJOcx2hP2QSpG4qBZCCw7cbPgEGTALney2jKmYT2I38QsjH1NHOOl8tdA3fAQ3AjAB5Up
        CNC6FEs0nIFE4975O3kafsCFC
X-Received: by 2002:a05:600c:1e24:b0:40c:709:d924 with SMTP id ay36-20020a05600c1e2400b0040c0709d924mr361269wmb.147.1701854269689;
        Wed, 06 Dec 2023 01:17:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnNvYZ9E+Rd4ZGT4BMa3yUJznXzkNiJ5+PR0E9T/A9POYeopO+Hj2OEscQF7QLC32L1eCdrQ==
X-Received: by 2002:a05:600c:1e24:b0:40c:709:d924 with SMTP id ay36-20020a05600c1e2400b0040c0709d924mr361252wmb.147.1701854269301;
        Wed, 06 Dec 2023 01:17:49 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b00405959469afsm21255103wmb.3.2023.12.06.01.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 01:17:48 -0800 (PST)
Message-ID: <3488f910-891d-48bf-a5da-5bc01955b072@redhat.com>
Date:   Wed, 6 Dec 2023 10:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/39] mm/rmap: convert folio_add_file_rmap_range()
 into folio_add_file_rmap_[pte|ptes|pmd]()
Content-Language: en-US
To:     Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-8-david@redhat.com>
 <12d26867-c6cf-4927-bc89-124a0179dfe4@intel.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <12d26867-c6cf-4927-bc89-124a0179dfe4@intel.com>
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

On 06.12.23 02:30, Yin Fengwei wrote:
> 
> 
> On 12/4/23 22:21, David Hildenbrand wrote:
>> Let's get rid of the compound parameter and instead define implicitly
>> which mappings we're adding. That is more future proof, easier to read
>> and harder to mess up.
>>
>> Use an enum to express the granularity internally. Make the compiler
>> always special-case on the granularity by using __always_inline.
>>
>> Add plenty of sanity checks with CONFIG_DEBUG_VM. Replace the
>> folio_test_pmd_mappable() check by a config check in the caller and
>> sanity checks. Convert the single user of folio_add_file_rmap_range().
>>
>> This function design can later easily be extended to PUDs and to batch
>> PMDs. Note that for now we don't support anything bigger than
>> PMD-sized folios (as we cleanly separated hugetlb handling). Sanity checks
>> will catch if that ever changes.
> I do have a question for the folio which has larger size than PMD in the
> future:
>     Will the folio size be only just like PMD size/PUD size? Or it's possible between
>     PUD size and PMD size?

I strongly assume that we'll see in the future folios larger than a 
single PMD (for example, 4 MiB on x86-64).

This will require quite some care in other areas (and this series, as it 
converts some PMD handling function to folios, further prepares for that).

> 
>     If it's possible between PUD size and PMD size, will the mapping be mixed PMD mapping
>     and PTE mapping or just PTE mapping. I suppose it could be mixed because of efficiency
>     of page walker.

Depending on with which alignment such larger folios are mapped into the 
page tables and some other factors, we might indeed end up having parts 
of the folio mapped by PMDs and parts by PTEs. Well, and once we involve 
PUDs we might have a mixture of all of these :)

The current API here will be able to deal with that (excluding the _pud 
variant). To improve performance, we might want PMD batching and have 
_pmds functions.

We'll have to tweak the rmap internals to do the rmap accounting 
properly then (and the sanity checks will catch any of that and 
highlight the need for rmap-internal extensions); maybe once we come to 
that, we no longer have these subpage mapcounts, but we'll have to see 
if/when/how that happens.

> 
> It may just be too early to consider this now.
> 

I had that in mind while working on this. I assume it will take some 
more time to handle everything else that needs to be prepared for that, 
but the rmap interface should be able to handle that, only the internals 
will have to be extended.


Thanks!

-- 
Cheers,

David / dhildenb

