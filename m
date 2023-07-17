Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D5756988
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGQQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D9101
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689612542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20NvLLdOaNLu4aJrHywdmmhB5ykRAnAniiQZ1Nfr4ks=;
        b=Jdzx/91F77useJmW/zP+vl3E/1hCXLKAntyH7XwYjuU5DIDWOT3f9znWEQOfefpV3dMOQ1
        7ghU6iMknejjepxQkt1q+5mjaXwKnezHJtf0RXVM/vly2tSEINQcmSsbs75dtK2pKyCVuw
        LmbmWcCFt/4IRXP2Reoroo96LBjqGOQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-TUlZszmANX-E0UJB8Lon4w-1; Mon, 17 Jul 2023 12:49:01 -0400
X-MC-Unique: TUlZszmANX-E0UJB8Lon4w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa976b8b6fso29275075e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612540; x=1692204540;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20NvLLdOaNLu4aJrHywdmmhB5ykRAnAniiQZ1Nfr4ks=;
        b=DI9s+VvaFRBK9z8jEekf03YLWQ1Fi1ItX374nnH/TZHkYogNFDUkOp4qiwGVJKSeO+
         Ts09GOZ0C1/lFabvG6r5Q31E/DfUSfM9YkoSBtFP4fMPKqRSYNsmJG02oHzfYrPNLGJP
         8uX+80zOEu3mnmkoTyW4otgRJmeEVS9lRjwBTHrnRHo/aBJ8P6ojfLTJUiXoiU4AIkkM
         3VNTBE8pehO8BVO9PbZQLc1aIficu4O67xRPX8YNste9miuyQW3QCBVLYhV8snzPo7GS
         a9ypeBxGIKo8jZPTbv9jcprTaBIKyWYxAO/xwe87I77Nhw4YZ+dNTp4vQTPNg+ZOCPax
         0FGg==
X-Gm-Message-State: ABy/qLbYaE+GpS/b37sOm+0M5JkhXi/vBH6CtrI5j6WD9DD+6XHpZpTN
        sXJ+C9O6842rhbHJACqKYp2RrtbhD/VFoybf1lYiP69cJ5ATMNiLDbXjN4odKXKzao0OSrFRqpu
        tMBOfShJGJH8dMsf0QjlPbx8P
X-Received: by 2002:a7b:ca5a:0:b0:3f7:3991:e12e with SMTP id m26-20020a7bca5a000000b003f73991e12emr10887816wml.1.1689612539943;
        Mon, 17 Jul 2023 09:48:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqj+aXN+NrCadDFIJThoMs1c3oEThy9rWZ4jo6fPlGWYpnEdDavnlVWTcWHLhG0rkm7NNyVQ==
X-Received: by 2002:a7b:ca5a:0:b0:3f7:3991:e12e with SMTP id m26-20020a7bca5a000000b003f73991e12emr10887807wml.1.1689612539619;
        Mon, 17 Jul 2023 09:48:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b003fc00702f65sm8323118wmj.46.2023.07.17.09.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 09:48:59 -0700 (PDT)
Message-ID: <0250a2d7-c79b-0e0f-8161-bf475daf1c82@redhat.com>
Date:   Mon, 17 Jul 2023 18:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
 <90b406af-9db4-b668-a7a0-e574e104c84c@redhat.com>
 <028c5f5b-b67c-9ccc-bc06-468f47362999@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <028c5f5b-b67c-9ccc-bc06-468f47362999@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.23 18:01, Ryan Roberts wrote:
> On 17/07/2023 16:42, David Hildenbrand wrote:
>> On 17.07.23 16:31, Ryan Roberts wrote:
>>> In preparation for the introduction of large folios for anonymous
>>> memory, we would like to be able to split them when they have unmapped
>>> subpages, in order to free those unused pages under memory pressure. So
>>> remove the artificial requirement that the large folio needed to be at
>>> least PMD-sized.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>> ---
>>>    mm/rmap.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 0c0d8857dfce..2baf57d65c23 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1430,7 +1430,7 @@ void page_remove_rmap(struct page *page, struct
>>> vm_area_struct *vma,
>>>             * page of the folio is unmapped and at least one page
>>>             * is still mapped.
>>>             */
>>> -        if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>>> +        if (folio_test_large(folio) && folio_test_anon(folio))
>>>                if (!compound || nr < nr_pmdmapped)
>>>                    deferred_split_folio(folio);
>>
>> !compound will always be true I guess, so nr_pmdmapped == 0 (which will always
>> be the case) will be ignored.
> 
> I don't follow why !compound will always be true. This function is
> page_remove_rmap() (not folio_remove_rmap_range() which I add in a later patch).
> page_remove_rmap() can work on pmd-mapped pages where compound=true is passed in.

I was talking about the folio_test_pmd_mappable() -> folio_test_large() 
change. For folio_test_large() && !folio_test_pmd_mappable() I expect 
that we'll never pass in "compound=true".

-- 
Cheers,

David / dhildenb

