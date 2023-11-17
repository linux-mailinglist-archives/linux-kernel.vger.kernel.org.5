Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A567EF1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjKQL2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQL2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B6EA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700220491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=CUXZ21s3tmdjDEStIWavtexWFfbCwQHlYn8virxNDas=;
        b=RB0XbHeo9io0+IFL6QDbKsKRwwRt8W6hobEimA/CX/vhQ1LkD2+mfQOr2Gk6z43O21vTSK
        Xyd1pKBce+m7VBlwI4uNAV1D4OT0UySzJVAhRlGOvnP4Q3GAVAWFVFmaOf5KXRl7KuCEnv
        roFTy9HGfWsQxLPBNjzpXCZapjWiTdc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-TLcfMqR-OPqVIjmlTVU4sA-1; Fri, 17 Nov 2023 06:28:10 -0500
X-MC-Unique: TLcfMqR-OPqVIjmlTVU4sA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c50255b905so18194491fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220489; x=1700825289;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUXZ21s3tmdjDEStIWavtexWFfbCwQHlYn8virxNDas=;
        b=q7Yq3MG2/cxTwbzkRmsjsiXdxCrIuZkUJZiRuiG0VfvxOzuyl6AS+WqNMj7vurwGph
         XF/YnvSuKxxxbZBPZ26AkWbpZEZ2cduyXc9P6PkGtshn0tsSIghmJpa34nnA6cdUk93r
         Y402nqBuPTaAcgOArfkjvsTZbGsqPDvYaZdxu/KGxuahcoxUkzlbWxGLfuUDX+Idko9k
         sPH3g+XM5A4B5hAnpjPLnpof5/qwLfLe22A8rTE+moflF6HavYbtpctk1hPN1MVtHPi9
         ijCcO+UwMbiIfUeKaLNxIQlyI4XdvPQFomyVCYwnY/3nzQ1QOKwDASyxaPqPFLh3m5lD
         VoKg==
X-Gm-Message-State: AOJu0YztG5iP3KictntjLR00WErKi1hT3PnqSSbGvzlkzCOkZjosfaG6
        CNhz7g4eEJnTdaXGZW1uL3bblw8XU3Oj3jp1Nkm9FoY0b3gLXvBYIVFL4RilsIfIIs0n9KqI9+j
        4GyXXdBD80NgPdHsVqJ7jyCRL
X-Received: by 2002:a05:6512:3994:b0:506:899d:1989 with SMTP id j20-20020a056512399400b00506899d1989mr17221042lfu.44.1700220488927;
        Fri, 17 Nov 2023 03:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdspe8ScX3J96Io+86n374o1JyEktGP3PEyK9CTZe5bL0Vqf9syzkobuY382VfrTeuhsxhrQ==
X-Received: by 2002:a05:6512:3994:b0:506:899d:1989 with SMTP id j20-20020a056512399400b00506899d1989mr17221027lfu.44.1700220488475;
        Fri, 17 Nov 2023 03:28:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:4400:d83c:42bd:326a:8b05? (p200300cbc7214400d83c42bd326a8b05.dip0.t-ipconnect.de. [2003:cb:c721:4400:d83c:42bd:326a:8b05])
        by smtp.gmail.com with ESMTPSA id y18-20020adfee12000000b003200c918c81sm2008508wrn.112.2023.11.17.03.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 03:28:08 -0800 (PST)
Message-ID: <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com>
Date:   Fri, 17 Nov 2023 12:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     steven.price@arm.com, akpm@linux-foundation.org,
        ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
References: <20231114014313.67232-1-v-songbaohua@oppo.com>
 <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com>
 <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.23 01:15, Barry Song wrote:
