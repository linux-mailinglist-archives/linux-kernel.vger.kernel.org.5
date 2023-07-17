Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ACF75683A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjGQPod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjGQPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12573A1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689608625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTfaOQJnDoIo46jfQT0QTGsg6WC2cCAaqYgqomxj/I8=;
        b=ipSL6Ah0H/LUwoprgGJv5oQj7SLX9Xn+uziDA47PZFdwwWTGClEX0t18Z52x0EcduG4Ezi
        7ZvEC0zmYBNFahwWLnqQBt2LR6hvZLfurXDN4rkm+xn/JdZkUJn46JpjlswyIoPSLgyG+6
        80SPmZf2u3qEaxxzbwzRJuM8lk7FfdY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-68S6PmkpMOS8srGIuImoUA-1; Mon, 17 Jul 2023 11:43:44 -0400
X-MC-Unique: 68S6PmkpMOS8srGIuImoUA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-314394a798dso1919217f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689608623; x=1692200623;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTfaOQJnDoIo46jfQT0QTGsg6WC2cCAaqYgqomxj/I8=;
        b=iU7/ohQAPWZ1geo+HxRDUi7JkAcRyiLek7U6tNOaLnk6AKsFjyFfplFN2OKmzu6K4O
         Nc4oKwHxoda1TSipaYntEdxyXhBz/KLmazWZEapkBF3KJGRLU5FfcjrUQyBM3+vkOviD
         0UOlPtLPTESwPEjtCijc8Gu0ObQYsdhR8/u2tz4b+BZj9sv4/dJKKn5T1QNIjAq8XQgw
         UV7Ae+j9md9fGj+nVLGVz4LJaDvFec2WW/DPBA0P1WyiuPnNcw7IyIKbv/o8uzaXTMBW
         fxpZxPP8WCnmZq9FE3IuCzJ4Gm0is0j2wrqUwAHgd7Lv2MTUWqZ1/pFxh6dz42T269pN
         5LLA==
X-Gm-Message-State: ABy/qLb0qXhfOLvVCaCQ8B4e9MfkjIeuNCaPMcymwRVGcHoD6GIYyZ7T
        p/GeuP6tMe5VAJuJSZ1HJo2rVALMamgXZE5iAD+NDxzwpRUani4nSu3yQcurhlThXlvrHWbL2++
        AoR21cIUuyVNFarzpf3wyk9NxdYmSX3fd
X-Received: by 2002:adf:fac6:0:b0:314:9dc:4c4 with SMTP id a6-20020adffac6000000b0031409dc04c4mr8391929wrs.2.1689608622829;
        Mon, 17 Jul 2023 08:43:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFn7xWZG6zHHkr919W29E/ngGyIe9MVhHMeGxe27ydQRjoWZqWe+1yvNtr+FqnkpJ41AWzmnA==
X-Received: by 2002:adf:fac6:0:b0:314:9dc:4c4 with SMTP id a6-20020adffac6000000b0031409dc04c4mr8391915wrs.2.1689608622491;
        Mon, 17 Jul 2023 08:43:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b0031272fced4dsm19657379wrw.52.2023.07.17.08.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 08:43:41 -0700 (PDT)
Message-ID: <c10ae780-c405-b2d2-ecc0-78ef35a892f3@redhat.com>
Date:   Mon, 17 Jul 2023 17:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
 <ZLVeeDmPDWupYzSH@casper.infradead.org>
 <283e4122-c23f-35a1-4782-fddde32f4ad4@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <283e4122-c23f-35a1-4782-fddde32f4ad4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 17.07.23 17:41, Ryan Roberts wrote:
> On 17/07/2023 16:30, Matthew Wilcox wrote:
>> On Mon, Jul 17, 2023 at 03:31:08PM +0100, Ryan Roberts wrote:
>>> In preparation for the introduction of large folios for anonymous
>>> memory, we would like to be able to split them when they have unmapped
>>> subpages, in order to free those unused pages under memory pressure. So
>>> remove the artificial requirement that the large folio needed to be at
>>> least PMD-sized.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>
>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Thanks!
> 
>>
>>>   		 */
>>> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>>> +		if (folio_test_large(folio) && folio_test_anon(folio))
>>>   			if (!compound || nr < nr_pmdmapped)
>>>   				deferred_split_folio(folio);
>>
>> I wonder if it's worth introducing a folio_test_deferred_split() (better
>> naming appreciated ...) to allow us to allocate order-1 folios and not
>> do horrible things.  Maybe it's not worth supporting order-1 folios;
>> we're always better off going to order-2 immediately.  Just thinking.
> 
> There is more than just _deferred_list in the 3rd page; you also have _flags_2a
> and _head_2a. I guess you know much better than me what they store. But I'm
> guessing its harder than jsut not splitting an order-1 page?
> 
> With the direction of large anon folios (_not_ retrying with every order down to
> 0), I'm not sure what the use case would be for order-1 anyway?

Just noting that we might need some struct-page space for better 
mapcount/shared tracking, which might get hard for order-1 pages.

-- 
Cheers,

David / dhildenb

