Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833067B5123
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjJBL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJBL0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270D8BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696245917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOneOzTrSmpqtG0qhnCChNvIYEoW+1fDAEnSmXjPvzQ=;
        b=Cvn9G8fnYsPDf4Mko80mJmMx5g/W0lPSovuCnr0RjPd9vkMSytu7c2bxKRA9BqITNg42GG
        k31yXPHCFLtYTqn5kOpuDEPVCGUL6t0kad7BiRBdmTKLoyA2d2YcWIsiIBtkQb4crK/s/C
        9yn+WebLekHUZchKkzMarLbfgmmMY68=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-c0umF5xDNF2op-KTGMnfUQ-1; Mon, 02 Oct 2023 07:25:13 -0400
X-MC-Unique: c0umF5xDNF2op-KTGMnfUQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4054743df06so126867725e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696245912; x=1696850712;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOneOzTrSmpqtG0qhnCChNvIYEoW+1fDAEnSmXjPvzQ=;
        b=Yrm4BhIvC3YVUzG/a2FACqmwyhDfvfo1pvKFIMhyHzrBy/moc86c5x1SJxSzvwPSEE
         sWpViJyLWaUTkiOcvK/EGyE0JrkvE5SieAyQzHJbt6acMhuohmKVUssL6ppJgcznnkj5
         XAcj2a5TvcajmNLS53TNJbeqIgX1VnBzJYZbPcDtd5rm0SKABX/ADGyS7Q983JXmrvKo
         Z3Ip5ZlgUEWrvKkmGHj0iwz53LrLOlRfwkidWStH5MXDTL+M+/0EkCHvtQWEp/fb+i24
         K8N2C0aWkpRff3SOVjC80+OtfdUmCo1q35kLOIfudM4oWzJs1pNiVkb5dsyWotI9BatV
         IKxw==
X-Gm-Message-State: AOJu0Ywqcun5Z+RDqCmM0+duuWSFkNlrPqD81BNJvl2BdJxQsst1fW5M
        BWo/P1sHYlg+WuPzGShaS9BG7RhUY4cC2ol6dDENH33ePFlUVYH+WowyNL08HXbLGa7FKG0XueP
        pyGul3NwuJl43tdovvZ5QRGm5
X-Received: by 2002:a1c:7204:0:b0:405:2e28:4878 with SMTP id n4-20020a1c7204000000b004052e284878mr9305396wmc.30.1696245912662;
        Mon, 02 Oct 2023 04:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1f4UOW5e13WimBj1kblk64FdiBVm0BzOHx3wepByhk2+qhVS2Z3xsWgx8Ay1nWRlG8oCfxg==
X-Received: by 2002:a1c:7204:0:b0:405:2e28:4878 with SMTP id n4-20020a1c7204000000b004052e284878mr9305375wmc.30.1696245912165;
        Mon, 02 Oct 2023 04:25:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003feae747ff2sm7016568wmj.35.2023.10.02.04.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:25:11 -0700 (PDT)
Message-ID: <3057dab3-19f2-99ca-f125-e91a094975ed@redhat.com>
Date:   Mon, 2 Oct 2023 13:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region when
 MEMINIT_EARLY
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <a6a20ff9-385c-639f-75cf-ce73a01d97cf@linux.dev>
 <20230929100252.GW3303@kernel.org>
 <15233624-f32e-172e-b2f6-7ca7bffbc96d@linux.dev>
 <20231001185934.GX3303@kernel.org>
 <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
 <20231002084708.GZ3303@kernel.org>
 <f7e6f67a-4cac-73bd-1d5e-5020c6c8423d@redhat.com>
 <20231002111051.GA3303@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231002111051.GA3303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.23 13:10, Mike Rapoport wrote:
> On Mon, Oct 02, 2023 at 10:56:51AM +0200, David Hildenbrand wrote:
>> On 02.10.23 10:47, Mike Rapoport wrote:
>>> On Mon, Oct 02, 2023 at 03:03:56PM +0800, Yajun Deng wrote:
>>>>
>>>> On 2023/10/2 02:59, Mike Rapoport wrote:
>>>>> On Fri, Sep 29, 2023 at 06:27:25PM +0800, Yajun Deng wrote:
>>>>>> On 2023/9/29 18:02, Mike Rapoport wrote:
>>>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>>>> index 06be8821d833..b868caabe8dc 100644
>>>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>>>> @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page *page, unsigned int order)
>>>>>>>>>>       	unsigned int loop;
>>>>>>>>>>       	/*
>>>>>>>>>> -	 * When initializing the memmap, __init_single_page() sets the refcount
>>>>>>>>>> -	 * of all pages to 1 ("allocated"/"not free"). We have to set the
>>>>>>>>>> -	 * refcount of all involved pages to 0.
>>>>>>>>>> +	 * When initializing the memmap, memmap_init_range sets the refcount
>>>>>>>>>> +	 * of all pages to 1 ("reserved" and "free") in hotplug context. We
>>>>>>>>>> +	 * have to set the refcount of all involved pages to 0. Otherwise,
>>>>>>>>>> +	 * we don't do it, as reserve_bootmem_region only set the refcount on
>>>>>>>>>> +	 * reserve region ("reserved") in early context.
>>>>>>>>>>       	 */
>>>>>>>>> Again, why hotplug and early init should be different?
>>>>>>>> I will add a comment that describes it will save boot time.
>>>>>>> But why do we need initialize struct pages differently at boot time vs
>>>>>>> memory hotplug?
>>>>>>> Is there a reason memory hotplug cannot have page count set to 0 just like
>>>>>>> for pages reserved at boot time?
>>>>>> This patch just save boot time in MEMINIT_EARLY. If someone finds out that
>>>>>> it can save time in
>>>>>>
>>>>>> MEMINIT_HOTPLUG, I think it can be done in another patch later. I just
>>>>>> keeping it in the same.
>>>>> But it's not the same. It becomes slower after your patch and the code that
>>>>> frees the pages for MEMINIT_EARLY and MEMINIT_HOTPLUG becomes non-uniform
>>>>> for no apparent reason.
>>>>
>>>> __free_pages_core will also be called by others, such as:
>>>> deferred_free_range, do_collection and memblock_free_late.
>>>>
>>>> We couldn't remove  'if (page_count(page))' even if we set page count to 0
>>>> when MEMINIT_HOTPLUG.
>>>
>>> That 'if' breaks the invariant that __free_pages_core is always called for
>>> pages with initialized page count. Adding it may lead to subtle bugs and
>>> random memory corruption so we don't want to add it at the first place.
>>
>> As long as we have to special-case memory hotplug, we know that we are
>> always coming via generic_online_page() in that case. We could either move
>> some logic over there, or let __free_pages_core() know what it should do.
> 
> Looks like the patch rather special cases MEMINIT_EARLY, although I didn't
> check throughfully other code paths.
> Anyway, relying on page_count() to be correct in different ways for
> different callers of __free_pages_core() does not sound right to me.

Absolutely agreed.

-- 
Cheers,

David / dhildenb

