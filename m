Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE9478D845
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjH3SaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343635AbjH3QZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D53F4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693412664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sgQnGhEZJ0yoOE5a8Oq+mztnWmGg/SOlXBzDljzJzy4=;
        b=W9vh7henX3e2bF2R7p4T/XSEDpsVeN+K+hOv1qvx7cICDP8KF2IzCK339rl1ZUM/XNkPOH
        E4iNFNW+vFHZLwtxYqa+UnzxkuIvY9sHrGofpMuIZJWtDplx3cshpCylKx5PPz5TG6QzSv
        8GnKAFD3FpOOx5F1w3Q3iUJlM2UJm6s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-nFFnzjDtO5m-mDlASdmHYg-1; Wed, 30 Aug 2023 12:24:22 -0400
X-MC-Unique: nFFnzjDtO5m-mDlASdmHYg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30932d15a30so3858306f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693412661; x=1694017461;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgQnGhEZJ0yoOE5a8Oq+mztnWmGg/SOlXBzDljzJzy4=;
        b=NyvmzHbGcwndzv3VvYuzKrddfE4wqXSCAuEeKLJYFoqnxa+xwmHnb9esC8VX1cfhh/
         zxayOa7bzHbkSxOCbyK8BEKRorce9rztduAcbz80pHYxxheXTUOn9+/GWv8qZVW6G86N
         toKN4vzLHXgQP8x+Z4RizTwlmLY3DqBKO9Q+H4vI6LZzq9bASmgvnjZ375EFPXsNXrfE
         OqlCx1iU7Dk0wnEkhpxup57Km/qIiVwbFiAzeKohqrFYH4uAmAbWmG0aZBg9jcWm/yd9
         tfHFLjTMVwjAQ+pPCobpLedyhMILroGYdBgtkoh9zfWd8gZxhyXmsT28Rz5CBmFJxcsO
         MSaA==
X-Gm-Message-State: AOJu0YzA2M7Gg7UKYuWqfQlNpaYopgVun2wsoJmHF9Mnwafsy9mdm70a
        Jux18y+JfJ9kxxeP1EiJ4dpkxRpFFXeDm3oY1opFK1rfTHjGcjxnZOxFinItnT2m0tk+951IVms
        Eji8OZLY/c6OsYVTKQWlxC2+B
X-Received: by 2002:adf:f4c3:0:b0:31d:d3db:4566 with SMTP id h3-20020adff4c3000000b0031dd3db4566mr1974307wrp.4.1693412661407;
        Wed, 30 Aug 2023 09:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/wXxa1hj4nkT4+KwE8RvCJfSVM6DqTxAvYR7jNalLGSk9aAL20Ta1x9gNDbBRH6bd4tZDBw==
X-Received: by 2002:adf:f4c3:0:b0:31d:d3db:4566 with SMTP id h3-20020adff4c3000000b0031dd3db4566mr1974281wrp.4.1693412661006;
        Wed, 30 Aug 2023 09:24:21 -0700 (PDT)
Received: from [10.59.19.200] (pd956a06e.dip0.t-ipconnect.de. [217.86.160.110])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b003140f47224csm17003722wrt.15.2023.08.30.09.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 09:24:20 -0700 (PDT)
Message-ID: <06110ce1-4638-2438-c17e-8f1dc3173522@redhat.com>
Date:   Wed, 30 Aug 2023 18:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/5] mm: Implement folio_remove_rmap_range()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
 <20230830095011.1228673-2-ryan.roberts@arm.com>
 <ZO9XgttGXnx5dxFZ@casper.infradead.org>
 <1696b47d-fcaa-4d60-b9b2-3f2178127dcb@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1696b47d-fcaa-4d60-b9b2-3f2178127dcb@arm.com>
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

On 30.08.23 17:42, Ryan Roberts wrote:
> On 30/08/2023 15:51, Matthew Wilcox wrote:
>> On Wed, Aug 30, 2023 at 10:50:07AM +0100, Ryan Roberts wrote:
>>> Like page_remove_rmap() but batch-removes the rmap for a range of pages
>>> belonging to a folio. This can provide a small speedup due to less
>>> manipuation of the various counters. But more crucially, if removing the
>>> rmap for all pages of a folio in a batch, there is no need to
>>> (spuriously) add it to the deferred split list, which saves significant
>>> cost when there is contention for the split queue lock.
>>>
>>> All contained pages are accounted using the order-0 folio (or base page)
>>> scheme.
>>>
>>> page_remove_rmap() is refactored so that it forwards to
>>> folio_remove_rmap_range() for !compound cases, and both functions now
>>> share a common epilogue function. The intention here is to avoid
>>> duplication of code.
>>
>> What would you think to doing it like this instead?  This probably doesn't
>> even compile and it's definitely not sanity checked; just trying to get
>> across an idea of the shape of this code.  I think this is more like
>> what DavidH was asking for (but he's on holiday this week so won't be
>> able to confirm).
> 
> I think it was actually Yu Zhou who was arguing for something more like this?

I think so, not me.

... but the second variant is certainly shorter.

-- 
Cheers,

David / dhildenb

