Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC676ECE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjHCOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbjHCOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE25257
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691073548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2yiRUXToo5dJqxKCedx3xrnV1At5a7zF8MhIPUWxqQ=;
        b=ThQJZpHcqw6ah9Ki85MjkPzPbEyzKGAwGY+8nxAy5jXhyalwclphHt8HFdpgwJBtfTjO46
        N+devw+hRYqzRRiwnHc6kB8kTfGRXjeweK1ShktV9rjn1KUd6qdUfHzxYbM+2i2KI8dASI
        Lz4Pp1sm2f9Wik/qlR2g7Ofbp6sosHw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-0bqAyRXVO7KLrMARhxE-SQ-1; Thu, 03 Aug 2023 10:21:44 -0400
X-MC-Unique: 0bqAyRXVO7KLrMARhxE-SQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31758708b57so626760f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072503; x=1691677303;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2yiRUXToo5dJqxKCedx3xrnV1At5a7zF8MhIPUWxqQ=;
        b=LfWd9g88+mwPA1hlghUMDtTBaYIwiovjgAxuu96GJYtsP4VCuLOvuj5UU6hHIbW6SA
         quj092E4KqS+HbGHYARcqNKnsxL5z0J027gNoD0xlWB2h1mUPqKfoZ+OOY9DAfJYeaJa
         dIt5k8DQncIxweb5RiCsDYWtfnYKG7gBQuXCwUUnKn5uOXZxsC+8jtgVp4iiHFL2gXJQ
         9LLUzbCg10XMpx6Kv7p0pQPPxgBsJf4KK+XPth12Xum9E0hCpVP+OJF5yJTVy033wwEa
         70A3iTUAd6TkdshiuMB6z1MO8wxtYH8iVn0kuPH1a8yT61QMGya9MKjQ3ZHZ3NljHYlp
         Ttkg==
X-Gm-Message-State: ABy/qLbjF/PmwOZQdX16GEadEGxlPdtvcz1RTJCgXPgHJ0fhnaLtfewJ
        hcKbtQ8beLJ9MFJXnjCEklzzUywrZRKFZKfgRxVJBJ+HBzOU9OfJd4RSzfgx9BQmeThaorEy0re
        1uvypkotirNt+nwz5hesZ1K+O
X-Received: by 2002:a5d:510a:0:b0:314:bdb:cf71 with SMTP id s10-20020a5d510a000000b003140bdbcf71mr7958346wrt.53.1691072503377;
        Thu, 03 Aug 2023 07:21:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEoKLeR8twzhSbAZm0I6RxWS45CD2PcT03DYvDx1v3JuJcxYHcW4fFZFKwkYMBxaPWVbQIFGg==
X-Received: by 2002:a5d:510a:0:b0:314:bdb:cf71 with SMTP id s10-20020a5d510a000000b003140bdbcf71mr7958326wrt.53.1691072502978;
        Thu, 03 Aug 2023 07:21:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id b18-20020adfe312000000b0031437ec7ec1sm22113249wrj.2.2023.08.03.07.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:21:42 -0700 (PDT)
Message-ID: <6fe2dd45-d634-facc-bb8a-3052ab463abb@redhat.com>
Date:   Thu, 3 Aug 2023 16:21:41 +0200
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
 <b54e7885-3e49-150f-cf8a-36a880e5dfc9@redhat.com>
 <bb871b52-526a-d4aa-5249-6105bc06aaba@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
In-Reply-To: <bb871b52-526a-d4aa-5249-6105bc06aaba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 03.08.23 16:15, Ryan Roberts wrote:
> On 03/08/2023 15:10, David Hildenbrand wrote:
>>>>
>>>> With this patch, you'll might suddenly have mapcount > refcount for a folio, or
>>>> am I wrong?
>>>
>>> Yes you would. Does that break things?
>>>
>>
>> It is problematic whenever you want to check for additional page references that
>> are not from mappings (i.e., GUP refs/pins or anything else)
>>
>> One example lives in KSM code (!compound only):
>>
>> page_mapcount(page) + 1 + swapped != page_count(page)
>>
>> Another one in compaction code:
>>
>> if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))
>>
>> And another one in khugepaged (is_refcount_suitable)
>>
>> ... and in THP split can_split_folio() (although that can deal with false
>> positives and false negatives).
>>
>>
>> We want to avoid detecting "no other references" if there *are* other
>> references. Detecting "there are other references" although there are not is
>> usually better.
>>
>>
>> Assume you have mapcount > refcount for some time due to concurrent unmapping,
>> AND some unrelated reference. You would suddenly pass these checks (mapcount ==
>> refcount) and might not detect other references.
> 
> OK. I'll rework with the 2 loop approach, assuming I can calculate the number of
> free slots in the mmu_gather ahead of time.

Note that I think some of these checks might be racy in corner cases 
(and we should most probably make them more reliable by enforcing the 
memory order -- especially a single atomic total_mapcount might help).

But for now, at least the idea that seems to work is that

a) When you map the page, you first increment the refcount, then the 
mapcount

b) When you unmap a page, you first decrement the mapcount, then the 
refcount

So refcount >= mapcount should in theory always hold when taking a 
snapshot of both values. Although if the actual sides that check for 
these additional references might deserve some fine-tuning.

-- 
Cheers,

David / dhildenb

