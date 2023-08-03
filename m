Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5476EC0B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjHCOMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjHCOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6387B4C1A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691071822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPNYecHu16O9Ut2w98fGEf3Yo08xy4t1WgY+3ixBHos=;
        b=aQNbgL+TG/C06Hk0IjcVFXS7Nz+VWfpJUC77EoNReAtwob2ZkNmaLn5rVNDBRJo/PNgGJ9
        kh1SjRhY2Cbo0EIppnHdNeCj/Brxx3qG3YcjEWysmBufittuUjyhNBF8USEJKJmVoMD6Xm
        HFlYN0vi4hqM6ZVe5dvFA/ImLOw4uFA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-yyGZCYKXNiich_Eo89qT_w-1; Thu, 03 Aug 2023 10:10:20 -0400
X-MC-Unique: yyGZCYKXNiich_Eo89qT_w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3176c4de5bbso527627f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071819; x=1691676619;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPNYecHu16O9Ut2w98fGEf3Yo08xy4t1WgY+3ixBHos=;
        b=Cjry6hvpG1vCsXUWZZT7k/68TgD4FZa6q8xarKwM4muJ70O1/ITyj69r+OdDmj1P3p
         FdOv97ShmmgVK7TxHl2iHuSjoo9NewgoavIpxcphPFA3q3paRElh9glCBXw6L6ReKsmL
         mvC3yMwIeV0TpX1xBiluTWtW1UUd3n/RG3LXiffcx0G5KmUjA27HagRyxRMR9fOE6SJ7
         ikHi5jyQt56ySCuaD0u6jB25tnwY9Srptwlay+fmGJtdhjK+5Y9WDUZbEl8OWxM/z5MF
         O5FpCMIF6/wc89K4QoL8Egn+kWq3qL840XOnvmLIWZy7ZUadPTBNYNECatVywcQocDd/
         UUiQ==
X-Gm-Message-State: ABy/qLbShpYAsbzJySZmblLPxSZANC70MQOOjZdPzK9Ey21cMbU7qxSE
        QemvUbevwYdI6OyJEtpElvVBfQjKD2I8fxi4gHcSAMW+pEUuQ2bANmCbyImO2niH748DK8+obVm
        t2Efyyc/gohnUhqUlX1JCw1EY
X-Received: by 2002:adf:e505:0:b0:315:9ee6:132f with SMTP id j5-20020adfe505000000b003159ee6132fmr7302700wrm.68.1691071819421;
        Thu, 03 Aug 2023 07:10:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJfgJw/tqsvdJvQR/uuuE5dJvRmtkylfqqPX2lYImbVVHLI92KUgmsAn5xWjx+MJ1hZlfajA==
X-Received: by 2002:adf:e505:0:b0:315:9ee6:132f with SMTP id j5-20020adfe505000000b003159ee6132fmr7302673wrm.68.1691071818968;
        Thu, 03 Aug 2023 07:10:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0031762e89f94sm21894524wrf.117.2023.08.03.07.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:10:18 -0700 (PDT)
Message-ID: <b54e7885-3e49-150f-cf8a-36a880e5dfc9@redhat.com>
Date:   Thu, 3 Aug 2023 16:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com>
 <6cda91b3-bb7a-4c4c-a618-2572b9c8bbf9@redhat.com>
 <4255e71a-63c9-b2f9-5e97-e46834f7837c@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
In-Reply-To: <4255e71a-63c9-b2f9-5e97-e46834f7837c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

>>
>> With this patch, you'll might suddenly have mapcount > refcount for a folio, or
>> am I wrong?
> 
> Yes you would. Does that break things?
> 

It is problematic whenever you want to check for additional page 
references that are not from mappings (i.e., GUP refs/pins or anything else)

One example lives in KSM code (!compound only):

page_mapcount(page) + 1 + swapped != page_count(page)

Another one in compaction code:

if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))

And another one in khugepaged (is_refcount_suitable)

... and in THP split can_split_folio() (although that can deal with 
false positives and false negatives).


We want to avoid detecting "no other references" if there *are* other 
references. Detecting "there are other references" although there are 
not is usually better.


Assume you have mapcount > refcount for some time due to concurrent 
unmapping, AND some unrelated reference. You would suddenly pass these 
checks (mapcount == refcount) and might not detect other references.

>>
>>> +
>>> +    for (i = 0; i < nr_pages;) {
>>> +        ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>> +        tlb_remove_tlb_entry(tlb, pte, addr);
>>> +        zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
>>> +        full = __tlb_remove_page(tlb, page, 0);
>>> +
>>> +        if (unlikely(page_mapcount(page) < 1))
>>> +            print_bad_pte(vma, addr, ptent, page);
>>
>> Can we avoid new users of page_mapcount() outside rmap code, please? :)
> 
> Sure. This is just trying to replicate the same diagnstics that's done on the
> non-batched path. I'm happy to remove it.

Spotted it afterwards in the existing code already, so you're effetively 
not adding new ones.

-- 
Cheers,

David / dhildenb

