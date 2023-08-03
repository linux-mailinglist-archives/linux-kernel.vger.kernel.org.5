Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BE676EB50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjHCN6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbjHCN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029C1FCB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691071038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8q6Z7pqkoedTXIWap9LkOruYe/sbO2nQstX3LZJ7yU=;
        b=au+4M4jJD2bqfXEcuAjuJw0AwuwO39kVM5nWhZxMUBG7aVrEsjDbDpIRLZBi5gMNbmmHR/
        iZDU6xVBR7RPXRespNzFHDtle9MBja+WnhwA9iCTEkDz6IVCuVYJAdcZ7fbfc1smGpUlaN
        4tRCnOnk3AOX47GxKztipoCw7p0RhzA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-UABGJMCWMcOVscHzsbPwBA-1; Thu, 03 Aug 2023 09:57:17 -0400
X-MC-Unique: UABGJMCWMcOVscHzsbPwBA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe2f10381cso980028e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071036; x=1691675836;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8q6Z7pqkoedTXIWap9LkOruYe/sbO2nQstX3LZJ7yU=;
        b=kRPBGy95d5jv1gju97t+kfY5e8+uSk1w+hFbyWynKWqNagG2Dcm/xgUVRU+N0CWweK
         Y3R67faq8eZLhmSM36dmBrVVHIeCxKAWKLzVohNtlfwkyaZNf26MiQ56Y4fHRiX0v9jX
         S8WmXg2FT2iLflywxqcf8DwdL5M5Gyifxs1PsJqqSjLaK22GwjIqm6IErfC5P2JKcEwD
         CO4Omi5hVB/viRp5C3oAA3VHFeqs2z4yoUnbsg7ZKSZ5RPmhwvy4ed733WpERZknSmll
         lCR6pcl3FNnT68wtZ8Q+58T8ueqQ9NbyC6Q1sAvsfNiTTYwkZCJKg39iwYoIePW5KSa9
         qm2A==
X-Gm-Message-State: ABy/qLbOd7jOTQWx+Kcym8BES9OKK3tieO45TaPEl21lIiw8SmuR/aiW
        D9jnff9IfXN/fRMb/wwR/fU02gIQ4UaCCjaMwZcFR8/ye3SxCv/uzMRHO7jNOLG+sYrZZeBrmMH
        MDc8FE1V5TPgDOH7bFMLS3EMb
X-Received: by 2002:a05:6512:538:b0:4fb:73d1:58e5 with SMTP id o24-20020a056512053800b004fb73d158e5mr6026050lfc.53.1691071035961;
        Thu, 03 Aug 2023 06:57:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH/adeNKqLJO3yJHoENqb6qn8CC14RihTNj12oBa59rhbZwveOAERtZXKtmV659jUXZGZWRyQ==
X-Received: by 2002:a05:6512:538:b0:4fb:73d1:58e5 with SMTP id o24-20020a056512053800b004fb73d158e5mr6026026lfc.53.1691071035531;
        Thu, 03 Aug 2023 06:57:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004fe333128c0sm1913291lfc.242.2023.08.03.06.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:57:14 -0700 (PDT)
Message-ID: <3d0ebaf0-894c-8238-c18b-92d624dc39a6@redhat.com>
Date:   Thu, 3 Aug 2023 15:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com>
 <CAOUHufYiEwYw0sFGK0kP0FFRfV51=hVJ==e5R_hXZXQo-OEcwQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAOUHufYiEwYw0sFGK0kP0FFRfV51=hVJ==e5R_hXZXQo-OEcwQ@mail.gmail.com>
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

On 27.07.23 19:22, Yu Zhao wrote:
> On Thu, Jul 27, 2023 at 8:18 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> This allows batching the rmap removal with folio_remove_rmap_range(),
>> which means we avoid spuriously adding a partially unmapped folio to the
>> deferred split queue in the common case, which reduces split queue lock
>> contention.
>>
>> Previously each page was removed from the rmap individually with
>> page_remove_rmap(). If the first page belonged to a large folio, this
>> would cause page_remove_rmap() to conclude that the folio was now
>> partially mapped and add the folio to the deferred split queue. But
>> subsequent calls would cause the folio to become fully unmapped, meaning
>> there is no value to adding it to the split queue.
>>
>> A complicating factor is that for platforms where MMU_GATHER_NO_GATHER
>> is enabled (e.g. s390), __tlb_remove_page() drops a reference to the
>> page. This means that the folio reference count could drop to zero while
>> still in use (i.e. before folio_remove_rmap_range() is called). This
>> does not happen on other platforms because the actual page freeing is
>> deferred.
>>
>> Solve this by appropriately getting/putting the folio to guarrantee it
>> does not get freed early. Given the need to get/put the folio in the
>> batch path, we stick to the non-batched path if the folio is not large.
>> While the batched path is functionally correct for a folio with 1 page,
>> it is unlikely to be as efficient as the existing non-batched path in
>> this case.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> This ad hoc patch looks unacceptable to me: we can't afford to keep
> adding special cases.
> 
> I vote for completely converting zap_pte_range() to use
> folio_remove_rmap_range(), and that includes tlb_flush_rmap_batch()
> and other types of large folios, not just anon. Otherwise I'll leave
> it to Matthew and David.

The !anon case with tlb_delay_rmap() really hurts my brain (again).

We're already special-casing on !anon ... so splitting anon and !anon 
also doesn't sound completely off to me.

But yes, we should find ways to just avoid any special casing here, or 
at least minimize them.

(The bigger problem I have with this patch, as raised in my replies, is 
that it messes up the order in which we adjust mapcount+refcount, and I 
am *really* not a friend of that :) )

-- 
Cheers,

David / dhildenb

