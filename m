Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03090777318
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjHJIh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHJIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DBC2103
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691656629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wOvD7jYN9ChNQ8zLFm4c8kgaf8S6DImHpzgpTUCLH0=;
        b=bcSNo95hg1n35SDC/0yLlSLLMHbxRpdLqxTVZJMq3KmLJoGozRGR7L+fbwb8QkwXa0auCI
        zJ07mXpNxXK+NHeG+wZ3u0xHRq+WPkHJr3Eqf6MKyrY91V3L5sl7Nhea8lpR3U0vkbvy9t
        IRcW95zmRjQPrGIJwtpMmBtMsABvUME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-vnFDxb76OqSl8s9f1LC4Yg-1; Thu, 10 Aug 2023 04:37:07 -0400
X-MC-Unique: vnFDxb76OqSl8s9f1LC4Yg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe45e71db3so4611695e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656626; x=1692261426;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wOvD7jYN9ChNQ8zLFm4c8kgaf8S6DImHpzgpTUCLH0=;
        b=hYPv3uLghqV7iG74bbxBwCk/QqU6R40lEMe9maFeLOfkZHaNB8VXx62KzmzL3tR+GQ
         Wwu/3p3RFXv8yTwWBOP/VXF+AaEfO5QaebdfcJfhind2wD4cNfMiB3foGQVhuy4itwtt
         +nVdqbouBcYUOi+yf80VZJKVNt0v1uh1yGEPXb40V7I3UTtSVG3SonTm0lz0C2tlmKHN
         UGA5bUu5ans67PZQvlD/1m4UyqXK4OUA5kcUtxe7+FFSdyd90nwozJOm7wOukHiIzu9a
         /QvLxKhmorlfmCunhrfbeP9NmLIkpWuIZ1i8yEP5G5GqNi5a3tnLmTKMtKXg/ptO/hSP
         9cmg==
X-Gm-Message-State: AOJu0Yxl/2S7cJUxwOCi2l7XfyNp1a/i2e/R8NWoESTFXRPAXvK+ggT8
        43EoS34poC/QFkUmz3wnVqNc6/hRjUven8Czvm+PgGiNbtwpfaW0vqSqZpxer3Uqwlr+Skj3ud1
        iJKh9mt2ubf895oCf15R40sXk
X-Received: by 2002:a05:600c:22c8:b0:3fb:a0fc:1ba1 with SMTP id 8-20020a05600c22c800b003fba0fc1ba1mr1391289wmg.35.1691656626684;
        Thu, 10 Aug 2023 01:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOirMlgSgvNCvjwAHcORn56HjxbIL6isaqI433RP3sVUOSu7WwdXepmvm07QTec9yD2UFMlg==
X-Received: by 2002:a05:600c:22c8:b0:3fb:a0fc:1ba1 with SMTP id 8-20020a05600c22c800b003fba0fc1ba1mr1391267wmg.35.1691656626296;
        Thu, 10 Aug 2023 01:37:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id b13-20020adfe30d000000b003113ed02080sm1367445wrj.95.2023.08.10.01.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 01:37:05 -0700 (PDT)
Message-ID: <7e31254d-8889-7e79-50e1-2630bd493d59@redhat.com>
Date:   Thu, 10 Aug 2023 10:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com> <ZNQD4pxo8svpGmvX@x1n>
 <ZNRYx8GhYftE4Xeb@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
In-Reply-To: <ZNRYx8GhYftE4Xeb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.23 05:25, Matthew Wilcox wrote:
> On Wed, Aug 09, 2023 at 05:23:46PM -0400, Peter Xu wrote:
>> Hi, David,
>>
>> Some pure questions below..
>>
>> On Wed, Aug 09, 2023 at 10:32:56AM +0200, David Hildenbrand wrote:
>>> Let's track the total mapcount for all large folios in the first subpage.
>>>
>>> The total mapcount is what we actually want to know in folio_mapcount()
>>> and it is also sufficient for implementing folio_mapped(). This also
>>> gets rid of any "raceiness" concerns as expressed in
>>> folio_total_mapcount().
>>
>> Any more information for that "raciness" described here?
> 
> UTSL.
> 
>          /*
>           * Add all the PTE mappings of those pages mapped by PTE.
>           * Limit the loop to folio_nr_pages_mapped()?
>           * Perhaps: given all the raciness, that may be a good or a bad idea.
>           */
> 

Yes, that comment from Hugh primarily discusses how we could possibly 
optimize the loop, and if relying on folio_nr_pages_mapped() to reduce 
the iterations would be racy. As far as I can see, there are cases where 
"it would be certainly a bad idea" :)


In the other comment in that function, it's also made clear what the 
traditional behavior with PMD-mappable THP was "In the common case, 
avoid the loop when no pages mapped by PTE", which will no longer hold 
with sub-PMD THP.

-- 
Cheers,

David / dhildenb

