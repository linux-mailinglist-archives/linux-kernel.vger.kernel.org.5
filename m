Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7607EF1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbjKQLZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbjKQLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:25:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A0127
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700220348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=9lcKgjDQLjkE+b1CC8zuiXRZSEeeBykzBttls1a5T5Y=;
        b=d50kC8FO568lMI5nGIRcmsEc4p0PoU1Z5auWnpXYnA4+zpHPhmsx8Fsy+3uU75/g0rP2WA
        JM3B7gRlzAscXyynkxKK8as/ePe4yRMpG+sIvFrkvPdDpqvFjS8a9pkyM80EC64rnt/xKn
        FMRCWjYz1F9wSa+93JqwlDMwigtSh90=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Q_FsbpAsNCGcFJa9lO4bfw-1; Fri, 17 Nov 2023 06:25:47 -0500
X-MC-Unique: Q_FsbpAsNCGcFJa9lO4bfw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-509c61cfa8dso1892115e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220345; x=1700825145;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lcKgjDQLjkE+b1CC8zuiXRZSEeeBykzBttls1a5T5Y=;
        b=UPP6gNXeGjjixSGPseo0UoLDbRjV2duGio1EZwwueMf9dYDeyVI3bUg71n5+4UAWUh
         l8FYyKmqOCjpOQurJkS/nyTHDjWzzAIR/UhghyFnkqQDr9yG/KgToyPhC7516KL8E0E+
         vkGSPEKbUQCNEOtFyTTDAjOwDBKrVIHN95qaktBU9dLSQvV4Xnb6E9iBGdMRiBESyjB0
         cHsElhcp11BfsYh3BC3QlG+bduDuFcO9/dfqp/RYhqPgnhLre9hkJD4PnojZ8tL2SJSN
         s7RP03/S1DlOHoSShvC+GIZM7JH6WPaalJqDEKG+HNbKNG9fmEiPyYheNdLyQZ7X118G
         UC9A==
X-Gm-Message-State: AOJu0YwMxXLfiyWObXrPFDWYGjvBJlHgUmWHuL0hDoT0wU6gcMXlzG8s
        Sh50rnn6fb+wzJU2+gXUyC/4pF19AfSQkhFSxUEbZ95LoKoRSn4TSGDbgJ3s8b1t7u46vJFVzMz
        DVawvjWr5/RVI/ePSk8GkPQnL
X-Received: by 2002:ac2:5a47:0:b0:500:b5db:990b with SMTP id r7-20020ac25a47000000b00500b5db990bmr3666228lfn.47.1700220345586;
        Fri, 17 Nov 2023 03:25:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtIvDtciZGJ2i6BctqW9oFNIYBzBAgRsmTIuuPIXAas1K/td9MhxYbt5GIrVm52wIv9vP19Q==
X-Received: by 2002:ac2:5a47:0:b0:500:b5db:990b with SMTP id r7-20020ac25a47000000b00500b5db990bmr3666206lfn.47.1700220345150;
        Fri, 17 Nov 2023 03:25:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:4400:d83c:42bd:326a:8b05? (p200300cbc7214400d83c42bd326a8b05.dip0.t-ipconnect.de. [2003:cb:c721:4400:d83c:42bd:326a:8b05])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000180500b003316a32cb25sm1576247wrh.86.2023.11.17.03.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 03:25:44 -0800 (PST)
Message-ID: <8831b4c9-4d14-4fac-84e6-66629aa32388@redhat.com>
Date:   Fri, 17 Nov 2023 12:25:43 +0100
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
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
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

On 17.11.23 00:47, Barry Song wrote:
> On Thu, Nov 16, 2023 at 5:36 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 15.11.23 21:49, Barry Song wrote:
>>> On Wed, Nov 15, 2023 at 11:16 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 14.11.23 02:43, Barry Song wrote:
>>>>> This patch makes MTE tags saving and restoring support large folios,
>>>>> then we don't need to split them into base pages for swapping out
>>>>> on ARM64 SoCs with MTE.
>>>>>
>>>>> arch_prepare_to_swap() should take folio rather than page as parameter
>>>>> because we support THP swap-out as a whole.
>>>>>
>>>>> Meanwhile, arch_swap_restore() should use page parameter rather than
>>>>> folio as swap-in always works at the granularity of base pages right
>>>>> now.
>>>>
>>>> ... but then we always have order-0 folios and can pass a folio, or what
>>>> am I missing?
>>>
>>> Hi David,
>>> you missed the discussion here:
>>>
>>> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com/
>>> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com/
>>
>> Okay, so you want to handle the refault-from-swapcache case where you get a
>> large folio.
>>
>> I was mislead by your "folio as swap-in always works at the granularity of
>> base pages right now" comment.
>>
>> What you actually wanted to say is "While we always swap in small folios, we
>> might refault large folios from the swapcache, and we only want to restore
>> the tags for the page of the large folio we are faulting on."
>>
>> But, I do if we can't simply restore the tags for the whole thing at once
>> at make the interface page-free?
>>
>> Let me elaborate:
>>
>> IIRC, if we have a large folio in the swapcache, the swap entries/offset are
>> contiguous. If you know you are faulting on page[1] of the folio with a
>> given swap offset, you can calculate the swap offset for page[0] simply by
>> subtracting from the offset.
>>
>> See page_swap_entry() on how we perform this calculation.
>>
>>
>> So you can simply pass the large folio and the swap entry corresponding
>> to the first page of the large folio, and restore all tags at once.
>>
>> So the interface would be
>>
>> arch_prepare_to_swap(struct folio *folio);
>> void arch_swap_restore(struct page *folio, swp_entry_t start_entry);
>>
>> I'm sorry if that was also already discussed.
> 
> This has been discussed. Steven, Ryan and I all don't think this is a good
> option. in case we have a large folio with 16 basepages, as do_swap_page
> can only map one base page for each page fault, that means we have
> to restore 16(tags we restore in each page fault) * 16(the times of page faults)
> for this large folio.

Can't you remember that it's already been restored? That seems like a 
reasonable thing to have.

For large folios we have plenty of page flags in tail pages available?

-- 
Cheers,

David / dhildenb

