Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DAA7C7EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJMHrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJMHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896B6CF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697183218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TphMvB1CPmRLPW6U1J+q+vD0ldjgA4gT+OdpEDDv6mM=;
        b=Mevh+tKaNtxzgzzkFVl5sLHY3C4YN01dKRdlqIPmlbDr5+3GE+gCpWTZhz53EsxGKJCTDi
        ESVI9y04nQaLpCoAUNOnafJ3CicJcurB/NZQazCO9Sb8JD5T+wewB5bYyr6Vx80ZRhkG42
        rd7XqCSyucbbDI9EMu8Idt6AqdVGj/4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-g8gKyVW_PkGbe5JpQfuRVA-1; Fri, 13 Oct 2023 03:46:46 -0400
X-MC-Unique: g8gKyVW_PkGbe5JpQfuRVA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32d9602824dso680013f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183205; x=1697788005;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TphMvB1CPmRLPW6U1J+q+vD0ldjgA4gT+OdpEDDv6mM=;
        b=NjdUGsqeD8LEO441qS87nT39Z2v8huoPbzLSfyaKjaKEETN25SuM/dykmQ1+4LVpCY
         BxKdYi4Nab+JumD1HM5CZyPOG6lN9cCl5PBnSBA+wOg7zlEMPpFVKATK2ZkF6GvjmZ7Q
         QWZJpO05XbrX6096cWny4w96d46nhvBUrktqh/d49gXGDFCHY0959Y2QTOcMAb4YLa+S
         tMHh8++cOv2wiyGuaI+gAdov+Wt/+2wCFEJdYhOP4WJBTIwq5NWqMDqaitQj7MyDpQuV
         yVmXWMKvsDFcFRwz9UUo8o/2RwyGpyef0tpDxX60ayoDIdo0Rf4rJ1FUcA/J0YtKRGXo
         NUHQ==
X-Gm-Message-State: AOJu0YzKS/vtiCRZfaBU5KFI9xgF6hb3xxDkVC51SzjkUfJ1PupSovgg
        ignqwCM74mZWWtGpFOSip7bHFq2lITBO6MP2IzUTF9nhA4ETmeBylEqQTKIypssZU2ivAGD8HDF
        pp/OLbz6IzobsUgAQw5eHSU1F
X-Received: by 2002:a05:6000:1246:b0:317:6513:da7e with SMTP id j6-20020a056000124600b003176513da7emr21308678wrx.36.1697183205655;
        Fri, 13 Oct 2023 00:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSSrs6m9cH6/GO/dAxAJtE+wFDvIs0eYPELm+NBLR10v6qYJ4xX620jSepqwwuna9L3vW1Uw==
X-Received: by 2002:a05:6000:1246:b0:317:6513:da7e with SMTP id j6-20020a056000124600b003176513da7emr21308657wrx.36.1697183205174;
        Fri, 13 Oct 2023 00:46:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9300:1381:43e2:7c78:b68f? (p200300cbc7189300138143e27c78b68f.dip0.t-ipconnect.de. [2003:cb:c718:9300:1381:43e2:7c78:b68f])
        by smtp.gmail.com with ESMTPSA id m12-20020a056000024c00b0032d88e370basm6036223wrz.34.2023.10.13.00.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 00:46:44 -0700 (PDT)
Message-ID: <82c16241-6c9f-88b7-5644-3a397f842e9e@redhat.com>
Date:   Fri, 13 Oct 2023 09:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 0/5] mm, kpageflags: support folio and fix output for
 compound pages
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
 <63d119f7-5adb-861a-00c2-69a92b19ef9b@redhat.com>
 <20231012150226.GA473412@u2004>
 <86170ebf-cbe3-1cda-dcb4-87e18695f9cd@redhat.com>
 <20231013005457.GA712115@ik1-406-35019.vs.sakura.ne.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231013005457.GA712115@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.23 02:54, Naoya Horiguchi wrote:
