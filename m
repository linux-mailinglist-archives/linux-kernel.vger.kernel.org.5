Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AD3810CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjLMIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:47:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0FA0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702457259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=vg8CdVRuMIwGTUfTgX2ezMiuczJo0pzbvsAHgGX9hak=;
        b=Jlzd3D+tv6TZKzV5LJ03btDTJ1nStpPAcATPcLp2fLRTNeFCGGwwSG1D2ozAgepoFWUmY+
        Gt6AqJMnW3kJxJMHo7zubfHT0PTvRc4/W9+fw1Us8LMDBIwbjEyMP/cC8mxnEOjDepYCHi
        3wEDHoYhutIyBV7h+3yztH2I17fM5vA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-xmRLdJzFPwe7jGHFPAh0fA-1; Wed, 13 Dec 2023 03:47:37 -0500
X-MC-Unique: xmRLdJzFPwe7jGHFPAh0fA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c3826d6feso29220065e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457256; x=1703062056;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg8CdVRuMIwGTUfTgX2ezMiuczJo0pzbvsAHgGX9hak=;
        b=Zv1bnlHiR4cSXHH181ZJhkuExTS+gnYkGesmlKblQ3R+VXAbl3G97YiGcbhrPqLsvJ
         nNSazS9fFJCEECTXOTBcUZcawojKwltaGVYdFVvKRFxLNnmTJUKS7A3cvuitXhh00ED0
         kCpkFdUTJWmhO2lOAPPZ3X8hpoLrF2t12s5PXyOVLhspiq8AuyYnYorTUId6g7wg5TGS
         fU76yNKpy6iMKumX8sr/UraXyyaejS7hP483Noq/wxgsOBiyDti28pZLO2IP7j+BVd2O
         BVWNxV80BVVUPnLKm2k35ckbu9ptO20XqJQw3N/gufNIbCbIe/pIkUeUCKrcHmuziMyr
         MbVg==
X-Gm-Message-State: AOJu0YzN0+l1A6B7I6sydQDjUcMMFTE5+t6VM5sOvuVRyzt8IyyxRGYE
        WYV0Ef/dXl/M+pBImOUPlkmhyZ3MK1EPyl+ouuO4ylwKzyG+AgLz/pyLi7ZkMWumMS1S9o7VbcP
        dPcJRZdEog4RvmX9IbxGGxrrp
X-Received: by 2002:a05:600c:1715:b0:40b:5e22:95d with SMTP id c21-20020a05600c171500b0040b5e22095dmr4805642wmn.76.1702457255967;
        Wed, 13 Dec 2023 00:47:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEme2zhDBy3UZvKVHQK+oNA+NSpBqO1G9kezoWLwuvfoBnp/5/byMuyeB0otGWszB4vgcljCQ==
X-Received: by 2002:a05:600c:1715:b0:40b:5e22:95d with SMTP id c21-20020a05600c171500b0040b5e22095dmr4805627wmn.76.1702457255473;
        Wed, 13 Dec 2023 00:47:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6e00:7e5:5f4d:f300:5d52? (p200300cbc7096e0007e55f4df3005d52.dip0.t-ipconnect.de. [2003:cb:c709:6e00:7e5:5f4d:f300:5d52])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0040c45cabc34sm11211263wmo.17.2023.12.13.00.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 00:47:35 -0800 (PST)
Message-ID: <2a844544-1109-4d77-b1d5-666553c2fec6@redhat.com>
Date:   Wed, 13 Dec 2023 09:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/39] mm/rmap: convert folio_add_file_rmap_range()
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
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-8-david@redhat.com>
 <d4b2c0be-1885-455c-8f26-a23b3db537c6@intel.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d4b2c0be-1885-455c-8f26-a23b3db537c6@intel.com>
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

On 13.12.23 06:33, Yin Fengwei wrote:
> 
> 
> On 2023/12/11 23:56, David Hildenbrand wrote:
>> Let's get rid of the compound parameter and instead define implicitly
>> which mappings we're adding. That is more future proof, easier to read
>> and harder to mess up.
>>
>> Use an enum to express the granularity internally. Make the compiler
>> always special-case on the granularity by using __always_inline. Replace
>> the "compound" check by a switch-case that will be removed by the
>> compiler completely.
>>
>> Add plenty of sanity checks with CONFIG_DEBUG_VM. Replace the
>> folio_test_pmd_mappable() check by a config check in the caller and
>> sanity checks. Convert the single user of folio_add_file_rmap_range().
>>
>> This function design can later easily be extended to PUDs and to batch
>> PMDs. Note that for now we don't support anything bigger than
>> PMD-sized folios (as we cleanly separated hugetlb handling). Sanity checks
>> will catch if that ever changes.
>>
>> Next up is removing page_remove_rmap() along with its "compound"
>> parameter and smilarly converting all other rmap functions.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> 

Thanks!

> With one small comment.
> 
>> ---
>>    include/linux/rmap.h | 47 +++++++++++++++++++++++++--
>>    mm/memory.c          |  2 +-
>>    mm/rmap.c            | 75 +++++++++++++++++++++++++++++---------------
>>    3 files changed, 95 insertions(+), 29 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index e3857d26b944..1753900f4aed 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -191,6 +191,45 @@ typedef int __bitwise rmap_t;
>>     */
>>    #define RMAP_COMPOUND		((__force rmap_t)BIT(1))
>>    
>> +/*
>> + * Internally, we're using an enum to specify the granularity. Usually,
>> + * we make the compiler create specialized variants for the different
>> + * granularity.
>> + */
>> +enum rmap_mode {
>> +	RMAP_MODE_PTE = 0,
>> +	RMAP_MODE_PMD,
>> +};
> Maybe rmap_level for enum name? To me, PTE and PMD are level instead of
> mode.

Originally, I wanted to call this "enum rmap_granularity", but that 
turned out rather long. Agreed that "level" is better than "mode", 
something resembling "granularity" would be even better.

-- 
Cheers,

David / dhildenb

