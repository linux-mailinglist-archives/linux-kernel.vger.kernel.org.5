Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C876CB41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjHBKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHBKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19691B4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690973334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLjbWxxoSZ1dNtOUnCKt0nz7AAWcmftqn6oRUggLh9c=;
        b=W9Tz5G4tpnGg0b5SGj3thfCuYe8+/BzU3KhPFMD8cikiLF6RYOh7uxd8xVNa4tS0aci6iv
        8ICO6NYUPXyGtKA+XTIasr6FBWVbYENYfpwjN1pxx/zzrKKdS/C8k4IThxrb9C6V9vt1iw
        gv4keGJr7uMuasPC+p9EJimxZ9kbI3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-xVi9g6opMyCVTMOqbsVSWQ-1; Wed, 02 Aug 2023 06:48:53 -0400
X-MC-Unique: xVi9g6opMyCVTMOqbsVSWQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fb416d7731so39166285e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 03:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690973332; x=1691578132;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLjbWxxoSZ1dNtOUnCKt0nz7AAWcmftqn6oRUggLh9c=;
        b=AGzuFCbFenerDlJywg5Z9wdDTli0BDLtoIfSjV8N/90Qv4kjixjS+GAsCR3xTmg+uS
         Hzk5VGNEgQ8o1tyuZexC8jM8W6goRVMTGIN86ifEZQRZg5euGhthZTrEE6r5im6B0REr
         eF1ZfGxtNbZQM1Tn38Bm8U4oqBBbybIN2NwBU5aZ2lQm7Cy6KvNvaIhcMGPBp5WDl3rj
         3H3pTeuGBv+kTnFF25bTEg2uj+m6o75/vBsLvhqfTI55MhFO3iHeuCHAzXxNufi8oW+U
         eq7NZEV16T6X04lG9BSwjDC3lfM56iR2gxKVseCJixfT2DwbC611vhJ+wScUlCLW41b7
         vE6g==
X-Gm-Message-State: ABy/qLZx2pZdHhcu9Im3O37htGSvR+tX4eMPQJoY+uGgL2qTtWwXORWG
        0CvDP32qxkErtS8Xo6AwJAvITVnWw8+TzS2paBRk8zuBapAxx1jW7gls5qii3rluGHaRo2gg+mb
        Q6ah2VoX8b+YQL3gkWqC8Ipwx
X-Received: by 2002:a05:600c:2213:b0:3fe:2813:6130 with SMTP id z19-20020a05600c221300b003fe28136130mr4455624wml.22.1690973332523;
        Wed, 02 Aug 2023 03:48:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHUEiRrf/4EeUw8aRl0LVFnwaPqfid2665Qb/NZxHkW6b9q3/fmfr2HRSeP6OOAES8r28MCsg==
X-Received: by 2002:a05:600c:2213:b0:3fe:2813:6130 with SMTP id z19-20020a05600c221300b003fe28136130mr4455615wml.22.1690973332125;
        Wed, 02 Aug 2023 03:48:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc011000000b003fe210d8e84sm1373978wmb.5.2023.08.02.03.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 03:48:51 -0700 (PDT)
Message-ID: <31093c49-5baa-caed-9871-9503cb89454b@redhat.com>
Date:   Wed, 2 Aug 2023 12:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, yuzhao@google.com, shy828301@gmail.com,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
In-Reply-To: <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
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

On 02.08.23 12:27, Ryan Roberts wrote:
> On 28/07/2023 17:13, Yin Fengwei wrote:
>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>> folio_mapcount() is used to check whether the folio is shared. But it's
>> not correct as folio_mapcount() returns total mapcount of large folio.
>>
>> Use folio_estimated_sharers() here as the estimated number is enough.
>>
>> Yin Fengwei (2):
>>    madvise: don't use mapcount() against large folio for sharing check
>>    madvise: don't use mapcount() against large folio for sharing check
>>
>>   mm/huge_memory.c | 2 +-
>>   mm/madvise.c     | 6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
> 
> As a set of fixes, I agree this is definitely an improvement, so:
> 
> Reviewed-By: Ryan Roberts
> 
> 
> But I have a couple of comments around further improvements;
> 
> Once we have the scheme that David is working on to be able to provide precise
> exclusive vs shared info, we will probably want to move to that. Although that
> scheme will need access to the mm_struct of a process known to be mapping the

There are probably ways to work around lack of mm_struct, but it would 
not be completely for free. But passing the mm_struct should probably be 
an easy refactoring.

> folio. We have that info, but its not passed to folio_estimated_sharers() so we
> can't just reimplement folio_estimated_sharers() - we will need to rework these
> call sites again.

We should probably just have a

folio_maybe_mapped_shared()

with proper documentation. Nobody should care about the exact number.


If my scheme for anon pages makes it in, that would be precise for anon 
pages and we could document that. Once we can handle pagecache pages as 
well to get a precise answer, we could change to folio_mapped_shared() 
and adjust the documentation.


I just saw

https://lkml.kernel.org/r/20230802095346.87449-1-wangkefeng.wang@huawei.com

that converts a lot of code to folio_estimated_sharers().


That patchset, for example, also does

total_mapcount(page) > 1 -> folio_estimated_sharers(folio) > 1

I'm not 100% sure what to think about that at this point. We eventually 
add false negatives (actually shared but we fail to detect it) all over 
the place, instead of having false positives (actually exclusive, but we 
fail to detect it).

And that patch set doesn't even spell that out.


Maybe it's as good as we will get, especially if my scheme doesn't make 
it in. But we should definitely spell that out.

-- 
Cheers,

David / dhildenb