> On Thu, Oct 12, 2023 at 05:30:34PM +0200, David Hildenbrand wrote:
>> On 12.10.23 17:02, Naoya Horiguchi wrote:
>>> On Thu, Oct 12, 2023 at 10:33:04AM +0200, David Hildenbrand wrote:
>>>> On 10.10.23 16:27, Naoya Horiguchi wrote:
>>>>> Hi everyone,
>>>>>
>>>>> This patchset addresses 2 issues in /proc/kpageflags.
>>>>>
>>>>>      1. We can't easily tell folio from thp, because currently both pages are
>>>>>         judged as thp, and
>>>>>      2. we see some garbage data in records of compound tail pages because
>>>>>         we use tail pages to store some internal data.
>>>>>
>>>>> These issues require userspace programs to do additional work to understand
>>>>> the page status, which makes situation more complicated.
>>>>>
>>>>> This patchset tries to solve these by defining KPF_FOLIO for issue 1., and
>>>>> by hiding part of page flag info on tail pages of compound pages for issue 2.
>>>>>
>>>>> I think that technically some compound pages like thp/hugetlb/slab could be
>>>>> considered as folio, but in this version KPF_FOLIO is set only on folios
>>>>
>>>> At least thp+hugetlb are most certainly folios. Regarding slab, I suspect we
>>>> no longer call them folios (cannot be mapped to user space). But Im not sure
>>>> about the type hierarchy.
>>>
>>> I'm not sure about the exact definition of "folio", and I think it's better
>>> to make KPF_FOLIO set based on the definition.
>>
>> Me neither. But in any case a THP *is* a folio. So you'd have to set that
>> flag in any case.
> 
> OK.
> 
>>
>> And any order-0 page (i.e., anon, pagecache) is also a folio. What you seem
>> to imply with folio is "large folio". So KPF_FOLIO is really wrong as far as
>> I can tell.
> 
> Ah, I meant "large folio" for the new flag, so it might have been better to
> name it KPF_LARGE_FOLIO.
> 
>>
>>> "being mapped to userspace" can be one possible criteria for the definition.
>>> But reading source code, folio_slab() and slab_folio() convert between
>>> struct slab and struct folio, so I feel that someone might think a slab is
>>> a kind of folio.
>>
>> I keep forgetting if "folio" is just the generic term for any order-0 or
>> compound page, or only for some of them. I usually live in the "anon" world,
>> so I don't get reminded that often :)
> 
> I didn't notice that an order-0 page is also a folio.
> 
>>
>>
>>>>> in pagecache (so "folios in narrower meaning").  I'm not confident about
>>>>> this choice, so if you have any idea about this, please let me know.
>>>>
>>>> It does sound inconsistent. What exactly do you want to tell user space with
>>>> the new flag?
>>>
>>> The current most problematic behavior is to report folio as thp (order-2
>>> pagecache page is definitely a folio but not a thp), and this is what the
>>> new flag is intended to tell.
>>
>> We are currently considering calling these sub-PMD sized THPs "small-sized
>> THP". [1] Arguably, we're starting with the anon part where we won't get
>> around exposing them to the user in sysfs.
>>
>> So I wouldn't immediately say that these things are not THPs. They are not
>> PMD-sized THP. A slab/hugetlb is certainly not a thp but a folio. Whereby
>> slabs can also be order-0 folios, but hugetlb can't.
>>
>>
>> Looking at other interfaces, we do expose:
>>
>> include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_HEAD        15
>> include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_TAIL        16
>>
>> So maybe we should just continue talking about compound pages or do we have
>> to use both terms here in this interface?
> 
> Extending the concept of thp to arbitrary size of thp sounds good to me.
> If patchset [1] will be merged, then setting KPF_THP on large folios is totally
> fine and one of my problem in this patchset will be automatically resolved.

CCing Ryan.

> So I'm thinking of not adding new flag and just focusing on garbage data issue.

That sounds minimal and reasonable! Flags/values that logically belong 
to the head (although are stored in the tail) should probably be exposed 
along with the head. Flags that apply to the actual tail pages should 
stay with the tail pages.

> 
> Thank you very much for sharing ideas.

Thank you!

-- 
Cheers,

David / dhildenb