> On Fri, Nov 17, 2023 at 7:47 AM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Thu, Nov 16, 2023 at 5:36 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 15.11.23 21:49, Barry Song wrote:
>>>> On Wed, Nov 15, 2023 at 11:16 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 14.11.23 02:43, Barry Song wrote:
>>>>>> This patch makes MTE tags saving and restoring support large folios,
>>>>>> then we don't need to split them into base pages for swapping out
>>>>>> on ARM64 SoCs with MTE.
>>>>>>
>>>>>> arch_prepare_to_swap() should take folio rather than page as parameter
>>>>>> because we support THP swap-out as a whole.
>>>>>>
>>>>>> Meanwhile, arch_swap_restore() should use page parameter rather than
>>>>>> folio as swap-in always works at the granularity of base pages right
>>>>>> now.
>>>>>
>>>>> ... but then we always have order-0 folios and can pass a folio, or what
>>>>> am I missing?
>>>>
>>>> Hi David,
>>>> you missed the discussion here:
>>>>
>>>> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com/
>>>> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com/
>>>
>>> Okay, so you want to handle the refault-from-swapcache case where you get a
>>> large folio.
>>>
>>> I was mislead by your "folio as swap-in always works at the granularity of
>>> base pages right now" comment.
>>>
>>> What you actually wanted to say is "While we always swap in small folios, we
>>> might refault large folios from the swapcache, and we only want to restore
>>> the tags for the page of the large folio we are faulting on."
>>>
>>> But, I do if we can't simply restore the tags for the whole thing at once
>>> at make the interface page-free?
>>>
>>> Let me elaborate:
>>>
>>> IIRC, if we have a large folio in the swapcache, the swap entries/offset are
>>> contiguous. If you know you are faulting on page[1] of the folio with a
>>> given swap offset, you can calculate the swap offset for page[0] simply by
>>> subtracting from the offset.
>>>
>>> See page_swap_entry() on how we perform this calculation.
>>>
>>>
>>> So you can simply pass the large folio and the swap entry corresponding
>>> to the first page of the large folio, and restore all tags at once.
>>>
>>> So the interface would be
>>>
>>> arch_prepare_to_swap(struct folio *folio);
>>> void arch_swap_restore(struct page *folio, swp_entry_t start_entry);
>>>
>>> I'm sorry if that was also already discussed.
>>
>> This has been discussed. Steven, Ryan and I all don't think this is a good
>> option. in case we have a large folio with 16 basepages, as do_swap_page
>> can only map one base page for each page fault, that means we have
>> to restore 16(tags we restore in each page fault) * 16(the times of page faults)
>> for this large folio.
>>
>> and still the worst thing is the page fault in the Nth PTE of large folio
>> might free swap entry as that swap has been in.
>> do_swap_page()
>> {
>>     /*
>>      * Remove the swap entry and conditionally try to free up the swapcache.
>>      * We're already holding a reference on the page but haven't mapped it
>>      * yet.
>>      */
>>      swap_free(entry);
>> }
>>
>> So in the page faults other than N, I mean 0~N-1 and N+1 to 15, you might access
>> a freed tag.
> 
> And David, one more information is that to keep the parameter of
> arch_swap_restore() unchanged as folio,
> i actually tried an ugly approach in rfc v2:
> 
> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> +{
> + if (system_supports_mte()) {
> +      /*
> +       * We don't support large folios swap in as whole yet, but
> +       * we can hit a large folio which is still in swapcache
> +       * after those related processes' PTEs have been unmapped
> +       * but before the swapcache folio  is dropped, in this case,
> +       * we need to find the exact page which "entry" is mapping
> +       * to. If we are not hitting swapcache, this folio won't be
> +       * large
> +     */
> + struct page *page = folio_file_page(folio, swp_offset(entry));
> + mte_restore_tags(entry, page);
> + }
> +}
> 
> And obviously everybody in the discussion hated it :-)
> 

I can relate :D

> i feel the only way to keep API unchanged using folio is that we
> support restoring PTEs
> all together for the whole large folio and we support the swap-in of
> large folios. This is
> in my list to do, I will send a patchset based on Ryan's large anon
> folios series after a
> while. till that is really done, it seems using page rather than folio
> is a better choice.

I think just restoring all tags and remembering for a large folio that 
they have been restored might be the low hanging fruit. But as always, 
devil is in the detail :)

-- 
Cheers,

David / dhildenb

