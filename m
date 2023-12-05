Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F62A804F53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjLEJ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346836AbjLEJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77B181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701770186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=tFjbNcunD8BMOPeYj96dPIDroGlPMDXu+W6kepYYR64=;
        b=RaNmwlOfvTwPSt223rzffSadcjUnPLg7QbFjS0qun3pPl8ELjgMuYjJYj40Edd+oan2wn9
        MJ8y3zGb/SlCxoheqM3Br5HegydIabHrJO2khOlMDDPhPU4gk88vA0gU4YAk6tMTATzMIC
        AtVgwcPcXGsMJY5jhxThJpRGJh2ePLk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-YBHHG1TvPBe0kF8Ya0TD0g-1; Tue, 05 Dec 2023 04:56:24 -0500
X-MC-Unique: YBHHG1TvPBe0kF8Ya0TD0g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33334e370d3so2698179f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770184; x=1702374984;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFjbNcunD8BMOPeYj96dPIDroGlPMDXu+W6kepYYR64=;
        b=LB7nk1O3ebCekjfM9gwC5FX/SyKvlErzR2X5t8TmckrbewLHB0jesqtGTvstxF8bKW
         cTDVaWbsXcXkGgdWnuEtyMaHvBlZtnHTOX6OZa7t6QGgH4lSPWNNLdTlWXZUxvPI3mMJ
         Y/LoZlqlkB3IL4jIImqjx8oFWGu7+ZsFmJ1+hAiPKpC4Hxh1RnSy2BAwupQWj2vx8Ovr
         3aq3oMio57Nr2XSt8OT895u0v4GMdmOoORc7qPkfYXaYSlYOSq8KZPu8khs7qQkI7lEy
         Hvt0aUhZGTyXxwX6XOWbAWLnrenjDD0LMIV+ww+8EA2BF6PWfgYEsfeCuqzdYWWiJBAx
         Tk8g==
X-Gm-Message-State: AOJu0YzUReEsWaNJwjlFEr5oeWjqgqeRSn1OQ92pScU93c/Fp9dX855o
        40JIR3UAKI1epYrv6QdXgscWyJZD5V2WZMa+FWtN6UiRhiYW1tb0vZ7YwdF913r1JfaEVv5w4it
        gkWCt4osEiCWWOwIZT5SCL0bAJgtqny6G
X-Received: by 2002:a5d:58f4:0:b0:332:fe7e:2a30 with SMTP id f20-20020a5d58f4000000b00332fe7e2a30mr3803654wrd.14.1701770183744;
        Tue, 05 Dec 2023 01:56:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlbLfdF1nWhniizPPXdkg1FUox9VPM6fJAb8DQ0+UBdPsQxX2pcEfdm0VdrieHm651cPMdhg==
X-Received: by 2002:a5d:58f4:0:b0:332:fe7e:2a30 with SMTP id f20-20020a5d58f4000000b00332fe7e2a30mr3803646wrd.14.1701770183305;
        Tue, 05 Dec 2023 01:56:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d4490000000b003333e71ef9asm8004884wrq.115.2023.12.05.01.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:56:22 -0800 (PST)
Message-ID: <067753e4-faf0-4bc0-9703-ec97b7de705e@redhat.com>
Date:   Tue, 5 Dec 2023 10:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/39] mm/rmap: interface overhaul
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <993ea322-8cdb-4ab1-84d3-0a1cb40049c9@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <993ea322-8cdb-4ab1-84d3-0a1cb40049c9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Ryan has series where we would make use of folio_remove_rmap_ptes() [1]
>> -- he carries his own batching variant right now -- and
>> folio_try_dup_anon_rmap_ptes()/folio_dup_file_rmap_ptes() [2].
> 
> Note that the contpte series at [2] has a new patch in v3 (patch 2), which could
> benefit from folio_remove_rmap_ptes() or equivalent. My plan was to revive [1]
> on top of [2] once it is merged.
> 
>>
>> There is some overlap with both series (and some other work, like
>> multi-size THP [3]), so that will need some coordination, and likely a
>> stepwise inclusion.
> 
> Selfishly, I'd really like to get my stuff merged as soon as there is no
> technical reason not to. I'd prefer not to add this as a dependency if we can
> help it.

It's easy to rework either series on top of each other. The mTHP series has highest priority,
no question, that will go in first.

Regarding the contpte, I think it needs more work. Especially, as raised, to not degrade
order-0 performance. Maybe we won't make the next merge window (and you already predicated
that in some cover letter :P ). Let's see.

But again, the conflicts are all trivial, so I'll happily rebase on top of whatever is
in mm-unstable. Or move the relevant rework to the front so you can just carry
them/base on them. (the batched variants for dup do make the contpte code much easier)

[...]

>>
>>
>> New (extended) hugetlb interface that operate on entire folio:
>>   * hugetlb_add_new_anon_rmap() -> Already existed
>>   * hugetlb_add_anon_rmap() -> Already existed
>>   * hugetlb_try_dup_anon_rmap()
>>   * hugetlb_try_share_anon_rmap()
>>   * hugetlb_add_file_rmap()
>>   * hugetlb_remove_rmap()
>>
>> New "ordinary" interface for small folios / THP::
>>   * folio_add_new_anon_rmap() -> Already existed
>>   * folio_add_anon_rmap_[pte|ptes|pmd]()
>>   * folio_try_dup_anon_rmap_[pte|ptes|pmd]()
>>   * folio_try_share_anon_rmap_[pte|pmd]()
>>   * folio_add_file_rmap_[pte|ptes|pmd]()
>>   * folio_dup_file_rmap_[pte|ptes|pmd]()
>>   * folio_remove_rmap_[pte|ptes|pmd]()
> 
> I'm not sure if there are official guidelines, but personally if we are
> reworking the API, I'd take the opportunity to move "rmap" to the front of the
> name, rather than having it burried in the middle as it is for some of these:
> 
> rmap_hugetlb_*()
> 
> rmap_folio_*()

No strong opinion. But we might want slightly different names then. For example,
it's "bio_add_folio" and not "bio_folio_add":


rmap_add_new_anon_hugetlb()
rmap_add_anon_hugetlb()
...
rmap_remove_hugetlb()


rmap_add_new_anon_folio()
rmap_add_anon_folio_[pte|ptes|pmd]()
...
rmap_dup_file_folio_[pte|ptes|pmd]()
rmap_remove_folio_[pte|ptes|pmd]()

Thoughts?

> 
> I guess reading the patches will tell me, but what's the point of "ptes"? Surely
> you're either mapping at pte or pmd level, and the number of pages is determined
> by the folio size? (or presumably nr param passed in)

It's really (currently) one function to handle 1 vs. multiple PTEs. For example:

void folio_remove_rmap_ptes(struct folio *, struct page *, unsigned int nr,
		struct vm_area_struct *);
#define folio_remove_rmap_pte(folio, page, vma) \
	folio_remove_rmap_ptes(folio, page, 1, vma)
void folio_remove_rmap_pmd(struct folio *, struct page *,
		struct vm_area_struct *);


Once could let the compiler generate specialized variants for the single-pte
versions to make the order-0 case faster. For now it's just a helper macro.

-- 
Cheers,

David / dhildenb

