Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1256753CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjGNON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjGNONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21212E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689343962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrLKOdVXb9Fv/CAMsQrfuXshfrR4te+3T5qXw1Gj1IE=;
        b=LUxO2NPMY2xUyy30y/aiX/zeI+ErTMoT172rIxV5NNeOVh9oQjuRYI/9GuK8oSV3BA2cFF
        VVIRlYsUAmcD90nAu0LIuTfWSK9dCt95Izk7yBm8CDGq9FGVSAWSjH5h3N3CZiBKD4GWcr
        YcOYlMXEbfuUCswxzzYcNI9yveNKgBQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-u1uGp_fAMqGn_BTm_8YoNQ-1; Fri, 14 Jul 2023 10:12:41 -0400
X-MC-Unique: u1uGp_fAMqGn_BTm_8YoNQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so11370505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343960; x=1691935960;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrLKOdVXb9Fv/CAMsQrfuXshfrR4te+3T5qXw1Gj1IE=;
        b=i5J4FNC8dBd17QIE8cGIVtFuwtXEA7LY2ADaVu2x2vwIIna6MAlyBrsjMJcCj30nIc
         IX+aeHRw7MTbcyeC4OpKA9YKX+JLM12hmlRj2nf83JxAba5DUNRYKP0x1cRbHw4+/csk
         UR5rSfJYATgRZDimFiI77alWgUGNnP/JXJws9PpkHnxaN3qWK5AYkSHvG6zB8wVd5V0b
         //ZJieStnCP149UpvReNbNz4MDnXSfK4FbWDHrqB1j8TPGXQUVWzR0sgDkQXPNjpQvgp
         y8GdxO79gH5sRSryGhaX7g8uWjMAti9szxO4/VDXSwxf4+xeQqZrLIVkaGA/uaA93Hnp
         ZdMQ==
X-Gm-Message-State: ABy/qLY93a/Qk0edi+bLA/gl+M5/eY4/Fd18CZsNLIHZQxbtM6kAQR+u
        tKuG0Z7LucMgXqe7Ji5GecdiFph9MBduWe6G+wwfx2NHbvtKJRfGy4bxx6sjDJEOyk7cAXL8iFe
        o1gXpi0oANpok1Rlgb0NAaqpV
X-Received: by 2002:a05:600c:2353:b0:3fc:8a:7c14 with SMTP id 19-20020a05600c235300b003fc008a7c14mr4978103wmq.18.1689343960398;
        Fri, 14 Jul 2023 07:12:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHtmmiOx8q2VOGhJpOeQ3H0bJZAr2CZdVX4yXHW0FI1RF1vgnAlnczvdivP0L6fJcDjc4jN3g==
X-Received: by 2002:a05:600c:2353:b0:3fc:8a:7c14 with SMTP id 19-20020a05600c235300b003fc008a7c14mr4978081wmq.18.1689343960003;
        Fri, 14 Jul 2023 07:12:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb? (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de. [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
        by smtp.gmail.com with ESMTPSA id e14-20020a05600c218e00b003fbbe41fd78sm1557672wme.10.2023.07.14.07.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:12:39 -0700 (PDT)
Message-ID: <237fd94f-0062-124c-6317-76fc4207ccd7@redhat.com>
Date:   Fri, 14 Jul 2023 16:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Zi Yan <ziy@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, ryan.roberts@arm.com, shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
 <2cbf457e-389e-cd45-1262-879513a4cf41@intel.com>
 <36cfe140-5685-bea7-d267-4a61f21aeb79@redhat.com>
 <9bcc8014-f5ef-9021-3ffc-032e39c32249@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
In-Reply-To: <9bcc8014-f5ef-9021-3ffc-032e39c32249@intel.com>
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

On 14.07.23 15:58, Yin, Fengwei wrote:
> 
> 
> On 7/14/2023 5:25 PM, David Hildenbrand wrote:
>>
>> (1) We're unmapping a single subpage, the compound_mapcount == 0
>>      and the total_mapcount > 0. If the subpage mapcount is now 0, add it
>>      to the deferred split queue.
>>
>> (2) We're unmapping a complete folio (PMD mapping / compound), the
>>      compound_mapcount is 0 and the total_mapcount > 0.
>>
>>   (a) If total mapcount < folio_nr_pages, add it
>>       to the deferred split queue.
>>
>>   (b) If total mapcount >= folio_nr_pages , we have to scan all subpage
>>       mapcounts. If any subpage mapcount == 0, add it to the deferred
>>       split queue.
>>
>>
>> (b) is a bit nasty. It would happen when we fork() with a PMD-mapped THP, the parent splits the THP due to COW, and then our child unmaps or splits the PMD-mapped THP (unmap easily happening during exec()). Fortunately, we'd only scan once when unmapping the PMD.
>>
>>
>> Getting rid of the subpage mapcount usage in (1) would mean that we have to do exactly what we do in (2). But then we'd need to ha handle (2) (B) differently as well.
>>
>> So, for 2 (b) we would either need some other heuristic, or we add it to the deferred split queue more frequently and let that one detect using an rmap walk "well, every subpage is still mapped, let's abort the split".
> 
> Or another option for 2 (b): don't add it to deferred split queue. We
> know the folio in deferred list is mainly scanned when system needs to
> reclaim memory.
> 
> Maybe it's better to let page reclaim choose the large folio here because
> page reclaiming will call folio_referenced() which does rmap_walk()->pvmw().
> And we can reuse rmap_walk() in folio_referenced() to detect whether there
> are pages of folio are not mapped. If it's the case, we can split it then.
> 
> Comparing to deferred list, the advantage is that folio_referenced() doesn't
> unmap page. While in deferred list, we need to add extra rmap_walk() to
> check whether there is page not mapped.

Right, I also came to the conclusion that the unmapping is undesirable. 
However, once benefit of the unmap is that we know when to stop scanning 
(due to page_mapped()). But maybe the temporary unmapping is actually 
counter-productive.

> 
> Just a thought. I could miss something here. Thanks.

Interesting idea.

I also had the thought that adding folios to the deferred split queue 
when removing the rmap is semantically questionable.

Yes, we remove the rmap when zapping/unmapping a pte/pmd. But we also 
(eventually only temporarily!) unmap when splitting a THP or when 
installing migration entries.

Maybe we can flag folios when zapping PTEs that they are a reasonable 
candidate to tell page reclaim code "this one was partially zapped, 
maybe there is some memory to reclaim there, now". Maybe that involves 
the deferred split queue.

-- 
Cheers,

David / dhildenb

